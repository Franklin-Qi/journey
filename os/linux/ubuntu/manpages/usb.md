# 挂载USB
```
mkdir /mnt/usb
df or sudo fdisk -l
mount (-t vfat|nfs) /dev/sdb1 /mnt/usb
cd /mnt/usb/

umount /mnt/usb
```

## usb category
NTFS => 部分操作系统，如果仅windows可选
FAT  => 所有操作系统，linux通用
Ext4 => Linux专用

## usb can read
lsusb

## usb location
mysudo fdisk -l  文件系统，如/dev/sdc1
df -h  文件系统和挂载点(*文件挂载目录*)

## usb mount
mysudo mount /dev/sdc1 /mnt/usb
此时可以从/mnt/usb进行拷贝u盘内容到电脑上。

## usb file and directory size
当前目录大小
```
du -h --max-depth=1
或
du -sh *
```

### Debugging:
Mount is denied because the NTFS volume is already exclusively opened.
```
fuser -m -u /dev/sdc1  => 14152
kill -9 14152
```
/proc/mounts
/dev/sdc1 /run/media/yusq/77 fuseblk rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096 0 0

*Not deals*


