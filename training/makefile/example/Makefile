# 伪目标.PHONY: 避免与同名文件发生冲突，以及提高性能
.PHONY: clean install

# CC默认变量
CC=gcc
CFLAGS=-Wall -g -I./cn/
LDFLAGS=-L./lib -lcn
target=${bin}/hello
objs=hello/hello.o cn/cn.o
libs=${lib}/libcn.a
bin=./bin
lib=./lib
obj=./obj
src=./src

${target}:${objs} ${libs}
	${CC} $(objs) -o $@ ${LDFLAGS}

${libs}:${obj}/cn.o
	ar -crv $@ $<

${obj}/%.o:${src}/%.c
	${CC} ${CFLAGS} -c $<  -o $@

install:
	cp -a ${target} /usr/bin

clean:
	rm -rf ${bin}/* ${lib}/* ${obj}/*
	@echo $*

