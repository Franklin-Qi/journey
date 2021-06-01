# remove-software
删除软件(remove-software) 可用于删除软件。
删除的命令使用yum remove -y 进行删除。
所以，如果删除的软件是系统工具中的话，会删除掉一些系统级别的依赖包。
应该不让用户显示的删除系统工具包，也就是系统工具包在删除软件中越少越好。

技巧：分配给普通用户权限应该越少越好，这样系统崩溃就会少。

如：
1）删除虚拟键盘会导致重启系统只有字符终端，导致图形界面崩溃；
2）删除系统更新会删去删除软件remove-software

# 删除系统更新会删去删除软件remove-software 解决
GRemoveSoftware/maindialog.py:222:  remove_rpms.insert(0, "info-remove-software")

maindialog.py：  用于主对话框的处理，如删除确认、删除软件desktop过滤
skip_desktop = ["remove-software.desktop", "yelp.desktop", "org.gnome.PackageUpdater.desktop"]

info-remove-software：用于调用yum remove -y 删除软件
