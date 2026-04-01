#! /bin/sh

#免预配制时专用，加快配置速度，ssid等参数会在启动时配置，无需此处配置。
CURRENT_DIR=$PWD
HW_WAP_TRUNK_ROOT=$CURRENT_DIR/..
HW_WAP_PLAT_ROOT=$HW_WAP_TRUNK_ROOT/WAP
# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt
var_specsn=""
var_userPwd=""
var_ssid=""
var_wpa="" 
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
	read -r var_specsn var_userPwd var_ssid var_wpa < $var_customize_file
	if [ 0 -ne $? ]
	then
	    echo "Failed to read spec info!"
	    return 1
	fi
	return
}


HW_Script_SetSpecSn()
{	
	echo $var_boardinfo_dup | xargs sed 's/obj.id = \"0x00000019\" ; obj.value = \"[A-Za-z0-9-]*\"/obj.id = \"0x00000019\" ; obj.value = \"'$var_specsn'\"/g' -i
	if [ 0 -ne $? ]
	then
		echo "dup boardinfo set failed!"
		return 1
	fi
	return
}

# set customize data to file
HW_Script_SetDatToFile()
{
	#设置SpecSn的值到boardinfo
	HW_Script_SetSpecSn

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

