# sleep 
sleep 就是让程序稍稍休息一下，然后，再继续工作（休息是为了更好地工作……）。

## 睡眠时间个性化
```
默认单位为秒。
sleep 中最大的单位是 d（天），如果想表示更长的时间，比如周、月、年的话，
那么你只能把它们转换成天来表示了

有秒的话，还应该有分钟和小时才对，那这些单位在 sleep 中如何表示呢？

    s：表示秒
    m：表示分钟
    h：表示小时
    d：表示天

比如，如果想让 Shell 程序睡眠 1 分钟，应该如何操作呢？

[roc@roclinux ~]$ date; sleep 1m; date
Thu Feb 25 10:00:43 CST 2016
Thu Feb 25 10:01:43 CST 2016


想让 shell 程序睡眠 1 分 40 秒，又该怎么操作呢？
#注意: 分钟和秒之间一定要有空格哦
[roc@roclinux ~]$ date; sleep 1m 40s; date
Thu Feb 25 10:17:04 CST 2016
Thu Feb 25 10:18:44 CST 2016


毫秒级睡眠时间
默认情况下，sleep 的进程是不占用 CPU 时间的，我们可以通过实验来说明这个问题：

[roc@roclinux ~]$ \time sleep 1
0.00user 0.00system 0:01.00elapsed 0%CPU (0avgtext+0avgdata 2560maxresident)k
0inputs+0outputs (0major+200minor)pagefaults 0swaps

看到了吗？0.00user、0.00system、0%CPU 这三个输出项都表明 sleep 是不会耗费 CPU 的计算资源的。


sleep 命令只能保证 10ms 级别的精度控制，对于小于 10ms 的睡眠时间是存在误差的。实际应用中，
如果你对时间精度要求特别高的话，sleep 或许不是一个正确的选择

```
