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
