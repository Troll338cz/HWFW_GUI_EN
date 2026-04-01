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

var_ssid=""
var_wpa="" 
var_webadmin_pwd=""
var_ssid_5g=""
var_wpa_5g="" 
var_cli2pwd=""

HW_Script_Cli2Pwd()
{
	#调用ontinfo工具获取产品类型
	var_boardtype=`ontinfo -s -b`
	var_len=${#var_boardtype}
	let var_len=var_len-1
	var_boardtype=`expr substr $var_boardtype 1 $var_len`
	var_cli2pwdpre=`GetSpec SPEC_TRIPLET_CLI_PWD`
	var_cli2pwd=$var_cli2pwdpre"{"$var_boardtype"}"
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
	read -r var_ssid var_wpa var_ssid_5g var_wpa_5g var_webadmin_pwd< $var_customize_file
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
	var_cli_pwd_node=InternetGatewayDevice.UserInterface.X_HW_CLIUserInfo.X_HW_CLIUserInfoInstance.1
	var_node_ssid5g=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5
	var_node_wpa_pwd5g=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5.PreSharedKey.PreSharedKeyInstance.1
    var_cli_pwd_node2=InternetGatewayDevice.UserInterface.X_HW_CLIUserInfo.X_HW_CLIUserInfoInstance.2
	var_web_normal=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.1
	
	#set web user and password
	password_byte1=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 5)
	password_byte2=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 6 | cut -c 1-2)
	var_web_pwd=$password_byte1$password_byte2
	
	
	 

	if [ -n "$var_ssid" ] ; then
		#set web info
		cfgtool set $var_default_ctree $var_web_pwd_node Password $var_webadmin_pwd
		if [ 0 -ne $? ]
		then
			echo "Failed to set common web password!"
			return 1
		fi

		#set cli pwd
		cfgtool set $var_default_ctree $var_cli_pwd_node Userpassword $var_webadmin_pwd
		if [ 0 -ne $? ]
		then
			echo "Failed to set common cli password!"
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

		#set ssid-5G
		cfgtool find $var_default_ctree $var_node_ssid5g
		if [ 0 -eq $? ]
		then
			cfgtool set $var_default_ctree $var_node_ssid5g SSID $var_ssid_5g
			if [ 0 -ne $? ]
			then
			echo "Failed to set ssid2 name!"
			exit 1
			fi

			#set wpa password 2
			cfgtool set $var_default_ctree $var_node_wpa_pwd5g PreSharedKey $var_wpa_5g
			if [ 0 -ne $? ]
			then
			echo "Failed to set ssid2 wpa password!"
			exit 1
			fi
		fi
	else
		#set web info
		cfgtool set $var_default_ctree $var_web_pwd_node Password $var_web_pwd
		if [ 0 -ne $? ]
		then
			echo "ERROR::Failed to set common web password!"
			return 1
		fi
		
		#set cli pwd
		cfgtool set $var_default_ctree $var_cli_pwd_node Userpassword $var_web_pwd
		if [ 0 -ne $? ]
		then
			echo "Failed to set common cli password!"
			return 1
		fi	
	fi	
	
	HW_Script_Cli2Pwd	
	cfgtool find $var_default_ctree $var_cli_pwd_node2
	if [ 0 -eq $? ]
	then
		cfgtool set $var_default_ctree $var_cli_pwd_node2 Userpassword $var_cli2pwd
		
		cfgtool gettofile $var_default_ctree $var_cli_pwd_node2 EncryptMode
		if [ 0 -eq $? ]
		then
			cfgtool set $var_default_ctree $var_cli_pwd_node2 EncryptMode "3"
		else
			cfgtool add $var_default_ctree $var_cli_pwd_node2 EncryptMode "3"
		fi
	fi
	
	cfgtool find $var_default_ctree $var_web_normal
	if [ 0 -eq $? ]
	then
		cfgtool set $var_default_ctree $var_web_normal Password $var_cli2pwd
	fi

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

echo "set spec info OK!"

exit 0

