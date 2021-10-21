本文目录
=================

* [一、创建新仓库](#一创建新仓库)
* [二、创建develop分支](#二创建develop分支)
* [三、创建develop分支进行功能开发](#三创建develop分支进行功能开发)
* [四、功能开发完毕后合并到develop分支](#四功能开发完毕后合并到develop分支)
* [五、分支发布](#五分支发布)
* [六、Tag追踪](#六tag追踪)
* [七、修复线上bug](#七修复线上bug)
   * [八、分支修改理解](#八分支修改理解)
* [九、参考](#九参考)

# 一、创建新仓库
在github或者gitlab中创建一个新的仓库，这时候项目是空的，而且只有一个master分支。

# 二、创建develop分支
第一个开发人员RD进来了，他在本地创建一个develop分支，并且提交到远程
```
git branch  develop
git push -u origin develop
```
现在线上就有两个分支master 和 develop 现在这两个分支里面都是空的。

# 三、创建develop分支进行功能开发
前2步完成后，任何一个参与该项目的开发人员首先要做的就是从develop分支上切一个新分支进行#45678功能开发。
```
git checkout -b feature/#45678  origin/develop

或者
git fetch origin 远程分支名:本地分支名
git branch --set-upstream-to=origin/远程分支名 本地分支名
```
然后进行开发到一定阶段，想提交一下
```
git status
git add
git commit
```

# 四、功能开发完毕后合并到develop分支
经过第3步，提交了几次后，就可以合并到develop分支完成功能开发，同时删除feature/#45678功能分支。
```
git pull origin develop  //先拉取develop中的代码
git checkout  develop  //切到develop分支
git merge feature/#45678  //合并feature/#45678中的代码到develop中
git push //提交到develop远程分支上
git branch -d feature/#45678  //删除本地的分支
```

# 五、分支发布
某一个开发人员RD想发布，但是其他人员还在进行开发，先不管别人，他先建立一个新的分支做发布准备
```
git checkout -b <本地分支名realse-0.1> <远程分支名develop> //注意这个realse-tagNo分支的功能是对发布的代码进行改善的地方
```
创建这个分支相当于测试环境修改，改好后就需要跟新master和develop,然后删除分支
```
git checkout  master  //切到master分支
git merge release-0.1  //将release分支合到master上
git push  //将合完的代码提交到远程master
git checkout develop  //切到develop分支
git merge release-01  //将release分支上的代码合到develop分支上
git push  //合完的代码推送到远程的develop分支
git branch -d release-01  //删除本地release分支
```

# 六、Tag追踪
```
git tag -a 1.0.0-24 -m 'add tag: 1.0.0-24'
git push --tags
```

# 七、修复线上bug
线上环境发现bug#47892了
```
git checkout -b hotfix/#47892 master  //从master分支上新建分支
```
然后开始改bug,改完后合并到master分支
```
git checkout master  //切回master分支
git merge hotfix/#47892  //将改完bug后的代码合并到master
git push
```
改完bug的代码还要合到develop分支
```
git pull origin master

或者
git checkout develop
git merge hotfic/#47892
git push
git branch -d hotfix/#47892
```

## 八、分支修改理解
一个文件在任意分支被`git add` 后，在某一分支develop中被`git commit`提交，那么这个文件就单独属于分支develop，同时，这个在分支develop被提交的文件无论被怎样的修改和处于任何状态，当我们切换到不是分支develop的任何其他分支中，我们都不会再可以找到这个文件的跟踪记录。

所以在分支feature添加功能或者分支hotfix修改bug会对文件产生修改记录，其他分支（如master、develop）都会出现文件的修改记录。当在修改记录文件所属的分支（feature或hotfix）中`git commit`后，那么就属于该分支的管理范围中。当完成功能研发或bug修复，便可以同步到master和develop

# 九、参考
[Franklin-Qi free-programming-books-zh_CN](https://github.com/Franklin-Qi/free-programming-books-zh_CN)

