PyQt5 QWebChannel实现python与Javascript双向通信

Pyqt项目需要嵌入百度地图API，需要PyQt5与Javascript进行数据交互；网上的资料少切新旧不一，出于人人为我，我为人人的目的写下记录，希望后来人少走弯路。（替代方案：==WebSocket实现通信，该技术比较新==，后面再玩）。

测试环境
==Python3.6、PyQt5.11==

功能描述

## js => Pyqt5:

运行程序，加载web页面后，点击上面的“点我”按钮，WEB则会调用 Web2PyQt5Value() 函数向python发送信息,类Myshared中的Web2PyQt5Value() 方法用于处理web发送来的信息，弹出消息对话框。

## PyQt5 => js：

程序运行5秒后，触发定时器函数 calljs(),通过page().runJavaScript(jscode)运行js代码——调用JS函数PyQt52WebValue()，弹出Alert警告框。

函数具体用法:https://www.riverbankcomputing.com/static/Docs/PyQt5/search.html

---

需三个文件： main.py、

```python
from PyQt5.QtWidgets import QWidget, QApplication, QMessageBox,QMainWindow
from PyQt5.QtWebEngineWidgets import QWebEngineView
from PyQt5.QtWebChannel import QWebChannel
from PyQt5.QtCore import pyqtSlot, Qt, QUrl, QFileInfo
from PyQt5.QtCore import pyqtProperty, pyqtSignal
 
class Myshared(QWidget):
 
    def __init__(self):
        super().__init__()
 
    def PyQt52WebValue(self):
        return "666"
 
    def Web2PyQt5Value(self, str):
        QMessageBox.information(self, "网页来的信息", str)
 
    value = pyqtProperty(str, fget=PyQt52WebValue, fset=Web2PyQt5Value)
 
class MainWindow(QMainWindow):
    def __init__(self):
        super(MainWindow, self).__init__()
        self.setWindowTitle('Javascript call PyQt5')
        self.setGeometry(5, 30, 1355, 730)
        self.browser = QWebEngineView()
        # 加载外部的web界面
        url = QUrl(QFileInfo("./web_file1.html").absoluteFilePath())
        self.browser.load(url)
        self.setCentralWidget(self.browser)
 
    def calljs(self):
        jscode = "PyQt52WebValue('你好web');"
        self.browser.page().runJavaScript(jscode)
 
import sys
from threading import Timer
if __name__ == '__main__':
    app = QApplication(sys.argv)
    win = MainWindow()
    channel = QWebChannel()
    shared = Myshared()
    channel.registerObject("con", shared)
    win.browser.page().setWebChannel(channel)
    t = Timer(5, win.calljs)
    t.start()
 
    win.show()
    sys.exit(app.exec_())
```
web_file1.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>web channel</title>
 
    <script src="qwebchannel.js"></script>
 
    <script language="JavaScript">
        function Web2PyQt5Value() {
            if ( window.con) {
                    window.con.value = "你好 Pyqt5";
                }
            }
            function PyQt52WebValue(value){
                alert(value);
            }
 
            document.addEventListener("DOMContentLoaded", function () {
                new QWebChannel( qt.webChannelTransport, function(channel) {
                    window.con = channel.objects.con;
                });
            });
 
    </script>
 
</head>
<body>
    <button οnclick="Web2PyQt5Value()">点我</button>
</body>
</html>
```

```
qwebchannel.js
```

获取地址：https://doc-snapshots.qt.io/qt5-5.9/qtwebengine-webenginewidgets-markdowneditor-resources-qwebchannel-js.html



### PyQt里js与python交互，js无法获取python返回值问题的解决办法
PyQt中通过QWebEngineView和QWebChannel可以实现程序内嵌浏览器效果
一般来说，核心代码如下：

```python
@pyqtSlot(str,result=str)
    def print(self,aaa):
        return aaa
```
```javascript
window.onload = function () {
   new QWebChannel(qt.webChannelTransport, function (channel) {
        window.pyjs = channel.objects.pyjs;
        alert(pyjs.myHello())//1. 这个不行
        pyjs.myHello(alert);// 2. 这个可以
        pyjs.print("sdafdsagf",alert)// 3. 这个可以
    });
}
```

那么问题来了，为什么js中代码1不行，代码2和3就可以
经过测试，我发现js调用Python函数时，传递给python的参数默认为构造函数，如果想传递自定义参数，随便传，只是在参数列表的最后，一定要加上回调函数，自定义参数需要在python函数的形参列表中声明，回调函数则是默认的，不需要声明。