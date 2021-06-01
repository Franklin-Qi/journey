本文目录
=================

* [一、simple-scan编译](#一simple-scan编译)
* [二、simple-scan日志](#二simple-scan日志)

# 一、simple-scan编译
simple-scan-autobuild.sh内容如下
```
#!/bin/bash

meson --prefix $PWD/_install _build
ninja -C _build all install
XDG_DATA_DIRS=_install/share:$XDG_DATA_DIRS ./_install/bin/simple-scan
```
执行如下命令进行编译
```
cd simple-scan/ ; bash simple-scan-autobuild.sh
```

# 二、simple-scan日志
```
vi ~/.cache/simple-scan/simple-scan.log
```
