#!/bin/bash
#isopath=""
isopath=$1

#update pve-base.sqaushfs
echo "unzip pve-bash"
unsquashfs $isopath/pve-base.sqaushfs
echo "update pkg list"
chroot squashfs-root/ apt update
echo "upgrade dist"
LC_ALL=C DEBIAN_FRONTEND=noninteractive  chroot squashfs-root/ apt dist-upgrade -y
chroot squashfs-root/ apt clean
echo "clean"
rm $isopath/pve-base.sqaushfs
echo "mk pve-base.sqaushfs"
mksquashfs  squashfs-root/ $isopath/pve-base.sqaushfs
mv squashfs-root pve-base
#update pve-installet.squashfs

echo "unzip pve-installer"
unsquashfs $isopath/pve-installer.squashfs
mv squashfs-root pve-installer
mkdir workdir .workdir
mount -t overlay -o lowerdir=pve-base,upperdir=pve-installer,workdir=.workdir overlay workdir
echo "update pkg list"
chroot workdir apt update
chroot workdir apt install curl gunpg2 -y

echo "add mirrors"
echo "deb https://mirrors.apqa.cn/proxmox/ pvearm  main"> workdir/etc/apt/sources.list.d/foxi.list
chroot workdir curl -L -O https://mirrors.apqa.cn/proxmox/gpg.key 
chroot workdir apt-key add gpg.key
echo "update pkg list"
chroot workdir apt update
echo "upgrade dist"
LC_ALL=C DEBIAN_FRONTEND=noninteractive chroot workdir apt dist-upgrade -y
umount workdir
rm $isopath/pve-installer.squashfs
mksquashfs  pve-installer $isopath/pve-installer.squashfs

