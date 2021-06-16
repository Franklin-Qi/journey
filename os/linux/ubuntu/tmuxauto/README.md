# autotmux
tmux auto scripts

## 自定义配置autotmux
Using *root* privileges to exec cmds as follows:
```bash
$ cp /etc/tmux.conf /etc/
$ mv autotmux /usr/bin/
$ chmod 777 autotmux
```

使用autotmux脚本
```bash
$ autotmux
```
![autotmux](./autotmux.png)

## tmux 使用
> tmux 是一个终端复用器，它使用户可以在一个终端界面内管理多个会话、窗口和窗格。

tmux 有主要两个用途：

- 分屏。可以同时使用多个命令行；
- 会话与窗口解绑。当窗口意外关闭时，会话并不会终止，当使用SSH远程登录计算机时，可以不受断网的影响。

### tmux 术语
tmux 采用 client/server模型，主要有四个模块：

+ server：服务。tmux运行的基础服务，以下模块均依赖于此服务；
+ session：会话。一个服务可以包含多个会话；
+ window：窗口。一个会话可以包含多个窗口；
+ panel：窗格/面板。一个窗口可以包含多个窗格。

执行 tmux 命令时，即开启了一个服务，并创建了一个会话、窗口和窗格。

### tmux 快捷键
会话相关命令：

查看已有会话：tmux ls
新建会话：tmux new -s <session-name>
接入会话：tmux attach -t <session-name> 或 tmux a -t 0
重命名会话：tmux rename-session -t 0 <new-name>
切换会话：tmux switch -t <session-name> 或 tmux s -t 0
杀死会话：tmux kill-session -t <session-name> 或 tmux kill-session -t 0

tmux 有大量快捷键，所有的快捷键都需要通过前缀键唤起，默认的前缀键是 Ctrl+b。
可以配置`~/.tmux.conf`将默认前缀改为`ctrl+a`。

#### 会话的快捷键
s：列出所有会话
d：离开当前会话
$：重命名当前会话

#### 窗口的快捷键
c：创建一个新窗口
n：切换到下一个窗口
w：从列表中选择窗口
<0~9>：切换到指定编号的窗口，编号显示在状态栏
,：窗口重命名
x: kill当前窗口

#### 窗格的快捷键
%：分成左右两个窗格
"：分成上下两个窗格
z：当前窗格全屏显示，再按一次恢复
q：显示窗格编号
.: 重命名当前窗格编号
,: 重命名当前窗格名字
t：在当前窗格显示时间
<arrow key>：光标切换到其他窗格
o：光标切换到下一个窗格
{：左移当前窗格
}：右移当前窗格
Ctrl+o：上移当前窗格
Alt+o：下移当前窗格
space：切换窗格布局

#### 鼠标支持
鼠标支持的内容：

用鼠标点击窗格来激活该窗格；
用鼠标拖动调节窗格的大小（拖动位置是窗格之间的分隔线）；
用鼠标点击来切换活动窗口（点击位置是状态栏的窗口名称）；
开启窗口/窗格里面的鼠标支持，用鼠标回滚显示窗口内容，按下shift的同时用鼠标选取文本，使用 ctrl+shift+c、ctrl+shift+v 的方式进行复制粘贴。
配置方式为在 ~/.tmux.conf 文件中
```
set -g mouse on
```
配置文件生效
```bash
$ tmux source ~/.tmux.conf

或者在tmux窗口中: source-file ~/.tmux.conf
```

