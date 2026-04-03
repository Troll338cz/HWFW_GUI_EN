#!/bin/sh
#添加lib的环境变量
echo "enter 1.sdk_init.5115.sh................"
[ -n $LD_LIBRARY_PATH ] && export LD_LIBRARY_PATH=/lib:/lib/exlib:/lib/omci_module:/lib/oam_module:/usr/osgi/lib:/usr/osgi/lib/aarch32:/usr/osgi/lib/aarch32/jli:/usr/osgi/lib/aarch32/server;

export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

#时间戳打印开关
echo Y > /sys/module/printk/parameters/time
echo Y > /sys/module/kbox/parameters/time

if [ -f /etc/wap/DebugVersionFlag ]; then
    cat /proc/kallsyms | grep -w kallsyms_lookup_name > /var/kallsyms
fi

#加载故障自愈的ko
if [ -f /lib/modules/wap/hw_ssp_sys_res.ko ];then
    insmod /lib/modules/wap/hw_ssp_sys_res.ko
fi

# 持裁剪jffs2文件系统，完成之后恢复log
ontchmod 1777 /var && ontchmod 1777 /tmp 
mkdir -p /var/run
ontchmod 1777 /var/run # 设置run目录的权限位 rwxrwxrwt 设置sticky位，不允许删除

mkdir /var/mngt
mount -t tmpfs -o nodev,nosuid,noexec,size=10m,mode=770,uid=3008,gid=2002 none /var/mngt

flashtype_v5=`cat /proc/mtd | grep "ubilayer" | wc -l`
echo "flashtype_v5 is $flashtype_v5"
tianyi_cut_128=`cat /proc/mtd | grep "exrootfs" | wc -l`
tianyi_256=`cat /proc/mtd | grep "frameworkA" | wc -l`
echo "tianyi_cut_128 is $tianyi_cut_128"

if [ $flashtype_v5 = 1 ]; then
    #之前的V5有bootpara，后面就干掉了
    flashtype_v5_old=`cat /proc/mtd | grep "bootpara" | wc -l`
    echo "flashtype_v5_old is $flashtype_v5_old"

    if [ $flashtype_v5_old = 1 ]; then
        if [ $tianyi_cut_128 = 1 ]; then
            jffs2_block=/dev/ubi0_5
        else
            jffs2_block=/dev/ubi0_4
        fi
    else
        if [ $tianyi_cut_128 = 1 ]; then
            jffs2_block=/dev/ubi0_12
        else
            if [ $tianyi_256 = 1 ]; then
				jffs2_block=/dev/ubi0_11
			else
				jffs2_block=/dev/ubi0_9
			fi
        fi
    fi
else
    jffs2_block=/dev/ubi0_13
fi

mount -t ubifs -o nodev,nosuid,sync $jffs2_block /mnt/jffs2/
if [ ! -f "/mnt/jffs2/mount_ok" ]; then
	echo "mount_ok" > "/mnt/jffs2/mount_ok"
	umount /mnt/jffs2
	mount -t ubifs -o nodev,nosuid,sync $jffs2_block /mnt/jffs2/
	if [  $? != 0  ] || [ ! -f "/mnt/jffs2/mount_ok" ]; then
		echo "Failed to mount jffs2, reboot system" | ls -l /mnt/jffs2
		reboot
	fi
fi

# 擦除组播升级的临时文件
[[ -f /mnt/jffs2/mu_bin ]] && rm -fr /mnt/jffs2/mu_bin

if [ -f /mnt/jffs2/speedtest.tar.gz ]; then
    rm -fr /mnt/jffs2/speedtest
    cd /mnt/jffs2/ && tar -zxvf speedtest.tar.gz -C /tmp
    mkdir /mnt/jffs2/speedtest && ontchown 3008:2002 /mnt/jffs2/speedtest
    cp -a /tmp/speedtest/*  /mnt/jffs2/speedtest
    rm -f speedtest.tar.gz
    rm -fr /tmp/speedtest
fi

# 删除擦写flash可能因中途断电导致的残留文件
rm -rf /mnt/jffs2/eraseFlag_*

# 临时解决降权限 升降级版本兼容问题
ontchown 0:2002 /mnt/jffs2 && ontchmod 1770 /mnt/jffs2
ontchown 3008:2002 /mnt/jffs2/fsok

ls /mnt/jffs2/hw_ctree* | xargs ontchmod 640
if [ -f /mnt/jffs2/backup_ok ]; then
    ontchown 3008:2002 /mnt/jffs2/backup_ok
fi
if [ -d /mnt/jffs2/app ]; then
    ontchmod 770 /mnt/jffs2/app;ontchown 3005:2002 /mnt/jffs2/app
fi
ls  /mnt/jffs2/hw*.bin | xargs ontchown 3008:2002 && ls /mnt/jffs2/hw*.bin | xargs  ontchmod 640
ontchown 3008:2002 -R /mnt/jffs2/restore && ontchmod 750 -R /mnt/jffs2/restore
[[ -f /mnt/jffs2/ProductLineMode ]] && ontchown 3008:2002 /mnt/jffs2/ProductLineMode
# 解决装备/非装备切换访问问题
[[ -f /mnt/jffs2/roguestatus ]] && ontchown 3003:2002 /mnt/jffs2/roguestatus
[[ -f /mnt/jffs2/eponroguestatus ]] && ontchown 3003:2002 /mnt/jffs2/eponroguestatus
[[ -f /mnt/jffs2/emergencystatus ]] && ontchown 3003:2002 /mnt/jffs2/emergencystatus
[[ -f /mnt/jffs2/mu_status_info ]] && ontchmod 664 /mnt/jffs2/mu_status_info

if [ -f /mnt/jffs2/cplug_down_fireware ]; then
    ontchmod 666 /mnt/jffs2/cplug_down_fireware
fi

if [ -d /mnt/jffs2/apps ]; then
    ontchown 0:2002 /mnt/jffs2/apps
    ontchmod 770 /mnt/jffs2/apps
fi

if [ -d /mnt/jffs2/equipment ]; then
    ontchown 3008:2002 -R /mnt/jffs2/equipment
fi

rm -fr /mnt/ftproot /mnt/usb
if [ ! -d "/mnt/ftproot" ]; then
    mkdir /mnt/ftproot && ontchown 3008:2002 /mnt/ftproot && ontchmod 750 /mnt/ftproot
fi

if [ ! -d "/mnt/usb" ]; then
    mkdir /mnt/usb && ontchown 3008:2002 /mnt/usb && ontchmod 750 /mnt/usb
fi

if [ ! -d "/mnt/pcdn" ]; then
    mkdir /mnt/pcdn && ontchown 3008:2002 /mnt/pcdn && ontchmod 750 /mnt/pcdn
fi

if [ -f /mnt/jffs2/frameworkcheck ]; then
    ontchown 3030:2002 /mnt/jffs2/frameworkcheck
fi

if [ -d /mnt/jffs2/shaopian ]; then
    ontchown 3008:2002 -R /mnt/jffs2/shaopian && ontchmod 770 /mnt/jffs2/shaopian
fi

/* 当前web的证书仅web有权限，ssmp无法平滑到证书管理节点 */
if [ -d /mnt/jffs2/webCert ]; then
    chown -h 3008:2002 -R /mnt/jffs2/webCert
    ontchmod g+r -R /mnt/jffs2/webCert
fi

# 如果jffs2目录下有midinfo.debug这个文件，就读取里面的mid，并打开
if [ -f /mnt/jffs2/midinfo.debug ]; then
while read midinfo; do
    mid set $midinfo 1;
done < /mnt/jffs2/midinfo.debug
rm -f /mnt/jffs2/midinfo.debug
fi

Reloadlog

