#! /bin/sh

# 写入一个SSID的recover脚本，该脚本通过读取 /var/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中

# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt
var_pack_temp_dir=/bin/

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree=/var/hw_default_ctree.xml
var_jffs2_customize_txt_file="/mnt/jffs2/customize.txt"
var_batch_file=/tmp/batch_file

var_userPwd=""
var_ssid=""
var_wpa=""
var_OperatorId="CTC"
fttr_spt=`GetFeature FT_FTTR_MAIN_ONT`

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
	read -r var_userPwd var_ssid var_wpa < $var_customize_file
    if [ 0 -ne $? ]
    then
        echo "Failed to read spec info!"
        return 1
    fi
    return
}

HW_Script_GetOperatorIdByBinCfgKey()
{
	var_g_Binword=""
	var_g_Cfgword=""
	var_jffs2_customize_key_file="/mnt/jffs2/customize.txt"
	#如果不存在"/mnt/jffs2/customize.txt"文件则直接返回
    if [ ! -f "$var_jffs2_customize_key_file" ]
    then
		var_OperatorId="CTC"
        return
    fi
    read var_g_Binword var_g_Cfgword < $var_jffs2_customize_key_file
    if [ 0 -ne $? ]
    then
		var_OperatorId="CTC"
        return
    fi
	
	binkey_upcase=$(echo $var_g_Binword | tr '[a-z]' '[A-Z]')
	cfgkey_upcase=$(echo $var_g_Cfgword | tr '[a-z]' '[A-Z]')
	var_CTkeycfg=$(expr match "$cfgkey_upcase" '.*\(SHTELECOM\).*')
	var_CMCCkeycfg=$(expr match "$cfgkey_upcase" '.*\(CMCC\).*')
	var_CUkeycfg=$(expr match "$cfgkey_upcase" '.*\(CU\).*')
	var_UNICOMkeycfg=$(expr match "$cfgkey_upcase" '.*\(UNICOM\).*')
	
	if [ "E8C" == "$binkey_upcase" ] || [ "E8C" == "$cfgkey_upcase" ] || [ "SHTELECOM" == "$var_CTkeycfg" ];then
		var_OperatorId="CTC"
	elif [ "CMCC" == "$binkey_upcase" ] || [ "CMCC" == "$var_CMCCkeycfg" ];then
		var_OperatorId="CMCC"
	elif [ "UNICOM" == "$binkey_upcase" ] || [ "$var_UNICOMkeycfg" == "UNICOM" ] || [ "$var_CUkeycfg" == "CU" ];then
		var_OperatorId="CUC"
	else
		var_OperatorId="CTC"
	fi
	
	return
}


HW_Script_SetVoiceDatToFile()
{
	var_nod_ssmppdt=InternetGatewayDevice.X_HW_SSMPPDT
	var_nod_deviceinfo=InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo

	var_voice_type="0"
	
	#如果不存在"/mnt/jffs2/customize.txt"文件则直接返回
    if [ ! -f "$var_jffs2_customize_txt_file" ]
    then
        return 0
    fi
    
    read var_bin_ft_word var_cfg_ft_word1 < $var_jffs2_customize_txt_file
    if [ 0 -ne $? ]
    then
        return 1
    fi
    
    var_cfg_ft_word=$(echo $var_cfg_ft_word1 | tr a-z A-Z)
    
    #如果配置特征字中没有_SIP则直接返回，重定向到/dev/null作用是不显示echo内容
    echo $var_cfg_ft_word | grep -iE "_SIP" > /dev/null	
	if [ $? == 0 ]
    then 
        var_voice_type="1"
	fi 
    #如果配置特征字中没有_H248则直接返回，重定向到/dev/null作用是不显示echo内容
    echo $var_cfg_ft_word | grep -iE "_H248" > /dev/null	
	if [ $? == 0 ]
    then
        var_voice_type="2"
	fi 
	
	if [ "0" = $var_voice_type ]
	then
	    return 0
    fi
    
    #如果没有对象InternetGatewayDevice.X_HW_SSMPPDT，需先添加
    cfgtool find $var_default_ctree $var_nod_ssmppdt
    if [ 0 -ne $? ]
	then
	    cfgtool add $var_default_ctree $var_nod_ssmppdt NULL 
	    if [ 0 -ne $? ]
	    then
		echo "Failed to set voice ssmppdt!"
		return 1
	    fi 	
    fi
	#如果没有对象InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo，需先添加
    cfgtool find $var_default_ctree $var_nod_deviceinfo
    if [ 0 -ne $? ]
    then
    	cfgtool add $var_default_ctree $var_nod_deviceinfo NULL
	if [ 0 -ne $? ]
	then
		echo "Failed to set voice deviceinfo!"
		return 1
	fi	
	
	cfgtool add $var_default_ctree $var_nod_deviceinfo X_HW_VOICE_MODE $var_voice_type
	if [ 0 -ne $? ]
	then
		echo "Failed to add voice Type!"
		return 1
	fi	
    else
		#如果没有对象InternetGatewayDevice.X_HW_SSMPPDT.Deviceinfo.X_HW_VOICE_MODE，需先添加	
		cfgtool gettofile $var_default_ctree $var_nod_deviceinfo X_HW_VOICE_MODE
	if [ 0 -ne $? ]
	then
		cfgtool add $var_default_ctree $var_nod_deviceinfo X_HW_VOICE_MODE $var_voice_type
		if [ 0 -ne $? ]
		then
			echo "Failed to add voice Type!"
			return 1
		fi		
		else
			cfgtool set $var_default_ctree $var_nod_deviceinfo X_HW_VOICE_MODE $var_voice_type
			if [ 0 -ne $? ]
			then
				echo "Failed to set voice Type!"
				return 1
			fi		
		fi
    fi   	
}

