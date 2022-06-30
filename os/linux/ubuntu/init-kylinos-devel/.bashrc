# .bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

PS1="\[\e[0m\][\[\e[32m\]\u\[\e[35m\] \[\e[36m\]\w\[\e[0m\]]\\$ "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# [ -r /usr/share/kysec-auth/kysec_env.sh ] && . /usr/share/kysec-auth/kysec_env.sh


#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

# Enable options:
shopt -s extglob       # Necessary for programmable completion. use ! command

#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.


# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

#-------------------------------------------------------------
# Shell Prompt - for many examples, see:
#       http://www.debian-administration.org/articles/205
#       http://www.askapache.com/linux/bash-power-prompt.html
#       http://tldp.org/HOWTO/Bash-Prompt-HOWTO
#       https://github.com/nojhan/liquidprompt
#-------------------------------------------------------------

# 格式：\033[显示方式;前景色;背景色m
# 
# 说明：
# 前景色            背景色           颜色
# ---------------------------------------
# 30                40              黑色
# 31                41              红色
# 32                42              绿色
# 33                43              黃色
# 34                44              蓝色
# 35                45              紫红色
# 36                46              青蓝色
# 37                47              白色
# 
# 显示方式           意义
# -------------------------
# 0                终端默认设置
# 1                高亮显示
# 4                使用下划线
# 5                闪烁
# 7                反白显示
# 8                不可见
# 
# 例子：
# \033[1;31;40m    <!--1-高亮显示 31-前景色红色  40-背景色黑色-->
# \033[0m          <!--采用终端默认设置，即取消颜色设置-->

# icon window-maximize-symbolic.svg folder-open.svg

# for vi mode
set -o vi on

# 对其输出 mount 的内容
alias mount='mount | column -t'

# 默认添加 ping 的次数
alias ping='ping -c 5'

# 删除文件时需要确认
alias rm='rm -i'

# 更新 Debian 系统中的软件
alias myupdate='sudo apt-get update && sudo apt-get upgrade'

# wget 默认断点续传
alias wget='wget -c --no-check-certificate'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# wget
#alias mywget='wget --no-check-certificate '

# for pycharm
alias pycharm='nohup sh /opt/pycharm-community-2020.3/bin/pycharm.sh  >/dev/null 2>&1 &'
# for codestyle
alias kylin-code-style='find . -regex ".*\.\(cpp\|h\|hpp\)$" |xargs astyle '

# for tar before debuild
# DEB_BUILD_OPTIONS=" nocheck notest " # for nocheck in make test
# DEB_BUILD_PROFILES=" nocheck notest "
alias mytar='tar -czvf kylin-scanner_1.0.0.orig.tar.gz --exclude=debian --exclude=.git kylin-scanner-1/'
#alias mydebuild='dpkg-buildpackage -sa -S -nc -kFAAF26EE2DA1EABD'
alias mydebuild='debuild -sa -S -nc  -k6517D11F9C557A88'
alias debuildmodify2='debuild --no-lintian -S -sa -nc -d -k6517D11F9C557A88 '
alias dputdevdaily='dput devppa:neokylin/kylin-desktop/v10-sp1-team-dev'
alias dputchangchengt321=' dput devppa:xc-cpu-desktop-design/kylin-desktop/oem-zjspcc-t321 '

# https://dev.kylinos.cn/kylin-desktop/v101-2107
alias dput2107=' dput dev:kylin-desktop/v101-2107-proposed '

# my 2107, kylin-desktop/2107创建ppa, v101-2107必须加，否则就是以主线编译，不是2107系列编译
alias dputmy2107='dput lpdev:~yushuoqi/kylin-desktop/2107/v101-2107 '

# https://dev.kylinos.cn/kylin-desktop/v101-2203/+package/kylin-music
alias dput2203='dput dev:kylin-desktop/v101-2203-proposed '

# https://dev.kylinos.cn/~ukui3.1-developer/+archive/kylin-desktop/v3.1.4
alias dputui314='dput devppa:ukui3.1-developer/kylin-desktop/v3.1.4'

