#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QTimer>
#include <QPainter>
#include <QLinearGradient>

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

public slots:
    void showScanLine();

    void startScan();
    void stopScan();

private:
    Ui::MainWindow *ui;

    QTimer *timer;
    int scanHeight = 0;
};
#endif // MAINWINDOW_H
