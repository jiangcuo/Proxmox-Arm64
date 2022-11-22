#!/bin/bash
#将proxmox-ve librust 包重新打包为arm64
repacked_path="/repacked"
mirror_path="/var/spool/mirrors/"
mkdir $repacked_path
for packlist in `ls $mirror_path/librust*`;do
extract_path="/librust/$packlist/extract"
mkdir $extract_path/DEBIAN -p
dpkg -X $packlist $extract_path
dpkg -e $packlist $extract_path/DEBIAN
sed -i "s/amd64/arm64/g" $extract_path/DEBIAN/control
dpkg-deb -Zxz -b  $extract_path  $repacked_path
done
