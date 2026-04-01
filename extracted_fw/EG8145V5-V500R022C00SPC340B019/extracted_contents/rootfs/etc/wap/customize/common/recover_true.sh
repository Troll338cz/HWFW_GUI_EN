#! /bin/sh

var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree_var=/var/hw_default_ctree.xml
var_default_ctree=/var/hw_default_ctree.xml
var_pack_temp_dir=/bin/
var_boardinfo_dup="/var/dup_boardinfo"
var_boardinfo_dup_tmp="/var/dup_boardinfo_tmp"
var_ssid=""
var_wpa="" 
var_para=""
var_pppoe_username=""

#set GPON SN 
HW_Set_GPON_SN_Passwd()
{
    if [ ! -f $var_boardinfo_dup ]
    then
        return;
    fi

    var_snpwd=`GetSpec SPEC_LOID_AMP_TRUE_SNPASSWORD`
    var_snpwdhex=`GetSpec SPEC_LOID_AMP_TRUE_SNPASSWORDHEX`

    cat $var_boardinfo_dup | while read -r line;
    do
            obj_id_temp=`echo $line | sed 's/\(.*\)obj.value\(.*\)/\1/g'`
            obj_id=`echo $obj_id_temp | sed 's/\(.*\)"\(.*\)"\(.*\)/\2/g'`
        #对于合一包制作场景不修改SN相关参数
        if [ "0x00000003" == $obj_id ] && [ ! -f /mnt/jffs2/gpon_chgpwd ] ;then
            echo "obj.id = \"0x00000003\" ; obj.value = \"$var_snpwd\";"
        elif [ "0x00000004" == $obj_id ] && [ ! -f /mnt/jffs2/gpon_chgpwd ] ;then
            echo "obj.id = \"0x00000004\" ; obj.value = \"$var_snpwdhex\";"
        else
            echo -E $line
        fi
    done  > $var_boardinfo_dup_tmp

    mv -f $var_boardinfo_dup_tmp $var_boardinfo_dup

    return 0
}

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
	read -r var_ssid var_wpa  var_pppoe_username < $var_customize_file
	
	return 0
}

# set customize data to file
HW_Script_SetDatToFile()
{
	var_node_ssid=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
	var_node_wpa_pwd=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	var_node_PPPOEWan=InternetGatewayDevice.WANDevice.WANDeviceInstance.1.WANConnectionDevice.WANConnectionDeviceInstance.1.WANPPPConnection.WANPPPConnectionInstance.1

	#判断密码即可
	if [ ! -z $var_wpa ]
	then
		# set ssid 
		cfgtool set $var_default_ctree_var $var_node_ssid SSID "$var_ssid"
		if [ 0 -ne $? ]
		then
		    echo "Failed to set common ssid name!"
		    return 1
		fi

		# set wpa password
		cfgtool set $var_default_ctree_var $var_node_wpa_pwd PreSharedKey "$var_wpa"
		if [ 0 -ne $? ]
		then
		    echo "Failed to set common ssid wap password!"
		    return 1
		fi
	fi
	   
	if [ ! -z $var_pppoe_username ]
	then
		#set PPPOE WAN username
		cfgtool set $var_default_ctree_var $var_node_PPPOEWan Username  "$var_pppoe_username"
		if [ 0 -ne $? ]
		then
		    echo "Failed to set pppoe wan username!"
		    return 1
		fi
	fi

	return
}

#
HW_Set_GPON_SN_Passwd

#
HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

#读取定制参数
HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

#
HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0

