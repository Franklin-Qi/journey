# fedora 干净环境安装


# Linux software installation manual
Summarize linux software installation manual

[wps-office](#wps-office-id)


## <a id="wps-office-id">wps-office</a>
### install
[wps 官网](https://www.wps.cn/product/wpslinux)
下载rpm包后，使用sudo yum install xxx进行安装

## **xmind**
### install
> 官网下载xmind： XMind-ZEN-for-Linux-64bit.rpm
> sudo yum install  XMind-ZEN-for-Linux-64bit.rpm

> 查看模板 /opt/XMind ZEN/resources/app/templates

### BUGS:
cannot be open with templates, so it is failed, unused.


## **Typora**

### install
> 1. cd /opt/;  wget https://typora.io/linux/Typora-linux-x64.tar.gz
> 2. tar -xzvf Typora-linux-x64.tar.gz -C /typora/
> 3. sudo vim /usr/local/share/applications/Typora.desktop

```
[Desktop Entry]
Name=typora
Version=0.9.53
Exec=/usr/bin/typora
Comment=The Next Document processor based on Markdown
Icon=/opt/typora/resources/app/asserts/icon/icon_128x128.png
Type=Application
Terminal=false
StartupNotify=true
Encoding=UTF-8
Categories=GNOME;GTK;Utility;TextEditor;Development;
MimeType=text/plain;

```

> 4. sudo ln -s /opt/typora/Typora /usr/bin/typora
> 5. sudo chown root:root /opt/typora/chrome-sandbox
> 6. sudo chmod 4755 /opt/typora/chrome-sandbox


Note:
Rather than run without sandboxing I'm aborting now.
You need to make sure that /opt/typora/chrome-sandbox is owned by root and has mode 4755.'

5 and 6 is ok.


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



## atom 手动安装插件包
Atom 用来进行编辑单个文件和编写markdown文件，vim终端下还是用于开发。

### Install
> 安装npm
+ yum install npm

> URL地址
通过CTRL + , 打开settings, 点击install进行安装vim-mode，如果安装失败，看失败日志，找到地址进行下载插件压缩包

> 将下载的文件解压缩到～/.atom/packages/

> 进入vim-mode/,执行npm i命令

Note:
安装 vim-mode(比如f查找就不行，推荐使用vim-mode-plus ,同时禁用vim-mode) ex-mode  relative -numbers(用于快速跳转到指定行)


## Free wifi for linux
[命令行中实现Wifi 连接的方法](https://www.jb51.net/LINUXjishu/234506.html)
[wifi error](https://raspberrypi.stackexchange.com/questions/31507/proper-configuration-for-wpa-supplicant-conf)

### Install
```
git clone https://github.com/oblique/create_ap
cd create_ap
sudo make install

sudo yum install hostapd
sudo create_ap wlp3s0 lo(或wlp3s0) mywifi 512123ysq   <!--  iwconfig could view eth message -->
```


### Bug dealing:
(1) Error: Failed to run hostapd, maybe a program is interfering.Error: Failed to run hostapd, maybe a program is interfering.

switch lo to wlp3s0, or wlp3s0 to lo


## taglist
更新清华大小镜像站的源后，直接yum install vim-taglist

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

## vim
rpm: vim-enhanced
