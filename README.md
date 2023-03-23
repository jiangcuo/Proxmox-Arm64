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
- public version = 7.4-2
- testing version = 7.4-2

### pbs
- public version = 2.3.1-1
- testing version = 2.3.1-1

## 4. Installtion

If you are using arm64 server that supports EFI,you can install proxmox-ve with iso.

https://mirrors.apqa.cn/proxmox-edge/unofficialiso/proxmox-ve-arm64_7.3-1.iso 

If you are using u-boot device or failed with iso, you can install proxmox-ve from repo.

Head to the wiki page to learn more.

## Passthrough
Hardware passthrough looks good

![ ](https://raw.githubusercontent.com/jiangcuo/Proxmox-Arm64/main/images/pasthrough.png)

## More ?

https://github.com/jiangcuo/Proxmox-Arm64/wiki
