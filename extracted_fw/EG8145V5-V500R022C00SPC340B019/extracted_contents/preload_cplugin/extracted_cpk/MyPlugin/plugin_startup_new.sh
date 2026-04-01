#!/bin/sh
# Copyright Huawei Technologies Co., Ltd. 2020-2020. All rights reserved.

#deviceFlag为0表示ONT,为1表示DSL
device_flag=0

plugin_type="C"

function updatefileright()
{
	#fifo文件属主如果是root,需要增加other的w权限
	local fifo_info=$(ls -l /var/collect_data_fifo|grep root)
	if [ ! -z "$fifo_info" ];then
		chmod o+w /var/collect_data_fifo
	fi
	
	#/tmp/proto目录属主如果是root,需要增加other的w权限
	local proto_info=$(ls -l /tmp|grep proto|grep root)
	if [ ! -z "$proto_info" ];then
		chmod o+w /tmp/proto
	fi
	
	# /dev/urandom 如果other没有r权限,插件启动会卡住
	local urandom_info=$(ls -l /dev/urandom |grep "\-\-\-")
	if [ ! -z "$urandom_info" ];then
		chmod o+r /dev/urandom
	fi
	
	# 新版本脚本可能是非root, 需要把400权限的文件改成600权限,避免无法修改
	local ro_files=$(find . -type f -exec ls -l \{} \; |grep "r-\-\-\-\-\-\-\-"|awk '{print $NF}')
	for each_file in $ro_files; do
		chmod 600 $each_file
	done
	
	# 尝试修改ping_group_range文件
	local osgi_gid=$(cat /etc/group|grep "osgi:x"|awk -F':' '{print $3}')
	if grep -E "^1[^0-9]0$" /proc/sys/net/ipv4/ping_group_range; then
		echo "0 ${osgi_gid}" > /proc/sys/net/ipv4/ping_group_range
	fi
}

function prestart()
{
    if [ -e /var/dslFlagForPlugin ]; then 
        device_flag=1
    fi
    echo "device_flag=${device_flag}"
    if [ "$device_flag" == "0" ]; then
      chown -Rh osgi_proxy:osgi ../
    fi

    #创建升级用的临时目录
    if [ ! -d  /var/Cplugin_upgrade ]; then
      mkdir /var/Cplugin_upgrade
      mount none /var/Cplugin_upgrade -t tmpfs -o size=10m,mode=700
    fi

    chown -Rh osgi_proxy:osgi /var/Cplugin_upgrade
    chmod 750 /var/Cplugin_upgrade

    umask 0027
    if [ "$plugin_type" == "C" ]; then
      updatefileright
    fi
}

function recordoldlog()
{
    echo "[$(date)]================kernelapp reboot==============" > /var/kernelapp_reboot.log
    echo "kernelapp_log.0:" >> /var/kernelapp_reboot.log
    tail -n 500 /var/kernelapp_log.0 >> /var/kernelapp_reboot.log
    
    echo "kernelapp_lsw.0:" >> /var/kernelapp_reboot.log
    cat /var/kernelapp_lsw.0 >> /var/kernelapp_reboot.log
    
    echo "kernelapp_event.log:" >> /var/kernelapp_reboot.log
    cat /var/kernelapp_event.log >> /var/kernelapp_reboot.log
    
    echo "kernelapp_boot.0:" >> /var/kernelapp_reboot.log
    cat /var/kernelapp_boot.0 >> /var/kernelapp_reboot.log
    
    echo "kernelapp_capierrlog:" >> /var/kernelapp_reboot.log
    cat /var/kernelapp_capierrlog >> /var/kernelapp_reboot.log
    
    chmod 640 /var/kernelapp_reboot.log
    if [ ! -e /var/dslFlagForPlugin ]; then 
        chown osgi_proxy:osgi /var/kernelapp_reboot.log
    fi
}

