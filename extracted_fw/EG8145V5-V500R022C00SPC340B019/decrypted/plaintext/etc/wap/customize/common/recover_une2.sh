#! /bin/sh

#定制命令
#customize.sh COMMON_WIFI XXX Web密码 SSID WPA密码

# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree=/var/hw_default_ctree.xml

var_pack_temp_dir=/bin/
var_batch_file=/tmp/batch_file

var_web_pwd=""
var_ssid=""
var_wpa="" 
var_wifi_ssid2=""
var_wifi_pwd2=""

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
	read -r var_web_pwd var_ssid var_wpa var_wifi_ssid2 var_wifi_pwd2 < $var_customize_file
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
	var_web_node=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.2
	var_node_ssid=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
	var_node_wpa_pwd=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	
	var_node_ssid2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5
	var_node_wpa_pwd2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5.PreSharedKey.PreSharedKeyInstance.1
	
	var_cli_pwd_node=InternetGatewayDevice.UserInterface.X_HW_CLIUserInfo.X_HW_CLIUserInfoInstance.1
	
	rm -rf $var_batch_file
	
	echo "set $var_web_node Password $var_web_pwd" >> $var_batch_file
	echo "set $var_node_ssid SSID $var_ssid" >> $var_batch_file
	echo "set $var_node_wpa_pwd PreSharedKey $var_wpa" >> $var_batch_file
	echo "set $var_node_ssid2 SSID $var_wifi_ssid2" >> $var_batch_file
	echo "set $var_node_wpa_pwd2 PreSharedKey $var_wifi_pwd2" >> $var_batch_file
	echo "set $var_cli_pwd_node Userpassword $var_web_pwd" >> $var_batch_file
	
	cfgtool batch $var_default_ctree $var_batch_file
	if [ 0 -ne $? ]
	then
		echo "Failed to set parameters!"
		rm -rf $var_batch_file
		return 1
	fi

	rm -rf $var_batch_file

	return
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

