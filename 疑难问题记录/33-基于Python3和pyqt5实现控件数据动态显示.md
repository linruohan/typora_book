# 基于Python3和pyqt5实现控件数据动态显示

[lbllich](https://me.csdn.net/lbllich) 发布于2019-03-02 15:25:33 收藏

展开

最近笔者在做一个pyqt5的界面，由于在日常生活中，一些实际运用的场合都需要对数据进行实时的刷新，例如对某个数值的监控，水温，室温的监控等等，都需要实时的刷新控件显示的数据。
对于实现这样的一种功能，pyqt5在面板生成的同时就固定住了UI中的数据，例如我们产生一个QLineEdit控件，然后布局在面板上，但是控件中的数据是固定的，如果这个数据是实时更新的，想要改变空间中的数据时，就要去刷新面板，pyqt5提供了一个QApplication.processEvents()的命令来刷新整个面板，但是要完成数据的动态显示，则要不断的去调用这个函数来刷新面板，同样，以使用多线程去刷新面板上的数据，但是通过搜索各种大佬的博客等，发现了pyqt5多线程刷新的各种问题，即大佬主要使用多线程来对控件显示的数据进行实时的刷新。 本文旨在演示一种使用定时器来刷新控件实现数据的方法，具体代码如下：

```
import sys
import random
import numpy as np
from time import sleep
import datetime
from PyQt5 import QtWidgets
from PyQt5.QtCore import *
from PyQt5.QtGui import *
from PyQt5.QtWidgets import *
123456789
```

# 定义数据生成线程，该线程主要目的是不断生成随机数，用来模拟不断采集数据

```
class WorkThread(QThread):
    # 初始化线程
    def __int__(self):
        super(WorkThread, self).__init__()
    #线程运行函数
    def run(self):
        while True:
            global T_value
            global P_value
            T_value = random.randint(200,225)
            P_value = random.randint(150,200)
            print(T_value, P_value)
            sleep(3)
12345678910111213
```

# 定义显示面板

```
class plotwindows(QtWidgets.QWidget):
    def __init__(self):
        super(plotwindows,self).__init__()
        layout = QFormLayout()
        self.edita3 = QLineEdit()
        self.edita4 = QLineEdit()
        self.edita5 = QLineEdit()
        layout.addRow("A数值", self.edita3)
        layout.addRow("B数值", self.edita4)
        layout.addRow("C数值", self.edita5)
        self.setLayout(layout)
        self.Mytimer()
123456789101112
```

# 定义定时器，使用定时器每隔一段时间来出发update函数，从而刷新数据

```
def Mytimer(self):
    timer = QTimer(self)
    timer.timeout.connect(self.update)
    timer.start(100)
1234
```

# 刷新函数

```
def update(self):
   self.edita3.setText(str(T_value))
    self.edita4.setText(str(P_value))
    global SUM_value
    SUM_value = T_value + P_value
    self.edita5.setText(str(SUM_value))

def mainwindows():
    app =QtWidgets.QApplication(sys.argv)
    new = plotwindows()
    new.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    workThread = WorkThread()
    workThread.start()
    mainwindows()
1234567891011121314151617
```

![在这里插入图片描述](F:\Typora_book\typora_pic\20190302152019695.png)
![在这里插入图片描述](F:\Typora_book\typora_pic\20190302152038180.png)
可以看到，子线程不断的生成数据，同时定时器以一种不断调用刷新函数的方法来实现对控件显示数据的刷新，这样就不用再建立新线程的情况下实现刷新控件显示的功能。
如有不足，请多指教。。。