#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QDebug>
#include <QScreen>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    resize(QSize(800, 600));
    QScreen *screen = QGuiApplication::primaryScreen();
    move((screen->geometry().width() - 800) / 2, (screen->geometry().height() - 600) / 2);

    this->setObjectName("MainWindow");


    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &MainWindow::showScanLine);
    timer->start(10);

    connect(ui->stopScan, &QPushButton::clicked, this, &MainWindow::stopScan);
    connect(ui->startScan, &QPushButton::clicked, this, &MainWindow::startScan);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::showScanLine()
{
    scanHeight += 1;

    if (scanHeight >= ui->label->height()) {
        scanHeight = 0;
    }


    QPixmap pix;
    QString pixFileName = QString(":/scan.pnm");

    QPixmap pixScan(":/scan.png");
    pixScan.scaled(ui->label->width(), 4, Qt::KeepAspectRatio, Qt::SmoothTransformation);

    pix.load(pixFileName );
    pix = pix.scaled(ui->label->width(), ui->label->height(), Qt::KeepAspectRatio, Qt::SmoothTransformation);
    ui->label->setPixmap(pix);

    QPainter painter(&pix);
    painter.setRenderHint(QPainter::Antialiasing, true);
    painter.setPen(Qt::transparent);
    painter.drawPixmap(0, scanHeight, ui->label->width(), 30, pixScan);

    ui->label->setPixmap(pix);
    pix.save(pixFileName );

}

void MainWindow::startScan()
{
    timer->start(10);
    scanHeight = 0;
}

void MainWindow::stopScan()
{
    QPixmap pix;
    QString pixFileName = QString(":/scan.pnm");
    pix.load(pixFileName );
    pix = pix.scaled(ui->label->width(), ui->label->height(), Qt::KeepAspectRatio, Qt::SmoothTransformation);
    ui->label->setPixmap(pix);

    timer->stop();
}

