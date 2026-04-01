#! /bin/sh

var_customize_file=/var/customizepara.txt

var_default_ctree=/var/hw_default_ctree.xml

var_pack_temp_dir=/bin/

var_ssid1=""
var_wpa1=""

var_ssid2=""
var_wpa2=""
var_userPwd=""
var_adminPwd=""

#默认是不带wifi
var_has_wifi=0

#判断是否包含wifi
HW_Script_CheckHaveWIFI()
{	
	var_has_wifi=`cat /proc/wap_proc/pd_static_attr | grep -w wlan_num | grep -o \".*[0-9].*\" | grep -o "[0-9]"`  
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
	if [ $var_has_wifi -ne 0 ]
	then
		read -r var_ssid1 var_wpa1 var_ssid2 var_wpa2 var_userPwd var_adminPwd < $var_customize_file
		if [ 0 -ne $? ]
		then
			echo "Failed to read spec info!"
			return 1
		fi
	fi
	return
}

# set customize data to file
HW_Script_SetDatToFile()
{
	var_node_ssid1=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
	var_node_wpa_pwd1=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	
	var_node_ssid2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5
	var_node_wpa_pwd2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5.PreSharedKey.PreSharedKeyInstance.1
	var_node_userpassword=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.1
        var_node_adminpassword=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.2

	
	if [ $var_has_wifi -eq 0 ]
	then
		return
	fi
	
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
	
	# set web_userpassword
	cfgtool set $var_default_ctree $var_node_userpassword Password $var_userPwd
	if [ 0 -ne $? ]
	then
		echo "Failed to set common web user password!"
		return 1
	fi
    # set web_adminpassword
	cfgtool set $var_default_ctree $var_node_adminpassword Password $var_adminPwd
	if [ 0 -ne $? ]
	then
		echo "Failed to set common web user password!"
		return 1
	fi
		
	#encrypt var_default_ctree
	 
	 

	return
}

HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

HW_Script_CheckHaveWIFI

HW_Script_CheckHaveWIFI
[ ! $? == 0 ] && exit 1

HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

#
HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0

