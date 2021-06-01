# apt 常用命令
1.apt-cache search package #搜索包
2.apt-cache show package #获取包的相关信息，如说明，大小，版本。
3.apt-cache depends package #了解使用依赖
4.apt-cache rdepends package #查看该包被那些包依赖
5.sudo apt-get install package #安装包
6.sudo apt-get install package=version #安装指定版本的包
7.sudo apt-get install package --reinstall #重新安装包
8.sudo apt-get -f install #修复安装(这个是启动APT自动安装依赖关系的一个功能键，你更新完源之后，如果APT还不能自行解决依赖关系，可以执行一下)
9.apt-get source package #下载该包的源代码
10.sudo apt-get remove package #删除包
11.sudo apt-get remove package --purge #删除包,包括删除配置文件等
12.sudo apt-get update #更新apt软件源数据库
13.sudo apt-get upgrade #更新以安装的包
14.sudo apt-get dist-upgrade #升级系统
15.sudo apt-get dselect-upgrade #使用dselect升级
16.sudo apt-get build-dep package #安装相关的编译环境
17.sudo apt-get clean & sudo apt-get autoclean #清理无用的包
18.sudo apt-get check #检查是否有损坏的依赖

## 如何获取ubuntu源码包里面的源码？

1、在获取源码包之前，确保在软件源配置文件/etc/apt/sources.list中添加了deb-src项
2、使用如下命令获取xxx源码包的详细信息:
 sudo apt-cache showsrc xxx 这用来查询当前镜像站点中是否有该源码包。
 或者通过 dpkg -S xxx


3、源码包中通常包含3个文件，分别以dsc，orig.tar.gz和diff.gz为后缀名。
 sudo apt-get source  xxx    命令来获取源码包，它会将源码包下载到用户当前目录

并在命令执行过程中，调用dpkg-source命令，根据dsc文件中的信息，将源码包解压到同名目录中，应用程序的源代码就在这里面。

sudo apt-get source xxx

要强调的是，在下载源码包前，必须确保安装了dpkg-dev（执行”apt-get install dpkg-dev”来安装），
否则，只会下载源码包的3个文件，但不会解压缩源码包。当然你也可以自己用dpkg-source命令去解压缩源码包。

4、在编译源码包前，需要安装具有依赖关系的相关软件包。使用”apt-get build-dep”命令可以主动获取并安装所有相关的软件包。

sudo apt-get build-dep xxx

5、现在可以来编译源码包了，首先进入源码所在目录，使用dpkg-buildpackage命令来编译源码包，它会将生成的Deb软件包放置在上层目录中。
cd xxx
sudo dpkg-buildpackage

这样就会编译生成xxx_i386.deb

6、安装软件包。使用”dpkg –i”命令来安装生成的Deb软件包。

sudo dpkg -i  xxx_i386.deb

## 文件所属包查找命令
dpkg-query  -S $(which sane)  //文件属于哪个包
dpkg -S  /usr/bin/ldd

// 先安装apt-file, sudo apt-file update
apt-file search libz.so.1     //缺少libz.so.1这个库文件,右边的是匹配你的库，左边的是你查的库所在的包，所以最后安装对应的包就行了

## man 中文化以及哪些命令被中文化
$ sudo apt-get install manpages-zh
$ apt-file list manpages-zh | less  # 可以查找命令，如paste

## ubuntu 编译程序源码查找
$ apt-file list kylin-video  # 查找kylin-video 的文件
$ apt-file search sane.h # 查找sane.h 所在包，不加文件路径也行

## 可执行文件文件依赖情况
$ ldd xxx # 文件依赖情况
$ ps -ef |grep xxx && cat /proc/xxx-pid/maps
$ objdump -x $(which xxx) | grep NEEDED
$ readelf -a xxx |grep Shared # faild

## ubuntu apt 源
```
V10.1内网源：
deb http://archive.launchpad.dev/kylin v101 main restricted universe multiverse
deb http://archive.launchpad.dev/kylin-desktop v101 main restricted universe multiverse
deb http://archive.launchpad.dev/kylin-desktop v101-updates main restricted universe multiverse
deb http://archive.launchpad.dev/kylin-desktop v101-proposed main restricted universe multiverse

V10内网源（arm&x86）：
deb http://archive.launchpad.dev/kord juniper main restricted universe multiverse
deb http://archive.launchpad.dev/kord juniper-security main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop v100 main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop v100-updates main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop v100-proposed main restricted universe multiverse
（sp1-ppa）deb http://ppa.launchpad.dev/neokylin/ukui3.0-v10-desktop/kylinos-desktop v100 main

V10内网源（mips）：
deb http://archive.launchpad.dev/kord-loongson juniper main restricted universe multiverse
deb http://archive.launchpad.dev/kord-loongson juniper-proposed main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop v100 main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop v100-updates main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop v100-proposed main restricted universe multiverse
（sp1-ppa）deb http://ppa.launchpad.dev/neokylin/ukui3.0-v10-desktop/kylinos-desktop v100 main

V4-sp4内网源（arm&x86）：
deb http://archive.launchpad.dev/kord juniper main restricted universe multiverse
deb http://archive.launchpad.dev/kord juniper-security main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop juniper.sp4 main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop juniper.sp4-updates main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop juniper.sp4-proposed main restricted universe multiverse

V4-sp4内网源（mips）：
deb http://archive.launchpad.dev/kord-loongson juniper main restricted universe multiverse
deb http://archive.launchpad.dev/kord-loongson juniper-proposed main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop juniper.sp4 main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop juniper.sp4-updates main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop juniper.sp4-proposed main restricted universe multiverse

V4-sp3内网源：
deb http://archive.launchpad.dev/kord juniper main restricted universe multiverse
deb http://archive.launchpad.dev/kord juniper-security main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop juniper.sp3 main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop juniper.sp3-updates main restricted universe multiverse
deb http://archive.launchpad.dev/kylinos-desktop juniper.sp3-proposed main restricted universe multiverse

V4-sp2内网源：
deb http://archive.launchpad.dev/kord juniper main restricted universe multiverse
deb http://archive.launchpad.dev/kord juniper-security main restricted universe multiverse
deb http://archive.launchpad.dev/neokylin juniper main restricted universe multiverse
deb http://archive.launchpad.dev/neokylin juniper-updates main restricted universe multiverse

V4-sp1内网源：
deb http://archive.launchpad.dev/kord juniper main restricted universe multiverse
deb http://archive.launchpad.dev/kord juniper-security main restricted universe multiverse
deb http://archive.launchpad.dev/neokylin juniper main restricted universe multiverse
deb http://archive.launchpad.dev/neokylin juniper-sp1 main restricted universe multiverse
```

