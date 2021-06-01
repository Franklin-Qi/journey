# gpg

## 生成 GPG key 用于上传源码的身份认证
> gpg --gen-key
gpg: 密钥 BEFE900C66AA8289 被标记为绝对信任
gpg: 目录‘/home/yusq/.gnupg/openpgp-revocs.d’已创建
gpg: 吊销证书已被存储为‘/home/yusq/.gnupg/openpgp-revocs.d/F734BF217FD00C7EF43C96D6BEFE900C66AA8289.rev’
公钥和私钥已经生成并被签名。

pub   rsa3072 2020-08-01 [SC] [有效至：2022-08-01]
      F734BF217FD00C7EF43C96D6BEFE900C66AA8289
      uid                      yushuoqi <yushuoqi@kylinos.cn>
      sub   rsa3072 2020-08-01 [E] [有效至：2022-08-01]

## 查看秘钥对
> gpg --list-key


## 上传key到服务器
> gpg --keyserver keyserver.ubuntu.com --send-keys  <KeyID>

此处，<KeyID> = 66AA8289 ,为后8位
A4AD689AAF357EFF

## 上传失败时
> dput ppa:yusq/ppa-neokylin kylin-scanner_1.0.0_source.changes

## 参考
https://blog.csdn.net/ligerendaqiu123/article/details/50603706

https://help.ubuntu.com/community/GnuPrivacyGuardHowto
