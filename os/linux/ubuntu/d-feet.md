# dconf-editor

## 一、输入参数为QStringList

可以采用格式，如("", "", "")：

```
("/home/yushuoqi/code/build-kylin-music-unknown-Debug/kylin-music", "/home/yushuoqi/音乐/录音/不同格式音频/wav.wav", "/home/yushuoqi/音乐/录音/不同格式音频/wav_track.wav")
```

## 二、dbus 的相关问题

### 2.1 文件管理器enter多个音频文件缺失问题

文件管理器 peony 通过 Enter 键导入多个文件会出问题，同时需要命令行执行` kylin-music 1.mp3 2.mp3 3.mp3 `也失败, 对比影音发现没问题。

通过询问可知， peony Enter 键之后，多个文件是依次打开的，如 kylin-music 1.mp3 ； kylin-music 2.mp3;  kylin-music 3.mp3 ，

而不是一次性输入（kylin-music 1.mp3 2.mp3 3.mp3）这种方式。

也就是说， 每次 Enter 键后，如果有多个文件，对于应用来说，则会进入多次 main 函数，排查问题可以从 main 开始。

通过日志排查和 sudo make instal 安装，发现 单例中的 dbus 调用需要在构造函数的最开始，否则会出现缺失情况。

源码:
```c++
Widget *Widget::mutual = nullptr; 
Widget::Widget(QStringList filelist, QWidget *parent)
    : QWidget(parent)
{
	mutual = this;

	//单例需要在最开始进行检测，不然kylin_music_play_request 调用会缺失导致enter导入文件缺失
	Single(filelist);

	...
		...

}

void Widget::Single(QStringList filelist)   //单例
{
	...

	QDBusInterface interface( "org.ukui.kylin_music", "/org/ukui/kylin_music","org.ukui.kylin_music.play", QDBusConnection::sessionBus());
	QDBusReply<int> reply = interface.call( "kylin_music_play_request", filelist);

	...
}

int Widget::kylin_music_play_request(QStringList filelist)
{
	qDebug() << "每次打开的请求： " << filelist;

	...
}
```



