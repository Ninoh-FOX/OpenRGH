#!/bin/sh

DEVICE=mmcblk0
PART_NUM=2

DEVICE_SIZE=`cat /sys/block/${DEVICE}/size`
START=`partx /dev/${DEVICE} -n ${PART_NUM} -g -o start`
SIZE=$((${DEVICE_SIZE} - ${START}))

failexit()
{
  echo "failed"
  /bin/mount -t ext4 -o noatime,nodiratime,rw /dev/${DEVICE}p${PART_NUM} /media/data 1>/dev/null 2>&1
  echo -n 0 >/sys/devices/virtual/vtconsole/vtcon1/bind
  sleep 5
  exit 1
}

if [[ ! -d /media/data || -f /media/data/.partition_resized ]]; then
    echo
    echo -n "Unmounting..."
    if `/bin/umount -l /media/data 1>/dev/null 2>&1`; then
    echo "done"
    else
    failexit
    fi
    /bin/umount -l /dev/${DEVICE}p${PART_NUM} 1>/dev/null 2>&1
    /usr/sbin/e2fsck -f -y -C 0 /dev/${DEVICE}p${PART_NUM}
    /bin/mount -t ext4 -o noatime,nodiratime,rw /dev/${DEVICE}p${PART_NUM} /media/data
    touch /media/data/.clean
    exit 1   
fi

echo -n 1 >/sys/devices/virtual/vtconsole/vtcon1/bind
clear

echo "Expanding internal partition on first boot."

echo
echo -n "Unmounting..."
if `/bin/umount -l /media/data 1>/dev/null 2>&1`; then
  echo "done"
else
  failexit
fi
sleep 2
clear

echo "${START},${SIZE}" | sfdisk --no-reread -uS -N ${PART_NUM} /dev/${DEVICE}
clear
echo "Resizing and checking the data partition. Please be patient."
sleep 3
set +e

(echo d
echo 2
echo n
echo
echo
echo
echo
echo w
) | fdisk /dev/${DEVICE}
/usr/sbin/partx -u /dev/${DEVICE}
/bin/umount -l /dev/${DEVICE}p${PART_NUM} 1>/dev/null 2>&1
/usr/sbin/e2fsck -f -y -C 0 /dev/${DEVICE}p${PART_NUM}
/usr/sbin/e2fsck -f /dev/${DEVICE}p${PART_NUM}
resize2fs -p /dev/${DEVICE}p${PART_NUM} || failexit
/bin/mount -t ext4 -o noatime,nodiratime,rw /dev/${DEVICE}p${PART_NUM} /media/data
touch /media/data/.partition_resized
echo
echo "All done."

sleep 2

echo -n 0 >/sys/devices/virtual/vtconsole/vtcon1/bind
