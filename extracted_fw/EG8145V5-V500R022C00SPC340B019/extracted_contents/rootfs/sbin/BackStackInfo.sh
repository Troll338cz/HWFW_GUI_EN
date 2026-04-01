#! /bin/sh

pid=$$
ppid=`cat /proc/$pid/status | grep PPid | cut -d':' -f2`
ppid=${ppid:1}

fileName=/var/stackrange_$ppid

cat /proc/$ppid/maps | grep " rw-p " | grep "00:00 0" | grep -v heap | cut -d' ' -f1 > $fileName
chmod 444 $fileName
