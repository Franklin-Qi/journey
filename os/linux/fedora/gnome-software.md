# gnome-software 安装软件流程
```
src/plugins/gs-plugin-shell-extensions.c
    gs_plugin_add_installed
        => gs_plugin_shell_extensions_add_app

gs_app_list_check_for_duplicate 


[yusq@localhost src]$ grep -nr "adding " | grep "g_debug" | grep "as nothing"
gs-app-list.c:79:               g_debug ("adding %s as nothing matched hash", id);

=====
gs_app_list_check_for_duplicate(安装程序重复检查) => return TRUE;

gs-app-list.c:
gs_plugin_app_install => gs_app_list_add => gs_app_list_add_safe => gs_app_list_check_for_duplicate


gs-plugin-loader.c:
gs_plugin_loader_app_action_async => gs_plugin_loader_app_action_thread_cb

shotwell install failed:
06:59:56:0215 Gs failed to call gs_plugin_app_install on packagekit: installing not available
gs_plugin_loader_app_action_async("gs_plugin_app_install") => g_task_run_in_thread(gs_plugin_loader_app_action_thread_cb)


gs-cmd.c:
main => gs_plugin_loader_app_action => gs-plugin-loader-sync.c(gs_plugin_loader_app_action_async())
     => gs_app_list_add => gs_app_list_add_safe => gs_app_list_check_for_duplicate


src/gs-plugin.c;
emitting downloading => return ... (gs_plugin_status_to_string())
gs_app_get_id (app) => a specific app name

gs_plugin_loader_setup => gs_plugin_loader_open_plugin => gs_plugin_loader_status_changed_cb => gs_plugin_status_to_string



src/plugins/gs-plugin-appstream.c +126
AppStream metadata changed

gs_plugin_setup => gs_plugin_appstream_store_changed_cb => 

gs_plugin_loader_setup => gs_plugin_setup


src/gs-plugin-loader.c +4717   GsPlugin::%s(%s)
run 0x120309190~GsPlugin::odrs(gs_plugin_app_install;gs_plugin_refine)
gs_plugin_loader_run_results 


vi src/plugins/gs-appstream.c  +141
run 0x120309190~appstream::refine-app
gs_appstream_refine_app





```




# Demand
调研分析服务器版本“软件商店”Application Installer的相关源码，可以 fedora30 和 兆芯服务器 作为调研对比对象 1，列举gnome-software具备哪些功能，注意关注兆芯或龙芯服务器版本 和 开源最新版本之间的功能差异对比；
2，熟悉各功能点实现的原理方法，分析相关代码逻辑并熟悉该软件架构；

根据调研分析，编写文档记录代码分析结果（反写软件开发设计文档，包含程序流程图），并根据分析情况评估该软件还有哪些可优化升级的点，为后续在此基础上进行新功能开发或进行相似功能软件设计开发做预研铺垫。


# gnome-software 
[Linux 公社](https://www.linuxidc.com/Linux/2018-08/153432.htm)
对于GNOME 3.30，我们已经启用了人们一直要求的东西，至少从gnome-software项目的诞生开始：
自动安装更新，”Richard Hughes说。 “由于自动更新软件包仍然不安全，我们将限制对Flatpaks的自动更新。
虽然我们会自动下载固件更新，ostree内容和软件包更新等内容。”

因此，我们认为新的自动更新功能将首先仅适用于Flatpak应用程序，这些应用程序可以安全使用，
这要归功于它们使用的整合技术，但GNOME软件仍会自动下载常规软件包和固件更新，不会自动安装，因此您必须手动安装它们。

[ArchLinux - gnome-software 3.34.1-1](https://www.archlinux.org/packages/community/x86_64/gnome-software/)
[ArchLinux - gnome Introduction](https://wiki.archlinux.org/index.php/GNOME_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
[fedora - gnome-software](https://gitlab.gnome.org/GNOME/gnome-software)
[gnome-software 添加程序分类文件](https://blog.csdn.net/ysyashy/article/details/65934720)

[gnome-sorftware Main Catagories](https://specifications.freedesktop.org/menu-spec/latest/apa.html)


[GNOME API Reference Manual](https://blog.csdn.net/Rong_Toa/article/details/86484459)
[GNOME Software Reference Manual](https://developer.gnome.org/gnome-software/stable/)  
[API Reference Manual](https://developer.gnome.org/gnome-software/unstable/gnome-software-GsPlugin-Exports.html)
[comment]:<> (This is nice.)
[Glib Reference Manual](https://developer.gnome.org/glib/stable/)

[meson Reference Manual](https://www.mesa3d.org/meson.html)
[developer](https://developer.gnome.org/)

## 安装依赖、安装软件
yum-utils
rpm-build ==> yum provides rpmbuild
之后对逐个依赖进行安装

devhelp 用于查看gnome-software文档


sudo yum install gcc-c++ libstdc++-devel 
golang环境:
https://github.com/goadesign/goa
https://github.com/goadesign/goa/goagen

goa框架：
https://www.cnblogs.com/zhangqingping/p/5531171.html

# 功能剖析流程

## 1. 界面功能熟悉应用
### 实现的功能
### 整体架构,运行机制
理解设计者的思路
网络请求的框架就可以了，知道是通过什么请求的，在哪里请求，请求返回的是什么；运行过程中，要多打些日志便于了解传递机制。 

## 2. 源码分析
### 程序所有组件

### 找到程序入口
#### 日志分析
首页->application 详细信息:
src/gs-shell.c |2366 : "search-changed" ==> search_changed_handler()
plugins/flatpak/gs-flatpak.c | : gs_flatpak_refine_app ==> 日志中GsPluginFlatpak 说明是flatpak插件



### 程序所需权限
### 产品文档

## 目录结构分析



## 3. 阅读源码
### 目的
新的模式|编码风格|满足需求

利用调试器|编译器给出的警告或输出的符号代码|系统调用跟踪器|数据库结构化查询语言的日志机制|
包转储工具和Windows的消息侦查程序, 定出的bug的位置
### 调试

```
killall gnome-software
/usr/bin/gnome-software --verbose

```

### 使用调试函数
gnome-software-3.34.1/lib/gs-plugin-loader.c|2775 col 13| *g_debug* ("compatible-project: %s", projects[i]);

### 生成和配置文件
/usr/share/glib-2.0/schemas/*org.gnome.software.gschema.xml*
gnome-software-3.34.1/data/*org.gnome.software.gschema.xml*|3 col 16| <key name="compatible-projects" type="as">

### keywords:
compatible-project: GNOME
初始化时，正在下载应用程序评分、正在下载软件目录


## 编译
通过rpmbuild 进行编译,依赖报错装依赖。



