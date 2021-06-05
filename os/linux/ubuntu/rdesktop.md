本文目录
=================

* [一、ubuntu连接windows原因](#一ubuntu连接windows原因)
* [二、rdesktop使用](#二rdesktop使用)
   * [1. windows准备工作](#1-windows准备工作)
   * [2. ubuntu准备工作](#2-ubuntu准备工作)

# 一、ubuntu连接windows原因
笔记本Windows10 可以使用google查找资料，同时也能用微信客户端，访问github也比较快。但是ubuntu为主要的办公电脑，开发代码都在ubuntu机器上，需要将ubuntu作为主要机器。

为了综合2者优点，不用来回切换笔记本和台式机，只在一个显示器上用cherry键盘就可以进行专注工作，那么就要在ubuntu上连接Windows。

# 二、rdesktop使用
rdesktop在ubuntu上是个很好的远程连接工具。
## 1. windows准备工作
设置->主题->鼠标光标下的方案下拉框里，选择Windows 黑色(系统方案)，避免鼠标光标消失。

此电脑属性->远程设置->允许远程连接（取消默认仅允许运行...计算机连接）进行运行远程连接。

## 2. ubuntu准备工作
安装rdesktop
```
sudo apt install rdesktop
```
rdesktop开始远程连接
```
rdesktop -f -a 16 winip   # winip 为Windows ip地址
```
rdesktop切换全屏可用`Ctrl+Alt+Enter`。

复制粘贴：
从window复制的内容粘贴到Ubuntu可以完美进行，但Ubuntu的内容复制粘贴到window不行。

重启window的rdpclip.exe和相应remote服务不生效.
```
```
