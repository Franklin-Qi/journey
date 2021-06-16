# locale中文英文互换

## 安装中文字体
```shell
sudo dpkg-reconfigure --force locales
sudo apt install fonts-wqy-microhei
```

## 相关文件
`/etc/default/locale`可以设置默认语言，重启生效
```shell
LANG=zh_CN.UTF-8
LANGUAGE="zh_CN:zh"

或者

LANG=en_US.UTF-8
LANGUAGE="en_US:en"

```

`~/.bashrc`增加默认语言，重启生效
```shell
export LANG=zh_CN.UTF-8
```
