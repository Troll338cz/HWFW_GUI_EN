#! /bin/sh

# 写入三个SSID的recover脚本，该脚本通过读取 /mnt/jffs2/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中

# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
CURRENT_DIR=$PWD
HW_WAP_TRUNK_ROOT=$CURRENT_DIR/..
HW_WAP_PLAT_ROOT=$HW_WAP_TRUNK_ROOT/WAP
var_default_ctree=/var/hw_default_ctree.xml
var_pack_temp_dir=/bin/
var_ssid1_pwd=""
var_ssid2_pwd=""
var_ssid3_pwd=""
var_ssid5_pwd=""
var_pppoe_un=""
var_pppoe_pwd=""

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
	
	#对于定制参数有修改的地区，要兼容以前的定制，保证合一包升级不会出现问题
	#R16C00S035之前定制：customize.sh COMMON PCCW4MAC SSID1密码 SSID2密码? SSID3密码 SSID5密码 pppoe用户名、pppoe密码 SSID1_MAC SSID5_MAC
	#R16C00S035之后定制: customize.sh COMMON PCCW4MAC SSID1密码 SSID5密码 pppoe用户名、pppoe密码 SSID1_MAC SSID5_MAC
	read -r var_tmp1_arg var_tmp2_arg var_tmp3_arg var_tmp4_arg var_tmp5_arg var_tmp6_arg var_tmp7_arg var_tmp8_arg < $var_customize_file
	if [ 0 -ne $? ]
	then
	    echo "Failed to read spec info!"
	    return 1
	fi
	
	#根据定制命令长度来判断，获取定制信息
	if [ "$var_tmp8_arg" == "" ]; then 
		var_ssid1_pwd=$var_tmp1_arg
		var_ssid5_pwd=$var_tmp2_arg
		var_pppoe_un=$var_tmp3_arg
		var_pppoe_pwd=$var_tmp4_arg
	else
		var_ssid1_pwd=$var_tmp1_arg
		var_ssid2_pwd=$var_tmp2_arg
		var_ssid3_pwd=$var_tmp3_arg
		var_ssid5_pwd=$var_tmp4_arg
		var_pppoe_un=$var_tmp5_arg
		var_pppoe_pwd=$var_tmp6_arg
	fi
	
	#如果定制参数不为空说明是用户输入,否则按照特定的格式自动生成
	if [ "$var_ssid1_pwd" == "" ] || [ "$var_ssid5_pwd" == "" ] \
	  || [ "$var_pppoe_un" == "" ] || [ "$var_pppoe_pwd" == "" ]
	then
		echo "Failed to read spec info!"
	    return 1
	fi
	return 0
}

# set customize data to file
HW_Script_SetDatToFile()
{ 
	var_node_wpa_pwd1=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	var_node_wpa_pwd2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.2.PreSharedKey.PreSharedKeyInstance.1
	var_node_wpa_pwd3=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.3.PreSharedKey.PreSharedKeyInstance.1
	var_node_wpa_pwd4=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.4.PreSharedKey.PreSharedKeyInstance.1
	
	var_node_wpa_pwd5=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5.PreSharedKey.PreSharedKeyInstance.1
	var_node_wpa_pwd6=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.6.PreSharedKey.PreSharedKeyInstance.1
	var_node_wpa_pwd7=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.7.PreSharedKey.PreSharedKeyInstance.1
	var_node_wpa_pwd8=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.8.PreSharedKey.PreSharedKeyInstance.1
	var_node_pppoe_wan=InternetGatewayDevice.WANDevice.WANDeviceInstance.1.WANConnectionDevice.WANConnectionDeviceInstance.2.WANPPPConnection.WANPPPConnectionInstance.1

  # decrypt var_default_ctree
  
	 

	# set ssid1_pwd ~ ssid4_pwd
	cfgtool set $var_default_ctree $var_node_wpa_pwd1 PreSharedKey $var_ssid1_pwd
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid1 password!"
	    return 1
	fi
	
	cfgtool set $var_default_ctree $var_node_wpa_pwd2 PreSharedKey $var_ssid1_pwd
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid2 password!"
	    return 1
	fi
	
	cfgtool set $var_default_ctree $var_node_wpa_pwd3 PreSharedKey $var_ssid1_pwd
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid3 password!"
	    return 1
	fi
	
	cfgtool set $var_default_ctree $var_node_wpa_pwd4 PreSharedKey $var_ssid1_pwd
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid4 password!"
	    return 1
	fi
	
	# set ssid5_pwd ~ ssid8_pwd
	cfgtool set $var_default_ctree $var_node_wpa_pwd5 PreSharedKey $var_ssid5_pwd
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid5 password!"
	    return 1
	fi
	
	cfgtool set $var_default_ctree $var_node_wpa_pwd6 PreSharedKey $var_ssid5_pwd
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid6 password!"
	    return 1
	fi
	
	cfgtool set $var_default_ctree $var_node_wpa_pwd7 PreSharedKey $var_ssid5_pwd
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid7 password!"
	    return 1
	fi
	
	cfgtool set $var_default_ctree $var_node_wpa_pwd8 PreSharedKey $var_ssid5_pwd
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common ssid8 password!"
	    return 1
	fi
	
	#set pppoe username
	cfgtool set $var_default_ctree $var_node_pppoe_wan Username $var_pppoe_un
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common pppoe wan name!"
	    return 1
	fi
	
	#set pppoe pwd
	cfgtool set $var_default_ctree $var_node_pppoe_wan Password $var_pppoe_pwd
	if [ 0 -ne $? ]
	then
	    echo "Failed to set common pppoe wan password!"
	    return 1
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

echo "set spec info OK!!"

exit 0