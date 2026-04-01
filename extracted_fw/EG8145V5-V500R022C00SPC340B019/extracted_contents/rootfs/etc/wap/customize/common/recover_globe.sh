#! /bin/sh

# 写入一个SSID的recover脚本，该脚本通过读取 /var/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中

# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree=/var/hw_default_ctree.xml
var_pack_temp_dir=/bin/
var_boardinfo_dup="/var/dup_boardinfo"
var_boardinfo_dup_tmp="/var/dup_boardinfo_tmp"
var_ProvisionCode="GLOBE"
var_ssid=""
var_wpa="" 
var_webadmin_pwd=""

HW_Check_Boardinfo()
{
	if [ -f $var_boardinfo_dup ]; then
		return 0;
	else
		echo "ERROR::$var_boardinfo_dup is not exist!"
		return 1;
	fi		
}

HW_Set_ProvisionCode()
{
    #ProvisionCode的ID为0x00000020
    #检查boardinfo是否存在
    HW_Check_Boardinfo
	if [ ! $? == 0 ]
	then
		echo "ERROR::Failed to Check Boardinfo!"
		return 1
	fi

	cat $var_boardinfo_dup | while read -r line;
	do
		obj_id_temp=`echo $line | sed 's/\(.*\)obj.value\(.*\)/\1/g'`
		obj_id=`echo $obj_id_temp | sed 's/\(.*\)"\(.*\)"\(.*\)/\2/g'`
		
		if [ "0x00000020" == $obj_id ];then
		    obj_value=`echo $line | sed 's/\(.*\)"\(.*\)"\(.*\)"\(.*\)"\(.*\)/\4/g'`
		    echo $line | sed 's/'\"$obj_value\"'/'\"$var_ProvisionCode\"'/g';
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
	if [ ! -f "$var_customize_file" ]
	then
		echo "ERROR::customize file is not existed."
		return 1
	fi
	return 0
}

# read data from customize file
HW_Script_ReadDataFromFile()
{
	read -r var_ssid var_wpa var_webadmin_pwd< $var_customize_file
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
	var_node_ssid=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
	var_node_wpa_pwd=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	var_web_pwd_node=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.2
	
	#set web user and password
	password_byte1=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 5)
	password_byte2=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 6 | cut -c 1-2)
	var_web_pwd=$password_byte1$password_byte2
	
	
	 
	 

	#set web info
	cfgtool set $var_default_ctree $var_web_pwd_node Password $var_webadmin_pwd
	if [ 0 -ne $? ]
	then
		echo "Failed to set common web password!"
		return 1
	fi	
	
	# set ssid 
	cfgtool set $var_default_ctree $var_node_ssid SSID $var_ssid
	if [ 0 -ne $? ]
	then
		echo "Failed to set common ssid name!"
		return 1
	fi

	# set wpa password
	cfgtool set $var_default_ctree $var_node_wpa_pwd PreSharedKey $var_wpa
	if [ 0 -ne $? ]
	then
		echo "Failed to set common ssid wap password!"
		return 1
	fi
	
		
	#encrypt var_default_ctree
	 
	 

	return 0
}

#
HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

#
HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

#
HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

#
HW_Set_ProvisionCode

echo "set spec info OK!"

exit 0

