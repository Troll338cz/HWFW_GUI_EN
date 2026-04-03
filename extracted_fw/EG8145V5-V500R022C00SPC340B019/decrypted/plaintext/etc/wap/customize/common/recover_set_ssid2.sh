#! /bin/sh

# 写入一个SSID的recover脚本，该脚本通过读取 /var/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中
#customize.sh COMMON_WIFI XXX SSID WPA密码
# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree_var=/var/hw_default_ctree.xml
var_default_ctree=/var/hw_default_ctree.xml
var_pack_temp_dir=/bin/

var_ssid=""
var_wpa="" 
var_para=""
var_web_pwd=""
var_web_passwd_len=8
var_support_secure_feature=`GetFeature FT_SECURITY_ACCESS`
var_webUserPre=`GetSpec SPEC_WEB_USER_PRE`
var_ebg_flag=$1

cli_olt_modifyFlag=1

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
	#有wifi才需要读
	if [ $var_has_wifi -ne 0 ]
	then	
		read -r var_para < $var_customize_file
		echo $var_para | grep \" > /dev/null	
		if [ $? == 0 ]
		then
			var_ssid=`echo $var_para | cut -d \" -f2 `
			len=`expr length "\"$var_ssid\"  "`
			var_wpa=`echo $var_para | cut -b $len-`
		else
			read -r var_ssid var_wpa var_web_pwd < $var_customize_file
		fi 
		
		if [ 0 -ne $? ]
		then
			echo "Failed to read spec info!"
			return 1
		fi
		return
	fi
}

# set customize data to file
HW_Script_SetDatToFile()
{
	var_node_ssid=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
	var_node_wpa_pwd=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	var_node_web_pwd=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.1
	var_node_admin_web_pwd=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.2
	var_node_cli_olt=InternetGatewayDevice.UserInterface.X_HW_CLIUserInfo.X_HW_CLIUserInfoInstance.2
	
	if [ $var_has_wifi -eq 0 ]
	then
		return
	fi

	#判断密码即可
	if [ ! -z $var_wpa ]
	then
		# set ssid 
		cfgtool set $var_default_ctree_var $var_node_ssid SSID "$var_ssid"
		if [ 0 -ne $? ]
		then
		    echo "Failed to set common ssid name!"
		    return 1
		fi

		# set wpa password
		cfgtool set $var_default_ctree_var $var_node_wpa_pwd PreSharedKey "$var_wpa"
		if [ 0 -ne $? ]
		then
		    echo "Failed to set common ssid wap password!"
		    return 1
		fi
	fi

	#设置普通web用户的密码
	cfgtool set $var_default_ctree_var $var_node_web_pwd Password $var_web_pwd
	if [ 0 -ne $? ]
	then
		echo "Failed to set web common user password!"
		return 1
	fi

    #如果开启了FT_SECURITY_ACCESS，将普通用户的随机密码写到管理员用户
    if [ $var_support_secure_feature = 1 ]; then
        if [ "$var_ebg_flag" != "1" ]; then
            var_admin_pwd=$var_webUserPre$var_web_pwd
            cfgtool set $var_default_ctree_var $var_node_admin_web_pwd Password $var_admin_pwd
            if [ 0 -ne $? ]
            then
                echo "Failed to set web admin user password!"
                return 1
            fi

            #设置管理员用户出厂密码，没有就新增
            cfgtool gettofile $var_default_ctree_var $var_node_admin_web_pwd "FactoryPassword"
            if [ 0 -eq $? ]
            then
                cfgtool set $var_default_ctree_var $var_node_admin_web_pwd "FactoryPassword" $var_admin_pwd
            else
                cfgtool add $var_default_ctree_var $var_node_admin_web_pwd "FactoryPassword" $var_admin_pwd
            fi
        fi

		cfgtool gettofile $var_default_ctree_var $var_node_cli_olt "ModifyPWDFlag"
		if [ 0 -eq $? ]
		then
			cfgtool set $var_default_ctree_var $var_node_cli_olt "ModifyPWDFlag" $cli_olt_modifyFlag
		fi
	fi

	#设置普通用户出厂密码，没有就新增
	cfgtool gettofile $var_default_ctree_var $var_node_web_pwd "FactoryPassword"
	if [ 0 -eq $? ]
	then
		cfgtool set $var_default_ctree_var $var_node_web_pwd "FactoryPassword" $var_web_pwd
	else
		cfgtool add $var_default_ctree_var $var_node_web_pwd "FactoryPassword" $var_web_pwd
	fi

	return
}

#校验web密码的长度
HW_Script_CheckWebPasswd()
{
	if [ ${#var_web_pwd} -ne $var_web_passwd_len ]
	then
		echo "The length of web password is not eight"
		return 1
	fi
	return
}

#
HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

#检查是否包含wifi
HW_Script_CheckHaveWIFI

#读取定制参数
HW_Script_ReadDataFromFile
[ ! $? == 0 ] && exit 1

HW_Script_CheckWebPasswd
[ ! $? == 0 ] && exit 1

#
HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0