# https://dev.kylinos.cn/+kylin/archive_publish?distro=kylin-desktop&series=v101
alias dput2209='dput dev:kylin-desktop/v101-proposed '
alias dputv101='dput dev:kylin-desktop/v101-proposed '

# https://dev.kylinos.cn/~yushuoqi/+archive/kylin-desktop/v3.1.4
alias dputmy314='dput devppa:yushuoqi/kylin-desktop/v3.1.4 '

################################################################################
################################################################################
# launchpad: https://launchpad.dev/~ubuntukylin-developer/+archive/ubuntu/2004pro
alias dput2004='dput devppa:ubuntukylin-developer/ubuntu/2004pro '

# 版本系列地址： https://launchpad.dev/kylin-desktop/v101.hw
# 源码包查看地址： https://launchpad.dev/+kylin/archive_publish?distro=kylin-desktop&series=v101.hw
alias dput990='dput dev:kylin-desktop/v101.hw-proposed '

# 版本系列地址： https://launchpad.dev/kylin-desktop-kv/v101.hw
# 源码包查看地址： https://launchpad.dev/+kylin/archive_publish?distro=kylin-desktop-kv&series=v101.hw
alias dput9a0='dput dev:kylin-desktop-kv/v101.hw-proposed '

# 源码包查看地址： https://dev.kylinos.cn/~neokylin/+archive/kylin-desktop-kv/panguw/+packages
# deb http://ppa.launchpad.dev/neokylin/panguw/kylin-desktop-kv v101.hw main 
# deb-src http://ppa.launchpad.dev/neokylin/panguw/kylin-desktop-kv v101.hw main 
alias dputpanguw='dput devppa:neokylin/kylin-desktop-kv/panguw '
alias dputtibetan='dput devppa:tibetan/kylin-desktop/v10-sp1 '

# 仓库地址：https://dev.kylinos.cn/ubuntukylin/jammy
# 传包仓库地址：dput dev:ubuntukylin/jammy-proposed
alias dputubuntukylinjammy='dput dev:ubuntukylin/jammy-proposed '


alias dputcommon='dput -u lpdev:~kylindev/kylin/v101-loongarch-modify/v101 '
alias dputmodify='dput lpdev:~kylindev/kylin/v101-loongarch-modify/v101 '
alias dputmodify2='dput lpdev:~kylindev/kylin/v101-loongarch-modify2/v101 '



## personnal ppa
# 所有版本系列地址： https://dev.kylinos.cn/~yushuoqi
alias dputmyv101='dput devppa:yushuoqi/kylin-desktop/v101-kylin-desktop '
alias dputmyv101update='dput devppa:yushuoqi/kylin-desktop/v101-update '
alias dputmy990='dput devppa:yushuoqi/kylin-desktop/990 '
alias dputmy9a0='dput devppa:yushuoqi/kylin-desktop-kv/9a0 '
alias dputmypanguw='dput devppa:yushuoqi/kylin-desktop-kv/panguw  '
alias dputmypanguw2='dput devppa:yushuoqi/kylin-desktop-kv/panguw2  '
alias dputmypanguwupdate='dput devppa:yushuoqi/kylin-desktop-kv/panguw-update2  '


################################################################################
################################################################################



# for auditctl: $1 filename
function myauditctrl {
    sudo auditctl -w "$1" -p warx -k auth_key
}
function myausearch {
    sudo ausearch -i -k auth_key
}
# problem:
# sudo echo fs.inotify.max_user_watches=100000 | sudo tee -a /etc/sysctl.conf
# sysctl -p

# for cppcheck: $1 is filename
function mycppcheck {
    cppcheck --enable=warning,style,performance "$1" 2>err.txt; vi err.txt
    #cppcheck --enable=all "$1" 2>err.txt; vi err.txt
}

# Function toc-md: help gh-md-toc to generate dir
function md-toc {
    echo "$(gh-md-toc  $1)" >> $1
}

# Function myfind: abbr find
function myfind {
    find . -name $1
}

