# 华为云安装v10.1 arm虚拟机
实体机较少，而且由于本机架构限制，x86主机装不了arm架构的。
所以可以在华为云上进行虚拟机的安装。

## 一、华为云安装虚拟机
浏览器地址： 10.1.80.179
密码： Q!W@E#R$9000

## 二、安装操作
资源池 -> ManagementCluster -> CNA-1 单击后进行新建虚拟机V10.1-arm。
一路next,然后完成，并选择配置中的光驱（通过文件挂载）然后打开虚拟机。

安装v10.1 时，需要配置netmanage, 选择第2个。

## 三、华为云环境软件问题

华为云内存有限，有时会打开软件出错，如打开音乐出错，可以`free -m`查看系统可用内存，判断是否内存不足导致问题。
