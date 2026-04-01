#! /bin/sh
var_default_ctree=/var/hw_default_ctree.xml

var_pack_temp_dir=/bin/
var_jffs2_customize_txt_file="/mnt/jffs2/customize.txt"
var_OperatorId="CTC"

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

# set customize data to file
HW_Script_SetDatToFile()
{
    var_OperatorId_node=InternetGatewayDevice.DeviceInfo
	    #get OperatorId
    HW_Script_GetOperatorIdByBinCfgKey

 


   	cfgtool set $var_default_ctree $var_OperatorId_node X_HW_OperatorID $var_OperatorId
	if [ 0 -ne $? ]
	then
		cfgtool add $var_default_ctree $var_OperatorId_node X_HW_OperatorID $var_OperatorId
		if [ 0 -ne $? ]
		then
			echo "Failed to set X_HW_OperatorID !"
			return 1
		fi
	fi
	#新增SIP H248预埋特性
	HW_Script_SetVoiceDatToFile
	if [ 0 -ne $? ]
	then
	    echo "Failed to set voice type!"
	    return 1
	fi	

	return
}

#
HW_Script_SetDatToFile
[ ! $? == 0 ] && exit 1

exit 0



