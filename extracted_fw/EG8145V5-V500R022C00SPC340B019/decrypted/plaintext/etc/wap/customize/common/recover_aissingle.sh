#! /bin/sh

# 写入一个SSID的recover脚本，该脚本通过读取 /var/customizepara.txt 
# 文件中的定制信息，来将定制信息写入ctree中

# 定制脚本信息文件，该文件名固定，不能更改
var_customize_file=/var/customizepara.txt

# 定制信息写入文件，该文件通过tar包解压后复制产生,
# recover脚本的写入操作都是在这个临时文件中进行
var_default_ctree=/var/hw_default_ctree.xml
var_pack_temp_dir=/bin/

var_boardinfo_dup="/var/dup_boardinfo"
var_boardinfo_dup_tmp="/var/dup_boardinfo_tmp"

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

HW_Set_GPON_SN_Passwd()
{
	if [ ! -f $var_boardinfo_dup ]
	then
        echo "ERROR::no hw_boardinfo"
		return;
	fi
	
	password_byte1=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 2)
	password_byte2=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 3)
	password_byte3=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 4)
	password_byte4=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 5)
	password_byte5=$(cat $var_boardinfo_dup | grep 0x0000000a | cut -d ":" -f 6 | cut -c 1-2)
	var_sn_pwd=$password_byte1$password_byte2$password_byte3$password_byte4$password_byte5

	
	cat $var_boardinfo_dup | while read -r line;
	do
		obj_id_temp=`echo $line | sed 's/\(.*\)obj.value\(.*\)/\1/g'`
		obj_id=`echo $obj_id_temp | sed 's/\(.*\)"\(.*\)"\(.*\)/\2/g'`
		if [ "0x00000003" == $obj_id ]  && [ ! -f /mnt/jffs2/chgpwd_file ] ;then
		    echo "obj.id = \"0x00000003\" ; obj.value = \"$var_sn_pwd\";"
		else
		    echo -E $line
		fi
	done  > $var_boardinfo_dup_tmp

	mv -f $var_boardinfo_dup_tmp $var_boardinfo_dup
	
	return 0
}

#
HW_Script_CheckFileExist
[ ! $? == 0 ] && exit 1

#
HW_Set_GPON_SN_Passwd
[ ! $? == 0 ] && exit 1

echo "set spec info OK!"

exit 0

