# palette 画板
palette 可以绘制背景图片和背景颜色

## palette 绘制背景颜色
```c++
 QPalette pal(this->palette());
 pal.setColor(QPalette::Background, QColor(255, 255, 255, 1));  
 this->setPalette(pal);
 setAutoFillBackground(true); // 作为父QWidget的子窗口也会有背景
```

## palette 绘制背景图片
```c++
 QPalette pal;  
 pal.setBrush(QPalette::Background, QBrush(QPixmap(":/icon/editbar/rotate.svg")));  
 this->setPalette(pal);
```

## 控制面板首选语言
代码位置： plugins/time-language/area/area.cpp
代码控件和风格：
```c++
ui->title3Label->setStyleSheet("QLabel{font-size: 18px; color: palette(windowText);}")
```
