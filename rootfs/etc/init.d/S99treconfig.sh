#!/bin/sh

if [ -f /media/data/.reconfig ]; then
   exit 1
 else
   rm -rf /media/data/local/etc/dropbear_*
   echo -n 1 >/sys/devices/virtual/vtconsole/vtcon1/bind
   clear
   echo "wipe old config from file system"
   sleep 4
   echo "done"
   sleep 2
   echo "The system reboot in 10s..."
   sleep 10
   echo -n 0 >/sys/devices/virtual/vtconsole/vtcon1/bind
   touch /media/data/.reconfig
   reboot
 fi