#! /bin/sh

# 写入一个SSID的recover脚本，该脚本通过读取 /var/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中

# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
CURRENT_DIR=$PWD
HW_WAP_TRUNK_ROOT=$CURRENT_DIR/..
HW_WAP_PLAT_ROOT=$HW_WAP_TRUNK_ROOT/WAP
var_default_ctree=/var/hw_default_ctree.xml
var_boardinfo_dup="/var/dup_boardinfo"
var_pack_temp_dir=/bin/
var_specsn=""

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
	read -r var_ssid var_wpa var_web_passwd < $var_customize_file
	if [ 0 -ne $? ]
	then
	    echo "Failed to read spec info!"
	    return 1
	fi
	return
}

# get ont SN
HW_Script_GetONTSN()
{
	while read line;
	do
		obj_id_temp=`echo $line | sed 's/\(.*\)obj.value\(.*\)/\1/g'`
		obj_id=`echo $obj_id_temp | sed 's/\(.*\)"\(.*\)"\(.*\)/\2/g'`
		if [ "0x00000002" == $obj_id ];then
		    obj_value=`echo $line | sed 's/\(.*\)"\(.*\)"\(.*\)"\(.*\)"\(.*\)/\4/g'`
			var_specsn=$obj_value
			break
		fi
	done < $var_boardinfo_dup
	
	if [ $var_specsn == "" ]
	then
		echo "ERROR::Failed to get cur_sn info!"
		exit 1
	fi
	return
}

# set customize data to file
HW_Script_SetDatToFile()
{
	var_node_ssid=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
	var_node_wpa_pwd=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	var_node_ont_webuser=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.1
	var_node_third_webuser=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.3
	var_node_custom_info=InternetGatewayDevice.X_HW_ProductInfo
        # decrypt var_default_ctree
        
	 
	 

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
	
	# set ont_username 
	cfgtool set $var_default_ctree $var_node_ont_webuser UserName $var_specsn
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ONT username!"
	    return 1
	fi

	# set ont_userpassword
	cfgtool set $var_default_ctree $var_node_ont_webuser Password $var_specsn
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ONT user password!"
	    return 1
	fi
	
	#set ont web third user password
	if [ ! -z $var_web_passwd ];then
		cfgtool find $var_default_ctree $var_node_third_webuser  
		if [ 0 -eq $? ]; then
			cfgtool set $var_default_ctree $var_node_third_webuser Password $var_web_passwd
			if [ 0 -ne $? ]
			then
				echo "Failed to set third webuser password!"
				return 1
			fi
		fi
	fi
	
	#encrypt var_default_ctree
	 
	 
	
	return
}

#
HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

#
HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

#
HW_Script_GetONTSN
[ ! $? == 0 ] && exit 1

#
HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0