# mygitconfig
alias gitmyconfigemail='git config user.email "18513412153@163.com"'
alias gitmyconfigname='git config user.name "Franklin-Qi"'
alias gitmybeforemerge='git config --global merge.ours.driver true '

# Function mygitcommit:
function mygitcommit {
    git add . ; git commit -m "$1"
}

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# smb://10.1.80.80/loongson/mipsDoc/shuoqi.yu qwer1234

# ps -ef
alias myps='ps -ef | grep '

# lintian
alias mylintian='lintian -i -EvIL +pedantic --verbose ../kylin-scanner_1.0.0_amd64.changes > lintian.txt'

# cman
alias cman='man -M /usr//share/man/zh_CN'
export LC_CTYPE=zh_CN.UTF-8

# mysql
alias mysqllogin='mysql -udebian-sys-maint -pMTiXp6Dt0Oe1ct2F'

# color
alias ls='ls -h --color '
alias grep='grep --color '

# .bashrc
alias vib='vim ~/.bashrc'
alias srcb='source ~/.bashrc'

# vim
alias vi='vim '
alias vifile='cd ~/; vim '

# cd
alias cdsrc='cd /home/yusq/example-qtcreator/src/'
alias cdrpmbuild='cd ~/rpmbuild/'
alias cdbuild='cd ~/rpmbuild/BUILD/'
alias cdhome='cd ~/'
alias myturn='cd -'
alias ..='cd ../'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias cdcodefactory='cd /home/yusq/CodeFactory '

# git
alias gitpush='git push origin HEAD:refs/for/master'
alias buildbp='rpmbuild -bp -D "_topdir `pwd`" '
alias buildba='rpmbuild -ba -D "_topdir `pwd`" '
alias buildbs='rpmbuild -bs -D "_topdir `pwd`" '

# ssh
alias sshloongson='ssh yusq@10.1.81.129' # ']\
alias ssharm='ssh yusq@10.1.81.206'
alias sshl2='ssh root@10.1.81.202 -X' # 1

# nohup stardict
alias nohupstardict='nohup  stardict  >/dev/null 2>&1 &'

# software-center
alias cdsoftware='cd /usr/share/doc/software-center/'

# codefactory
alias cdfedora='cd ~/code/trunk/CodeFactory/Linux/Fedora/'

# mutter
alias mygrep='grep -nr '
alias myschemas='sudo glib-compile-schemas schemas/'
alias cdglib='cd /usr/share/glib-2.0/'
alias vibindings='sudo vim schemas/org.gnome.desktop.wm.keybindings.gschema.xml'
alias cdmutter='cd ~/rpmbuild/BUILD/mutter-3.14.4/'
alias vimutter='cd ~/rpmbuild; vim SPECS/mutter.spec'
alias vikey='cd  ~/rpmbuild/BUILD/mutter-3.14.4/; vim src/core/keybindings.c'
alias viwin='vim src/core/window.c'
alias mutterbp='rpmbuild -bp SPECS/mutter.spec'
alias mutterba='rpmbuild -ba SPECS/mutter.spec'
alias cpa='cp mutter-3.14.4/ bak -a'
alias mydiff='diff -Nura bak/ mutter-3.14.4/ > '


# eom
alias cdeom='cd ~/rpmbuild/eom-1.24.0/'


# valgrind memory loss
alias myvalgrind='valgrind --tool=memcheck --log-file=test.log  --leak-check=yes --show-reachable=yes ~/build-kylin-scanner-Desktop-Debug/src/kylin-scanner'


function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
    for fs ; do

        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}

