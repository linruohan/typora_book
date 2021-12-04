# [PyQt文本框搜索功能](https://www.cnblogs.com/aloe-n/p/8175757.html)

为PyQt文本框添加搜索功能,效果如下:

![img](https://images2017.cnblogs.com/blog/1176578/201801/1176578-20180102093735190-369504222.gif)

## 1.UI定义如下

Ui_main.py

```python
from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName(_fromUtf8("MainWindow"))
        MainWindow.resize(800, 600)
        self.centralWidget = QtGui.QWidget(MainWindow)
        self.centralWidget.setObjectName(_fromUtf8("centralWidget"))
        self.verticalLayout = QtGui.QVBoxLayout(self.centralWidget)
        self.verticalLayout.setObjectName(_fromUtf8("verticalLayout"))
        self.horizontalLayout = QtGui.QHBoxLayout()
        self.horizontalLayout.setObjectName(_fromUtf8("horizontalLayout"))
        self.search_edit = QtGui.QLineEdit(self.centralWidget)
        self.search_edit.setObjectName(_fromUtf8("search_edit"))
        self.horizontalLayout.addWidget(self.search_edit)
        self.search_btn = QtGui.QPushButton(self.centralWidget)
        self.search_btn.setObjectName(_fromUtf8("search_btn"))
        self.horizontalLayout.addWidget(self.search_btn)
        self.search_res = QtGui.QLabel(self.centralWidget)
        self.search_res.setObjectName(_fromUtf8("search_res"))
        self.horizontalLayout.addWidget(self.search_res)
        spacerItem = QtGui.QSpacerItem(40, 20, QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Minimum)
        self.horizontalLayout.addItem(spacerItem)
        self.verticalLayout.addLayout(self.horizontalLayout)
        self.textBrowser = QtGui.QTextBrowser(self.centralWidget)
        self.textBrowser.setObjectName(_fromUtf8("textBrowser"))
        self.verticalLayout.addWidget(self.textBrowser)
        MainWindow.setCentralWidget(self.centralWidget)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow", None))
        self.search_btn.setText(_translate("MainWindow", "搜索", None))
        self.search_res.setText(_translate("MainWindow", "0/0", None))
```

## 2.main.py文件如下

```python
# coding=utf-8

from PyQt4.QtGui import QMainWindow, QApplication, QTextCursor
from PyQt4.QtCore import QTextCodec
import sys
from Ui_main import Ui_MainWindow

"""初始化QT编码设置"""
reload(sys)
sys.setdefaultencoding('utf-8')
QTextCodec.setCodecForCStrings(QTextCodec.codecForName("utf-8"))


def Qstring2Str(qStr):
    """转换Qstring类型为str类型"""
    return unicode(qStr.toUtf8(), 'utf-8', 'ignore')


class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self, parent=None):
        QMainWindow.__init__(self, parent)
        self.setupUi(self)
    
        # 文本框
        self.textBrowser.setText("这是测试文字...测试,测试,测试,一共多少个测试?")
        # 文本框内容变化重设被搜索内容
        self.textBrowser.textChanged.connect(self.reset_search_content)
        # 点击按钮开始搜索
        self.search_btn.clicked.connect(self.search)

        # 搜索相关项
        self.search_content = None
        self.search_key = None
        self.search_count = 0
        self.search_current = 0

    def select(self, start, length):
        """选中文字,高亮显示"""
        cur = QTextCursor(self.textBrowser.textCursor())
        cur.setPosition(start)
        cur.setPosition(start + length, QTextCursor.KeepAnchor)
        self.textBrowser.setTextCursor(cur)

    def reset_search_content(self):
        """改变待搜索内容"""
        self.search_content = None
        self.search_count = 0
        self.search_current = 0

    def search(self):
        """搜索"""
        key_word = Qstring2Str(self.search_edit.text())
        if key_word != self.search_key:
            self.search_key = key_word
            self.search_count = 0
            self.search_current = 0
        if not self.search_content:
            self.search_content = Qstring2Str(self.textBrowser.toPlainText())
        if not self.search_count:
            self.search_count = self.search_content.count(key_word)
            if self.search_count != 0:
                start = self.search_content.index(key_word)
                self.select(start, len(key_word))
                self.search_current += 1
        else:
            if self.search_current < self.search_count:
                start = self.search_content.find(key_word, self.textBrowser.textCursor().position())
                if start != -1:
                    self.select(start, len(key_word))
                    self.search_current += 1
            else:
                self.search_count = 0
                self.search_current = 0
                self.search()
        self.textBrowser.setFocus()
        self.search_res.setText("{}/{}".format(self.search_current, self.search_count))


if __name__ == '__main__':
    app = QApplication(sys.argv)
    ui = MainWindow()
    ui.show()
    sys.exit(app.exec_())
```

标签: [Pyqt 搜索 Python](https://www.cnblogs.com/aloe-n/tag/Pyqt 搜索 Python/)