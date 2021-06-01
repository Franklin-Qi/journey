# cscope 
快速查询本函数调用和调用本函数的函数

对于少量代码：vim+ctags+cscope
对于大量代码：doxygen+graphviz
doxygen.md

[看代码神器](https://blog.csdn.net/Touatou/article/details/79680781)
[vim+ctags+cscope, doxygen+graphviz](https://www.jianshu.com/p/09e74b05fd5d) => cscope.md

```
0 或 s: 查找本 C 符号 √

1 或 g: 查找本定义   ctrl+] √

2 或 d: 查找本函数调用的函数  display functions √
3 或 c: 查找调用本函数的函数  call this √
4 或 t: 查找本字符串 √


6 或 e: 查找本 egrep 模式
7 或 f: 查找本文件
8 或 i: 查找包含本文件的文件


s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
d: 查找本函数调用的函数
c: 查找调用本函数的函数
t: 查找指定的字符串
e: 查找egrep模式，相当于egrep功能，但查找速度快多了
f: 查找并打开文件，类似vim的find功能
i: 查找包含本文件的文件

```
