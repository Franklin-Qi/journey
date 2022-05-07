# scanimage 详解
**scanimage** 是属于sane-utils包，在sane-backends源码中，是sane的一个命令行前端扫描程序。

它可以查看当前可用的扫描仪，获取和设置扫描参数（选择黑白，彩色，分辨率，纸张大小等），

开始扫描并获取到扫描图片的操作。

也就是说，通过**scanimage 中对sane api的使用**，可以指导我们进行扫描程序的二次开发，这也是最实用的扫描前端程序。

基于sane-backends源码，[二次开发的程序](http://www.sane-project.org/sane-frontends.html):
- gtk的xsane
- Qt的麒麟扫描（kylin-scanner）
- Scala语言的扫描易(simple-scan)等。

## sane-backends 目录简介
frontend/ : 包含了命令行前端程序，如我们重点掌握的 scanimage.c 源码

backend/ : 包含了sane已支持的扫描驱动，如canon_dr.c 代表了已支持的佳能(canon) dr系列扫描仪驱动

## 一、编译并运行scanimage
首先获取sane-backends源码，参考 **./README** 文件，按如下步骤进行编译sane-backends
```shell
$ ./configure
$ make
```
编译完后，可以根据进入到scanimage.c 所在目录的 **.libs/** 目录并运行scannimage程序
```shell
$ cd frontend/.libs/
$ ./scanimage --help # 查看scanimage 帮助，最底下可以获取到可用扫描仪设备列表
```

## 二、scanimage 使用
### 1. 获取所有扫描列表

通过**scanimage --help** 或者 **SANE_DEBUG_DLL=5 scanimage -L (用于调试)** 

获取所有扫描仪列表。对相关常用参数做了[解释](http://www.sane-project.org/man/scanimage.1.html)，如下：

```shell
$ ./scanimage --help

Usage: scanimage [OPTION]...
-d epson) and by a "=" from multi-character options (e.g. --device-name=epson). # 需要指定的扫描仪设备名
-d, --device-name=DEVICE   use a given scanner device (e.g. hp:/dev/scanner)  
    --format=pnm|tiff|png|jpeg  file format of output file # 查看支持的输出扫描图片格式
-i, --icc-profile=PROFILE  include this ICC profile into TIFF file
-L, --list-devices         show available scanner devices # 查看所有可支持的扫描仪列表
-f, --formatted-device-list=FORMAT similar to -L, but the FORMAT of the output
                           can be specified: %d (device name), %v (vendor),
                           %m (model), %t (type), %i (index number), and
                           %n (newline)
-b, --batch[=FORMAT]       working in batch mode, FORMAT is `out%d.pnm' `out%d.tif'
                           `out%d.png' or `out%d.jpg' by default depending on --format
                           This option is incompatible with --output-file.    --batch-start=#        page number to start naming files with
    --batch-count=#        how many pages to scan in batch mode
    --batch-increment=#    increase page number in filename by #
    --batch-double         increment page number by two, same as
                           --batch-increment=2
    --batch-print          print image filenames to stdout
    --batch-prompt         ask for pressing a key before scanning a page
    --accept-md5-only      only accept authorization requests using md5
-p, --progress             print progress messages # 查看扫描进度
-o, --output-file=PATH     save output to the given file instead of stdout. # 扫描输出文件
                           This option is incompatible with --batch.
-n, --dont-scan            only set options, don't actually scan
-T, --test                 test backend thoroughly
-A, --all-options          list all available backend options
-h, --help                 display this help message and exit
-v, --verbose              give even more status messages # 调试时可用
-B, --buffer-size=#        change input buffer size (in kB, default 32)
-V, --version              print version information
Output format is not set, using pnm as a default.

## 以下是默认扫描仪的扫描仪参数，如hpaio:/usb/HP_ColorLaserJet_MFP_M278-M281?serial=VNCRP4036Y 这款扫描仪
Options specific to device `hpaio:/usb/HP_ColorLaserJet_MFP_M278-M281?serial=VNCRP4036Y':
  Scan mode: # 扫描色彩模式，如此款扫描仪支持黑白(Lineart)，灰度(Gray)、彩色(Color)，不同扫描仪设备对应不同的扫描模式，那么mode 获取的名称也会有所不同
    --mode Lineart|Gray|Color [Lineart]
        Selects the scan mode (e.g., lineart, monochrome, or color).
    --resolution 75|100|150|200|300|600|1200dpi [75] # 分辨率参数，如此款扫描仪支持75, 100, 150, 200, 600, 1200 dpi等，不同扫描仪支持也有所不同
        Sets the resolution of the scanned image.
    --source Flatbed|ADF [Flatbed] # 扫描仪来源，如支持平板式（Flatbed）、馈纸式（ADF），此款惠普扫描仪就是支持平板和馈纸双合一，不同扫描仪也有所区别,
        Selects the scan source (such as a document-feeder).
  Advanced:
    --brightness -1000..1000 [0] # 扫描明亮度, 此款扫描仪默认为0， 可变区域为【-1000, 1000】，不同扫描仪有所不同
        Controls the brightness of the acquired image.
    --contrast -1000..1000 [0] # 扫描对比度, 此款扫描仪默认为0，可变区域为【-1000, 1000】，不同扫描仪有所不同
        Controls the contrast of the acquired image.
    --compression None|JPEG [JPEG] # JPEG 压缩
        Selects the scanner compression method for faster scans, possibly at
        the expense of image quality.
    --jpeg-quality 0..100 [inactive]  # jpeg 压缩因子，目前为inactive不可用
        Sets the scanner JPEG compression factor. Larger numbers mean better
        compression, and smaller numbers mean better image quality.
  Geometry: # 用于控制扫描区域,比如A4， A5, A6之类尺寸
    -l 0..215.9mm [0]  # 左上角起始x坐标，默认为0，阈值为[0, 215.9mm]，不同扫描仪有所不同
        Top-left x position of scan area.
    -t 0..296.926mm [0] # 左上角起始y坐标，默认为0，阈值为[0,296.926mm]，不同扫描仪有所不同
        Top-left y position of scan area.
    -x 0..215.9mm [215.9] # 扫描区域宽度，默认为215.9mm，阈值为[0, 215.9mm]，不同扫描仪有所不同
        Width of scan-area.
    -y 0..296.926mm [296.926] # 扫描区域高度，默认为296.926，阈值为[0, 296.926mm]，不同扫描仪有所不同
        Height of scan-area.

Type ``scanimage --help -d DEVICE'' to get list of all options for DEVICE.

List of available devices: # 列出所有的可用扫描仪设备，类似于 ./scanimage -L
    hpaio:/usb/HP_ColorLaserJet_MFP_M278-M281?serial=VNCRP4036Y
```

## 2. 对指定的扫描仪设备进行获取参数
参考1中的描述，通过 **scanimage --help -d DEVICE** 来获取指定扫描仪设备参数
```shell
$ ./scanimage --help -d hpaio:/usb/HP_ColorLaserJet_MFP_M278-M281?serial=VNCRP4036Y

...

## 以下是默认扫描仪的扫描仪参数，如hpaio:/usb/HP_ColorLaserJet_MFP_M278-M281?serial=VNCRP4036Y 这款扫描仪
Options specific to device `hpaio:/usb/HP_ColorLaserJet_MFP_M278-M281?serial=VNCRP4036Y':
  Scan mode: # 扫描色彩模式，如此款扫描仪支持黑白(Lineart)，灰度(Gray)、彩色(Color)，不同扫描仪设备对应不同的扫描模式，那么mode 获取的名称也会有所不同
    --mode Lineart|Gray|Color [Lineart]
        Selects the scan mode (e.g., lineart, monochrome, or color).
    --resolution 75|100|150|200|300|600|1200dpi [75] # 分辨率参数，如此款扫描仪支持75, 100, 150, 200, 600, 1200 dpi等，不同扫描仪支持也有所不同
        Sets the resolution of the scanned image.
    --source Flatbed|ADF [Flatbed] # 扫描仪来源，如支持平板式（Flatbed）、馈纸式（ADF），此款惠普扫描仪就是支持平板和馈纸双合一，不同扫描仪也有所区别,
        Selects the scan source (such as a document-feeder).
  Advanced:
    --brightness -1000..1000 [0] # 扫描明亮度, 此款扫描仪默认为0， 可变区域为【-1000, 1000】，不同扫描仪有所不同
        Controls the brightness of the acquired image.
    --contrast -1000..1000 [0] # 扫描对比度, 此款扫描仪默认为0，可变区域为【-1000, 1000】，不同扫描仪有所不同
        Controls the contrast of the acquired image.
    --compression None|JPEG [JPEG] # JPEG 压缩
        Selects the scanner compression method for faster scans, possibly at
        the expense of image quality.
    --jpeg-quality 0..100 [inactive]  # jpeg 压缩因子，目前为inactive不可用
        Sets the scanner JPEG compression factor. Larger numbers mean better
        compression, and smaller numbers mean better image quality.
  Geometry: # 用于控制扫描区域,比如A4， A5, A6之类尺寸
    -l 0..215.9mm [0]  # 左上角起始x坐标，默认为0，阈值为[0, 215.9mm]，不同扫描仪有所不同
        Top-left x position of scan area.
    -t 0..296.926mm [0] # 左上角起始y坐标，默认为0，阈值为[0,296.926mm]，不同扫描仪有所不同
        Top-left y position of scan area.
    -x 0..215.9mm [215.9] # 扫描区域宽度，默认为215.9mm，阈值为[0, 215.9mm]，不同扫描仪有所不同
        Width of scan-area.
    -y 0..296.926mm [296.926] # 扫描区域高度，默认为296.926，阈值为[0, 296.926mm]，不同扫描仪有所不同
        Height of scan-area.

Type ``scanimage --help -d DEVICE'' to get list of all options for DEVICE.

List of available devices: # 列出所有的可用扫描仪设备，类似于 ./scanimage -L
    hpaio:/usb/HP_ColorLaserJet_MFP_M278-M281?serial=VNCRP4036Y
```

### 3. 使用scanimage 进行扫描
使用指定惠普扫描仪，扫描分辨率75dpi、黑白、平板方式、A4（210mm * 297mm）、pnm格式的图片，并保存为test.pnm
```shell
$ ./scanimage  -d hpaio:/usb/HP_ColorLaserJet_MFP_M278-M281?serial=VNCRP4036Y --format=pnm --mode=Lineart --resolution=75 --source=Flatbed -l 0 -t 0 -x 210 -y 297 -o test.pnm 
```

## 三、开发中指定扫描仪出现的参数错误排查
对指定扫描仪 escl:http://172.30.40.141:8080' 进行设置扫描参数后扫描失败，那么可以获取相关参数
```shell
$ ./scanimage --help -d 'escl:http://172.30.40.141:8080'
...
Geometry:
    -l 48.768..215.9mm [0]
        Top-left x position of scan area.
    -t 48.768..297.011mm [0]
        Top-left y position of scan area.
    -x 48.768..215.9mm [0]
        Width of scan-area.
    -y 48.768..297.011mm [0]
        Height of scan-area.
```
其中，中括号中的值为默认值，也就是说在8080上端口的这台扫描仪默认top-left x为0，
和范围区间[48.768..215.9mm]不符合，所以会出现参数错误。

使用扫描命令，可以避免出现参数错误，其他参数错误排查方法类似。
```shell
$ scanimage -d 'escl:http://172.30.40.141:8080' -l 50 -t 50 -x 215 -y 297 >a.pnm
```

## 四、参考资料

[1. 官方英文版标准Sane API手册，目前不可访问](https://sane-project.gitlab.io/standard/)

[2. 中文翻译的Sane API 手册](https://blog.csdn.net/weixin_39743893/article/details/83350568)

[3. GitHub上对Sane Api的简易使用](https://github.com/Franklin-Qi/kylin-sane-test)
