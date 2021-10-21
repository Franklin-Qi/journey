# github 基本操作

## git 查看单独一个文件的修改历史
1. 看到fileName相关的commit记录
> git log filename

2. 显示每次提交的diff
> git log -p filenam

3. 只看某次提交中的某个文件变化，可以直接加上fileName
> git show c5e69804bbd9725b5dece57f8cbece4a96b9f80b filename


## 对象文件损坏
bug: error: object file .git/objects/xxx is empty

solutions:
1. git init重头开始，最暴力最直接解决方案，但是这样之前的commit就没有了，短期的还好，长期的项目提交全不见了，貌似不太好
2. git clone/fetch克隆或拉取其他人的项目，这样可以回溯到那个人项目的最新提交记录，可以挽救一些，万一你的项目比他新好多呢
3. 可以恢复本机项目原本的git log记录，修一下坏的节点就好

对于solutions_3 步骤如下：
```
1. 运行 git fsck --full
2. 选中空文件，删除 rm filepath
对于1，2可以用以下命令：
$ find . -type f -empty -delete -print

3. 运行 git fsck --full，还是有错，head指向元素不存在，是之前一个空文件
4. 手动获得最后两条reflog ,运行tail -n 2 .git/logs/refs/heads/ia
xxx1 xxx2 shuoqi.yu<yushuoqi@kylinos.cn> ...

5. head当前是指向最新的那一条记录，所以我们看一下parent commit 即倒数第二条提交 git show xxx2,可以看到内容，是好着的

6. 我们就重新设置head,使其指向倒数第二条 git update-ref HEAD xxx2

7. .最后提交新代码就OK了。这样保留下来我们的git log记录，只是修一下坏的节点而已。

```

##  两个仓库同步
1. diff和patch对两个仓库进行同步,

kylin-scanner-1是新fork的仓库，kylin-scanner是有修改的仓库，比kylin-scanner-1更新
```
diff -Nura kylin-scanner-1/src/ kylin-scanner/src/ > src.patch
cd kylin-scanner-1/
patch -p1 < ../src.patch
```

2. git diff 和 git apply 对两个仓库进行同步
```
cd kylin-scanner/
git diff commitID1 commitID2 > src.patch
cd kylin-scanner-1/
git apply ../src.patch
git status
```

## 通过ssh进行下载仓库
有时http网速不行导致下载远程仓库失败，可以通过ssh进行git clone
```
# 1. 配置ssh
$ ssh-keygen -t rsa -C "yushuoqi@kylinos.cn"
$ cat ~/.ssh/id_rsa.pub
将上面的ssh秘钥在网页上新增SSH

# 2. 测试ssh
$ ssh -T git@gitee.com
返回 Hi XXX! You've successfully authenticated, but Gitee.com does not provide shell access. 内容，则证明添加成功。

# 3. git clone
在网页上的仓库clone处，将HTTPS换成SSH得到git clone地址
$ git clone xxx.git
```

## 增加语言设置为c++
仓库下新建.gitattributes，通过src linguist-language=dst 进行设置语言。

## markdown增加目录
在GitHub中[TOC]不管用，需要专门的软件才行。
```
# install
wget https://raw.githubusercontent.com/ekalinin/github-markdown-toc/master/gh-md-toc
sudo mv gh-md-toc  /usr/bin/gh-md-toc
sudo chmod a+x /usr/bin/gh-md-toc

# Use
gh-md-toc xxx.md
从终端拷贝内容到xxx.md 的第一行

优化可以在.bashrc增加一个md-toc 函数，命令行如下：
md-toc xxx.md
```

## git恢复某个已修改的文件
```
checkout => 撤销未提交的修改,也就是恢复到GitHub 未修改的状态

恢复某个已修改的文件（撤销未提交的修改）：
$ Git checkout file-name

revert => 已经提交过的修改,通过这个可以重新提交
还原已提交的修改（已经提交过的修改，可以反悔～）

还原最近一次提交的修改：
$ git revert HEAD

还原指定版本的修改：
$ git revert commit-id
```

## Account改名后，本地仓库授权失败
```
# remove origin repo
git remote -v
git remote remove origin

# add current repo
git remove add origin https://xxx.git
git fetch origin
git merge origin/master

# update Auth message
git config --list
git config --global user.name xxx
git config --global user.email xxx

# git push
git push --set-upstream origin master
```

