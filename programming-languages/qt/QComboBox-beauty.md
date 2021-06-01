# QComboBox beauty
下拉列表框美化技巧整理

## 字体居中显示
可以这么用，加入一个QLineEdit
    QLineEdit *lineEdit = new QLineEdit;
    lineEdit->setReadOnly(true);
    lineEdit->setAlignment(Qt::AlignCenter);
    comboBox->setLineEdit(lineEdit);
[QLineEdit](https://blog.csdn.net/qq_34305316/article/details/96488636)

## Code
```
QStringList strList1, strList2, strList3, strList4,strList5;

    textColor->clear();
    strList1<<tr("灰度")<<tr("黑白")<<tr("彩色");
    textColor->setStyleSheet(
                "QComboBox{margin:0px;border-radius:4px;background-color:#0D0400;color:white;}" 
                "QComboBox::drop-down{subcontrol-position: top right;border-radius: 4px;border:none;}" //下拉按钮
                "QComboBox::down-arrow{border-image:url(:/icon/icon/down.png);}"//下拉箭头
                "QComboBox QAbstractItemView{margin-top:4px solid #0D0400;color:white;border-radius:4px;background-color:#888888;}"
                "QComboBox QAbstractItemView::item{width:180px;height: 32px;border-radius:4px;}"//下拉选项样式
                "QComboBox QAbstractItemView::item:hover{background-color:#6F6F6F;}"
                "QComboBox QAbstractItemView::item:selected{background-color:#6F6F6F;}"
                );
    textColor->addItems(strList1); //增加列表项
    textColor->setFixedSize(180,32); //固定长度

    //    QLineEdit *lineEdit = new QLineEdit;
//    lineEdit->setReadOnly(true);
//    lineEdit->setAlignment(Qt::AlignLeft);
//    lineEdit->setStyleSheet("QLineEdit{border: 2px solid red; border-radios:4px;background-color:#0D0400;color:white;}");
//    textColor->setLineEdit(lineEdit);

    textColor->setInsertPolicy(QComboBox::NoInsert);  //编辑框的内容不插入到列表项
    QListView *colorListView = new QListView;
    textColor->setEditable( true ); //可编辑
    textColor->setFocusPolicy(Qt::NoFocus); //获取焦点策略：无焦点，也就是不可编辑
    textColor->setModel(colorListView->model());
    textColor->setView(colorListView); //使下拉选项样式生效
```

## References
[文本框禁止编辑](https://blog.csdn.net/qq_42292831/article/details/91962503)
[QComboBox中文解释](https://zhuanlan.zhihu.com/p/57652947)
[qss界面美化简介](https://www.jianshu.com/p/409f1e2d0275)
