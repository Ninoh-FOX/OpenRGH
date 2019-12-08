#!/bin/sh
/bin/mount -o remount,rw /media
/bin/mkdir -p /media/system
/bin/mount -o ro /dev/mmcblk0p1 /media/system
/bin/mount -o remount,ro /media
/bin/mount -o remount,rw /media/system