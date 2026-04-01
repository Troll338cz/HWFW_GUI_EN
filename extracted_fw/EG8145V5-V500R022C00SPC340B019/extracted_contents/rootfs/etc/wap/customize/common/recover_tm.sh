#! /bin/sh

# 写入一个SSID的recover脚本，该脚本通过读取 /var/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中

# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree=/var/hw_default_ctree.xml
var_pack_temp_dir=/bin/

var_webuser_pwd=""
var_webadmin_pwd=""


# check the customize file
HW_Script_CheckFileExist()
{
	if [ ! -f "$var_customize_file" ]
	then
		echo "ERROR::customize file is not existed."
		return 1
	fi
	return 0
}

# read data from customize file
HW_Script_ReadDataFromFile()
{
	read -r  var_webuser_pwd var_webadmin_pwd < $var_customize_file
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
	
	var_web_pwd_admin=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.2
	var_web_pwd_user=InternetGatewayDevice.UserInterface.X_HW_WebUserInfo.X_HW_WebUserInfoInstance.1
	
	
	 

	if [ -n "$var_webuser_pwd" ] ; then
		#set web info
		cfgtool set $var_default_ctree $var_web_pwd_user Password $var_webuser_pwd
		if [ 0 -ne $? ]
		then
			echo "Failed to set common web password!"
			return 1
		fi

		#set cli pwd
		cfgtool set $var_default_ctree $var_web_pwd_admin Password $var_webadmin_pwd
		if [ 0 -ne $? ]
		then
			echo "Failed to set common cli password!"
			return 1
		fi			
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

echo "set spec info OK!"

exit 0

