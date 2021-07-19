# 定义检查等级: foreign为最宽松等级
AUTOMAKE_OPTIONS = foreign

# 包含子路径在cn include 上进行
SUBDIRES = cn include

# 将当前路径的hello在执行make install安装到/usr/bin
bin_PROGRAMS = hello

# 编译hello.c生成hello.o
hello_SOURCES = hello.c

hello_CFLAGS = -I$(top_srcdir)/include
# hello_CFLAGS生效
export hello_CFLAGS

# 链接静态库libcn.a
hello_LDADD = libcn.a

