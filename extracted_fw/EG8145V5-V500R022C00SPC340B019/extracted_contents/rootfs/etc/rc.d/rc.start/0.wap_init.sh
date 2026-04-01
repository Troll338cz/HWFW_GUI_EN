#!/bin/sh

#时间整改，平台修改系统启动时间
echo "enter 0.wap_init.sh................"
echo -n "IAS WAP Ver:"
cat /etc/wap/wap_version
echo -n "IAS WAP Timestamp:"
cat /etc/wap/wap_timestamp

# 修复用户态非对齐的指令问题
echo 2 > /proc/cpu/alignment

# mount jffs2文件系统，需要移到产品侧，但Log是写在flash中的，存在依赖
#echo "Mount the JFFS2 file system: "
var_index=$(cat /proc/mtd | grep jffs2cfg) 
if [ "$var_index" != "" ]; then
	var_index=$(echo $var_index | cut -d ":" -f 1 | cut -c 4-)
	mount -t jffs2 /dev/mtdblock$var_index /mnt/jffs2
fi

# 读取小型化配置
cut_ver=$(cat /etc/wap/hw.wap.ssp.config | grep HW_WAP_CUT_VERSION | cut -d" " -f2)

# 加载平台封装的GPL函数
insmod /lib/modules/linux/kernel/crypto/jitterentropy_rng.ko

# 低概率出现jitterentropy_rng加载失败
if [ $? != 0 ] ; then
	dmesg -c
	echo "insmod failed"
fi

insmod /lib/modules/linux/securec/ksecurec.ko
insmod /lib/modules/wap/hw_ssp_gpl.ko

# 加载平台基础KO
insmod /lib/modules/wap/hw_module_random.ko
insmod /lib/modules/wap/hw_ssp_basic.ko

# 如果不是小型化，就启动打印记录和msgread进程
if [ "$cut_ver" != "1" ] ; then
	dlwIndex=0;
	while true;
		do sleep 10;
		if [ -f /var/cleanmemflag ]; then
			rm /var/init_dlw*
			break;
		fi
		dlwIndex=$(($dlwIndex+1))
		dlw > /var/init_dlw$dlwIndex
		if [ $dlwIndex -ge 12 ]; then
			if [ ! -f /var/init_complete ]; then
				cp /var/init_debug.txt /mnt/jffs2/init_debug.txt
			fi
			rm /var/init_dlw*
			break;
		fi
	done&
	# 启动kmsgreader读取打印信息
	kmsgread &

	# 初始化串口打印跟踪记录，120秒以后关闭记录
	echo !path "/var/init_debug.txt" > /proc/wap_proc/tty;
	echo !start > /proc/wap_proc/tty;
	while true; do sleep 120; echo !stop > /proc/wap_proc/tty; echo !path "/var/console.log" > /proc/wap_proc/tty; sed -i 's/WAP(Dopra Linux) #//g' /var/init_debug.txt; chown srv_ssmp:service /var/init_debug.txt; break; done &
fi

# 动态创建部分用户，避免出现冗余账户，注意有部分单板使用扩展分区extrootfs，此时执行文件为软连接
if [ -e /bin/ethoam ] || [ -h /bin/ethoam ]; then AddSysUser srv_ethoam 3013 2002; fi
if [ -e /bin/hybrid ] || [ -h /bin/hybrid ]; then AddSysUser srv_hybrid 3027 2002; fi
if [ -e /bin/ret_server ] || [ -h /bin/ret_server ] || [ -e /bin/ret_client ] || [ -h /bin/ret_client ]; then AddSysUser srv_ret 3050 2002; fi
if [ -e /bin/pcp_c ] || [ -h /bin/pcp_c ]; then AddSysUser srv_pcpc 3051 2002; fi
if [ -e /bin/dot1x ] || [ -h /bin/dot1x ]; then AddSysUser srv_dot1x 3052 2002; fi
if [ -e /bin/ddnsc ] || [ -h /bin/ddnsc ] || [ -e /bin/phddns ] || [ -h /bin/phddns ]; then AddSysUser srv_ddns 3054 2002; fi
if [ -e /bin/nostb_btv ] || [ -h /bin/nostb_btv ]; then AddSysUser srv_nosbtv 3055 2002; fi
if [ -e /bin/upnpd ] || [ -h /bin/upnpd ]; then AddSysUser srv_upnpd 3056 2002; fi
if [ -e /sbin/ipsec ] || [ -h /sbin/ipsec ]; then AddSysUser srv_ipsec 3057 2002; fi
if [ -e /bin/emdi ] || [ -h /bin/emdi ]; then AddSysUser srv_emdi 3059 2002; fi
if [ -e /bin/mpudp ] || [ -h /bin/mpudp ]; then AddSysUser srv_mpudp 3060 2002; fi
if [ -e /usr/bin/llmnr ] || [ -h /usr/bin/llmnr ]; then AddSysUser srv_llmnr 3061 2002; fi
if [ -e /bin/wifi ] || [ -h /bin/wifi ]; then
    AddSysUser srv_wifi 3024 2002;
    AddSysUser cfg_wifi 3025 2002;
fi

# 指定用户创建iptables锁文件，避免在启动过程中自动创建为root用户文件
if [ -f /sbin/iptables ]; then
    touch /var/xtables.lock
    touch /var/iptable_lock
    chown srv_bbsp:service /var/xtables.lock /var/iptable_lock
fi

# 指定用户创建sec命令日志文件，避免在启动过程自动创建为root用户文件
touch /var/xcmdlog
chown srv_bbsp:service /var/xcmdlog
echo "out 0.wap_init.sh................"
