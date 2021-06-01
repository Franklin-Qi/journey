## 加快caja编译
```
rpm -ivh -D "_topdir `pwd`/caja-1.8.2-1.nd7.152" caja-1.8.2-1.nd7.152.src.rpm
cd caja-1.8.2-1.nd7.152
rpmbuild -ba -D "_topdir `pwd`" SPECS/caja.spec
make
make install
```


## 龙芯 b62.3同方问题处理
1. 桌面拖拽文件到U盘，桌面文件与U盘文件显示同时被选中，按delete键删除，删除的是桌面文件

问题来源：
同方

复现步骤：
选中桌面文件->鼠标拖拽文件到U盘->此时U盘内文件与桌面文件同时被选中，
按delete键，删除的是桌面的文件。

注：B62.3 iso 地址:
http://10.1.80.209/REPO/ND7U2/LS/ISO/REL/BUILD62.3/0707/

### 确定修改标准
修改为与win一致：
当拖拽桌面文件到U盘中时，桌面文件不选中，而U盘中文件选中，
此时delete则删除U盘中的文件。

## 相关文件
disk => vi src/caja-places-sidebar.c

### 解决方案
可以参考ctrl+c/v 后delete，虽然都是选中，但删除的是U盘中的。

猜测问题难点在于如何区分U盘和桌面文件。

> sudo rpm -Uvh RPMS/mips64el/*152.mips* --replacepkgs --replacefiles

display_selection_info_idle_callback
=> fm_directory_view_display_selection_info(打印选中状态信息)
如： "选中了“新建文本文件” (0 字节)"

2. 在桌面选中文件的情况下，拖动文件至U盘，桌面文件名称会变成重命名格式

### 解决方案
问题来源：
工厂

问题描述：
在桌面选中文件的情况下，拖动文件至U盘，桌面文件名称会变成重命名格式

复现步骤：
在桌面选中文件的情况下，拖动文件至U盘，桌面文件名称会变成重命名格式
1.选中桌面文件
2.直接拖动文件至U盘内

由于之前修改过重命名的ctrl+z，可以断点跟踪，一直 next
gdb跟踪断点：caja_icon_container_start_renaming_selected_item

```
Breakpoint 1, caja_icon_container_start_renaming_selected_item (container=0x1205af020 [FMIconContainer], select_all=0) at caja-icon-container.c:9716

(gdb) n
fm_icon_view_start_renaming_file (view=0x1205dc7a0 [FMDesktopIconView], file=0x1208d4ab0 [CajaVFSFile], select_all=0) at fm-icon-view.c:1690
1690	}
(gdb) n
real_action_rename (view=0x1205dc7a0 [FMDesktopIconView], select_all=0) at fm-directory-view.c:6880
6880		caja_file_list_free (selection);
(gdb) n
6881	}
(gdb) n
click_signal_rename (container=0x1205af020 [FMIconContainer], widget=0x120a13860, callback_data=0x1205dc7a0) at fm-icon-view.c:2972
2972	}
```

解决方案：
1.追加问题复现步骤：
1）单击选择文件，再次单击拖动也会触发重命名
2）单击文件，再次单击拖动到非U盘中也会出现重命名

2. 解决方案
由现象可知，该问题是由第二次单击已选择的文件，触发了重命名接口。
因此可以屏蔽因单击已选择的文件而触发的重命名接口。
全局搜索代码可知，修改后的代码不影响其他功能。


## caja 手动新建文件重叠到第一个图标处

========v10 caja 日志打印 ========
<syslog.h> => 日志打印头文件
第一种方式：
    char mystr[1024] = "";
    openlog("test", LOG_CONS | LOG_PID, LOG_AUTHPRIV);
    memcpy(mystr, "test", 1024);
    syslog(LOG_AUTHPRIV | LOG_WARNING, "[%s:%s:%d]: %s\n", __FILE__, __func__, __LINE__, mystr);
    closelog();

$ journalctl -f => 日志查看

第二种方式： => 需要在/etc/rsyslog.conf末尾增加一行: local2.* /var/log/mylog , 并执行 systemctl restart rsyslog.service

   char mystr[1024] = "";
   openlog("mylog", LOG_CONS | LOG_PID, LOG_LOCAL2);
   memcpy(mystr, "test", 1024);
   syslog(LOG_INFO, "[%s:%s:%d]: %s\n", __FILE__, __func__, __LINE__, mystr);
   closelog();

$ tail -f /var/log/mylog => 日志查看
========v10 caja 日志打印 ========

=========v10 caja 调试步骤 start=========
cd caja-241/caja-1.12.7/ =>进入源文件
vim libcaja-private/caja-icon-container.c => 修改文件
quilt add libcaja-private/caja-file-operations.c => 增加补丁文件
quilt refresh => 刷新
debuild -b -j4 => v10做补丁包
cd ..  => caja-241/目录下进行安装修改后的包
sudo dpkg -i caja_1.12.7-1kord0k241_amd64.deb caja-common_1.12.7-1kord0k241_all.deb gir1.2-caja_1.12.7-1kord0k241_amd64.deb libcaja-extension
1_1.12.7-1kord0k241_amd64.deb
ps -ef | grep caja 
kill 29087 => 由于caja会自动加载，所以找到当前的caja进行kill
=========v10 caja 调试步骤 end=========


================================================================================分析开始
src/file-manager/fm-list-view.c => 列表视图
src/file-manager/fm-directory-view.c => 图标视图，也就是平常的视图
	signals[ADD_FILE] =
		g_signal_new ("add_file",
		              G_TYPE_FROM_CLASS (klass),
		              G_SIGNAL_RUN_LAST,
		              G_STRUCT_OFFSET (FMDirectoryViewClass, add_file),
		              NULL, NULL,
		              fm_marshal_VOID__OBJECT_OBJECT,
		              G_TYPE_NONE, 2, CAJA_TYPE_FILE, CAJA_TYPE_DIRECTORY);

add_file 定义到 src/file-manager/fm-directory-view.h
    /* The 'add_file' signal is emitted to add one file to the view.
     * It must be replaced by each subclass.
     * 也就是说这里是虚函数，具体实现看子对象，可以根据G_OBJECT
     */
    void    (* add_file) 		 (FMDirectoryView *view,
                                  CajaFile *file,
                                  CajaDirectory *directory);
