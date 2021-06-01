# ubuntu 安装svn 进行GitHub文件夹的安装
1. 首先安装svn  

sudo apt install subversion

2. 利用svn co 更改分支为trunk进行下载文件夹

svn co https://github.com/spmallick/learnopencv/tree/master/hdr

更改/tree/master => /trunk

svn co https://github.com/spmallick/learnopencv/trunk/hdr

