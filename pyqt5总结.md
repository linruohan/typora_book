# [Pyqt使用总结](https://www.cnblogs.com/aloe-n/p/7979710.html)

# PyQt总结

## 1. 状态栏

### 显示临时消息

临时消息在下一个操作触发时会自动消失;

```
self.statusBar().showMessage("this is status bar")
```

### 显示永久信息

使用状态栏附加标签(或者其他Qwidget)的形式显示永久消息

```
self.label = QLabel("请打开项目 : [文件 -> 打开config.json]")
self.statusBar().addWidget(self.label)
```

### 设置状态栏样式

```
self.setStyleSheet("QStatusBar{padding-left:8px;background:rgba(240,240,240,255);color:black;font-weight:bold;}")
```

## 2. 中文乱码整体设置

```
reload(sys)
sys.setdefaultencoding('utf-8')
QTextCodec.setCodecForCStrings(QTextCodec.codecForName("utf-8"))
```

## 3. QTextBrowser

1. 重置内容

   ```
   self.textBrowser.setText("this is new content")
   ```

2. 添加内容

   ```
   self.textBrowser.append("this is appended test")
   ```

3. 清空内容

   ```
   self.textBrowser.clear()
   ```

## 4. QcomboBox

1. 清空内容

   ```
   self.comboBox.clear()
   ```

2. 添加一条

   ```
   self.comboBox.addItem("new Item")
   ```

3. 添加列表

   ```
   self.comboBox.addItems(list)
   ```

## 5. 重定向输出

```python
# -*- coding: utf-8 -*-

import sys
from PyQt4 import QtGui
from PyQt4.QtCore import pyqtSignature, QThread, QObject, pyqtSignal, QTextCodec,pyqtSignal
from PyQt4.QtGui import QFrame
reload(sys)
sys.setdefaultencoding('utf-8')
QTextCodec.setCodecForCStrings(QTextCodec.codecForName("utf-8"))

class EmittingStream(QObject):
    textWritten = pyqtSignal(str)
    def write(self, text):
        self.textWritten.emit(str(text))


class Example(QtGui.QMainWindow):
    def __init__(self):
        super(Example, self).__init__()
        self.setWindowTitle(u"测试")

        self.textEdit = QtGui.QTextEdit(self)
        self.textEdit.move(0,50)
        self.textEdit.resize(350,300)

        self.qbtn = QtGui.QPushButton('print', self)
        self.qbtn.move(100, 10)
        self.qbtn.clicked.connect(self.my_print)

        self.setGeometry(300, 300, 350, 250)
        self.setWindowTitle('Main window')

        # 重定向输出
        sys.stdout = EmittingStream(textWritten=self.normalOutputWritten)
        sys.stderr = EmittingStream(textWritten=self.normalOutputWritten)


    def my_print(self):
        print("hello world!")


    def normalOutputWritten(self, text):
        # 重定向输出位置
        cursor = self.textEdit.textCursor()
        cursor.movePosition(QtGui.QTextCursor.End)
        cursor.insertText(text)
        self.textEdit.setTextCursor(cursor)
        self.textEdit.ensureCursorVisible()



if __name__ == '__main__':
    app = QtGui.QApplication(sys.argv)
    ex = Example()
    ex.show()
    sys.exit(app.exec_())
```

## 6. 文件打开与保存对话框

1. 选择文件

   ```
   my_file_path = QFileDialog.getOpenFileName(self, u'选择config.json', './', '*.json')
   ```

2. 选择文件夹

   ```
   dir_path = QFileDialog.getExistingDirectory(self, "choose exsiting directory", "./")
   ```

3. 保存为文件

   ```
   file_path = QFileDialog.getSaveFileName(self, "save file", "../","json(*.json);;all files(*.*)")
   ```

标签: [pyqt python GUI](https://www.cnblogs.com/aloe-n/tag/pyqt python GUI/)