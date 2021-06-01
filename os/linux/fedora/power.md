# power
# windows
ACPI有下几种
在ACPI电源管理方式下,根据CPU、内存、二级缓存、主控芯片、硬盘等设备挂起时所处的状态不同,它可以支持五种睡眠状态S1、S2、S3、S4和S5。

     S0--正常,即正常的工作状态，所有设备全开，功耗一般会超过80W；

     S1--CPU停止工作,也称为POS（PoweronSuspend），这时除了通过CPU时钟控制器将CPU关闭之外，
        其他的部件仍然正常工作，这时的功耗一般在30W以下；（有些CPU降温软件就是利用这种工作原理）

     S2--CPU关闭,这时CPU处于停止运作状态，总线时钟也被关闭，但其余的设备仍然运转；

     S3--除了内存外的部件都停止工作（standby）,即STR（SuspendtoRAM：挂起到内存），这时的功耗不超过10W；

     S4--内存信息写入硬盘(hibernation)，所有部件停止工作,也称为STD（SuspendtoDisk），
        这时系统主电源关闭，但是硬盘仍然带电并可以被唤醒；

     S5--关闭,所有设备全部关闭（包含电源），功耗为0。

S1/S3 在 windows 中都叫「待命 or standby」，所以在 BIOS 里会有一个选項，设定 Standby mode 为何，
是要 S1 还是 S3。S1 和 S3 是不能同时存在的。不是 S1,S4,S5 就是 S3,S4,S5 。

# linux 
三种节电模式的方法如下：

#echo standby > /sys/power/state ---->挂起（S1）

#echo mem > /sys/power/state ---->挂起到内存（S3） => 休眠命令

#echo shutdown > /sys/power/disk; echo disk > /sys/power/state ---->挂起到磁盘（S4）


# 
休眠是一种更加省电的模式，它将内存中的数据保存于硬盘中，所有设备都停止工作。当再次使用时需按开关机键，机器将会恢复到您的执行休眠时的状态，而不用再次执行启动操作系统复杂的过程。

待机（挂起）是将当前处于运行状态的数据保存在内存中，机器只对内存供电，而硬盘、屏幕和CPU等部件则停止供电。由于数据存储在速度快的内存中，因此进入等待状态和唤醒的速度比较快。不过这些数据是保存在内存中，如果断电则会使数据丢失。

立刻关机：
sudo halt
sudo init 0
sudo shutdown -h now
sudo shutdown -h 0

定时/延时关机：
sudo shutdown -h 19:30
sudo shutdown -h +30   ##单位为分钟

重启：
sudo reboot
sudo init 6
sudo shutdown -r now

休眠：
sudo pm-hibernate
 
echo “disk” > /sys/power/state
 
sudo hibernate-disk

待机(挂起)：
sudo pm-suspend
sudo pm-suspend-hybrid
 
echo “mem” > /sys/power/state
 
sudo hibernate-ram
