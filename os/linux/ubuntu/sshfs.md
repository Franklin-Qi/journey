# sshfs用于Ubuntu远程目录挂载到本地
可以将开发代码和资料放到Ubuntu主机，在不同的Ubuntu开发机通过sshfs挂载到开发机本地进行开发。

## sshfs安装
```shell
sudo apt install sshfs
```

## sshfs使用
```shell
$ sshfs 用户名@IP地址:远程目录 本地目录
```
