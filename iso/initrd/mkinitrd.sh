#!/bin/bash
#isopath=""
isopath=$1
localpath=$(dirname $(readlink -f "$0"))
mkdir $localpath/initrd
for inits in `ls $isopath/boot/initrd*.img`;
do
cp $inits $localpath/initrd/$inits.gz
cd $localpath/initrd
gzip -d $inits.gz
mkdir $localpath/initrd/initrd
cd  $localpath/initrd/initrd
echo "uncpio $inits"
cpio -idm <../$inits
echo "copy local"
cp $localpath/init  $localpath/initrd/initrd
find . | cpio -o -H newc | gzip > $isopath/boot/$inits
rm  $localpath/initrd/* -rf
done
rm $localpath/initrd
