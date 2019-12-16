#!/bin/sh

cd `dirname $0`

export MININIT=./mininit-syspart
export MODULES_FS=./modules.squashfs
export ROOTFS=./rootfs.squashfs
DATE_FILE=./date.txt
VERSION_FILE=./version.txt

SYSTEM_MOUNTPOINT=/mnt/_system_update

if [ -f ./uImage ] ; then
	export KERNEL=./uImage
	KERNEL_DEST=$SYSTEM_MOUNTPOINT/uImage
	KERNEL_BACKUP=$SYSTEM_MOUNTPOINT/uImage.bak
elif [ -f ./uzImage.bin ] ; then
	export KERNEL=./uzImage.bin
	KERNEL_DEST=$SYSTEM_MOUNTPOINT/uzImage.bin
	KERNEL_BACKUP=$SYSTEM_MOUNTPOINT/uzImage.bak
else
	export KERNEL=./vmlinuz.bin
	KERNEL_DEST=$SYSTEM_MOUNTPOINT/vmlinuz.bin
	KERNEL_BACKUP=$SYSTEM_MOUNTPOINT/vmlinuz.bak
fi
KERNEL_TMP_DEST=$SYSTEM_MOUNTPOINT/update_kernel.bin

ROOTFS_TMP_DEST=$SYSTEM_MOUNTPOINT/update_rootfs.bin
ROOTFS_CURRENT=$SYSTEM_MOUNTPOINT/rootfs.squashfs

MODULES_FS_TMP_DEST=$SYSTEM_MOUNTPOINT/update_modules.bin
MODULES_FS_DEST=$SYSTEM_MOUNTPOINT/update_m.bin
MODULES_FS_CURRENT=$SYSTEM_MOUNTPOINT/modules.squashfs

MININIT_TMP_DEST=$SYSTEM_MOUNTPOINT/update_mininit
MININIT_DEST=$SYSTEM_MOUNTPOINT/mininit-syspart

if [ `grep rootfs_bak /proc/cmdline` ] ; then
	# If we're running the backup rootfs, we can overwrite the
	# regular rootfs without problem
	ROOTFS_DEST=$ROOTFS_CURRENT
else
	# Otherwise, the regular rootfs is currently mounted, so we
	# cannot overwrite it; we let min-init (in initramfs) do the switch
	ROOTFS_DEST=$SYSTEM_MOUNTPOINT/update_r.bin
fi

SYSTEM_PARTITION="`sed -n 's/.*boot=\([a-z_/:0-9]\+\).*/\1/p' /proc/cmdline`"
[ -z "$SYSTEM_PARTITION" ] && SYSTEM_PARTITION="`sed -n 's/.*root=\([a-z_/:0-9]\+\).*/\1/p' /proc/cmdline`"

SYSTEM_PARTITION_TYPE="`sed -n 's/.*rootfstype=\([a-z0-9]\+\).*/\1/p' /proc/cmdline`"
[ -z "$SYSTEM_PARTITION_TYPE" ] && SYSTEM_PARTITION_TYPE="auto"

export BAR=`which bar`
export PV=`which pv`

cat_file() {
	if [ "$BAR" ] ; then
		$BAR -w 54 -0 ' ' -n "$1"
	elif [ "$PV" ] ; then
		$PV -p "$1"
	else
		cat "$1"
	fi
}

copy_file() {
	cat_file $1 > $2
}

error_quit() {
	rm -f "$KERNEL_TMP_DEST" "$MININIT_TMP_DEST" \
		"$ROOTFS_TMP_DEST" "$ROOTFS_DEST" "${ROOTFS_DEST}.sha1" \
		"$MODULES_FS_TMP_DEST" "$MODULES_FS_DEST" "${MODULES_FS_DEST}.sha1"

	# Forces other mount points to be read-only before unmounting
	mount -t "$SYSTEM_PARTITION_TYPE" -o remount,ro "$SYSTEM_MOUNTPOINT" 2>/dev/null
	umount "$SYSTEM_MOUNTPOINT" 2>/dev/null
	exit 1
}

DISCLAIMER="\Zb\Z3NOTICE\Zn

