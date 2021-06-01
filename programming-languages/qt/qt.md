# qt

# Install qtcreator
[qt install](https://wiki.qt.io/Install_Qt_5_on_Ubuntu)
通过麒麟软件中心安装的qt有问题，可能是缺少依赖(qt5-default)。
还有的问题是会出现unknown type name 'QString'未定义标识符

qtcreator5.12.4 => http://download.qt.io/archive/qt/
sudo apt-get install gcc g++ libqt4-dev build-essential cmake

sudo apt-get install gcc g++   //安装 linux 下编程的编译器
sudo apt-get install libqt4-dev  //不然编译时会出现错误“cannot find -lgl
sudo apt-get install build-essential //它可以使得我们的程序知道头文件和库函数放在哪个位置
sudo apt-get install cmake g++ //新建project运行编译报错，缺少make


## 初始ukui需要安装的软件
sudo apt install openssh-server
                 libopencv-dev
                 vim git ctags
                 sane sane-utils xsane libsane-dev libsane
                 libglib2.0-dev
                 tesseract-ocr tesseract-ocr-eng tesseract-ocr-chi-sim libleptonica-dev liblept5 libtesseract-dev
                 qtcreator qt5-default qttools5-dev-tools //这个有问题，需要在官网进行下载版本并安装

注：
自己生成的kylin-scanner包可以通过以下方式解决依赖问题：
sudo dpkg -i *.deb
sudo apt install -f
sudo dpkg -i *.deb

## 提示Kit不存在
sudo apt install qt5-default qttools5-dev-tools
option -> qt version -> 选择qmake路径为/usr/lib/qt5/bin/qmake

## 提示gio-2.0 失败
sudo apt install libglib2.0-dev

## 提示sane失败，没找到sane.h头文件
sudo apt install sane sane-utils xsane


# How to getting start qt
通过兆芯的qt creator =>　Welcome => Tutorials => "Example"

## qt chinese
[qtcreator不能输入中文](https://blog.csdn.net/qq_42608626/article/details/95992101)
```
sudo  apt-get install fcitx-frontend-qt5

sudo cp /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/libfcitxplatforminputcontextplugin.so  \
    /opt/Qt5.12.3/Tools/QtCreator/lib/Qt/plugins/platforminputcontexts/

sudo chmod 775 /opt/Qt5.12.3/Tools/QtCreator/lib/Qt/plugins/platforminputcontexts/libfcitxplatforminputcontextplugin.so

```

# 学习网站

## bugs
### QT编辑器不能输出中文
qt creator插件目录：qt安装目录/Tools/QtCreator/lib/Qt/plugins/platforminputcontexts。

需要的fcitx输入法插件文件：libfcitxplatforminputcontextplugin.so

解决方法：

使用dpkg查找插件文件，fcitx在fcitx-frontend-qt5中，没有就用apt安装即可。

$ dpkg -L fcitx-frontend-qt5 | grep .so /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/libfcitxplatforminputcontextplugin.so

然后复制这个文件到QT Creator目录：

$ cd qt安装目录/Tools/QtCreator/lib/Qt/plugins/platforminputcontexts/
$ cp /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/libfcitxplatforminputcontextplugin.so .
$ chmod +x libfcitxplatforminputcontextplugin.so

然后重启QT Creator即可输入中文。


## qt 汉化
国际化过程：
1.在程序源码中标识需要翻译的文本信息
2.通过Qtcreator生成.ts翻译文件
3.通过翻译工具(Linguist)，对.ts文件进行翻译，发布生成.qm二进制文件
4.在源码中加载.qm文件，实现国际化

1. 如何标识我们需要翻译的内容？
  对用户可见的文本信息使用tr()进行封装。举例如下：
   label->setText(tr("Hello"));
2. 如何通过Qtcreator生成.ts翻译文件?
  在工程文件中添加：TRANSLATIONS = zh_CN.ts
  工具->外部->Qt语言家->更新翻译(lupdate)
小总结：
    1. 如果翻译失败，首先先检查有没有使用tr()进行封装。
    2. ts文件的名称可以自定义。但一般以区域代码表示。zh_CN表示简体中文。

如何使用Linguist工具进行翻译？
  问题有点大。在demo演示时进行说明，很简单。
如何在源码中加载.qm文件？
  QTranslator translator;
  translator.load(QString("/usr/share/zh_CN.qm"));
  a.installTranslator(&translator);
小提示：
    1. 上面加载翻译文件的代码，要放到创建部件代码之前。

Qt自带弹出框没有汉化:
需要查看Qt源码中如何实现国际化：
Qt源码下载地址：
  http://download.qt.io/archive/qt/5.13/5.13.2/single/

在源码的qt-everywhere-src-5.13.1/qttranslations/translations 目录下有很多翻译文件

上面的问题，在ts文件中，加上如下代码就可以实现国际化：

</context>
<context>
    <name>QPlatformTheme</name>
    <message>
        <location filename="qplatformtheme.cpp" line="+704"/>
        <source>Open</source>
        <translation>打开</translation>
    </message>
    <message>
        <location line="+18"/>
        <source>Cancel</source>
        <translation>取消</translation>
    </message>
</context>
<context>
    <name>QFileDialog</name>
    <message>
        <source>All Files (*)</source>
        <translation>所有文件 (*)</translation>
    </message>
</context>

项目的build路径可以用来找相对文件，所以放在与项目目录同级下比较好
