#! /bin/sh

# 写入一个SSID的recover脚本，该脚本通过读取 /var/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中

# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree=/var/hw_default_ctree.xml
var_specsn=""
var_userPwd=""
var_ssid=""
var_wpa=""
var_ssid5=""
var_wpa5="" 

var_pack_temp_dir=/bin/
var_batch_file=/tmp/batch_file
var_boardinfo_dup="/var/dup_boardinfo"

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
	read -r var_ssid var_wpa var_ssid5 var_wpa5 var_pppoe_unm var_pppoe_pwd < $var_customize_file
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
	var_node_ssid5=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5
	var_node_wpa_pwd5=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5.PreSharedKey.PreSharedKeyInstance.1	
	var_pppoe_node=InternetGatewayDevice.WANDevice.WANDeviceInstance.1.WANConnectionDevice.WANConnectionDeviceInstance.1.WANPPPConnection.WANPPPConnectionInstance.1
	var_tms_node=InternetGatewayDevice.ManagementServer
	
	password_byte1=$(cat $var_boardinfo_dup | grep 0x0000000f | tr A-Z a-z | cut -d "\"" -f 4 | cut -d ":" -f 1)
	password_byte2=$(cat $var_boardinfo_dup | grep 0x0000000f | tr A-Z a-z | cut -d "\"" -f 4 | cut -d ":" -f 2)
	password_byte3=$(cat $var_boardinfo_dup | grep 0x0000000f | tr A-Z a-z | cut -d "\"" -f 4 | cut -d ":" -f 3)
	password_byte4=$(cat $var_boardinfo_dup | grep 0x0000000f | tr A-Z a-z | cut -d "\"" -f 4 | cut -d ":" -f 4)
	password_byte5=$(cat $var_boardinfo_dup | grep 0x0000000f | tr A-Z a-z | cut -d "\"" -f 4 | cut -d ":" -f 5)
	password_byte6=$(cat $var_boardinfo_dup | grep 0x0000000f | tr A-Z a-z | cut -d "\"" -f 4 | cut -d ":" -f 6)
	var_acs_username=$password_byte1$password_byte2$password_byte3"-"$password_byte4$password_byte5$password_byte6

    # decrypt var_default_ctree
    
	 
	
	rm -rf $var_batch_file
	
	# set ssid2 
	echo "set $var_node_ssid SSID $var_ssid" >> $var_batch_file

	# set wpa password2
	echo "set $var_node_wpa_pwd PreSharedKey $var_wpa" >> $var_batch_file
	
	# set ssid5 
	echo "set $var_node_ssid5 SSID $var_ssid5" >> $var_batch_file

	# set wpa password5
	echo "set $var_node_wpa_pwd5 PreSharedKey $var_wpa5" >> $var_batch_file
	
	echo "set $var_pppoe_node Username $var_pppoe_unm" >> $var_batch_file
	
	echo "set $var_pppoe_node Password $var_pppoe_pwd" >> $var_batch_file
	
	echo "set $var_tms_node Username $var_acs_username" >> $var_batch_file
		
	cfgtool batch $var_default_ctree $var_batch_file
	if [ 0 -ne $? ]
	then
	    echo "set spec info Fail!"
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

