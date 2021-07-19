#include <stdio.h>
#include <stdlib.h>

#include "config.h"

int m = 10;

int fun(int a, int b)
{
    int c = 0;
    c = a + b;
    return c;
}

int main(int argc, char *argv[])
{
    // 栈内存是从高到低
    int i = 4;
    int j = 5;
    m = fun(i, j);
    printf("i=%p j=%p\n", &i , &j);

    printf("hello, world!\n");

    printf("VAR = %d\n", VAR);

    return 0;
}
