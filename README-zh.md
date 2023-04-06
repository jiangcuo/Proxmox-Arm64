# Proxmox-Arm

[Englist](README.md) | [中文](README-zh.md)

## 获取有限的支持

mail: jiangcuo@bingsin.com

issue: https://github.com/jiangcuo/Proxmox-Arm64/issues

qq群组：750937440

## 1. 测试的平台 (arm64):
- Rockpi
- Raspberry Pi
- Amlogic TV box
- Kunpeng
- FT 由于该产品的系列有点多，最好先安装debian再安装proxmox ve
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
- public version = 2.4.1-1
- testing version = 2.4.1-1

## 4. Installtion

如果使用带efi的设备，可以使用ISO安装

https://mirrors.apqa.cn/proxmox/isos/

如果使用u-boot启动的设备，请先安装好debian或者armbian再安装proxmox ve

这部分请参考wifi

## 直通
目前已经过测试，可以直通io卡，显卡有问题。

![ ](https://raw.githubusercontent.com/jiangcuo/Proxmox-Arm64/main/images/pasthrough.png)

## 了解更多 ?

请参考wiki页面

https://github.com/jiangcuo/Proxmox-Arm64/wiki
