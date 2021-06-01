# scan
扫描软件所需库。

apt-get install sane
apt-get install libsane-dev   => /usr/include/sane/sane.h

/usr/share/doc/sane

在linux系统中如果使用了sane，是否还需要扫描仪的驱动？
不需要驱动，只需要sane ,sane front end 也是可选的。

## 设备检测
首先要查询如何在Linux下使用扫描仪，可以连线到：http://www.sane-project.org/sane-supported-devices.html ，
该站点不仅有最流行的Linux扫描仪软件，而且还有兼容硬件的数据库，可以查询扫描仪的兼容和可使用状况

查询后通常会得到以下六个查询结果：

1． complete（完全支持Linux下使用扫描仪，并且可以使用扫描仪的所有功能和分辨率）。
2． good（大部分功能支持Linux下使用，但是可能有一些小缺陷）。
3． basic （基本上支持Linux下使用，许多功能不能实现） 。
4． minimal （最小程度上支持Linux下使用，但是工作质量不理想）。
5． untested（没有经过测试可能可以使用）。
6． unsupported（不能使用）。
　　Linux对SANE的支持包括两个方面：1.对底层接口设备的支持（SCSI和USB等）；2.对一个具体型号的支持。
　　SANE是一个应用程序接口，它包含三个部分，使用命令查询：
rpm -qa|grep sane
sane-frontends-1.0.9-2  ＃实现API的库（中间件）
sane-backends-1.0.9-5   ＃访问扫描以的驱动程序（后端程序）
xsane-gimp-0.89-3   #gimp的扫描仪插件
sane-backends-devel-1.0.9-5
xsane-0.89-3 ＃调用API的程序（前端程序）

　　SANE的配置文件是：/etc/sane.d/dll.conf 和/etc/sane.d/目录下的其他文件。

　　/etc/sane.d/dll.conf：本身包含许多后端程序列表。它们通常以扫描仪制造商命名。SANE调用时会搜索这个列表。

　　特定扫描仪配置文件：除了/etc/sane.d/dll.conf之外，/etc/sane.d/还包含一些其他特定扫描仪的配置文件，这些文件是工具后端程序命名的，后缀是.conf。


## 设备检测
通常有两个命令可以查询扫描仪的情况，sane-find-scanner和scanimage。sane-find-scanner用来搜索本地扫描仪的接口
使用scanimage加参数-L 用来设备扫描仪的具体型号

## scanimage -L
device `snapscan:/dev/usb/scanner0' is a Acer FlatbedScanner13
　　正确检测到扫描仪的型号之后，下面就可以调用Linux下的扫描程序进行工作了。
　　Scanimage是一个命令行下的工具，可以直接进行扫描：

## scanimage –d /dev/usb/scanner0 －mode color >1.pnm
　　这样一个1.pnm格式的图像文件就生成了。

## 同类前端扫描软件kooka依赖解决
```
sudo apt install  extra-cmake-modules cmake-extras cmake-doc cmake-data cmake-qt-gui
sudo apt install libkf5config* libkf5kio* libkf5widgetsaddons* libtiff libkf5doctools* 
```

## 相关网址
[sane-frontends](http://www.sane-project.org/sane-frontends.html)
[sane man](https://linux.die.net/man/7/sane)
[leadtools demo](https://www.leadtools.com/help/sdk/v20/sane/api/demo-programs.html)
[维护人邮件](ljm@xs4all.nl)
