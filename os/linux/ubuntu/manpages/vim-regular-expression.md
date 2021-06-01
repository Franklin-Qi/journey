# Vim Regular Expressions
Regular Expressions for Vim.

Table of Contents
=================

   * [Vim Regular Expressions](#vim-regular-expressions)
      * [Common commands](#common-commands)
      * [Metacharacters](#metacharacters)

## Common commands
1. <font color="red">Search  => /regex</font>
2. <font color="red">Replace => :s/regex/replace-string/options</font>

## Metacharacters
Outlines:

| Metacharacters | Detail messages |
| :------------: | :-------------- |
| **.**          | Match any characters |
| **[a-z0-9]**   | Match any character in square brackets |
| **[^a-z]**     | Match any character except the characters in square brackets |
| **\d**         | Match digits, equal to **[0-9]** |
| **\D**         | Match digits, equal to **[^0-9]** |
| **\x**         | Match Hex, equal to **[0-9A-Fa-f]** |
| **\X**         | Match Hex, equal to **[^0-9A-Fa-f]** |
| **\w**         | Match words, equal to **[0-9A-Za-z_]** |
| **\W**         | Match words, equal to **[^0-9A-Za-z_]** |
| **\t**         | Match TAB |
| **\s**         | Match blank characters, equal to **[\t]**  |
| **\S**         | Match any character except the blank characters, equal to **[^\t]**  |

If match charaters( * . / \ [ ), you should use    \     symbol.

[vim 正则表达式1](https://www.cnblogs.com/PegasusWang/p/3153300.html)
[vim 正则表达式2](https://cloud.tencent.com/developer/article/1453086)
[vim 正则表达式3](https://www.cnblogs.com/penseur/archive/2011/02/25/1964522.html)
