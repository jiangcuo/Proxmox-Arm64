#!/bin/bash
#isopath=""
isopath=$1
localpath=$(dirname $(readlink -f "$0"))
chmod +x $localpath/init
mkdir $localpath/initrd -p
for inits in `find  $isopath/boot/ -maxdepth 1 -name "initrd*.img"  -printf '%f\n'`;
do
initpath="$isopath/boot/$inits"
cp $initpath $localpath/initrd/initrd.img.gz
cd $localpath/initrd
gzip -d initrd.img.gz
mkdir $localpath/initrd/initrd
cd  $localpath/initrd/initrd
echo "uncpio $inits"
cpio -idm <../initrd.img
echo "copy local init"
cp $localpath/init  $localpath/initrd/initrd
cp $isopath/.cd-info ./
cp $isopath/.pve-cd-id.txt ./
echo "cpio $inits"
find . | cpio -o -H newc | gzip > $initpath
rm  $localpath/initrd/* -rf
echo "$inits done"
done
rm -rf $localpath/initrd
echo "all done"
