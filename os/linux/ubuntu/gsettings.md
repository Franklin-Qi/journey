# gsettings
Table of Contents
=================

* [gsettings](#gsettings)
   * [gsettings 使用](#gsettings-使用)
      * [查看所有的schema](#查看所有的schema)
      * [查看所有的gsettings对应的值](#查看所有的gsettings对应的值)
      * [获取某一个值](#获取某一个值)
      * [设置某一个值](#设置某一个值)

GSettings是一个让你无需直接对话到存储实际的后台访问键/值对（例如，永久的应用程序设置）数据（配置文件时，GConf，dconf），
提供了列出所有的schema，列出指定schema中的键，设置与获取具体的键的值。具体的命令可以参看man gsettings查看。

## gsettings 使用
### 查看所有的schema
```bash
gsettings list-schemas
```

### 查看所有的gsettings对应的值
方便用grep进行过滤。
```bash
gsettings list-recursively | grep screensaver
```

### 获取某一个值
```
gsettings get org.ukui.control-center.personalise save-transparency
```

### 设置某一个值
```
gsettings set org.ukui.control-center.personalise save-transparency 75
```
