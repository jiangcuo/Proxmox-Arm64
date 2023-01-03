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
echo "deb https://mirrors.apqa.cn/proxmox/ pvearm main ">/etc/apt/sources.list.d/foxi.list
curl -L https://mirrors.apqa.cn/proxmox/gpg.key |apt-key add 
```

You need first change dhcp to static and install ifupdown or ifupdown2 avoid losing network connectivity during installation( we remove the ifupdown2 in pve-manager depends, but we still recommend install it first).

```
apt update 
apt install ifupdown2 -y
apt install proxmox-ve -y
```

### Proxmox Backup Server

```
echo "deb deb https://mirrors.apqa.cn/proxmox/ pbsarm main">/etc/apt/sources.list.d/foxi-pbs.list
curl -L  deb https://mirrors.apqa.cn/proxmox/gpg.key |apt-key add 
apt update && DEBIAN_FRONTEND=noninteractiv apt --no-install-recommends install proxmox-backup-server 
```

## More ?

https://github.com/jiangcuo/Proxmox-Arm64/wiki
