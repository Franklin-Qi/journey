# QPainter

## QPainter设置背景色
```c++
void KYCBUTTON::paintEvent(QPaintEvent *)

{
     QPainter painter(this);
     painter.setBrush(Qt::black);
     painter.drawRect(this->rect());
}
```

## QPainter设置背景图片
```c++
void KYCBUTTON::paintEvent(QPaintEvent *)

{
     QPixmap pixmap = QPixmap(":/icon/background.svg").scaled(this->size());
     QPainter painter(this);
     painter.drawPixmap(this->rect(), pixmap);
}
```
