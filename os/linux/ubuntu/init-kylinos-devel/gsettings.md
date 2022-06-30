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

## 一、gsettings 使用
### 查看所有的schema
```bash
$ gsettings list-schemas
```

### 查看指定schema对应的所有key
```bash
$ gsettings list-keys org.ukui.style
```

### 查看所有的gsettings对应的值
方便用grep进行过滤。
```bash
$ gsettings list-recursively | grep screensaver
```

### 获取某一个值
```bash
$ gsettings get org.ukui.control-center.personalise save-transparency
```

### 设置某一个值
```bash
$ gsettings set org.ukui.control-center.personalise save-transparency 75
```

### 监视对应key的值
```bash
$ gsettings monitor org.ukui.style
```

### v10 sp2上对应的gsettings值
| SCHEMA | KEY | | Qt QGsettings 中查看值 | DESCRIPTION |
| :----- | :-- | :-------------- | :---------- |
| org.ukui.peony.settings | show-trash-dialog | showTrashDialog | 删除文件、目录显示删除对话框，默认为true显示, 可选为true, false |
| org.ukui.peony.settings | show-hidden-file | showHiddenFile | 目录显示隐藏文件，默认为false不显示，可选为true, false |
| org.ukui.style | icon-theme-name | iconThemeName | ukui-icon-theme-default | 控制面板->主题->图标主题，默认为ukui-icon-theme-default，
        可选值： 默认:ukui-icon-theme-default, 经典: ukui-icon-theme-classical， 时尚：ukui-icon-theme-fashion, 和印：ukui-icon-theme-HeYin, 寻光：ukui-icon-theme-lightseeking |

| org.ukui.style | style-name | styleName | 控制面板->主题->主题模式，默认为ukui-default（白色）, 可选值: ukui-default(白色), ukui-dark(黑色) |
| org.ukui.style | system-font-size | systemFontSize | 控制面板->字体->字体大小，默认为11，可选值为10， 11， 12， 13， 14， 15 |


## 二、QGsettings 使用

图形化的dconf-editor根据path来检索GSettings并管理key，而且支持在key发生改变时发出信号通知。

```bash
### 1. 相关依赖包
```bash
sudo apt install qtbase5-dev qt5-qmake qtchooser qtscript5-dev qttools5-dev-tools qtbase5-dev-tools libgsettings-qt-dev dconf-editor devhelp
```

# Qt的工程文件.pro中，加入如下两行
```shell
CONFIG += link_pkgconfig
PKGCONFIG += gsettings-qt
```

# 编译, 其中qgsettings-demo.gschema.xml 是gsettings配置文件，需要自己写
```shell
sudo install -m 0644 qgsettings-demo.gschema.xml /usr/share/glib-2.0/schemas  # 环境变量XDG_DATA_DIRS/glib-2.0/schemas/路径
sudo glib-compile-schemas /usr/share/glib-2.0/schemas  # glib-compile-schemas将schema文件编译为二进制文件
qmake
make
```

### 2. 配置文件解释

GSettings的配置文件是xml格式的，文件需以.gschema.xml结尾，一个配置文件里面可以包含多个schema，每个schema可由多个key组成（key是无法通过代码动态创建的）。

在schema文件中，通常一个id对应一个固定的path，但也可不设置path，这样就是一个可重定位的schema，path两头必须都有/，否则会验证失败。

但是需要注意如果没有指定path属性，则gsettings无法被dconf-editor读取。

| 字段        | 说明                                                         |
| :---------- | :----------------------------------------------------------- |
| id          | schema中的id在整个配置系统中是唯一的，否则在执行glib-compile-schemas时会忽略重复的id的开头通常使用与应用相关的域名。 |
| path        | schema中的path必须是以/开头并且以/结尾，不能包含连续的/，path用于指定在storage中存储路径，可以与id不一致。 |
| name        | key的名称，需要在此schema中唯一，name的值由小写字母、数字和-组成，并ä¸开头必须是小写字母，不能以-结尾，也不能出现连续的-。 |
| type        | key的类型，需要是GVariant支持的类型，除了可以使用基本的类型外，也可按照GVariant的方式组合类型。 |
| default     | key的默认值                                                  |
| summary     | key的简单描述                                                |
| description | key的详细描述                                                |



### 3. gsettings命令

| 命令                                | 说明                                                         |
| :---------------------------------- | :----------------------------------------------------------- |
| gsettings list-schemas              | 显示系统已安装的不可重定位的schema(已安装并已安装并有固定path的 schema)。 |
| gsettings list-relocatable-schemas  | 显示已安装的可重定位的schema(已安装却没有固定path的 schema)。 |
| gsettings list-children SCHEMA      | 显示指定schema的children，其中SCHEMA为xml文件中schema的id属性值，如示例代码中daemon的”apps.eightplus.qgsettings-demo”。 |
| gsettings list-keys SCHEMA          | 显示指定schema的所有项(key)。                                |
| gsettings range SCHEMA KEY          | 查询指定schema的指定项KEY的有效取值范围。                    |
| gsettings get SCHEMA KEY            | 显示指定schema的指定项KEY的值。                              |
| gsettings set SCHEMA KEY VALUE      | 设置指定schema的指定项KEY的值为VALUE。                       |
| gsettings reset SCHEMA KEY          | 恢复指定schema的指定项KEY的值为默认值。                      |
| gsettings reset-recursively SCHEMA  | 恢复指定schema的所有key的值为默认值。                        |
| gsettings list-recursively [SCHEMA] | 如果有SCHEMA参数，则递归显示指定schema的所有项(key)和值(value)，如果没有SCHEMA参数，则递归显示所有schema的所有项(key)和值(value)。 |


