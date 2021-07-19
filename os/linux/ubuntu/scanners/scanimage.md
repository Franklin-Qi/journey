# scanimage详解
scanimage 可以查看当前可用的扫描仪，获取扫描参数等操作。

## scanimage参数获取
```shell
$ scanimage --help -d 'escl:http://172.30.40.141:8080'
...
Geometry:
    -l 48.768..215.9mm [0]
        Top-left x position of scan area.
    -t 48.768..297.011mm [0]
        Top-left y position of scan area.
    -x 48.768..215.9mm [0]
        Width of scan-area.
    -y 48.768..297.011mm [0]
        Height of scan-area.
```
其中，中括号中的值为默认值，也就是说在8080上端口的这台扫描仪默认top-left x为0，
和范围区间[48.768..215.9mm]不符合，所以会出现参数错误。

使用扫描命令，可以避免出现参数错误，但会出现如下错误，暂时未解决该错误。
```shell
$ scanimage -d 'escl:http://172.30.40.141:8080' -l 50 -t 50 -x 215 -y 297 >a.pnm

scanimage: open of device escl:http://172.30.40.141:8080 failed: Device busy
```

参考以下解决方案，未解决：
```shell
$ sudo mkdir -p /var/lock/sane
$sudo chmod a+rwx /var/lock/sane
```

## scanimage使用
后端功能检测可以通过`scanimage -L`(属于sane-utils) 查找设备。
```shell
scanimage --device-name=pixma:04A91912_435F94 --resolution=300 --format=jpeg >scanner.jpg
```

## scanimage调试
`man scanimage`可以看到SANE_DEBUG_DLL选项，可以通过以下进行调试scanimage
```shell
SANE_DEBUG_DLL=5 scanimage -L
```

## 惠普扫描仪驱动使用
### hp-check检查依赖相关
```shell
$ hp-check -t 
```
发现8处error，缺少8个依赖，之后进行安装
```shell
$ sudo apt install libnetsnmp-devel cups cups-devel cups-image python3-notify2 python3-pyqt4-dbus python3-pyqt4 libtool
```
其中，libnetsnmp-devel在Ubuntu用libsnmp-devel替代,
python3-pyqt4* 用python3-qtpy替代
cups-devel 用 libcups2-dev 替代

```shell
$ sudo apt install hplip hplip-doc hplip-data hplip-gui
```

### hp-scan可以查找扫描仪设备进行扫描
```shell
$ hp-scan
```
