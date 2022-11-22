# 重新打包Proxmox-VE librust包

你需要使用apt-mirror将下面的开发源镜像下来
`deb https://mirrors.ustc.edu.cn/proxmox/debian/devel/ bullseye main`

随后使用[repacked.sh](./repacked.sh)脚本进行解包并重新封装为arm64平台。

