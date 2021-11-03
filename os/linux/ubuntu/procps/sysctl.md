# procps软件包详解 
日常工作中会使用/proc/sys/目录下的文件,所以这里进行详解。
/etc/sysctl.conf文件所属包，sysctl 命令可以控制系统的/proc/sys/目录下的变量。

如，段错误core文件的产生命名可在/etc/sysctl.conf中找到，
具体表现为/proc/sys/kerner/core_pattern 。

**临时设置**/proc/sys/中变量生效为：
> sudo sysctl kernel.core_pattern= /tmp/core-%p-%e-%t

**重启后永久生效**设置/pro/sys/变量为:
> sudo vi /etc/sysctl.conf # 增加 kernel.core_pattern = /tmp/core-%p-%e-%t

## 修改swappiness优化速度
 我在日常使用ubuntu时，经常要同时打开10几个窗口和应用，有时候就会发生速度变得很慢的情况，甚至 系统明显反应迟钝，这时一般是物理内存不够用，系统开始用换硬盘上的swap分区做虚拟内存，其速度可想而知。
  
  在ubuntu里面往往不是物理内存全部耗尽采取使用swap分区，swappiness的值的大小对如何使用swap分区是有着很大的联系 的。swappiness=0的时候表示最大限度使用物理内存，然后才是 swap空间，swappiness＝100的时候表示积极的使用swap分区，并且把内存上的数据及时的搬运到swap空间里面。两个极端，对于 ubuntu的默认设置，这个值等于60，建议修改为10.

  修改后生效使用命令： sudo sysctl -p 