function my_ip() # Get IP adress on ethernet.
{
    ifconfig_path=$(which ifconfig)
    dev_eth="ens33"
    MY_IP=$(${ifconfig_path} ${dev_eth} | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}

function corename()   # Get name of app that created a corefile.
{
    for file ; do
        echo -n $file : ; gdb --core=$file --batch | head -1
    done
}

alias apilaunchd='https://api.launchpad.dev/devel/kylin-desktop/v101/amd64'
alias mylogout='ukui-session-tools --logout'

function gitclonekylin()
{
    git clone https://hub.fastgit.org/UbuntuKylin/$1.git
}

function gitcloneukui()
{
    git clone https://hub.fastgit.org/ukui/$1.git
}

function gitcloneFranklinQi()
{
    git clone https://github.com.cnpmjs.org/Franklin-Qi/$1.git
}

# avoid rm -rf /*
#alias rm='trash-put'
#alias rM='/bin/rm'

# wy: derek@172.30.40.141 Derek@0314

# For dch -i
export DEBFULLNAME="yushuoqi"
export DEBEMAIL="yushuoqi@kylinos.cn"

# For rdesktop
alias myrdesktop="nohup rdesktop -f -r clipboard:PRIMARYCLIPBOARD -r disk:MyDisk=/home/yushuoqi/ -a 16 -u yusq 172.30.40.149 2>&1 &"


# openssl enc
function encryption() 
{ 
 /usr/bin/openssl enc -aes128 -pbkdf2 -in $1 -out $1.aes128enc
}

function decryption() 
{ 
 /usr/bin/openssl enc -aes128 -pbkdf2 -d -in $1 -out $1.aes128dec
}

# /etc/resolv.conf 
# nameserver 172.30.191.2

# vmware tools
function myvmwareshare()
{
    vmhgfs-fuse .host:/nfs /home/yushuoqi/hgfs/
}

# kysec stop
function mykysecstop()
{
    sudo systemctl stop kysec*
}

function mygitlabdownload()
{
    git clone http://gitlab2.kylin.com/kylin-desktop/$1.git
}

function mylogout()
{
    ukui-session-tools --logout
}

function myhugoserver()
{
    hugo server -e production -D
}

# vpn code: byr-l5tey-5b


# valgrind
alias myvalgrind='valgrind --leak-check=yes --trace-children=yes --show-reachable=yes --log-file=kylin-scanner.log '


# panguw machine: kylin@172.30.40.98 qwer1234
# panguw ppa: https://dev.kylinos.cn/~neokylin/+archive/kylin-desktop-kv/panguw/+packages
alias mysshpanguw='ssh kylin@172.30.40.98 '
alias myssharm64='ssh c@172.30.40.69 ' # 密码空格

# liucong arm machine(the same as panguw): c@172.30.40.69 密码空格
alias mysshliucong='ssh c@172.30.40.69 '

## useful shell command
# find .  -name "*.cpp" -o -name "*.cc" -o -name "*.h" |xargs licensecheck -r |grep "UNKNOWN" |grep -v "plugins-simple"  |awk -F":" '{print $1}' |xargs |tee file.tx
# find .  -name "*.cpp" -o -name "*.cc" -o -name "*.hpp" -o -name  "*.h" |xargs licensecheck -r |grep "UNKNOWN"   |awk -F":" '{print $1}'
# find .  -name "*.cpp" -o -name "*.cc" -o -name "*.hpp" -o -name  "*.h" |xargs licensecheck -r |grep "UNKNOWN"   |awk -F":" '{print $1}' |tee file.txt


## dbus-send
# 其中 “--session” 指会话总线，“--dest” 指对象名称，“/” 指对象路径，“org.freedesktop.DBus.ListNames” 指“接口+方法名”。之后，我们切换到调用 dbus-monitor 的终端，看到相应输出
# dbus-send --session --type=method_call --print-reply --dest=org.freedesktop.DBus / org.freedesktop.DBus.ListNames

## wayland
# kylin-scanner -platform wayland

# token: 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
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
export PATH="$HOME/gems/bin:$PATH"

function myhistory()
{
    history | awk '{CMD[$2]++;count++;} END { for (a in CMD )print CMD[ a ]" " CMD[ a ]/count*100 "% " a }' | grep -v "./" | column -c3 -s " " -t |sort -nr | nl | head -n10
}

# english language
alias myenglishenv='LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 '

# bo_zh language
alias mybozhenv='LANG=bo_CN.UTF-8 LANGUAGE=bo_CN.UTF-8 LC_ALL=bo_CN.UTF-8 '

