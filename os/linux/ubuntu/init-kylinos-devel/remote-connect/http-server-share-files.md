`Tags:` 共享文件和目录 惠普扫描仪

# linux通过web浏览器共享文件和目录
`Http-server` 是一个用 NodeJS 编写的简单的可用于生产环境的命令行 http 服务器。
它不需要配置，可用于通过 Web 浏览器即时共享文件和目录。

## npm安装http-server
```shell
$ npm install -g http-server
```

现在进入任何目录并通过 HTTP 共享其内容，如下所示。
```shell
$ cd ~/nfs/
$ http-server -p 8000

Starting up http-server, serving ./
Available on:
    http://127.0.0.1:8000
    http://172.30.40.148:8000
    Hit CTRL-C to stop the server
```
现在你可以使用 URL 从任何远程系统访问此文件夹的内容 - http://<ip-address>:8000。

## windows共享文件
目录属性-》共享开启共享和高级共享（权限全打开），保存后的网络路径就是本机可访问的路径，
但在其他Linux平台不可访问。

可以用于惠普扫描仪网络扫描`（http://172.30.40.141/）`的扫描到网络的网络路径。
