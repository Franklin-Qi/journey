# <center><b><font color=blue>Qt + OpenCV 进行图像处理</font></b></center>
ubunty 扫描软件中使用OpenCV处理图片一键美化。

## 1. opencv 配置
``` bash
sudo apt-get install libopencv-dev
```

动态库位置：
/usr/lib/x86_64-linux-gnu/libopencv*

头文件位置：
/usr/include/opencv*

## 2. 下载opencv源码进行问题分析
1、在获取源码包之前，确保在软件源配置文件/etc/apt/sources.list中添加了deb-src项
2、使用如下命令获取xxx源码包的详细信息:
 sudo apt-cache showsrc opencv 这用来查询当前镜像站点中是否有该源码包。
 找到libopencv_photo

 3、 sudo apt-get source libopencv-photo-dev

进而找到 (scn == 4 || scn == 3)断言错误的原因为加载图片错误（imread读取方式不为0，图片路径正确）
可用im.data非空代表加载成功。


## 3. Qt中使用opencv读取资源文件中图片
在使用opencv中，我们一般使用imread读取图片，但是在Qt creator中的资源文件的路径一般为:/xxx/xxx/xxx.png,例如我的就是

:/image/images/people1.jpg,这个路径使用imread是无法读取的，但是可以使用imdecode读取，首先把图片读取到buffer中，然后在用imdecode读取。

```opencv
QFile file(":/image/images/people2.jpg");
    if(!file.open(QFile::ReadOnly))
    {
        qDebug<<"读取失败";
    }else{
                 QByteArray ba = file.readAll();
                Mat img = imdecode(vector<char>(ba.begin(), ba.end()), 1);
                namedWindow("行人");
                imshow("行人图片",img);
                waitKey(5000);
    }
```
参考： https://blog.csdn.net/qq_33375598/article/details/89423760


## QImage 和QPixmap 在label上显示一张图片
QImage 和 QPixmap 对比。
QPixmap是存储在服务器端，往往QPixmap上绘图比较慢，但显示它则比较快。

QImage为I/O，为图片像素访问及修改而设计的，如果你想访问图片的像素或者修改图片的像素，则需要使用QImage，或者借助于QPainter来操作像素。在X11, Mac 以及 Symbian平台上，QImage: 因为它是存储在客户端，往QImage上绘图比较快，但显示它则比较慢。

参考：
[QImage和QPixmap 显示一张图片](https://www.cnblogs.com/wxl845235800/p/10769807.html)


## opencv Mat 和 qt QImage 图像显示转换, 显示一张图片
``` opencv
Mat img;  
QImage qimg;  
img = imread("../lena.jpg");  
cvtColor(img, img, CV_BGR2RGB);  
qimg = QImage((unsigned char*)img.data, // 图像数据  
    img.cols, img.rows, // 图像尺寸
    img.step, //bytesPerLine  ***
    QImage::Format_RGB888); //图像格式
ui->label->setPixmap(QPixmap::fromImage(qimg));
ui->label->resize(ui->label->pixmap()->size());
```

## 基于qt的图像处理技术和算法
使用Qt在像素级别上对图像进行操作，并实现了一些图像效果，这些效果主要有：灰度，模糊，锐化，添加相框，金属质感，改变图像饱和度，亮度还有白平衡。

## 亮度和对比度

参考： 
[opencv 汉化](https://www.w3cschool.cn/opencv/opencv-c6yv2cb1.html)
[qt+opencv](https://blog.csdn.net/keith_bb/article/details/53263641)

## 灰度图
参考：
[在qt界面显示opencv处理的图像](https://blog.csdn.net/qinchang1/article/details/86769773)

## 锐化

参考:
[filter2D 滤波锐化](https://blog.csdn.net/qq_35508344/article/details/82821557)
