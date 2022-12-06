#!/bin/bash
repacked_path="/repacked"
mirror_path="/var/spool/apt-mirror/mirror/download.proxmox.com/debian/devel/dists/bullseye/main/binary-amd64/"
#newpkg
ls  $mirror_path |grep librust>/tmp/newpkg
#oldpkg
ls $repacked_path >/tmp/oldpkg
#oldpkg-arm64.deb to amd64.deb
sed -i "s/arm64/amd64/g" /tmp/oldpkg 
#diff
diff -u /tmp/oldpkg /tmp/newpkg |grep +librust|sed "s/^.//g" > /tmp/needpkg
echo "$(date "+%Y/%m/%d %H:%M:%S") Needpkgs:" 
if test -s /tmp/needpkg
then
cat /tmp/needpkg
else
echo "all pkg is up date"
exit 0
fi

for packlist in `cat /tmp/needpkg`;do
extract_path="/librust/$packlist/extract" 
mkdir $extract_path/DEBIAN -p
dpkg -X $mirror_path$packlist $extract_path > /dev/null
dpkg -e $mirror_path$packlist $extract_path/DEBIAN > /dev/null
sed -i "s/amd64/arm64/g" $extract_path/DEBIAN/control > /dev/null
dpkg-deb -Zxz -b  $extract_path  $repacked_path  > /dev/null
echo "$(date "+%Y/%m/%d %H:%M:%S") repacked $packlist done" >>/var/log/repacked.log
done
echo "$(date "+%Y/%m/%d %H:%M:%S") all package repacked  done" 
echo "$(date "+%Y/%m/%d %H:%M:%S") all package repacked  done" >>/var/log/repacked.log
