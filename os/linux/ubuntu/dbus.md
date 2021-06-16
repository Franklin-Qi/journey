# dbus

## 概念
D-Bus是针对桌面环境优化的IPC（interprocess communication ）机制，用于进程间的通信或进程与内核的通信。
最基本的D-Bus协议是一对一的通信协议。但在很多情况下，通信的一方是消息总线。
消息总线是一个特殊的应用，它同时与多个应用通信，并在应用之间传递消息。
消息总线的角色有点类似与X系统中的窗口管理器，窗口管理器既是X客户，又负责管理窗口。

支持dbus的系统都有两个标准的消息总线：系统总线和会话总线。
系统总线用于系统与应用的通信。会话总线用于应用之间的通信。

有一个`d-feet`的python程序，我们可以用它来观察系统中的dbus世界。

D-Bus是一个程序。它提供了API，但我们一般不会直接使用dbus的接口。

## Qt dbus 参考
dbus tutorial 地址： https://dbus.freedesktop.org/doc/dbus-tutorial.html
dbus Qt地址：https://doc.qt.io/qt-5/qtdbus-index.html
