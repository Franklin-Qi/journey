### 目标
depends:
build-essential debmake debhelper dh-make devscripts xutils-dev

在我接触`debian`打包的时候，遇到过很多问题，面对众多的`debian`打包命令有些束手无策，看过[Debian官方维护者手册](https://www.debian.org/doc/manuals/maint-guide/)，但是对于急于成功打包的我来说，资料太多了（当然，官方资料永远应该是最主要的学习资料，其它渠道的都应该只是起辅助作用），所以，我先整理个快速打包流程分享一下。在实验学习中如发现任何问题或不当之处，请一定指出来，不要因为我的错误影响到别人，在此先谢谢大家。

> 示例程序放在 [https://github.com/dingjingmaster/debian-helloworld](https://github.com/dingjingmaster/debian-helloworld)

### `debian`目录主要文件介绍

> 主要的四个文件 `control`、`rules`、`changelog`、`install`文件、`copyright`

1. control

   主要记录`debian`包的依赖（此项目打包成各个二进制包的依赖）、和其它包相关信息

2. rules

   实际是一个 makefile 文件由许多预定义的target组成

3. `changelog`

   每个版本修改信息

4. install 文件

5. copyright

### `debian` 打包准备

1. 安装依赖

   - build-essential
   - `debmake`
   - 代码依赖的其它环境

2. 生成 `debian` 文件夹及配置文件

   1. 生成`debian`目录

      > 注意：如果源码不是C/C++类型的，需要使用 `debmake -b` 选项

      ```debmake -e dingjing@live.cn -u 0.0.0 -f demon1 -m -n -x1```

      - `-e` 邮箱

      - `-p` 软件名

      - `-f` 作者全名

      - `-m` 强制软件包非多架构

      - `-n` 创建源码包（无需`xxx.orig.tar.gz`）

      - `-x1` 默认就是1，deb构建中由很多狗子方法，`x1`只是包含一些项目信息和构建信息的版本；`x0`只有构建信息，`x2`、`x3`、`x4`会生成很多文件，一般`x1`即可
   
   2. 修改 `control` 文件
   
   3. 修改 `rules` 文件
   
   4. 创建 `install` 文件（非必须，后边说明）
   
   5. 修改 `changelog` 文件
   
      ```dch -i```
   
   6. 生成deb包

### `debian`打包例子（`demo1`生成一个二进制包）

1. 生成 `debian` 目录

   ```debmake -e yushuoqi@kylinos.cn -u 1.0.0 -f kylin-scanner -m -n```

2. 修改 `debian/control` 文件

   1. 修改Section: 该源码包要进入发行版中的分类（后边会详细说明）

      值修改为 `debug`（这里是我随便写的，详细参看[https://www.debian.org/doc/debian-policy/ch-archive.html#s-subsections](https://www.debian.org/doc/debian-policy/ch-archive.html#s-subsections)）

   2. 修改 Homepage

      值修改为`https://github.com/ukui/`

   3. 执行`objdump -p`，查看项目的依赖包，并写入`Build-Depends`里

   4. 把 `Build-Depends` 选项下的 `qt4-qmake` 改为 `qt5-qmake`

3. 修改 `debian/rules`

   这个暂时不修改

4. 修改 `debian/changelog`

   1. 执行 `dch -i`(此包版本号`+1`且添加新的`changelog`信息，具体参看`dch --help`)
   2. 编辑`changelog` 后一定把 `UNRELEAED` 修改掉(修改与否不影响打包)，比如暂时改为`experimental`

5. 生成 `deb` 包

   	1. 在项目根目录下（也就是`debian`同级目录下）执行 `debuild -D`

> 至此，一个 `deb` 包就生成了，可以执行 `sudo apt install ./xxxx.deb`安装刚刚生成的包，安装成功后，你可以在 `/usr/bin` 下找到 `demo1.run` 可执行文件，执行它输出 `Hello World`。执行`dpkg -L demo1` 可以看到这个包里安装的一些内容。

另外：可以在执行`debuild -D` 命令之后，把控制台输出信息重定向到文件，仔细分析打包过程。打包执行过程如下：

> 执行 `debuild -D` 等价于执行 `dpkg-buildpackage -D -us -uc -ui`

1. ` dpkg-source --before-build .`  准备编译环境
2. `dpkg-source -b .` 产生源码包，在项目上层目录生成 `xxxx.tar.xz` 和 `xxxx.dsc`，好奇的话可以解压`xxx.tar.xz`看看，就是`源码 + debian目录`里的东西
3. `fakeroot dh build` 编译源码
4. `fakeroot dh binary` 产生二进制包，在项目上层目录生成了deb包

> 后续步骤大家可以根据输出日志去看
>
> `dpkg-xxxx` 命令说明都可以在 [https://manpages.debian.org/jessie/dpkg-dev](https://manpages.debian.org/jessie/dpkg-dev) 里找到

### `debian`打包例子（`demo2`生成两个二进制包）

1. 生成 `debian` 目录

   ```debmake -e dingjing@live.cn -u 0.0.0 -f demo2 -m -n```

2. 修改 `debian/control` 文件

   1. 修改Section: 该源码包要进入发行版中的分类（后边会详细说明）

      值修改为 `debug`（这里是我随便写的）

   2. 修改 Homepage

      值修改为`https://github.com/ukui/`

   3. 执行`objdump -p`，查看项目的依赖包，并写入`Build-Depends`里

   4. 把 `Build-Depends` 选项下的 `qt4-qmake` 改为 `qt5-qmake`

   5. 添加第二个二进制包的信息

      将包名命名为 `demo2-doc`

3. 添加 `xxx.install`文件

   分别添加`demo2.install` 和 `demo2-doc.install`编辑两个文件，写入要安装的文件

   > `xxx.install` 文件其实有两个作用：① 项目中生成的文件分包安装；② 当项目中安装文件不写在makefile里的时候，此文件可以把项目中生成要安装的文件放到指定位置，打包的时候安装到系统

4. 修改 `debian/rules`

   这个暂时不修改

5. 修改 `debian/changelog`

   1. 执行 `dch -i`
   2. 编辑`changelog` 后一定把 `UNRELEAED` 修改掉，比如暂时改为`experimental`

6. 生成 `deb` 包

    	1. 在项目根目录下（也就是`debian`同级目录下）执行 `debuild -D`

### `debian`打包例子（`demo3`打包动态库）

> 与前两个例子大致相同

### `debian`软件包制作补充内容

1. `debian`社区中常见的角色定义

   - `Upstream author` ：上游作者，是程序的原始作者
   - `Upstream maintainer`：目前在上游维护代码的人
   - `Maintainer`：制作并维护该 `Debian`软件包的人
   - `Sponsor`：帮助维护者上传软件包到 `Debian` 官方仓库的人
   - `Mentor`： 帮助新手维护者熟悉和深入打包的人
   - `Debian Developer` (`DD`)：`Debian`社区的官方成员，DD拥有向`Debian`官方仓库上传的全部权限
   - `Debian Maintainer`(`DM`)：拥有对`Debian`官方仓库部分上传权限的人

   > 这里咱是从 `Maintainer` 干起😂

2. 需要的开发工具（这个是开发必备，也是打包需要的，不是所有工具都必须有）

   - **最重要的包**就是 `build-essential`，安装它的时候，就会拉取其它基本构建环境所需的工具链。
   - `debhelper`
   - `dh-make` 用于创建软件包骨架所需，它使用 `debhelper` 中的一些工具来创建软件包（已被新的`debmake`所替代）
   - `devscripts` 
   - `fakeroot` 以普通用户模拟`root`用户环境
   - `file`检查文件类型
   - `git`
   - `gnupg` 使用数字签名签署你打包的软件包，当分发给别人的时候，这一点很重要，要把软件包加入`Debian`发行版中也是必须的步骤
   - `lintian` 是`Debian`软件包检查工具
   - `patch`打补丁用的
   - `patchutils` 帮助处理补丁的一些工具
   - `pbuilder` 提供了创建和维护 `chroot` 环境的工具，在它的 `chroot` 环境中编译`Debian`软件包可以检查依赖是否核时
   - `quilt` 帮助管理一系列补丁
   - `xutils-dev`一些常用于`x11`的程序，使用其宏功能生成`Makefile`文件
   - `automake`、`autoconf`、`autotools-dev` `automake`系列项目需要的编译工具

3. 软件包名称和版本

   - `Debian`软件包名：只能含有 小写字母 (`a-z`), 数字 (`0-9`), 加号 (`+`) 和 减号 (`-`) ， 以及 点号 (`.`)。 软件包名最短长度两个字符；它必须以字母开头；它不能与仓库软件包名发生冲突。还有，把软件包名的长度控制在 30 字符以内是明智之举。

   - `Debian`版本号： 只包含字母和数字 (`0-9A-Za-z`), 以及加号 (`+`), 波浪号 (`~`), 还有 点号(`.`)。它必须以数字开头 (`0-9`)。如果可能的话，最好把它的长度控制在8字符以内。

   - 版本号可以使用 `dpkg --compare-versions ver1 op ver2` 来比较大小，比较规则如下：

     - 字符串要从头到尾进行比较。

     - 字母比数字大。

     - 数字作为整数进行比较。

     - 字母按照 ASCII 编码顺序进行比较。

     - 对于点号 (`.`)，加号 (`+`)，以及波浪号 (`~`) 则有对应的特殊规则，具体如下：

       `0.0` < `0.5` < `0.10` < `0.99` < `1` < `1.0~rc1` < `1.0` < `1.0+b1` < `1.0+nmu1` < `1.1` < `2.0`

> `debian` 中必须存在的几个文件：`control`、`changelog`、 `copyright`、 `rules`

1. `debian`目录中必须内容 —— `control`文件

   ```
    1 Source: gentoo
    2 Section: unknown
    3 Priority: optional
    4 Maintainer: Josip Rodin <joy-mg@debian.org>
    5 Build-Depends: debhelper (>=10)
    6 Standards-Version: 4.0.0
    7 Homepage: <insert the upstream URL, if relevant>
    8
    9 Package: gentoo
   10 Architecture: any
   11 Depends: ${shlibs:Depends}, ${misc:Depends}
   12 Description: <insert up to 60 chars description>
   13  <insert long description, indented with spaces>
   ```

   - 1 ~ 7 行是**源代码包**的控制信息；9 ~ 13 行是二进制包的控制信息（可以打包多个二进制包）

   - 主要字段介绍：

     - `Source` 源代码包的名称

     - `Section` 该源码包要进入发行版中的分类，详细参看[https://www.debian.org/doc/debian-policy/ch-archive.html#sections](https://www.debian.org/doc/debian-policy/ch-archive.html#sections)

     - `Priority` 描述了用户安装此软件包的优先级，详细参看 [https://www.debian.org/doc/debian-policy/ch-archive.html#priorities](https://www.debian.org/doc/debian-policy/ch-archive.html#priorities)

     - `Maintainer` 维护者的姓名和电子邮件

     - `Build-Depends` 列出了编译此软件包需要的软件包，另外：`Build-Depends-Indep` 作为附加依赖包列表（留待查证：两个变量干一样的事情？？？）

       这里如果不清楚依赖哪些包，可以使用 `objdump -p 生成的命令` 来显示出依赖的包

     - `Standards-Version` 此软件包所依据的 `Debian Policy Manual` 标准版本号

     - `Homepage` 项目首页 URL

     - `Package` 二进制软件包的名称，通常情况下与源码包相同

     - `Architecture` 可以编译二进制包的体系结构

     - `Description` 二进制包描述

     - `Depends` 此软件包仅当它依赖的软件包均已安装后才可以安装。此处请写明你的程序所必须的软件包，如果没有要求的软件包该软件便不能正常运行（或严重抛锚）的话。

       > 每个软件包都可以和其他软件包有各种不同的关系。除 `Depends` 外，还有 `Recommends`、`Suggests`、`Pre-Depends`、`Breaks`、`Conflicts`、`Provides` 和 `Replaces`。

     - `Recommends` 这项中的软件包不是严格意义上必须安装才可以保证程序运行。当用户安装软件包时，所有前端工具都会询问是否要安装这些推荐的软件包。`aptitude` 和 `apt-get` 会在安装你的软件包的时候自动安装推荐的软件包(用户可以禁用这个默认行为)。`dpkg` 则会忽略此项。

     - `Suggests`  此项中的软件包可以和本程序更好地协同工作，但不是必须的。当用户安装程序时，所有的前端程序可能不会询问是否安装建议的软件包。`aptitude` 可以被配置为安装软件时自动安装建议的软件包，但这不是默认。`dpkg` 和 `apt-get` 将忽略此项。

     - `Pre-Depends` 此项中的依赖强于 `Depends` 项。软件包仅在预依赖的软件包已经安装并且 正确配置 后才可以正常安装。在使用此项时应 *非常慎重*，仅当在 [debian-devel@lists.debian.org](http://lists.debian.org/debian-devel/) 邮件列表讨论后才能使用。记住：根本就不要用这项。 :-)

     - `Conflicts` 仅当所有冲突的软件包都已经删除后此软件包才可以安装。当程序在某些特定软件包存在的情况下根本无法运行或存在严重问题时使用此项。

     - `Break` 此软件包安装后列出的软件包将会受到损坏。通常 `Breaks` 要附带一个“版本号小于多少”的说明。这样，软件包管理工具将会选择升级被损坏的特定版本的软件包作为解决方案。

     - `Provide` 某些类型的软件包会定义有多个备用的虚拟名称。你可以在 [virtual-package-names-list.txt.gz](http://www.debian.org/doc/packaging-manuals/virtual-package-names-list.txt)文件中找到完整的列表。如果你的程序提供了某个已存在的虚拟软件包的功能则使用此项。

     - `Replaces` 当你的程序要替换其他软件包的某些文件，或是完全地替换另一个软件包(与 `Conflicts` 一起使用)。列出的软件包中的某些文件会被你软件包中的文件所覆盖。

     > 所有的这些项都使用统一的语法。它们是一个软件包列表，软件包名称间使用半角逗号分隔。也可以写出有多个备选软件包名称，这些软件包使用 `|` 符号(管道符)分隔。
     >
     > 这些项内还可以限定与某些软件包的某个版本区间之间的关系。版本号限定在括号内，这紧随软件包名称之后，并在以下逻辑符号后写清具体版本：`<<`、`<=`、`=`、`>=` 和 `>>`，分别代表严格小于、小于或等于、严格等于、大于或等于以及严格大于。例如：
     >
     > ```
     > Depends: foo (>= 1.2), libbar1 (= 1.3.4)
     > Conflicts: baz
     > Recommends: libbaz4 (>> 4.0.7)
     > Suggests: quux
     > Replaces: quux (<< 5), quux-foo (<= 7.6)
     > ```

     > 最后一个需要了解的特性是 `${shlibs:Depends}`, `${perl:Depends}`, `${misc:Depends}`, 之类。
     >
     > - `dh_shlibdeps` 会为二进制包计算共享库依赖关系。它会为每个二进制包生成一份 ELF 可执行文件和共享库列表。 这个列表用于替换 `${shlibs:Depends}`。
     > - `dh_perl`会计算 Perl 依赖。它会为每个二进制包生成一个叫作 `perl` 或 `perlapi` 的依赖列表。这个列表用于替换 `${perl:Depends}`。
     > - 一些 `debhelper` 命令可能会使生成的软件包需要依赖于某些其他的软件包。所有这些命令将会为每一个二进制包生成一个列表。这些列表将用于替换 `${misc:Depends}` 。

2. `debian`目录中必须内容 —— `copyright`文件

   这个，有需要自己去看啊

3. `debian`目录中必须内容 —— `changelog`文件

   ```
   1  gentoo (0.9.12-1) unstable; urgency=medium
   2
   3   * Initial release (Closes: #nnnn)  <nnnn is the bug number of your ITP>
   4
   5  -- Josip Rodin <joy-mg@debian.org>  Mon, 22 Mar 2010 00:37:31 +0100
   6
   ```

   - 第 1 行是软件包名、版本号、发行版和紧急程度。软件包名必须与实际的源代码包名相同，发行版应该是 `unstable`。除非有特殊原因，紧急程度默认设置为 medium（中等）。

     为了阻止软件包在打包完成之前被意外上传，将发行版值改成一个不可用的 `UNRELEASED` 将是一个很好的选择。

   - 第 3-5 行是一个很长的条目，记录了你在这个 `Debian` 修订版本中做出的修改

4. `debian`目录中必须内容 —— `rules`文件

   ```
    1 #!/usr/bin/make -f
    2 # See debhelper(7) (uncomment to enable)
    3 # output every command that modifies files on the build system.
    4 #DH_VERBOSE = 1         # 去掉注释，输出将要使用的 dh_*命令
    5 #export DH_OPTIONS=-v   # 会输出它正在调用的命令与上条配置等价
    6 # see FEATURE AREAS in dpkg-buildflags(1)
    7 #export DEB_BUILD_MAINT_OPTIONS = hardening=+all
    8
    9 # see ENVIRONMENT in dpkg-buildflags(1)
   10 # package maintainers to append CFLAGS
   11 #export DEB_CFLAGS_MAINT_APPEND  = -Wall -pedantic
   12 # package maintainers to append LDFLAGS
   13 #export DEB_LDFLAGS_MAINT_APPEND = -Wl,--as-needed
   14 
   15
   16 %:
   17         dh $@ 
   ```

   `rules` 本质就是一个 `Makefile`，此文件可执行，以make命令解析。

   > 当想要执行一个 rule 的时候，就将 target（目标）名称作为命令行参数来调用。比如说， `debian/rules build` 以及 `fakeroot make -f debian/rules binary` 会分别执行 `build` 和 `binary` 两个 target。

   - `clean` target：清理所有编译的、生成的或编译树中无用的文件。(必须)
   - `build` target：在编译树中将代码编译为程序并生成格式化的文档。(必须)
   - `build-arch` target：在编译树中将代码编译为依赖于体系结构的程序。(必须)
   - `build-indep` target：在编译树中将代码编译为独立于平台的格式化文档。(必须)
   - `install` target：把文件安装到 `debian` 目录内为各个二进制包构建的文件树。如果有定义，那么 `binary` target 则会依赖于此 target。(可选)
   - `binary` target：创建所有二进制包(是 `binary-arch` 和 `binary-indep` 的合并)。(必须)
   - `binary-arch` target：在父目录中创建平台依赖(`Architecture: any`)的二进制包。(必须)
   - `binary-indep` target：在父目录中创建平台独立(`Architecture: all`)的二进制包。(必须)
   - `get-orig-source` target：从上游站点获得最新的原始源代码包。(可选)

   另外了解

   - `debian/rules clean` 运行了 `dh clean`，接下来实际执行的命令为：

     ```
     dh_testdir
     dh_auto_clean
     dh_clean
     ```

   - `debian/rules build` 运行了 `dh build`，其实际执行的命令为：

     ```
     dh_testdir
     dh_auto_configure
     dh_auto_build
     dh_auto_test
     ```

   - `fakeroot debian/rules binary` 执行了 `fakeroot dh binary`，其实际执行的命令为：

     ```
     dh_testroot
     dh_prep
     dh_installdirs
     dh_auto_install
     dh_install
     dh_installdocs
     dh_installchangelogs
     dh_installexamples
     dh_installman
     dh_installcatalogs
     dh_installcron
     dh_installdebconf
     dh_installemacsen
     dh_installifupdown
     dh_installinfo
     dh_installinit
     dh_installmenu
     dh_installmime
     dh_installmodules
     dh_installlogcheck
     dh_installlogrotate
     dh_installpam
     dh_installppp
     dh_installudev
     dh_installwm
     dh_installxfonts
     dh_bugfiles
     dh_lintian
     dh_gconf
     dh_icons
     dh_perl
     dh_usrlocal
     dh_link
     dh_compress
     dh_fixperms
     dh_strip
     dh_makeshlibs
     dh_shlibdeps
     dh_installdeb
     dh_gencontrol
     dh_md5sums
     dh_builddeb
     ```

     > 如果你想覆盖某个`target`，比如覆盖 `dh_auto_configure`，那么可以编辑`rules`如下：
     >
     > ```
     > override_dh_auto_configure:
     >         # 你想执行的操作
     > ```

### 文档

- [debian-policy](https://www.debian.org/doc/debian-policy/index.html) 包含了对`Debian`软件仓库、操作系统设计问题、文件系统层级标准(`FHS`，讲述每个文件和目录应该放在哪里)等的描述。

- [developers-reference](http://www.debian.org/doc/devel-manuals#devref) 描述了打包所需的包含技术细节在内的全部详细信息，如仓库结构、如何重命名/丢弃/接手软件包、如何进行 `NMU`(非维护者上传)、如何管理 Bug 以及打包最佳实践、何时向何处上传等。
- [debian维护者手册](https://www.debian.org/doc/manuals/maint-guide/) 打包相关

