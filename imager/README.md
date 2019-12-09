GCW Zero Image Generation Tools port to RG350
======

The installation uses four files:
* master boot record (MBR)
* boot loader (UBIBoot)
* system image (vfat), containing Linux kernels
* data image (ext4), containing rootfs and preloaded apps

This repository contains the tools to create the MBR image, the system image and the data image. The boot loader is installed as-is, no need to create an image file of it.

`create_mbr.sh` has no input and outputs the MBR image `images/mbr.bin`.

`create_system_image.sh` takes a kernel file named `vmlinuz.bin` as its input and outputs the system image `images/system.bin`.

`create_data_image.sh` takes a rootfs file named `rootfs.squashfs` and OPK files in the directory `apps/` as its inputs and outputs the data image `images/data.bin`.

Instructions on flashing the images to the device:
  https://github.com/gcwnow/ingenic-boot/wiki

Instead of flashing via ingenic-boot, you can create a combined image file and use a raw sector writer to put in on the SD card that will be used as the internal SD in the GCW Zero.

`assemble_images.sh` takes the previously mentioned three images files and a boot loader named `ubiboot.bin` as its inputs and outputs the combined image `images/sd_image.bin`.
