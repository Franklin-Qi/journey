# sane-backends如何适配驱动？
`扫描驱动`是由指定扫描仪厂商进行研发的包含动态库等文件的deb包，如`drc240_1.00-1.2.mips64.deb`驱动就是由佳能厂商研发。
`适配驱动`是指定扫描仪厂商已经适配了sane-backends，通过安装驱动包能实现正确扫描。

sane-backens默认已经集成了一些扫描驱动，驱动列表在`/etc/sane.d/dll.conf`可查看，
这也就是有些扫描仪不额外安装驱动（其实已经默认集成）也能直接使用的原因。

## sane-backends一般适配流程
sane-backends的驱动适配，就是安装的驱动包需要将相关的库文件、配置文件和规则rules文件放到
系统的指定路径下。目的是最后能正确扫描，或者能判断是驱动的问题，让对应扫描驱动重新适配。

因此需要开启日志进行如下检查：
1. 库文件路径和库文件名称，可以修改库文件名称（如增加后缀.1）或者ln -sf 软链接进行修改。
2. dll.conf末尾是否增加新的驱动后端扫描名
3. 配置文件和规则文件是否在指定目录

如果遇到安装驱动后，不能正确扫描，这时可以开启sane-backends的日志环境手动进行对应的驱动文件路径调整，
以此判断是操作系统的问题还是驱动的问题。

## sane-backends的dll.conf详解
sane-backends已经包括了常见的扫描仪驱动,这些支持的扫描仪列表可以在/etc/sane.d/dll.conf中查看。
在/etc/sane.d/dll.conf名称中的都是支持的扫描仪后端名。

sane-backends通过dll.conf中的后端名会逐个进行加载对应的配置文件和动态库，
所以当新适配一个驱动时，安装完驱动包，这个文件中应该新增一行驱动扫描后端名数据，
用于查找新适配的动态库和配置文件。

## sane-backends驱动相关路径检查
扫描驱动安装后需要检查系统相关目录信息。
```bash
1. 库文件so目录:
    /usr/lib/mips64el-linux-gnuabi64/sane/  # v10 sp1 mips
    /usr/lib/mips64el-linux-gnu/sane/  # v10 mips

2. 配置文件路径:
    /etc/sane.d/*  # 其中dll.conf去查找每个具体配置文件，如canon_dr.conf

3. 规则rules文件路径： 
    /etc/udev/rules.d/
    /lib/udev/rules.d/
    /usr/lib/udev/rules.d/
```
## sane-backends日志环境变量设置
```bash
$ export SANE_DEBUG_DLL=4  # 通用，查看dll.c加载动态库的情况
$ export SANE_DEBUG_XXX=4  # 可选，查看指定扫描仪的情况，xxx为/etc/sane.d/dll.conf中扫描后端名大写
$ export SANE_DEBUG_SANEI_USB=128 # 可选，查看sanei中函数的调用情况
$ export SANE_USB_WORKAROUND=1 # 可选，如果在插入usb后不生效，可以查看内核版本相关信息
$ scanimage -h -L # 查看具体的扫描仪设备列表
```

## sane-backends适配实例
下面是v10 sp1 mips架构下sane-backens适配厂商给的drc240_1.00-1.2.mips64.deb实例。

### 问题描述
Bug编号：#64291
Canon DR-C240 扫描仪在V10 SP1(0326) MIPS 版本下无法使用，但在v10的MIPS上可以使用。

### 问题分析
此问题属于驱动适配问题,因此要手动调整驱动文件路径，判断是否是驱动本身问题。

1. dpkg-deb -c查看驱动提供的相关文件信息
```bash
yushuoqi@yushuoqi:~$ dpkg-deb -c drc240_1.00-1.2.mips64.deb 
drwxrwxr-x kylin/kylin       0 2021-07-02 14:32 ./
drwxrwxr-x kylin/kylin       0 2020-07-06 10:08 ./opt/
drwxrwxr-x kylin/kylin       0 2020-07-06 10:08 ./opt/Canon/
drwxrwxr-x kylin/kylin       0 2020-07-06 10:08 ./opt/Canon/lib/
drwxrwxr-x kylin/kylin       0 2020-07-06 10:08 ./opt/Canon/lib/canondr/
-rwxrwxr-x kylin/kylin 1051552 2020-07-06 10:08 ./opt/Canon/lib/canondr/canondr_backenddrc240
-rwxrwxr-x kylin/kylin  132408 2020-07-06 10:08 ./opt/Canon/lib/canondr/canondr_com_usbdrc240
drwxrwxr-x kylin/kylin       0 2020-07-06 10:08 ./opt/Canon/lib/canondr/drc240/
-rw-rw-r-- kylin/kylin    3401 2020-07-06 10:08 ./opt/Canon/lib/canondr/drc240/80-cndrvsane.rules
-rw-rw-r-- kylin/kylin   18002 2020-07-06 10:08 ./opt/Canon/lib/canondr/drc240/COPYING
-rwxrwxr-x kylin/kylin 3247408 2020-07-06 10:08 ./opt/Canon/lib/canondr/drc240/CeiVSLinux.so
-rwxrwxr-x kylin/kylin  460368 2020-07-06 10:08 ./opt/Canon/lib/canondr/drc240/CsdCore.so
-rw-rw-r-- kylin/kylin   24218 2020-07-06 10:08 ./opt/Canon/lib/canondr/drc240/LICENSEE.txt
-rw-rw-r-- kylin/kylin   26291 2020-07-06 10:08 ./opt/Canon/lib/canondr/drc240/LICENSEJ.txt
-rwxrwxr-x kylin/kylin    2695 2020-07-06 10:08 ./opt/Canon/lib/canondr/drc240/canondr.conf
-rwxrwxr-x kylin/kylin  214272 2020-07-06 10:08 ./opt/Canon/lib/canondr/drc240/libsane-canondr.so
```
由此，可以看到驱动的库文件为`libsane-canondr.so`，也就是代表此款扫描仪的后端扫描名为`canondr`，
正确的情况应该如下：
    - dll.conf应该新增一行`cannondr`数据。
    - 对应的库文件都在`/usr/lib/mips64el-linux-gnuabi64/sane/`目录下
    - 规则rules文件应该在`/etc/udev/rules.d/`, `/lib/udev/rules.d/`, `/usr/lib/udev/rules.d/`的其中之一

