# 龙芯v7 qt5-qtbase源码编译
```shell
1. 配置yum koji为: http://10.1.122.122/kojifiles/repos/nd7-mips64-ty-Release-3a4k-dev-build/latest/mips64el/
2. sudo yum-builddep SPECS/qt5-qtbase.spec # 解决相关依赖
3. sudo yum install  mesa-libwayland-egl mesa-libwayland-egl-devel gegl gegl-devel gegl-operations-workshop mesa-libEGL-devel
4. rpmbuild -ba SPECS/qt5-qtbase.spec
```
其中，步骤3是为了解决egl相关错误，因为直接编译src.rpm包会出现在%file阶段找不到egl相关内容。
但又不能去除掉%file内容造成qtbase基础库缺失。

所以在Google搜索了`File not found by glob qt5-qtbase "libQt5EglFSDeviceIntegration"`出错内容，
找到了官方的spec文件，对比了egl相关，进行了如下修改，同时按照步骤3安装了`mesa-libEGL-devel`包，完成编译工作：
```shell
1. 注释掉BuildRequires: pkgconfig(egl)，并添加BuildRequires: mesa-libEGL-devel；
2. 注释掉Requires: pkgconfig(egl)，并添加Requires: mesa-libEGL-devel。
```
