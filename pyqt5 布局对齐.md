# PyQt5学习笔记02 - PyQt5布局管理

[![img](https://upload.jianshu.io/users/upload_avatars/9101119/bc3026ea-ecf6-4c47-9009-765133f7ad6a?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/680e0e38ddc9)

[星星在线](https://www.jianshu.com/u/680e0e38ddc9)[![  ](https://upload.jianshu.io/user_badge/19c2bea4-c7f7-467f-a032-4fed9acbc55d)](https://www.jianshu.com/mobile/creator)关注

2019.05.21 22:43:55字数 1,299阅读 996

PyQt5的界面布局主要有两种方法：绝对定位和局部类。在PyQt5中有四种布局方式：水平布局、垂直布局、网格布局、表单布局。还有两种布局方法：addLayout和addWidget，其中addLayout用于在布局中插入子布局，addWidget用于在布局中插入控件。

- 垂直布局：控件默认按照从上到下的顺序进行纵向添加。
- 水平布局：控件默认按照从左到右的顺序进行横向添加。
- 栅格布局：将窗口分为若干行(row)和列(column)。
- 表单布局：控件以两列的形式布局在窗口中，左边为标签，右边为输入控件。

------

## 使用布局管理器

1. **绝对布局**
   这个就不详细说明了，使用QWidget的move、setGeometry等方法，直接设置其在窗口中的位置。

2. **盒子布局**（QHBoxLayout 水平布局、QVBoxLayout 垂直布局）
   方法：

   - **addLayout(self, QLayout, stretch=0)**
     在窗口的右边添加布局，使用stretch（伸缩量）进行伸缩，默认为0

   - addWidget(self, QWidget, stretch, Qt.Alignment)

     在布局中添加控件。

     - stretch（伸缩量），只适用于QBoxLayout布局方式，控件和窗口会随着伸缩量的变大而增加
     - alignment，指定对齐方式

3. **QGridLayout 栅格布局**
   方法：

   - **addLayout(QLayout, row, column, Qt.Alignment)**
     在栅格布局的行(row)、列(column)位置添加新的布局，并设置对齐方式
   - **addLayout(QLayout, row, column, rowSpan, columnSpan, Qt.Alignment)**
     在栅格布局中新的布局，从行(row)、列(column)开始，占据rowSpan行、columnSpan列
   - **addWidget(QWidget, row, column, Qt.Alignment)**
     在栅格布局的行(row)、列(column)中添加窗口控件，
   - **addWidget(QWidget, fromRow, fromColumn, rowSpan, columnSpan, Qt.Alignment)**
     在栅格布局中添加窗口控件，从行(row)、列(column)开始，占据rowSpan行、columnSpan列
   - **setRowStretch(row, stretch)**
     在行(row)处添加伸缩量
   - **setColumnStretch(column, stretch)**
     在列(column)处添加伸缩量

4. **QFormLayout 表单布局**
   方法：

   - **addRow(QWidget, QWidget)**
   - **addRow(QWidget, QLayout)**
   - **addRow(str, QWidget)**
   - **addRow(str, QLayout)**
     以上在表单布局最后添加一行数据，设置表单的标签和控件
   - **addRow(QWidget)**
   - **addRow(QLayout)**
     QWidget和QLayout添加在最后一行，并占据两列宽度
   - **insertRow(row, QWidget, QWidget)**
   - **insertRow(row, QWidget, QLayout)**
   - **insertRow(row, str, QWidget)**
   - **insertRow(row, str, QLayout)**
     在指定行添加标签和控件
   - **insertRow(row, QWidget)**
   - **insertRow(row, QLayout)**
     在指定行添加控件，并占据两列宽度

布局对齐方式：

| 参数                   | 描述             |
| ---------------------- | ---------------- |
| QtCore.Qt.AlignLeft    | 水平方向居左对齐 |
| QtCore.Qt.AlignRight   | 水平方向居右对齐 |
| QtCore.Qt.AlignCenter  | 水平方向居中对齐 |
| QtCore.Qt.AlignJustify | 水平方向两端对齐 |
| QtCore.Qt.AlignTop     | 垂直方向靠上对齐 |
| QtCore.Qt.AlignBottom  | 垂直方向靠下对齐 |
| QtCore.Qt.AlignVCenter | 垂直方向居中对齐 |

> **addSpacing(self, int)**
> 设置各控件的上下间距，通过该方法可以增加额外的控件

> **addStretch(self, int)**
> 分配布局大小比例

> **insertStretch(index, stretch = 0)**
> 在指定控件间隔处添加布局比例

> **insertSpacing(index, size)**
> 在指定控件间隔处设置间隔大小

addStretch是按照比例来调整界面布局，在页面布局中使用广泛，所以我们要使用一定的篇幅来进行代码测试。
使用addStretch，我们可以实现各种对齐方式，而且更加灵活。



```python
import sys
from PyQt5.QtWidgets import QtWidget, QPushButton, QHBoxLayout, QVBoxLayout

class Example(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()
    
    def initUI(self):
        layout = QHBoxLayout()
        layout.addWidget(QPushButton(str(1))
        layout.addWidget(QPushButton(str(2))
        
        self.setLayout(layout)
        self.setGeometry(300, 300, 400, 100)
        self.setWindowTitle("Buttons")
 
if __name__ == "__main__":
    app = QtWidget.QApplication(sys.argv)
    ex = Example()
    ex.show()
    sys.exit(app.exec_())
```

默认是所有控件撑满整个布局文件

![img](https://upload-images.jianshu.io/upload_images/9101119-c5a21bb716c0bdb9.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图1

- 水平居左对齐 ~ QtCore.Qt.AlignLeft



```python
def initUI(self):
    layout = QHBoxLayout()
    layout.addWidget(QPushButton(str(1))
    layout.addWidget(QPushButton(str(2))

    layout.addStretch(1) # 新增这一行
    ......
```

在两个控件后增加这一行，相当于水平布局中存在：按钮1-按钮2-stretch，此时addStretch的参数只要大于0，则表示占满整个布局最后一部分，前面的控件显示为正常大小，不要拉伸。

![img](https://upload-images.jianshu.io/upload_images/9101119-876703a75b600e3e.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图2

- 水平居右对齐 ~ QtCore.Qt.AlignRight



```python
def initUI(self):
    layout = QHBoxLayout()

    layout.addStretch(1) # 新增这一行在控件前面

    layout.addWidget(QPushButton(str(1))
    layout.addWidget(QPushButton(str(2))
    ......
```

这一行加入到布局中所有控件之前，相当于水平布局中存在：stretch-按钮1-按钮2，表示占满整个布局的最开始部分，后面的控件显示为正常大小，不要拉伸。

![img](https://upload-images.jianshu.io/upload_images/9101119-c53d7f2adc5d7977.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图3

- 水平居中对齐 ~ QtCore.Qt.AlignCenter



```python
def initUI(self):
    layout = QHBoxLayout()

    layout.addStretch(1) # 前面增加一行

    layout.addWidget(QPushButton(str(1))
    layout.addWidget(QPushButton(str(2))

    layout.addStretch(1) #后面增加一行
    ......
```

stretch-按钮1-按钮2-stretch，表示左右两边充满，控件占据中间位置

![img](https://upload-images.jianshu.io/upload_images/9101119-0387445f3b4372e4.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图4

**注意**：当一个布局中出现多个addStretch时，后面的参数就有意义了，其表示整个布局的大小减去控件总大小进行n等份分配。例如：



```python
def initUI(self):
    layout = QHBoxLayout()
    layout.addStretch(1)  # 注意1
    layout.addWidget(QPushButton(str(1))
    layout.addWidget(QPushButton(str(2))
    layout.addStretch(3)  # 注意2
```

表示除去控件1、控件2的宽度，剩余部分四等份，前面占据一份，最后面占据三份

![img](https://upload-images.jianshu.io/upload_images/9101119-40f8ac0ca97a5bd8.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图5

- 水平两端对齐 ~ QtCore.Qt.AlignJustify



```python
def initUI(self):
    layout = QHBoxLayout()
    layout.addWidget(QPushButton(str(1))
    layout.addStretch(1)  # 添加行
    layout.addWidget(QPushButton(str(2))
```

![img](https://upload-images.jianshu.io/upload_images/9101119-15f6e301cc77f1a3.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图6

- 垂直顶部对齐 ~ QtCore.Qt.AlignTop



```python
def initUI(self):
    layout = QVBoxLayout()
    layout.addWidget(QPushButton(str(1))
    layout.addWidget(QPushButton(str(2))
    layout.addStretch(1)  # 添加行
```

![img](https://upload-images.jianshu.io/upload_images/9101119-a5d08f87dc33761a.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图7

- 垂直底部对齐 ~ QtCore.Qt.AlignBottom



```python
def initUI(self):
    layout = QVBoxLayout()
    layout.addStretch(1)  # 添加行
    layout.addWidget(QPushButton(str(1))
    layout.addWidget(QPushButton(str(2))
```

![img](https://upload-images.jianshu.io/upload_images/9101119-87d9344876726936.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图8

- 垂直居中对齐 ~ QtCore.Qt.AlignVCenter



```python
def initUI(self):
    layout = QVBoxLayout()
    layout.addStretch(1)  # 添加行
    layout.addWidget(QPushButton(str(1))
    layout.addWidget(QPushButton(str(2))
    layout.addStretch(1)  # 添加行
```

![img](https://upload-images.jianshu.io/upload_images/9101119-9409b0d49f2ae46c.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图9

- 垂直两端对齐



```python
def initUI(self):
    layout = QVBoxLayout()
    layout.addWidget(QPushButton(str(1))
    layout.addStretch(1)  # 添加行
    layout.addWidget(QPushButton(str(2))
```

![img](https://upload-images.jianshu.io/upload_images/9101119-ca5f88980dcef5ec.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图10

如果要进行组合布局，例如左上角、右下角等，如下：



```python
def initUI(self):
    layout1 = QHBoxLayout()
    layout1.addWidget(QPushButton(str(1))
    layout1.addWidget(QPushButton(str(2))
    layout1.addStretch(1) # 水平居左

    layout2 = QVBoxLayout()
    layout2.addLayout(layout1)
    layout2.addStretch(1) # 垂直顶部对齐
    
    self.setLayout(layout2)
    ......
```

![img](https://upload-images.jianshu.io/upload_images/9101119-3544672b29b44d00.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图11

## addSpacing

addSpacing是设置控件之间的间距。就按照图1的布局及代码进行演示。



```python
def initUI(self):
    layout = QHBoxLayout()
    layout.addWidget(QPushButton(str(1))
    layout.addSpacing(100)
    layout.addWidget(QPushButton(str(2))
```

![img](https://upload-images.jianshu.io/upload_images/9101119-e211e9b16a3e2f5d.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

图12

间距设置可以放置在任何地方，对于调整控件位置十分有效。相当于在控件之间添加了一个空的控件。详细的用法与addStrech类似，参考以上使用即可。