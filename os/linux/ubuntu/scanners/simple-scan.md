# simple-scan详解
本文目录
=================

* [一、simple-scan编译](#一simple-scan编译)
* [二、simple-scan日志](#二simple-scan日志)

## 一、simple-scan编译
获取Ubuntu源码
```shell
$ git clone https://git.launchpad.net/ubuntu/+source/simple-scan
```

simple-scan-autobuild.sh内容如下
```shell
#!/bin/bash

meson --prefix $PWD/_install _build
ninja -C _build all install
XDG_DATA_DIRS=_install/share:$XDG_DATA_DIRS ./_install/bin/simple-scan
```
执行如下命令进行编译
```shell
cd simple-scan/ ; bash simple-scan-autobuild.sh
```

## 二、simple-scan日志
```shell
$ simple-scan --debug

$ vi ~/.cache/simple-scan/simple-scan.log
```

## 双面扫描
•
您无法调整扫描区域。
•
DCP-8070D 和 MFC-8370DN 不支持双面扫描。
•
使用 Legal 尺寸的纸张时，无法进行双面扫描。
•
仅当使用自动进稿器时方可进行双面扫描。

当文档放置在稿台玻璃上时，本机无法自动对文档进行双面扫描。

