本文目录
=================

* [一、修饰常量](#一修饰常量)
* [二、修饰指针](#二修饰指针)
* [三、const修饰函数声明](#三const修饰函数声明)
* [四、const修饰c++类相关](#四const修饰c类相关)
   * [1. const修饰类对象](#1-const修饰类对象)
   * [2. const修饰成员变量](#2-const修饰成员变量)
   * [3. const修饰类的成员函数](#3-const修饰类的成员函数)
   * [4. c++ const_cast](#4-c-const_cast)
   * [5. c++ mutable](#5-c-mutable)
* [五、const常量与define宏定义的区别](#五const常量与define宏定义的区别)

# 一、修饰常量
```c++
　　const int temp1;  //temp1为常量，不可变
　　int const temp2;  //temp2为常量，不可变
```

# 二、修饰指针
    看const在*的前后，在前则指针指向的内容为常量，在后则指针本身为常量。
```c++
　　const int *ptr;   //*ptr为常量；
　　int const *ptr;   //*ptr为常量；
　　int* const ptr;   //ptr为常量；
　　const int * const ptr;   //*ptr、ptr均为常量；
```
# 三、const修饰函数声明
　　在函数声明中，const可以修饰函数的返回值，也可以修饰具体某一个形参；
　　修饰形参时，用相应的变量初始化const常量，在函数体内，按照const所修饰的部分进行常量化；
　　修饰函数返回值时，一般情况下，const修饰返回值多用于操作符的重载。通常不建议用const修饰函数的返回值类型为某个对象或某个对象引用的情况；

# 四、const修饰c++类相关
## 1. const修饰类对象
    const修饰类对象时，其对象中的任何成员都不能被修改。const修饰的对象，只能调用const成员函数，因为任何非const成员函数都会有修改成员变量的可能。
```c++
　　class TEMP{
　　　　void func1();
　　　　void func2() const;
　　}

　　const TEMP temp;
　　temp.func1();  //错误；
　　temp.func2();  //正确；
```

## 2. const修饰成员变量
　　const修饰的成员变量不能被修改，同时只能在初始化列表中被初始化，因为常量只能被初始化，不能被赋值；
　　赋值是使用新值覆盖旧值构造函数是先为其开辟空间然后为其赋值，不是初始化；
而初始化列表开辟空间和初始化是同时完成的，直接给与一个值，所以const成员变量一定要在初始化列表中完成。
```c++
　　class TEMP{
　　　　const int val;            
　　　　TEMP(int x)val(x){};   //只能在初始化列表中赋值；
　　}
```

## 3. const修饰类的成员函数
　　const成员函数表示该成员函数不能修改类对象中的任何非const成员变量。一般const写在函数的后面，形如：void func() const;
　　如果某个成员函数不会修改成员变量，那么最好将其声明为const，因为const成员函数不会对数据进行修改，如果修改，编译器将会报错；
```c++
　　class TEMP{
　　　　void func()const;  //常成员函数，不能修改对象中的成员变量，也不能调用类中任何非const成员函数；
　　}
```
　　对于const类对象，只能调用类中的const成员函数。

## 4. c++ const_cast
　　用于修改类型的const或volatile属性。

　　用法:  const_cast<type_id> (expression)

　　该运算符用来修改类型的const或volatile属性。除了const 或volatile修饰之外， type_id和expression的类型是一样的。
　　1）常量指针被转化成非常量的指针，并且仍然指向原来的对象；
　　2）常量引用被转换成非常量的引用，并且仍然指向原来的对象；
　　3）const_cast一般用于修改底指针。如const char *p形式。
 
建议：
　　1、应该尽可能使用const，它会允许你指定一个语义约束（也就是指定一个不能被改动的对象），而编译器会强制实施这项约束。它允许你告诉编译器和其他程序员某值应该保持不变。
　　2、将某些东西声明为const可帮助编译器侦测出错误用法。const可被施加于任何作用域内的对象、函数参数、函数返回类型、成员函数本体；
　　3、编译器强制实施bitwise constness，但你编写程序时应该使用“概念上的常量性”（conceptual constness）;
　　4、当const和non_const成员函数有着实质等价的实现时，令non-const版本调用const版本可避免代码重复；
## 5. c++ mutable
在C++中，mutable是为了突破const的限制而设置的。
被mutable修饰的变量，将永远处于可变的状态，即使在一个const函数中，甚至结构体变量或者类对象为const，其mutable成员也可以被修改：
```c++
　　class ST {
　　　　public:
　　　　int a;
　　　　mutable int showCount;
　　　　void Show()const;
　　};

　　void ST::Show()const{
　　　　//a=1;//错误，不能在const成员函数中修改普通变量
　　　　showCount++;//正确
　　}
```
mutable只能修饰非静态数据成员；


# 五、const常量与define宏定义的区别
+ 1. 处理阶段不同
const常量在编译阶段使用，define是在预处理阶段。

+ 2. 类型和安全检查不同
const常量有明确的类型，在编译阶段会进行类型检查；
define没有类型，不做任何检查，仅仅是字符替换，没有类型安全检查，并且在字符替换时可能会产生意料不到的错误。

+ 3. 存储方式不同
编译器通常不会为const常量分配空间，只是将它们保存在符号表内，使他们成为一个编译期间的一个常量，没有读取内存的操作，效率也很高；
define是字符替换，有多少地方使用，就会替换多少次，不会分配内存。


