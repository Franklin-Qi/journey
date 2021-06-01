# GDB
在龙芯机器上，
gdb 调试很不错，可以设置查看对应的值
insight 是gdb的前端，可以有助于学习gdb，但不应该依赖。


在x86上，可以通过vscode和clion(cmake)进行调试

# 如何调试caja通过gdb
## 设置参数
```
(gdb) set args -n

# 查看参数
(gdb) show args
```

## 设置断点
1) 根据行号设置断点
(gdb) b 10
or
(gdb) b caja-icon-container.c:9714

2) 根据函数名设置断点
(gdb) b caja_icon_container_start_renaming_selected_item

3) 查看断点
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x000000012017612c in caja_drag_drop_action_ask at caja-dnd.c:840
2       breakpoint     keep y   0x00000001200d9b44 in fm_directory_view_display_selection_info at fm-directory-view.c:2468
3       breakpoint     keep y   0x0000000120183874 in caja_file_operations_trash_or_delete at caja-file-operations.c:2661
real_trash

p *view->details->window->details->active_pane->window->details->active_pane->active_slot->status_text 
status_text = 0x120bd8ce0 "选中了“2.txt” (0 字节)"

caja-window.c:1142: caja_window_key_press_event



delete
src/file-manager/fm-directory-view.c:
action_trash_callback => action_trash_callback
=> trash_or_delete_selected_files


rename:
(gdb) info b
Num     Type           Disp Enb Address            What
1       breakpoint     keep y   0x00000001201d2ff0 in caja_icon_container_start_renaming_selected_item at caja-icon-container.c:9716
	breakpoint already hit 5 times


(gdb) p items_string 
$13 = 0x1205afc20 "选中了“新建文本文件”"
(gdb) p size_string
$14 = 0x1203bbfa0 "0 字节"
(gdb) p non_folder_size_known 
$15 = 1
(gdb) p  non_folder_str
$16 = 0x0
(gdb) n
2589                g_free (size_string);
(gdb) p non_folder_str 
$17 = 0x1206cf470 "选中了“新建文本文件” (0 字节)"

4) 从一个断点继续执行到下一个断点
(gdb) continue


## 打印print
1. 打印结构体值
针对结构体变量caja
```
# 查看caja变量类型
(gdb) whatis icon
type = CajaIcon *

# 设置漂亮显示结构体
gdb) sm_mainTray = new QSystemTrayIcon(Images::icon("logo", 22), this);et print pretty on

# 打印结构体值
(gdb) print *icon
$16 = {
  data = 0x12051a470,
  item = 0x0,
  x = 0,
  y = 9.8813129168249309e-324,
  saved_ltr_x = 2.3898296155111474e-314,
  scale = 2.3898887690027927e-314,
  is_selected = 0,
  was_selected_before_rubberband = 0,
  is_visible = 0,
  is_monitored = 0,
  has_lazy_position = 0
}

# 查看当前位置
(gdb) where
#0  0x00000001201d30c0 in caja_icon_container_start_renaming_selected_item (container=0x120380960 [FMIconContainer], select_all=0)
    at caja-icon-container.c:9741
#1  0x0000000120105f54 in fm_icon_view_start_renaming_file (view=0x1204fd0c0 [FMDesktopIconView], file=0x12051a470 [CajaVFSFile], select_all=0)
    at fm-icon-view.c:1688
#2  0x00000001200e8d7c in real_action_rename (view=0x1204fd0c0 [FMDesktopIconView], select_all=0) at fm-directory-view.c:6857


2. 打印宏定义
specs文件的%build增加：
export CFLAGS='-O0 -g -march=loongson3a -mabi=64 -g3 -gdwarf-2'

其中-g3 是为了显示宏定义的，加了-g3的参数后，gcc编译的时候，
会将扩展的debug 信息编译进二进制文件里面，包括宏定义信息。
```

## 调试多进程

