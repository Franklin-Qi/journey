# Grep
grep 用于对符合规范的正则表达式进行查找。

## 正则表达式
命令行下正则表达式含义:
```
.*^$[]      \(\) \{\} \? \+ \|
```
```
--正则--

基础正则

^word     ##搜索以word开头的 vi/vim中 ^ 一行的开头
word$     ##搜索以word结尾的 vi/vim中 $ 一行的结尾
^$        ##表示空行
.         ##代表且只能代表任意一个字符
\         ##例：\. 只代表点本身，转义符号，让有特殊身份意义的字符，脱掉马甲，还原
\n        ##换行符
\r        ##匹配回车
\w        ##匹配任意一个字符和数字
*         ##重复0次或多次前面的一个字符
.*        ##匹配所有字符。例：^.* 以任意多个字符开头，.*$以任意多个字符结尾
[abc]     ##匹配字符集内的任意一个字符
[^abc]    ##匹配不包含 ^ 后的任意字符的内容。中括号里的 ^ 为取反
[1-9]     ##表示匹配括号内的范围内的任意字符
a\{n,m\}  ##重复n到m次前一个重复的字符。若用egrep、sed -r可以去掉斜线
\{n,\}    ##重复至少n 次前一个重复的字符。若用egrep、sed -r可以去掉斜线
\{n\}     ##重复n 次前一个重复的字符。若用egrep、sed -r可以去掉斜线
\{,m\}    ##重复少于m次

注：egrep，grep –E或sed –r 过滤一般特殊字符可以不转义


扩展正则（egrep或grep -E）
这些在vim 编辑中都需要增加转义字符\，也就是说vim内嵌grep

+          ##重复一次或一次以上前面的一个字符
?          ##重复0次或一次前面的一个字符
|          ##或者的意思，用或的方式查找多个符合的字符串
()         ##找出括号内的字符串


实例

^linux                                            ##以linux开始
linux$                                            ##以linux结束
linuxfan.                                         ##匹配linuxfans等
coo[kl]                                           ##匹配cool或cook
9[^5689]                                          ##匹配91,92等，但不匹配95,96,98,99
[0-9]                                             ##匹配任意一个所有的数字
[a-z]|[A-Z]                                       ##匹配任意一个所有大小写字母,|属于扩展正则grep -E支持
colou?r                                           ##匹配color或colour，但是不能匹配colouur
rollno-9+                                         ##匹配rollno-9、rollno-99，rollno-999，但不匹配rollno-
co*l                                              ##匹配cl，col，cool，coool等
ma(tri)x                                          ##匹配matrix
[0-9]{3}                                          ##匹配任意一个三位数，等于[0-9][0-9][0-9]
[0-9]{2,}                                         ##匹配任意一个两位数或更多位的数字
[0-9]{2,5}                                        ##匹配从两位数到五位数之间的任意一个数字
Oct (1st|2nd)                                     ##匹配Oct 1st或Oct 2nd
a\.b                                              ##匹配a.b，但不能匹配ajb
[a-z0-9_]+\@[a-z0-9_]+\.[a-z]{2,4}                ##匹配一个邮箱地址
[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}    ##匹配IP地址

```

## grep
查找

