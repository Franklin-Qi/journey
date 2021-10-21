# override重写
override是重写（覆盖）了一个方法，以实现不同的功能。一般是用于`子类在继承父类时，重写（重新实现）父类中的方法`。

## 重写（覆盖）的规则：
- 重写方法的参数列表必须完全与被重写的方法的相同,否则不能称其为重写而是重载.
- 重写方法的访问修饰符一定要大于被重写方法的访问修饰符（public>protected>default>private）。
- 重写的方法的返回值必须和被重写的方法的返回一致；
- 重写的方法所抛出的异常必须和被重写方法的所抛出的异常一致，或者是其子类；
- 被重写的方法不能为private，否则在其子类中只是新定义了一个方法，并没有对其进行重写。
- 静态方法不能被重写为非静态的方法（会编译出错）。

## 重写实例ukui-control-center
接口类`shell/interface.h`
```c++
#ifndef INTERFACE_H
#define INTERFACE_H

class QString;
class QWidget;
class QStringLiteral;

enum FunType{
    SYSTEM, // 系统
    DEVICES, // 设备
    PERSONALIZED, // 个性化
    NETWORK, // 网络
    ACCOUNT, // 账户
    DATETIME, // 时间语言
    UPDATE, // 安全更新
    NOTICEANDTASKS, // 通知关于
    TOTALMODULES,
};

enum SystemIndex{
    DISPLAY, // 显示器
    DEFAULTAPP, // 默认应用
    POWER, // 电源
    AUTOBOOT, // 开机启动
    TOTALSYSFUNC,
};

enum DevicesIndex{
    PRINTER, // 打印机
    MOUSE, // 鼠标
    TOUCHPAD, // 触摸板
    KEYBOARD, // 键盘
    SHORTCUT, // 快捷键
    AUDIO, // 声音
    BLUETOOTH, // 蓝牙
    TOTALDEVICESFUNC,
};

enum PersonalizedIndex{
    BACKGROUND, // 背景
    THEME, // 主题
    SCREENLOCK, // 锁屏
    FONTS, // 字体
    SCREENSAVER, // 屏保
    DESKTOP, // 桌面
    TOTALPERSFUNC,
};

enum NetworkIndex{
    NETCONNECT, // 网络连接
    VPN, // VPN
    PROXY, // 代理
    VINO, // 桌面共享
    TOTALNETFUNC,
};

enum AccountIndex{
    USERINFO, // 账户信息
    NETWORKACCOUNT, // 云账户
    TOTALACCOUNTFUNC,
};

enum DatetimeIndex{
    DAT, // 时间日期
    AREA, // 区域语言
    TOTALDTFUNC,
};

enum SeUpdatesIndex{
    SECURITYCENTER, // 安全中心
    UPDATES, // 备份
    BACKUP, // 更新
    TOTALSUFUNC,
};

enum NoticeAndTasksIndex{
    NOTICE, // 通知
    ABOUT, // 关于
    EXPERIENCEPLAN, // 搜索
    TOTALNATFUNC,
};

class CommonInterface{
public:
    virtual ~CommonInterface(){}
    virtual QString get_plugin_name() = 0;
    virtual int get_plugin_type() = 0;
    virtual QWidget * get_plugin_ui() = 0;
    virtual void plugin_delay_control() = 0;


    /**
     * \brief name
     * module name (用于搜索？)
     */
    virtual const QString name() const = 0;

    /**
     * \brief translationPath
     * 获取多语言文件路径，用于搜索
     * \return QString
     */
    virtual QString translationPath()const {
        return QStringLiteral(":/i18n/%1.ts");
    }
};

#define CommonInterface_iid "org.kycc.CommonInterface"

Q_DECLARE_INTERFACE(CommonInterface, CommonInterface_iid)

#endif // INTERFACE_H

```
文件`plugins/messages-task/about/about.h`通过`Q_DECL_OVERRIDE`实现重写。
```c++
    QString get_plugin_name() Q_DECL_OVERRIDE;
    int get_plugin_type() Q_DECL_OVERRIDE;
    QWidget * get_plugin_ui() Q_DECL_OVERRIDE;
    void plugin_delay_control() Q_DECL_OVERRIDE;
    const QString name() const  Q_DECL_OVERRIDE;
```


