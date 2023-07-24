#!/bin/bash
arch="arm64"
codename="bookworm"
rootfssrc="/tmp/rootfs"
pve_pkgs='rados|pve|proxmox|extjs|qemu-server|apparmor|criu|spiceterm|vncterm|ceph|rgw|corosync|rbd|libcfg7|libcmap4|libcpg4|ibjs-qrcodejs|libknet1|libnozzle1|quorum|lxcfs|smartmontools'
apt install debootstrap squashfs-tools -y
rm -rf $rootfssrc
mkdir $rootfssrc
debootstrap --arch=$arch $codename $rootfssrc https://mirrors.ustc.edu.cn/debian/

cat << EOF > $rootfssrc/etc/apt/sources.list
deb https://mirrors.ustc.edu.cn/debian/ $codename main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian/ $codename-updates main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian/ $codename-backports main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian-security/ $codename-security main contrib non-free non-free-firmware
EOF

LC_ALL=C DEBIAN_FRONTEND=noninteractive chroot $rootfssrc apt update
LC_ALL=C DEBIAN_FRONTEND=noninteractive chroot $rootfssrc apt install vim pciutils curl wget aria2 net-tools rsync iotop htop tcpdump -y
LC_ALL=C DEBIAN_FRONTEND=noninteractive chroot $rootfssrc apt install -y \
busybox initramfs-tools initramfs-tools-core klibc-utils libklibc linux-base btrfs-progs tree faketime file fontconfig fontconfig-config fonts-dejavu-core fonts-font-awesome fonts-glyphicons-halflings fuse gdisk genisoimage \
glib-networking glib-networking-common glib-networking-services glusterfs-client glusterfs-common gnupg gnupg-l10n gnupg-utils gnutls-bin gpg gpg-agent \
gpg-wks-client gpg-wks-server gpgconf gpgsm groff-base gsettings-desktop-schemas gstreamer1.0-libav gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
gstreamer1.0-x hdparm ibverbs-providers idn ipset iptables iso-codes javascript-common keyutils libaa1 libaacs0 libaio1 libanyevent-http-perl \
libanyevent-perl libaom3 libappconfig-perl libapt-pkg-perl libarchive13 libasound2 libasound2-data libass9 libassuan0 libasync-interrupt-perl libasyncns0 \
libauthen-pam-perl libauthen-sasl-perl libavahi-client3 libavahi-common-data libavahi-common3 libavc1394-0 libavcodec59 libavfilter8 libavformat59 \
libavutil57 libbabeltrace1 libbdplus0 libbinutils libblas3 libbluray2 libbs2b0 libbytes-random-secure-perl libcaca0 libcairo-gobject2 libcairo2 libcbor0.8 \
libcrypt-ssleay-perl libctf-nobfd0 libctf0 libcups2 libcurl3-gnutls libdata-dump-perl libdatrie1 libdav1d6 libdbi1 libdconf1 libdeflate0 libdevel-cycle-perl \
libdevmapper-event1.02.1 libdigest-bubblebabble-perl libdigest-hmac-perl libdouble-conversion3 libdrm-amdgpu1 libdrm-common libdrm-nouveau2 libdrm-radeon1 \
libdrm2 libdv4 libdw1 libencode-locale-perl libepoxy0 libev-perl libevent-2.1-7 libevent-core-2.1-7 libfaketime libfdt1 libfido2-1 libfile-chdir-perl \
libfile-listing-perl libfile-readbackwards-perl libfilesys-df-perl libflac12 libflite1 libfmt9 libfont-afm-perl libfontconfig1 libfreetype6 libfribidi0 \
libfuse2 libfuse3-3 libgbm1 libgdbm-compat4 libgdbm6 libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-bin libgdk-pixbuf2.0-common libgfapi0 libgfchangelog0 libgfortran5 \
libgfrpc0 libgfxdr0 libgl1 libgl1-mesa-dri libglapi-mesa libglib2.0-0 libglib2.0-data libglusterd0 libglusterfs0 libglvnd0 libglx-mesa0 libglx0 libgme0 \
libgnutls-dane0 libgnutlsxx30 libgomp1 libgoogle-perftools4 libgpgme11 libgprofng0 libgraphite2-3 libgsm1 libgssapi-perl libgstreamer-plugins-base1.0-0 \
libgstreamer1.0-0 libguard-perl libgudev-1.0-0 libharfbuzz0b libhtml-form-perl libhtml-format-perl libhtml-parser-perl libhtml-tagset-perl libhtml-tree-perl \
libhttp-cookies-perl libhttp-daemon-perl libhttp-date-perl libhttp-message-perl libhttp-negotiate-perl libhwy1 libibverbs1 libidn12 libiec61883-0 libinih1 \
libio-html-perl libio-multiplex-perl libio-socket-ssl-perl libio-stringy-perl libip6tc2 libipset13 libiscsi7 libjack-jackd2-0 libjbig0 libjpeg62-turbo \
liblttng-ust-common1 liblttng-ust-ctl5 liblttng-ust1 liblua5.3-0 liblvm2cmd2.03 liblwp-mediatypes-perl liblwp-protocol-https-perl liblzo2-2 libmagic-mgc \
libmagic1 libmailtools-perl libmath-random-isaac-perl libmath-random-isaac-xs-perl libmbedcrypto7 libmime-base32-perl libmp3lame0 libmpg123-0 libmysofa1 \
libncurses6 libnet-dbus-perl libnet-dns-perl libnet-dns-sec-perl libnet-http-perl libnet-ip-perl libnet-ldap-perl libnet-libidn2-perl libnet-smtp-ssl-perl \
libnpth0 libnspr4 libnss3 libnuma1  liboath0 libogg0 libopenjp2-7 libopenmpt0 libopus0 liborc-0.4-0 libpam-systemd libpango-1.0-0 \
libpangocairo-1.0-0 libpangoft2-1.0-0 libpcre2-16-0 libperl4-corelibs-perl libperl5.36 libpgm-5.3-0 libpixman-1-0 libplacebo208 libpng16-16 libpocketsphinx3 \
libslirp0 libsmbclient libsnappy1v5 libsndfile1 libsocket6-perl libsord-0-0 libsoup2.4-1 libsoup2.4-common libsoxr0 libspeex1 libsphinxbase3 \
libspice-server1 libsratom-0-0 libsrt1.5-gnutls libssh-gcrypt-4 libstatgrab10 libstring-shellquote-perl libsubid4 libsvtav1enc1 libswresample4 libswscale6 \
libtag1v5 libtag1v5-vanilla libtalloc2 libtcmalloc-minimal4 libtdb1 libtemplate-perl libterm-readline-gnu-perl libtevent0 libthai-data libthai0 libtheora0 \
libthrift-0.17.0 libtie-ixhash-perl libtiff6 libtimedate-perl libtpms0 libtry-tiny-perl libtwolame0 libtypes-serialiser-perl libu2f-server0 libuchardet0 \
libudfread0 libunbound8 libunwind8 liburcu8 liburi-perl liburing2 libusb-1.0-0 libusbredirparser1 libuuid-perl libv4l-0 libv4lconvert0 \
libva-drm2 libva-x11-2 libva2 libvdpau-va-gl1 libvdpau1 libvidstab1.1 libvirglrenderer1 libvisual-0.4-0 libvorbis0a libvorbisenc2 libvorbisfile3 \
libwww-robotrules-perl libx11-6 libx11-data libx11-xcb1 libx264-164 libx265-199 libxau6 libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-present0 \
libxcb-randr0 libxcb-render0 libxcb-shm0 libxcb-sync1 libxcb-xfixes0 libxcb1 libxdamage1 libxdmcp6 libxext6 libxfixes3 libxi6 libxml-libxml-perl \
libxml-namespacesupport-perl libxml-parser-perl libxml-sax-base-perl libxml-sax-expat-perl libxml-sax-perl libxml-twig-perl libxml-xpathengine-perl libxmuu1 \
libxrender1 libxshmfence1 libxslt1.1 libxv1 libxvidcore4 libxxf86vm1 libyaml-0-2 libyaml-libyaml-perl libz3-4 libzimg2 libzmq5 \
ocl-icd-libopencl1 perl perl-modules-5.36 perl-openssl-defaults pinentry-curses pocketsphinx-en-us \
python3-certifi python3-cffi-backend python3-chardet python3-charset-normalizer python3-cryptography python3-gpg python3-idna python3-jwt python3-ldb \
thin-provisioning-tools ucf uidmap va-driver-all vdpau-driver-all  xauth xdg-user-dirs xfsprogs xsltproc xz-utils  zstd \
apparmor binutils binutils-aarch64-linux-gnu bridge-utils cifs-utils criu cstream dosfstools dtach ebtables libcephfs2 \
libcfg7 libcmap4 libcorosync-common4 libcpg4 libcrypt-openssl-bignum-perl libcrypt-openssl-random-perl libcrypt-openssl-rsa-perl libjs-bootstrap \
libjs-jquery  libjson-glib-1.0-0 libjson-glib-1.0-common libjson-perl libjson-xs-perl libknet1 liblinux-inotify2-perl \
libnet1 libnetaddr-ip-perl libnetfilter-log1 libnfsidmap1 libnozzle1  libposix-strptime-perl libprotobuf-c1 libprotobuf32 libqb100 \
libqrencode4 libquorum5 librados2 libradosstriper1 librbd1 librdkafka1 librgw2 librrd8 librrds-perl \
 libvotequorum8 lvm2  lzop nfs-common  numactl  python3-ceph-argparse python3-ceph-common \
python3-cephfs python3-protobuf python3-rados python3-rbd python3-rgw \
python3-samba python3-talloc python3-tdb python3-yaml qrencode rpcbind \
rrdcached samba-common samba-common-bin samba-dsdb-modules sgml-base smartmontools smbclient socat sqlite3 init systemd  efibootmgr gettext-base grub-common grub-efi grub-efi-arm64 grub-efi-arm64-bin grub-efi-arm64-signed grub2-common \
libefiboot1 libefivar1 mokutil os-prober console-setup \
shim-helpers-arm64-signed shim-signed shim-signed-common shim-unsigned secureboot-db

LC_ALL=C DEBIAN_FRONTEND=noninteractive chroot $rootfssrc apt clean
LC_ALL=C DEBIAN_FRONTEND=noninteractive chroot $rootfssrc rm /var/lib/apt/* -rf
LC_ALL=C DEBIAN_FRONTEND=noninteractive chroot $rootfssrc rm /var/cache/* -rf

mksquashfs $rootfssrc /root/pve-base.squashfs 
