#!/bin/sh
# Copyright Huawei Technologies Co., Ltd. 2020-2020. All rights reserved.

watch_mem()
{
    local num=$(ps | grep kernelapp | grep -v grep |wc -l)
    local pid=$(ps | grep kernelapp | awk -F: NR==${num} | awk '{print $1}')
    local usemem=$(cat /proc/${pid}/status | grep VmRSS |  awk '{print $2}')
    if [ "${usemem}" -ge "11246" ]; then
        echo "[$(date)]mem:$usemem" > /var/kernelapp_monitor.log
        chmod 640 /var/kernelapp_monitor.log
        if [ ! -e /var/dslFlagForPlugin ]; then 
            chown osgi_proxy:osgi /var/kernelapp_monitor.log
        fi
        ./plugin_stop.sh
    fi
}

watch_file()
{
    if [ -f ./upgrade_done ]; then
        rm -f ./upgrade_done
    fi
    
    if [ -e /var/dslFlagForPlugin ]; then 
        echo "DSL mode"
        return
    fi
    
    local errs=$(ls -l ./Lib/ | grep -v '\->' | awk '{print $1}' | grep rwx)
    if [ ! -z "${errs}" ]; then
        chown -Rh osgi_proxy:osgi ../MyPlugin
        
        chmod 750 ../MyPlugin
        chmod 400 ./Lib/*
    fi
    
    errs=$(ls -l /var/|grep Cplugin_upgrade|grep -v "osgi")
    if [ ! -z "${errs}" ]; then
        chown -Rh osgi_proxy:osgi /var/Cplugin_upgrade
        chmod 750 /var/Cplugin_upgrade
    fi
}

watch_proc()
{
    local num=$(ps | grep -wE "kernelapp$" | grep -v grep | wc -l)
    if [ "${num}" -gt "1" ]; then
        ps > /var/kernelapp_monitor.log
        chmod 640 /var/kernelapp_monitor.log
        if [ ! -e /var/dslFlagForPlugin ]; then 
            chown osgi_proxy:osgi /var/kernelapp_monitor.log
        fi
        sleep 3
        num=$(ps | grep -wE "kernelapp$" | grep -v grep | wc -l)
        if [ "${num}" -gt "1" ]; then
            ps >> /var/kernelapp_monitor.log
            echo "[$(date)]num:$num" >> /var/kernelapp_monitor.log 
            ./plugin_stop.sh
        fi
    fi
}

watch_startshell()
{
    if [ -e ../MyPlugin1 ] && [ ! -f ../MyPlugin1/upgrade_done ]; then
        echo "need upgrade!"
        return
    fi
    
    if [ -f ./plugin_startup_new.sh ]; then
        mv -f plugin_startup_new.sh plugin_startup.sh
    fi
}

watch_mem
watch_file
watch_startshell
watch_proc

