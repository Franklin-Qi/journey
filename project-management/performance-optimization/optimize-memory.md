# 功耗优化实践
当开发的程序在闲时状态下仍有大量系统调用导致占用内存，
这时可以通过strace、ltrace、c++filt和gdb进行跟踪调试。

## 安装ltrace
```shell
$ sudo apt install ltrace
```

## 使用是trace查看闲时系统调用
```shell
$ strace -p `pidof kylin-scanner`
```

## 使用ltrace查看一段时间系统调用
```shell
$ ltrace -c -p `pidof kylin-scanner`

^C% time     seconds  usecs/call     calls      function
------ ----------- ----------- --------- --------------------
 22.12    0.631616       10526        60 _ZN6QFrame5eventEP6QEvent
```

## 使用c++filt找到函数名称用于gdb断点调试
```shell
$ c++filt _ZN6QFrame5eventEP6QEvent

QFrame::event(QEvent*)
```

## gdb断点调试
```shell
$ sudo gdb -p `pidof kylin-scanner`

(gdb) b QFrame::event(QEvent*)
(gdb) c
(gdb) bt
...
#3 0x00007f3e31b386aa in QTimer::timeout(QTimer::QPrivateSignal) () at /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
...
```
根据堆栈信息，可以知道是timeout()导致的闲时大量系统调用，之后可以优化代码架构，让闲时调用都是有必要。

