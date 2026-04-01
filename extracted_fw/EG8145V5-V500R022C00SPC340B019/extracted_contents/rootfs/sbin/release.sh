#!/bin/sh
# 清理所有业务进程，将系统初始化为开始状态，只保留KO

killall -23 dhcpc
echo "Dhcp4 Release!"

killall -15 dhcp6c
echo "Dhcp6 Release!"

killall -15 pppd
echo "pppd Terminal!"

if [ "$1" == "reboot" ]; then
    killall -12 ctrg_m
fi

sleep 0.5
