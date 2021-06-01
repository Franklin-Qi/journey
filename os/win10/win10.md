# win10 问题汇总

## 主机有网，但任务栏显示没网
控制面板\网络和 Internet\网络连接\以太网 -> 属性 -> Microsoft 网络客户端 -> 配置 -> 高级 -> IPv4 校验和
的值改为Disable(关闭)

## 查看资产统计
1. 设备序列号

wmic bios get serialnumber

2. 查看硬盘序列号

wmic diskdrive get serialnumber

3. mac地址

控制面板\网络和 Internet\网络连接\以太网\详细信息

4. 查看磁盘ID

（1）打开cmd

（2）执行diskpart命令，windows会打开一个新的cmd窗口

（3）执行list disk命令，cmd窗口会展示磁盘列表并排好序了

（4）依据排序执行查询命令：select disk 0, 代表选中第0个磁盘，界面会提示当前已进入指定磁盘

（5） 执行命令：detail disk，查看详细信息。此时展示的信息中，“磁盘ID”就是我们要的硬盘序列号。

## win10 快捷键
[windows keyboard shutcuts](https://support.microsoft.com/zh-cn/help/12445/windows-keyboard-shortcuts)


win 组合键：
表情，复杂数字  win+.
临时速览桌面 win+,
最小化所有窗口  win+m
恢复最小化所有窗口 win+shift+m
显示日期  win+alt+d
打开设置  win+i
打开操作中心 win+a


文件资源管理器的快捷键

打开选定项的属性  alt+enter
选择地址栏  alt+d
显示预览面板  alt+p


以管理员权限打开应用  ctrl+shift+鼠标左键



