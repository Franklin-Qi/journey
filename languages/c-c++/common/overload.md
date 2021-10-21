# overload重载
overload是重载，一般是用于在`一个类内实现若干重载的方法，这些方法的名称相同而参数形式不同`。
C++ 允许在同一作用域中的某个函数和运算符指定多个定义，分别称为`函数重载`和`运算符重载`。

重载声明是指一个与之前已经在该作用域内声明过的函数或方法具有相同名称的声明，但是它们的参数列表和定义（实现）不相同。

当您调用一个重载函数或重载运算符时，编译器通过把您所使用的参数类型与定义中的参数类型进行比较，决定选用最合适的定义。
选择最合适的重载函数或重载运算符的过程，称为重载决策。

## 重载的规则：
- 在使用重载时只能通过相同的方法名、不同的参数形式(参数的个数、类型或者顺序)实现。
- 不能通过访问权限、返回类型、抛出的异常进行重载；
- 方法的异常类型和数目不会对重载造成影响；

## 函数重载
在同一个作用域内，可以声明几个功能类似的同名函数，但是这些同名函数的`形式参数（指参数的个数、类型或者顺序）`必须不同。
您不能仅通过返回类型的不同来重载函数。

参考`qstring.h`
```c++
	inline QString() Q_DECL_NOTHROW;
    explicit QString(const QChar *unicode, int size = -1);
    QString(QChar c);
    QString(int size, QChar c);
    inline QString(QLatin1String latin1);
    inline QString(const QString &) Q_DECL_NOTHROW;
```

## 运算符重载
您可以重定义或重载大部分 C++ 内置的运算符。这样，您就能使用自定义类型的运算符。

重载的运算符是带有特殊名称的函数，函数名是由关键字 operator 和其后要重载的运算符符号构成的。
与其他函数一样，重载运算符有一个返回类型和一个参数列表。
```c++
	QString &operator=(QChar c);
    QString &operator=(const QString &) Q_DECL_NOTHROW;
    QString &operator=(QLatin1String latin1);
#ifdef Q_COMPILER_RVALUE_REFS
    inline QString(QString && other) Q_DECL_NOTHROW : d(other.d) { other.d = Data::sharedNull(); }
    inline QString &operator=(QString &&other) Q_DECL_NOTHROW
    { qSwap(d, other.d); return *this; }
#endif
```

## Q_DECL_NOTHROW解释
Q_DECL_NOTHROW标识noexcept。
noexcept形如其名地，表示其修饰的函数不会抛出异常。
不过与throw()动态异常声明不同的是，在C++11中如果noexcept修饰的函数抛出了异常，
编译器可以选择直接调用std::terminate()函数来终止程序的运行，这比基于异常机制的throw()在效率上会高一些。
这是因为异常机制会带来一些额外开销，比如函数抛出异常，会导致函数栈被依次地展开（unwind），
并依帧调用在本帧中已构造的自动变量的析构函数等。

从语法上讲，noexcept修饰符有两种形式，一种就是简单地在函数声明后加上noexcept关键字。

另外一种则可以接受一个常量表达式作为参数，如下所示：void excpt_func() noexcept (常量表达式); 

常量表达式的结果会被转换成一个bool类型的值。该值为true，表示函数不会抛出异常，反之，则有可能抛出异常。
这里，不带常量表达式的noexcept相当于声明了noexcept(true)，即不会抛出异常。
在通常情况下，在C++11中使用noexcept可以有效地阻止异常的传播与扩散。




