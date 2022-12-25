# Proxmox-Arm

## 1. Tested platform (arm64):
- Rockpi
- Raspberry Pi
- Amlogic TV box
- Kunpeng
- FT
- Ampere 

## 2. features

- ramfb support.
- add more pice on vm,so we can hotplug and use more nets disks.(not perfect)
- set gic-version=host.
- tpm

## 3. version

### pve
- public version = 7.3-3
- testing version = 7.3-4

### pbs
- public version = 2.3.1-1
- testing version = 2.3.1-1

## 4. Install pve & pbs from repo

### Proxmox VE

```
echo "deb https://foxi.buduanwang.vip/pan/foxi/Virtualization/proxmox/foxi/ bullseye main">/etc/apt/sources.list.d/foxi.list
curl -L  https://foxi.buduanwang.vip/pan/foxi/Virtualization/proxmox/foxi/gpg.key |apt-key add 
```

You need first change dhcp to static and install ifupdown or ifupdown2 avoid losing network connectivity during installation( we remove the ifupdown2 in pve-manager depends, but we still recommend install it first).

```
apt update 
apt install ifupdown2 -y
apt install proxmox-ve -y
```

### Proxmox Backup Server

```
echo "deb https://foxi.buduanwang.vip/pan/foxi/Virtualization/proxmox/foxi/ pbsarm main">/etc/apt/sources.list.d/foxi-pbs.list
curl -L  https://foxi.buduanwang.vip/pan/foxi/Virtualization/proxmox/foxi/gpg.key |apt-key add 
apt update && DEBIAN_FRONTEND=noninteractiv apt --no-install-recommends install proxmox-backup-server 
```

## 5. Install pve & pbs from source

https://git.proxmox.com/?p=pve-common.git;a=blob_plain;f=README.dev;hb=refs/heads/master

### Build Environment

install proxmox-ve arm on you arm  machine(pimox is ok). or use docker `https://github.com/jiangcuo/pvemaker`

### Dev Repo

```
echo "deb https://foxi.buduanwang.vip/pan/foxi/Virtualization/proxmox/foxi/ pvearmdev main">/etc/apt/sources.list.d/foxi-devel.list
curl -L  https://foxi.buduanwang.vip/pan/foxi/Virtualization/proxmox/foxi/gpg.key |apt-key add 
```
### Some pkg
```
apt-get install devscripts build-essential autotools-dev autogen dh-autoreconf dkms doxygen check pkg-config \
groff quilt dpatch automake autoconf libtool lintian libdevel-cycle-perl \
libjson-perl libcommon-sense-perl liblinux-inotify2-perl libio-stringy-perl \
libstring-shellquote-perl dh-systemd rpm2cpio libsqlite3-dev sqlite3 \
libglib2.0-dev librrd-dev librrds-perl rrdcached libdigest-hmac-perl \
libxml-parser-perl gdb libcrypt-openssl-random-perl \
libcrypt-openssl-rsa-perl libnet-ldap-perl libauthen-pam-perl \
libjson-xs-perl libterm-readline-gnu-perl oathtool libmime-base32-perl \
liboath0 libpci-dev texi2html libsdl1.2-dev libgnutls28-dev \
libspice-protocol-dev xfslibs-dev libnuma-dev libaio-dev \
pve-libspice-server-dev libusbredirparser-dev glusterfs-common \
libusb-1.0-0-dev librbd-dev libpopt-dev iproute bridge-utils numactl \
glusterfs-common ceph-common python-ceph libgoogle-perftools4 \
libfile-chdir-perl lvm2 glusterfs-client liblockfile-simple-perl \
libsystemd-dev libreadline-gplv2-dev libio-multiplex-perl \
libnetfilter-log-dev libipset3 ipset socat libsasl2-dev libogg-dev \
python-pyparsing libfilesys-df-perl libcrypt-ssleay-perl \
libfile-readbackwards-perl libanyevent-perl libanyevent-http-perl \
unzip liblocale-po-perl libfile-sync-perl cstream \
lzop dtach hdparm gdisk parted ttf-dejavu-core \
liblzma-dev dosfstools mtools libxen-dev libfuse-dev libcpg-dev libquorum-dev \
libcmap-dev libuuid-perl libqb-dev libapparmor-dev docbook2x libcap-dev \
dh-apparmor graphviz libseccomp-dev libglib-perl libgtk3-perl libnss3-dev \
libdlm-dev libudev-dev asciidoc-dblatex source-highlight libiscsi-dev \
libiscsi7 librsvg2-bin libarchive-dev libgpgme-dev libcurl4-gnutls-dev \
libtest-mockmodule-perl libjemalloc-dev libjpeg-dev
```
### Building normal pkg

```
git clone https://git.proxmox.com/git/pve-common.git
cd pve-common
yes|mk-build-deps --install --remove 
make deb
```
### Building rust pkg

Install cargo

```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs >>rustinit.sh 
RUSTUP_INIT_SKIP_PATH_CHECK=yes sh rustinit.sh --default-toolchain  nightly  --profile complete -y  

export PATH="$HOME/.cargo/bin:$PATH"
rm /usr/bin/cargo* /usr/bin/rust*
ln -s ~/.cargo/bin/* /usr/bin/
```
Install dh-cargo

```
wget http://download.proxmox.com/debian/devel/dists/bullseye/main/binary-amd64/dh-cargo_28~bpo11%2Bpve1_all.deb
dpkg -i dh-cargo_28~bpo11+pve1_all.deb  
```

Install debcargo

```
cd  /usr/local 
git clone https://salsa.debian.org/rust-team/debcargo.git 
cd debcargo 
cargo build --release  
rm /usr/bin/debcargo 
ln -s /usr/local/debcargo/target/release/debcargo /usr/bin/
```


build rustpkg

```
git clone https://git.proxmox.com/git/proxmox-acme-rs.git
cd proxmox-acme-rs
yes|mk-build-deps --install --remove 
make deb
```