While we carefully constructed this updater,
it is possible flaws in the updater or in
the updated OS could lead to \Zb\Z3data loss\Zn. We
recommend that you \Zb\Z3backup\Zn all valuable
personal data on your RG-350 before you
perform the update.

Do you want to update now?"

# The update will fail if /media/system is mounted,
# so we first un-mount it.
# For some reason, future ro mounts will also fail if /media/system was
# mounted rw before it was unmounted.
if [ -d /media/system ] ; then
	mount -t "$SYSTEM_PARTITION_TYPE" -o remount,ro /media/system
	umount /media/system
fi

mkdir -p "$SYSTEM_MOUNTPOINT"

# Linux will refuse to mount read-write if other mount points are read-only,
# so we mount read-only first and remount read-write after
mount -t "$SYSTEM_PARTITION_TYPE" -o ro "$SYSTEM_PARTITION" "$SYSTEM_MOUNTPOINT" 2>/dev/null
if [ $? -eq 0 ] ; then
	mount -t "$SYSTEM_PARTITION_TYPE" -o remount,rw "$SYSTEM_MOUNTPOINT"
else
	mount -t "$SYSTEM_PARTITION_TYPE" -o rw "$SYSTEM_PARTITION" "$SYSTEM_MOUNTPOINT"
fi

UP_TO_DATE=yes

if [ -f "$DATE_FILE" ] ; then
	DATE="`cat $DATE_FILE`"
        VERSION="`cat $VERSION_FILE`"
	export DIALOGOPTS="--colors --backtitle \"RG350 ROGUE VERSION update $DATE $VERSION\""
fi

echo "screen_color = (RED,RED,ON)" > /tmp/dialog_err.rc

if [ -f "$KERNEL" -a -f "$KERNEL.sha1" -a -f "$KERNEL_DEST.sha1" ] ; then
	SHA1_OLD=`cat "$KERNEL_DEST.sha1"`
	SHA1_NEW=`cat "$KERNEL.sha1"`
	if [ "$SHA1_OLD" != "$SHA1_NEW" ] ; then
		UP_TO_DATE=no
	fi
fi

if [ -f "$MODULES_FS" -a -f "$MODULES_FS.sha1" -a -f "$MODULES_FS_CURRENT.sha1" ] ; then
	SHA1_OLD=`cat "$MODULES_FS_CURRENT.sha1"`
	SHA1_NEW=`cat "$MODULES_FS.sha1"`
	if [ "$SHA1_OLD" != "$SHA1_NEW" ] ; then
		UP_TO_DATE=no
	fi
fi

if [ -f "$ROOTFS" -a -f "$ROOTFS.sha1" -a -f "$ROOTFS_CURRENT.sha1" -a "$UP_TO_DATE" = "yes" ] ; then
	SHA1_OLD=`cat "$ROOTFS_CURRENT.sha1"`
	SHA1_NEW=`cat "$ROOTFS.sha1"`
	if [ "$SHA1_OLD" != "$SHA1_NEW" ] ; then
		UP_TO_DATE=no
	fi
fi

if [ "$UP_TO_DATE" = "yes" ] ; then
	dialog --defaultno --yesno 'The system seems to be already up to date.\n\n
Do you really want to continue?' 10 30
	if [ $? -ne 0 ] ; then
		error_quit
	fi
fi

dialog --defaultno --yes-label 'Update' --no-label 'Cancel' --yesno "$DISCLAIMER" 15 48
if [ $? -eq 1 ] ; then
	error_quit
fi

clear
echo 'Update in progress - please be patient.'
echo

HWVARIANT="`sed -n 's/.*hwvariant=\([a-z_0-9]\+\).*/\1/p' /proc/cmdline`"

if [ -z "$HWVARIANT" ] ; then
	# Only old "Frankenzeros" can have a bootloader so old that
	# it doesn't pass the 'hwvariant' parameter to the kernel...
	HWVARIANT="v11_ddr2_256mb"
fi

export BOOTLOADER="./ubiboot-$HWVARIANT.bin"

