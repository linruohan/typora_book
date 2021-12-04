## PyQt5 设置窗口居中显示示例
问题：窗口控件尺寸太大会不在屏幕中心，所以要自定义窗口位置
核心在方法 center() 中，获取桌面屏幕的尺寸，再移动到屏幕中心
```python
class SYSTempInterface(QtWidgets.QWidget, Ui_sysTemp):
    """  一个窗口控件模块 """
    def __init__(self):
        super(SYSTempInterface, self).__init__()
        self.setupUi(self)
        self.ui = ''
        self.center()

    def center(self):
        screen = QDesktopWidget().screenGeometry()
        size = self.geometry()
        self.move((screen.width() - size.width()) / 2,
                  (screen.height() - size.height()) / 2)

    def return_main(self):
        self.hide()
        self.ui = MainInterface()
        self.ui.show()
```    


## 第二种方法
 
这个程序是将一个窗口显示在屏幕的中心。
作者：我的世界你曾经来过
博客：http://blog.csdn.net/weiaitaowang
最后编辑：2016年7月30日
```python
import sys
from PyQt5.QtWidgets import QApplication, QWidget, QDesktopWidget
 
class Example(QWidget):
 
 def __init__(self):
  super().__init__()
  self.initUI()
 def initUI(self):
  self.setGeometry(300, 300, 300, 220)
  self.center()
  self.setWindowTitle('窗口居中')  
  self.show()
 def center(self):
  qr = self.frameGeometry()
  cp = QDesktopWidget().availableGeometry().center()
  qr.moveCenter(cp)
  self.move(qr.topLeft())
 
if __name__ == '__main__':
 app = QApplication(sys.argv)
 ex = Example()
 sys.exit(app.exec_())
 ```