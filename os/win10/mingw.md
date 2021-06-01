# MingW
官网和sourceforge下载太慢，[msys2](1) 运行安装包很快

安装参考： [mingw-w64](2)
```
pacman -Syu  //同步数据库, 需要多次，直到无事可做

pacman -S mingw-w64-x86_64-gcc //安装mingw-w64

pacman -Sl | grep gcc //查看gcc包
```

## 设置mingw-w64环境变量
mingw64安装目录：C:\msys64\mingw64\bin

“环境变量” => PATH 增加 C:\msys64\mingw64\bin

验证一下: 按win+r运行cmd或者powershell输入gcc -v



[1]: https://www.msys2.org/
[2]: https://www.cnblogs.com/fanbi/p/10315753.html