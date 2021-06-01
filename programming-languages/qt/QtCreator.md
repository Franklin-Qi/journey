# QtCreator
## 解决警告
1.1 qt overriding recipe for target 'install_target'
命令行进行qmake查看该行Makefile，查看有多行install_target，
所以可以修改Pro文件，删除一个target设置。

## Your GStreamer installation is missing a plug-in 
QMediaPlayer error:
> sudo apt-get install ubuntu-restricted-extras


## 重命名快捷键
`ctrl+shift+ri` 比在后端用grep、sed更快。

## 帮助文档F1
帮助文档在指定的名称上面按F1,可多次F1,返回则是Esc;
当前类找不到函数时，可到inherits(基类)中寻找。

每一个cpp都是一个窗口界面，而且是新增c++ class类型。


## QT Creator 代码自动补全---快捷键设定
在 Creater里使用居然没有效果，估计是输入法切换的冲突（CTRL+SPACE是我中英文输入的默认快捷键）

于是寻求解决方法，在QT Creater->Tools(工具)->Options(选项)里找到
environment(环境)->Keyboard(键盘)，发现TextEditor.CompleteThis命令，其快捷键是Ctrl+Space；
点击那个红叉叉，将原快捷键删除后，添加Alt+/(Eclipse常用这个)
成功，代码提示顺利。

## 快捷键
[快捷键](https://www.cnblogs.com/lsgxeva/p/7804617.html)

快捷键风格，左边一列为ctrl开始，底部一行为alt开始

切换Vim的编辑风格 Alt+V, Alt+V
cpp和h切换  F4
自动缩进 Ctrl+I
换新行 Ctrl+Enter
跳转至块结尾    Ctrl+]
跳转至块开始    Ctrl+[
跳转至以}结尾的块   Ctrl+}
跳转至以{开始的块   Ctrl+{

隐藏或关闭项目文件目录 alt+0
全屏 ctrl+shift+f11
全项目文件搜索字符串  ctrl+shift+f 或者 alt+2


## Qt学习地址
[Qt开发经验博客](https://gitee.com/feiyangqingyun/qtkaifajingyan)
