# convert 图像编辑

## 一、查找convert命令所属包imagemagick-6.q16
1. dpkg -S /usr/bin/convert 失败
2. ll /usr/bin/convert -> /etc/alternatives/convert*
3. ll /etc/alternatives/convert -> /usr/bin/convert-im6.q16*
4. dpkg -S /usr/bin/convert-im6.q16 -> imagemagick-6.q16: /usr/bin/convert-im6.q16

## 二、通过convert命令将多张图片合成一张tif格式或pdf格式图片
```bash
$ convert *.pnm a.tif
$ convert *.tif b.tif
$ convert *.pnm a.pdf
```
