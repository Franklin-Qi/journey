# 定义检查等级: foreign为最宽松等级
AUTOMAKE_OPTIONS = foreign

# 将当前路径的hello在执行make install安装到/usr/bin
bin_PROGRAMS = hello

# 编译hello.c生成hello.o
hello_SOURCES = hello.c

# 链接静态库libcn.a
hello_LDADD = libcn.a

# 不安装声明静态库libcn.a
noinst_LIBRARIES = libcn.a

# 生成静态库libcn.a
libcn_a_SOURCES = cn.c

#noinst_HEADERS=config.h
#hello_CPPFLAGS=-g
