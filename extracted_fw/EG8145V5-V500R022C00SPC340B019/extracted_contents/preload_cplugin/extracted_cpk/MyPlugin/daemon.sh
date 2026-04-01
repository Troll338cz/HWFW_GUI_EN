#!/bin/sh
# Copyright Huawei Technologies Co., Ltd. 2010-2020. All rights reserved.

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)/Lib:/usr/lib/glib-2.0
trap ' ./plugin_stop.sh; exit 1;' 15
while true ; do  
    sh ./plugin_startup.sh
    sh ./plugin_monitor.sh
    sh ./plugin_keeplive.sh
done
