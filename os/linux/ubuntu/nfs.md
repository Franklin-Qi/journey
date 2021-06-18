# 通过nfs将Ubuntu远程目录挂载（mount）到fedora本地
由于项目的复杂性，v7操作系统是Fedora系列，主要开发环境是Ubuntu系列。
此外，一些开发代码和文档也是放在Ubuntu机器上。

需要将Ubuntu机器上的资料和代码在Fedora机器上可见，同时又不想多份拷贝占用内存空间。
这时，就需要通过NFS将Ubuntu服务器的远程目录挂载到Fedora客户端的本地目录。

## NFS简介
`NFS（Network File System）`即网络文件系统，是FreeBSD支持的文件系统中的一种，
它允许网络中的计算机之间通过TCP/IP网络共享资源。
在NFS的应用中，本地NFS的客户端应用可以透明地读写位于远端NFS服务器上的文件，就像访问本地文件一样。

## 将Ubuntu下的~/nfs挂载到Fedora下~/nfs。
按如下配置，可以在Fedora和Ubuntu之间互传文件，且只有一份硬盘数据。

### Ubuntu服务器配置
```shell
$ sudo apt install nfs-kernel-server nfs-common

$ vi /etc/exports # 添加以下一行
/home/yushuoqi/nfs *(rw,sync,no_root_squash) ＃该目录为nfs服务根目录，*表示允许所有的网段访问，也可以使用具体的IP，参数详解在最后

$ sudo mkdir /home/yushuoqi/nfs
$ exportfs -r # 更新配置
$ showmount -e # 查看配置是否生效，生效如下
Export list for yushuoqi:
/home/yushuoqi/nfs

$ sudo systemctl restart nfs-kernel-server # 重启nfs服务

```

### Fedora客户端配置
```shell
$ sudo yum install nfs-utils
$ mkdir /home/yushuoqi/nfs
$ mount -t nfs 172.30.40.149:/home/yushuoqi/nfs /home/yushuoqi/nfs # Ubuntu网络地址为172.30.40.149
```
