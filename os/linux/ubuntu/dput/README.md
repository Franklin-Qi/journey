# dput配置
## dput上传source到PPA
[dput上传source到ppa](http://zsk.kylin.com/support/article/view/146#header_5)

### 源码包签名
生成 GPG key 用于上传源码的身份认证（如果已经生成过GPG key了可以跳过这一步）

      运行： $ gpg --gen-key

    注意：V10.1请使用命令 gpg --full-generate-key
      1）GPG 将会问你需要何种key。选择默认的 (RSA and DSA) 就可以。
      2）然后将问你key的大小. 默认为(currently 2048)， 这也可以, 但 4096 更安全.
      3）之后，询问你是否希望key有期限. 你可以选择“0”, 这意味着你的key将永远不会过期.
      4）接着问你的姓名和email.
      5）最后你将会被要求设置密码。 （记住密码，后面完成邮件验证时需要该密码）
      最后后GPG将会为你生成一个KEY, 将会花费一些时间。一旦完成，你将获得下面提示：
      pub 4096R/43CDE61D 2010-12-06 Key fingerprint = 5C28 0144 FB08 91C0 2CF3 37AC 6F0B F90F 43CD E61D
      uid Daniel Holbach <xx@xxx.com>
      sub 4096R/51FBE68C 2010-12-06
      其中 43CDE61D就是 key ID.
      【注意：此步骤中的email地址实际上是用户身份的唯一凭证，因为后面要通过邮件来完成验证过程。务必使用注册launchpad帐号时的邮件地址。】


### 上传key到公钥服务器

      运行： $ gpg --keyserver keyserver.launchpad.dev --send-keys  43CDE61D

 
### 上传你的GPG key到Launchpad

      1）首先运行：$ gpg --fingerprint
      得到fingerprint
      pub 4096R/43CDE61D 2010-12-06 Key fingerprint = 5C28 0144 FB08 91C0 2CF3 37AC 6F0B F90F 43CD E61D
      uid Daniel Holbach <dh@mailempfang.de>
      sub 4096R/51FBE68C 2010-12-06

      2）打开 https://launchpad.dev/~/+editpgpkeys 并拷贝 “Key fingerprint” 到text输入框. 在上面的例子中就是5C28 0144 FB08 91C0 2CF3 37AC 6F0B F90F 43CD E61D. 然后点击“Import Key”.
      如果前面上传Key成功，则此处页面会提示发了一封邮件到注册邮箱，其中包含验证信息。
 

### 通过邮箱验证gpg

     1）先把邮件中从"-----BEGIN PGP MESSAGE-----" 到"-----END PGP MESSAGE-----"的内容拷贝到一个文件中，注意，这两行也需要拷。
     2）在终端中执行命令： gpg -d xxx.txt
        其中xxx.txt为刚刚创建的文件名。

     3）程序会提示，需要输入密码（之前生成gpg key的密码），然后给出一个新的文件名用于放解密的结果。
     4）最后，打开解密文件中的链接完成验证。

 

### 配置debuild所使用的默认签名

    1. echo 'DEBSIGN_KEYID="43CDE61D"' >> ~/.devscripts
    注意：V10.1请使用完整fingerprint，例如（区别在于fingerprint长度，使用短fingerprint会提示错误）：
    echo 'DEBSIGN_KEYID="A7916A0AF9E7A0449BF82B6118BF50DDC33120DA"' >> ~/.devscripts

    2. 运行 debuild  -sa -S (注意：V10.1 debuild -sa -S -nc)生成源码包时就会自动用选择的key来对.dsc和.changes文件进行签名了
     注意：配置默认签名只对debuild命令有效，dpkg-buildpackage -S 依然是根据changelog里的署名来查找key，如果找不到就不会签名。
    本地编包命令：dpkg-buildpackage -b

### dput上传source到PPA里
使用dput命令上传source：
```shell
 dput devppa:<owner>/neokylin/<ppaname> <source.changes>
# 比如当前4.0-1c版本的目标PPA是neokylin/neokylin/4.0-1c
```
上传前需要先在/etc/dput.cf或者~/.dput.cf里添加

```shell
[devppa]
fqdn = ppa.launchpad.dev:2121
method = ftp
incoming = ~%(devppa)s
login = anonymous
```

### dput上传source到正式版本
使用dput命令上传source：
```shell
 dput dev:<distribution> <source.changes>
# 比如主版本的distribution名称为neokylin
```
 要上传到4.0-2系列的source，要把changelog里的xenial或者juniper改为juniper-proposed。
 上传前需要先在/etc/dput.cf或者~/.dput.cf里添加
```shell
[dev]
fqdn = ppa.launchpad.dev:2121
method = ftp
incoming = /%(dev)s
login = anonymous
```
