# tee
> tee命令用于将数据重定向到文件，另一方面还可以提供一份重定向数据的副本作为后续命令的stdin。
简单的说就是把数据重定向到给定文件和屏幕上。

## Examples
``` bash
ls | tee out.txt | cat -n
```

## 参考
[linux 命令大全](https://man.linuxde.net/tee)