## 加入Github Developer Program
[Github API Guide](https://github.com/developer/thanks?account=yusq77)
好处：
> 1. 提前知道Github的新功能试用资格
> 2. Github 会员徽章
> 3. 熟悉GitHub流程

## 整合不同的仓库到统一的仓库CodeFactory中
> git clone xxx.git
> cd xxx/; rm -rf .git/
> git add . ; git commit -m "xxx" ; git push

## 取消git init操作
> rm -rf .git

## Git命令行首次提交项目
1. 在网页上进行新建一个远程项目，并拷贝地址
2. 进入本地项目根目录，git init 进行初始化仓库
3. git add . //把目录下的文件全部提交到本地缓冲区
4. git commit -m ”first commit" //提交到本地并添加说明
5. git remote add origin https://git.oschina.net/xxx/xxx.git（第一步中copy下来的地址） //提交项目

6. git pull origin
   git pull --rebase origin master //本地与远程代码合并

7. git push --set-upstream origin master  //最后提交到远程仓库


1. 初步配置:
```bash
git config --global user.name shuoqi.yu
git config --global user.email shuoqi.yu@cs2c.com.cn


git config --global user.name shuoqi.yu
git config --global user.email yushuoqi@kylinos.cn
```

## fork他人项目后，再同步更新别人的提交。
```
# 查看远程信息
git remote -v

# 添加远程仓库xxx(upstream为仓库别名)
git remote add upstream https://github.com/mahailiang/kylin-scanner.git

# 删除远程仓库，可不使用
git remote remove upstream

# 查看远程信息
git remote -v


第一种情况，个人仓库和主仓库没同步，个人仓库没更改，主仓库更改，直接同步主仓库:

git fetch upstream # 从源仓库更新同步代码，必须

git merge upstream/master # 合并到本地代码，必须
{
git合并的时候，冲突问题Merging is not possible because you have unmerged files

你手动修改git提示有错误的文件，修改之后，添加有冲突的文件： git add [被修改的冲突文件]， 最后，按照普通提交那样，提交有冲突的问题： git commit [修改后的冲突文件] -m “注释内容”

*简单的来说就是：
用git diff或者git status 查看哪些文件冲突，有冲突的会提示：
++<<<<<<< HEAD

# 这部分是自己仓库的

===========

# 这部分是上游仓库的

++<<<<<<< upstream

修改你的冲突的文件，修改完之后，保存。
用git add xxx，把你修改的文件全部都添加进去。
最后，用git commit -a -m ” 备注信息 ” 提交，完成。

}

git commit -m "upstream sync" # 提交远程仓库的数据
git pull origin master # 更新并合并自己远程仓库的代码
git push # 向自己的远程仓库同步刚才源仓库后的代码




第二种情况，个人仓库和主仓库已同步，提交个人代码到个人仓库中，同时做一些验证:

# simply github operations, git add/commit/status/log ...
git fetch upstream # 从源仓库更新同步代码，必须
git merge upstream/master # 合并到本地代码，必须
git pull origin master # 更新并合并自己远程仓库的代码
git push # 向自己的远程仓库同步刚才源仓库后的代码

```
https://blog.csdn.net/qq1332479771/article/details/56087333

## 下载单个/部分文件
1. 下载单个文件，可以Raw右键链接另存为或者复制链接
2. 下载部分文件夹，Chrome扩展插件 **GitZip for github**，*failed*.
3. 下载部分文件夹，下载TortoiseSVN
```
1. master分支, 将 /tree/master/ 换成 /trunk/;
2. 不是master分支(如dev分支), /trunk/ => /branches/dev/
```

## git clone速度太慢
原因：git clone特别慢是因为github.global.ssl.fastly.net域名被限制了。只要找到这个域名对应的ip地址，然后在hosts文件中加上ip–>域名的映射，刷新DNS缓存便可。

1. 查找域名对应的ip地址，并修改hosts文件
```
$ nslookup github.global.ssl.fastly.Net

Non-authoritative answer:
Name:	github.global.ssl.fastly.Net
Address: 31.13.72.1

$ nslookup github.com

Non-authoritative answer:
Name:	github.com
Address: 52.74.223.119

在hosts文件末尾添加两行
sudo vim /etc/hosts
github.com 52.74.223.119
github.global.ssl.fastly.Net 31.13.72.1
```

2. 刷新DNS缓存
```
sudo /etc/init.d/networking restart
```


## win10 解决Github网页上图片显示失败的问题
打开hosts文件，末尾增加以下行, 2020/6/23整理：
```
# GitHub Start
140.82.113.3      github.com
140.82.114.20     gist.github.com

151.101.184.133    assets-cdn.github.com
151.101.184.133    raw.githubusercontent.com
151.101.184.133    gist.githubusercontent.com
151.101.184.133    cloud.githubusercontent.com
151.101.184.133    camo.githubusercontent.com
151.101.184.133    avatars0.githubusercontent.com
199.232.68.133     avatars0.githubusercontent.com
199.232.28.133     avatars1.githubusercontent.com
151.101.184.133    avatars1.githubusercontent.com
151.101.184.133    avatars2.githubusercontent.com
199.232.28.133     avatars2.githubusercontent.com
151.101.184.133    avatars3.githubusercontent.com
199.232.68.133     avatars3.githubusercontent.com
151.101.184.133    avatars4.githubusercontent.com
199.232.68.133     avatars4.githubusercontent.com
151.101.184.133    avatars5.githubusercontent.com
199.232.68.133     avatars5.githubusercontent.com
151.101.184.133    avatars6.githubusercontent.com
199.232.68.133     avatars6.githubusercontent.com
151.101.184.133    avatars7.githubusercontent.com
199.232.68.133     avatars7.githubusercontent.com
151.101.184.133    avatars8.githubusercontent.com
199.232.68.133     avatars8.githubusercontent.com

# GitHub End
```

[参考](https://blog.csdn.net/qq_38232598/article/details/91346392)


