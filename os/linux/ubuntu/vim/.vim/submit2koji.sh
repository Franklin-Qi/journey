# !/usr/bin/bash
if [ ! -f /usr/bin/koji ]; then
    echo
    echo "[Error] command /usr/bin/koji not found"
    echo "Exit..."
    echo
fi

if [ ! -n "$4" ]; then
    echo ""
    echo "********************************************"
    echo "     此脚本用作向 koji 提交软件源码包"
    echo "********************************************"
    echo ""
    echo "Usage..."
    echo ""
    echo "       /usr/bin/submit2koji.sh [PATH TO src.rpm] [Tag] [User]"
    echo ""
    echo "常用Tag有 :"
    echo "       ns7.4"
    echo "       ns7.0"
    echo "       nd7-mips64-ty-Release"
    echo "       nd7-mips64-ty-Release-test"
    echo "       nd7-mips64-ty-Release-3a4k-dev        (useful)" 
    echo "       nd7-x86-ty-zx        (useful)"
    echo ""
    echo "常用User有 :"
    echo "       huanzhang.yan       (默认使用 --scratch 参数)"
    echo "       kunpeng.wu       (默认使用 --scratch 参数)"
    echo "       os7.0builders    (useful 默认不使用 --scratch 参数)"
    echo "       其他用户         (默认不使用 --scratch 参数)"
    echo ""
    echo "eg:"
    echo "       /usr/bin/submit2koji.sh /root/rpmbuild/SRPMS/xxx.src.rpm ns7.4 kunpeng.wu <password>"
    echo "       /usr/bin/submit2koji.sh /root/rpmbuild/SRPMS/xxx.src.rpm ns7.4 os7.0builders <password> --scratch"
    echo "       /usr/bin/submit2koji.sh /root/rpmbuild/SRPMS/xxx.src.rpm ns7.4 jie.meng <password> --scratch"
    echo ""
    exit
fi

file=$1
if [ "${file##*.}"x = "rpm"x ]; then
    echo "$1 file name end with .rpm"
else
    echo "[Error] need a src.rpm file "
    exit
fi

if [ $2 == "ns7.4" ] || [ $2 == "ns7.0" ]; then
    echo "submit to 10.1.82.10 "
    echo "[ns7-ls]" > /etc/koji.conf
    echo "server = http://10.1.82.10/kojihub" >> /etc/koji.conf
    echo "weburl = http://10.1.82.10/koji" >> /etc/koji.conf
    echo "topurl = http://10.1.82.10/kojifiles" >> /etc/koji.conf
    PROFILE="ns7-ls"
elif [ $2 == "nd7-mips64-ty-Release" ] || [ $2 == "nd7-mips64-ty-Release-test" ]; then
    echo "submit to 10.1.122.122 "
    echo "[nd7-ls]" > /etc/koji.conf
    echo "server = http://10.1.122.122/kojihub" >> /etc/koji.conf
    echo "weburl = http://10.1.122.122/koji" >> /etc/koji.conf
    echo "topurl = http://10.1.122.122/kojifiles" >> /etc/koji.conf
    PROFILE="nd7-ls"
elif [ $2 == "nd7-x86-ty-zx" ]; then
    echo "submit to 10.1.122.182 "
    echo "[nd7-zx]" > /etc/koji.conf
    echo "server = http://10.1.122.182/kojihub" >> /etc/koji.conf
    echo "weburl = http://10.1.122.182/koji" >> /etc/koji.conf
    echo "topurl = http://10.1.122.182/kojifiles" >> /etc/koji.conf
    PROFILE="nd7-zx"
elif [ $2 == "nd7-mips64-ty-Release-3a4k-dev" ]; then
    echo "submit to 10.1.122.122 "
    echo "[nd7-ls]" > /etc/koji.conf
    echo "server = http://10.1.122.122/kojihub" >> /etc/koji.conf
    echo "weburl = http://10.1.122.122/koji" >> /etc/koji.conf
    echo "topurl = http://10.1.122.122/kojifiles" >> /etc/koji.conf
    PROFILE="nd7-ls"
else
    echo "[Error] Unknow Tag"
    exit
fi

#koji --profile=nd-koji --user os7.0builders --password os7.0builders build  nd7-mips64-ty-Release  $1

if [ $3 == "kunpeng.wu" ] || [ $3 == "Dapeng" ]; then
    koji --profile=$PROFILE --user kunpeng.wu --password $4 build $2 $1 --nowait --scratch
elif [ $3 == "os7.0builders" ]; then
    koji --profile=$PROFILE --user=os7.0builders --password=$4 build $2 $1 --nowait $5
#    koji --user=os7.0builders --password=$4 build $2 $1 --nowait --scratch
else
    koji --profile=$PROFILE --user=$3 --password=$4 build $2 $1 --nowait $5
fi
