# ssh 技巧

# 免密码登录

[!免密码登陆](https://www.cnblogs.com/cangqinglang/p/11098556.html)

ssh-keygen -t rsa -P ''
ssh-copy-id -i .ssh/id_rsa.pub shangzekai@10.140.112.40



## ssh 链接失败
2台机器，一个自动获取网络(computer-01)，一个手动设置网络(computer-02)，computer-01 能ssh 手动设置网络的机器(computer-02)，
但是computer-02 不能连接自动连接IP的机器。但是手动设置网络机器里面配置文件很多，易于操作，因此需要通过compute2 ==> computer1。

### 原因及解决方法
2台机器路由不一致，通过ssh连接情况能体现出来。
一个自动，一个手动有问题，需要都是手动，这样一个网段下路由保持一致，可以ssh进行连接。

### bugging
1. WARNING: REMOTE IDENTIFICATION HAS CHANGED!
删除~/.ssh/known_hosts 中对应的IP记录
