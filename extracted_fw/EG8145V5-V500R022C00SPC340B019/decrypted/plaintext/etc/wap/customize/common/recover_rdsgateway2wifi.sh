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
var_boardinfo_dup="/var/dup_boardinfo"

var_ssid1=""
var_wpa1=""

var_ssid2=""
var_wpa2=""

var_webadminpwd=""

var_gCfgWord=""

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
	read -r var_ssid1 var_wpa1 var_ssid2 var_wpa2 var_webadminpwd < $var_customize_file
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

    var_node_adminpassword=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.2
    var_node_clipassword=InternetGatewayDevice.UserInterface.X_HW_CLIUserInfo.X_HW_CLIUserInfoInstance.1

	HW_Script_Cfgtool_Set $var_default_ctree $var_node_ssid1 "SSID" $var_ssid1
	HW_Script_Cfgtool_Set $var_default_ctree $var_node_ssid2 "SSID" $var_ssid2
	HW_Script_Cfgtool_Set $var_default_ctree $var_node_wpa_pwd1 "PreSharedKey" $var_wpa1
	HW_Script_Cfgtool_Set $var_default_ctree $var_node_wpa_pwd2 "PreSharedKey" $var_wpa2
    # decrypt var_default_ctre

    if [ -n "$var_webadminpwd" ]; then 
        HW_Script_Cfgtool_Set $var_default_ctree $var_node_adminpassword Password $var_webadminpwd

        #set cli pwd
        HW_Script_Cfgtool_Set $var_default_ctree $var_node_clipassword Userpassword $var_webadminpwd
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

