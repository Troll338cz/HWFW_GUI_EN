#! /bin/sh

var_equipmode_file="/mnt/jffs2/Equip.sh"
var_equipmodenew_file="/etc/wap/equip_new"
var_equiptestmode_file="/mnt/jffs2/equiptestmode"

#如果boardinfo是加密的，只能操作解密后的文件
txt_boardinfo=/mnt/jffs2/hw_boardinfo
if [ -f /var/decrypt_boardinfo ]; then
	txt_boardinfo=/var/decrypt_boardinfo
fi

echo "[TOOLS]setequiptestmodeoff start."

#如果是装备模式，则退出
if [ -f $var_equipmode_file ] || [ -f $var_equipmodenew_file ]; then
    echo "[TOOLS]setequiptestmodeoff exit: state is EquipMode."
    return 1
fi

#删除equiptestmode文件，关闭装备测试模式，装备用户登录需要密码
if [ -f $var_equiptestmode_file ] ; then
	rm -fr $var_equiptestmode_file
	echo "[TOOLS]setequiptestmodeoff finish."
else
    echo "[TOOLS]setequiptestmodeoff exit: equiptestmode file don't exist."
fi

