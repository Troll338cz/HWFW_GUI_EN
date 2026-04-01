#! /bin/sh

var_customize_path=/etc/wap/customize
#add by guotao 20161116 ,设置ap模式切换标识到boardinfo
var_boardinfo_dup="/var/dup_boardinfo"
ap_support_mode_id=`cat $var_boardinfo_dup |grep "0x00000042"`
var_customize_file=/var/customizepara.txt
var_pack_temp_dir=/bin/
var_default_ctree=/var/hw_default_ctree.xml
var_jffs2_customize_txt_file="/mnt/jffs2/customize.txt"

var_ssid1=""
var_wpa1=""

var_ssid2=""
var_wpa2=""

var_userPwd=""

#若boardinfo文件里不存在模式切换的id，则向boardinfo文件新增
if [ -z "$ap_support_mode_id" ]
then
	echo "obj.id = \"0x00000042\" ; obj.value = \"0\";" >> $var_boardinfo_dup
fi

var_upport="0x0030400"`cat /proc/wap_proc/pd_static_attr | grep ssid_num | awk -F "\"" '{print $2}'`
var_eth="0x0000000"`cat /proc/wap_proc/pd_static_attr | grep eth_num | awk -F "\"" '{print $2}'`

echo $var_boardinfo_dup| xargs sed 's/obj.id = \"0x00000001\" ; obj.value = \"[a-zA-Z0-9_-]*\"/obj.id = \"0x00000001\" ; obj.value = \"8\"/g' -i
echo $var_boardinfo_dup| xargs sed 's/obj.id = \"0x00000039\" ; obj.value = \"[a-zA-Z0-9_-]*\"/obj.id = \"0x00000039\" ; obj.value = \"'$var_upport'\"/g' -i
echo $var_boardinfo_dup| xargs sed 's/obj.id = \"0x0000003c\" ; obj.value = \"[a-zA-Z0-9_-]*\"/obj.id = \"0x0000003c\" ; obj.value = \"'$var_eth'\"/g' -i
echo $var_boardinfo_dup| xargs sed 's/obj.id = \"0x00000042\" ; obj.value = \"[a-zA-Z0-9_-]*\"/obj.id = \"0x00000042\" ; obj.value = \"3\"/g' -i

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
	read -r var_ssid1 var_wpa1 var_ssid2 var_wpa2 var_userPwd < $var_customize_file
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
	
	var_node_ssid2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5
	var_node_wpa_pwd2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5.PreSharedKey.PreSharedKeyInstance.1
	
	var_node_web_pwd=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.1

 
	
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

	# set web user password
	cfgtool set $var_default_ctree $var_node_web_pwd Password $var_userPwd
	if [ 0 -ne $? ]
	then
		echo "Failed to set common web password!"
		return 1
	fi

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



