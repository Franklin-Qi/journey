# dch详解
> dch 可用于deb包上传时的信息提示自定义添加，大大简化changelog步骤和规范化流程。

**本文目录**
=================

* [dch详解](#dch详解)
   * [/usr/bin/dch 脚本变更](#usrbindch-脚本变更)
   * [环境变量增加](#环境变量增加)
   * [使用dch -i](#使用dch--i)

## /usr/bin/dch 脚本变更
为了适应产品的规范，有必要完善dch的规范。
其中，decode_utf8可用于解码中文字符，否则会出现乱码。

在`line += 3;`前一行增加需要增加的中文信息。
```perl
my $TEXTNONE  = decode_utf8("无");
my $TEXTBUGNUMBER  = decode_utf8("BUG 号");
my $TEXTTASKNUMBER  = decode_utf8("任务号");
my $TEXTDEMANDNUMBER  = decode_utf8("需求号");
my $TEXTOTHERDESCRIPTIONS  = decode_utf8("其他改动说明");

print O "  [ $TEXTBUGNUMBER ] \n";
print O "  * Closes: #\n";
print O "    -  \n";
print O "  \n";
print O "  [ $TEXTTASKNUMBER ] \n";
print O "  * $TEXTNONE \n";
print O "  \n";
print O "  [ $TEXTDEMANDNUMBER ] \n";
print O "  * $TEXTNONE \n";
print O "  \n";
print O "  [ $TEXTOTHERDESCRIPTIONS ] \n";
print O "  * $TEXTNONE \n";
print O "  \n";
```

## 环境变量增加
增加`DEBFULLNAME`为changelog提交的用户名
增加`DEBEMAIL`为changelog提交的邮箱

## 使用dch -i
```bash
$ dch -i
```
