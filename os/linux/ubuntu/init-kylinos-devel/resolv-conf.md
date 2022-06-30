# resolv.conf避免重启消失
resolvconf包避免resolv.conf重启消失：
1. sudo apt install resolvconf 
2. cd /etc/resolvconf/resolv.conf.d/
3. 修改 base 和 head文件，增加以下内容：
```shell
nameserver 172.20.191.2
nameserver 114.114.114.114
```
