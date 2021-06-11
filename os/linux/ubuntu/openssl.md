# Linux下利用openssl对文件进行加密和解密
**本文目录
=================

* [Linux下利用openssl对文件进行加密和解密](#linux下利用openssl对文件进行加密和解密)
   * [加密解密常识](#加密解密常识)
   * [Linux加密解密实例](#linux加密解密实例)


## 加密解密常识
加密算法分类：
- 对称加密: DES、3DES、AES等
- 非对称加密: RSA、DSA等
- 哈希加密：SHA1和MD5

查看openssl 通过`man openssl`查看相应信息，
支持的命令可用`openssl list -commands`

在Linux中可通过`openssl enc -list`进行查看可支持的加密算法。

## Linux加密解密实例
```shell
# openssl enc
function encryption() 
{ 
 /usr/bin/openssl enc -aes128 -pbkdf2 -in $1 -out $1.aes128enc
}

function decryption() 
{ 
 /usr/bin/openssl enc -aes128 -pbkdf2 -d -in $1 -out $1.aes128dec
}

```
