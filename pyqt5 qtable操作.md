# [Qtablewidget操作,设置表头,填充内容,删除行,获取行内其它元素](https://www.cnblogs.com/aloe-n/p/8721590.html)

# PyQt表格操作

## 1 qtablewidget添加表头

## 2 qtablewidget添加Button

## 3 qtablewidget添加内容

## 4 qtablewidget获取行内其它元素

## 5 qtablewidget删除行

![img](https://images2018.cnblogs.com/blog/1176578/201804/1176578-20180405113408380-1545593213.gif)

## 6 代码示例

**UI文件:UI_main.py**

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
        MainWindow.resize(762, 512)
        self.centralWidget = QtGui.QWidget(MainWindow)
        self.centralWidget.setObjectName(_fromUtf8("centralWidget"))
        self.gridLayout = QtGui.QGridLayout(self.centralWidget)
        self.gridLayout.setObjectName(_fromUtf8("gridLayout"))
        self.tableWidget = QtGui.QTableWidget(self.centralWidget)
        self.tableWidget.setRowCount(10)
        self.tableWidget.setColumnCount(7)
        self.tableWidget.setObjectName(_fromUtf8("tableWidget"))
        self.gridLayout.addWidget(self.tableWidget, 0, 0, 1, 1)
        MainWindow.setCentralWidget(self.centralWidget)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow", None))
```

**业务代码文件**:main.py

```
# -*- coding: utf-8 -*-
from PyQt4.QtGui import QMainWindow, QColor, QPushButton, QTableWidgetItem
from PyQt4.QtCore import QTextCodec, Qt
from Ui_main import Ui_MainWindow
from PyQt4 import QtGui


class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self, parent=None):
        QMainWindow.__init__(self, parent)
        # 加载UI
        self.setupUi(self)
        # 填充内容
        self.set_content()

    # 设置表头
    def set_table_header(self, header_list):
        """设置table表头"""
        self.tableWidget.clear()
        self.tableWidget.setColumnCount(len(header_list))
        self.tableWidget.setRowCount(20)
        # 表格展示
        self.tableWidget.setHorizontalHeaderLabels(header_list)
        # 设置最后一列自动拉伸
        self.tableWidget.horizontalHeader().setStretchLastSection(True)
        self.tableWidget.verticalHeader().setVisible(True)
        # 设置默认排序
        self.tableWidget.sortItems(0, Qt.AscendingOrder)
        # 设置表头颜色
        for x in range(self.tableWidget.columnCount()):
            headItem = self.tableWidget.horizontalHeaderItem(x)
            headItem.setTextColor(QColor(200, 111, 30))
            headItem.setBackgroundColor(QColor(200, 200, 200))

    def set_content(self):
        """填充数据"""
        data = [
            {'id': "1", 'desc': '第一条数据!'},
            {'id': "2", 'desc': '第二条数据!'},
            {'id': "3", 'desc': '第三条数据!'},
            {'id': "4", 'desc': '第四条数据!'}
        ]
        self.set_table_header(['删除', '启用', '禁用', 'id', '描述'])
        for row, i in enumerate(data):
            btn_del = QPushButton("删除")
            btn_del.id = i["id"]
            btn_del.clicked.connect(self.delete_slot)

            btn_inact = QPushButton("禁用")
            btn_inact.id = i["id"]
            btn_inact.clicked.connect(self.inactive_slot)

            btn_act = QPushButton("启用")
            btn_act.id = i["id"]
            btn_act.clicked.connect(self.active_slot)

            id_item = QTableWidgetItem(i["id"])
            btn_del.item = id_item

            self.tableWidget.setCellWidget(row, 0, btn_del)
            self.tableWidget.setCellWidget(row, 1, btn_inact)
            self.tableWidget.setCellWidget(row, 2, btn_act)
            self.tableWidget.setItem(row, 3, id_item)
            self.tableWidget.setItem(row, 4, QTableWidgetItem(i["desc"]))

    def delete_slot(self):
        sender = self.sender()
        # 删除行,关键点
        self.tableWidget.removeRow(self.tableWidget.row(sender.item))

    def inactive_slot(self):
        sender = self.sender()
        sender.setEnabled(False)
        for btn in self.tableWidget.findChildren(QPushButton):
            if btn.id == sender.id and btn.text() == "启用":
                btn.setEnabled(True)

    def active_slot(self):
        sender = self.sender()
        sender.setEnabled(False)
        for btn in self.tableWidget.findChildren(QPushButton):
            if btn.id == sender.id and btn.text() == "禁用":
                btn.setEnabled(True)


if __name__ == "__main__":
    import sys
    reload(sys)
    sys.setdefaultencoding('utf-8')
    QTextCodec.setCodecForCStrings(QTextCodec.codecForName("utf-8"))
    app = QtGui.QApplication(sys.argv)
    ui = MainWindow()
    ui.show()
    sys.exit(app.exec_())
```