function chmod_keyfile()
{
    [[ -f /mnt/jffs2/customize.txt ]] && ontchown 3030:2002 /mnt/jffs2/customize.txt && ontchmod 640 /mnt/jffs2/customize.txt
    [[ -f /mnt/jffs2/customizepara.txt ]] && ontchown 3030:2002 /mnt/jffs2/customizepara.txt && ontchmod 640 /mnt/jffs2/customizepara.txt
    [[ -d /mnt/jffs2/customize ]] && ontchown 3030:2002 -R /mnt/jffs2/customize && ontchmod 750 -R /mnt/jffs2/customize && ontchmod 640 /mnt/jffs2/customize/*
    [[ -f /mnt/jffs2/kmc_need_backup ]] && ontchown 3030:2002 /mnt/jffs2/kmc_need_backup && ontchmod 660 /mnt/jffs2/kmc_need_backup
    ls /mnt/jffs2/*ctree* | xargs ontchown 3008:2002
    #证书类目录700 文件600 不可随意更改
    [[ -d /mnt/jffs2/certs ]] && ontchown 3008:2002 -R /mnt/jffs2/certs && ontchmod 700 /mnt/jffs2/certs && ontchmod 600 /mnt/jffs2/certs/*

    #压缩包相关权限修改
    [[ -f /mnt/jffs2/choose_xml.tar.gz ]] && ontchown 3008:2002 /mnt/jffs2/choose_xml.tar.gz && ontchmod 440 /mnt/jffs2/choose_xml.tar.gz
    [[ -f /mnt/jffs2/encrypt_spec_key.tar.gz ]] && ontchown 0:0 /mnt/jffs2/encrypt_spec_key.tar.gz && ontchmod 400 /mnt/jffs2/encrypt_spec_key.tar.gz
    [[ -f /mnt/jffs2/choose_xml.tar.gz ]] && ontchmod 440 /mnt/jffs2/choose_xml.tar.gz
    [[ -f /var/backKey/encrypt_spec_key.tar.gz ]] && ontchmod 440 /var/backKey/encrypt_spec_key.tar.gz
    [[ -f /var/backKey/choose_xml.tar.gz ]] && ontchmod 440 /var/backKey/choose_xml.tar.gz
}

function keyfile_restore_proc()
{
    echo "keyfilemng restore start"

    cat /proc/mtd | grep keyfile > /dev/null
    [ ! $? == 0 ] && return 0

    keyfilemng common
    local dir1=/var/backKey
    local dir2=/var/backKey/choose_xml
    [[ -d $dir1 ]] && ontchown 3008:2002 -R $dir1
    ontchown 3020:500 $dir1/kmc_store* 2>/dev/null
    ontchmod 600 $dir1/kmc_store* 2>/dev/null
    [[ -d $dir2 ]] && ontchmod 770 $dir2 && ontchmod 660 $dir2/*
    keyfilemng restore
    echo "keyfilemng restore return $?"
    chmod_keyfile
}

check_sign=0
function check_equip_sign
{
    echo "check_equip_sign"
    data_path=/mnt/jffs2/Equip.sh
    cms_path=/mnt/jffs2/equipment/sign/cms
    crl_path=/mnt/jffs2/equipment/sign/crl
    pub_path=/etc/app_cert.crt

    if [ ! -f $data_path ]; then
        echo "do not need to check"
        return 0
    fi

    cms_check $pub_path $cms_path $crl_path $data_path

    if [ $? != 0 ]; then
        echo "check equip sign error"
        rm -rf $data_path
        check_sign=1
        return 0
    fi

    cat $data_path | cut -d ',' -f 1 | grep ^EquipId=[0-9]'\{1,\}$' > /dev/null
    if [ $? != 0 ];then
        echo "check equip content error"
        rm -rf $data_path
        check_sign=1
        return 0
    fi

    #equip id用来预留吊销以往出的装备包,以黑名单的模式
    equip_id=`cat $data_path | cut -d ','  -f 1 | cut -d '=' -f 2`
    echo "check equip sign success, equip id = $equip_id"

    return 0
}

check_equip_sign
echo "check_sign ${check_sign}"

# 装备模式只需要modprobe nf_conntrack
if [ ${check_sign} == "0" ] && [ -f /mnt/jffs2/Equip.sh ] && [ -f /usr/bin/equip_single.sh ]; then
    echo 0 > /proc/sys/kernel/printk
    modprobe nf_conntrack
    echo "equip mode not modprobe"
    insmod /lib/modules/wap/hw_module_feature.ko
else
    echo "Loading the kernel modules: "
    cat /etc/modules | sed -e '/^[ \t]*$/d' |
    while read module; do
        echo "Loading module: $module"
        modprobe $module
    done
    insmod /lib/modules/wap/hw_module_feature.ko
    chmod_keyfile
fi
#关键文件校验的初始化及平滑
#执行前权限需要设置ok
backupKey
keyfile_restore_proc
ProcDataWh -i

if [ ! -e /mnt/jffs2/hw_boardinfo ]; then 
    if [ -e /mnt/jffs2/hw_boardinfo.bak ]; then
        cp -a /mnt/jffs2/hw_boardinfo.bak /mnt/jffs2/hw_boardinfo
        ProcDataWh -g -f /mnt/jffs2/hw_boardinfo
    else
        if [  -e /var/backKey/hw_boardinfo ]; then
            cp -a /var/backKey/hw_boardinfo /mnt/jffs2/hw_boardinfo
            ProcDataWh -g -f /mnt/jffs2/hw_boardinfo
            cp -a /var/backKey/hw_boardinfo /mnt/jffs2/hw_boardinfo.bak
            ProcDataWh -g -f /mnt/jffs2/hw_boardinfo.bak
        fi
    fi
fi

#如果flash中boardinfo是加密的则解密到/var目录
if [ -f /bin/decrypt_boardinfo ]; then
	if [ -f /mnt/jffs2/hw_boardinfo ]; then
		decrypt_boardinfo -s /mnt/jffs2/hw_boardinfo -d /var/decrypt_boardinfo
	fi
	if [ -f /mnt/jffs2/hw_boardinfo.bak ]; then
		decrypt_boardinfo -s /mnt/jffs2/hw_boardinfo.bak -d /var/decrypt_boardinfo.bak
	fi
    chown -h srv_ssmp:service /var/decrypt_boardinfo*

	if [ -f /var/decrypt_boardinfo ] && [ ! -f /var/decrypt_boardinfo.bak ]; then
		cp -a /var/decrypt_boardinfo /var/decrypt_boardinfo.bak
	fi

	if [ ! -f /var/decrypt_boardinfo ] && [ -f /var/decrypt_boardinfo.bak ]; then
		cp -a /var/decrypt_boardinfo.bak /var/decrypt_boardinfo
	fi
fi

if [ -f /bin/decrypt_boardinfo ] && [ ! -f /var/decrypt_boardinfo ] && [ ! -f /var/decrypt_boardinfo.bak ] && [ -f /var/backKey/hw_boardinfo ] ; then
    decrypt_boardinfo -s /var/backKey/hw_boardinfo -d /var/decrypt_boardinfo && chown -h srv_ssmp:service /var/decrypt_boardinfo
    if [ -f /var/decrypt_boardinfo ] ; then
        cp -a /var/decrypt_boardinfo /var/decrypt_boardinfo.bak
        cp -a /var/backKey/hw_boardinfo /mnt/jffs2/hw_boardinfo
        ProcDataWh -g -f /mnt/jffs2/hw_boardinfo
        cp -a /var/backKey/hw_boardinfo /mnt/jffs2/hw_boardinfo.bak
        ProcDataWh -g -f /mnt/jffs2/hw_boardinfo.bak
    fi
fi

#如果boardinfo是加密的，只能操作解密后的文件
txt_boardinfo=/mnt/jffs2/hw_boardinfo
txt_boardinfo_bak=/mnt/jffs2/hw_boardinfo.bak

if [ -f /var/decrypt_boardinfo ]; then
	txt_boardinfo=/var/decrypt_boardinfo
fi

if [ -f /var/decrypt_boardinfo.bak ]; then
	txt_boardinfo_bak=/var/decrypt_boardinfo.bak
fi

if [ `grep -c "obj.id = \"0x0000001b\"" $txt_boardinfo` -eq '0' ] && [ `grep -c "obj.id = \"0x0000001b\"" $txt_boardinfo_bak` -eq '1' ]; then
    cp -a $txt_boardinfo_bak $txt_boardinfo
    ProcDataWh -g -f /mnt/jffs2/hw_boardinfo
fi

if [ -f /mnt/jffs2/debug/debug_lib ] && [ -f /etc/wap/DebugVersionFlag ]; then
    echo "export debug lib!"
    export LD_LIBRARY_PATH=/mnt/jffs2/debug:$LD_LIBRARY_PATH
    rm -f /mnt/jffs2/debug/debug_lib
else
    if [ -d /mnt/jffs2/debug/ ]; then
        rm /mnt/jffs2/debug.bak -rf
        mv /mnt/jffs2/debug /mnt/jffs2/debug.bak
    fi
fi

# 读取boardinfo中id对应模式切换的value;其他模块从ap_support_mode _value变量读取该值
ap_support_mode_value=0
if [ -e $txt_boardinfo ]; then
    ap_support_mode_value=`cat $txt_boardinfo | grep "0x00000042" | cut -c38-38`
fi

work_as_ap=0
if [ $ap_support_mode_value -eq 2 ] || [ $ap_support_mode_value -eq 3 ]; then
    work_as_ap=1
    echo "Device works in AP mode "
    touch /var/apmode_nosmart
fi

if [ $ap_support_mode_value -eq 4 ]; then
    ap_support_mode_value=`cat $txt_boardinfo | grep "0x00000058" | cut -c38-38`
    if [ $ap_support_mode_value -eq 2 ] || [ $ap_support_mode_value -eq 3 ]; then
        work_as_ap=1
        echo "Device works in AP mode "
        touch /var/apmode_nosmart
    fi
fi

if [ -f /mnt/jffs2/stop ] && [ -f /etc/wap/DebugVersionFlag ]; then
    exit
fi

[ -f /lib/modules/linux/kernel/net/ipv6/ipv6.ko ] && insmod /lib/modules/linux/kernel/net/ipv6/ipv6.ko
[ -f /lib/modules/linux/kernel/drivers/block/loop.ko ] && insmod /lib/modules/linux/kernel/drivers/block/loop.ko
sysctl -w net.ipv6.ip6frag_low_thresh=196608
sysctl -w net.ipv6.ip6frag_high_thresh=262144
sysctl -w net.ipv6.neigh.default.base_reachable_time=300

export HW_LANMAC_TEMP="/var/hw_lanmac_temp"

HW_BOARD_LANMAC="00:00:5E:00:53:02"

echo -n "Rootfs time stamp:"
cat /etc/timestamp

ontchmod 444 /proc/flashchipid
ontchmod 444 /sys/class/mtd/mtd0/chipid

#避免eth0发RS
[ -f /proc/sys/net/ipv6/conf/default/forwarding ] && echo 1 > /proc/sys/net/ipv6/conf/default/forwarding

# Close/Open(0/8) the printk for debug
echo 8 > /proc/sys/kernel/printk
echo -32 128 > /proc/sys/kernel/dump_around_reg_mem_region

echo !reload > /proc/wap_proc/voice_log
echo !reload > /proc/wap_proc/nff_log

#如果智能apps目录不存在或被删除，就创建一个
if [ ! -d /mnt/jffs2/apps ] && [ $tianyi_cut_128 = 1 ]; then
    mkdir -p /mnt/jffs2/apps
fi

# efuse数据存储在sram，需要在网口初始化之前加载此ko
if [ -f /lib/modules/wap/hw_module_efuse.ko ];then
    insmod /lib/modules/wap/hw_module_efuse.ko
fi

# 装备模式临时调试用
if [ ${check_sign} == "0" ] && [ -f /mnt/jffs2/Equip.sh ] && [ -f /usr/bin/equip_single.sh ]; then
    echo "out 1.sdk_init.5115.sh................"
    /usr/bin/equip_single.sh bin4 && exit
fi

[ ${check_sign} == "0" ] && [ -f /mnt/jffs2/Equip.sh ] && /bin/Equip.sh && exit
[[ -f /mnt/jffs2/equipnoneedmounttsdk ]] && rm -rf /mnt/jffs2/equipnoneedmounttsdk
#非装备独立软件且Equip_MU_UpGRD_Flag存在，则直接删除Equip_MU_UpGRD_Flag
if [ ! -f "/etc/wap/equip_new" ] && [ -f /mnt/jffs2/Equip_MU_UpGRD_Flag ]; then
    rm -f /mnt/jffs2/Equip_MU_UpGRD_Flag
fi

var_xpon_mode=`cat $txt_boardinfo |grep "obj.id = \"0x00000001\"" |cut -d ";" -f 2 | cut -d "\"" -f 2 `
echo "xpon_mode:${var_xpon_mode}"

echo ${var_xpon_mode}>>/var/var_xpon_mode

function mount_sdk()
{
    ubi_dir=/sys/class/ubi
    for file in `ls $ubi_dir`
    do
        if [ -d $ubi_dir"/"$file ]; then
            if [ -f $ubi_dir"/"$file"/name" ]; then
                ubi_name=`cat $ubi_dir"/"$file"/name"`
                echo "ubi name is:$ubi_name"
                if [ $ubi_name == "apps" ] || [ $ubi_name == "app_system" ]; then
                    echo "sub_dir name:$file"
                    mkdir -p /mnt/jffs2/sdk_mnt
                    ontchown -h 3008:2002 /mnt/jffs2/sdk_mnt && ontchmod 770 /mnt/jffs2/sdk_mnt
                    mount -t ubifs -o sync /dev/$file /mnt/jffs2/sdk_mnt
                    break;
                fi
            fi
        fi
    done
 
    # 挂载sdk到/var/目录下
    if [ -d /mnt/jffs2/sdk_mnt ]; then
        echo "load sdk start"
        loadsdkfs sdk
        echo "load sdk end"
    fi
}

echo "User init start......"
# load sdk
mount_sdk

if [ -d "/var/TsdkFs/lib/modules/hisi_sdk" ]; then
  sdk_path="/var/TsdkFs/lib/modules/hisi_sdk"
else 
  sdk_path="/lib/modules/hisi_sdk"
fi
if [ -d "/var/TsdkFs/etc/soc" ]; then
  phy_ponlink_path="/var/TsdkFs/etc/soc/"
else 
  phy_ponlink_path="/etc/soc/"
fi

# load hisi modules
cd $sdk_path
echo "Loading the HISI SD511X modules: "

if [ -f $sdk_path/hi_sal.ko ]; then
    insmod hi_sal.ko
fi

#如果有多芯片注册KO，则注册多芯片，否则注册单芯片
if [ -f /lib/modules/wap/hw_module_multichip.ko ]; then
    insmod hi_sysctl.ko g_chipnum=2
else
    insmod hi_sysctl.ko
fi

tempChipType1=`md 0x10100800 1`
tempChipType=`echo $tempChipType1 | sed 's/.*:: //' | sed 's/[0-9][0-9]00//' | cut -b 1-4`

#合并之后的ko只需要加载一个
if [ -f $sdk_path/hi_ecs.ko ]; then
    insmod hi_ecs.ko
else
    insmod hi_spi.ko
    insmod hi_mdio.ko
    insmod hi_gpio.ko
    insmod hi_dma.ko
    insmod hi_i2c.ko
    insmod hi_timer.ko
    insmod hi_uart.ko
fi
insmod hi_ponlink.ko
insmod hi_hilink.ko

if [ $flashtype_v5 = 1 ]; then
    insmod hi_crg.ko pPhyPatchPath=$phy_ponlink_path g_pSerdesFirmwarePath=$phy_ponlink_path
    insmod hi_gemac.ko
    insmod hi_xgemac.ko
    insmod hi_pcs.ko
    insmod hi_dp.ko gemport_expand=1
else

    if [ -f $sdk_path/hi_crg.ko ]; then
        insmod hi_crg.ko pPhyPatchPath=$phy_ponlink_path g_pSerdesFirmwarePath=$phy_ponlink_path
        insmod hi_gemac.ko
        insmod hi_xgemac.ko
        insmod hi_pcs.ko
    fi

    if [ $tempChipType -eq 5115 ]; then
        insmod hi_dp_5115.ko
    else
        insmod hi_dp.ko
    fi
fi

enable_64bit=`GetFeature FT_WAN_STATISTICS_SUPPORT_64BIT`
if  [ $enable_64bit = 1 ];then
    insmod hi_bridge.ko
else 
    insmod hi_bridge.ko g_xfc_64bit_en=0
fi

insmod hi_ponlp.ko

if [ -e /mnt/jffs2/xpon_mode_sccn ]; then
    mv /mnt/jffs2/xpon_mode_sccn /mnt/jffs2/xpon_mode
fi

if [ ! -f /mnt/jffs2/xpon_mode ]; then
   if [ ${var_xpon_mode} == "4" ]; then
        echo '1' > /mnt/jffs2/xpon_mode
   elif [ ${var_xpon_mode} == "12" ]; then
        echo '5' > /mnt/jffs2/xpon_mode
    elif [ ${var_xpon_mode} == "15" ]; then
        echo '10' > /mnt/jffs2/xpon_mode
   else
        echo ${var_xpon_mode} > /mnt/jffs2/xpon_mode
   fi
fi

ontchown 3003:2002 /mnt/jffs2/xpon_mode && ontchmod 640 /mnt/jffs2/xpon_mode

if [ ${var_xpon_mode} == "4" ] || [ ${var_xpon_mode} == "12" ] || [ ${var_xpon_mode} == "15" ]; then
    pon_type_value=`cat /mnt/jffs2/xpon_mode`
else
    pon_type_value=${var_xpon_mode}
fi

#融合CPE需要同时启动gpon和xgpon，用hw_module_ploam_proxy.ko是否存在判断融合CPE
if [ -f /lib/modules/wap/hw_module_ploam_proxy.ko ]; then
    insmod hi_xgmac.ko
    insmod hi_gmac.ko
    insmod hi_gpon.ko
elif [ ${var_xpon_mode} == "5" ] || [ ${pon_type_value} == "5" ]; then
    insmod hi_xgmac.ko
    insmod hi_xgpon.ko
    if [ $flashtype_v5 = 1 ]; then
        insmod hi_gpon.ko
    elif [ -f $sdk_path/hi_gpon.ko ]; then
        insmod hi_gpon.ko
    fi
elif [ ${var_xpon_mode} == "6" ] || [ ${pon_type_value} == "6" ]; then
    insmod hi_xemac.ko
    insmod hi_xepon.ko
    if [ $flashtype_v5 = 1 ]; then
        insmod hi_epon.ko
    elif [ -f $sdk_path/hi_epon.ko ]; then
         insmod hi_epon.ko
    fi
elif [ ${var_xpon_mode} == "7" ]; then
    insmod hi_xemac.ko
    insmod hi_xepon.ko
    if [ $flashtype_v5 = 1 ]; then
        insmod hi_epon.ko
    elif [ -f $sdk_path/hi_epon.ko ]; then
        insmod hi_epon.ko
    fi
elif [ ${var_xpon_mode} == "10" ] || [ ${pon_type_value} == "10" ]; then
        insmod hi_xgmac.ko
        insmod hi_xgpon.ko
    if [ $flashtype_v5 = 1 ]; then
        insmod hi_gpon.ko
    elif [ -f $sdk_path/hi_gpon.ko ]; then
        insmod hi_gpon.ko
    fi
elif [ ${var_xpon_mode} == "1" ] || [ ${pon_type_value} == "1" ]; then
        insmod hi_gmac.ko
        insmod hi_gpon.ko
elif [ ${var_xpon_mode} == "2" ] || [ ${pon_type_value} == "2" ]; then
        insmod hi_emac.ko
        insmod hi_epon.ko
elif [ ${var_xpon_mode} == "3" ]; then
    echo "eth mode"
else
    insmod hi_gmac.ko
    insmod hi_emac.ko
    insmod hi_gpon.ko
    insmod hi_epon.ko
fi

#加载多芯片注册KO
if [ -f /lib/modules/wap/hw_module_multichip.ko ]; then
    insmod /lib/modules/wap/hw_module_multichip.ko
fi

insmod /lib/modules/hisi_sdk/hi_pie.ko tx_chk=0
#特殊接口在此ko中初始化注册，仅限GPON产品加载
if [ ${var_xpon_mode} == "1" ] || [ ${var_xpon_mode} == "5" ] || [ ${var_xpon_mode} == "10" ] || [ ${var_xpon_mode} == "15" ]; then
    insmod /lib/modules/hisi_sdk/hi_gpon_api_regist.ko
fi
if [ $tempChipType -eq 5115 ]; then
    insmod hi_l3_5115.ko
else
    #根据配置指定SDK的NAPT表项规格,product_flag.cfg代表低端双频网关
    if [ -f "/etc/wap/product_flag.cfg" ]; then
       echo "hi_l3.ko napt_ext_ipv4_mode=2 napt_ext_ipv6_mode=2"
       insmod hi_l3.ko napt_ext_ipv4_mode=2 napt_ext_ipv6_mode=2
    else
       echo "hi_l3.ko"
       insmod hi_l3.ko
    fi
fi

insmod hi_oam.ko

if [ -f $sdk_path/hi_tms.ko ]; then
    echo "insmod hi_tms"
    insmod hi_tms.ko
fi

cd /

if [ -f /var/TsdkFs/lib/modules/hisi_cdk/libhs_sd5182_sdk_rtos.ko ]; then
    insmod /var/TsdkFs/lib/modules/hisi_cdk/libhs_sd5182_sdk_rtos.ko
elif [ -f /lib/modules/hisi_cdk/libhs_sd5182_sdk_rtos.ko ]; then
    insmod /lib/modules/hisi_cdk/libhs_sd5182_sdk_rtos.ko
fi
if [ -f /var/TsdkFs/lib/modules/hisi_cdk/libhs_sd5182_nse_rtos.ko ]; then
    insmod /var/TsdkFs/lib/modules/hisi_cdk/libhs_sd5182_nse_rtos.ko
elif [ -f /lib/modules/hisi_cdk/libhs_sd5182_nse_rtos.ko ]; then
    insmod /lib/modules/hisi_cdk/libhs_sd5182_nse_rtos.ko
fi

if [ -f /var/TsdkFs/lib/modules/hisi_cdk/hal_np.ko ]; then
    insmod /var/TsdkFs/lib/modules/hisi_cdk/hal_np.ko
elif [ -f /lib/modules/hisi_cdk/hal_np.ko ]; then
    insmod /lib/modules/hisi_cdk/hal_np.ko
fi

if [ -f $sdk_path/hi_woe.ko ]; then
    insmod $sdk_path/hi_woe.ko
fi

# set lanmac 
getlanmac $HW_LANMAC_TEMP
if [ 0  -eq  $? ]; then
    read HW_BOARD_LANMAC < $HW_LANMAC_TEMP
    echo "ifconfig eth0 hw ether $HW_BOARD_LANMAC"
    ifconfig eth0 hw ether $HW_BOARD_LANMAC
fi

# delete temp lanmac file
if [ -f $HW_LANMAC_TEMP ]; then
    rm -f $HW_LANMAC_TEMP
fi

#虚拟ip未使能删除虚拟ip设置文件
if [ ! -f /mnt/jffs2/equip_ip_enable ]; then
    rm -f /mnt/jffs2/equip_ipnet
fi

#删除可能残留的装备的efuseflag文件
if [ -f /mnt/jffs2/equip_efuse_flag ]; then
    rm -f /mnt/jffs2/equip_efuse_flag
fi

mkdir /var/tmp && ontchmod 1777 /var/tmp

echo "Loading the EchoLife WAP modules: LDSP"

insmod /lib/modules/wap/hw_module_common.ko
insmod /lib/modules/wap/hw_module_bus.ko
if [ -f /lib/modules/wap/hw_module_extgpio.ko ];then
    insmod /lib/modules/wap/hw_module_extgpio.ko
fi
insmod /lib/modules/wap/hw_module_dev.ko

if [ -f /lib/modules/wap/hw_module_cdk.ko ]; then
    insmod /lib/modules/wap/hw_module_cdk.ko
fi
if [ -f /mnt/jffs2/defaultGroup.bin ]; then
    rm /mnt/jffs2/defaultGroup.bin
fi

chmod 640 /var/board_cfg.txt
#判断硬件能力集，按需加载
soc_type=`cat /var/board_cfg.txt | grep bob_type|cut -d ';' -f 3|cut -d '=' -f 2`
bob_type=`cat /var/board_cfg.txt | grep bob_type|cut -d ';' -f 6|cut -d '=' -f 2`
slic_type=`cat /var/board_cfg.txt | grep board_id|cut -d ';' -f 4|cut -d '=' -f 2`
ext_phy_type=`cat /var/board_cfg.txt | grep ext_phy_type|cut -d ';' -f 5|cut -d '=' -f 2`
support_usb=`cat /var/board_cfg.txt | grep usb|cut -d ';' -f 8|cut -d '=' -f 2`
support_sd=`cat /var/board_cfg.txt | grep sd|cut -d ';' -f 9|cut -d '=' -f 2`
support_rf=`cat /var/board_cfg.txt | grep rf|cut -d ';' -f 10|cut -d '=' -f 2`
support_battery=`cat /var/board_cfg.txt | grep battery|cut -d ';' -f 11|cut -d '=' -f 2`
support_iot=`cat /var/board_cfg.txt | grep iot|cut -d ';' -f 12|cut -d '=' -f 2`
support_nfc=`cat /var/board_cfg.txt | grep nfc|cut -d ';' -f 13|cut -d '=' -f 2`
support_lte=`cat /var/board_cfg.txt | grep lte|cut -d ';' -f 14|cut -d '=' -f 2`
pse_type=`cat /var/board_cfg.txt | grep pse_type|cut -d ';' -f 15|cut -d '=' -f 2`
support_rs485=`cat /var/board_cfg.txt | grep rs485|cut -d ';' -f 16|cut -d '=' -f 2`
ext_lsw_type=`cat /var/board_cfg.txt | grep ext_lsw_type|cut -d ';' -f 17|cut -d '=' -f 2`
support_motor=`cat /var/board_cfg.txt | grep motor|cut -d ';' -f 18|cut -d '=' -f 2`
support_pll=`cat /var/board_cfg.txt | grep pll|cut -d ';' -f 19|cut -d '=' -f 2`

echo "soc_type= $soc_type, bob_type= $bob_type, ext_phy_type= $ext_phy_type, ext_lsw_type= $ext_lsw_type, support_motor= $support_motor, support_pll= $support_pll"
echo "support_usb= $support_usb, support_sd= $support_sd, support_rf= $support_rf, support_battery= $support_battery, support_iot= $support_iot, support_nfc= $support_nfc, support_lte= $support_lte, pse_type=$pse_type"

chmodTtree.sh
SpecProc.sh
insmod /lib/modules/wap/hw_dm_pdt.ko

reload_feature="/proc/wap_proc/feature"
if [ -f $reload_feature ];then
    echo "Reload" > $reload_feature
else
    insmod /lib/modules/wap/hw_module_feature.ko
fi

rm -rf /var/spec/
insmod /lib/modules/wap/hw_module_optic.ko
#关键文件校验log恢复
ProcDataWh -l

if [ $soc_type == HWSOC3 ] || [ $soc_type == HWSOC4 ] || [ $soc_type == HWSOC5 ] || [ $soc_type == SD5118V2 ] || [ $soc_type == HWSOC7 ] || [ $soc_type == HWSOC8 ] || [ $soc_type == HWSOC9 ]; then
    if [ -f $sdk_path/hi_ipsec.ko ]; then
        insmod $sdk_path/hi_ipsec.ko
        echo "insmod hi_ipsec.ko"
    fi
fi

if [ ${var_xpon_mode} == "2" ] || [ ${var_xpon_mode} == "6" ] || [ ${var_xpon_mode} == "7" ]; then
    insmod /lib/modules/wap/hw_ker_optic_chip_511x_epon.ko
elif [ ${var_xpon_mode} == "1" ] || [ ${var_xpon_mode} == "5" ] || [ ${var_xpon_mode} == "10" ]; then
    insmod /lib/modules/wap/hw_ker_optic_chip_511x_gpon.ko
elif [ ${var_xpon_mode} == "3" ]; then
    echo "eth mode"
elif [ ${var_xpon_mode} == "4" ]; then
    echo "adapt pon_mode : $pon_type_value"
    if [ ${pon_type_value} == "1" ]; then
        insmod /lib/modules/wap/hw_ker_optic_chip_511x_gpon.ko
    else
        insmod /lib/modules/wap/hw_ker_optic_chip_511x_epon.ko
    fi
elif [ ${var_xpon_mode} == "12" ]; then
    echo "adapt pon_mode : $pon_type_value"
    if [ ${pon_type_value} == "5" ]; then
        insmod /lib/modules/wap/hw_ker_optic_chip_511x_gpon.ko
    else
        insmod /lib/modules/wap/hw_ker_optic_chip_511x_epon.ko
    fi
elif [ ${var_xpon_mode} == "15" ]; then
    insmod /lib/modules/wap/hw_ker_optic_chip_511x_gpon.ko
else
    insmod /lib/modules/wap/hw_ker_optic_chip_511x_epon.ko
    insmod /lib/modules/wap/hw_ker_optic_chip_511x_gpon.ko
fi

#判断/mnt/jffs2/customize_xml.tar.gz文件是否存在，存在解压
if [ -e /mnt/jffs2/customize_xml.tar.gz ]; then
    #解析customize_relation.cfg
    tar -xzf /mnt/jffs2/customize_xml.tar.gz -C /mnt/jffs2/ customize_xml/customize_relation.cfg  
fi
#V5 版本只做以下光phy
echo "borad cfg bob type is"$bob_type
if [ $bob_type == M02103 ] || [ $bob_type == HN5176 ] || [ $bob_type == UX5176 ] || [ $bob_type == UX5176S ] || [ $bob_type == GNA4221 ]; then
    echo "G/E pon bob group"
    #M2013 Gpon/Epon光phy
    if [ -f /lib/modules/wap/hw_ker_optic_m02103.ko ]; then
        insmod /lib/modules/wap/hw_ker_optic_m02103.ko
    fi
    #HN5176 Gpon/Epon光phy
    if [ -f /lib/modules/wap/hw_ker_optic_hn5176.ko ]; then
        insmod /lib/modules/wap/hw_ker_optic_hn5176.ko
    fi
    #HU5176 Gpon/Epon光phy
    if [ -f /lib/modules/wap/hw_ker_optic_ux5176.ko ]; then
        insmod /lib/modules/wap/hw_ker_optic_ux5176.ko
    fi
elif [ $bob_type == SD5175v300 ] || [ $bob_type == GN7355 ] || [ $bob_type == HN517X ] || [ $bob_type == UX517X ]; then
    echo "XG/XE pon bob group"
    #SD5175不带MCU版本 XGpon/XEpon
    if [ -f /lib/modules/wap/hw_ker_optic_sd5175v300.ko ]; then
        insmod /lib/modules/wap/hw_ker_optic_sd5175v300.ko
    fi
    #GN7355带MCU版本 XGpon/XEpon
    if [ -f /lib/modules/wap/hw_ker_optic_sd5175.ko ]; then
        insmod /lib/modules/wap/hw_ker_optic_sd5175.ko
    fi

    #HN517X新芯片，这个必须要放在最后面，样片读不到chip，默认为HN5170!!!
    #HN5171/UX5171 XGSPON
    #HN5170/UX5170 XGPON
    if [ -f /lib/modules/wap/hw_ker_optic_517x.ko ]; then
        insmod /lib/modules/wap/hw_ker_optic_517x.ko
    fi
fi

if [ -f /lib/modules/wap/hw_ker_optic_gna4215.ko ]; then
    insmod /lib/modules/wap/hw_ker_optic_gna4215.ko
fi

if [ -f /lib/modules/wap/hw_ker_optic_ux3326.ko ]; then
    insmod /lib/modules/wap/hw_ker_optic_ux3326.ko
fi

# slave chip
if [ -f /lib/modules/wap/hal_module_slave_chip.ko ]; then
    insmod /lib/modules/wap/hw_module_spi.ko
    insmod /lib/modules/wap/hal_module_slave_chip.ko
    insmod /lib/modules/wap/hal_slave_chip_sd511x.ko
fi

# poe ko
if [ -f /lib/modules/wap/hw_module_poe.ko ]; then
    insmod /lib/modules/wap/hw_module_poe.ko
    if [ $pse_type == rtk8238 ]; then
        insmod /lib/modules/wap/hw_module_spi.ko
        insmod /lib/modules/wap/hw_ker_poe_rtk8238.ko
    fi
fi

if [ -f /lib/modules/wap/hw_module_poe_monitor.ko ]; then
    insmod /lib/modules/wap/hw_module_poe_monitor.ko
fi

if [ $support_battery == Y ]; then
    insmod /lib/modules/wap/hw_module_uart.ko
fi

if [ $support_rf == Y ]; then
    insmod /lib/modules/wap/hw_module_rf.ko
fi

if [ $support_rs485 == Y ]; then
    insmod /lib/modules/wap/hw_module_uart.ko
fi

# motor ko
if [ $support_motor == Y ]; then
    insmod /lib/modules/wap/hw_module_motor.ko
fi

# pll ko
if [ $support_pll == Y ]; then
    insmod /lib/modules/wap/hw_module_pll.ko
    insmod /lib/modules/wap/hw_ker_pll_au53x5.ko
    insmod /lib/modules/wap/hw_ker_pll_sa77xx.ko
    insmod /lib/modules/wap/hw_ker_pll_si53xx.ko
fi

function add_andlink_downloaddir()
{
    local deskcmcc4ap_ft=`GetFeature FT_DESKCMCCAP_SUPPORT`
    local andlink_gw_ft=`GetFeature FT_ANDLINK_PRIMARY_GW`
    if [ $deskcmcc4ap_ft = 1 ] || [ $andlink_gw_ft = 1 ]; then
        mkdir /var/andlink_download
        mount -t tmpfs -o nodev,nosuid,mode=1777 none /var/andlink_download
    fi
}

add_andlink_downloaddir

auto_upgrade=`GetFeature FT_HGW_UPGRADE_AP`
if [ ! -d /mnt/jffs2/pack_sh ] && [ $auto_upgrade -eq 1 ]; then
    mkdir /mnt/jffs2/pack_sh && ontchown 3008:2002 /mnt/jffs2/pack_sh && ontchmod 750 /mnt/jffs2/pack_sh
fi

#当合一包文件存在时先备份到var/pack_sh目录，避免升级失败删除后无法恢复
if [ $auto_upgrade -eq 1 ] && [ -d /mnt/jffs2/pack_sh ]; then
    mkdir /var/pack_sh && ontchown 3008:2002 /var/pack_sh && ontchmod 750 /var/pack_sh
    cp -f /mnt/jffs2/pack_sh/* /var/pack_sh/
fi

#极简模式，部分功能受限启动
minimal_mode=`GetFeature FT_DESKAP_MODE_SIMPLE`

#128M双频单板重新设置PIE最大接受报文长度
skb_mtu=`GetFeature FT_SKB_ACCORD_WITH_MTU`
mtu_spec=`GetSpec SPEC_LOWER_LAYER_MAX_MTU`
# 默认2048，需要按照SPEC重置
if [ $skb_mtu = 1 ]; then
    echo "spec effect:ifconfig eth0 mtu="$mtu_spec
    ifconfig eth0 mtu $mtu_spec
fi
# activate ethernet drivers
ifconfig eth0 192.168.100.1 up

if [ $tianyi_cut_128 = 1 ] && [ $flashtype_v5 = 1 ]; then
    touch /var/tianyi_cut_128
fi

if [ $soc_type == HWSOC3 ] || [ $soc_type == HWSOC4 ] || [ $soc_type == HWSOC5 ] || [ $soc_type == SD5118V2 ] || [ $soc_type == HWSOC7 ] || [ $soc_type == HWSOC8 ] || [ $soc_type == HWSOC9 ]; then
    if [ -f /lib/modules/wap/hw_module_sec.ko ];then
        insmod /lib/modules/wap/hw_module_sec.ko
        kmc_tool check kmc_store_A3
    fi
fi

# V5系列，均起loadexfs。
v_version=`cat /etc/version | cut -c 1-4`
echo "=======v_version:$v_version"
if [ "$v_version" == "V500" ] || [ $tianyi_cut_128 = 1 ]; then
    echo "V500 load ex rootfs"
    mkdir /var/image && ontchmod 770 /var/image
    loadexfs
fi

#产品侧DM加载之后就可以通过/proc/wap_proc/chip_attr文件获取芯片类型
#再根据芯片类型给kbox分配512k高端内存(只是网关产品才添加)
var_soc_attr_kbox=`cat /proc/wap_proc/chip_attr | grep chip_des`
var_soc_type_kbox=`echo $var_soc_attr_kbox | tr -s ' ' | cut -d ' ' -f 4 | tr -d \" | cut -b 1-6`
echo 153600 > /sys/module/kbox/parameters/kbox_default_reg_size

if [[ $var_soc_type_kbox == "HWSOC1" ]] || [[ $var_soc_type_kbox == "HWSOC6" ]]; then
    echo "0x80880000 512K" > /proc/kbox/mem
elif [[ $var_soc_type_kbox == "HWSOC2" ]]; then
    echo "0x80880000 512K" > /proc/kbox/mem
elif [[ $var_soc_type_kbox == "HWSOC3" ]]; then
    echo "0x80880000 512K" > /proc/kbox/mem
elif [[ $var_soc_type_kbox == "HWSOC4" ]] || [[ $var_soc_type_kbox == "HWSOC7" ]] || [[ $var_soc_type_kbox == "HWSOC8" ]] ; then
    echo "0x81080000 512K" > /proc/kbox/mem
elif [[ $var_soc_type_kbox == "HWSOC5" ]] ; then
    echo "0x81080000 512K" > /proc/kbox/mem
else
    var_soc_type_kbox=`echo $var_soc_attr_kbox | tr -s ' ' | cut -d ' ' -f 4 | tr -d \" | cut -b 3-6`
    if [[ $var_soc_type_kbox == "5117" ]]; then
        echo "0x80880000 512K" > /proc/kbox/mem
    elif [[ $var_soc_type_kbox == "5118" ]]; then
        echo "0x82080000 512K" > /proc/kbox/mem
    else
        echo "(!5117&!HWSOC1&!HWSOC2&!HWSOC3&!5118&!HWSOC4&!HWSOC5)can not configure the kbox!!!"
    fi
fi

var_kbox_config=`cat /proc/kbox/mem`
echo "kbox config(Addr---Size)="$var_kbox_config

#打开4.4 R死锁检测softlockup，分配128K大小，OOM大小为128K
echo 64 > /proc/sys/kernel/softlockup_log_size
echo 128 > /proc/oom_extend/kbox_region_size
echo 1 > /proc/sys/kernel/watchdog
echo 2 500 > /proc/sys/kernel/watchdog_thresh

#打印进程快照，必须在kbox配置之后
insmod /lib/modules/linux/mts/rtos_snapshot.ko log_size=164 per_cpu_size=8
if [ $? != 0 ]; then
    echo 1 > /proc/kbox/erasure
    echo 64 > /proc/sys/kernel/softlockup_log_size
    echo 128 > /proc/oom_extend/kbox_region_size
    insmod /lib/modules/linux/mts/rtos_snapshot.ko log_size=164 per_cpu_size=8 2>&1 > /dev/null
fi

cd /var
dlw 1 > lastsysinfo
var_size=`stat -c %s /var/lastsysinfo`
if [ $var_size -gt 1024 ]; then
    echo "save sys info"
    echo "=======kbox panic=======" >> lastsysinfo
    cat /proc/kbox/regions/panic >> lastsysinfo
    echo "=======kbox deadlock======" >> lastsysinfo
    cat /proc/kbox/regions/deadlock >> lastsysinfo
    echo "======kbox ks_0======" >> lastsysinfo
    cat /proc/kbox/regions/ks_0 >> lastsysinfo
    echo "=======kbox ks_1======" >> lastsysinfo
    cat /proc/kbox/regions/ks_1 >> lastsysinfo
    echo "=======kbox ks_2======" >> lastsysinfo
    cat /proc/kbox/regions/ks_2 >> lastsysinfo
    echo "=======kbox ks_3======" >> lastsysinfo
    cat /proc/kbox/regions/ks_3 >> lastsysinfo
    echo "=======kbox ks_4======" >> lastsysinfo
    cat /proc/kbox/regions/ks_4 >> lastsysinfo
    echo "=======kbox ks_main======" >> lastsysinfo
    cat /proc/kbox/regions/ks_main >> lastsysinfo

    tar -czf lastsysinfo.tar.gz lastsysinfo
fi
rm -rf lastsysinfo
cd /

uart_support=`GetFeature FT_CONSOLE_OPEN`
if [ $uart_support = 1 ]; then
    read uarflag < /proc/tty/uart_suspend
    echo "uarflag is $uarflag"
    if [ $uarflag = 1 ]; then
        echo 0 > /proc/tty/uart_suspend
    fi
fi

#挂载app分区
ctrg_support=`GetFeature HW_SSMP_FEATURE_CTRG`
cuinform_enale=`GetFeature FT_CU_DPI_CPLUG`
cuc_support=`GetFeature FEATURE_CU_DBUS`
fttrmerge_ctrg_support=`GetFeature FEATURE_FTTRMERGEBIN_CT`
fttrmerge_cuc_support=`GetFeature FEATURE_FTTRMERGEBIN_CU`
if [ $cuc_support = 1 ]; then
	framework_dir=cu
else
	framework_dir=upt
fi

if [ $ctrg_support = 1 ] || [ $cuc_support = 1 ]; then
	echo "start to insmod exportfs.ko and overlay.ko"
	if [ -f /lib/modules/linux/kernel/fs/exportfs/exportfs.ko ]; then
        insmod /lib/modules/linux/kernel/fs/exportfs/exportfs.ko
    fi
        
	if [ -f /lib/modules/linux/kernel/fs/overlayfs/overlay.ko ]; then
		insmod /lib/modules/linux/kernel/fs/overlayfs/overlay.ko
	fi

    if [ -f /lib/modules/linux/kernel/kernel/configs.ko ]; then
		insmod /lib/modules/linux/kernel/kernel/configs.ko
	fi
fi

if [ $cuc_support = 1 ]; then
	insmod /lib/modules/wap/libsha256.ko
	insmod /lib/modules/wap/sha256_generic.ko
	insmod /lib/modules/wap/ctr.ko
	insmod /lib/modules/wap/ccm.ko
	insmod /lib/modules/wap/cmac.ko
	insmod /lib/modules/wap/drbg.ko
	insmod /lib/modules/wap/seqiv.ko

	if [ -f /lib/modules/linux/kernel/fs/cifs/cifs.ko ]; then
		insmod /lib/modules/linux/kernel/lib/crypto/libdes.ko
		insmod /lib/modules/linux/kernel/lib/crypto/md4.ko
		insmod /lib/modules/linux/kernel/lib/crypto/sha512_generic.ko
		insmod /lib/modules/linux/kernel/fs/cifs/cifs.ko
	fi
fi

#HN8145XR 三大T合一bin
function china_allbin_process()
{
    osgi_block=/dev/ubi0_12 #HN8145XR  三大T合一bin，osgi_block需要挂载 到/dev/ubi0_12
    echo "osgi_block_all is: $osgi_block"
    mkdir -p /mnt/jffs2/plug
    mount -t ubifs -o sync $osgi_block /mnt/jffs2/plug
    if [ ! -f "/mnt/jffs2/mount_apps_ok" ]; then
        echo "mount_apps_ok" > "/mnt/jffs2/mount_apps_ok"
        umount /mnt/jffs2/plug
        mount -t ubifs -o sync $osgi_block /mnt/jffs2/plug
        if [  $? != 0  ] || [ ! -f "/mnt/jffs2/mount_apps_ok" ]; then
                echo "Failed to mount apps" | ls -l /mnt/jffs2
        fi
    fi
    mkdir -p /mnt/jffs2/plug/app
    rm -rf /mnt/jffs2/app
    [ ! -L /mnt/jffs2/app ] && ln -s /mnt/jffs2/plug/app /mnt/jffs2/app
}

#老的移动联通单板
function old_osgibin_process()
{
    #老流程
    if [ ! -d "/mnt/jffs2/app" ]; then
        mkdir /mnt/jffs2/app
    fi
    chown -h osgi_proxy:osgi /mnt/jffs2/app;chmod 770 /mnt/jffs2/app
    if [ -c "$osgi_block" ]; then
        mount -t ubifs -o sync $osgi_block /mnt/jffs2/app
        echo "osgi_block_ is: $osgi_block"
        if [ ! -f "/mnt/jffs2/mount_osgi_ok" ] && [ $work_as_ap -eq 0 ]; then
            echo "mount_ok" > "/mnt/jffs2/mount_osgi_ok"
            umount /mnt/jffs2/app
            mount -t ubifs -o sync $osgi_block /mnt/jffs2/app
            if [  $? != 0  ] || [ ! -f "/mnt/jffs2/mount_osgi_ok" ]; then
                echo "Failed to mount app" | ls -l /mnt/jffs2/app
            fi
        fi
    fi
}

if [ $tianyi_cut_128 = 0 ]; then
    if [ $flashtype_v5 = 1 ]; then
        #判断是否有app 分区,128M 无app分区，256M有app分区
        app_v5=`cat /proc/mtd | grep "app_system" | wc -l`
        echo "app_v5 is $app_v5"

        #判断是否是UBI单板
        if [ $flashtype_v5_old = 1 ]; then
            osgi_block=/dev/ubi0_5
        else
            if [ $app_v5 = 1 ]; then
                osgi_block=/dev/ubi0_10
            fi
        fi
    else
        osgi_block=/dev/ubi0_14
    fi

    #通过特性开关来挂载opt
    echo "@@@@@@ ctrg_support is $ctrg_support @@@@@@"

    if [ $ctrg_support = 1 ] || [ $cuc_support = 1 ]; then
        if [ ! -d "/mnt/jffs2/apps" ]; then
            mkdir /mnt/jffs2/apps
        fi

        if [ $flashtype_v5 = 1 ];then
            apps_block=ubi0_12
        else
            apps_block=ubi0_16
        fi

        #挂载天翼网关要求的分区目录，framework1和framework2由中间件挂载，/opt/upt/apps
        mkdir -p /mnt/jffs2/plug
        mount -t ubifs -o nodev,sync /dev/$apps_block /mnt/jffs2/plug
        if [ ! -f "/mnt/jffs2/mount_apps_ok" ]; then
            echo "mount_apps_ok" > "/mnt/jffs2/mount_apps_ok"
            umount /mnt/jffs2/plug
            mount -t ubifs -o nodev,sync /dev/$apps_block /mnt/jffs2/plug
            if [  $? != 0  ] || [ ! -f "/mnt/jffs2/mount_apps_ok" ]; then
                echo "Failed to mount apps, reboot system" | ls -l /mnt/jffs2
            fi
        fi

        mkdir -p /mnt/jffs2/plug/app
        mkdir -p /mnt/jffs2/plug/apps
        rm -rf /mnt/jffs2/app
        [ ! -L /mnt/jffs2/app ] && ln -s /mnt/jffs2/plug/app /mnt/jffs2/app

        mkdir -p /var/exrootfs
        mkdir -p /var/image && ontchmod 770 /var/image

        loadexfs
        
        ontchmod 777 /mnt/jffs2/plug
        ontchmod 770 /mnt/jffs2/plug/app;ontchown 3005:2002 /mnt/jffs2/plug/app
        ontchmod 777 /mnt/jffs2/plug/apps

        if [ $cuc_support = 1 ]; then
            [ ! -L /opt/cu/apps/apps/var/log ] && rm -fr /opt/cu/apps/apps/var/log && ln -s /var/run/dbus/culog /opt/cu/apps/apps/var/log
        fi
        
        if [ $fttrmerge_ctrg_support = 1 ];then
	        [ ! -L /mnt/jffs2/dbus-1 ] && rm -fr /mnt/jffs2/dbus-1 && ln -sf /opt/upt/apps/etc/dbus-1 /mnt/jffs2/dbus-1
        elif [ $fttrmerge_cuc_support = 1 ];then
	        [ ! -L /mnt/jffs2/dbus-1 ] && rm -fr /mnt/jffs2/dbus-1 && ln -sf /opt/cu/apps/etc/dbus-1 /mnt/jffs2/dbus-1
        fi

    else
        osgi_hasframe=`cat /proc/mtd | grep "frameworkA" | wc -l`
        echo "osgi_hasframe is $osgi_hasframe"
        if [ $osgi_hasframe = 1 ]; then # HN8145XR  三大T合一bin，osgi_block需要挂载 到/dev/ubi0_12
            echo "china_allbin_process"
            china_allbin_process
        else
            old_osgibin_process
            echo "old_osgibin_process"
        fi
    fi
fi

echo "loadsdkfs"
loadsdkfs
echo "=======v_version:$v_version"

need_support_wifi=`GetFeature HW_AMP_FEATURE_WLAN`
if [ $need_support_wifi = 1 ]; then
    if [ -f /lib/modules/linux/extra/arch/arm/mach-hisi/pcie.ko ]; then
        insmod /lib/modules/linux/extra/arch/arm/mach-hisi/pcie.ko
        insmod /lib/modules/wap/hw_module_acp.ko
    fi
fi

if [ $support_nfc == Y ]; then
    insmod /lib/modules/wap/hw_module_nfc_st.ko
    insmod /lib/modules/wap/hw_module_nfc.ko
    insmod /lib/modules/wap/hw_module_nfc_nta5332.ko
    insmod /lib/modules/wap/hw_module_nfc_fm11nc.ko
fi

###外置phy
if [[ $ext_phy_type != "NONE" ]] ; then
    insmod /lib/modules/wap/hw_module_mdio.ko
    insmod /lib/modules/wap/hw_module_phy.ko
fi

###按配置加载外置phy chip ko
if [[ $(echo $ext_phy_type | grep "RTL8211")"NOEXIST" != "NOEXIST" ]] ; then
    insmod /lib/modules/wap/hal_extphy_rtl8211.ko
fi
if [[ $(echo $ext_phy_type | grep "YT8521")"NOEXIST" != "NOEXIST" ]] ; then
    insmod /lib/modules/wap/hal_extphy_yt8521.ko
fi
if [[ $(echo $ext_phy_type | grep "BCM84881")"NOEXIST" != "NOEXIST" ]] ; then
    insmod /lib/modules/wap/hw_ker_phy_bcm84881.ko
fi
if [[ $(echo $ext_phy_type | grep "RTL8226")"NOEXIST" != "NOEXIST" ]] ; then
    insmod /lib/modules/wap/hw_ker_phy_rtl8266.ko
fi
if [[ $(echo $ext_phy_type | grep "RTL8261")"NOEXIST" != "NOEXIST" ]] ; then
    insmod /lib/modules/wap/phy_sdk_rtl8261.ko
    insmod /lib/modules/wap/hal_extphy_rtl8261.ko
fi
if [[ $(echo $ext_phy_type | grep "QCA8081")"NOEXIST" != "NOEXIST" ]] ; then
	insmod /lib/modules/wap/hal_extphy_qca8081.ko
fi

if [ $ext_lsw_type == RTL8366 ];then
    insmod /lib/modules/wap/hw_module_extlsw.ko
    insmod /lib/modules/wap/hw_ker_eth_rtl8366.ko
fi

insmod /lib/modules/wap/hw_module_amp.ko
insmod /lib/modules/wap/hw_module_l2qos.ko

#融合CPE需要同时启动gploam和xgploam，hw_module_ploam_proxy.ko只有两个协议栈同时启动才需要，因此用来判断gploam和xgploam同时启动
if [ -f /lib/modules/wap/hw_module_ploam_proxy.ko ]; then
        insmod /lib/modules/wap/hw_module_gmac.ko
        insmod /lib/modules/wap/hw_module_xgploam.ko
        insmod /lib/modules/wap/hw_module_ploam.ko
        insmod /lib/modules/wap/hw_module_ploam_proxy.ko
elif [ ${var_xpon_mode} == "4" ]; then
    if [ ${pon_type_value} == "1" ]; then
        insmod /lib/modules/wap/hw_module_gmac.ko
        insmod /lib/modules/wap/hw_module_ploam.ko
    else
        insmod /lib/modules/wap/hw_module_emac.ko
        insmod /lib/modules/wap/hw_module_mpcp.ko
    fi
elif [ ${var_xpon_mode} == "12" ]; then
    if [ ${pon_type_value} == "5" ]; then
        insmod /lib/modules/wap/hw_module_gmac.ko
        insmod /lib/modules/wap/hw_module_xgploam.ko
    else
        insmod /lib/modules/wap/hw_module_emac.ko
        insmod /lib/modules/wap/hw_module_mpcp.ko
    fi
elif [ ${var_xpon_mode} == "2" ] || [ ${var_xpon_mode} == "6" ] || [ ${var_xpon_mode} == "7" ]; then
    insmod /lib/modules/wap/hw_module_emac.ko
    insmod /lib/modules/wap/hw_module_mpcp.ko
elif [ ${var_xpon_mode} == "3" ]; then
    echo "eth mode"
else
    insmod /lib/modules/wap/hw_module_gmac.ko
    if [ ${var_xpon_mode} == "5" ] || [ ${var_xpon_mode} == "10" ] || [ ${var_xpon_mode} == "15" ]; then
        insmod /lib/modules/wap/hw_module_xgploam.ko
    else
        insmod /lib/modules/wap/hw_module_ploam.ko
    fi

    if [ -f /lib/modules/wap/hw_module_ppm.ko ]; then
        insmod /lib/modules/wap/hw_module_ppm.ko
    fi
fi

#通用网关挂载cgroup
cgroot="/sys/fs/cgroup"
mount -t tmpfs -o nodev,noexec,nosuid cgroup_root "${cgroot}"
subsys="cpu memory freezer cpuacct cpuset devices"
for item in $subsys; do
    mkdir -p "$cgroot/$item"
    mount -t cgroup -o "$item,nodev,noexec,nosuid" "$item" "$cgroot/$item"
done

osgi_cplugin_enble=`GetFeature HW_FT_OSGI_CPLUGIN`
if [ -d /var/osgi ]; then
    if [ -f /bin/osgi_proxy ] || [ $osgi_cplugin_enble == 1 ]; then
        mount -t tmpfs -o nodev,nosuid,noexec,size=16m,mode=770,uid=3005,gid=2000 none /var/osgi
    fi
fi

#通过特性开关来启动cwmp进程
resume_enble=`GetFeature HW_SSMP_FEATURE_TR069`
echo $resume_enble > /var/resume_enble_cwmp
minor_board=0

. /usr/bin/init_topo_info.sh

qoe_enble=`GetFeature FT_SHMP_QOE`

probe_server_enble=`GetFeature HW_SSMP_FT_CWMP_PROBE_SERVER`
if [ $probe_server_enble = 1 ]; then
    if [ -e /mnt/jffs2/jscmcc.qosmonloader.cpk ]; then
        rm -rf /mnt/jffs2/vixtel
        mkdir -p /mnt/jffs2/vixtel
        cd /mnt/jffs2/vixtel
        tar -xzf /mnt/jffs2/jscmcc.qosmonloader.cpk -C ./
        ontchmod 777 -R /mnt/jffs2/vixtel
        rm -f /mnt/jffs2/jscmcc.qosmonloader.cpk
        cd -
    fi
fi

if [ -f /mnt/jffs2/Equip_MU_UpGRD_Flag ]; then
    pots_num=0
    usb_num=0
    ssid_num=0
fi

echo "pots_num="$pots_num
echo " usb_num="$usb_num
echo "hw_route="$hw_route
echo "   l3_ex="$l3_ex
echo "    ipv6="$ipv6
echo "minor_board="$minor_board

mem_totalsize=`cat /proc/meminfo | grep MemTotal | cut -c11-22`
echo "Read MemInfo Des:"$mem_totalsize

# pots ko fpga依赖hw_ker_codec_pef31002.ko,后续要挪一下
if [ $pots_num -ne 0 ] || [ -f /lib/modules/wap/hw_module_fpga.ko ]; then
    insmod $sdk_path/hi_hw.ko
    insmod /lib/modules/wap/hw_module_highway.ko
    insmod /lib/modules/wap/hw_module_spi.ko
    insmod /lib/modules/wap/hw_module_codec.ko

    if [ $slic_type == SI32176 ]; then
        insmod /lib/modules/wap/codec_sdk_si3217x.ko
        insmod /lib/modules/wap/hw_ker_codec_si32176.ko
    elif [ $slic_type == PEF3201 ]; then
        insmod /lib/modules/wap/hw_ker_codec_pef3201.ko
    elif [ $slic_type == PEF3100x ]; then
        insmod /lib/modules/wap/hw_ker_codec_pef31002.ko
    elif [ $slic_type == LE964x ]; then
        insmod /lib/modules/wap/codec_sdk_le964x.ko
        insmod /lib/modules/wap/hw_ker_codec_le964x.ko
    elif [ $slic_type == N68x38x ]; then
        insmod /lib/modules/wap/hw_ker_codec_n68x38x.ko
    elif [ $slic_type == AUTO_MATCH ]; then
        #first le964x
        if [ -f /lib/modules/wap/hw_ker_codec_le964x.ko ]; then
            insmod /lib/modules/wap/codec_sdk_le964x.ko
            insmod /lib/modules/wap/hw_ker_codec_le964x.ko
        fi

        #second pef3100x
        if [ -f /lib/modules/wap/hw_ker_codec_pef31002.ko ]; then
            insmod /lib/modules/wap/hw_ker_codec_pef31002.ko
        fi

        #third coslic n68x38x
        if [ -f /lib/modules/wap/hw_ker_codec_n68x38x.ko ]; then
            insmod /lib/modules/wap/hw_ker_codec_n68x38x.ko
        fi
    else
        insmod /lib/modules/wap/hw_ker_codec_ve8910.ko
    fi
fi

# hw_module_gmacdrv_olt依赖hw_ker_codec_pef31002.ko,后续要挪一下
if [ -f /lib/modules/wap/hw_module_fpga.ko ]; then
    rm -f /var/fpga_load
    insmod /lib/modules/wap/hw_module_fpga.ko
    insmod /lib/modules/wap/hw_module_gmacdrv_olt.ko
    insmod /lib/modules/wap/hw_ker_fpga_xc7a100t.ko
fi

#if file is existed ,don't excute
if [ $usb_num -ne 0 ]; then
    /etc/wap/usb/init_usb.sh
fi

# AMP_KO
insmod /lib/modules/wap/hw_amp.ko

if [ $support_iot == Y ]; then
    insmod /lib/modules/wap/hw_module_uart.ko
    insmod /lib/modules/wap/hw_module_tty.ko
fi

##privilege to BBSP
ontchown 3012:2002 /mnt/jffs2/ppplasterr*

#privilege to BBSP
if [ -e /mnt/jffs2/dhcpc ] && [ ! -h /mnt/jffs2/dhcpc ]; then
    ontchown 3012:2002 /mnt/jffs2/dhcpc
    ontchown 3012:2002 /mnt/jffs2/dhcpc/*
fi

# BBSP_l2_basic
echo "Loading BBSP L2 modules: "
insmod /lib/modules/linux/kernel/drivers/net/slip/slhc.ko
insmod /lib/modules/linux/kernel/drivers/net/ppp/ppp_generic.ko
insmod /lib/modules/linux/kernel/drivers/net/ppp/pppox.ko
insmod /lib/modules/linux/kernel/drivers/net/ppp/pppoe.ko

insmod /lib/modules/wap/commondata.ko
insmod /lib/modules/wap/sfwd.ko
insmod /lib/modules/wap/l2ffwd.ko
insmod /lib/modules/wap/btvfw.ko
insmod /lib/modules/wap/hw_ptp.ko
insmod /lib/modules/wap/l2base.ko
insmod /lib/modules/wap/acl.ko
insmod /lib/modules/wap/cpu.ko

if [ -f /lib/modules/wap/bridge_ap_acc.ko ];then
    insmod /lib/modules/wap/bridge_ap_acc.ko
fi

# 5.10 内核默认策略是禁止扩展helper，产品主动打开； 4.4内核默认策略是打开；
echo 1 > /proc/sys/net/netfilter/nf_conntrack_helper
echo 1 > /sys/module/nf_conntrack/parameters/nf_conntrack_helper

if [ $soc_type != HWSOC4 ] && [ $soc_type != HWSOC7 ] && [ $soc_type != HWSOC8 ]; then
    insmod /lib/modules/wap/hal_adpt_hisi.ko
fi

if [ -f /lib/modules/wap/bbsp_l2_adpt.ko ];then
    insmod /lib/modules/wap/bbsp_l2_adpt.ko
fi
# BBSP_l2_basic end

insmod /lib/modules/linux/kernel/net/netfilter/xt_conntrack.ko

# BBSP_l2_extended
echo "Loading BBSP L2_extended modules: "
insmod /lib/modules/wap/l2ext.ko
# BBSP_l2_extended end

msocket_ft=`GetFeature FT_ADPT_CONFIG_IP_MULTICAST`
if [ $msocket_ft -eq 1 ]; then
    insmod /lib/modules/linux/kernel/net/netfilter/xt_addrtype.ko
fi

insmod /lib/modules/wap/qos_adpt.ko

feature_dscp2pbit=`GetFeature FT_DSCP_TO_8021P_TEMPLATE`
if [ $feature_dscp2pbit = 1 ];then
    insmod /lib/modules/linux/kernel/net/netfilter/xt_DSCP.ko
    echo "qos dscp to pbit installed ok!"
fi

# BBSP_l3_basic
echo "Loading BBSP L3_basic modules: "
insmod /lib/modules/wap/hw_ssp_gpl_ext.ko
[ -f /lib/modules/wap/hw_ssp_gpl_ext_add.ko ] && insmod /lib/modules/wap/hw_ssp_gpl_ext_add.ko
[ -f /lib/modules/wap/hw_module_priority.ko ] && insmod /lib/modules/wap/hw_module_priority.ko
[ -f /lib/modules/wap/hw_module_pbit.ko ] && insmod /lib/modules/wap/hw_module_pbit.ko
if [ -f /lib/modules/linux/kernel/net/ipv4/netfilter/nf_log_ipv4.ko ]; then
    # RTOS 4.4 new modules -- for xt_LOG.ko
    insmod /lib/modules/linux/kernel/net/ipv4/netfilter/nf_log_ipv4.ko
fi
feature_snmp_dyinggasp=`GetFeature FT_SNMP_DYINGGASP_SUPPORT`
if [ $feature_snmp_dyinggasp -eq 1 ]; then
    insmod /lib/modules/wap/esight_dying_gasp.ko
fi

# 依赖hw_ssp_gpl_ext.ko
insmod /lib/modules/wap/hw_module_wifi_bsd.ko
insmod /lib/modules/wap/hw_module_wifi_drv.ko
insmod /lib/modules/wap/hw_module_wifi_log.ko
if [ -f /lib/modules/wap/hw_module_acs.ko ];then
	insmod /lib/modules/wap/hw_module_acs.ko
fi
insmod /lib/modules/wap/hw_module_wifi_gpl.ko

if [ $ssid_num -ne 0 ] && [ ! -e /mnt/jffs2/wifi_kernel_debug ]; then
	if [ -e /lib/modules/wap/cfg80211.ko ]; then
		insmod /lib/modules/wap/cfg80211.ko
	fi

	if [ -e /lib/modules/wap/mhi_core.ko ]; then
		insmod /lib/modules/wap/mhi_core.ko
	fi

	if [ -e /lib/modules/wap/mhi_controllers.ko ]; then
		insmod /lib/modules/wap/mhi_controllers.ko
	fi

	if [ -e /lib/modules/wap/qrtr.ko ]; then
		insmod /lib/modules/wap/qrtr.ko
	fi

	if [ -e /bin/qrtr-cfg ]; then
		qrtr-cfg 1
	fi

	if [ -e /bin/qrtr-ns ]; then
		qrtr-ns &
	fi

	if [ -e /lib/modules/wap/qrtr-mhi.ko ]; then
		insmod /lib/modules/wap/qrtr-mhi.ko
	fi

	if [ -e /lib/modules/wap/qmi_helpers.ko ]; then
		insmod /lib/modules/wap/qmi_helpers.ko
	fi

	if [ -e /lib/modules/wap/qmi_interface.ko ]; then
		insmod /lib/modules/wap/qmi_interface.ko
	fi

	if [ -e /lib/modules/wap/qcom_kern.ko ]; then
		insmod /lib/modules/wap/qcom_kern.ko
	fi

	if [ -e /lib/modules/wap/smem.ko ]; then
		insmod /lib/modules/wap/smem.ko
	fi

	if [ -e /lib/modules/wap/cnss2.ko ]; then
		if [ -e /mnt/jffs2/qca_ramdump_enable ]; then
			insmod /lib/modules/wap/cnss2.ko bdf_pci0=0xA1 bdf_pci1=0xA0 ramdump_enabled=Y
		else
			insmod /lib/modules/wap/cnss2.ko bdf_pci0=0xA1 bdf_pci1=0xA0
		fi
	fi
fi

if [ $ctrg_support = 1 ]; then
    echo "Load hw_wifi_diagnose_ct.ko"
    insmod /lib/modules/wap/hw_wifi_diagnose_ct.ko
fi

cat /proc/wap_proc/spec | grep -w BBSP_SPEC_FWD_SESSIONNUM | while read spec_name spec_type spec_len spec_value; do
    if [ $spec_name = "BBSP_SPEC_FWD_SESSIONNUM" ]; then
        echo $spec_value | tr -d '\r' | tr -d '\n' > /proc/sys/net/nf_conntrack_max 2>>/var/xcmdlog
    fi
done
echo 1 > /proc/sys/net/netfilter/nf_conntrack_tcp_be_liberal 2>>/var/xcmdlog
#add for rtos, to enable connection tracking flow accounting for new kernel
echo 1 > /proc/sys/net/netfilter/nf_conntrack_acct

tedata=`GetFeature HW_FT_FEATURE_DTEDATA`
if [ ! -f /bin/telnet ]; then
    if [ $tedata = 1 ]; then
        if [ -f /mnt/jffs2/temp/telnet ]; then
            rm -rf /mnt/jffs2/temp/
        fi
    else
        if [ ! -f /mnt/jffs2/temp/telnet ]; then
            mkdir /mnt/jffs2/temp
            ln -sf /bin/busybox /mnt/jffs2/temp/telnet
        fi
        export PATH=/mnt/jffs2/temp:$PATH
    fi
fi

feature_tde_flag=`GetFeature FT_FEATURE_TDE`
if [ $feature_tde_flag = 1 ]; then
    iptables-restore -n < /etc/wap/sec_init_tde
else
    iptables-restore -n < /etc/wap/sec_init
fi

iptables  -t filter  -I INPUT_DMZIF -p  icmp --icmp-type  13  -j DROP

insmod /lib/modules/wap/hw_module_trigger.ko
insmod /lib/modules/wap/l3base.ko

if [ $msocket_ft -eq 1 ]; then
    insmod /lib/modules/wap/msocket_btv.ko
fi

#4.4 默认值是180，5.10默认值是120，保持和4.4一致
echo 180 > /proc/sys/net/netfilter/nf_conntrack_udp_timeout_stream

#add by zengwei for ip_forward and rp_filter nf_conntrack_tcp_be_liberal
#enable ip forward
echo 1 > /proc/sys/net/ipv4/ip_forward
#disable rp filter
echo 0 > /proc/sys/net/ipv4/conf/default/rp_filter
echo 0 > /proc/sys/net/ipv4/conf/all/rp_filter
#end of add by zengwei for ip_forward and rp_filter nf_conntrack_tcp_be_liberal
# BBSP_l3_basic end

#  load DSP modules
if [ $pots_num -ne 0 ]; then
    echo "Loading DSP temporary modules: "
    feature_soft_dsp=`GetFeature VOICE_FT_SOFT_DSP`
    insmod /lib/modules/wap/hw_module_dopra.ko
    if [ $feature_soft_dsp = 1 ]; then
        echo "Loading DSP 1 modules: "
        insmod /lib/modules/wap/hw_module_soft_dsp_sdk.ko
    else
        echo "Loading DSP 2 modules: "
        insmod /lib/modules/wap/hw_module_dsp_sdk.ko
    fi
    insmod /lib/modules/wap/hw_module_dsp.ko
fi

# BBSP_l3_extended
if [ $l3_ex -eq 0 ]; then
    echo "NO L3_extended!"
else
    echo "Loading BBSP L3_extended modules: "
    netslice_ft=`GetFeature FT_NETWORK_SLICE_SUBNET`
    if [ $netslice_ft = 1 ] && [ -f /lib/modules/wap/network_slice.ko ]; then
        insmod /lib/modules/wap/network_slice.ko
    fi
    insmod /lib/modules/linux/kernel/net/ipv4/ip_tunnel.ko
    insmod /lib/modules/linux/kernel/net/ipv4/gre.ko
    insmod /lib/modules/linux/kernel/net/ipv4/ip_gre.ko
    
    insmod /lib/modules/wap/l3ext.ko
    insmod /lib/modules/wap/hw_module_conenat.ko
    insmod /lib/modules/wap/ffwd_adpt.ko
    insmod /lib/modules/wap/napt.ko

    if [ -f /lib/modules/wap/smartont_bbsp.ko ]; then
        insmod /lib/modules/wap/smartont_bbsp.ko
    fi
fi

if [ -f /lib/modules/wap/np_adpt.ko ]; then
    insmod /lib/modules/wap/np_adpt.ko
fi
# BBSP_l3_extended end

if [ $soc_type == HWSOC4 ] || [ $soc_type == HWSOC7 ] || [ $soc_type == HWSOC8 ]; then
    insmod /lib/modules/wap/hal_adpt_hisi_np.ko
    insmod /lib/modules/wap/hw_module_wifi_np.ko
    insmod /lib/modules/wap/hal_eth_sd518x.ko
    insmod /lib/modules/wap/hal_qos_sd518x.ko
    echo "insmod hal_eth_sd518x!"
    if [ ${var_xpon_mode} == "12" ]; then
        if [ ${pon_type_value} == "5" ]; then
            insmod /lib/modules/wap/hw_module_gmac_sd518x.ko
            echo "insmod hw_module_gmac_sd518x!"
        else
            insmod /lib/modules/wap/hw_module_emac_sd518x.ko
            echo "insmod hw_module_emac_sd518x!"  
        fi
    elif [ ${var_xpon_mode} == "4" ]; then
        if [ ${pon_type_value} == "1" ]; then
            insmod /lib/modules/wap/hw_module_gmac_sd518x.ko
            echo "insmod hw_module_gmac_sd518x!"
        else
            insmod /lib/modules/wap/hw_module_emac_sd518x.ko
            echo "insmod hw_module_emac_sd518x!"  
        fi
    elif [ ${var_xpon_mode} == "2" ] || [ ${var_xpon_mode} == "6" ] || [ ${var_xpon_mode} == "7" ]; then
        insmod /lib/modules/wap/hw_module_emac_sd518x.ko
        echo "insmod hw_module_emac_sd518x!"
    else
        insmod /lib/modules/wap/hw_module_gmac_sd518x.ko
        echo "insmod hw_module_gmac_sd518x!"
    fi
fi

wifi_dev=`cat /proc/bus/pci/devices | cut -f 2 | sort -u`
if [ "$wifi_dev" == "808609d0" ]; then
    echo "no need to insmod np wifi"
elif [ -f /var/WiFisdk/lib/modules/wap/hi_np_wifi.ko ]; then
    insmod /var/WiFisdk/lib/modules/wap/hi_np_wifi.ko
    if [ -f /var/WiFisdk/lib/modules/wap/hi_np_wifi_cmd.ko ]; then
        insmod /var/WiFisdk/lib/modules/wap/hi_np_wifi_cmd.ko
    fi

    if [ -f /var/WiFisdk/lib/modules/wap/hi_np_wifi_diagnose.ko ]; then
        insmod /var/WiFisdk/lib/modules/wap/hi_np_wifi_diagnose.ko
    fi
elif [ -f /lib/modules/wap/hi_np_wifi.ko ]; then
    insmod /lib/modules/wap/hi_np_wifi.ko
    if [ -f /lib/modules/wap/hi_np_wifi_cmd.ko ]; then
        insmod /lib/modules/wap/hi_np_wifi_cmd.ko
    fi

    if [ -f /lib/modules/wap/hi_np_wifi_diagnose.ko ]; then
        insmod /lib/modules/wap/hi_np_wifi_diagnose.ko
    fi
fi

ft_no_boot_wifi=`GetFeature FT_WLAN_NO_BOOT_WIFI`
if [ $ft_no_boot_wifi -eq 0 ]; then
    if [ "$wifi_dev" == "59e70003" ] && [ -f /bin/WifiDyChipInstallKo.sh ]; then
        WifiDyChipInstallKo.sh &
    fi

    if [ -f /bin/WifiPreDfsInstall.sh ]; then
        # hisi ko提前加载KO开始标志
        touch /var/wifi_start_hisi_install
        chmod ug=r,o= /var/wifi_start_hisi_install
        chown -h srv_wifi:service /var/wifi_start_hisi_install

        # 执行SDK提前加载
        WifiPreDfsInstall.sh &
    fi
fi

if [ -f /bin/WifiAxInstallKo.sh ]; then
    WifiAxInstallKo.sh &
fi

# BBSP_Ipv6_feature
if [ $ipv6 -eq 0 ]; then
    echo "NO ipv6!"
else
    echo "Loading BBSP IPv6 modules: "
    if [ -f /lib/modules/linux/kernel/net/ipv6/netfilter/nf_log_ipv6.ko ]; then
        # RTOS 4.4 new modules -- for xt_LOG.ko
        insmod /lib/modules/linux/kernel/net/ipv6/netfilter/nf_log_ipv6.ko
    fi
    insmod /lib/modules/linux/kernel/net/ipv6/netfilter/nf_defrag_ipv6.ko

    if [ -f /lib/modules/linux/kernel/net/ipv6/netfilter/nf_conntrack_ipv6.ko ]; then
        insmod /lib/modules/linux/kernel/net/ipv6/netfilter/nf_conntrack_ipv6.ko # 5.10 没有nf_conntrack_ipv6.ko
    fi
    insmod /lib/modules/linux/kernel/net/ipv6/netfilter/ip6t_rt.ko
    insmod /lib/modules/linux/kernel/net/ipv6/netfilter/ip6_tables.ko
    insmod /lib/modules/linux/kernel/net/ipv6/netfilter/ip6table_filter.ko
    insmod /lib/modules/linux/kernel/net/ipv6/netfilter/ip6table_mangle.ko
    if [ -f /lib/modules/linux/kernel/net/ipv6/netfilter/nf_reject_ipv6.ko ]; then
        # RTOS 4.4 new modules -- for ip6t_REJECT.ko
        insmod /lib/modules/linux/kernel/net/ipv6/netfilter/nf_reject_ipv6.ko
    fi
    insmod /lib/modules/linux/kernel/net/ipv6/netfilter/ip6t_REJECT.ko

    if [ -f /lib/modules/linux/kernel/net/ipv6/netfilter/nf_nat_ipv6.ko ]; then
        insmod /lib/modules/linux/kernel/net/ipv6/netfilter/nf_nat_ipv6.ko # 5.10 没有nf_nat_ipv6.ko
    fi
    insmod /lib/modules/linux/kernel/net/ipv6/netfilter/ip6table_nat.ko
    insmod /lib/modules/linux/kernel/net/ipv6/tunnel6.ko
    insmod /lib/modules/linux/kernel/net/ipv6/ip6_tunnel.ko
    insmod /lib/modules/linux/kernel/net/ipv4/tunnel4.ko
    insmod /lib/modules/linux/kernel/net/ipv6/sit.ko
    insmod /lib/modules/4.4.263/kernel/net/8021q/8021q.ko
    insmod /lib/modules/wap/wap_ipv6.ko
    insmod /lib/modules/linux/kernel/net/ipv6/ip6_gre.ko
    ip6tables -t mangle -I PREROUTING -m mark --mark 0x102001 -i br+ -j DROP
    ip6tables -A OUTPUT -o ra+ -j DROP
    ip6tables -A OUTPUT -o wl+ -j DROP

    feature_tde2=`GetFeature FT_FEATURE_TDE`
        if [ $feature_tde2 = 1 ] ;then
            ip6tables-restore -n < /etc/wap/sec6_init_tde
        else
            ip6tables-restore -n < /etc/wap/sec6_init
        fi
fi
# BBSP_Ipv6_feature end

#softgre.ko放在系统IPV6模块加载之后，softgre.ko向ip_gre.ko, ip6_gre.ko注册hook
if [ -f /lib/modules/wap/softgre.ko ]; then
    insmod /lib/modules/wap/softgre.ko
fi

ethoam_enble=`GetFeature BBSP_FT_ETHOAM_SUPPORT`
insmod /lib/modules/wap/bbsp_l3_adpt.ko
if [ $ethoam_enble = 1 ]; then
    insmod /lib/modules/wap/ethoam.ko
    insmod /lib/modules/wap/ethoam_adpt.ko
    echo "ethoam installed ok!"
fi

video_diagnose_enable=`GetFeature BBSP_FT_VIDEO_DIAGNOSE`
feature_btv_emdi=`GetFeature HW_BBSP_FT_BTV_EMDI`
if [ $video_diagnose_enable = 1 ]; then
    insmod /lib/modules/wap/video_diag.ko
    insmod /lib/modules/wap/video_diag_adpt.ko
    echo "video_diag installed ok!"
    if [ $feature_btv_emdi = 1 ]; then
        insmod /lib/modules/wap/video_emdi_diag_adpt.ko
        insmod /lib/modules/wap/unicast_diag_adpt.ko
    fi
fi

# RTOS 4.4 new modules -- for l2tp_core.ko
if [ -f /lib/modules/linux/kernel/net/ipv4/udp_tunnel.ko ]; then
    insmod /lib/modules/linux/kernel/net/ipv4/udp_tunnel.ko
    insmod /lib/modules/linux/kernel/net/ipv6/ip6_udp_tunnel.ko
fi

echo "Loading BBSP l2tp modules: "
insmod /lib/modules/linux/kernel/net/l2tp/l2tp_core.ko
if [ -f /lib/modules/linux/kernel/net/l2tp/l2tp_netlink.ko ]; then
    # RTOS 4.4 new modules -- for CONFIG_L2TP_V3
    insmod /lib/modules/linux/kernel/net/l2tp/l2tp_netlink.ko
fi
insmod /lib/modules/linux/kernel/net/l2tp/l2tp_ppp.ko

http_capture_path="/var/httpcapture_support_useragent"
rm -fr $http_capture_path
echo "Loading netfilter extend connmark modules:"
insmod /lib/modules/wap/hw_module_nf_ext_connmark.ko
if [ $? -ne 0 ]; then
    echo "hw_module_nf_ext_connmark.ko" > $http_capture_path
fi
portmap_inseq_enable=`GetFeature BBSP_FT_PORTMAP_INSEQ`
if [ $portmap_inseq_enable = 1 ]; then
    insmod /lib/modules/wap/hw_module_nf_ext_connport.ko
    echo "connport installed ok!"
fi

template_capture_enable=`GetFeature BBSP_FT_TEMPLATE_CAPTURE`
if [ $template_capture_enable = 1 ]; then
    echo "Loading flow template modules:"
    insmod /lib/modules/wap/hw_module_template.ko
    if [ $? -ne 0 ]; then
        echo "hw_module_template.ko" > $http_capture_path
    fi
    echo "Loading netfilter http modules:"
    insmod /lib/modules/wap/hw_module_xt_http.ko
    if [ $? -ne 0 ]; then
        echo "hw_module_xt_http.ko" > $http_capture_path
    fi
    insmod /lib/modules/wap/hw_module_xt_capture.ko
    if [ $? -ne 0 ]; then
        echo "hw_module_xt_capture.ko" > $http_capture_path
    fi
fi

if [ -f /lib/modules/wap/mac_filter.ko ]; then
    insmod /lib/modules/wap/mac_filter.ko
    insmod /lib/modules/wap/access_inform.ko
    echo "mac_filter installed ok!"
fi

ft_app_ctl=`GetFeature FT_APP_NETWORK_CONTROL`
feature_l2tp=`GetFeature FT_L2TP_VPN`
if [ $ft_app_ctl = 1 ] || [ $feature_l2tp = 1 ]; then
    echo "loading app.ko:"
    insmod /lib/modules/wap/app.ko
fi

#skb内存池
feature_double_wlan=`GetFeature HW_AMP_FEATURE_DOUBLE_WLAN`
feature_11ac=`GetFeature HW_AMP_FEATURE_11AC`
not_skpool=`GetFeature FT_NOT_INSTALL_SKPOOL`
if [ $feature_double_wlan = 1 ] || [ $feature_11ac = 1 ]; then
    #128M双频单板重新设置SKPOOL内存大小
    if [ $not_skpool = 1 ]; then
        echo "note:skpool not installed!"
    else
        insmod /lib/modules/wap/skpool.ko
        echo "note:skpool installed!"
    fi
fi

#wds特性
insmod /lib/modules/wap/wds.ko
echo "wds installed ok!"
# BBSP_hw_route end

#通过特性开关来启动爱wifi的l2tp_fwd.ko,mark1.ko,FON开启ifb.ko
feature_l2tp=`GetFeature FT_BBSP_AWIFI_SWITCH`
feature_fon=`GetFeature HW_AMP_FEATURE_FON`
feature_tc=`GetFeature BBSP_FT_TC_POLICER`
feature_linkturbo=`GetFeature FT_WLAN_LINKTURBO`
feature_tc_ont_speedlimit=`GetFeature BBSP_FT_ONT_TC_SPEED_LIMIT`
if [ $feature_l2tp = 1 ] || [ $feature_fon = 1 ] ;then
    insmod /lib/modules/wap/l2tp_fwd.ko
    insmod /lib/modules/wap/mark1.ko
    insmod /lib/modules/linux/kernel/net/netfilter/xt_mac.ko
    insmod /lib/modules/linux/kernel/net/netfilter/xt_REDIRECT.ko
    echo "l2tp mark1 installed ok!"
fi

if [ $feature_fon = 1 ] || [ $feature_tc = 1 ] ;then
    insmod /lib/modules/linux/kernel/net/netfilter/nfnetlink_cttimeout.ko
    insmod /lib/modules/linux/kernel/net/netfilter/nf_tproxy_core.ko
    insmod /lib/modules/linux/kernel/net/netfilter/xt_NFQUEUE.ko
    insmod /lib/modules/linux/kernel/net/netfilter/xt_NFLOG.ko
    insmod /lib/modules/linux/kernel/net/netfilter/xt_connbytes.ko
    insmod /lib/modules/linux/kernel/net/netfilter/xt_length.ko
    if [ $feature_tc_ont_speedlimit = 1 ] ;then
        insmod /lib/modules/linux/kernel/drivers/net/ifb.ko numifbs=4
        insmod /lib/modules/linux/kernel/net/sched/sch_htb.ko
        insmod /lib/modules/linux/kernel/net/sched/sch_prio.ko
        insmod /lib/modules/linux/kernel/net/sched/cls_fw.ko
    else
        insmod /lib/modules/linux/kernel/drivers/net/ifb.ko
    fi
    echo "ifb installed ok!"
fi

insmod /lib/modules/linux/kernel/net/netfilter/nfnetlink_queue.ko
insmod /lib/modules/linux/kernel/net/netfilter/xt_NFQUEUE.ko

insmod /lib/modules/linux/kernel/net/netfilter/nfnetlink.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_netiface.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_netportnet.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_bitmap_ip.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_ip.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_ipport.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_ipmac.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_bitmap_port.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_bitmap_ipmac.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_net.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_ipportnet.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_netnet.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_list_set.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_ipmark.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_mac.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_netport.ko
insmod /lib/modules/linux/extra/netfilter/ipset/ip_set_hash_ipportip.ko
insmod /lib/modules/linux/extra/netfilter/xt_set.ko
echo "ipset installed ok!"

#change xt_recent module parameters for iptables
hit_count=`GetSpec SPEC_PORT_SCAN_PARA_HIT`
list_tot=100
if [ $hit_count -gt 20 ]; then
    list_tot=300
fi

insmod /lib/modules/linux/kernel/net/netfilter/xt_recent.ko ip_pkt_list_tot=255 ip_list_tot=$list_tot
insmod /lib/modules/linux/kernel/net/netfilter/xt_comment.ko

insmod /lib/modules/linux/kernel/net/802/stp.ko > /dev/null
insmod /lib/modules/linux/kernel/drivers/net/veth.ko > /dev/null
insmod /lib/modules/linux/kernel/net/bridge/bridge.ko > /dev/null
insmod /lib/modules/linux/kernel/net/llc/llc.ko

feature_vpn=`GetFeature FT_L2TP_VPN`
if [ $feature_vpn = 1 ]; then
    insmod /lib/modules/linux/kernel/drivers/net/ppp/pptp.ko
    insmod /lib/modules/linux/kernel/drivers/net/ppp/ppp_mppe.ko
    echo "l2tp vpn installed ok!"
fi

if [ $ssid_num -ne 0 ]; then
    insmod /lib/modules/wap/wifi_fwd.ko
fi

while true; do
    if [ -p /var/collect_data_fifo ]; then
        exec 1>/var/collect_data_fifo
        break;
    fi
    sleep 1
done

#绑定pie中断到CPU1
task_bind=3
cpu_plan=`GetSpec SPEC_CPUS_BALANCE_PLAN`
if [ $cpu_plan -eq 1 ]; then
    echo "Start CPUS BALANCE PLAN ..."
    echo 2 > /proc/irq/132/smp_affinity
    taskset -p 1 1
    task_bind=1
fi

#start for hw_ldsp_cfg进行单板差异化配置，必须放在前面启动
iLoop=0
echo -n "Start ldsp_user..."
if [ -e /bin/hw_ldsp_cfg ]; then
  hw_ldsp_cfg &
  while [ $iLoop -lt 50 ] && [ ! -e /var/hw_ldsp_tmp.txt ]; do
    iLoop=$(( $iLoop + 1 ))
    sleep 0.1
  done

  if [ -e /var/hw_ldsp_tmp.txt ]; then 
      rm -rf /var/hw_ldsp_tmp.txt
  fi
fi

#自适应模式才启动ldsp_xpon_auto
gepon_auto_mode=`GetFeature FT_UPPORT_MODE_GPON_EPON_ADAPT`
xgepon_auto_mode=`GetFeature FT_UPPORT_MODE_XGPON_10GEPON_ADAPT`
xpon_auto_mode=0
if [ $gepon_auto_mode = 1 ] && [ $var_xpon_mode = 4 ]; then
    xpon_auto_mode=1
fi

if [ $xgepon_auto_mode = 1 ] && [ $var_xpon_mode = 12 ]; then
    xpon_auto_mode=1
fi

#通过特性开关来启动usb_resume进程
resume_enble=`GetFeature HW_SSMP_FEATURE_QUICKCFG`
if [ $resume_enble = 1 ]; then
    echo -n "Start usb_resume..."
    taskset $task_bind usb_resume
    break;
fi
iLoop=0
if [ -e /bin/hw_ldsp_cfg ]; then
  while [ $iLoop -lt 100 ] && [ ! -e /var/epon_up_mode.txt ] && [ ! -e /var/gpon_up_mode.txt ] && [ ! -e /var/ge_up_mode.txt ] && [ ! -e /var/wifi_up_mode.txt ] 
  do
    iLoop=$(( $iLoop + 1 ))
    sleep 0.1
  done
fi

insmod /lib/modules/wap/hw_module_drv_event.ko

# start install wifi ko ---------------------------------------
if [ $work_as_ap -eq 1 ];then
    echo "work as ap..."
    if [ ! -f /etc/wap/DebugVersionFlag ] || [ ! -f /mnt/jffs2/replace_ko ]; then
        echo "Start install wifi ko..."
        if [ -f /bin/WifiInstallKo.sh ]; then
            WifiInstallKo.sh &
        fi
    fi
fi

#天翼网关，增加dbus服务启动
if [ $ctrg_support = 1 ] || [ $cuc_support = 1 ]; then
    if [ $fttrmerge_ctrg_support = 1 ];then
        export PATH=/usr/ct:$PATH
        export LD_LIBRARY_PATH=/usr/ct:$LD_LIBRARY_PATH
    elif [ $fttrmerge_cuc_support = 1 ];then
        export PATH=/usr/cu:$PATH
        export LD_LIBRARY_PATH=/usr/cu:$LD_LIBRARY_PATH
    fi
    mkdir -p /var/lib/dbus/ && chmod -R 755 /var/lib
    dbus-uuidgen>>/var/lib/dbus/machine-id &
    chmod 644 /var/lib/dbus/machine-id
    mkdir -p /var/run/dbus/ && chmod 755 /var/run/dbus/

    chmod -R 755 /opt/upt/apps/apps
    chmod -R 755 /opt/upt/apps/olwork
    #info目录其他进程需要写入
    chmod 777 /opt/upt/apps/info

    #挂载后, 先确保 system.conf 存在，再启动dbus-daemon

    if [ ! -f /opt/$framework_dir/apps/etc/dbus-1/system.conf ]; then
        mkdir -p /opt/$framework_dir/apps/etc
        if [ $fttrmerge_cuc_support = 1 ];then
            cp -rf /etc/dbus/cu/dbus-1 /opt/$framework_dir/apps/etc/
        else
            cp -rf /etc/dbus/dbus-1 /opt/$framework_dir/apps/etc/
        fi
    fi

    if [ ! -f /opt/$framework_dir/apps/etc/dbus-1/system-local.conf ]; then
        if [ $fttrmerge_cuc_support = 1 ];then
            cp -f /etc/dbus/cu/dbus-1/system-local.conf /opt/$framework_dir/apps/etc/dbus-1/
        else
            cp -f /etc/dbus/dbus-1/system-local.conf /opt/$framework_dir/apps/etc/dbus-1/
        fi
    fi
    if [ ! -f /etc/dbus-1/system.conf ]; then
        echo "Error:not find system.conf"
    else
        if [ $cuc_support = 1 ];then
            mtd_num="`ufwmg -v | grep Active | sed 's/\(.*\)k\(.*\)/\2/g' | cut -d "]" -f 1`"
            var_devblock="/dev/mtdblock"$mtd_num
            mount -t squashfs $var_devblock /opt/cu/framework
        fi
        dbus-daemon --system&
    fi
fi

mkdir -p /var/lib/lxc/
mkdir -p /var/cache/lxc/ && ontchown :2002 /var/cache && ontchmod 770 /var/cache 

featureeai=`GetFeature FT_EAI_APP_SUPPORT`
if [ $featureeai -eq 0 ] && [ -f /mnt/jffs2/custum_finish_flag ];then
    if [-f /mnt/jffs2/app/explugin/eai.ipk];then
        rm -f /mnt/jffs2/app/explugin/eai.ipk
        echo "not support eai"
    fi
fi

if [ -f /lib/modules/wap/eaiframe.ko ];then
    insmod /lib/modules/wap/eaiframe.ko
fi

if [ $featureeai -eq 1 ];then
    insmod /lib/modules/linux/kernel/net/netfilter/xt_string.ko
    insmod /lib/modules/linux/kernel/net/netfilter/xt_time.ko
    insmod /lib/modules/linux/kernel/lib/ts_bm.ko
    insmod /lib/modules/linux/kernel/lib/ts_fsm.ko
    insmod /lib/modules/linux/kernel/lib/ts_kmp.ko
    insmod /lib/modules/wap/parentalctrl.ko
    echo "parentctrl ko installed ok!"
fi

feature_ap_andlink=`GetFeature FT_DESKCMCCAP_SUPPORT`
feature_gw_andlink=`GetFeature FT_ANDLINK_PRIMARY_GW`
if [ $feature_ap_andlink -eq 1 ] || [ $feature_gw_andlink -eq 1 ];then
    insmod /lib/modules/wap/andlink_pkt.ko
    insmod /lib/modules/linux/kernel/drivers/net/tun.ko
    insmod /lib/modules/linux/kernel/net/netfilter/xt_string.ko
    insmod /lib/modules/linux/kernel/net/netfilter/xt_time.ko
    insmod /lib/modules/linux/kernel/net/netfilter/xt_mac.ko
    echo "andlink_pkt ko installed ok!"
fi

if [ -f /mnt/jffs2/Equip_MU_UpGRD_Flag ]; then
    rm -f /mnt/jffs2/Equip_MU_UpGRD_Flag
    start ssmp comm lsvd bbsp amp cms&
    ssmp &
    cms &
    comm -l ssmp bbsp cms &
    bbsp &
    amp &

    while true; do
        sleep 1
        # 如果ssmploadconfig文件存在，表示消息服务启动成功，可以启动PM进程了
        if [ -f /var/ssmploadconfig ]; then
            procmonitor & break
        fi
    done &
    while true;
    do
        sleep 1

        if [ -f /var/ssmploaddata ] ; then
            echo -n "Start mu..."
            mu &
            echo "Start flash aging test..."
            /mnt/jffs2/equipment/bin/aging &
            break;
        fi
    done &
    exit 0
fi


# 当lan口需要等待wifi启动的时候，wifi和语音不延迟启动
lanwaitwifi=`GetFeature HW_AMP_FT_LAN_WAIT_WIFI`

#upnp扩展，控制是否在不带wifi单板上启动wifi&udm进程
ft_upnp_expand=`GetFeature FT_WLAN_UPNP_EXPAND`

var_appm_x=`GetFeature HW_SSMP_FEATURE_APPMX`

ft_wlan_fast_boot=`GetFeature FT_WLAN_FAST_BOOT`

# start process ---------------------------------------
var_proc_name="ssmp bbsp igmp amp cms"

var_proc_comm="-l bbsp wifi cms"

feature_dot1x=`GetFeature HW_BBSP_FEATURE_8021X`
if [ $feature_dot1x -eq 1 ] ;then
    var_proc_name=$var_proc_name" dot1x"
fi

if [ -f /bin/comm ]; then
    var_proc_name=$var_proc_name" comm"
fi

if [ -f /bin/lsvd ]; then
    var_proc_name=$var_proc_name" lsvd"
fi

if [ -e /bin/ethoam ] && [ $ethoam_enble = 1 ] ;then
    var_proc_name=$var_proc_name" ethoam"
    var_proc_comm=$var_proc_comm" ethoam"
fi

emdi_enble=`GetFeature HW_BBSP_FT_BTV_EMDI`
if [ -e /bin/emdi ] && [ $emdi_enble = 1 ] ;then
    var_proc_name=$var_proc_name" emdi"
fi

if [ $lanwaitwifi = 1 ]; then
    if [ $pots_num -ne 0 ]; then
        var_proc_name=$var_proc_name" voice"
    fi

    if [ $ssid_num -ne 0 ] || [ $ft_upnp_expand -eq 1 ]; then
        var_proc_name=$var_proc_name" wifi"
    fi
else
    if [ $ft_wlan_fast_boot -eq 1 ] && [ $ft_no_boot_wifi -eq 0 ]; then
        if [ $ssid_num -ne 0 ] || [ $ft_upnp_expand -eq 1 ]; then
            var_proc_name=$var_proc_name" wifi"
        fi
    fi
fi

if [ -e /var/gpon_up_mode.txt ]; then
    var_proc_name=$var_proc_name" omci"
fi

if [ -e /var/epon_up_mode.txt ]
then
    var_proc_name=$var_proc_name" oam"
fi

en=`cat /var/resume_enble_cwmp`
if [ $en = 1 ]; then
#    echo -n "Add cwmp to start..."
    var_proc_name=$var_proc_name" cwmp"
    var_proc_comm=$var_proc_comm" cwmp"
fi

enable_webpa=`GetFeature FT_SUPPORT_WEBPA`
if  [ -f /bin/webpa ] && [ $enable_webpa = 1 ];then
    var_proc_name=$var_proc_name" webpa"
    var_proc_comm=$var_proc_comm" webpa"
fi

areatype=1
if [ -e $txt_boardinfo ]; then
    areatype=`cat $txt_boardinfo | grep "0x00000062" | cut -c38-38`
fi

if [ -f /lib/libhw_smp_bulkdata.so ] && [ $areatype == 1 ]; then
    var_proc_comm=$var_proc_comm" bulk"
fi

if [ -f /lib/libhw_wlan_dbus.so ]; then
    var_proc_comm=$var_proc_comm" wlan_dbus"
fi

#通过特性开关，按启动框架来启动usb_mngt进程
usb_enble=`GetFeature HW_SSMP_FEATURE_USB`
usbsmart_enble=`GetFeature HW_SSMP_FEATURE_USBSMART`
tr111_enble=`GetFeature HW_SSMP_FEATURE_CWMP_TR111_P2`
rip_enble=`GetFeature FT_RIP_DYNAMIC_ROUTE`
pcp_enble=`GetFeature BBSP_FT_PCP`
#ethoam_enble=`GetFeature BBSP_FT_ETHOAM_SUPPORT`
cwmp_enble=`GetFeature HW_SSMP_FEATURE_TR069`
dido_enble=`GetFeature HW_SSMP_FEATURE_DIDO`

if [ ! -f /lib/libhw_usb_mngt.so ]; then
    usb_enble=0
    usbsmart_enble=0
fi 

if [ $usb_enble = 1 ] || [ $usbsmart_enble = 1 ]; then
    var_proc_comm=$var_proc_comm" usb_mngt dlna usb_ftp sftp"
fi

if [ -f /lib/libhw_dm_pdt_dido.so ] && [ $dido_enble = 1 ]; then
    var_proc_comm=$var_proc_comm" dido"
fi

if [ -f /lib/modules/wap/softgre.ko ]; then
    var_proc_comm=$var_proc_comm" softgre"
fi

if [ -f /lib/libtdefirewall.so ]; then
    var_proc_comm=$var_proc_comm" tdefirewall"
fi

if [ -f /lib/libuplinkqos.so ]; then
    var_proc_comm=$var_proc_comm" uplinkqos"
fi

if [ -f /lib/libtr098qos.so ]; then
    var_proc_comm=$var_proc_comm" tr098qos"
fi

if [ -f /lib/libvideo_diag_comm.so ] && [ $video_diagnose_enable = 1 ]; then
    var_proc_comm=$var_proc_comm" video_diag"
fi

monitor_enble=`GetFeature FT_COLLECT_MONITOR_REPORT`
if [ -f /lib/libhw_cwmp_common.so ] && [ $monitor_enble = 1 ]; then
    var_proc_comm=$var_proc_comm" monitor"
fi

if [ $feature_dot1x = 1 ]; then
    var_proc_comm=$var_proc_comm" dot1x"
fi

if [ -f /lib/libl3_ext_rip.so ] && [ $rip_enble = 1 ]; then
    var_proc_comm=$var_proc_comm" rip"
fi

if [ -f /lib/libpcp_c.so ] && [ $pcp_enble = 1 ];then
    var_proc_comm=$var_proc_comm" pcp_c"
fi

if [ -f /lib/libsmartont_bbsp.so ]; then
    var_proc_comm=$var_proc_comm" smartont_bbsp"
fi

if [ -f /lib/libnos_pt_shell.so ]; then
    var_proc_comm=$var_proc_comm" nos_pt_shell"
fi

var_proc_comm=$var_proc_comm" ssmp"
#tr143组件宿主进程是ssmp
if [ -f /lib/libhw_smp_tr143.so ]; then
    var_proc_comm=$var_proc_comm" tr143"
fi

if [ -f /lib/libcmcc_speedtest.so ]; then
    var_proc_comm=$var_proc_comm" cmcc_speedtest"
fi

if [ -f /lib/libhw_smp_cmp.so ]; then
    var_proc_comm=$var_proc_comm" cmp"
fi

houpUpgrade=`GetFeature FT_HOUP_UPGRADE`
if [ -f /lib/libhw_smp_houp.so ] && [ "$houpUpgrade" == "1" ]; then
    var_proc_comm=$var_proc_comm" houp"
fi

AutoUpgrade=`GetFeature FT_SINGTEL_AUTOUPGRADE`
if [ -f /lib/libauto_upgrade.so ] && [ "$AutoUpgrade" == "1" ]; then
    var_proc_comm=$var_proc_comm" auto_upgrade"
fi

if [ -f /lib/libhw_smp_gate.so ]; then
    var_proc_comm=$var_proc_comm" gate"
fi

if [ -f /lib/libhw_cwmp_bulkchina.so ] && [ $cwmp_enble = 1 ] && [ $areatype == 2 ]; then
    var_proc_comm=$var_proc_comm" bulkchina"
fi

if [ -f /bin/tr111p2 ] && [ $tr111_enble = 1 ]; then
    var_proc_name=$var_proc_name" tr111p2"
    var_proc_comm=$var_proc_comm" tr111p2"
fi

if [ -f /lib/libhw_smp_sntp.so ]; then
    var_proc_comm=$var_proc_comm" sntp"
fi

if [ -f /lib/libhw_ssp_syslogcfg.so ]; then
    var_proc_comm=$var_proc_comm" syslog"
fi

if [ -f /lib/libcwmp_userinfo_abroad.so ] && [ $areatype == 1 ]; then
    var_proc_comm=$var_proc_comm" cwmp_uinfo_a"
fi

if [ -f /lib/libcwmp_userinfo_china.so ] && [ $areatype == 2 ]; then
    var_proc_comm=$var_proc_comm" cwmp_uinfo_c"
fi

if [ -f /lib/libcli_userinfo.so ]; then
    var_proc_comm=$var_proc_comm" cliuserinfo"
fi

if [ -e /bin/ldsp_xpon_auto ] && [ $xpon_auto_mode -eq 1 ]; then
    var_proc_name=$var_proc_name" ldsp_xpon_auto"
fi

if [ -f /lib/libmaptunnel.so ]; then
    var_proc_comm=$var_proc_comm" maptunnel"
fi

if [ -f /lib/libbackupwan.so ]; then
    var_proc_comm=$var_proc_comm" backupwan"
fi

if [ -f /lib/libgreennetctrl.so ]; then
    var_proc_comm=$var_proc_comm" greennetctrl"
fi

if [ -f /lib/libeaiparentalctrl.so ]; then
    var_proc_comm=$var_proc_comm" eaiparentalctrl"
fi

if [ -f /lib/libhw_cms_safetycheck.so ]; then
    var_proc_comm=$var_proc_comm" safetycheck"
fi

if [ -f /lib/libhw_cms_wcwp.so ]; then
    var_proc_comm=$var_proc_comm" wcwp"
fi

if [ -f /lib/libhw_cms_xmpp.so ]; then
    var_proc_comm=$var_proc_comm" xmpp"
fi

tr369_support=`GetFeature FT_SUPPORT_TR369`
if [ $tr369_support = 1 ] && [ -f /lib/libcms_usp_cfg.so ]; then
    var_proc_comm=$var_proc_comm" usp"
fi

awareness_plugin_support=`GetFeature FT_AWARENESS_PLUGIN`
if [ $awareness_plugin_support = 1 ] && [ -f /lib/libuser_hardacc.so ]; then
    var_proc_comm=$var_proc_comm" hardacc"
fi

echo $var_proc_name
echo $var_proc_comm

osgi_no_app=`GetFeature FT_OSGI_NONAPP`
if [[ -c "$osgi_block" && $ctrg_support = 0 && $cuc_support = 0 && $work_as_ap -eq 0 ]] || [ $osgi_no_app = 1 ]; then 
 
    if [ ! -d "/mnt/jffs2/app/osgi" ]; then
        mkdir -p /mnt/jffs2/app/osgi;
    fi

    [ -d /mnt/jffs2/osgi ] && rm -rf /mnt/jffs2/osgi
    
    mkdir -p /mnt/jffs2/app;ontchown 3005:2000 /mnt/jffs2/app;ontchmod 770 /mnt/jffs2/app;

    ontchown 3005:2000 -R /mnt/jffs2/app/osgi 2>/dev/null; ontchmod 770 /mnt/jffs2/app/osgi;
    ontchown 3005:2000 -R /var/osgi 2>/dev/null;
    ontchown 3005:2000 -R /var/felix-temp 2>/dev/null;

    #special process for security upgrade
    if [ -f /mnt/jffs2/app/osgi/bundlelist.info.bak ];then
        seccacheinfo=`find /mnt/jffs2/app/osgi/felix-cache/ -name bundle.info |xargs grep framework.security-`
        seccachever=`echo $seccacheinfo |cut -d":" -f3`
        seccachedir=`echo $seccacheinfo |cut -d"/" -f7`
        syssecver=`find /usr/osgi/ -name *framework.security-*.jar`
        echo "seccachever:$seccachever syssecver:$syssecver"
        if [ "$seccachever" != "$syssecver" ];then
            rm -rf /mnt/jffs2/app/osgi/felix-cache/$seccachedir
            echo "rm $seccachedir ok"
        fi
    fi
    
    if [ -f /etc/wap/osgi_bundlelist.info ]; then
        cp -rf /etc/wap/osgi_bundlelist.info /var/osgi/bundlelist.info;
        ontchown 3005:2000 /var/osgi/bundlelist.info;
    fi
fi

ap_with_cagent=`GetFeature FT_AP_SUPPORT_CPLUGIN`
if [ $work_as_ap -eq 0 ] || [ $ap_with_cagent = 1 ]; then
    # C plugin
    mkdir -p /mnt/jffs2/app/cplugin;
    if [ -d /mnt/jffs2/cplugin ]; then
        if [ ! -f /mnt/jffs2/app/cplugin/cpluginstate ]; then
            cp -rf /mnt/jffs2/cplugin/* /mnt/jffs2/app/cplugin/
            rm -rf /mnt/jffs2/cplugin
        else
            rm -rf /mnt/jffs2/cplugin
        fi
    fi

    ontchmod 770 /mnt/jffs2/app/cplugin;
    ontchown 3005:2000 /mnt/jffs2/app/cplugin;
    
    # 创建C插件升级目录
    mkdir -p /var/Cplugin_upgrade;
    ontchown 3005:2000 /var/Cplugin_upgrade;
    ontchmod 775 /var/Cplugin_upgrade
    
    # 插件打包时Info.plugin被错误的设置为只读文件; 因此需要在启动时对该文件添加写权限, 以便于插件升级时更新版本信息
    for i in $(seq 1 10);do
        cpluin_dir=/mnt/jffs2/app/cplugin/cplugin$i
        cplugin_info=$cpluin_dir/Info.plugin
        if [ -d $cpluin_dir ] && [ -f $cplugin_info ]; then
            ontchmod u+w $cplugin_info
        fi
    done 
fi

#FTTR三大T合一bin，osgi组件启动时解压
if [ -e /mnt/jffs2/app/osgi.tar.gz ];then
    mkdir -p /mnt/jffs2/app/jdk
    mv /mnt/jffs2/app/osgi.tar.gz /var
    (tar -zvxf /var/osgi.tar.gz -C /mnt/jffs2/app/ ;rm -rf /var/osgi.tar.gz)&
    chown -Rh osgi_proxy:osgi /mnt/jffs2/app/jdk
fi

#网关模式起ret_server,ap模式起ret_clinet
if [ -f /bin/ret_server ] && [ $work_as_ap -eq 0 ]; then
    var_proc_name=$var_proc_name" ret_server"
fi

if [ -f /bin/ret_client ] && [ $work_as_ap -eq 1 ]; then
    var_proc_name=$var_proc_name" ret_client"
fi

# start 用于启动时创建共享内存，需要保证进程的个数正确即可，因此omci/oam使用oamomci替代
start $var_proc_name&

echo "Start SSMP..." && taskset $task_bind ssmp &

echo "Start cms..."
taskset $task_bind cms &

taskset $task_bind lsvd &

if [ -f /bin/comm ]; then
    echo "Start COMM..."
    taskset $task_bind comm $var_proc_comm &
fi

#通过特性开关来启动ret服务器和客户端进程
if [ -f /bin/ret_server ] && [ $work_as_ap -eq 0 ]; then
    echo -n "Start ret_server..."
    taskset $task_bind ret_server &
fi

if [ -f /bin/ret_client ] && [ $work_as_ap -eq 1 ];then
    echo -n "Start ret_client..."
    taskset $task_bind ret_client &
fi

echo -n "Start BBSP..."
taskset $task_bind bbsp &

echo -n "Start AMP..."
taskset $task_bind amp &

if [ -e /bin/ldsp_xpon_auto ] && [ $xpon_auto_mode -eq 1 ]; then
    echo -n "Start ldsp_xpon_auto..."
    taskset $task_bind ldsp_xpon_auto &
fi

echo -n "Start IGMP..."
if [ -f /bin/ret_server ] && [ $work_as_ap -eq 0 ];then
    touch /var/mc_prog_detect
fi

taskset $task_bind igmp &

#echo -n "Start ethoam..."
if [ -e /bin/ethoam ] && [ $ethoam_enble = 1 ]; then
    taskset $task_bind ethoam &
fi

#echo -n "Start emdi..."
if [ -e /bin/emdi ] && [ $emdi_enble = 1 ]; then
    taskset $task_bind emdi &
fi

if [ -e /bin/dot1x ] && [ $feature_dot1x -eq 1 ]; then
    taskset $task_bind dot1x &
fi

#echo -n "Start VOICE ..."
if [ $pots_num -eq 0 ]; then
    echo -n "Do not start VOICE..."
else
    if [ $lanwaitwifi = 1 ]; then
    echo -n "Start VOICE ...voice_sip -d 3 -n 10"
    [ -f /bin/voice_h248 ] && taskset $task_bind voice_h248 &
    [ -f /bin/voice_sip ] && taskset $task_bind voice_sip &
    [ -f /bin/voice_mgcp ] && taskset $task_bind voice_mgcp &
    [ -f /bin/voice_h248sip ] && taskset $task_bind voice_h248sip &
    else
        while true; do
            sleep 0.1
            if [ -f /var/init_kickoff ]; then
                echo -n "Start VOICE ...-d 3 -n 10"
                [ -f /bin/voice_h248 ] && taskset $task_bind voice_h248 -d 3 -n 10 &
                [ -f /bin/voice_sip ] && taskset $task_bind voice_sip -d 3 -n 10 &
                [ -f /bin/voice_mgcp ] && taskset $task_bind voice_mgcp -d 3 -n 10 &
                [ -f /bin/voice_h248sip ] && taskset $task_bind voice_h248sip -d 3 -n 10 &
                break;
            fi
        done &
    fi
fi

if [ $en = 1 ]; then
    taskset $task_bind cwmp &
fi

if [ -f /bin/tr111p2 ] && [ $tr111_enble = 1 ]; then
    taskset $task_bind tr111p2 &
fi

if [ -f /bin/webpa ] && [ $enable_webpa = 1 ]; then
    taskset $task_bind webpa &
fi

#end first --------------------------------------------

up_mode_uid=0
if [ -e /var/gpon_up_mode.txt ]; then
    AddSysUser cfg_omci 3009 2001 # 动态增加cfg_omci用户
    addgroup cfg_omci service
    addgroup cfg_omci osgi
    up_mode_uid=3009
    taskset $task_bind omci &
fi

if [ -e /var/epon_up_mode.txt ]; then
    AddSysUser cfg_oam 3011 2001 # 动态增加cfg_oam用户
    addgroup cfg_oam service
    addgroup cfg_oam osgi
    up_mode_uid=3011
    taskset $task_bind oam &
fi

# 临时解决降权限 升降级版本 装备/非装备切换 兼容问题
if [ $up_mode_uid -ne 0 ]; then
    ontchown $up_mode_uid:2001 /mnt/jffs2/oldcrc && ontchmod 640 /mnt/jffs2/oldcrc
    [[ -f /mnt/jffs2/xmlcfgerrorcode ]] && ontchown $up_mode_uid:2001 /mnt/jffs2/xmlcfgerrorcode
    [[ -f /mnt/jffs2/cu_cfg_counter ]] && ontchown $up_mode_uid:2001 /mnt/jffs2/cu_cfg_counter
    [[ -f /mnt/jffs2/cu_cfg_para ]] && ontchown $up_mode_uid:2001 /mnt/jffs2/cu_cfg_para
    [[ -f /mnt/jffs2/onlinecounter ]] && ontchown $up_mode_uid:2001 /mnt/jffs2/onlinecounter
fi

if [ -f /etc/wap/DebugVersionFlag ] && [ -f /mnt/jffs2/replace_celeno_ko ]; then
export cl2400_root=/var/cl2400_host_pkg/cl2400
elif [ -f /etc/wap/DebugVersionFlag ] && [ $ft_no_boot_wifi -eq 1 ]; then
export cl2400_root=/mnt/jffs2/app/cl2400_host_pkg/cl2400
else
export cl2400_root=/usr/lib/cl2400_host_pkg/cl2400
fi
export clr_install_dir_cl2400=$cl2400_root
export clr_cfg_dir_cl2400_24g=/var/cl2400_24g
export clr_cfg_dir_cl2400=/var/cl2400
export PATH=$PATH:$cl2400_root/bin:$cl2400_root/scripts
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$cl2400_root/lib

# wifi模块启动需要消耗内存多，主动清理一下缓存
sync
write_proc /proc/sys/vm/drop_caches 3

#获取单板形态
board_type="default"
if [ -f /bin/ontinfo ]; then
    board_type=$(ontinfo -s -b)
    board_len=${#board_type}
    let board_len=board_len-1
    board_type=$(expr substr $board_type 1 $board_len)
fi
#配置WIFI进程延时启动参数
wifi_delay=5
if [ $board_type == "HS8145V6" ]; then
    wifi_delay=0
fi

if [ $ft_no_boot_wifi -eq 0 ]; then
    if [ $ssid_num -ne 0 ] || [ $ft_upnp_expand -eq 1 ]; then
        echo -n "Start WIFI..."
        if [ $lanwaitwifi = 1 ] || [ $ft_wlan_fast_boot -eq 1 ]; then
            taskset $task_bind wifi &
        else
            taskset $task_bind wifi -d $wifi_delay -n 120 &
        fi
    fi
fi

#echo -n "Start ProcMonitor..."
while true; do 
    sleep 1
    # 如果ssmploadconfig文件存在，表示消息服务启动成功，可以启动PM进程了
    if [ -f /var/ssmploadconfig ]; then
        if [ $pots_num -eq 0 ] ; then
            echo "Start ProcMonitor without voice ..."

            taskset $task_bind procmonitor ssmp amp &
            break
        elif [ -f /bin/voice_h248 ]; then
            echo "Start ProcMonitor with h248 ..."
            taskset $task_bind procmonitor ssmp bbsp amp voice_h248 & break
        elif [ -f /bin/voice_mgcp ]; then
            echo "Start ProcMonitor with mgcp ..."
            taskset $task_bind procmonitor ssmp bbsp amp voice_mgcp & break
        elif [ -f /bin/voice_sip ]; then
             echo "Start ProcMonitor with sip ..."
            taskset $task_bind procmonitor ssmp bbsp amp voice_sip & break
        elif [ -f /bin/voice_h248sip ]; then
            echo "Start ProcMonitor with h248sip ..."
               taskset $task_bind procmonitor ssmp bbsp amp voice_h248sip & break
          else
            echo "Start ProcMonitor only ..."
            taskset $task_bind procmonitor ssmp bbsp amp & break
           fi
    fi
done &

#启动双机通信进程
feature_LTE_support=`GetFeature FT_LTE_SUPPORT`
if [ $feature_LTE_support = 1 ]; then
    echo -n "Start devscom..."
    while true; do
            sleep 1
            if [ -f /var/ssmploaddata ]; then
                taskset $task_bind devscom &
                break;
            fi
    done &
fi

#iODN产品需要关闭printk打印
printk_enble=`GetFeature HW_SSMP_FEATURE_PRINTK_SILENCE`
if [ $printk_enble == 1 ]; then
    echo 0 > /proc/sys/kernel/printk
fi

while true; do
    sleep 4
    # FixedDevice/OneTrack#993
    # 宽带确认阶段三完成RPC注册，此处选取阶段4时启动mu
    if [ -f /var/bbsploaddata ] && [ -f /var/ssmploaddata ]; then
        echo -n "Start mu..."
        taskset $task_bind mu & break;
    fi
done &

# [网关异常重启时暂停智能业务的启动] 判断当前单板是否支持osgi插件 (和下面osgi_proxy判断保持一致)
echo "osgi_block is: $osgi_block  ctrg_support is: $ctrg_support work_as_ap is: $work_as_ap"
if [ -c "$osgi_block" ] && [[ $ctrg_support = 0 || $cuc_support = 0 ]] && [ $work_as_ap -eq 0 ]; then
        osgi_support=1
else
        osgi_support=0
fi

# [网关异常重启时暂停智能业务的启动] plugin_suspend进程启动 (要确保dm已初始化完成, 且在ctrg进程和osgi_proxy进程之前启动)
echo "osgi_support is: $osgi_support  ctrg_support is: $ctrg_support"
if [ $osgi_support = 1 ] || [ $ctrg_support = 1 ] || [ $cuc_support = 1 ]; then
    if [ ! -f /bin/plugin_suspend ]; then
        echo "Error:not find plugin_suspend"
    else
        while true; do
            sleep 1
            if [ -f /var/ssmploaddata ] ; then
                echo "start plugin suspend"
                su -s /bin/sh osgi_proxy -c plugin_suspend & break;
            fi
        done &
    fi
fi

# KMC
# 启动KMC秘钥管理进程
echo -n "Start KMC..."
while true; do
        sleep 1
        if [ -f /var/ssmploaddata ]; then
                taskset $task_bind kmc & 
                break;
        fi
done &

# CBLC
# Start Combined Bin Loading Check Proc
echo -n "Start CBLC..."
while true; do
        sleep 1
        if [ -f /var/ssmploaddata ]; then
                taskset $task_bind cblc & 
                break;
        fi
done &


# JVM & OSGi Felix
#OSGI Only for 256M Flash
qbb_enable=`GetFeature FT_BBSP_QBB_SUPPORT`
if [[ -c "$osgi_block" && $ctrg_support = 0 && $cuc_support = 0 && $work_as_ap -eq 0 ]] || [ $osgi_no_app = 1 ]; then
    [[ -f /mnt/jffs2/app/save_upgrade_status ]] && ontchown 3005:2000 /mnt/jffs2/app/save_upgrade_status && ontchmod 664 /mnt/jffs2/app/save_upgrade_status
    osgiflag=`GetFeature FT_CWMP_WAIT_OSGI`
    echo cmcc is $osgiflag
    if [ $osgiflag = 1 ];then
        while true; do sleep 10; 
            if [ -f /var/ssmploaddata ]; then
                while [ -f /mnt/jffs2/hw_iotboardtype ] && [ ! -f /mnt/jffs2/hw_iotupdateresult ]; do
                    sleep 10
                done
                echo osgi_proxy start!
                if [ ! -f /var/kill_java ]; then
                     if [ $qbb_enable = 1 ]; then
                        insmod /lib/modules/wap/qbb_session.ko
                        insmod /lib/modules/wap/qbbflow_monitor.ko
                        insmod /lib/modules/wap/ker_qbb_monitor.ko
                        echo "ker_qbb_monitor installed ok!"
                    fi
                    osgi_proxy & 
                    break;
                fi
            fi
        done &
    else
        while true; do sleep 10;
            if [ -f /var/init_complete ]; then
                while [ -f /mnt/jffs2/hw_iotboardtype ] && [ ! -f /mnt/jffs2/hw_iotupdateresult ]; do
                    sleep 10
                done
                if [ ! -f /var/kill_java ]; then
                     if [ $qbb_enable = 1 ]; then
                        insmod /lib/modules/wap/qbb_session.ko
                        insmod /lib/modules/wap/qbbflow_monitor.ko
                        insmod /lib/modules/wap/ker_qbb_monitor.ko
                        echo "ker_qbb_monitor installed ok!"
                    fi
                    osgi_proxy & 
                    break;
                fi
            fi
        done &
       fi
else
    cpluginflag=`GetFeature HW_FT_OSGI_CPLUGIN`
    if [ $cpluginflag = 1 ] && [ $qbb_enable = 1 ]; then
        insmod /lib/modules/wap/qbb_session.ko
        insmod /lib/modules/wap/qbbflow_monitor.ko
        insmod /lib/modules/wap/ker_qbb_monitor.ko
        echo "ker_qbb_monitor installed ok!"
    fi

#modify for plugin
    ontchmod a+r /var/wan/dns
    ontchmod a+x /var/run/dbus
fi

#saf-huawei启动由ctrg_m来保证
if [ $ctrg_support = 1 ] || [ $cuc_support = 1 ]; then
    if [ $work_as_ap -eq 0 ]; then
        #天翼网关oom策略修改
        #0标识oom时不panic，默认值2
        echo 0 > /proc/sys/vm/panic_on_oom 
        #1标识oom时谁申请杀谁，默认值0
        echo 1 > /proc/sys/vm/oom_kill_allocating_task
    fi
fi

#启动ctrg_m服务进程
if [ -e /bin/ctrg_m ] && [ $work_as_ap -eq 0 ]; then
    if [ $ctrg_support = 1 ] || [ $cuc_support = 1 ];then
        # 在ctrg进程启动时主动创建诊断目录(防止电信插件使用root权限来创建, 导致其他的非root权限进程不可写)
        if [ ! -d /tmp/diaginfo ]; then
            mkdir -p /tmp/diaginfo
        fi
        ontchmod 777 /tmp/diaginfo

        while true; do
            if [ ! -f /mnt/jffs2/customizepara.txt ] && [ ! -f /mnt/jffs2/Equip.sh ]; then
                sleep 60;
            else
                sleep 2;
            fi

            if  [ -f /var/tianyi_stop ]; then
                break;
            fi

            if [ -f /var/init_complete ]; then
                umount /opt/cu/framework
                taskset $task_bind ctrg_m &
                break;
            fi
        done &
    fi
fi

ap_ubus_support=`GetFeature FT_SMART_UBUS_SUPPORT`
# 启动电信Edge AP ubus进程 
if [ $ap_ubus_support = 1 ] && [ -e /bin/ctcapd ]; then
    # 按照电信要求安装/ctcap/目录, 用于插件的安装升级和预制软件更新
    mount /mnt/jffs2/apps /ctcap/

    while true; do
        if [ ! -f /mnt/jffs2/customizepara.txt ] && [ ! -f /mnt/jffs2/Equip.sh ]; then
            sleep 10;
        else
            sleep 2;
        fi
        
        # 同样遵守tianyi_stop标志, 约定网关反复重启后不再启动中间件
        if  [ -f /var/tianyi_stop ]; then
            break;
        fi
        
        # 启动ctcapd进程
        if [ -f /var/init_complete ]; then
            /bin/ctcapd &
            break;
        fi
    done &
fi

#insmod y1731 ko for 5115S/H
var_soc_attr=`cat /proc/wap_proc/chip_attr | grep chip_des`
var_soc_type=`echo $var_soc_attr | sed 's/.*\"SD//'| sed 's/V[0-9]*\"//' | tr -d '[\015]'`
feature_1731_enble=`GetFeature BBSP_FT_1731`
if [ $feature_1731_enble = 1 ]; then
    if [ "${var_soc_type:0:5}" == "5115S" ] || [ "${var_soc_type:0:5}" == "5115H" ]; then
        insmod $sdk_path/hi_kit.ko
        echo "hi_kit installed ok!"
    fi
fi

#5117L芯片pie线程化需要将优先级提到100
soc_type_tmp=`cat /proc/wap_proc/chip_attr | grep chip_des|cut -d ' ' -f 30|sed 's/\"//g'|tr -d '\r\n'`
echo $soc_type_tmp
if [ "$soc_type_tmp" = "HWSOC2V100" ]; then
    pie_rx0_tmp=`wap.ssp.ps | grep pie_rx/0 |cut -d ' ' -f 3`
    pie_rx1_tmp=`wap.ssp.ps | grep pie_rx/1 |cut -d ' ' -f 3`
    busybox renice -20 -p $pie_rx0_tmp
    busybox renice -20 -p $pie_rx1_tmp
    echo 'renice 5117L pie_rx!'
fi

#insmod p2p nac ko
feature_p2p_nac=`GetFeature BBSP_FT_P2P_NAC`
if [ $feature_p2p_nac = 1 ]; then
    if [ -f /lib/modules/wap/nac.ko ]; then
        insmod /lib/modules/wap/nac.ko
    fi
fi

while true; do
    sleep 10
    if [ -f /var/ssmploaddata ] ; then
        taskset $task_bind wificli & break;
    fi
done &

fttr_spt=`GetFeature FT_FTTR_MAIN_ONT`
if [ $fttr_spt == 1 ]; then
    echo -n "Start LINEOMCI..."
    if [ -f /lib/modules/wap/ethomci.ko ]; then
        insmod /lib/modules/wap/ethomci.ko
    fi
    while true; do
        sleep 10
        if [ -f /var/ssmploaddata ] && [ -f /var/fpga_load ] && [ -e /bin/lineomci ]; then
            #用户不存在则动态添加用户
            egrep "^cfg_omci" /etc/passwd >& /dev/null
            if [ $? -ne 0 ]; then
                AddSysUser cfg_omci 3009 2001
                addgroup cfg_omci service
                addgroup cfg_omci osgi
            fi
            taskset $task_bind lineomci &
            break;
        fi
    done &
fi

#系统启动后加载 诊断信息获取ko
if [ -f /lib/modules/wap/hw_module_diag.ko ]; then
    insmod /lib/modules/wap/hw_module_diag.ko
fi

#延时20秒，保证可以取得正确feature，从而保证WEB进程启动正常
sleep 20

#删除恢复出厂设置的标示文件
rm -f /mnt/jffs2/factory_reset_tag

#启动完成之后，恢复打印级别为4
if [ $printk_enble -ne 1 ];then
    echo 4 > /proc/sys/kernel/printk
fi

feature_eai=`GetFeature FT_EAI_APP_SUPPORT`
feature_identify=`GetFeature FT_EAI_APP_IDENTIFY`
if [ $feature_eai = 1 ] && [ $feature_identify = 1 ];then
    insmod /lib/modules/wap/ifit.ko
    echo "ifit.ko installed ok!"
fi

usm_enable=`GetFeature FT_USM_CPLUG`
smart_phone_qoe_enable=`GetFeature VOICE_FT_SPEAKER_FEATURE`
smart_remoteplugin_enable=`GetFeature FT_PLUGIN_DOWNLOAD_REMOTE`
e8c_qoe_enble=`GetFeature FT_E8C_QOE`
e8c_gasy_enble=`GetFeature FT_E8C_GASY`
feature_awifi=`GetFeature HW_AMP_FT_FEATURE_AWIFI`
feature_elink=`GetFeature FEATURE_ELINK_START`
feature_except_ct=`GetFeature FEATURE_HILINK_START`
vixtel_robot_enble=`GetFeature FT_VIXTEL_ROBOT_CPLUG`
wifiaudit_enble=`GetFeature FT_CPLUGIN_WIFI_AUDIT`
audit_rzx_enble=`GetFeature FT_AUDIT_RZX_CPLUG`
tgrplugin_enble=`GetFeature FT_CPLUGIN_TGR`
ap_andlink_enable=`GetFeature FT_DESKCMCCAP_SUPPORT`
xr_andlink_enable=`GetFeature FT_ANDLINK_PRIMARY_GW`
edge_router_enable=`GetFeature FT_EDGE_AP_ROUTER`
mabr_support=`GetFeature FT_CPLUGIN_MABR_SUPPORT`
modify_cdn_enable=`GetFeature FT_MODIFY_CDN`
nginx_enable=`GetFeature FT_PCDN_SUPPORT`

#节省二层启动事件，延时启动iaccess  HW_SSMP_FEATURE_GXBMONITOR
iaccess_enble=`GetFeature HW_SSMP_FEATURE_GXBMONITOR`

if [ -f /var/lastsysinfo.tar.gz ]; then
    mv -f /var/lastsysinfo.tar.gz /mnt/jffs2/lastsysinfo.tar.gz && ontchown :2002 /mnt/jffs2/lastsysinfo.tar.gz
    chmod 440 /mnt/jffs2/lastsysinfo.tar.gz
fi

cwmp_tunnel=`GetFeature HW_SSMP_FT_CWMP_IGD_TUNNEL`
if [ -f /bin/portmapping ] && [ $cwmp_tunnel -eq 1 ]; then
    taskset $task_bind portmapping &
fi

#启动appm_x 进程
if [ -e /bin/appm_x ]; then
    if [ $var_appm_x = 1 ]; then
        while true; do sleep 10;
            if [ -f /var/init_complete ]; then
                echo -n "Start appm_x..."
                taskset $task_bind appm_x & break;
            fi
        done &
    fi
fi

capi_enble=`GetFeature FT_SSMP_AGENT_CAPI`
if [ -e /home/netopen/bin/kernelapp ] && [ $capi_enble -eq 1 ]; then
    while true; do sleep 10;
        if [ -f /var/init_complete ]; then
            # 等待30s，app_m进程准备就绪后再启动netopen C插件进程
            sleep 30
            export LD_LIBRARY_PATH=/home/netopen/lib:$LD_LIBRARY_PATH
            cd /home/netopen/bin
            ./daemon.sh &
            cd -
            break
        fi
    done &
fi

tde2_enble=`GetFeature FT_FEATURE_TDE`

#通过特性开关来启动EMM进程
resume_enble_emm=`GetFeature FT_SSMP_POWER_NODE_SUPPORT`
feature_wifidr=`GetFeature FT_WLAN_WIFIDOCTOR`
feature_wolink=`GetFeature FT_SUPPORT_UNICOM_RESTFUL`
# After system up, drop the page cache.
while true; do sleep 10;
    if [ -f /var/init_complete ]; then
        #启动m_json 进程
        ronghe_enble=`GetFeature FT_SHMP_RONGHE`
        if [ -f /bin/mm_json ] && [ $ronghe_enble -eq 1 ]; then
            taskset $task_bind mm_json &
        fi

        # 启动cagent
        capi_support=`GetFeature HW_FT_OSGI_CPLUGIN`
        if [[ $ap_with_cagent = 1 || $work_as_ap -eq 0 ]] && [ $capi_support = 1 ] && [ -f /bin/cagent ]; then
			rm -rf /var/apmode_nosmart
            taskset $task_bind cagent &
        fi

        # 延后启动的进程
        if [ -f /bin/apm ]; then
            taskset $task_bind apm &
        fi

        if [ -e /bin/iaccess ] && [ $iaccess_enble = 1 ]; then
            AddSysUser tool_iac 3019 2003; addgroup tool_iac service # 动态增加tool_iac用户
            taskset $task_bind iaccess &
            sleep 1
        fi

        if [ $feature_except_ct -eq 1 ]; then
            taskset $task_bind udm &
            sleep 1
        fi

        if [ $feature_elink -eq 1 ]; then
            taskset $task_bind elink &
            sleep 1
        fi

        if [ $feature_awifi -eq 1 ]; then
            taskset $task_bind awifi &
            sleep 1
        fi

        if [ $feature_fon -eq 1 ]; then
               taskset $task_bind fon &
            sleep 1
        fi

        if [ $feature_wolink -eq 1 ]; then
            taskset $task_bind xlink &
        fi

        if [ -f /bin/hweasymesh ]; then
            taskset $task_bind hweasymesh &
        fi
        if [ $feature_wifidr -eq 1 ]; then
            taskset $task_bind wifidr &
            sleep 1
        fi

        if [ $cuinform_enale = 1 ]; then
            mount -t tmpfs -o,mode=0755,size=5m tmpfs /usr/dpi
            mkdir -p /mnt/jffs2/app/dpi
            mkdir -p /mnt/jffs2/app/dpi/upper/tmp /mnt/jffs2/app/dpi/work
            chmod 777 -R /mnt/jffs2/app/dpi
            mount -n -t overlay -o rw,noatime,lowerdir=/usr/dpi,upperdir=/mnt/jffs2/app/dpi/upper,workdir=/mnt/jffs2/app/dpi/work overlay /CuInform
            mount -t tmpfs -o,mode=1777,size=5m tmpfs /CuInform/tmp
        fi

        if [ -f /bin/linkturbo ]; then
            if [ $feature_linkturbo -eq 1 ]; then
               taskset $task_bind linkturbo &
            fi
        fi

        if [ $qoe_enble = 1 ] || [ $probe_server_enble = 1 ] || [ $e8c_qoe_enble = 1 ] || [ $e8c_gasy_enble = 1 ] || [ $cuinform_enale = 1 ] || [ $edge_router_enable = 1 ] ||
           [ $smart_phone_qoe_enable = 1 ] || [ $usm_enable = 1 ] || [ $smart_remoteplugin_enable = 1 ] || [ $vixtel_robot_enble = 1 ] || 
           [ $wifiaudit_enble = 1 ] || [ $audit_rzx_enble = 1 ] || [ $tgrplugin_enble = 1 ] || [ $ap_andlink_enable = 1 ] || [ $xr_andlink_enable = 1 ] || 
           [ $mabr_support = 1 ] || [ $modify_cdn_enable = 1 ] || [ $nginx_enable = 1 ]; then
   			while true; do sleep 10;
				if [ -f /var/ssmploaddata ] ; then
					taskset $task_bind qoe & break; 
				fi
			done &
            if [ $tgrplugin_enble = 1 ];then
                [ ! -L /mnt/jffs2/Claro ] && rm -fr /mnt/jffs2/Claro && ln -s /mnt/jffs2/app/plugins/work/tgr/MyPlugin/ /mnt/jffs2/Claro
            fi
        fi	

		audit_obj_enble=`GetFeature FT_CWMP_NODE_AUDIT_PLUGIN`
        if [ $audit_obj_enble = 1 ];then
	        while true; do sleep 10;
			    if [ -f /var/ssmploaddata ] ; then
			        taskset $task_bind audit & break; 
		        fi
	        done &
        fi

        if [ $tde2_enble = 1 ]; then
               taskset $task_bind watchdog &
        fi

        if [ -d /mnt/jffs2/ThirdPartyPlugin ]; then
            rm -rf /mnt/jffs2/ThirdPartyPlugin
        fi

        if [ -f "/bin/emm" ] && [ $resume_enble_emm -eq 1 ];then
            while true; do sleep 10;
                if [ -f /var/ssmploaddata ] ; then
                    taskset $task_bind emm & break; 
                fi
            done &
        fi

        sleep 15

        # 大于128M水线值设置为4M，其它设置为3M
        mem_info=`cat /proc/cmdline | awk '{print $2}'`
        mem_size=`echo $mem_info | tr -cd "[0-9]"`
        if [[ $mem_size -gt 128 ]]; then
            MIN_FREE_INFO=4096
        else
            MIN_FREE_INFO=2560
        fi
        echo $MIN_FREE_INFO > /proc/sys/vm/min_free_kbytes

        kill -9 `ps | grep "sh -c taskset $task_bind" | grep  -v grep | awk '{print $1}'`
        write_proc /proc/sys/vm/drop_caches 3
        echo "Dropped the page cache. mem_size is $mem_size, and Limit is $MIN_FREE_INFO";

        # ZRAM内存压缩，当前先在HG8145X6-10单板上进行落地，通过FT_ZRAM_ON控制
        zram_flag=`GetFeature FT_ZRAM_ON`
        if [ $zram_flag = 1 ]; then
            # insmod zram相关ko，调试版本暂时编进内核，待RTOS提供正式版本
            insmod /lib/modules/linux/kernel/lib/lz4/lz4_decompress.ko
            insmod /lib/modules/linux/kernel/lib/lz4/lz4_compress.ko
            insmod /lib/modules/linux/kernel/crypto/lz4.ko
            insmod /lib/modules/linux/kernel/mm/zsmalloc.ko
            insmod /lib/modules/linux/kernel/drivers/block/zram/zram.ko
            total_mem=`cat /proc/meminfo | grep MemTotal | cut -d: -f2 |cut -dk -f1`
            disk_size=$(($total_mem * 1024 / 2))
            echo lz4 > /sys/block/zram0/comp_algorithm
            echo $disk_size > /sys/block/zram0/disksize
            mkswap /dev/zram0
            swapon /dev/zram0
        fi

        write_proc /proc/sys/net/ipv4/conf/br0/arp_announce 2
        if [ -f "/etc/wap/product_flag.cfg" ]; then
            killall kmsgread
        fi
        break;
    fi
done &

while true; do sleep 180; 
    if [ -f /var/init_complete ] && [ -f /bin/renice ] ; then
        echo -n "renice java..."
        renice -0 -u osgi_proxy;
        break;
    fi
done &

aisap_ft=`GetFeature FT_AISAP_MODE`
if [ -e /bin/aisap ] && [ $aisap_ft -eq 1 ]; then
	aisap &
fi

aismesh_api_ft=`GetFeature FT_AIS_MESH_API`
if [ -x /bin/aismesh ] && [ $aismesh_api_ft -eq 1 ]; then
	aismesh &
fi

shctap_ft=`GetFeature FT_SUPPORT_SHCT_AP_MANAGE`
if [ $shctap_ft -eq 1 ] && [ -e /bin/APManage ]; then
    echo "start APManage"
    APManage &
fi

scctap_ft=`GetFeature FT_SUPPORT_SCCT_AP_CUBE`
if [ $scctap_ft -eq 1 ] && [ -e /bin/ap_cube ]; then
    echo "start ap_cube"
    ap_cube &
fi

tr369_ft=`GetFeature FT_SUPPORT_TR369`
if [ -x /bin/usp ] && [ $tr369_ft -eq 1 ]; then
	usp &
fi

if [ -f /lib/modules/wap/ipsec_ker_crypt.ko ]; then
    if [ -f $sdk_path/hi_ipsec.ko ]; then
        insmod $sdk_path/hi_ipsec.ko
    fi
    if [ -f /lib/modules/5.10.0/kernel/crypto/gf128mul.ko ]; then
        insmod /lib/modules/5.10.0/kernel/crypto/gf128mul.ko
    fi

    insmod /lib/modules/wap/ipsec_ker_crypt.ko
fi

if [ -f /mnt/jffs2/app/ThirdPartyPlugin.tar.gz ]; then
	ontchmod 440 /mnt/jffs2/app/ThirdPartyPlugin.tar.gz
fi
if [ -f /mnt/jffs2/app/cplugin/cplugin1/MyPlugin/etc/res/webs.tar.gz ]; then
	ontchmod 440 /mnt/jffs2/app/cplugin/cplugin1/MyPlugin/etc/res/webs.tar.gz
fi