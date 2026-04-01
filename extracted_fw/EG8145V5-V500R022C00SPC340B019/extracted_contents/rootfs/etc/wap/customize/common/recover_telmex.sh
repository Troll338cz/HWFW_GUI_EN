#! /bin/sh

#Telmex定制命令
#customize.sh COMMON TELMEX WIFI用户名 WIFI密码 PPPOE用户名 PPPOE密码 TR069用户名 TR069密码  WEB密码
# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree=/var/hw_default_ctree.xml

var_boardinfo_dup="/var/dup_boardinfo"
var_boardinfo_dup_tmp="/var/dup_boardinfo_tmp"

var_pack_temp_dir=/bin/

var_wifi_unm=""
var_wifi_pwd=""
var_wpa_pwd=""
var_pppoe_unm=""
var_pppoe_pwd=""
var_tms_unm=""
var_tms_pwd=""
var_web_unm="TELMEX" #Web用户名不作参数传入, 使用默认值TELMEX
var_web_pwd=""
var_ProvisionCode="Telmex"
var_cli_name="" 
var_cli_pwd=""
var_batch_file=/tmp/batch_file 

HW_Check_Boardinfo()
{
	if [ -f $var_boardinfo_dup ]; then
		return 0;
	else
		echo "ERROR::$var_boardinfo_dup is not exist!"
		return 1;
	fi		
}

HW_Set_ProvisionCode()
{
    #ProvisionCode的ID为0x00000020
    #检查boardinfo是否存在
    HW_Check_Boardinfo
	if [ ! $? == 0 ]
	then
		echo "ERROR::Failed to Check Boardinfo!"
		return 1
	fi

	cat $var_boardinfo_dup | while read -r line;
	do
		obj_id_temp=`echo $line | sed 's/\(.*\)obj.value\(.*\)/\1/g'`
		obj_id=`echo $obj_id_temp | sed 's/\(.*\)"\(.*\)"\(.*\)/\2/g'`
		
		if [ "0x00000020" == $obj_id ];then
		    obj_value=`echo $line | sed 's/\(.*\)"\(.*\)"\(.*\)"\(.*\)"\(.*\)/\4/g'`
		    echo $line | sed 's/'\"$obj_value\"'/'\"$var_ProvisionCode\"'/g';
		else
		    echo -E $line
		fi
	done  > $var_boardinfo_dup_tmp

	mv -f $var_boardinfo_dup_tmp $var_boardinfo_dup

	return 0
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
	#和海星、胡淑宝确认了，telmex定制还是使用TELMEX定制特征字，保持不变，定制参数为9个，不用兼容原来的5个，7个，格式如下：
	#customize.sh COMMON TELMEX SSID WEP_KEY PPPoE_username PPPoE_password TR069用户名 TR069密码 WEB密码 CLI用户名 CLI密码	
	read -r var_wifi_unm var_wifi_pwd var_pppoe_unm var_pppoe_pwd var_tms_unm var_tms_pwd var_web_pwd var_cli_name var_cli_pwd var_wpa_pwd< $var_customize_file
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
	var_wifi_unm_node=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
	var_wifi_pwd_node=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	var_wifi_wep_pwd1=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.WEPKey.WEPKeyInstance.1
	var_wifi_wep_pwd2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.WEPKey.WEPKeyInstance.2
	var_wifi_wep_pwd3=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.WEPKey.WEPKeyInstance.3
	var_wifi_wep_pwd4=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.WEPKey.WEPKeyInstance.4
	var_pppoe_node=InternetGatewayDevice.WANDevice.WANDeviceInstance.1.WANConnectionDevice.WANConnectionDeviceInstance.1.WANPPPConnection.WANPPPConnectionInstance.1
	var_tms_node=InternetGatewayDevice.ManagementServer
	var_web_node=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.2 
	var_cli_node=InternetGatewayDevice.UserInterface.X_HW_CLIUserInfo.X_HW_CLIUserInfoInstance.1 
	
	var_wifi_node=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance
	
	#set wifi info
	# decrypt var_default_ctree
    
	 

	rm -rf $var_batch_file

	if [ -z $var_wpa_pwd ]
	then
		var_wpa_pwd=$var_wifi_pwd
	fi
	
	echo "set $var_wifi_unm_node SSID $var_wifi_unm" >> $var_batch_file
	echo "set $var_wifi_pwd_node PreSharedKey $var_wpa_pwd" >> $var_batch_file
	echo "set $var_wifi_wep_pwd1 WEPKey $var_wifi_pwd" >> $var_batch_file
	echo "set $var_wifi_wep_pwd2 WEPKey $var_wifi_pwd" >> $var_batch_file
	echo "set $var_wifi_wep_pwd3 WEPKey $var_wifi_pwd" >> $var_batch_file
	echo "set $var_wifi_wep_pwd4 WEPKey $var_wifi_pwd" >> $var_batch_file
	echo "set $var_pppoe_node Username $var_pppoe_unm" >> $var_batch_file
	echo "set $var_pppoe_node Password $var_pppoe_pwd" >> $var_batch_file
	echo "set $var_tms_node Username $var_tms_unm" >> $var_batch_file
	echo "set $var_tms_node Password $var_tms_pwd" >> $var_batch_file
	echo "set $var_web_node Password $var_web_pwd" >> $var_batch_file
	if [ ! -z $var_cli_name ]
	then
		echo "set $var_cli_node Username $var_cli_name" >> $var_batch_file
	fi	
	
	iCounter=1
	while [ $iCounter -lt 5 ]
	do
		var_wifi_unm_tmp=$var_wifi_unm
		
		if [ $iCounter -ne 1 ]
		then
			var_wifi_unm_tmp=$var_wifi_unm"_"$iCounter
		fi
		
		echo "set $var_wifi_node.$iCounter SSID $var_wifi_unm_tmp" >> $var_batch_file
		echo "set $var_wifi_node.$iCounter.PreSharedKey.PreSharedKeyInstance.1 PreSharedKey $var_wpa_pwd" >> $var_batch_file
		echo "set $var_wifi_node.$iCounter.WEPKey.WEPKeyInstance.1 WEPKey $var_wifi_pwd" >> $var_batch_file
		echo "set $var_wifi_node.$iCounter.WEPKey.WEPKeyInstance.2 WEPKey $var_wifi_pwd" >> $var_batch_file
		echo "set $var_wifi_node.$iCounter.WEPKey.WEPKeyInstance.3 WEPKey $var_wifi_pwd" >> $var_batch_file
		echo "set $var_wifi_node.$iCounter.WEPKey.WEPKeyInstance.4 WEPKey $var_wifi_pwd" >> $var_batch_file
	
		iCounter=`expr $iCounter + 1`
	done

	cfgtool batch $var_default_ctree $var_batch_file
	if [ 0 -ne $? ]
	then
		echo "Failed to set parameters!"
		rm -rf $var_batch_file
		return 1
	fi

	rm -rf $var_batch_file	
	
	if [ ! -z $var_cli_pwd ]
	then
		cfgtool set $var_default_ctree $var_cli_node Userpassword $var_cli_pwd
		if [ 0 -ne $? ]
		then
			echo "Failed to set common cli password!"
			return 1
		fi	
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

#
HW_Set_ProvisionCode

echo "set spec info OK!!"

exit 0