# 调试工具cgdb
# gdb 使用
[ubuntu wiki gdb](https://wiki.ubuntu.org.cn/index.php?title=%E7%94%A8GDB%E8%B0%83%E8%AF%95%E7%A8%8B%E5%BA%8F&variant=zh-hans)


```
CGDB的图形接口是参考GDB的文本用户接口（tui）设计和实现的，它使用一个分屏显示了当前执行的代码。
代码区的界面模仿了Unix经典的文本编辑器：vi。熟悉vi的人对CGDB应该有着宾至如归的感觉。

CGDB具有如下这些特性：

    高亮的源代码窗口
    可视化的断点
    常用功能的键盘快捷键
    搜索源代码（通过正则表达式）

```

## cgdb 使用
[官网](http://cgdb.sourceforge.net/)
[官网源码](http://cgdb.sourceforge.net/download.php)
[cgdb使用](https://www.bookstack.cn/read/cgdb-manual-in-chinese/6.3.md)

按esc键可让输入焦点进入到vi窗口，再按i键回到gdb窗口。按其它键也可以进入到vi窗口，
比如小键盘上的按键（如果此时Num Lock处于打开状态）


1、设置断点命令，程序在执行时遇到断点会停下来，执行停止后可以进行变量值的检查。
    break 行数；
    break youcode.cpp:32，这个命令是说在youcode.cpp第32行代码处设置断点，程序运行至此时会停下来。

2、显示变量的值，程序在断点处停止时可以打印变量的值。
    print 变量名

3、单步执行，程序在断点处停止后，使用单步调试命令让程序一步步往下执行。使用next命令可以完成这个任务，可以缩写为n。
    next

4、进入内部，在调试过程中，如果想进入某个函数的内部，则可使用step命令。
    step

5、继续执行到下一个断点处。使用continue命令可以完成这个任务。
    continue


#cgdb 环境安装
```
# 相关依赖
[yusq@localhost ~]# yum install -y ncurses-devel texinfo readline-devel automake flex 

# 进行安装
[yusq@localhost ~]# wget https://github.com/cgdb/cgdb/archive/v0.7.0.tar.gz 
[yusq@localhost ~]# tar xf v0.7.0.tar.gz 
[yusq@localhost ~]# cd cgdb-0.7.0/ 
[yusq@localhost cgdb-0.7.0]# ./autogen.sh 
[yusq@localhost cgdb-0.7.0]# ./configure --prefix=/usr/share/cgdb 
[yusq@localhost cgdb-0.7.0]# make && mysudo make install

# 建立软连接
[yusq@localhost cgdb-0.7.0]# mysudo ln -s /usr/share/cgdb/bin/cgdb /usr/bin/cgdb


```
