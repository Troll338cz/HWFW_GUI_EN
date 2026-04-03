#! /bin/sh

# 写入一个SSID的recover脚本，该脚本通过读取 /var/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中
#customize.sh COMMON_WIFI XXX SSID WPA密码
# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree=/var/hw_default_ctree.xml

var_pack_temp_dir=/bin/

var_boardinfo_dup="/var/dup_boardinfo"
var_boardinfo_dup_tmp="/var/dup_boardinfo_tmp"

var_ssid1=""
var_wpa1=""

var_ssid2=""
var_wpa2=""

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
		read -r var_ssid1 var_wpa1 var_ssid2 var_wpa2 < $var_customize_file
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
		
	#encrypt var_default_ctree
	 
	 

	return
}

HW_Set_GPON_SN_Passwd()
{
	if [ ! -f $var_boardinfo_dup ]
	then
        echo "ERROR::no hw_boardinfo"
		return;
	fi
	
	password_byte1=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 1 | cut -d "\"" -f 4)
	password_byte2=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 2)
	password_byte3=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 3)
	password_byte4=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 4)
	password_byte5=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 5)
	password_byte6=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 6 | cut -c 1-2)
	var_sn_pwd=$password_byte1$password_byte2$password_byte3$password_byte4$password_byte5$password_byte6
	
	cat $var_boardinfo_dup | while read -r line;
	do
		obj_id_temp=`echo $line | sed 's/\(.*\)obj.value\(.*\)/\1/g'`
		obj_id=`echo $obj_id_temp | sed 's/\(.*\)"\(.*\)"\(.*\)/\2/g'`
		if [ "0x00000003" == $obj_id ] ;then
		    echo "obj.id = \"0x00000003\" ; obj.value = \"\";"
		else
			if [ "0x00000004" == $obj_id ] ;then
				echo "obj.id = \"0x00000004\" ; obj.value = \"$var_sn_pwd\";"
			else
				echo -E $line
			fi
		fi
		
	done  > $var_boardinfo_dup_tmp

	mv -f $var_boardinfo_dup_tmp $var_boardinfo_dup
	
	return 0
}

#
HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

#检查是否包含wifi
HW_Script_CheckHaveWIFI

#
HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

#
HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

#
HW_Set_GPON_SN_Passwd
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0