function iscbusenv()
{
	local flash_size=$(dbus-send --system --type=method_call --print-reply --dest=com.ctc.igd1 /com/ctc/igd1/Info/Device com.ctc.igd1.Properties.Get string:com.ctc.igd1.DeviceInfo string:FlashSize|tail -n 1|awk '{print $NF}')
	local product_type=$(dbus-send --system --type=method_call --print-reply --dest=com.ctc.igd1 /com/ctc/igd1/Info/Device com.ctc.igd1.Properties.Get string:com.ctc.igd1.DeviceInfo string:ProductClass|tail -n 1|awk '{print $NF}') 
	if [ -z "${flash_size}" ];then
		flash_size=268435456 # 默认为256M
	fi

	if [ ${flash_size} -le 134217728 ] && [ "${product_type}" == "\"HS8145C5\"" -o "${product_type}" == "\"HS8145V5\"" -o "${product_type}" == "\"HN8145V\"" ];then
		echo "This is cbus evn, flash:${flash_size}, product:${product_type}, not support upgrade"
		return 0
	fi
	
	return 1
}

function startkernelapp()
{
    recordoldlog
    if iscbusenv; then
        return
    fi

    local curdir=$(pwd)
    chmod 700 $(pwd)/bin
    chmod 500 $(pwd)/bin/*
    chmod 700 $(pwd)/etc/config
    cd bin/
    
    FREEMEM=$(cat /proc/meminfo | grep MemFree | cut -d: -f2 |cut -dk -f1)
    AVAILABLEMEM=$(cat /proc/meminfo | grep MemAvailable | cut -d: -f2 |cut -dk -f1)
    if [ "${FREEMEM}" -gt "5120" ] || [ "${AVAILABLEMEM}" -gt "5120" ]; then
        echo "begin to start kernelapp..."
        if [ "$device_flag" == "0" ]; then
            echo "ONT mod"
            local who=$(whoami)
            if [ "${who}" == "root" ]; then
                su -s /bin/sh osgi_proxy -c "./kernelapp" &
            else 
                ./kernelapp &
            fi
            
            sleep 1
            kill -9 $(ps | grep "sh -c ./kernelapp" | grep  -v grep | awk '{print $1}')
        elif [ "$device_flag" == "1" ]; then
            echo "DSL mod"
            ./kernelapp &
        fi
    else
        echo "memory is not enough, freeMem:${FREEMEM}, availableMem:${AVAILABLEMEM}"
    fi
    
    cd $curdir
}

function rollbackfiles()
{
    echo "rollback files!"
    touch ../Data/upgrade_failed
    if [ -e ../back_dir/kernelapp.tar ]; then
        tar -zxf ../back_dir/kernelapp.tar -C /
        rm -f ../back_dir/kernelapp.tar
    fi
}

function updatefiles()
{   
    rm -rf ./Lib/*;mv -f ../MyPlugin1/*.sh ./;cp -rf ../MyPlugin1/* ../MyPlugin
    touch ../MyPlugin1/upgrade_done
    chown -Rh osgi_proxy:osgi ../MyPlugin
}

function startup()
{   
    rm -f ../Data/startup_failed
    export MQTT_C_CLIENT_TRACE=/var/kernelapp_mqtt_connect.log
    export MQTT_C_CLIENT_TRACE_LEVEL=PROTOCOL
    export MQTT_C_CLIENT_TRACE_MAX_LINES=6000
    local try=0
    while [ "$try" -lt "3" ] ; do 
        echo "startapp $try."
        startkernelapp
        try=$(($try+1))
        sleep 8
        
        NUM=$(ps | grep kernelapp | grep -v grep |wc -l)
        if [ "${NUM}" -gt "0" ]; then
            echo "startup success"
            return
        fi
    done
    
    touch ../Data/startup_failed
}

function dostart()
{
    prestart
    startup
    exit
}

function dorollback()
{
    rollbackfiles
    exit
}

function doupdate()
{
    updatefiles
    exit
}

if pidof kernelapp; then
    exit
fi

# 升级已完成文件覆盖
if [ -f ../MyPlugin1/upgrade_done ]; then
    rm -rf ../MyPlugin1
    dostart
fi

# 升级未开始文件覆盖
if [ -e ../MyPlugin1 ]; then
    doupdate
fi

# 升级失败需要回滚
if [ -f ../Data/startup_failed ]; then
    rm ../Data/startup_failed
    dorollback
fi

# 异常退出的场景
dostart

