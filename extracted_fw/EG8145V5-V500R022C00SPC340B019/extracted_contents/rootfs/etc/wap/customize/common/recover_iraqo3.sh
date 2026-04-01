#! /bin/sh

# 写入一个SSID的recover脚本，该脚本通过读取 /var/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中
#customize.sh COMMON IRAQO3 SSID1 WPA密码1 SSID2 WPA密码2
# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree=/var/hw_default_ctree.xml

var_pack_temp_dir=/bin/

var_ssid1=""
var_wpa1=""

var_ssid2=""
var_wpa2=""

var_boardinfo_dup="/var/dup_boardinfo"
var_boardinfo_dup_tmp="/var/dup_boardinfo_tmp"

#set GPON SN 
HW_Set_GPON_SN_Passwd()
{
    if [ ! -f $var_boardinfo_dup ]
    then
        return;
    fi

    var_snpwd=`GetSpec SPEC_LOID_AMP_IRAQ_SNPASSWORD`
    var_snpwdhex=`GetSpec SPEC_LOID_AMP_IRAQ_SNPASSWORDHEX`

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
	read -r var_ssid1 var_wpa1 var_ssid2 var_wpa2 < $var_customize_file
	if [ 0 -ne $? ]
	then
	    echo "Failed to read spec info!"
	    return 1
	fi
	return
}

# set customize data to file
HW_Script_SetDatToFile()
{
	var_node_ssid1=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
	var_node_wpa_pwd1=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	
	var_node_ssid2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.2
	var_node_wpa_pwd2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.2.PreSharedKey.PreSharedKeyInstance.1
	
	
	# decrypt var_default_ctre
	 
	 
	
	# set ssid 
	cfgtool set $var_default_ctree $var_node_ssid1 SSID $var_ssid1
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid1 name!"
	    return 1
	fi
	
	cfgtool set $var_default_ctree $var_node_ssid2 SSID $var_ssid2
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid2 name!"
	    return 1
	fi

	# set wpa password
	cfgtool set $var_default_ctree $var_node_wpa_pwd1 PreSharedKey $var_wpa1
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid1 wap password!"
	    return 1
	fi
	
	
	cfgtool set $var_default_ctree $var_node_wpa_pwd2 PreSharedKey $var_wpa2
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid2 wap password!"
	    return 1
	fi
		
	#encrypt var_default_ctree
	 
	 

	return
}


HW_Set_GPON_SN_Passwd

#
HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

#
HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

#
HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0