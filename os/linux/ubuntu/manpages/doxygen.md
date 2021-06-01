# doxygen
对于大量代码：doxygen + graphviz 可以在网页上看代码，同时有图片生成。
poxygen 源码编译需要cmake3.2上，而兆芯koji上是3.0，所以升级cmake。
[doxygen](http://www.doxygen.nl/manual/markdown.html#mddox_lists)

## doxygen use

### Install
```
sudo apt install bison flex graphviz
```

### How to Use
[blog](https://www.liuguogy.com/archives/doxygen-c-brief-annotation.html)
[csdn](https://www.cnblogs.com/rongpmcu/p/7662765.html)
1. comments
```
/**
 * ... text ...
 * \param c1 the first argument.
 */
```

2. members comments
```
int var; /**< Detailed description after the member */
```

3. functions comments
```
/**
 * @brief 
 * 退出后端
 *
 * <pre>
 * @details 
 * 必须调用此函数以终止使用后端。
 * 该函数将首先关闭所有可能仍处于打开状态的设备句柄（建议通过调用sane_close（）显式关闭设备句柄，但要求后端在调用此函数时释放所有资源）。
 * 此函数返回后，不能调用sane_init（）以外的任何函数（无论sane_exit（）返回的状态值如何。忽略调用此函数可能会导致某些资源无法正确释放。
 * </pre>
 *
 * @param   a  变量a
 * @param   a  变量a
 * @return void
 * @retval 
 * 1: result1
 * 2: result2
 */

   @可用\代替，但我倾向于用@。
   @param[in|out]     参数名及其解释
   @exception            用来说明异常类及抛出条件
   @return                   对函数返回值做解释
   @note                      表示注解，暴露给源码阅读者的文档
   @remark                表示评论，暴露给客户程序员的文档
   @since                   表示从那个版本起开始有了这个函数
   @deprecated        引起不推荐使用的警告
   @see                      表示交叉参考
```


## 实例
cd ~/gtk-simple-test/GtkApplication/
mkdir doc  => 存放文档
doxygen -g => Doxyfile 生成，同时参照## USE 进行配置文件
doxygen ~/gtk-simple-test/GtkApplication/Doxyfile
firefox doc/index.html => 可以看到调用对象的引用以及跳转图片

注： 但是对于main 中的一些系统调用函数还是没显示出来，需要加强。也就是需要结合cscope.md

## USE
[*Note*]:
/usr/bin/autodoxygen.sh 可以进行处理，单需要根据需要更改`OUTPUT_DIRECTORY` 和`INPUT` 



```
ibm default: 
OUTPUT_DIRECTORY = /home/user1/docs
EXTRACT_ALL = yes
EXTRACT_PRIVATE = yes
EXTRACT_STATIC = yes
INPUT = /home/user1/project/kernel
#Do not add anything here unless you need to. Doxygen already covers all 
#common formats like .c/.cc/.cxx/.c++/.cpp/.inl/.h/.hpp
FILE_PATTERNS = 
RECURSIVE = yes


1. 生成图像的选项.doxygen使用dot这个工具来绘图,所以要先执行sudo apt-get install graphviz安装dot.
在设置好这个绘图选项之后,doxygen就会生成各个结构体的关系,对于类会生成函数调用关系

HAVE_DOT (一定要置为YES,后面的选项都依赖这个)
DOT_NUM_THREADS (使用dot绘图的线程数量,越多越快,我一般是设置跟cpu的核数一样)
//以下两个选项跟生成函数调用关系图有关
CALL_GRAPH
CALLER_GRAPH
EXTRACT_ALL //把所有实体都输出到文档,不管它是否能被描述
EXTRACT_STATIC //把静态变量也输出到文档中
EXTRACT_PRIVATE //把私有变量也输出到文档中



2. 语言优化输出的选项,默认都是NO
OPTIMIZE_OUTPUT_FOR_C  yes
OPTIMIZE_OUTPUT_JAVA
OPTIMIZE_FOR_FORTRAN
OPTIMIZE_OUTPUT_VHDL

3. 生成文档的类型的选项,默认生成html和latex,共支持六种类型的文档,每种类型的生成配置也是很多,具体根据需要配置
GENERATE_HTML  yes
GENERATE_LATEX yes
GENERATE_RTF
GENERATE_XML
GENERATE_DOCBOOK
GENERATE_MAN

```


## Install
```
git clone https://github.com/doxygen/doxygen.git
cd doxygen
mkdir build
cd build
cmake -G "Unix Makefiles" ..   # 需要更新cmake，根据cmake.md 配置
make
make install
```

## 参考
[doxygen 官网下载指导](http://www.doxygen.nl/download.html)
[doxygen IBM使用手册](https://www.ibm.com/developerworks/cn/aix/library/au-learningdoxygen/index.html)
[简书·阅读源码工具](https://www.jianshu.com/p/09e74b05fd5d)


