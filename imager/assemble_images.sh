#!/bin/bash

source ./partition_layout.sh

( cp images/mbr.bin images/sd_image.bin &&
  dd if=ubiboot.bin of=images/sd_image.bin ibs=512 seek=1 &&
  dd if=images/system.bin of=images/sd_image.bin ibs=512 seek=${SYSTEM_START} &&
  dd if=images/data.bin of=images/sd_image.bin ibs=512 seek=${DATA_START}
) || rm -f images/sd_image.bin
