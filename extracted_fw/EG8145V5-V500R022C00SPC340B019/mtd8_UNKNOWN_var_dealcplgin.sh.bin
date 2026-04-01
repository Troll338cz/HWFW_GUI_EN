#!/bin/sh
cplugin_preload_dir=/mnt/jffs2/app

mkdir -p $cplugin_preload_dir
chmod 770 /mnt/jffs2/app

rm -rf /mnt/jffs2/ThirdPartyPlugin.tar.gz
if [ -f /mnt/jffs2/app/plugins/Installer ]; then
    sudo rm -fr /mnt/jffs2/app/plugins/Installer
fi