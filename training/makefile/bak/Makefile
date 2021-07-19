# 伪目标.PHONY: 避免与同名文件发生冲突，以及提高性能
.PHONY: clean install

# CC默认变量
CC=gcc

CFLAGS=-Wall -g
INCLUDE=-I${include}
LIBDIRS=-L${lib}
LIBS=-lcn
target=${bin}/hello
objs=${obj}/hello.o ${obj}/cn.o
libs=${lib}/libcn.a
bin=./bin
include=./include
lib=./lib
obj=./obj
src=./src

${target}:${objs} ${libs}
	${CC} $(objs) -o $@ ${LIBDIRS} ${LIBS}

${libs}:${obj}/cn.o
	ar -crv $@ $<

${obj}/%.o:${src}/%.c
	${CC} ${INCLUDE}  ${CFLAGS} -c $<  -o $@

install:
	cp -a ${target} /usr/bin

clean:
	rm -rf ${bin}/* ${lib}/* ${obj}/*
	@echo $*

