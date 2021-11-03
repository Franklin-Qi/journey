# QHBoxLayout 水平布局

## 避免QLabel图片跟随控件变化
直接将QLabel加入QWidget的布局中，并设定居中等属性，会让图片变形。

将QLabel控件放入该QHBoxLayout布局，并加上伸缩和设置最小宽度和高度，之后放入QWidget控件的布局中可以实现最小宽度和高度的图片，同时不跟随QWidget而变形。
