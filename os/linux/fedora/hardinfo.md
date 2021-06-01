# computer hardinfo

## SN 序列号
dmidecode -t 1 | grep  Serial Number

## MAC
ifconfig | grep ether

## 硬件序列号
sudo hdparm  -I /dev/sda  | head -n 10  //Model Number && Serial Number

