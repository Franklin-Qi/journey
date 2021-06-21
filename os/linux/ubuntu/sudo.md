# 免密码使用sudo和su
```shell
$ su -
$ vi /etc/sudoers

# Add your username
kylin   ALL=(ALL)       NOPASSWD:ALL
%admin  ALL=(ALL)       NOPASSWD:ALL
```
```
