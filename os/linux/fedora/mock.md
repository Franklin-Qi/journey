# 使用mock配置文件来进行编译
```
[root@test ~]$ mock -r xxx --init          #初始化，不需要加xxx.cfg后缀

#开始搭建环境并编译，使用此命令每次都会清空原有环境，重新搭建编译环境。
[root@test ~]$ mock -r xxx --rebuild package-1.2-3.src.rpm   

# 不对环境进行清理，检测并安装依赖的包后，进行编译。(此方法配合chroot方法较为方便)
[root@test ~]$ mock -r xxx --no-clean --rebuild package-1.2-3.src.rpm  


使用chroot的方法进行编译 
[root@test ~]# cd /var/lib/mock/xxx/root 
[root@test ~]# chroot . 

```


# mock 编译环境配置
1.安装mock
    从koji服务器下载并安装mock。

2，mock使用方法
mock编译过程最好不要用root身份，先建立一个普通的用户。


3.配置本地机的/etc/mock/xxx.cfg文件。（配置文件）

例如：test_mips64el.cfg
config_opts['root'] = 'test.cfg'
config_opts['target_arch'] = 'mips64el'
#config_opts['target_arch'] = 'x86_64'
config_opts['chroot_setup_cmd'] = 'groupinstall build'
config_opts['dist'] = 'ns7_4'
#config_opts['dist'] = 'nd7'

config_opts['plugin_conf']['ccache_enable'] = False

##config_opts['plugin_conf']['root_cache_enable'] = False

##config_opts['plugin_conf']['yum_cache_enable'] = False



config_opts['yum.conf'] = """

[main]

cachedir=/var/cache/yum

debuglevel=1

logfile=/var/log/yum.log

reposdir=/dev/null

retries=20

obsoletes=1

gpgcheck=0

assumeyes=1



# repos
```
[local-mock]
name=local-mock
baseurl=file:///var/www/html/repos/origin/
skip_if_unavailable = 1
enabled=1

[koji]
name=koji
#baseurl=http://10.1.60.20/kojifiles/repos/ns7.4-build/latest/mips64el/
baseurl=http://10.1.82.10/kojifiles/repos/ns7.4-build/latest/mips64el/
#baseurl=http://10.1.122.122/kojifiles/repos/nd7-mips64-ty-Release-build/latest/mips64el/
#baseurl=http://10.1.122.182/kojifiles/repos/nd7-x86-ty-zx-build/latest/x86_64/
#skip_if_unavailable = 1
enabled=1

"""
##config_opts['chroothome'] = '/builddir'
##config_opts['use_host_resolv'] = False
config_opts['basedir'] = '/var/lib/mock'
##config_opts['rpmbuild_timeout'] = 259200

config_opts['macros']['%_topdir'] = '/builddir/build'

##config_opts['macros']['%_host'] = 'mips64el-neokylin-linux-gnu'
##config_opts['macros']['%_host_cpu'] = 'mips64el'
config_opts['macros']['%vendor'] = 'CS2C'
##config_opts['macros']['%distribution'] = 'Koji'
##config_opts['macros']['%_rpmfilename'] = '%%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm'
config_opts['macros']['%packager'] = 'NeoKylin Linux'
##
```

文件修改完成

```
[root@test ~]# useradd mockbuilder 
[root@test ~]# usermod -a -G mock mockbuilder 
[root@test ~]# su  -  mockbuilder
```


详见help。


