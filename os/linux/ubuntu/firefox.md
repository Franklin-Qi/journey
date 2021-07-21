# firefox 快捷键

ctrl+b  书签打开与关闭
ctrl+d  书签保存

ctrl+l  定位到地址栏
ctrl+k  定位到搜索栏

ctrl+w  标签页关闭
ctrl+t  标签页新建
shift+ctrl+t 标签页恢复

## launchpad.dev使用
resolvconf包避免resov.conf重启消失：
1. sudo apt install resolvconf 
2. cd /etc/resolvconf/resolv.conf.d/
3. 修改 base 和 head文件，增加以下内容：
```shell
nameserver 172.20.191.2
nameserver 114.114.114.114
```

目前只在火狐浏览器上可以登录，about:config 搜索preloadlist， 修改 
`network.stricttransportsecurity.preloadlist` 为false。
同时/etc/resolv.conf需要设为`172.20.191.2`。