```
实例

##查看系统内存、缓存、交换分区-e的作用是匹配多个表达式
cat /proc/meminfo |grep -e Mem -e Cache -e Swap

##查找/etc目录下的所有文件中的邮件地址；-R递归，-n表示匹配的行号，-o只输出匹配内容，-E支持扩展正则表达式，
grep -R -o -n -E  '[a-z0-9_]+\@[a-z0-9_]+\.[a-z]{2,4}' /etc/

##查找/etc/目录下文件中包含“HOSTNAME”的次数，-c统计匹配次数，-v取反
grep -R -c 'HOSTNAME' /etc/ |grep -v "0$"

##查找包含“HOSTNAME”的文件名，-l显示匹配的文件名，-L显示不匹配的文件名
grep -R -l 'HOSTNAME' /etc/

##查找内核日志中eth的行，显示颜色及行号
dmesg | grep -n --color=auto 'eth'

##用 dmesg 列出核心信息，再以 grep 找出内含 eth 那行,在关键字所在行的前两行与后三行也一起找出出来显示
dmesg | grep -n -A3 -B2 --color=auto 'eth'

##统计系统中能登录的用户的个数
cat /etc/passwd |grep -c bash$

##创建测试文件，以下三条命令是一样的效果，匹配文件名123，可以包含1个到多个
touch /tmp/{123,123123,456,1234567}.txt
ls |grep -E '(123)+'
ls |grep '\(123\)\+'
ls |egrep '(123)+'

##统计httpd进程数量
ps -ef |grep -c httpd

##显示games匹配的“-C”前后4行
grep -C 4 'games' --color /etc/passwd

##查看adm组的信息
grep ^adm /etc/group

##获取网卡名称
ip a |grep -E '^[0-9]' |awk -F : '{print $2}'

##截取ip地址，[^ ]*表示以非空字符作为结束符，[0-9.]*表示数字和点的组合
ifconfig eth0 |grep -E -o 'inet addr:[^ ]*' |grep -o '[0-9.]*'

##截取ip地址
ip a |grep inet |grep eth0 |grep -o "inet[^/]*" |grep -o "[0-9.]*"

##截取MAC地址
ifconfig eth0 |grep -i hwaddr |awk '{print $5}'

##截取MAC地址
ip a |grep -A 3 "eth0" |grep link/ether |grep -o "ether[^r]*" |grep -o -E "[0-9a-f:]+"|grep -E "[0-9a-f:]{2}$"

grep "^m" oldboy.log                ##过滤输出以m开头的行
grep "m$" oldboy.log
grep -vn "^$" oldboy.log            ##过滤空行
grep -o "0*" oldboy.log
grep -o "oldb.y" oldboy.log
grep "\.$" oldboy.log               ##以.结尾的行
grep "0\{3\}" oldboy.log            ##重复三次
```


/< 和 /> 分别标注单词的开始与结尾。
例如：
grep man * 会匹配 ‘Batman’、‘manic’、‘man’等，
grep '/<man' * 匹配‘manic’和‘man’，但不是‘Batman’，
grep '/<man/>' 只匹配‘man’，而不是‘Batman’或‘manic’等其他的字符串。
'^'：指匹配的字符串在行首，
'$'：指匹配的字符串在行尾，

grep -i pattern files ：不区分大小写地搜索。默认情况区分大小写，
grep -l pattern files ：只列出匹配的文件名，
grep -L pattern files ：列出不匹配的文件名，
grep -w pattern files ：只匹配整个单词，而不是字符串的一部分（如匹配‘magic’，而不是‘magical’）
grep "[a-z]\{2\}" -nrw （查找含有两个字母的单词所在行和行号，{2}表示匹配两次，{}必须要转义）
忽略二进制文件的匹配结果，只显示文本文件（-I，大写的i）：grep "s\{2\}" -Inrw（查找ss）

```
查找当前文件夹及子文件夹下文件名为shm*.c中以shm开头的单词的行及其行号：grep "shm\w*" -Inrw --include=shm*.c

查找系统头文件库中指定函数名的函数声明所在的头文件和行数：
grep gtk_application_window_new -Inrw /usr/include/gtk-3.0/gtk（查找gtk_application_window_new函数的声明）
grep g_signal_connect -Inrw /usr/include/glib-2.0/ --include=*.h （查找g_signal_connect的声明，只查找*.h头文件）
grep g_application_run -Inrw /usr/include/glib-2.0/ --include=*.h（查找g_application_run的声明）
grep g_signal_ -Inr /usr/include/glib-2.0/ --include=*.h（查找所有含有g_signal_的函数的声明，注意没有-w选项）
```

不仅显示匹配行，还要显示后两行（After）：grep void -Inrw -A 2
不仅显示匹配行，还要显示前两行（Before）：grep void -Inrw -B 2
不仅显示匹配行，还要显示前后两行（before and after）：grep void -Inrw -C 2

```
find . -name "*.java" | xargs grep 'startPreview'
find是搜索匹配条件的文件。grep是查找匹配条件的行，
```


在app目录中搜索字符串foo,但不包括文件名中包含迁移的任何文件.我希望这个grep命令能够工作
```
grep -Ir --include "*.py" --exclude "*migrations*" foo app/

grep -nr --include=*.{c,h}  "resizable"
```