if [ "$SYSTEM_PARTITION" = "/dev/mmcblk0p1" ] ; then
# Checks if the system partition has been resized.

	SYSTEM_END_THEORY=819199
	SYSTEM_END=`partx /dev/mmcblk0 -n 1 -g -o end`
	if [ $SYSTEM_END_THEORY -gt $SYSTEM_END ] ; then
		exec ./flash_partition.sh
	fi
fi

if [ -f "$ROOTFS" ] ; then
	echo 'Installing updated root filesystem... '

	copy_file "$ROOTFS" "$ROOTFS_TMP_DEST"
	if [ $? -ne 0 ] ; then
		DIALOGRC="/tmp/dialog_err.rc" \
			dialog --msgbox 'ERROR!\n\nUnable to update RootFS.\nDo you have enough space available?' 10 34
		error_quit
	fi
fi

if [ -f "$KERNEL" ] ; then
	echo 'Installing updated kernel... '

	copy_file "$KERNEL" "$KERNEL_TMP_DEST"
	if [ $? -ne 0 ] ; then
		DIALOGRC="/tmp/dialog_err.rc" \
			dialog --msgbox 'ERROR!\n\nUnable to update kernel.' 8 34
		error_quit
	fi

	echo 'Installing updated modules filesystem... '

	copy_file "$MODULES_FS" "$MODULES_FS_TMP_DEST"
	if [ $? -ne 0 ] ; then
		DIALOGRC="/tmp/dialog_err.rc" \
			dialog --msgbox 'ERROR!\n\nUnable to update modules filesystem.' 8 34
		error_quit
	fi
fi

if [ -f "$MININIT" ] ; then
	echo 'Installing updated startup program... '

	copy_file "$MININIT" "$MININIT_TMP_DEST"
	if [ $? -ne 0 ] ; then
		DIALOGRC="/tmp/dialog_err.rc" \
			dialog --msgbox 'ERROR!\n\nUnable to update startup program.' 8 34
		error_quit
	fi
fi

echo 'Flushing write cache... '
sync
echo ''

# Make sure that the verification steps use data from disk, not cached data.
echo 3 > /proc/sys/vm/drop_caches

if [ -f "$ROOTFS" ] ; then
	if [ -f "$ROOTFS.sha1" ] ; then
		echo 'Verifying checksum of updated root filesystem...'

		SHA1=`cat_file "$ROOTFS_TMP_DEST" | sha1sum | cut -d' ' -f1`
		if [ "$SHA1" != "`cat $ROOTFS.sha1`" ] ; then
			DIALOGRC="/tmp/dialog_err.rc" \
				dialog --msgbox 'ERROR!\n\nUpdated RootFS is corrupted!' 9 34
			error_quit
		fi
	fi
fi

if [ -f "$KERNEL" ] ; then
	if [ -f "$KERNEL.sha1" ] ; then
		echo 'Verifying checksum of updated kernel...'

		SHA1=`cat_file "$KERNEL_TMP_DEST" | sha1sum | cut -d' ' -f1`
		if [ "$SHA1" != "`cat $KERNEL.sha1`" ] ; then
			DIALOGRC="/tmp/dialog_err.rc" \
				dialog --msgbox 'ERROR!\n\nUpdated kernel is corrupted!' 9 34
			error_quit
		fi
	fi

	if [ -f "$MODULES_FS.sha1" ] ; then
		echo 'Verifying checksum of updated modules filesystem...'

		SHA1=`cat_file "$MODULES_FS_TMP_DEST" | sha1sum | cut -d' ' -f1`
		if [ "$SHA1" != "`cat $MODULES_FS.sha1`" ] ; then
			DIALOGRC="/tmp/dialog_err.rc" \
				dialog --msgbox 'ERROR!\n\nUpdated modules filesystem is corrupted!' 9 34
			error_quit
		fi
	fi
fi

if [ -f "$MININIT" -a -f "${MININIT}.sha1" ] ; then
	echo 'Verifying checksum of updated startup program...'

	SHA1=`cat_file "$MININIT_TMP_DEST" | sha1sum | cut -d' ' -f1`
	if [ "$SHA1" != "`cat ${MININIT}.sha1`" ] ; then
		DIALOGRC="/tmp/dialog_err.rc" \
			dialog --msgbox 'ERROR!\n\nUpdated startup program is corrupted!' 9 34
		error_quit
	fi
