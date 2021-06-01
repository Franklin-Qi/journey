# GTK and GLib
For gtk-demo or gtk3-demo
[gtk 定义查找](https://developer.gnome.org/gtk3/stable/gtk3-Stock-Items.html#GTK-STOCK-CLOSE:CAPS) 重要
[GTK+ github](https://github.com/yusq77/gtk/tree/mainline/examples/application1)
[GTK+ bookstack](https://www.bookstack.cn/read/GTK-3-Chinese-Reference-Manual/content-gtk-questing-index.md)
[GTK+ Gitlab](https://gitlab.gnome.org/GNOME/gtk/tree/master/examples/application7)
[bitbucket.org](https://bitbucket.org/monami_ya/gtk/src/master/) 包含gtk-demo and examples 
[GTK+ 2.0 zetcode](http://zetcode.com/gui/gtk2/firstprograms/)
[Gtk-demo 主函数](https://blog.csdn.net/taiyang1987912/article/details/48174563)  多看看
[Gtk-demo 作者目录](https://blog.csdn.net/taiyang1987912/article/list/7) 7可以改变，一般6-7关于gtk

## experiences
How to test gtk-demo localizations ?
Editing examples/test.c, add gtk-demo source codes to it and change
*do_*(Main entrance to call functions)functions in main().

How to from gtk-demo to gtk3-demo
1. Aims to some deprecated functions, should search them in *developer.gnome.org* and
find replace functions.
2. Replace functions should seek their definitions and declarations, trying to replace deprecated functions.

## gtk-demo
linux在终端下输入gtk-demo，双击名称即可运行实例，进入目录/usr/share/doc/gtk+-devel-1.2.10/examples/也有部分例子。
若想自己运行gtk-demo中的例子，加上以下主函数：
``` main
int main (int argc, char *argv[])  
 {
     /*
    GtkWidget *window = NULL;  
    gtk_init(&argc, &argv);
    window = do_button_box(NULL);
 
    gtk_widget_show_all(window);   
    gtk_main(); 
    return 0; 
     */
    GtkWidget *do_window = NULL;   
    gtk_init(&argc, &argv);   
    do_window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
 
    //add example
    do_window = do_button_box (do_window);
 
    g_signal_connect(do_window, "destroy",G_CALLBACK (gtk_main_quit), NULL);
    gtk_main();  
    return 0;   
}
```


## 宏
使C代码和C++代码保持互相兼容的过程调用接口。
``` G_BEGIN_DECLS和G_END_DECLS宏
    #ifdef  __cplusplus
    # define G_BEGIN_DECLS  extern "C" {
    # define G_END_DECLS    }
    #else
    # define G_BEGIN_DECLS
    # define G_END_DECLS
    #endif
```

## GLib的库
类型声明: G开头，后加类型名Name, 如GList, GSList, GTime
函数声明: 类型名小写加下划线组合，最后跟函数功能名。如 

 GLib是一种底层库，创建GDK和GTK应用程序时该库提供许多有用的定义和函数，
其中包括基本类型及限制的定义、标准宏、类型转化、字节序、存储分配、警告和断言、
消息记录、计时器、字符串工具、hook函数、句法扫描器、动态加载模块和字符串自动补全。
同时也提供了许多数据类型及相关操作，包括存储块、双向链表、单向链表、哈希表、动态列表、关系和元组及缓存。
最后GLib具有很好的移植性，所以使用GLib作为底层应用支持，那么也保证了应用的可移植性。


``` 存储管理
gpointer g_malloc(gulong size)：这是malloc的替代函数，不需要检查返回值。如果存储分配因任何原因失败，则应用程序终止。
gpointer g_malloc0(gulong size)：和g_malloc具有相同功能，但在返回指向分配存储块的指针前，将该存储块清0。
gpointer g_realloc(gpointer mem, gulong size)：重新分配由mem开始的指针，并设置大小为size字节。
void g_free(gpointer mem)：释放分配的存储块。如果mem为NULL，则直接返回。
```

``` GSList 单向链表
GSList *g_slist_prepend(GSList *list, gpointer data)：链表最前面新增一个元素
GSList *g_slist_insert(GSList *list, gpointer data, gint position)：指定链表位置插入新元素
GSList *g_slist_remove(GSList *list, gpointer data)：链表中删除具有值data的元素
GSList *g_slist_reverse(GSList *list)：反转元素位置
GSList *g_slist_nth(GSList *list, gint n)：返回链表中下一个元素
GSList *g_slist_find(GSList *list, gpointer data)：查找指定data的元素，没有则返回NULL
GSList *g_slist_last(GSList *list)：查找链表的最后一个元素
gint g_slist_length(GSList *list)：返回链表元素个数
void g_slist_foreach(GSList *list, GFunc func, gpointer data)：遍历链表
```

``` GList 双向链表
GList *g_list_append(GList *list, gpointer data)：将一个新元素加入到链表尾
GList *g_list_prepend(GList *list, gpointer data)：将一个新元素加入到链表头
GList *g_list_insert(GList *list, gpointer data, gint position)：插入一个新元素到链表的指定位置
GList *g_list_remove(GList *list, gpointer data)：从链表中移除一个具有值data的元素，如果元素不存在，则链表不变
GList *g_list_free(GList *list)：数释放由GList使用的所有存储区
GList *g_list_remove_link(GList *list, GList *link)
GList *g_list_reverse(GList *list)：链表元素位置反转
GList *g_list_nth(GList *list, gint n)：获取指定位置元素
GList *g_list_find(GList *list, gpointer data)：在链表中查找一个含有指定值的元素，没有则返回NULL
GList *g_list_last(GList *list)：获取链表中最后一个元素
GList *g_list_first(GList *list)：获取链表中第一个元素
gint g_list_length(GList *list)：返回链表元素个数
void g_list_foreach(GList *list, GFunc func, gpointer data)：遍历链表
gint g_list_index(GList *list, gconstpointer data)：返回指定元素在链表中的位置，没有找到匹配的元素，则返回－1。元素位置从0开始计算。



void each_callback(gpointer data, gpointer user_data)
{
    g_print("element:%s, user param:%s\n", (gchar*)data, (gchar*)user_data);
}
int main( int argc,
          char *argv[] )
{
  GList *list = NULL;
  list = g_list_append(list, "second");
  list = g_list_prepend(list, "first");
  g_list_foreach(list, each_callback, "user_data");
  GList *second = g_list_find(list, "second");
  g_print("findElement:%s\n", (gchar*)second->data);
  list = g_list_remove(list, "second");
  g_list_foreach(list, each_callback, "user_data");
  return 0;
}
```

``` GTime 计时器
GTimer *g_timer_new(void)：创建一个新计时器
void g_timer_destroy(GTimer *timer)：注销计时器
void g_timer_start(GTimer *timer)：计时器开始
void g_timer_stop(GTimer *timer)：停止计时
void g_timer_reset(GTimer *timer)：重置计时器
void g_timer_continue（GTimer *timer)：继续计时
gdobule g_timer_elapsed(GTimer *timer, gulong *microseconds)：决定所耗时间



GTimer *timer;
void each_callback(gpointer data, gpointer user_data)
{
    g_print("element:%s, user param:%s\n", (gchar*)data, (gchar*)user_data);
}
int main( int argc,
          char *argv[] )
{
  GList *list = NULL;
  gulong seconds;
  int i=0;
  timer = g_timer_new();
  list = g_list_append(list, "second");
  list = g_list_prepend(list, "first");
  g_timer_start(timer);
  g_list_foreach(list, each_callback, "user_data");
  g_timer_stop(timer);
  g_timer_elapsed(timer, &seconds);
  g_print("use seconds:%ld\n", seconds);
  g_timer_continue(timer);
  for(i; i<=1000; i++)
  {
      g_print("%d", i);
  }
  g_timer_elapsed(timer, &seconds);
  g_print("use seconds:%ld\n", seconds);
  return 0;
}
```

``` GString 字符串处理
GLib定义了一个叫做GString的新类型，它可以自动增长，并且提供了一系列方便的操作函数。
struct GString{
gchar *str;/*指向当前以\0结尾的字符串*/
gint len;/*当前字符长度*/
}


GString *g_string_new(gchar *init)：创建GList类型
GString *g_string_truncate(GString *string, gint len)：截取指定长度的字符串
GString *g_string_append(GString *string, gchar *val)：末尾追加字符串
GString *g_string_append_c(GString *string, gchar c)：末尾最加单个字符
GString *g_string_prepend(GString *string, gchar *val)：开头插入字符串
GString *g_string_prepend_c(GString *string, gchar c)：开头插入单个字符
void g_string_sprintf(GString *string, gchar *fmt, ...)：格式化字符串
gchar *g_strdup (const gchar *str)：复制字符串，返回一个新分配的字符串。
gchar *g_strndup(const gchar *str, gsize n)：复制指定个数的字符串，返回新分配的字符串
gchar *g_strstr_len(const gchar *haystack, gssize haystack_len, const gchar *needle)：在限定长度内，第一次出现指定字符的指针
gchar *g_strrstr(const gchar *haystrack, const gchar *needle):搜索字符串haystack中最后一次出现的串针。
gchar *g_strrstr_len(const gchar *haystrack, gssize haystrack_len, const gchar *needle)
gboolean g_str_hash_prefix(const gchar *str, const gchar *prefix)：返回字符串是否以某个前缀开头
int g_strcmp0(const char *str1, const char *str2)：对比两个字符串
gchar **g_strsplit(const gchar *string, const gchar *delimiter, gint max_tokens)：分割字符串，保存为数组
gchar *g_strconcat(const gchar *string1, ...)：字符串拼接
gchar *g_strjoin(const gchar *separator, ...)：以某个字符串隔离并拼接

```

``` 错误处理
gchar *g_strdup( const gchar *str )：替代strdup函数。把原字符串内容复制到新分配的存储块中，返回指向它的指针。
gchar *g_strerror( gint errnum );
void g_error( gchar *format, ... );错误提示：“ ** ERROR ** ”并且退出程序。仅用在致命错误上。
void g_warning( gchar *format, ... )：错误提示：“ ** WARNING ** ”
void g_message( gchar *format, ... )：在传递字符串前打印"message"
void g_print( gchar *format, ... )：替代printf函数
```


