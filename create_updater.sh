#!/bin/bash
set -e
umask 0022

VERSION="`cat ./version.txt`"

if [ -r "update/vmlinuz.bin" ]; then
KERNEL="update/vmlinuz.bin"
else
KERNEL=""
fi

if [ -r "update/modules.squashfs" ]; then
MODULES_FS="update/modules.squashfs"
else
MODULE_FS=""
fi

if [ -r "update/rootfs.squashfs" ]; then
ROOTFS="update/rootfs.squashfs"
else
ROOTFS=""
fi

if [ -r "update/mininit-syspart" ]; then
MININIT="update/mininit-syspart"
else
MININIT=""
fi

if [ -r "update/ubiboot-rg350.bin" ]; then
BOOTLOADERS="update/ubiboot-rg350.bin"
else
BOOTLOADERS=""
fi

# TODO: Reinstate this:
# X-OD-Manual=CHANGELOG

# Copy kernel and rootfs to update dir.
# We want to support symlinks for the kernel and rootfs images and if no
# copy is made, specifying the symlink will include the symlink in the OPK
# and specifying the real path might use a different name than the update
# script expects.
if [ "$KERNEL" -a "$ROOTFS" ] ; then
	if [ `date -r "$KERNEL" +%s` -gt `date -r "$ROOTFS" +%s` ] ; then
		DATE=`date -r "$KERNEL" +%F`
	else
		DATE=`date -r "$ROOTFS" +%F`
	fi

elif [ "$KERNEL" ] ; then
	DATE=`date -r "$KERNEL" +%F`
elif [ "$ROOTFS" ] ; then
	DATE=`date -r "$ROOTFS" +%F`
else
	echo "ERROR: No kernel or rootfs found."
	exit 1
fi

if [ "$KERNEL" ] ; then

	chmod a-x "$KERNEL" "$MODULES_FS"

	echo -n "Calculating SHA1 sum of kernel... "
	sha1sum "$KERNEL" | cut -d' ' -f1 > "update/vmlinuz.bin.sha1"
	echo "done"

	echo -n "Calculating SHA1 sum of modules file-system... "
	sha1sum "$MODULES_FS" | cut -d' ' -f1 > "update/modules.squashfs.sha1"
	echo "done"

	KERNEL="$KERNEL update/vmlinuz.bin.sha1"
        MODULES_FS="$MODULES_FS update/modules.squashfs.sha1"
fi

if [ "$ROOTFS" ] ; then

	echo -n "Calculating SHA1 sum of rootfs... "
	sha1sum "$ROOTFS" | cut -d' ' -f1 > "update/rootfs.squashfs.sha1"
	echo "done"

	ROOTFS="$ROOTFS update/rootfs.squashfs.sha1"
fi

if [ "$BOOTLOADERS" ] ; then

	echo -n "Calculating SHA1 sum of bootloaders... "
        sha1sum "$BOOTLOADERS" | cut -d' ' -f1 > "update/ubiboot-rg350.bin.sha1"
        echo "done"

        BOOTLOADERS="$BOOTLOADERS update/ubiboot-rg350.bin.sha1"
fi

if [ "$MININIT" ] ; then

	echo -n "Calculating SHA1 sum of mininit-syspart... "
	sha1sum "$MININIT" | cut -d' ' -f1 > "update/mininit-syspart.sha1"
	echo "done"

	MININIT="$MININIT update/mininit-syspart.sha1"
fi

echo "$DATE" > update/date.txt

echo "$VERSION" > update/version.txt

# Report metadata.
echo
echo "=========================="
echo "Bootloaders:          $BOOTLOADERS"
echo "Mininit:              $MININIT"
echo "Kernel:               $KERNEL"
echo "Modules file system:  $MODULES_FS"
echo "Root file system:     $ROOTFS"
echo "build date:           $DATE"
echo "build version:        $VERSION"
echo "=========================="
echo

# Write metadata.
cat > update/default.gcw0.desktop <<EOF
[Desktop Entry]
Name=OS Update $VERSION
Comment=RG350 ROGUE Update $DATE
Exec=update.sh
Icon=rogue
Terminal=true
Type=Application
StartupNotify=true
Categories=applications;
EOF

# Create OPK.
OPK_FILE=update/rg350-update-$VERSION-$DATE.opk
mksquashfs \
	update/default.gcw0.desktop \
	update/rogue.png \
	update/update.sh \
	update/trimfat.py \
	update/flash_partition.sh \
	update/date.txt \
        update/version.txt \
        update/fsck.fat \
	$BOOTLOADERS \
	$MININIT \
	$KERNEL \
	$MODULES_FS \
        $ROOTFS \
	$OPK_FILE \
	-no-progress -noappend -comp gzip -all-root

echo
echo "=========================="
echo
echo "Updater OPK:       $OPK_FILE"
echo
