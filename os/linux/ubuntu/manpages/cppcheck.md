# cppcheck静态代码检测工具
cppcheck是一个C/C++静态检查工具。它可以帮助我们检测出代码存在(潜在)的问题，
比如数组越界、内存申请未释放、文件打开未关闭。
注意，cppcheck不是编译器，替代不了gcc。

Cppcheck是一种C/C++代码缺陷静态检查工具。不同于 C/C++ 编译器及很多其它分析工具，
它不检查代码中的语法错误。Cppcheck只检查编译器检查不出来的bug类型，
其目的是检查代码中真正的错误。

支持的代码和平台：

> 可以检查非标准代码，包括不同的编译器扩展、内联汇编代码等。
> Cppcheck应该被处理最新C++标准的任何C++编译器所编译。
> Cppcheck应该在任何有足够CPU和内存的平台上工作。
> 要知道Cppcheck有限制，Cppcheck很少在报告错误方面出错，但有很多bug，它不能检测。

通过仔细测试软件，你会发现软件中有更多的bug，而不是使用Cppcheck。
但Cppcheck仍可以检测到在测试和评估软件时错过的一些bug。


## Install
> sudo apt-cache search "^cppcheck"
> sudo apt install cppcheck

## Use
1. cppcheck的严重性等级可能为：

> 警告(warning): 关于防御性编程，以防止bug的建议
> 风格警告(style): 风格有关问题的代码清理（未使用的函数、冗余代码、常量性等等）
> 可移植性警告(portability): 可移植性警告。64 位的可移植性，代码可能在不同的编译器中运行结果不同。
> 性能警告(performance): 建议使代码更快。这些建议只是基于常识，即使修复这些消息，也不确定会得到任何可测量的性能提升。
> 信息消息(information): 配置问题，建议在配置期间仅启用这些。

通过 *cppcheck --help | grep -A5 "\-\-enabled"*进行查看

2. 启用其他检查
默认情况下，cppcheck只检测错误信息，可以通过--enable选项启用更多的检查：
```
# enable warning messages
cppcheck --enable=warning file.c

# enable performance messages
cppcheck --enable=performance file.c

# enable information messages
cppcheck --enable=information file.c

# For historical reasons, --enable=style enables warning, performance,
# portability and style messages. These are all reported as "style" when
# using the old xml format.
cppcheck --enable=style file.c

# enable warning and performance messages
cppcheck --enable=warning,performance file.c

# enable unusedFunction checking. This is not enabled by --enable=style
# because it doesn't work well on libraries.
cppcheck --enable=unusedFunction file.c

# enable all messages
cppcheck --enable=all
```

注意：--enable=unusedFunction和--enable=all应该只在进行项目工程检查是才启用。
因为unusedFunction会将未使用的函数报告为警告。

3. 保存结果到文件
> cppcheck --enable=warning,style,performance main.cpp 2>err.txt


## examples
1. style
1.1 Local variable 'device' shadows outer variable [shadowVariable]
将局部变量删除，保留外部变量

1.2 The scope of the variable 'optval' can be reduced. [variableScope]
变量范围可以缩小，不一定都是函数最开始声明

> 使用int等基本数据类型作为循环变量，不需要关心在循环外还是循环内定义循环变量。
> 如果循环变量本身是复杂的对象，建议在循环外定义好，
> 并且在for循环的赋值语句、判断语句中，都要避免重复创建对象。

1.3 Variable 'status' is reassigned a value before the old one has been used. [redundantAssignment]
用同一变量获取返回值，需要判断返回值，即使用最开始的变量状态

1.4 Variable 'instance' can be declared with const [constVariable]
该使用const时就该使用const

1.5 Label 'again' is not used. [unusedLabel]

2. warning
2.1 warning: Member variable 'KylinSane::devicesInfo' is not initialized in the constructor. [uninitMemberVar]
类中成员变量需要初始化

2.2 Found suspicious operator ',' [constStatement]
该使用const时就该使用const



## 参考
https://www.jianshu.com/p/d71729b0981d
