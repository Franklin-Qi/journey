# awk
文本数据分析和生成报表

## 基本操作
```
语法：
awk [选项] '模式{动作（action）}' 文件1 文件2 ...
选项： -F   指定输入分隔符，可以是字符串或正则表达式
常用动作： print、printf

chkconfig --list |grep 3:启用 |awk '{print $1}'
tail -1 /etc/passwd |awk -F ':' 'BEGIN{OFS="---"}{print $1,$6,$7}'  ##OFS指定输出分隔符
ifconfig eth1 |awk -F '[ :]+' 'NR==2 {print $4}'
ifconfig eth1 |awk -F '[ :]+' 'NR==2 {print "eth1_ip="$4}' ##可以加入显示内容
awk 'BEGIN {print "line one \nline two\nline three"}'

匹配范围（ranges）：指定的匹配范围，格式为part1,part2
awk -F : '$3==3,$3==10{print $1,$3,$7}' /etc/passwd
awk -F : '$1=="root",$1=="adm"{print $1,$3,$7}' /etc/passwd
awk -F : '/^r/,/^a/{print $1,$3,$7}' /etc/passwd

awk区块原理：

区域构成：

BEGIN { 动作 } ##开始处理第一行文本之前的操作
{ 动作 } ##针对每一行文本的处理操作
END { 动作 } ##处理完最后一行文本之后的操作
执行流程：
 首先执行 BEGIN { } 区块中的初始化操作；
 然后从指定的数据文件中循环读取一个数据行（自动更新 NF、 NR、 $0、 $1…… 等内建变量的值），并执行'模式或条件{ 动作 }'；
 最后执行 END { } 区块中的后续处理操作。


##在awk处理之前打印头部BEGIN{}
awk -F : 'BEGIN{printf "%-10s%-10s%-20s\n","UserName","ID","Shell"}{printf "%-10s%-10s%-20s\n",$1,$3,$7}' /etc/passwd

ifconfig eth0 |awk -F':' 'NR==2{print $2,$4}'|awk 'BEGIN{OFS=" / "}{print "IP="$1,"MASK="$3}'


awk的变量：
awk变量：
FS：列分隔符，默认位空白
RS：行分隔符，默认位换行符
OFS：输出列分隔符
ORS ：输出行分隔符

awk内置变量：
NR：处理中行数
FNR：单个文件的行数
NF：列的个数

案例：
ifconfig eth1 |awk '{print NR}'
ifconfig eth1 |awk '{print NF}'

自定义变量案例：
awk 'BEGIN{test="www.linuxfan.cn";print test}'
awk -v test="linuxfan.cn" 'BEGIN{print test}'

printf的使用：

格式：printf "格式",列表1,列表2 ...

特征：

a.必须指定format(格式)，用于指定后面item（列表）的输出格式

b.printf语句不会自动打印换行符：\n

c.format格式以%加一个字符，如下：

%c:显示字符的ASCII码
%d，%i:十进制整数
%f:显示浮点数（小数）
%s:显示字符串
%u:无符号整数
%%:显示%

d.修饰符：N:显示宽度，-：左对齐，+：显示数值符号，如%-c(左对齐)

案例：

chkconfig --list |grep 3:启用 |awk '{printf "%-10s",$1}' ##在统一行显示
awk -F : '{printf "%-15s %-10d %-10s\n",$1,$3,$7}' /etc/passwd

awk的操作符：

算数操作符： x^y、x/y、x+y、x-y、x%y
比较操作符：>、<、>=、<=、==、!=
逻辑操作符：&&、||、！

awk常见的模式类型

正则表达式（regexp）：awk -F : '/^u/{print $1}' /etc/passwd

表达式（expression）：值位非0或位非空是满足条件，如$1 ~ /foo/或 $1 == "root"

案例：
awk -F : '$3>=500{print $1,$3,$7}' /etc/passwd ##打印普通用户
awk -F : '$3+1<=100&&$3+1>=10{print $1,$3,$7}' /etc/passwd ##UID在10-100之间的用户
awk -F : '$2=="!!"{print $1,$2}' /etc/shadow ##检查未初始化密码的用户
passwd -d u01
awk -F : '$2==""{print $1}' /etc/shadow ##打印密码为空的用户
awk -F : '$7~"bash$"{print $1,$3,$7}' /etc/passwd ##匹配$7为bash结束行
awk -F : '$7!~"bash$"{print $1,$3,$7}' /etc/passwd

```
