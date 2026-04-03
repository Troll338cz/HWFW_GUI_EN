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
var_batch_file=/tmp/batch_file
var_default_ctree2=/var/hw_default_ctree2.xml

var_ssid1=""
var_wpa1=""

var_ssid2=""
var_wpa2=""
var_userPwd=""
var_adminPwd=""

var_acsname=""
var_acspwd=""
var_cpename=""
var_cpepwd=""

#默认是不带wifi
var_has_wifi=0

HW_Script_Cfgtool_Set()
{      
	echo "set $2 $3 $4" >> $var_batch_file   
}
HW_Script_Cfg_Add_Clone()
{
	#当前实例可能被删除了，在此做一下判断
	cfgtool find $1 $2        
	if [ 0 -ne $? ]
	then		     
		cfgtool add $1 $2 "NULL"
		if [ 0 -ne $? ]
		then
			echo "add $2 fail" 
		fi
	fi
	
	if [ -f $3 ]
    then
        cfgtool clone $1 $2 $3
		if [ 0 -ne $? ]
		then
			echo "Failed to clone" $2 
		fi          
    else
        echo "$3 not exist !" 
    fi 
}

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
		read -r var_ssid1 var_wpa1 var_ssid2 var_wpa2 var_userPwd var_adminPwd var_acsname var_acspwd var_cpename var_cpepwd< $var_customize_file
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

	var_node_acs=InternetGatewayDevice.ManagementServer

	if [ $var_has_wifi -eq 0 ]
	then
		return
	fi

    HW_Script_Cfgtool_Set $var_default_ctree $var_node_ssid1 "SSID" $var_ssid1
    HW_Script_Cfgtool_Set $var_default_ctree $var_node_ssid2 "SSID" $var_ssid2
    HW_Script_Cfgtool_Set $var_default_ctree $var_node_wpa_pwd1 "PreSharedKey" $var_wpa1
    HW_Script_Cfgtool_Set $var_default_ctree $var_node_wpa_pwd2 "PreSharedKey" $var_wpa2
    HW_Script_Cfgtool_Set $var_default_ctree $var_node_userpassword "Password" $var_userPwd
    HW_Script_Cfgtool_Set $var_default_ctree $var_node_adminpassword "Password" $var_adminPwd
			
	cfgtool batch $var_default_ctree $var_batch_file
	if [ 0 -ne $? ]
	then
		echo "Failed to set parameters!"
		rm -rf $var_batch_file
		return 1
	fi
	
	rm -rf $var_batch_file
		

	# decrypt var_default_ctree2
	
	

	HW_Script_Cfgtool_Set $var_default_ctree2 $var_node_ssid1 "SSID" $var_ssid1
	HW_Script_Cfgtool_Set $var_default_ctree2 $var_node_ssid2 "SSID" $var_ssid2
	HW_Script_Cfgtool_Set $var_default_ctree2 $var_node_wpa_pwd1 "PreSharedKey" $var_wpa1
	HW_Script_Cfgtool_Set $var_default_ctree2 $var_node_wpa_pwd2 "PreSharedKey" $var_wpa2
	HW_Script_Cfgtool_Set $var_default_ctree2 $var_node_adminpassword "Password" $var_userPwd
    if [ ! -z $var_acsname ]
    then
        HW_Script_Cfgtool_Set $var_default_ctree2 $var_node_acs "Username" $var_acsname
        HW_Script_Cfgtool_Set $var_default_ctree2 $var_node_acs "Password" $var_acspwd
        HW_Script_Cfgtool_Set $var_default_ctree2 $var_node_acs "ConnectionRequestUsername" $var_cpename
        HW_Script_Cfgtool_Set $var_default_ctree2 $var_node_acs "ConnectionRequestPassword" $var_cpepwd
    fi

	cfgtool batch $var_default_ctree2 $var_batch_file
	if [ 0 -ne $? ]
	then
		echo "Failed to set parameters!"
		return 1
	fi
	
	rm -rf $var_batch_file
		
	#encrypt var_default_ctree2
	
	
	return
}

#
HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

#检查是否包含wifi
HW_Script_CheckHaveWIFI

#
HW_Script_CheckHaveWIFI
[ ! $? == 0 ] && exit 1

#
HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

#
HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0
