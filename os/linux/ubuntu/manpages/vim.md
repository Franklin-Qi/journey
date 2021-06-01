# vim操作汇总


Table of Contents
=================

   * [vim操作汇总](#vim操作汇总)
   * [位置标记和相关动作](#位置标记和相关动作)
   * [滚动屏幕操作](#滚动屏幕操作)
   * [命令行编辑](#命令行编辑)
   * [获取文件路径名和文件名](#获取文件路径名和文件名)
   * [文本每3行合并成1行](#文本每3行合并成1行)
   * [删除代码段每行的行号](#删除代码段每行的行号)
   * [在每行行尾添加相同的内容](#在每行行尾添加相同的内容)
   * [在每行行首添加相同的内容](#在每行行首添加相同的内容)
   * [切换当前工作目录](#切换当前工作目录)
   * [buffer 操作](#buffer-操作)
   * [提取和合并文件](#提取和合并文件)
   * [插入补全模式](#插入补全模式)
   * [统计单词数、行数等](#统计单词数行数等)
   * [恢复光标位置](#恢复光标位置)
   * [rename 批量文件更名](#rename-批量文件更名)
   * [tips.txt  `=&gt;'](#tipstxt--)
   * [代码缩进](#代码缩进)
   * [文件批量改名.后缀](#文件批量改名后缀)
   * [color.h ==&gt; color.sh](#colorh--colorsh)
   * [echo ==&gt; echo_color ... $BLUE](#echo--echo_color--blue)
   * [函数定义函数名移动](#函数定义函数名移动)
   * [删除单词](#删除单词)
   * [命令的前10行](#命令的前10行)
   * [替换每行以英文开头的字符](#替换每行以英文开头的字符)
   * [用VIM去掉文件中的^M](#用vim去掉文件中的m)
   * [设置注释颜色](#设置注释颜色)
   * [使用技巧](#使用技巧)
   * [折叠](#折叠)
   * [中文帮助help](#中文帮助help)
   * [man 中文](#man-中文)
   * [assign the selected row and replace words before and after](#assign-the-selected-row-and-replace-words-before-and-after)
   * [vim Markdown 支持](#vim-markdown-支持)
   * [taglist](#taglist)
   * [ctags 全局库函数](#ctags-全局库函数)


## 位置标记和相关动作
:help quickref
```
*Q_ma*		位置标记和相关动作

|m|	   m{a-zA-Z}	用标记 {a-zA-Z} 记录当前位置
|`a|	   `{a-z}	至当前文件中的标记 {a-z}
|`A|	   `{A-Z}	至任何文件中的标记 {A-Z}
|`0|	   `{0-9}	至 Vim 上次退出的位置
|``|	   ``		至上次跳转之前的位置
|`quote|   `"		至上次编辑此文件的位置 
|`[|	   `[		至上次被操作或放置的文本的开始
|`]|	   `]		至上次被操作或放置的文本的结尾
|`<|	   `<		至 (前次) 可视区域的开始
|`>|	   `>		至 (前次) 可视区域的结尾
|`.|	   `.		至当前文件最后被改动的位置
|'|	   '{a-zA-Z0-9[]'"<>.}
			同 `，但同时移动至该行的第一个非空白字符
|:marks|  :marks	列出活动的标记
|CTRL-O|  N  CTRL-O	跳转到跳转表中第 N 个较早的位置
|CTRL-I|  N  CTRL-I	跳转到跳转表中第 N 个较晚的位置
|:ju|	  :ju[mps]	列出跳转表

. ——最近编辑的位置
0-9 ——最近使用的文件
∧ ——最近插入的位置
' ——上一次跳转前的位置
" ——上一次退出文件时的位置
[ ——上一次修改的开始处
] ——上一次修改的结尾处
使用:delmarks a b c命令，可以删除某个或多个标记；而:delmarks! 命令，则会删除所有标记。

自定义标记在[a-zA-Z]
a-z 在本文件跳转
A-Z 可跨文本跳转

Marco中自定义标签：
M - main
D - meta_display_open
E - event_callback

```

## 滚动屏幕操作
```
Ctrl + F <==> <c-f>

<c-f> 屏幕向下滚动一屏
<c-b> 屏幕向上滚动一屏
<c-e> 屏幕向下滚动一行
<c-y> 屏幕向上滚动一行
<c-d> 屏幕向下滚动半屏
<c-u> 屏幕向上滚动半屏
```

## 命令行编辑
:help cmdline
```
CTRL-R {0-9a-z"%#:-=.}					*c_CTRL-R* *c_<C-R>*
		插入寄存器里的内容。当按下 CTRL-R 时，屏幕会显示一个 '"' 字
		符，提示你输入一个寄存器的名字。
		插入的文字就像是你自己输入的，但是映射和缩写不会生效。同样也不
		会触发 'wildchar' 的补全功能。并且那些可以结束命令的字符会被按
		字面插入 (<Esc>，<CR>，<NL>，<C-C>)。虽然 <BS> 或 CTRL-W 仍旧
		可能结束命令行模式，但是剩余的字符会被接下来其他的模式解释，这
		可能并非你的目的。
		特殊寄存器:

			'"'	无名寄存器，包含最近一次删除或复制的内容       有用，可以先yy复制，在命令行复制整行
			'%'	当前文件名                                     有用
			'#'	轮换文件名
			'*'	剪贴板的内容 (X11: 主选择区)
			'+'	剪贴板的内容
			'/'	最近一次的查找模式
			':'	最近一次在命令行输入的命令
			'-'	最近一次小的 (少于一行) 删除
			'.'	最近插入的文本
							*c_CTRL-R_=*
			'='	表达式寄存器: 会提示你输入一个表达式。
				(见 |expression|)
				(在表达式提示中无效；不允许改变缓冲区或者当前
				窗口这样的操作，以避免副作用)
		与寄存器相关的内容请参见 |registers|。{Vi 无此功能}
		实现细节: 如果使用 |expression| 寄存器并且调用 setcmdpos()，那
		么在插入返回的文本之前设置光标位置。使用 CTRL-R CTRL-R 在插入
		返回的文本之后设置光标位置。

CTRL-R CTRL-F				*c_CTRL-R_CTRL-F* *c_<C-R>_<C-F>*
CTRL-R CTRL-P				*c_CTRL-R_CTRL-P* *c_<C-R>_<C-P>*
CTRL-R CTRL-W				*c_CTRL-R_CTRL-W* *c_<C-R>_<C-W>*
CTRL-R CTRL-A				*c_CTRL-R_CTRL-A* *c_<C-R>_<C-A>*
		插入光标下的对象:
			CTRL-F	光标下的文件名
			CTRL-P	用 'path' 扩展的光标下的文件名。与 |gf|
				中的类似。
			CTRL-W	光标下的单词
			CTRL-A	光标下的字串；参见: |WORD|
```

## 获取文件路径名和文件名
```Bash
PWD=/root/markdown/vim.md
dirname $PWD   # 文件路径名: /root/markdown
basename $PWD  # 文件名: vim.md

# Shell文件名前缀(prefix)、后缀(suffix)
file=vim.md
prefix: ${file%.*}
suffix: ${file##*.}

```

## 文本每3行合并成1行
01.md 为每个一行的文本，如01.md    
命令行下执行:  ` sed 'N;N;s/\n/ /g'  01.md  >  symbols.md `  使01.md变成3行合并成一行的文本symbols.md  
接下来编辑sysbols.md, 进行如下操作，可做成表格：  
```
:%s/:\([a-z0-9_-]*\):/& `:\1:`/g
:%s/\([:a-z0-9_-]\+`\)/\1 \|/g
:%s/^/| /g

```

## 删除代码段每行的行号
```bash
:%s/^\s*[0-9]*\s*//gc
```

## 在每行行尾添加相同的内容
:%s/$/要添加的内容

## 在每行行首添加相同的内容
:%s/^/要添加的内容

## 切换当前工作目录
你也可以用 :cd 和 :lcd 命令换到别的目录，所以你可以不用总是在文件名前输入
目录名。这也影响到外部命令的执行，例如 ":!ls"。

通过help cd进行查看，也就是说可以在vim中测试linux命令通过help。

## buffer 操作
:b {bufname}
通过文件名切换到 bufname 对应的文件，输入文件名时，可以用Tab键补全。

:help buffer
buffer帮助

## 提取和合并文件
提取
v motion  选择文本
:w FILENAME 保存文本到FILENAME

合并
:r FILENAME  从FILENAME提取文本到当前行


## 插入补全模式
可以补全文件名等。

CTRL+P: 向前补全
CTRL+N: 向后补全
CTRL+Y: 选中当前补全
CTRL+E: 撤销当前补全

:h ins-completion@cn
补全可以是针对:

```
1. 整行							|i_CTRL-X_CTRL-L|
2. 当前文件内的关键字					|i_CTRL-X_CTRL-N|
3. 'dictionary'	的关键字				|i_CTRL-X_CTRL-K|
4. 'thesaurus' 的关键字，同义词风格			|i_CTRL-X_CTRL-T|
5. 当前和头文件内的关键字				|i_CTRL-X_CTRL-I|
6. 标签							|i_CTRL-X_CTRL-]|
7. 文件名						|i_CTRL-X_CTRL-F|
8. 定义或宏						|i_CTRL-X_CTRL-D|
9. Vim 命令						|i_CTRL-X_CTRL-V|
10. 用户定义的补全					|i_CTRL-X_CTRL-U|
11. 全能 (omni) 补全					|i_CTRL-X_CTRL-O|
12. 拼写建议						|i_CTRL-X_s|
13. 'complete' 的关键字					|i_CTRL-N|
```

## 统计单词数、行数等
	:%s/./&/gn		字符数
	:%s/\i\+/&/gn		单词数
	:%s/^//n		行数
	:%s/the/&/gn		任何地方出现的 "the"
	:%s/\<the\>/&/gn	作为单词出现的 "the"

## 恢复光标位置
有时你希望写一个映射，让它在文件中的其他地方做一些修改然后恢复光标的位置 (不滚
动文本)。例如，修改一个文件中的日期标记： >

```
   :map <F2> msHmtgg/Last [cC]hange:\s*/e+1<CR>"_D"=strftime("%Y %b %d")<CR>p'tzt`s
```

分解出保存位置的命令：
	ms	把光标位置存放在位置标记 's' 中   start
	H	跳转到窗口的顶端
	mt	把这个位置存放在位置标记 't' 中   to

分解出恢复位置的命令：
	't	跳转到先前位于窗口顶端的那一行
	zt	滚屏，使这一行位于窗口的顶端
	`s	跳转到最初光标的位置

## rename 批量文件改名
假如我有一个目录，里面有如下的文件 (目录是随机选取的)：

buffer.c
charset.c
digraph.c
...

现在我希望把 *.c 更名为 *.bla。我可以这样做： >

	$ vim
	:r !ls *.c
	:%s/\(.*\).c/mv & \1.bla
	:w !sh
	:q!


## tips.txt  `=>'
map ' `

使得单引号和 ' 一样工作

## 代码缩进
>i{
这个命令会缩进当前 {} 区内的行，'{' 和 '}' 本身并不被缩进。">a{" 会包括它们。

## 文件批量改名.后缀
rename "markdown" "md" *

## color.h ==> color.sh
%s/\([A-Z]*\) *"\\/\1="\\/g

## echo ==> echo_color ... $BLUE
26,30s/echo \(" *[a-z-]*"\)/echo_color \1  $BLUE/g


## 函数定义函数名移动
一般系统函数或者源代码的函数移动
[[ -->> (

gd ==>> 跳转到局部变量声明
gD ==>> 跳转到全局变量声明

## 删除单词
bcw

## 命令的前10行
hdparm -I /dev/sda | head -n 10   //查看硬件序列号

## 替换每行以英文开头的字符
%s/^\([a-z]\)/RPM: \1/g


## 用VIM去掉文件中的^M
将Windows环境下编辑的文件，copy到Linux环境下，再继续编辑，一般都需要去掉^M。

我们可以通过VIM这个工具来做这件事情，具体操作方式如下：

vim test.py
:set fileformat=unix
:w

set fileformat=unix这一行命令，就可以完成去掉^M的操作。

## 设置注释颜色
[自定义配色方案](https://www.linuxidc.com/Linux/2016-01/127561.htm)
打开vim，在命令模式下输入:Xt，这里是大写x,小写t。然后按<tab>补全，补全为XtermColorTable，回车后就会出现下面界面

## 使用技巧
Ctrl-f    即 PageDown 翻页。
Crtl-b    即 PageUp 翻页。

0：将光标移至行首（绝对行首）
^：将光标移至行首的第一个非空白字符
$：绝对行尾
H  移至萤幕顶第一个非空白字元。
M  移至萤幕中间第一个非空白字元。
L  移至萤幕底第一个非空白字元。
w  移至次一个字（word）字首。当然是指英文单字。
W  同上，但会忽略一些标点符号。
e  移至前一个字字尾。
E  同上，但会忽略一些标点符号。
b  移至前一个字字首。
B  同上，但会忽略一些标点符号。

x：删除自光标起向后第#个字符。
dw:删除自光标起第#个单词，光标位于第#+1个单词词首
de:删除自光标起第#个单词，光标位于第#个单词词尾
db：删除光标所在单词以及前#-1个单词 共#个单词
dd：删除包括当前光标所在行在内的#行
d$：删除光标至行尾的所有字符
d^：删除光标至行首第一个非空白字符的所有字符
d0：删除光标至绝对行首的所有字符

u                撤销
ctrl + r         恢复

## 折叠
zf   创建折叠（fold creation）
zo   打开折叠(open)
zc   再次折叠起来(close)

v{motion}zf  折叠V模式下选中的文本。（这里的v{motion}指的是Shift+v）。
zfnk：从当前行开始向上到n行折叠
zf3j     折叠当前光标出下3行
zf10G    从当前行折叠至第20行
zfgg     折叠至行首
zf%      光标移至'{'时，vim会去匹配'}'，这样'{}'之间的内容就可以折叠起来

zj：向下一个折叠点移动
zk：向上一个折叠点移动
[z：移动到打开后的折叠区的开始处
]z：移动到打开后的折叠区的结束处



## 中文帮助help
[下载地址](wget http://nchc.dl.sourceforge.net/sourceforge/vimcdoc/vimcdoc-1.5.0.tar.gz)

解包后进入文件夹，使用以下命令安装：
$sudo ./vimcdoc.sh -i
启动vim，输入:help，看看帮助文档是否已经便成中文了？

一些注意事项：
1.vim中文文档不会覆盖原英文文档，安装后vim默认使用中文文档。若想使用英文文档，可在vim中执行以下命令：
     set helplang=en
同理，使用以下命令可重新使用中文文档：
     set helplang=cn
2. 帮助文件的文本是utf-8编码的, 如果想用vim直接查看, 需要在~/.vimrc中设置:
   set encoding=utf-8

3. 查看帮助文档也能用ctrl + ] 和ctrl +　ｔ进行跳转。

## man 中文
yum list | grep man-pages

sudo yum install man-pages-zh-CN


## assign the selected row and replace words before and after
> :86s/\(en\):\(zh\)/\2:\1/g


## vim Markdown 支持
~/.vim/bundle/vim-pathogen/README.markdown

## taglist
1.  安装exuberant-ctags: 非必须
2.  下载taglist_42.zip: http://www.vim.org/scripts/download_script.php?src_id=7701
3.  解压taglist_42.zip : unzip taglist_42.zip
4.  拷贝taglist下的doc和plugin文件夹到~/.vim文件夹下
5.  进入~/.vim/doc目录，输入vim，然后用“:helptags .”在该目录下生成tags文件
6.  用vim打开文件，然后输入":TlistToggle"，显示函数列表

linux非root用户的设置：
1. vim ~/.vimrc
加入 source $TAGLISTPATH/plugin/taglist.vim

常用命令
:TlistToggle 切换函数列表的展现和折叠""

## ctags 全局库函数
systags:
```
sudo ctags -I __THROW --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --fields=+S -R -f ~/.vim/systags /usr/include /usr/local/include
```

## 上传到GitHub的文件进行加密
vim xxx.txt 之后使用 :X 进行输入密码，上传到GitHub的文件就是加密过的，这点很不错，可以保存自己的私有文件在共有仓库中。
这样就可以在同一个仓库进行grep等操作。

## 行尾增加指定字符
> : 12,$s/$/ \|/g

## 行首增加指定字符
> : 12,15s/^/#/g

## 指定行进行缩进
> 6<<  # 缩进6行，包括当前行，所以就是对应着relativenumber的5

## 删除当前行的当前字符到行尾
> D

## 向上删除4行
> 3dk

## 删除到文件末尾
> dG

## 删除多余空行
> :g/^$/d # 指定行：:2,$g/^$/d
> ::g/^\s*$/d

## 删除行尾空格
> :2,3s/  *$//g

## 自动代码格式调整
```
1. gg 跳转到第一行
2. shift+v 转到可视模式
3. shift+g 全选
4. 按下神奇的 =
```

[参考](https://www.cnblogs.com/zl-graduate/p/5777711.html)
