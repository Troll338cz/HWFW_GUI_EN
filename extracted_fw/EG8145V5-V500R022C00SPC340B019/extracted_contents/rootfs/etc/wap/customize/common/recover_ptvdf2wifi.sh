#! /bin/sh

var_customize_file=/var/customizepara.txt
var_default_ctree_var=/var/hw_default_ctree.xml
var_default_ctree=/var/hw_default_ctree.xml
var_pack_temp_dir=/bin/

var_ssid=""
var_ssid1=""
var_ssid2=""
var_ssid3=""
var_ssid4=""
var_wpa="" 
var_ssid5g=""
var_ssid5=""
var_ssid6=""
var_ssid7=""
var_ssid8=""
var_wpa5g="" 
var_wpa2=""


#默认是不带wifi
var_has_wifi=0

#判断是否包含wifi
HW_Script_CheckHaveWIFI()
{	
	var_has_wifi=`cat /proc/wap_proc/pd_static_attr | grep -w wlan_num | grep -o \".*[0-9].*\" | grep -o "[0-9]"`  
}

HW_Script_CheckFileExist()
{
	if [ ! -f "$var_customize_file" ] ;then
	    echo "ERROR::customize file is not existed."
        return 1
	fi
	return 0
}

HW_Script_ReadDataFromFile()
{
	if [ $var_has_wifi -ne 0 ];then	
		read -r var_ssid1 var_ssid2 var_ssid3 var_ssid4 var_wpa var_ssid5 var_ssid6 var_ssid7 var_ssid8 var_wpa5g < $var_customize_file
		if [ 0 -ne $? ];then
			echo "Failed to read spec info!"
			return 1
		fi

		var_wpa2=$var_wpa
		if [ ! -z $var_wpa ];then
			var_ssid="$var_ssid1 $var_ssid2 $var_ssid3 $var_ssid4"
		else
			var_ssid=$var_ssid1
			var_wpa=$var_ssid2
		fi
		
		if [ ! -z $var_wpa5g ];then
			var_ssid5g="$var_ssid5 $var_ssid6 $var_ssid7 $var_ssid8"
		else
			if [ ! -z $var_wpa2 ];then
				var_ssid5g=$var_ssid5
				var_wpa5g=$var_ssid6
			else
				var_ssid5g=$var_ssid3
				var_wpa5g=$var_ssid4
			fi
		fi

		return
	fi
}

# set customize data to file
HW_Script_SetDatToFile()
{
	var_node_ssid=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
	var_node_wpa_pwd=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
    var_node_ssid_guest=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.2
	var_node_ssid5g=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5
	var_node_wpa_pwd5g=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5.PreSharedKey.PreSharedKeyInstance.1
    var_node_ssid5g_guest=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.6
	
	if [ $var_has_wifi -eq 0 ]
	then
		return
	fi

	if [ ! -z $var_wpa ];then
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
	fi
	
	if [ ! -z $var_wpa5g ];then
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
	fi

	return
}

#
HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

HW_Script_CheckHaveWIFI

HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0




