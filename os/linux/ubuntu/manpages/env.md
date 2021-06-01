# env 系统环境变量
通过环境变量控制调试日志开关是否开启

## 命令行下环境变量操作
环境变量命名规则：软件名_DEBUG_作者名

export MUTTER_DEBUG_YUSQ="1" // 增加或更改环境变量
unset  MUTTER_DEBUG_YUSQ     // 删除环境变量

自己调试日志的环境变量标识为*MYDEBUG*



## Codes
``` getenv()  取得环境变量内容
头文件：#include <stdlib.h>
定义函数：char * getenv(const char *name);

函数说明：getenv()用来取得参数name 环境变量的内容. 参数name 为环境变量的名称, 如果该变量存在则会返回指向该内容的指针.
环境变量的格式为name＝value.

返回值：执行成功则返回指向该内容的指针, 找不到符合的环境变量名称则返回NULL.

#include <stdlib.h>
main()
{
   char *p;
   if((p = getenv("USER")))
       printf("USER = %s\n", p);
}

执行：
USER = yusq

```

``` putenv() 改变或增加环境变量
头文件：#include4<stdlib.h>

定义函数：int putenv(const char * string);

函数说明：putenv()用来改变或增加环境变量的内容. 参数string 的格式为name＝value, 
如果该环境变量原先存在, 则变量内容会依参数string 改变, 否则此参数内容会成为新的环境变量.

返回值：执行成功则返回0, 有错误发生则返回-1.

错误代码：ENOMEM 内存不足, 无法配置新的环境变量空间.

范例
#include <stdlib.h>
main()
{
   char *p;
   if((p = getenv("USER")))
       printf("USER =%s\n", p);
   putenv("USER=test");
   printf("USER+5s\n", getenv("USER"));
}

执行：
USER=root
USER=test
```
