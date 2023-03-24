#!/bin/bash
#isopath
isopath=$1
xorriso -as mkisofs -r  -V 'PVE' \
-o ./pvearm.iso \
-R -cache-inodes \
-e boot/grub/efi.img \
-no-emul-boot \
-append_partition 2 0xef boot/grub/efi.img \
-partition_cyl_align all \
$isopath/