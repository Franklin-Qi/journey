
#include <stdio.h>
#include <string.h>
 
extern int testFunction_01(char *str);
 
int main(void)
{
	testFunction_01("hello libtool");
	return 0;
}

