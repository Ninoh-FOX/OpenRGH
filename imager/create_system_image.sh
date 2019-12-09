#!/bin/bash

source ./partition_layout.sh

if ! which mcopy > /dev/null
then
	echo "Please install the 'mtools' package."
	exit 1
fi

echo "Checking presence of kernel files..."
if test -f vmlinuz.bin
then
	SIZE=$(stat -Lc %s vmlinuz.bin)
	echo "vmlinuz.bin: $((${SIZE} / 1024)) kB"
else
	echo "missing main kernel: vmlinuz.bin"
	exit 1
fi
if test -f vmlinuz.bak
then
	SIZE=$(stat -Lc %s vmlinuz.bak)
	echo "vmlinuz.bak: $((${SIZE} / 1024)) kB"
else
	echo "missing fallback kernel: vmlinuz.bak"
	exit 1
fi

echo "Checking presence of mininit-syspart..."
if test -f mininit-syspart
then
	SIZE=$(stat -Lc %s mininit-syspart)
	echo "mininit-syspart: $((${SIZE} / 1024)) kB"
else
	echo "missing program: mininit-syspart"
	exit 1
fi

echo "Checking presence of root filesystem..."
if test -f rootfs.squashfs
then
	SIZE=$(stat -Lc %s rootfs.squashfs)
	echo "rootfs.squashfs: $((${SIZE} / 1024)) kB"
else
	echo "missing root filesystem: rootfs.squashfs"
	exit 1
fi

echo "Checking presence of modules filesystem..."
if test -f modules.squashfs
then
	SIZE=$(stat -Lc %s modules.squashfs)
	echo "modules.squashfs: $((${SIZE} / 1024)) kB"
else
	echo "missing modules filesystem: modules.squashfs"
	exit 1
fi
if test -f modules.squashfs.bak
then
	SIZE=$(stat -Lc %s modules.squashfs.bak)
	echo "modules.squashfs.bak: $((${SIZE} / 1024)) kB"
else
	echo "missing fallback modules filesystem: modules.squashfs.bak"
	exit 1
fi

echo "Creating system partition..."
IMAGE_SIZE=$((${DATA_START} - ${SYSTEM_START}))
mkdir -p images
dd if=/dev/zero of=images/system.bin bs=512 count=${IMAGE_SIZE} status=noxfer
/sbin/mkdosfs -s 8 -F 32 images/system.bin
echo

echo "Populating system partition..."
mmd -i images/system.bin ::dev ::root
mcopy -i images/system.bin vmlinuz.bin ::vmlinuz.bin
sha1sum vmlinuz.bin | cut -d' ' -f1 | mcopy -i images/system.bin - ::vmlinuz.bin.sha1
mcopy -i images/system.bin vmlinuz.bak ::vmlinuz.bak
sha1sum vmlinuz.bak | cut -d' ' -f1 | mcopy -i images/system.bin - ::vmlinuz.bak.sha1
mcopy -i images/system.bin mininit-syspart ::mininit-syspart
sha1sum mininit-syspart | cut -d' ' -f1 | mcopy -i images/system.bin - ::mininit-syspart.sha1
mcopy -i images/system.bin modules.squashfs ::modules.squashfs
sha1sum modules.squashfs | cut -d' ' -f1 | mcopy -i images/system.bin - ::modules.squashfs.sha1
mcopy -i images/system.bin modules.squashfs.bak ::modules.squashfs.bak
sha1sum modules.squashfs.bak | cut -d' ' -f1 | mcopy -i images/system.bin - ::modules.squashfs.bak.sha1
mcopy -i images/system.bin rootfs.squashfs ::rootfs.squashfs
sha1sum rootfs.squashfs | cut -d' ' -f1 | mcopy -i images/system.bin - ::rootfs.squashfs.sha1

echo "Minimizing image size..."
./trimfat.py images/system.bin
