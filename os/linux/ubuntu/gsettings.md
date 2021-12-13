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
