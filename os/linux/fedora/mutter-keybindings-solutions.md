# Mutter 管理器
功能需求：系统快捷键修改
同步兆芯：控制面板中，键盘设置功能增加自定义系统快捷键功能，默认快捷键需参考OS统一标准

## 询问的知识
### 热键   F4 F6 F7 F8 F10
  control-wf-bt
  touchpad_show_osd
  gxrandr
  mate-control-center的custom-shortcut.sh脚本

### 热键   F1 F2 F3 F11 F12
  这些是mate-settings-daemon默认做好的

### win键及win组合快捷键
#### marco管理器下：
  marco + mate-panel 处理win键
  mate-control-center的custom-shortcut.sh脚本 处理win键的组合键   如：win+e win+l

#### mutter管理器下：
  mutter 处理win键与截屏键
  其余win组合键功能未实现


loongson使用的Mutter,兆芯使用的Metacity (Marco)
时间中文管理： chinese-calendar
窗口管理查看： wmctrl -m
wmctrl -l结合ps命令可用于定位指定窗口对应的程序，从而查到对应的rpm包
## 如何增加、修改快捷键？
win组合键参考/usr/bin/customize-shortcut.sh的程序，结合mutter之前的屏幕截图快捷键，

## 给出可行性解决方案
系统快捷键问题说明
## 概要
龙芯B56机器上控制面板-主题和背景-视觉效果有个模式选择（最佳性能和最佳外观）。其中，默认的最佳外观使用mutter窗口管理器,
最佳性能是使用marco窗口管理器。经测试证明marco管理器下的win及win组合快捷键已实现，而mutter管理器下的win键与截屏快捷键已实现，
win组合快捷键（如 Win+e ）未实现。


## 测试结果如下：
1、龙芯上默认窗口管理器mutter（最佳外观），win组合快捷键都不能使用；此外，Alt+F8 功能和Alt+F7功能重叠，都是移动窗口；
2、龙芯上默认窗口管理器mutter（最佳外观），手动修改控制面板-系统快捷键的win组合快捷键和Alt+F8不生效；
3、龙芯上默认窗口管理器mutter（最佳外观），手动修改mutter配置文件后win组合快捷键和Alt+F8不生效；
4、龙芯上由默认的窗口管理器mutter（最佳外观）改为marco时，除涉及工作区功能的win组合快捷键和Alt+F8都能使用；


## 参考可行解决方案有2个，如下：
1、直接将龙芯的默认窗口管理器mutter修改为marco，改动量小，但mutter问题仍旧存在；// 但由于之间有bug修改过，所以此方案丢弃
2、修改默认窗口管理器mutter的源码以及配置文件，改动量大，但涉及具体源码暂不明确需要跟踪调试。  // 可行，接下来的实现。




### 功能复现
1. 验证增加： 修改mutter源码(keybindings.c, display.c, pres.h)和org.gnome.desktop.wm.keybindings.gschema.xml配置文件。
            函数中调用指定的接口，是通过xml配置文件的name来查看的。

2. 验证修改： 修改org.gnome.desktop.wm.keybindings.gschema.xml配置文件

1和2操作后，都需要执行cdglib 和 myschemas命令编译/usr/share/glib-2.0/schemas/目录, 注销当前用户再次登陆生效。

## 突破口
1. 如何增加调试？
代码中通过meta_warning();
可以将原有的代码中调试通过正则表达式进行批量转换成可用的调试日志接口，或者通过syslog系统日志

2. 如何查看mutter的按键匹配信息
终端下mutter直接查看,或者加调试进行查看,在代码匹配中可以看到，同时代码最好用0x%x格式输出宏定义，如下：
窗口管理器警告：Display has keycode range 8 to 255
窗口管理器警告：Keysym Alt_L bound to modifier 0x8
窗口管理器警告：Keysym Meta_L bound to modifier 0x8
窗口管理器警告： Devirtualized mods 0xc0 -> 0xc (cycle-panels)
窗口管理器警告： Devirtualized mods 0xe0 -> 0xd (cycle-panels)
窗口管理器警告： Devirtualized mods 0x2000 -> 0x40 (show-desktop)

3. 宏定义在工作目录找不到
可以先全局搜索，如grep -nr "CLUTTER_KEY_Super_R" /
找到在 /usr/include/clutter-1.0/clutter/clutter-keysyms.h, 之后在工作目录,ctags -R . /usr/include/
CLUTTER_KEY_Super_L 0xffeb
CLUTTER_KEY_Super_R 0xffec


4. win 组合键
1. 验证增加： 修改mutter源码(keybindings.c, display.c, pres.h)和org.gnome.desktop.wm.keybindings.gschema.xml配置文件。
            函数中调用指定的接口，是通过xml配置文件的name来查看的。
2. 验证修改： 修改org.gnome.desktop.wm.keybindings.gschema.xml配置文件
1和2操作后，都需要执行cdglib 和 myschemas命令编译/usr/share/glib-2.0/schemas/目录, 注销当前用户再次登陆生效。

