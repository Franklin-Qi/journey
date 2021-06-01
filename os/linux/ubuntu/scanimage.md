本文目录
=================

* [一、scanimage使用](#一scanimage使用)
* [二、scanimage调试](#二scanimage调试)

# 一、scanimage使用
后端功能检测可以通过`scanimage -L`(属于sane-utils) 查找设备。
```
scanimage --device-name=pixma:04A91912_435F94 --resolution=300 --format=jpeg >scanner.jpg
```

# 二、scanimage调试
`man scanimage`可以看到SANE_DEBUG_DLL选项，可以通过以下进行调试scanimage
```
SANE_DEBUG_DLL=5 scanimage -L
```
