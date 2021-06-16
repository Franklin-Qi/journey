# QLabel
QLabel可以显示图片。

## setStyleSheet适应主题颜色
```c++
    ui->titleLabel->setStyleSheet("QLabel{font-size: 18px; color: palette(windowText);}");
```

## QPixmap图片反白
`ukui-control-center(plugins/messages-task/about/about.cpp)`通知关于界面的关于图标反白
```c++
ui->logoLabel->setPixmap(QPixmap("://img/plugins/about/galaxyUnicorn.png"));
ui->logoLabel->setPixmap(QPixmap("://img/plugins/about/logoukui.svg"));

```
