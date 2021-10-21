# Qt代码风格
## 头文件风格
```C++
/** 头文件包含顺序
 * 一、Qt Coding style
 * 1. Qt Class
 * 2. STL stuff
 * 3. System stuff
 *
 * 二、Google coding style for C++
 * Example: foo/foo.c
 * 1. 本 .cpp 文件对应 .h 文件为优先位置
 * 		- foo/foo.h
 * 2. C系统文件:
 * 		- #include <sys/types.h>
 * 		- #include <unistd.h>
 * 3. C++系统文件
 * 		- #include <hash_map>
 * 		- #include <vector>
 * 4. 其他项目内 .h 文件
 * 		- #include "base/basictypes.h"
 * 		- #include "base/commandlineflags.h"
 * 5. 本项目内 .h 文件
 * 		- #include "foo/bar.h"
*/
```
