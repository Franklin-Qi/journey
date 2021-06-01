本文目录
=================

* [一、更改rm命令为移动到回收站](#一更改rm命令为移动到回收站)
   * [1. 安装trash-cli](#1-安装trash-cli)
   * [2. 配置trash-cli](#2-配置trash-cli)
   * [3. 使用trash-cli](#3-使用trash-cli)
   * [4. 定期删除超过回收站超过30天的文件或文件夹](#4-定期删除超过回收站超过30天的文件或文件夹)
   * [二、删除除了某个文件之外的所有文件](#二删除除了某个文件之外的所有文件)

# 一、更改rm命令为移动到回收站
Linux哲学为假定用户知道自己在干什么，并且能为自己行为负责。
但是有时用户还是会将不期望删除的数据删除，使用extundelete并不会恢复已删除的数据。
这种情况产生是让人崩溃的，但同样可以通过更改rm命令为移动到回收站进行避免。

## 1. 安装trash-cli
```
sudo apt install trash-cli
```

## 2. 配置trash-cli
编辑/etc/bash.bashrc替代rm
```
alias rm ="trash-put"
source /etc/bash.bashrc`
```

## 3. 使用trash-cli
用户回收站目录为`~/.local/share/Trash/files/`
```
trash-put   # 将文件或目录放入回收站
trash-empty # 清空回收站
trash-list  # 列出回收站文件
trash-restore   # 还原回收站文件
trash-rm    # 删除回收站的单个文件
```

## 4. 定期删除超过回收站超过30天的文件或文件夹
```
(crontab -l ; echo "@daily $(which trash-empty) 30") | crontab -
```
使用crontab -l查看已修改的配置。


## 二、删除除了某个文件之外的所有文件
shopt 启用了 shell 选项 extglob，支持 !
> shopt -s extglob

> rm -rf !(file)
> rm -rf !(file1 | file2)

