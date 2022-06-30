# 调试不同语言环境

> 如何在中文系统环境，调试不同的语言翻译导致的bug，比如英文、藏文或者其他语种的字符显示、翻译生效等问题？ 

1. 直接控制面板切换语言，重启。太耗时间，效率不高。
2. 通过改名翻译语言文件，使得当前系统语言找不到翻译文件。默认为英文，但其他语言支持不好。
3. 通过修改环境变量。在qtcreator或者终端中修改环境变量，即直接修改当前应用的运行语言环境，可以适用于其他语种，效率也高，比较推荐。

英文命令如下：
LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 kylin-scanner

中文命令如下：
LANG=zh_CN.UTF-8 LANGUAGE=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8 kylin-scanner

藏文命令如下：
LANG=bo_CN.UTF-8 LANGUAGE=bo_CN.UTF-8 LC_ALL=bo_CN.UTF-8 kylin-scanner

其他语言可参考如上。
