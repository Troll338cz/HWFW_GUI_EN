#! /bin/sh

# 写入一个SSID的recover脚本，该脚本通过读取 /var/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中
#customize.sh COMMON_WIFI XXX SSID WPA密码
# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree=/var/hw_default_ctree.xml
var_default_ctree_var=/var/hw_default_ctree.xml
var_pack_temp_dir=/bin/
var_jffs2_customize_txt_file="/mnt/jffs2/customize.txt"

var_userPwd=""
var_OperatorId="SCCNCATV"

# GPON/EPON自适应上行模式标志文件
var_xpon_mode_file=/mnt/jffs2/xpon_mode_sccn
# 读取上行模式
var_access_mode=`cat /var/dup_boardinfo | grep "0x00000001" | cut -c38-38`

# check the customize file
HW_Script_CheckFileExist()
{
	if [ ! -f "$var_customize_file" ] ;then
	    echo "ERROR::customize file is not existed."
            return 1
	fi
	return 0
}

# read data from customize file
HW_Script_ReadDataFromFile()
{
	read -r var_userPwd < $var_customize_file
	if [ 0 -ne $? ]
	then
	    echo "Failed to read spec info!"
	    return 1
	fi
	return
}

HW_Script_GetOperatorIdByBinCfgKey()
{
	var_OperatorId="SCCNCATV"
	return
}

# set customize data to file
HW_Script_SetDatToFile()
{
	var_OperatorId_node=InternetGatewayDevice.DeviceInfo
	
	#get OperatorId
	HW_Script_GetOperatorIdByBinCfgKey
	
   	cfgtool set $var_default_ctree_var $var_OperatorId_node X_HW_OperatorID $var_OperatorId
	if [ 0 -ne $? ]
	then
		cfgtool add $var_default_ctree_var $var_OperatorId_node X_HW_OperatorID $var_OperatorId
		if [ 0 -ne $? ]
		then
			echo "Failed to set X_HW_OperatorID !"
			return 1
		fi
	fi
	
	var_node_web_pwd=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.1
	
	# set web user password
	cfgtool set $var_default_ctree_var $var_node_web_pwd Password $var_userPwd
	if [ 0 -ne $? ]
	then
		echo "Failed to set common web password!"
		return 1
	fi	

	return
}

# set access mode to epon
HW_Script_SetAccessModeEpon()
{
	if [ ${var_access_mode} == "4" ]; then
	    echo '2' > /mnt/jffs2/xpon_mode_sccn
	fi

	if [ ${var_access_mode} == "4" ] && [ ! -f "$var_xpon_mode_file" ]; then
	    echo "ERROR::access mode file is not existed."
        return 1
	fi
	return 0
}

HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

HW_Script_SetAccessModeEpon
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0