HW_Script_Cfgtool_Set()
{      
	echo "set $2 $3 $4" >> $var_batch_file   
}

#写入APPLocal管理的用户
#联通通用特性，ctree中未配置时才执行写入web用户，否则以ctree中配置的为准
#若各省份有特殊需求则在ctree中添加相应属性，脚本中不会修改
#联通定制时间太长，产线概率性失败.定制脚本中不宜进行过多操作影响生产效率。
HW_Script_SetApprmDatToFile()
{
    var_node_apprm=InternetGatewayDevice.X_HW_AppRemoteManage
	cfgtool find $var_default_ctree $var_node_apprm
    if [ 0 -eq $? ]
	then
	    cfgtool gettofile $var_default_ctree $var_node_apprm LocatePort2
		if  [ 0 -ne $? ]
		then
			echo "add $var_node_apprm LocatePort2 17998" >> $var_batch_file		    
		else
			echo "set $var_node_apprm LocatePort2 17998" >> $var_batch_file		    
		fi
		echo "set $var_node_apprm LocatePort 17999" >> $var_batch_file
		
		cfgtool gettofile $var_default_ctree $var_node_apprm LocalUserPassword
		if [ 0 -eq $? ]
		then
			echo "set $var_node_apprm LocalUserPassword $var_wpa" >> $var_batch_file
	    fi
        cfgtool gettofile $var_default_ctree $var_node_apprm LocalAdminPassword
        if [ 0 -eq $? ]
	    then
			echo "set $var_node_apprm LocalAdminPassword $var_wpa" >> $var_batch_file	
        fi
	fi
}

HW_Script_SetDatToFile()
{
    var_node_app_srvmng=InternetGatewayDevice.X_HW_ServiceManage
    var_node_app_ftpuser=InternetGatewayDevice.X_HW_AppSrvManage.X_HW_AppSrvManageInstance.1
	var_node_web_pwd=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.1
    var_node_ssid1=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1
    var_node_wpa_pwd1=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.1.PreSharedKey.PreSharedKeyInstance.1
	var_node_ssid2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.2
	var_node_wpa_pwd2=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.2.PreSharedKey.PreSharedKeyInstance.1
	var_node_ssid5g=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5
	var_node_wpa_pwd5g=InternetGatewayDevice.LANDevice.LANDeviceInstance.1.WLANConfiguration.WLANConfigurationInstance.5.PreSharedKey.PreSharedKeyInstance.1

	var_random_number=$(echo $var_ssid | cut -b 4-7)
    var_OperatorId_node=InternetGatewayDevice.DeviceInfo
	
    #get OperatorId
    HW_Script_GetOperatorIdByBinCfgKey   
    # decrypt var_default_ctree
    
    
     
     

	rm -rf $var_batch_file
	HW_Script_Cfgtool_Set $var_default_ctree $var_node_web_pwd "Password" $var_userPwd
	HW_Script_Cfgtool_Set $var_default_ctree $var_node_ssid1 "SSID" $var_ssid
	HW_Script_Cfgtool_Set $var_default_ctree $var_node_wpa_pwd1 "PreSharedKey" $var_wpa

	cfgtool find $var_default_ctree $var_node_ssid2
	if [ 0 -eq $? ];then
		var_itv_ssid2="CU_iTV_$var_random_number"
		HW_Script_Cfgtool_Set $var_default_ctree $var_node_ssid2 "SSID" $var_itv_ssid2
		HW_Script_Cfgtool_Set $var_default_ctree $var_node_wpa_pwd2 "PreSharedKey" $var_wpa
	fi
	
	#fttr支持双频合一
	if [ $fttr_spt = 1 ]
	then
		var_ssid_5g=$var_ssid
	else
		var_ssid_5g=$var_ssid"-5G"
	fi

	HW_Script_Cfgtool_Set $var_default_ctree $var_node_ssid5g "SSID" $var_ssid_5g
	HW_Script_Cfgtool_Set $var_default_ctree $var_node_wpa_pwd5g "PreSharedKey" $var_wpa

    cfgtool find $var_default_ctree $var_node_app_ftpuser
    if [ 0 -eq $? ];then
        # add app ftpsrv account
        echo "add $var_node_app_ftpuser FtpUserName root" >> $var_batch_file

        # add app ftpsrv account
        echo "add $var_node_app_ftpuser FtpPassword $var_userPwd" >> $var_batch_file
    fi

    cfgtool find $var_default_ctree $var_node_app_srvmng
    if [ 0 -eq $? ];then
        # add app srvmng account
        echo "add $var_node_app_srvmng FtpUserName root" >> $var_batch_file

        #add app srvmng account
        echo "add $var_node_app_srvmng FtpPassword $var_userPwd" >> $var_batch_file
    fi

	cfgtool set $var_default_ctree $var_OperatorId_node X_HW_OperatorID $var_OperatorId
	if [ 0 -ne $? ]
	then
		echo "add $var_OperatorId_node X_HW_OperatorID $var_OperatorId" >> $var_batch_file
	fi
	
	#写入APPLocal管理的用户
	HW_Script_SetApprmDatToFile
	if [ 0 -ne $? ]
	then
	    echo "Failed to set X_HW_AppRemoteManage!"
	    return 1
	fi
     
	#新增SIP H248预埋特性
	HW_Script_SetVoiceDatToFile
	if [ 0 -ne $? ]
	then
	    echo "Failed to set voice type!"
	    return 1
	fi

	cfgtool batch $var_default_ctree $var_batch_file
	if [ 0 -ne $? ]
	then
		echo "Failed to set parameters!"
		rm -rf $var_batch_file
		return 1
	fi
	rm -rf $var_batch_file
    
    #encrypt var_default_ctree
     
     
	
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

