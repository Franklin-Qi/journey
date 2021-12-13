# U盘启动器安装系统


## 兆芯B61
下载ISO后，可以用以下命令进行制作U盘启动器：
```
sudo fdisk -l
sudo umount /dev/sdb*
sudo mkfs.ext4 /dev/sdb
sudo dd if=xxx.iso of=/dev/sdb status=progress
```
但会遇到失败情况，可能原因有以下方面：
1. 机器的处理器较新，不支持老版的ISO安装，比如T480就没法安装x86的兆芯，需要找测试同事借老版兆芯笔记本进行安装。

## 龙芯mips
解压ISO后，查看里面的文档
解压ISO:
```
sudo mount -o loop xxx.iso /mnt/iso
```
