# QTranslator国际化
> QTranslator可以实现国际化，包括藏文、中文等。

## 国际化过程
- 1. 在程序源码中标识需要翻译的文本信息
- 2. 通过Qtcreator生成.ts翻译文件
- 3. 通过翻译工具(linguist)，对.ts文件进行翻译，发布生成.qm二进制文件
- 4. 在源码中加载.qm文件，实现国际化

## 汉化实例
### pro工程文件添加
```shell
TRANSLATIONS = translations/kylin-scanner.zh_CN.ts
qm_files.files = translations/*.qm
qm_files.path = /usr/share/kylin-scanner/translations/

INSTALLS += qm_files
DISTFILES += translations/local.zh_CN.qm
```
### 代码中标识国际化代码
```c++
    /**
	* main.cpp: For qt: QFileDialog translate
	*
	* qt项目目录下./qttranslations/translations 目录下有很多翻译文件
	* 在ts文件中，翻译文件的一些代码也可以实现QFileDialog国际化
	*/
    QTranslator qtTranslator;
    qtTranslator.load("qt_" + QLocale::system().name(),
                      QLibraryInfo::location(QLibraryInfo::TranslationsPath));
    app.installTranslator(&qtTranslator);

    // For translations with different language environments
    QTranslator translator;
    QString localePath(CN_TRANSLATION_FILE_PATH);
    QString locale = localePath + QLocale::system().name();

    translator.load(locale);
    app.installTranslator(&translator);

	// other cpp files: For instance, titlebar.cpp
	ui->label->setText(tr("Hello"));
```
### 生成ts文件
工具->外部->Qt语言家->更新翻译(lupdate)和发布翻译(lrealese)

### linguist进行翻译
```bash
linguist translations/kylin-scanner.zh_CN.ts
```
之后进行保存和发布翻译。

