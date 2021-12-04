# 浅谈pyqt5在QMainWindow中布局的问题

 更新时间：2019-06-25 03:02:41  作者：佚名  [![img](F:\Typora_book\typora_pic\text-message.png) 我要评论(0)](http://www.52codes.net/develop/shell/57846.html#comments)

引言：
在pyqt5中使用了父类为QMainWindow的话，在里面使用布局类，QGridLayout， QHBoxLayout ，QVBoxLayout 时，发现不好用。
解决：
如果是在以QWidget为父



**引言：**

在pyqt5中使用了父类为QMainWindow的话，在里面使用布局类，QGridLayout， QHBoxLayout ，QVBoxLayout 时，发现不好用。

# QWidget为父类的自定义类很好用

但是在QMainWindow中使用的时候要多写几句话。具体如下所示：

```python
widget = QWidget()
widget.setLayout(gridLayout)
self.setCentralWidget(widget)
```

```
gridLayout = QGridLayout(self)
```

加上这几句话后，就和在QWidget中一样使用了。

以上这篇浅谈pyqt5在QMainWindow中布局的问题就是小编分享给大家的全部内容了，希望能给大家一个参考，也希望大家多多支持脚本之家。