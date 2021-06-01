## 查看所有的repo
yum repolist all

## 更新所有的rpm, 同时人走后也一直更新
yum update --skip-broken
此处超时出错后，可以关闭超时的yum源，继续进行上述操作。

## rpmbuild 更新依赖 yum-builddep
sudo yum-builddep SPECS/xxx


## bugging
1. rpmbuild -bp 依赖出错
> 1. yum install yum-utils ，使用yum-builddep进行安装，如果失败，可以尝试安装一个，然后所有的进行手动复制安装

2. 源码编译失败
> 1. 一般原则是有rpmbuild的specs文件，则不看源码的README.md 的安装指导,而是参照bugging 1进行操作
当时一直按照源码包进行编译，但是一直失败，同时goa哪里都找不到，此时就停滞了；
应该考虑源码方式不正确，改用rpmbuild进行编译才行。

3. yum 由于升级或配置yum源损坏
/usr/share/bash-completion/completion/yum : No such file or directory
conflicting requests:

```
yum check all //yum: 找不到命令
sudo dnf install /usr/bin/yum //安装yum
rpm -qa | grep yum  //查看已安装的yum
yum check all


```

## linux 查找某个库文件属于哪个rpm包
1. 文件已存在，已安装
rpm -qf xxx

2. 未安装
yum provides xxx  # 如果没有，则Google
