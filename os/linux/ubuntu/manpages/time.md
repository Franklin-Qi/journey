# time
time 命令是用来测量 Linux 程序执行时间的命令，而不是用来显示系统时间(date)的命令
```
查看一条命令（比如 ls）到底执行了多长时间，我们可以这样做：

[roc@roclinux ~]$ time ls
program  public_html  repo  rocscm
 
real    0m0.002s
user    0m0.002s
sys     0m0.000s

(1) real：从进程 ls 开始执行到完成所耗费的 CPU 总时间。该时间包括 ls 进程执行时实际使用的 CPU 时间，
ls 进程耗费在阻塞上的时间（如等待完成 I/O 操作）和其他进程所耗费的时间（Linux 是多进程系统，
ls 在执行过程中，可能会有别的进程抢占 CPU）。

(2) user：进程 ls 执行用户态代码所耗费的 CPU 时间。该时间仅指 ls 进程执行时实际使用的 CPU 时间，
而不包括其他进程所使用的时间和本进程阻塞的时间。

(3) sys：进程 ls 在内核态运行所耗费的 CPU 时间，即执行内核系统调用所耗费的 CPU 时间。

ls 命令的真正执行时间是多少？答案就是 user+sys 的时间，但一般情况下，real=user+sys，
因而我们就使用 real 的时间作为 ls 的执行时间了（注意，这里会有几个坑，我们将在后面进行介绍）。



```

# 时间戳转换timestamp
## curtime to timestamp
date +%s

## time to timestamp
date -d  "2018-05-09 00:12:00" "+%s"

## timestamp to time
date -d @1525795920  +"%Y-%m-%d %H:%M:%S"
