# free wifi

## 准确步骤
1. 确保iwconfig 接口服务启动着
mysudo ip link set wlp3s0 up

2. 扫描附近无线网络
mysudo iw dev wlp3s0 scan | grep 47A

3. 对于WPA/WPA2 协议网络， 编辑 /etc/wpa_supplicant/wpa_supplicant.conf
增加如下行，*并确保其他配置都注销掉*
```
network={
    ssid="danke_47A8C0" 
    #password="wifi.danke.life" 
    psk="wifi.danke.life" 
    priority=1
}
```
4. 启动命令，使配置生效
mysudo wpa_supplicant -iwlp3s0 -c/etc/wpa_supplicant/wpa_supplicant.conf

5. dhcp 自动获取ip ，*必须的*
mysudo dhclient wlp3s0

6. 验证网络连接情况
iwconfig wlp3s0 => 出现ssid 有值则连接成功，桌面的网络标识不用看。

## 注意事项
对于固定的网络，只需要从步骤3开始即可。

在步骤4之后，可以增加以下步骤，但不是必须：
```
打开无线网卡电源
iwconfig wlp3s0 txpower on

启用无线网卡
ifconfig wlp3s0 up
```

## 参考
[freeWifi](https://blog.csdn.net/greenjolly/article/details/81038694)

