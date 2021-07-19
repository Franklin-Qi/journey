#include <stdio.h>
#include <stdlib.h>
#include "cn.h"

int main(int argc, char *argv[])
{
    int a = 1;
    int b = 2;
    int c;

    c = sum(a, b);

    printf("hello world!\n");

    printf("c = %d\n", c);

    return 0;
}
