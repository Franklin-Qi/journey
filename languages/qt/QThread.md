# QThread多线程
Qt实现多线程编程的两种方式
- 继承自QThread类，覆写run函数。此实现方法只有run函数内的代码是运行在子线程内。
- 创建一个QThread和QWorker(继承自QObject)类对象。使用moveToThread函数移动到thread中运行，通过thread类start信号和worker槽函数绑定

## QThread实现多线程
qdemothread.h
```c++
#ifndef QDEMOTHREAD_H
#define QDEMOTHREAD_H

#include <QThread>
#include <QDebug>

class QDemoThread : public QThread
{
    Q_OBJECT

public:
    QDemoThread(QObject* parent = nullptr);
    ~QDemoThread();

protected:
    void run() override;

public:
    void stop();

private:
    bool m_running;
};

#endif // QDEMOTHREAD_H

```
qdemothread.cpp
```c++
#include "qdemothread.h"

QDemoThread::QDemoThread(QObject* parent) : QThread(parent)
{
}

QDemoThread::~QDemoThread()
{
}

void QDemoThread::run()
{
    m_running = true;
    while(m_running)
    {
        qDebug() << "thread id:" << QThread::currentThreadId();
        sleep(1);
    }
}

void QDemoThread::stop()
{
    m_running = false;
    if(isRunning())
    {
        exit();  // 结束线程
		/// wait长时间等待会导致界面卡顿，所以可以注释掉，而将需要使用的变量在run中局部new产生。
        //wait();  // 等待退出
    }
}
```
主线程
```c++
#include "widget.h"
#include "ui_widget.h"

Widget::Widget(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Widget)
{
    ui->setupUi(this);
    demoThread = new QDemoThread(this);
    qDebug() << "main thread id:" << QThread::currentThreadId();
}

Widget::~Widget()
{
    demoThread->stop();  // 退出线程
    delete ui;
}

void Widget::on_pushButton_clicked()
{
    if(!demoThread->isRunning())
    {
        demoThread->start();  // 启动线程
    }
}
```

## 

## QObject实现多线程
创建一个QThread和QWorker(继承自QObject)类对象。
使用moveToThread函数移动到thread中运行，通过thread类start信号和worker槽函数绑定

QWorker类: qworker.h
```c++
#ifndef QWORKER_H
#define QWORKER_H

#include <QObject>
#include <QThread>
#include <QDebug>

class QWorker : public QObject
{
    Q_OBJECT
public:
    explicit QWorker(QObject *parent = nullptr);

signals:

public slots:
    void doWork();
};

#endif // QWORKER_H

```

QWorker类: qworker.h
```c++
#include "qworker.h"

QWorker::QWorker(QObject *parent) : QObject(parent)
{
}

void QWorker::doWork()
{
    qDebug() << "thread id:" << QThread::currentThreadId();
}
```

主线程
```c++
#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    qDebug() << "main thread id:" << QThread::currentThreadId();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    QThread* thread = new QThread();
    QWorker* worker = new QWorker();

    QObject::connect(thread, SIGNAL(started()), worker, SLOT(doWork()));
    QObject::connect(thread, SIGNAL(finished()), worker, SLOT(deleteLater()));
    QObject::connect(thread, SIGNAL(finished()), thread, SLOT(deleteLater()));
    worker->moveToThread(thread);
    thread->start();
}
```
