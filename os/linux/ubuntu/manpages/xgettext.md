# gtk 中汉化
参照 ~/gtk-simple-test/examples/example-0.c     exampele-tran.sh
```
mkdir -p ./locale/zh_CN/LC_MESSAGES/
```

# c语言 翻译translation translate
[国际化多语言](https://blog.csdn.net/taiyang1987912/article/details/48468539)
[c语言的本地化实现](https://blog.csdn.net/white_pearl/article/details/12621127)


1. 支持国际化的C程序
```  ~/gtk-simple-test/examples/hello.c
#include <stdio.h>
#include <stdlib.h>
#include <locale.h> 
#include <libintl.h>
#define PACKAGE "hello" // hello.mo
#define LOCALEDIR "/usr/share/locale/" 

#define _(s)  gettext(s)
#define N_(s) s

int main()
{
    setlocale(LC_ALL, "");
    bindtextdomain(PACKAGE, LOCALEDIR);
    textdomain(PACKAGE);
    printf(gettext("Hello, World!\n"));
    return 0;
}
```

2. 提取待翻译po并进行本地化
-k参数：指定翻译字符以何种宏定义括起，代码中使用的是_()所以用-k_
```
xgettext -k_ hello.c  -o  hello.po
```

刚创建的pot文件默认为“charset=CHARSET”，编辑po文件时，注
意要将字符调整为可移植的编码格式，如UTF-8
当msgid 有\n时，msgstr也应该有\n，否则报错。
``` Note:
-k --keyword=gettext => gettext("Hello, World!\n");
-k_ => _("Hello, World!\n");
```

3. 生成.mo文件，并拷贝到指定目录
```
msgfmt hello.po -o hello.mo
mysudo cp hello.mo /usr/share/locale/zh_CN/LC_MESSAGES
```
4. 编译hello.c，生成hello程序执行
./hello

可通过export LANG="" 进行测试结果

其中相关的函数和命令除了以上涉及到的还有：
msgmerge msginit ngettext localeconv，具体可参考 man 7 locale



# translate-shell Install

## Git Shell
cd /opt/ && sudo git clone https://github.com/soimort/translate-shell && sudo cd translate-shell/
sudo make && sudo make install


## 参考
[Translate-shell](http://ju.outofmemory.cn/entry/93500)
