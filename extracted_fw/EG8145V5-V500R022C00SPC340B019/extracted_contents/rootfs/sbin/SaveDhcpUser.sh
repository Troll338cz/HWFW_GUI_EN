#!/bin/sh
# 软重启前保存数据

#DHCPD reboot前将/var/dhcp_data 刷到/mnt/jffs2/dhcp_data_a或者/mnt/jffs2/dhcp_data_b
if [ -e /var/dhcp_data ]; then
	if [ -e /mnt/jffs2/dhcp_data_a ]; then
		echo "save /mnt/jffs2/dhcp_data_b"
		cp -rf /var/dhcp_data /mnt/jffs2/dhcp_data_b
	rm -rf /mnt/jffs2/dhcp_data_a
	else
		echo "save /mnt/jffs2/dhcp_data_a"
		cp -rf /var/dhcp_data /mnt/jffs2/dhcp_data_a
	rm -rf /mnt/jffs2/dhcp_data_b
	fi
fi

if [ -e /var/dhcp_lastip ]; then
	cp -rf /var/dhcp_lastip /mnt/jffs2/dhcp_lastip
fi