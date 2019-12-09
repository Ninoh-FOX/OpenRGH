#!/bin/bash

source ./partition_layout.sh

dd if=post-mortem/broken.bin of=post-mortem/mbr.bin ibs=512 count=1
dd if=post-mortem/broken.bin of=post-mortem/ubiboot.bin ibs=512 skip=1 count=$((${SYSTEM_START} - 1))
dd if=post-mortem/broken.bin of=post-mortem/system.bin ibs=512 skip=${SYSTEM_START} count=$((${DATA_START} - ${SYSTEM_START}))
dd if=post-mortem/broken.bin of=post-mortem/data.bin ibs=512 skip=${DATA_START}
