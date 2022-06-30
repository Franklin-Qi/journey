本文目录
=================

* [一、解决ubuntu系列版本的编译依赖](#一解决ubuntu系列版本的编译依赖)
   * [1. 使用mk-build-deps](#1-使用mk-build-deps)
   * [2. 开启deb-src情况下用apt-get build-dep](#2-开启deb-src情况下用apt-get-build-dep)
   * [3. apt install -f 方式](#3-apt-install--f-方式)
   * [4. 手动使用apt install 逐个安装](#4-手动使用apt-install-逐个安装)

# 一、解决ubuntu系列版本的编译依赖
## 1. 使用mk-build-deps
项目主目录下mk-build-deps创建依赖xxx.deb，并执行apt install进行安装依赖。
```
mk-build-deps debian/control 
sudo apt install ./xxx.deb
rm -f ./xxx.deb
```

## 2. 开启deb-src情况下用apt-get build-dep
编辑/etc/apt/source.list等源文件，增加deb-src列便可以用apt-get build-dep安装依赖。
```
sudo vi /etc/apt/source.list
sudo apt-get install kylin-scanner
```

## 3. apt install -f 方式
在安装失败后，可以用`apt install -f`处理依赖。

## 4. 手动使用apt install 逐个安装
```
sudo apt install xxx xxx xxx
```