2. 设置sane-backends的日志开关进行获取设备列表
```bash
$ export SANE_DEBUG_DLL=4
$ scanimage -h -L
...
device `canon_dr:libusb:001:002` is a Canon dr-c240 sheetfed scanner
...
```
可以看出，此处对此款扫描仪识别出来的后端名是`canon_dr`，而不是`cannondr`，因此存在问题。
这里获取的后端名是调用了对应的库文件导致的，可以推断如下：
    - dll.conf的canondr没生效，canon_dr生效，因此调用了canon_dr所在的库文件。
可以在dll.conf中注释canon_dr进行尝试。若出现注释后，scanimage -L获取不了设备名，
可以判断确实调用了canon_dr所在的库文件。


3. 根据步骤1获取的出问题的扫描设备名进行查看相关默认参数，并测试是否正确扫描
```bash
$ scanimage -h -d canon_dr:libusb:001:002
```
这里如果遇到参数错误，可以查看默认的参数，进行手动设置参数，如下：
```bash
$ scanimage -d canon_dr:libusb:001:002 --resolution 75 -l 0 -t 0 -x 215 -y 297 > test.pnm
...
[dll] load sane_open: trying to open `canon_dr:libusb:001:002`
[dll] load: searching backend `canon_dr` in `/usr/lib/mips64el-linux-gnuabi64/sane:/usr/lib/sane`
[dll] load: trying to load `/usr/lib/mips64el-linux-gnuabi64/sane/libsane-canon_dr.so.1`
[dll] load: dlopen()ing `/usr/lib/mips64el-linux-gnuabi64/sane/libsane-canon_dr.so.1`
[dll] init: initializing backend `canon_dr`
[dll] init: backend `canon_dr` is version 1.0.58
[dll] sane_open: open successful
...
```
上面可以看到这款扫描仪后端是调用的具体动态库为`libsane-canon_dr.so.1`，是libsane-canon_dr.so的软链接。
因此如果要调用libsane-cannondr.so，也应该创建软链接libsane-canondr.so.1。

所以，根据前3步的分析，可以手动对驱动文件进行以下调整：
```bash
$ sudo cp /opt/Canon/lib/canondr/drc240/*.so /usr/lib/mips64el-linux-gnuabi64/sane/
$ sudo cp /opt/Canon/lib/canondr/drc240/80-cndrvsane.rules /etc/udev/rules.d/
$ sudo cp /opt/Canon/lib/canondr/drc240/canondr.conf /etc/sane.d/
$ sudo vi /etc/sane.d/dll.conf # 末尾增加canondr
$ cd /usr/lib/mips64el-linux-gnuabi64/
$ sudo ln -sf ./libsane-canondr.so ./libsane-canondr.so.1
```
必要时，可以重启系统，再进行步骤1、2、3操作查看具体驱动情况

调整完驱动文件的路径，可以进行扫描测试如下：
```bash
$ export SANE_DEBUG_DLL=4
$ scanimage -h -L
...
device `canondr:libusb:001:002` is a Canon dr-c240 sheetfed scanner
...

$ scanimage -d canondr:libusb:001:002 > test.pnm
...
[dll] load sane_open: trying to open `canondr:libusb:001:002`
[dll] load: searching backend `canondr` in `/usr/lib/mips64el-linux-gnuabi64/sane:/usr/lib/sane`
[dll] load: trying to load `/usr/lib/mips64el-linux-gnuabi64/sane/libsane-canondr.so.1`
[dll] load: dlopen()ing `/usr/lib/mips64el-linux-gnuabi64/sane/libsane-canondr.so.1`
[dll] init: initializing backend `canondr`
[dll] init: backend `canondr` is version 1.0.58
[dll] sane_open: open successful
```
当扫描出test.pnm时，就代表着正确扫描了。这时代表是驱动路径的问题，需要和佳能厂商进行沟通，让驱动研发进行路径的更改，
重新进行适配v10 sp1 mips的环境，而产品部则可以手动进行配置驱动路径让扫描仪正确工作。

此外，如果是驱动路径的问题，可以修改驱动包deb的postinst脚本:
```bash
$ mkdir drc240
$ dpkg-deb -R drc240_1.00-1.2.mips64.deb ./drc240 # 解压包
$ cd drc240
$ vi DEBIAN/postinst # 驱动安装后处理脚本，修改动态库的安装位置，同时增加软链接相关
$ dpkg-deb -b ./drc240 drc240_1.00-1.2-v10-sp1.mips64.deb # 重新做包
$ sudo dpkg -i ./drc240_1.00-1.2-v10-sp1.mips64.deb # 安装修改的驱动包进行扫描

```

## 参考网址
sane手册: https://www.freebsd.org/cgi/man.cgi?query=sane&sektion=7&manpath=freebsd-release-ports
backend后台手册: http://www.sane-project.org/backend-writing.txt
图像扫描仪: https://www.xuchao.org/docs/freebsd/scanners.html
