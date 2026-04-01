#! /bin/sh

var_customize_file=/var/customizepara.txt

var_default_ctree_var=/var/hw_default_ctree.xml
var_default_ctree=/var/hw_default_ctree.xml
var_pack_temp_dir=/bin/

var_ssid=""
var_wpa="" 
var_ssid5g=""
var_wpa5g="" 
var_userPwd=""


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
	read -r var_ssid var_wpa var_ssid5g var_wpa5g var_userPwd < $var_customize_file
	if [ 0 -ne $? ];then
		echo "Failed to read spec info!"
		return 1
	fi
	return
}

# set customize data to file
HW_Script_SetDatToFile()
{
	var_node_ssid=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
    var_node_ssid_guest=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.2
	var_node_wpa_pwd=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	var_node_ssid5g=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5
    var_node_ssid5g_guest=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.6
	var_node_wpa_pwd5g=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5.PreSharedKey.PreSharedKeyInstance.1
	
	var_node_userpassword=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.1

	cfgtool set $var_default_ctree_var $var_node_ssid SSID "$var_ssid"
	if [ 0 -ne $? ];then
		echo "Failed to set common ssid name!"
		return 1
	fi

    cfgtool set $var_default_ctree_var $var_node_ssid_guest SSID "$var_ssid"-Guest
    if [ 0 -ne $? ];then
        echo "Failed to set common guest ssid name!"
        return 1
    fi

	cfgtool set $var_default_ctree_var $var_node_wpa_pwd PreSharedKey "$var_wpa"
	if [ 0 -ne $? ];then
		echo "Failed to set common ssid wap password!"
		return 1
	fi

	cfgtool set $var_default_ctree_var $var_node_ssid5g SSID "$var_ssid5g"
	if [ 0 -ne $? ];then
		echo "Failed to set common 5g ssid name!"
		return 1
	fi

    cfgtool set $var_default_ctree_var $var_node_ssid5g_guest SSID "$var_ssid5g"-Guest
    if [ 0 -ne $? ];then
        echo "Failed to set common 5g guest ssid name!"
        return 1
    fi

	cfgtool set $var_default_ctree_var $var_node_wpa_pwd5g PreSharedKey "$var_wpa5g"
	if [ 0 -ne $? ];then
		echo "Failed to set common 5g ssid wap password!"
		return 1
	fi
	
	cfgtool set $var_default_ctree_var $var_node_userpassword Password "$var_userPwd"
	if [ 0 -ne $? ]
	then
		echo "Failed to set  ONT password!"
		return 1
	fi

	#设置普通用户出厂密码，没有就新增
	cfgtool gettofile $var_default_ctree_var $var_node_userpassword "FactoryPassword"
	if [ 0 -eq $? ]
	then
		cfgtool set $var_default_ctree_var $var_node_userpassword "FactoryPassword" $var_userPwd
	else
		cfgtool add $var_default_ctree_var $var_node_userpassword "FactoryPassword" $var_userPwd
	fi

	return
}


HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0




