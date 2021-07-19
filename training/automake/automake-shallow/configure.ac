#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT(hello, 1.0, yushuoqi@kylinos.cn, hellokylin1, "http://launchpad.dev/")
AC_CONFIG_SRCDIR([hello.c])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE

# AC_DEFINE(VAR, 10, NULL)

# 打包静态文件
AC_PROG_RANLIB

# Checks for programs.
AC_PROG_CC

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([stdlib.h])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

#AC_CONFIG_FILES([Makefile])
# shallow方式也需要在头文件下生成Makefile，将头文件打包
AC_CONFIG_FILES(Makefile
                cn/Makefile
                include/Makefile)
AC_OUTPUT
