## deepin 命令行安装
有的笔记本带有指纹识别功能，可以通过安装相关包启动指纹解锁功能，更加方便解锁。
``` bash
sudo apt-get install fprintd
fprintd-enroll    // 录入指纹
sudo apt install libpam-fprintd
```

另请参考: [Fingerprint GUI](1)

[1]: https://launchpad.net/~fingerprint/+archive/ubuntu/fingerprint-gui