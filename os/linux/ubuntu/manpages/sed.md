# sed
对符合要求的正则表达式进行编辑。

## 基本操作
```
--sed--

语法：sed [options] 'command' file(s)

选项：

-n 抑制自动打印pattern space，sed默认输出全部，-n用于取消默认输出
-i 编辑文件
-r 支持扩展正则表达式

1.改：

语法：sed '/正则匹配条件/s/old/new/g' 文件
sed 's/dhcp/static/g' /etc/sysconfig/network-scripts/ifcfg-eth1           ##只是显示，不修改
sed -i 's/dhcp/static/g' /etc/sysconfig/network-scripts/ifcfg-eth1        ##只修改，不显示
sed -i 's/dhcp/static/g' ip                                               ##将所有的dhcp替换为static
sed -i '/^IP1/s/static/dhcp/g' ip                                         #将IP1开头的行替换
sed -i '2s/static/dhcp/g' ip                                              #指定特定行号2行替换
cat -n /etc/selinux/config                                                #查看并显示行号
sed -i '7s/disabled/enforcing/g' /etc/selinux/config                      ##开启selinux
sed 's/^/HEAD&/g' a.txt                                                   ##行首增加字符串
sed 's/$/&TAIL/g' a.txt                                                   ##行尾增加字符串


# Doxyfile 指定整行修改
sed -i   '/^OUTPUT_DIRECTORY/c OUTPUT_DIRECTORY = \/home\/yusq\/' Doxyfile

sed -i '/^IP3/a "test add"' ip ##在以IP3开头的行后添加
sed -i '/^IP3/i "test add"' ip ##在以IP3开头的行前添加

2.删：

语法：sed '/表达式/d' 文件
vim ip ##添加空行
sed '/^$/d' ip ##删除空行并显示在屏幕上
sed -i '/IP1/d' ip ##删除包含IP1的行
sed -i '/^IP2/d' ip ##删除以IP2开头的行
sed -i '2d' ip ##删除第二行

3.增：

语法：sed ' /表达式/a "需要添加的文字"' 文件
sed 'a IP3=static' ip ##每一行后都加上IP3=static
sed '3a IP3=static' ip ##只在第3行后加上IP3=static，并显示不修改
sed '3i IP3=static' ip ##只在第3行前加上IP3=static，显示不修改
sed -i '3a IP3=static' ip ##修改，不显示
sed -i '/^IP3/a "test add"' ip ##在以IP3开头的行后添加
sed -i '/^IP3/i "test add"' ip ##在以IP3开头的行前添加

4.查：

语法：sed -n '/表达式/p' 文件
sed -n '2p' /etc/hosts ##查看第二行
sed -n '/www/p' /var/named/chroot/var/named/linuxfan.cn.zone ##查看包含www的解析记录
sed -n '/.100$/p' /var/named/chroot/var/named/linuxfan.cn.zone ##查看以.100结尾的行
sed -n '2~2p' ip ##从第二行，每隔两行显示


##注：当sed命令处理的内容为多行内容，则以/作为表达式的分隔，若sed命令处理的内容为单行内容，作为截取的作用，以#号作为分隔符；
ifconfig eth0|sed -n '2p'|sed 's#.*dr:##g'|sed 's# Bc.*##g'
10.0.0.9

##-r支持扩展正则，\2将2转义，打印出第二个范围(.*)
ifconfig eth0|sed -n '2p'|sed -r 's#(.*dr:)(.*)(Bc.*$)#\2#g'
10.0.0.9

ifconfig eth0|sed -n '2p'|sed -r 's#.*dr:(.*) Bc.*$#\1#g'
10.0.0.9

ifconfig eth0|sed -nr '2s#^.*dr:(.*) Bc.*$#\1#gp'
10.0.0.9

ifconfig eth0|sed -nr '1s#^.*dr (.*)#\1#gp'
00:0C:29:33:C8:75

ifconfig eth0|sed -n '1p'|sed -r 's#(^.*dr )(.*)#\2#g'
00:0C:29:33:C8:75

ifconfig eth0|sed -n '1p'|sed 's#^.*dr ##g'
00:0C:29:33:C8:75

ifconfig eth0|sed -nr '1s#^.*t (.*) 00.*$#\1#gp'
HWaddr

stat /etc/hosts|sed -n '4p'
Access: (0644/-rw-r--r--) Uid: (  0/  root)  Gid: (  0/  root)

stat /etc/hosts|sed -n '4p'|sed 's#^.*ss: (##g'|sed 's#/-.*$##g'
0644

stat /etc/hosts|sed -n '4p'|sed -r 's#^.*s: \((.*)/-.*$#\1#g'
0644

stat /etc/hosts|sed -nr '4s#^.*s: \((.*)/-.*$#\1#gp'
0644

stat /etc/hosts|sed -nr '4s#(^.*s: \()(.*)(/-.*$)#\2#gp'
0644
```
