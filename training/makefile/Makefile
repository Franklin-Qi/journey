# 伪目标.PHONY: 避免与同名文件发生冲突，以及提高性能
.PHONY: clean install

# CC默认变量
CC=gcc

CFLAGS=-Wall -g -I./include
LDFLAGS=-L./lib -lcn
LIBS=-lcn
target=${bin}/hello
srcs=${wildcard ${src}/*.c}
#objs=${obj}/hello.o ${obj}/cn.o
objs=${patsubst ${src}/%.c,${obj}/%.o,${srcs}}
libs=${lib}/libcn.a

bin=./bin
include=./include
lib=./lib
obj=./obj
src=./src

# VPATH=src:include:lib
vpath %.c src
vpath %.o obj

${target}:${objs} ${libs}
	${CC} $(objs) -o $@ ${LDFLAGS}

${libs}:cn.o
# 如果注释vpath %.o obj, 在当前路径下生成文件，因为vpath下隐藏会自动执行然后生成在当前目录cn.o
# ${libs}:cn.o 
	${AR} -crv $@ $<

#${obj}/%.o:${src}/%.c
	#${CC} ${CFLAGS} -c $<  -o $@
${obj}/%.o:%.c
	${CC} ${CFLAGS} -c $<  -o $@


install:
	cp -a ${target} /usr/bin

clean:
	rm -rf ${bin}/* ${lib}/* ${obj}/*
	@echo $*

subst:
	@echo ${subst .o,.c,${objs}}

# 使用的多
patsubstr:
	@echo ${patsubst %.o,%.c,${objs}}

sources=a.x a.y a.z a.x
filter:
	@echo ${filter %.x %.y, ${sources}}

# 去重
sort:
	@echo ${sort ${sources}}

