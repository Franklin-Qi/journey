本文目录
=================

   * [一、wmctrl](#一wmctrl)
   * [二、wmctrl + xdotool](#二wmctrl--xdotool)
   * [三、xwininfo + xdotool](#三xwininfo--xdotool)
   * [四、xprop + xdotool](#四xprop--xdotool)
 
## 一、wmctrl
```
$ wmctrl -lG
```

## 二、wmctrl + xdotool
```
$ wid=$(xdotool getactivewindow) // 获取整数格式window id
$ wid16=$(echo "obase=16; $wid" |bc) // 10进制wid转16进制wid16
$ wmctl -lG|grep -i $wid16
```

## 三、xwininfo + xdotool
xwininfo是x11-utils的一部分。
```
$ xwininfo -id $wid
```

## 四、xprop + xdotool
```
$ xprop -id $wid |grep _NET_WM_OPAQUE_REGION
```