fi

if [ -f "$BOOTLOADER" ] ; then
	if [ -f "$BOOTLOADER.sha1" ] ; then
		echo 'Verifying checksum of updated bootloader...'

		SHA1=`cat_file "$BOOTLOADER" | sha1sum | cut -d' ' -f1`
		if [ "$SHA1" != "`cat $BOOTLOADER.sha1`" ] ; then
			DIALOGRC="/tmp/dialog_err.rc" \
				dialog --msgbox 'ERROR!\n\nUpdated bootloader is corrupted!' 9 34
			error_quit
		fi
	fi
fi

echo ''
echo 'Committing changes. Please wait...'

if [ -f "$ROOTFS" ] ; then
	# Synchronize the dates
	touch -d "`date -r "$ROOTFS" +'%F %T'`" "$ROOTFS_TMP_DEST"

	if [ -f "$ROOTFS.sha1" ] ; then
		cp "$ROOTFS.sha1" "$ROOTFS_DEST.sha1"
		sync
	fi

	mv "$ROOTFS_TMP_DEST" "$ROOTFS_DEST"
	sync
fi

if [ -f "$KERNEL" ] ; then
	# Synchronize the dates
	touch -d "`date -r "$KERNEL" +'%F %T'`" "$KERNEL_TMP_DEST"

	# Special case when the destination modules filesystem does not exist
	if [ ! -e "$MODULES_FS_CURRENT" ] ; then
		MODULES_FS_DEST="$MODULES_FS_CURRENT"
	fi

	# Don't create a backup if we are already running from the backup kernel,
	# so that no matter what, we'll still have a working kernel installed.
	if [ -z `cat /proc/cmdline |grep kernel_bak` ] ; then
		cp "$KERNEL_DEST" "$KERNEL_BACKUP"
		cp "$KERNEL_DEST.sha1" "$KERNEL_BACKUP.sha1"
		if [ -e "$MODULES_FS_DEST.sha1" ] ; then
			cp "$MODULES_FS_DEST.sha1" "$MODULES_FS_DEST.sha1.bak"
		fi
	else
		MODULES_FS_DEST="$MODULES_FS_CURRENT"
	fi

	if [ -f "$KERNEL.sha1" ] ; then
		cp "$KERNEL.sha1" "$KERNEL_DEST.sha1"
		sync
	fi

	if [ -f "$MODULES_FS.sha1" ] ; then
		cp "$MODULES_FS.sha1" "$MODULES_FS_DEST.sha1"
		sync
	fi

	mv "$MODULES_FS_TMP_DEST" "$MODULES_FS_DEST"
	mv "$KERNEL_TMP_DEST" "$KERNEL_DEST"
	sync
fi

if [ -f "$MININIT" ] ; then
	# Synchronize the dates
	touch -d "`date -r "$MININIT" +'%F %T'`" "$MININIT_TMP_DEST"

	if [ -f "${MININIT}.sha1" ] ; then
		cp "${MININIT}.sha1" "${MININIT_DEST}.sha1"
		sync
	fi

	# mininit will use those directories as mountpoints
	mkdir -p ${SYSTEM_MOUNTPOINT}/dev ${SYSTEM_MOUNTPOINT}/root

	chmod +x "$MININIT_TMP_DEST"
	mv "$MININIT_TMP_DEST" "$MININIT_DEST"
	sync
fi

if [ -f "$BOOTLOADER" -a "$SYSTEM_PARTITION" = "/dev/mmcblk0p1" ] ; then
	dd if="$BOOTLOADER" of=/dev/mmcblk0 bs=512 seek=1 \
		count=16 conv=notrunc 2>/dev/null
	sync
fi

dialog --msgbox 'Update complete!\nThe system will now restart.\n\n
If for some reason the system fails to boot, try to press the
following keys while powering on the device:\n
    -Y to boot the last working kernel,\n
    -X to boot the last working rootfs.\n\n
Note that pressing both keys during the power-on sequence will load the very
same Operating System (kernel + rootfs) you had before upgrading.' 16 0
reboot
