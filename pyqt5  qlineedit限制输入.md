# PySide/PyQt中怎样限制QLineEdit的输入？

再使用PySide/PyQt编写界面时如果能够对QLineEdite的输入进行一定的限制，这样就可能减少用户输入错误导致程序出错的概率。于是便翻看了一下Qt的帮助文档发现官方还是有这样的限制方法的，限制方法如下：
首先需要创建一个QLineEdit:

```
lineEdit = QtGui.QLineEdit()

12
```

限制输入的数值为整数：

```
lineEdit.setValidator(QtGui.QIntValidator())#设置只能输入int类型的数据
1
```

限制输入的数值为double类型：

```
lineEdit.setValidator(QtGui.QDoubleValidator())#设置只能输入double类型的数据
1
```

更强大的限制是PyQt中的正则表达式，我们都知道python中的正则表达式是非常的强大的，PyQt中的正则表达式也是和python中的差不多。
例如我们的想限制只输入数字和字母以及逗号。

```
my_regex = QtCore.QRegExp("[a-zA-Z0-9]")
my_validator = QtGui.QRegExpValidator(my_regex, lineEdit)
lineEdit.setValidator(my_validator)
123
```

这样就可以对QLineEdit的输入的数值进行限制，当然也可以对很多很多输入进行限制，在这里就不一一举例说明了，感兴趣的童鞋可以自行百度。