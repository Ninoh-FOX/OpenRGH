#!/bin/sh

DISCLAIMER="\Zb\Z3NOTICE\Zn

While we carefully constructed this flasher,
it is possible flaws in the flasher or in
the flashed MMC could lead to \Zb\Z3data loss\Zn.
We recommend that you \Zb\Z3backup\Zn all
valuable personal data on your RG-350 before
you perform the flash.

Do you want to flash now?"

if [ -f "date.txt" ] ; then
	DATE="`cat date.txt`"
        VERSION="`cat version.txt`"
	export DIALOGOPTS="--colors --backtitle \"RG350 ROGUE VERSION $VERSION MMC flasher $DATE\""
fi

dialog --defaultno --yes-label 'Flash' --no-label 'Cancel' --yesno "$DISCLAIMER" 15 48
if [ $? -eq 1 ] ; then
  exit 1
fi

/sbin/swapoff -a
/bin/umount -l /dev/mmcblk0p2 1>/dev/null 2>&1
let n=5
while [ `/bin/mount | grep mmcblk0p2 | wc -l` -gt 0 -a $n -gt 0 ]; do
  /bin/umount -l /dev/mmcblk0p2 1>/dev/null 2>&1
  echo "unmount failed, retrying ($n times left)"
  let n=$n-1
  sleep 1
done
if [ $n -eq 0 ]; then
  exit 1
fi

(./pv -n ./sd_image.bin | ./dd of=/dev/mmcblk0 bs=4M conv=notrunc,noerror) 2>&1 | dialog --gauge "Flashing, please wait..." 7 48 0
sleep 2

dialog --msgbox '\n      Flash complete!\n\nThe system will now restart.\n\n' 8 0
reboot