具体子对象实现，进行查找
$ grep -wnr "add_file" src/

src/file-manager/fm-empty-view.c:293:    fm_directory_view_class->add_file = fm_empty_view_add_file;
src/file-manager/fm-list-view.c:3413:    fm_directory_view_class->add_file = fm_list_view_add_file;
src/file-manager/fm-icon-view.c:3371:    fm_directory_view_class->add_file = fm_icon_view_add_file;
src/file-manager/fm-computer-view.c:3875:    fm_directory_view_class->add_file = fm_computer_view_add_file;

src/file-manager/fm-icon-view.c
    FMDirectoryViewClass *fm_directory_view_class; => 父对象结构体指针,相当于父对象

    fm_directory_view_class = FM_DIRECTORY_VIEW_CLASS (klass);

    G_OBJECT_CLASS (klass)->set_property = fm_icon_view_set_property;

    fm_directory_view_class->add_file = fm_icon_view_add_file; => 初始化，相当于c++的构造函数，指定
        子对象add_file实现函数在fm_icon_view_add_file() 

    fm_icon_view_add_file => caja_icon_container_add

libcaja-private/caja-icon-container.c
   caja_icon_container_add => schedule_redo_layout => redo_layout_callback => redo_layout_internal
   redo_layout_internal() 中进行修改手动排列中add_file的图标与第一个重叠

    /* Run an idle function to add the icons. */
    schedule_redo_layout (container);


    CajaIconContainer *icon_container;
    if(caja_icon_container_get_is_desktop(icon_container)) => 图标是在桌面上的
    {
        if(!desktop_has_no_icons)
            desktop_has_no_icons = TRUE;
    }

    if (container->details->auto_layout => 图标排列是手动
            && container->details->drag_state != DRAG_STATE_STRETCH)
    {
        resort (container);
        lay_down_icons (container, container->details->icons, 0); => 排列图标
    }

    redo_layout_internal => lay_down_icons 进行排列图标
        lay_down_icons_horizontal (container, icons, start_y); => 水平的排列图标
            lay_down_one_line (container, line_start, p, y, max_height_above, positions, FALSE); => 排列一行
                icon_set_position() => 设置图标位置
                    container_top =  container_y / pixels_per_unit + 5; => **图标上限+5，所以没有短横**

        lay_down_icons_vertical_desktop1 (container, icons); => 竖直的排列图标
            lay_down_one_column() => 排列一列
                icon_set_position() => 设置图标位置
                    container_top =  container_y / pixels_per_unit + 5; => 图标上限+5，所以没有短横



## 快捷方式批量移动时，会重叠
解决方案：
处理方案为当移动桌面图标到超过屏幕的宽度时，图标进行从右到左放置，
同时在图标已满的情况下，还按照原有流程放置多余图标到右上角。

新建图标在满的时候，仍按照原流程放置多余图标在右上角。

libcaja-private/caja-icon-container.c 
realize -> caja_icon_dnd_init  (dnd: drag and drop 拖动和放下)
=> libcaja-private/caja-icon-dnd.c
    drag_begin_callback
    drag_end_callback

libcaja-private/caja-icon-container.c 

选中15个icons, 循环snap_position()进行打印屏幕分辨率15次
caja_icon_container_unstretch => caja_icon_container_move_icon 

Functions:

// 判断当前网格位置是否为空(是否有其他图标在该位置)，
// 返回为TRUE时，表示当前位置没有其他图标，可以放置图标，不用再循环找下一个坐标位置
placement_grid_position_is_free()

// 桌面图标可以从左往右进行查找空位置，输入的是第一个xy(top-left)坐标，返回的是找到的xy坐标
// 寻找空位置的判断条件为是否在新行(y值超过屏幕高度) || 当前图标位置是否为空 
// 不开启新行，当前坐标为空，则可以返回当前坐标，然后设置图标位置放置在当前位置
find_empty_location() 

// 新增桌面图标可以从右往左进行查找空位置，输入的是第一个xy(top-left)坐标，返回的是找到的xy坐标
find_empty_location() 

// 设置图标位置，只要设定就可以在桌面上该坐标(top-left)位置显示图标
icon_set_position() 

// 可以排列桌面图标
align_icons()


