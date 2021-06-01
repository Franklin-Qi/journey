# SPEC文件制作

[linux制作RPM包](https://www.cnblogs.com/pycode/p/6508401.html)

## 常见问题

### 1、rpmbuild -ba 失败？

现象描述:
warning: Installed (but unpackaged) file(s) found:
   /usr/share/doc/software-center/scc-init.pyc
  /usr/share/doc/software-center/scc-init.pyo
导致rpmbuild -ba失败;同时，rpm -e --nodeps software-center
警告：文件 /usr/share/doc/software-center/scc-init.pyo: 移除失败: 没有那个文件或目录

在/usr/lib/rpm/macros文件中有一个定义:
%_unpackaged_files_terminate_build 1
把1改为0只警告

测试结果：
rpm -e 正常；
rpm -ba 正常。

### 2、模块未找到
python /usr/sbin/neokylin-software-center_start.py 报模块tkinter或notify-python未找到？
- 1、yum search tkinter 进行查找相关rpm1，如在arm平台未找到，可以在兆芯或龙芯上找到相关.src.rpm包进行编译安装
- 2、yum install rpm1，安装失败，考虑yum源是否正确
- 3、再执行脚本

注：
arm平台的yum源地址: http://10.1.123.232/kojifiles/repos/ns7.5-aarch64-nd-build/latest/aarch64/
兆芯平台yum源地址：http://10.1.122.182/kojifiles/repos/nd7-x86-ty-zx-build/latest/x86_64/
已废弃龙芯平台yum源地址：http://10.1.122.122/kojifiles/repos/nd7-mips64-ty-Release-build/latest/mips64el/
新的龙芯平台yum源地址：http://10.1.122.122/kojifiles/repos/nd7-mips64-ty-Release-3a4k-dev-build/latest/mips64el/

### 3. yum downgrade降级失败
可通过 --oldpackage

### 4. yum remove 删除依赖恢复
通过/var/log/yum.log 查看当天Erase内容
mate-system-log -> yum.log

### 新环境如何进行改bug
1. 环境配置
1.1 vim文件进行拷贝
1.2 /etc/yum.repo.d/下文件koji地址更改以及拷贝submit2koji.sh
sudo yum clean all && sudo yum update
当yum update依赖提示错误，可以先rpm -e xxx --nodeps，之后sudo yum update

1.3 到koji得到地址xxx.src, 并进行rpm -ivh xxx.src
1.4 解决依赖：sudo yum-builddep SPECS/caja.spec
1.5 编译软件源码：rpmbuild -bp SPECS/caja.spec


# 关于mutter 管理器的重复做补丁和rpm包问题

不需要重复性的做很多的补丁包，然后更改spec文件，否则最后一步的汇总会很麻烦。最好的方式是只修改一个补丁包，利用这个补丁包进行
做rpm包。

- 1. 源码包先做2个备份(xxx.bak和xxx.tmp), xxx.tmp为工作目录；

- 2. 在 xxx.tmp 中修复源码;
- 3. 做补丁包，如 diff -Nura xxx.bak xxx.tmp > ../SOURCE/xxx.patch ;
- 4. 做rpm包，如 mutterbp , mutterba ；
- 5. mysudo yum downgrade mutter -y 降级 ；
- 6. mysudo rpm -Uvh xxx 升级, 进行调试跟踪, 验证功能正确性 ；


调试时，2,6步骤只需要不断重复，而步骤1只需要一次，这样就提高了效率。

此方式适用于大多数情况，可安全使用。

# koji 讲解
nd: desktop 桌面
nk: 全平台
ns: server 服务器

当gerrit不存在时，需要向左工申请，格式如： 龙芯桌面mutter在gerrit上没有，需要新增gerrit项目。


# gerrit初始化仓库、代码同步以及代码提交

## 第一次从gerrit上git下来空的目录, 用除cs2c的版本在fedora查找指定的版本下载并在gerrit仓库目录安装
  923  wget https://kojipkgs.fedoraproject.org//vol/fedora_koji_archive01/packages/gsettings-desktop-schemas/3.14.1/1.fc21/src/gsettings-desktop-schemas-3.14.1-1.fc21.src.rpm
  925  cd nd7.0-gsettings-desktop-schemas-3.14.1/

  927  rpm -ivh -D "_topdir `pwd`" ../gsettings-desktop-schemas-3.14.1-1.fc21.src.rpm  // 在fedora下载的原始源码包(无cs2c人员修改),这是到~/rpmbuild中
  929  rpmbuild  -bp -D "_topdir `pwd`" SPECS/gsettings-desktop-schemas.spec
or 
  344  rpm -ivh -D "_topdir `pwd`/glib2-2.50.3-3.nd7.7" glib2-2.50.3-3.nd7.7.src.rpm // 这是到~/glib2-2.50.3-3.nd7.7中
  347  rpmbuild -bp -D "_topdir `pwd`" SPECS/glib2.spec // 或者装到指定目录

  935  git add .
  936  git status
  937  git commit -m "BASE"
  939  vib
  940  gitpush


## 第二次从koji上直接用地址进行同步数据
  943  rpm -ivh -D "_topdir `pwd`" http://10.1.122.122/kojifiles/packages/gsettings-desktop-schemas/3.14.1/1.nd7.9/src/gsettings-desktop-schemas-3.14.1-1.nd7.9.src.rpm         //在最新koji上的源码包
  945  rpmbuild  -bp -D "_topdir `pwd`" SPECS/gsettings-desktop-schemas.spec
  946  git add .
  947  git status
  948  git commit  -m "sync old versions"
  949  gitpush


## 第三次把已经修改源码、验证功能的源码包直接在gerrit仓库目录进行安装
  976  rpm -ivh -D "_topdir `pwd`" /tmp/mutter-3.14.4-2.nd7.27.src.rpm   //在本地rpmbuild生成的源码包
  978  rpmbuild  -bp -D "_topdir `pwd`" SPECS/mutter.spec
  980  vi SPECS/mutter.spec
  983  git status
  984  rpmbuild  -bs -D "_topdir `pwd`" SPECS/mutter.spec
  988  mv SRPMS/mutter-3.14.4-2.nd7.27.src.rpm  /tmp/
  989  cd /tmp/
  991  /usr/bin/submit2koji.sh   //查看经过bs生成的源码提交koji格式
  992  /usr/bin/submit2koji.sh mutter-3.14.4-2.nd7.27.src.rpm  nd7-x86-ty-zx kunpeng.wu kunpeng.wu --scratch  //兆芯桌面
  994  sudo /usr/bin/submit2koji.sh mutter-3.14.4-2.nd7.27.src.rpm  nd7-mips64-ty-Release  kunpeng.wu kunpeng.wu --scratch  //龙芯

## 在koji上把包下载到龙芯或兆芯,经过验证的功能，就可以git add . ; git commit ;以及git push 提交到gerrit上了。
  946  git add .
  947  git status
  948  git commit  -m "win key combinations"
  949  git push origin HEAD:refs/for/master

当git push 不如意时，可以在原有仓库进行(格式问题：%s/ \n/ \r/gc)
git reset 上一版本(git log 中shuoqi.yu 之前的一个版本)
再进行修改后，git add/commit/push
同时可在gerrit上abandon掉上一个提交记录。

