# QLabel
QLabel可以显示图片。

## setStyleSheet适应主题颜色
```c++
    ui->titleLabel->setStyleSheet("QLabel{font-size: 18px; color: palette(windowText);}");
```

## QLabel 进行截图的方向思考
加载带有图片的截图，可以使用QWidget进行绘制，之后根据位置绘制出所有的带图片的矩形和线条。

## QPixmap图片反白
`ukui-control-center(plugins/messages-task/about/about.cpp)`通知关于界面的关于图标反白
```c++
ui->logoLabel->setPixmap(QPixmap("://img/plugins/about/galaxyUnicorn.png"));
ui->logoLabel->setPixmap(QPixmap("://img/plugins/about/logoukui.svg"));

```

## 属性相关
```c++
QString text() const;                                                 // 获取显示的文本
void settext(const QString &text);                                // 设置显示的文本，这是一个槽
const QPixmap *pixmap() const;                                 // 获取显示的图像
void setPixmap(const QPixmap &pixmap);                     // 设置显示的图像，这时一个槽
void setNum(int num);                                              // 设置显示的文本为代表整数 num 的字符串，这是一个槽
void setNum(double num);                                         // 设置显示的文本为代表浮点数 num 的字符串，这时一个槽
```

## 清空显示
```c++
void clear();    // 清空显示内容
```

## 对齐方式
```c++
Qt::Alignment alignment() const;    // 获取对齐方式
void setAlignment(Qt::Alignment align);    // 设置对齐方式
```
Qt::Alignment 类型有以下取值。
        1）Qt::AlignLeft:：水平方向靠左。
        2）Qt::AlignRight：水平方向靠右。
        3）Qt::AlignHCenter：水平方向居中。
        4）Qt::AlignJustify：水平方向调整间距两端对齐。
        5）Qt::AlignTop：垂直方向靠上。
        6）Qt::AlignButton：垂直方向靠下。
        7）Qt::AlignVCenter：垂直方向居中。
        8）Qt::AlignCenter：等价于 Qt::AlignHCenter | Qt::AlignVCenter。

其中一个水平方向的取值和一个垂直方向的取值可以用 “按位或” 的方式组合起来以同时指定两个方向的对齐方式。默认的对齐方式为水平靠左、垂直居中。

## 文本的缩进值
```c++
int indent() const;    // 获取文本缩进值
void setIndex(int indent);    //设置文本缩进值
```

## 是否换行
```c++
bool wordWrap() const;            // 判断是否允许换行
void setWordWrap(bool on);     // 设置是否允许换行
```

## 显示图像时是否允许缩放
如果允许缩放，则显示图像时会进行缩放以填满整个显示区域。
```c++
bool hasScaledContenes() const;    // 判断是否允许图像缩放
void setScaledContents(bool on);    // 设置是否允许图像缩放
```


