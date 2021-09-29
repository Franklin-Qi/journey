
## 名字过长
//名字过长显示...
void TitleBar::longText(QLabel *nameC, QString text)
{
    QFontMetrics fontWidth(nameC->font());//得到每个字符的宽度
    QString elideNote = fontWidth.elidedText(text, Qt::ElideRight, this->width()/2);//最大宽度wid像素
    nameC->setText(elideNote);//显示省略好的字符串
    //解决tooltips设置一次后一直显示的问题
    if (elideNote.contains("…",Qt::CaseInsensitive)) {
         nameC->setToolTip(text);//设置tooltips
    } else {
         nameC->setToolTip("");//设置tooltips
    }
}

    longText(g_imageName,name);

## 标题栏主题
void TitleBar::paintEvent(QPaintEvent *event)
{
    Q_UNUSED(event);
    QPainter p(this);
    p.setRenderHint(QPainter::Antialiasing);  // 反锯齿;
    QPainterPath rectPath;
    rectPath.addRoundedRect(this->rect(), 0, 0); // 左上右下
    QStyleOption opt;
    opt.init(this);
    QColor mainColor;
    if (QColor(255,255,255) == opt.palette.color(QPalette::Base) || QColor(248,248,248) == opt.palette.color(QPalette::Base)) {
        mainColor = QColor(255, 255, 255,178);
    } else {
        mainColor = QColor(15, 15, 15,178);
    }
    p.fillPath(rectPath,QBrush(mainColor));

}

## QMessageBox 使用
        m_msg->warning(this,tr("Warning"),tr("File does not exist (or has been deleted)!"));


## 实现QT控件中的QLabel显示图片，并自适应显示。

QImage Image;
Image.load(":/image/image/logo.jpg");
QPixmap pixmap = QPixmap::fromImage(Image);
int with = ui->label_logo->width();
int height = ui->label_logo->height();
QPixmap fitpixmap = pixmap.scaled(with, height, Qt::IgnoreAspectRatio, Qt::SmoothTransformation); // 饱满填充
//QPixmap fitpixmap = pixmap.scaled(with, height, Qt::KeepAspectRatio, Qt::SmoothTransformation); // 按比例缩放
ui->label_logo->setPixmap(fitpixmap);"")

## pushbutton
~/code/ukui-control-center/commonComponent/ImageUtil/imageutil.cpp

~/code/ukui-control-center/shell/mainwindow.cpp
QPushButton * MainWindow::buildLeftsideBtn(QString bname,QString tipName) {
