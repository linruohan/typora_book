No module named PyQt5.QtWebEngineWidgets

> 报错的原因是PyQt5版本过高，解决方法主要有两大类方法：

## 【方法一】 指定安装5.10.1版本的pyqt5

`pip install pyqt5==5.10.1`

## 【方法二】 单独安装WebEngine，安装命令为：

`pip install PyQtWebEngine`