win + e : ==> event->hardware_keycode = 26   event->modifier_state = 64


5. 单独win键
抓取的键盘键，通过keycode 和 mask 进行运算，如
Grabbing keybinding Super_L keycode 133 mask 0x0 on   ==> event->hardware_keycode =133 event->modifier_state = 0x0
Grabbing keybinding Super_R keycode 134 mask 0x0 on

win    ==> event->hardware_keycode = 133  event->modifier_state = 0x0

对比第一次win和之后接下来的win键区别，发现在处理win键的函数中，之前修改人员进行了限制，打开限制试试。
打开限制后，实现了单独win不能隐藏问题。

当通过win的值判断后，进行win需要释放才生效，而不是按下生效，所以可以调整输入值，重新调用当前接口。或者重写当前接口，
在重写接口中进行调整输入值，将释放变成按下，实现功能。



6. Alt + F8 功能和Alt + F7 功能重叠:
由于调用同一个接口，因此对同一接口查看2个日志区别，分析2者resizing = 0, 并不能解决问题。

把Alt + F8 功能用鼠标和键盘分别查看日志区别，分析出鼠标的resizing = 1， 而键盘按键的resizing = 0，进行查出问题，
所以，解决问题就在于如何使得resizing = 1, 继续加调试并测试，最后成功。

Alt + F7:  begin-move
event->hardware_keycode=73 event->modifier_state=8
move: 0x103
Grap op 259
enent_route=3
resizing: 0

Alt + F8: begin-resize
keysys_code: 0xffc5
event->hardware_keycode=74 event->modifier_state=8
resize: 0x303
event_route=3
resizing: 0

鼠标直接进行begin-resize窗口大小时，resizing： 1
((op & META_GRAB_OP_WINDOW_DIR_MASK) != 0) ? 1: 0     ==>>   op & META_GRAB_OP_WINDOW_DIR_MASK) != 0 代表resize
how to make this : 1
首先测试下UNKNOWN的形式，如何可以的话就尝试改下其他的，比如去掉& META_GRAB_OP_WINDOW_DIR_MASK,而直接进行判断op，应为moving的op为0
>>>>>>>>>>>   验证可以使用，success

相应值可以通过mutter-simple.test.tar.gz来测试。


## 附录
Alt + F8: begin-resize   handle_begin_resize
Alt + F7: begin-moving   handle_begin_moving






# 快捷键修改
# ARM系统快捷键修改

## 1、目标：删除所有的build-in custom 快捷键

(1)删除或注释掉 **/etc/dconf/db/neokylin.d/10-neokylin-keybindings** 内的全部内容

(2)删除或注释掉 **/usr/bin/customize-shortcut.sh** 内的全部内容

## 2、修改：所有需要修改的快捷键均采用开源做法

(1)开源代码的快捷键几乎全在 **窗口管理器** 和 **settings-daemon** 内实现

开源逻辑：

- 在xml文件内进每个key值绑定一个快捷键
- 每个key值在代码内部也对应一个回调函数
- 具体回调函数与快捷键的绑定方式在不同源码包内也是不同的
- 增加或修改快捷键意味着修改xml文件key值，处理代码内回调函数等操作

(2)将修改或增加的快捷键显示给用户

以fedora MATE系为例：

- 在 **/usr/share/mate-control-center/keybindings** 目录下提供了xml文件，每个xml文件代表了一个分组，将需要展示给用户的数据按照格式加到文件内部即可

# 3、注意

在修改过程中可以增加快捷键绑定(即增加xml的key值)，但是尽量***不要对已存在key值的name值做更改***，因为这可能带来无法预知的后果，如点击任意窗口做上角后造成窗口管理器意外结束。

# 4、应用举例(fedora MATE系为例)

(1) xml 文件内增加key值   <u>/usr/share/glib-2.0/schemas/org.mate.marco.gschema.xml</u>

```xml
    <key name="display-switch-1" type="s">
      <default>'XF86Display'</default>
      <summary>Display switch 1</summary>
      <description>The format looks like "&lt;Control&gt;a" or "&lt;Shift&gt;&lt;Alt&gt;F1". The parser is fairly liberal and allows lower or upper case, and also abbreviations such as "&lt;Ctl&gt;" and "&lt;Ctrl&gt;". If you set the option to the special string "disabled", then there will be no keybinding for this action.</description>
    </key>
```

(2)c代码进行回调函数绑定   marco   <u>src/include/all-keybindings.h</u>

```c
keybind (display-switch-1, handle_display_switch, 0, 0)
```

记得在c函数实现 **handle_display_switch**

(3)对新增的快捷键分组   <u>/usr/share/mate-control-center/keybindings/50-marco-desktop-key.xml</u>

```xml
<KeyListEntry name="display-switch-1" description="Display switch 1"></KeyListEntry>
```

(4)源码层面修改的话不要忘记修改po文件进行汉化

(5)最终结果图

<img src="/home/yan/图片/keybinding-change.png" alt="keybinding-change" style="zoom:75%;" />

