# **ps 技巧**
查看进程的启动时间和运行时间
<a id="wps-office-id-01">iasdf</a>
## ps -eo
```
 ps -eo lstart,pid,tty,user,etime,comm | sort -n -k1        //sort by lstart from 1 to n

```

参数说明：
lstart：开始时间
pid：进程ID
tty：终端
user：用户
comm：进程名
etime：运行时间


## ps -ef
标准格式显示进程

### 查看僵尸进程
1. top => zombie
ps -ef |grep defunct

## ps -aux
BSD格式显示进程

*参数说明：*
> + USER:用户名
> + VSZ:该进程使用的虚拟內存量（KB）
> + RSS:该进程占用的固定內存量（KB）（驻留中页的数量）
> + START:该进程被触发启动时间
> + TIME:该进程实际使用CPU运行的时间


## ps与top区别
ps看命令执行那刻的进程信息，top是持续监视，ctrl c退出
ps只是查看进程,而top还可以监视系统性能,如平均负载,cpu和内存的消耗
