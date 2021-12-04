# pyqt5与前端进行交互

[toc]



基本思路就是在pyqt界面中直接加载html文件，并与html进行交互，参考的文件我已经找不到了，这里我放三个编写好的例子，里面也做了写解释说明，可根据这些例子进行测试，使用。

## 案例一：

### 后端部分：

```python
#! /usr/bin/env
# -*- coding: utf-8 -*-
# webview.py
 
 
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import QObject, pyqtSlot, QUrl
from PyQt5.QtWebChannel import QWebChannel
from PyQt5.QtWebEngineWidgets import QWebEngineView
import sys
 
 
class Print(QObject):
    # pyqtSlot，中文网络上大多称其为槽。作用是接收网页发起的信号
    @pyqtSlot(str, result=str)
    def print(self, content):
        print('输出文本：',content)  # 对接收到的内容进行处理，比如调用打印机进行打印等等。此处略去，只在bash中显示接收到的消息
        return content
 
 
if __name__ == '__main__':
    app = QApplication(sys.argv)
    browser = QWebEngineView()  # 新增一个浏览器引擎
    browser.setWindowTitle('QWebChannel交互Demo')
    browser.resize(900, 600)
    channel = QWebChannel()  # 增加一个通信中需要用到的频道
    printer = Print()  # 通信过程中需要使用到的功能类
    channel.registerObject('printer', printer)  # 将功能类注册到频道中，注册名可以任意，但将在网页中作为标识
    browser.page().setWebChannel(channel)  # 在浏览器中设置该频道
    url_string = "file:///D:/TY_75Stability/mxh_work/pyqt_work/demo13.html"  # 内置的网页地址，此处我采用的是本地的。远程同样可以使用。
    browser.load(QUrl(url_string))
    browser.show()
    sys.exit(app.exec_())
```

### <!-- index.html -->

```
 
<!-- index.html -->
<!DOCTYPE html>
<html>
<title>QWebChannel交互Demo</title>
<body>
<button onclick="sendMes()">发送消息</button>
<p id="mes"></p>
<!-- 引入qwebchannel.js，才能与QWebEngineView进行交互 -->
<script type="text/javascript" src="qwebchannel.js"></script>
<script>
    window.onload = function() {
        new QWebChannel(qt.webChannelTransport, function (channel) {
            window.printer= channel.objects.printer;  // 此处channel.objects.printer中的printer就是上文提到的功能类注册的标识名
        });
    };
    function sendMes() {  // 调用python端的功能类的方法执行操作
        printer.print('你收到一条网页发送的消息！')
    }
</script>
</body>
</html>
```

## 案例二：
### 后端部分：

```python
import sys
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import QObject, pyqtSlot, QUrl
from PyQt5.QtWebChannel import QWebChannel
from PyQt5.QtWebEngineWidgets import QWebEngineView
 
 
class CallHandler(QObject):
    @pyqtSlot(result=str)
    def myHello(self):
        view.page().runJavaScript('uptext("hello, Pythongjhkkkk");')
        print('call received')
        return 'hello, Python'
 
 
    @pyqtSlot(str, result=str)
    def myTest(self, test):
        print('test is',test)
        return '返回前端结果'
 
 
if __name__ == '__main__':
    app = QApplication(sys.argv)
    view = QWebEngineView()
    channel = QWebChannel()
    handler = CallHandler()
    channel.registerObject('pyjs', handler)##前者是str，后者是一个QObject（里面放着需要调用的函数）
    view.page().setWebChannel(channel)
    url_string = "file:///D:/TY_75Stability/mxh_work/pyqt_work/demo15.html"
    view.load(QUrl(url_string))
    view.show()
    sys.exit(app.exec_())
```

### html
```
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <script type="text/javascript" src="qwebchannel.js"></script>
    <title>QWebChannel测试</title>
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.1.1/jquery.min.js"></script>
    <script>
        window.onload = function () {
            new QWebChannel(qt.webChannelTransport, function (channel) {
                window.pyjs = channel.objects.pyjs;    //把对象赋值到JS中
//                pyjs.myHello(alert);
                pyjs.myHello(function (res) {
                    alert(res)
                })
            });
        }
    </script>
</head>
<body>
<div id="test">
    this is test !
</div>
<div onclick="qt5test();">测试</div>
<button class = 'btn'>点击</button>

<script>
    function qt5test() {
       pyjs.myTest('这是测试传参的',function (res) {
           alert('sssss')
            alert(res);
        });
    }
//    pyqt返回来的值必须写一个方法接收，如上面方法所示
//    js调用Python函数时，传递给python的参数默认为构造函数，如果想传递自定义参数，随便传，只是在参数列表的最后，
//    一定要加上回调函数，自定义参数需要在python函数的形参列表中声明，回调函数则是默认的，不需要声明。
     $('.btn').click(function () {
        var con =pyjs.myTest('mxh_connncon')
        alert(typeof(con),con)
    })

    function uptext(msg) {
        document.getElementById('test').innerHTML=msg;
    }

</script>
</body>
</html>
```
## 案例三：
这个案例后端有两个文件，一个是qt_designer涉及的.py，一个是主界面文件，

### 后端主文件：

```python
import os
import sys

from PyQt5.QtCore import QUrl, pyqtSlot, QObject, pyqtSignal
from PyQt5.QtWebChannel import QWebChannel
from PyQt5.QtWidgets import QMainWindow, QApplication

from demo14_1 import Ui_MainWindow


class TInteractObj(QObject):
    """
    一个槽函数供js调用(内部最终将js的调用转化为了信号),
    一个信号供js绑定,
    这个一个交互对象最基本的组成部分.
    """

    # 定义信号,该信号会在js中绑定一个js方法.
    sig_send_to_js = pyqtSignal(str)
     
    def __init__(self, parent=None):
        super().__init__(parent)
        # 交互对象接收到js调用后执行的回调函数.
        self.receive_str_from_js_callback = None
     
    # str表示接收str类型的信号,信号是从js发出的.可以出传递的参数类型有很多种：str、int、list、object、float、tuple、dict等等
    @pyqtSlot(str)
    def receive_str_from_js(self, str):
        print('接受消息str is ',str)
        self.receive_str_from_js_callback(str)

 


class MainWindow(QMainWindow, Ui_MainWindow):
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.setupUi(self)

        self.index = (os.path.split(os.path.realpath(__file__))[0]) + "/demo14.html"
        self.webview.load(QUrl.fromLocalFile(self.index))
        self.init_channel()
     
    def init_channel(self):
        """
        为webview绑定交互对象
        """
        self.interact_obj = TInteractObj(self)
        self.interact_obj.receive_str_from_js_callback = self.receive_data
     
        channel = QWebChannel(self.webview.page())
        # interact_obj 为交互对象的名字,js中使用.
        channel.registerObject("interact_obj", self.interact_obj)
     
        self.webview.page().setWebChannel(channel)
     
    def receive_data(self, data):
        self.textBrowser.setText(data)
     
    @pyqtSlot()
    def on_pushButton_clicked(self):
        if not self.textBrowser.toPlainText():
            return
        # 这个信号是在js中和一个js方法绑定的,所以发射这个信号时会执行对应的js方法.
        print('pyqt发送消息')
        self.interact_obj.sig_send_to_js.emit(self.textBrowser.toPlainText())
        self.textBrowser.clear()

 


if __name__ == '__main__':
    app = QApplication(sys.argv)
    ui = MainWindow()
    ui.show()
    sys.exit(app.exec_())
```
### 后端界面文件：

```python
from PyQt5.QtWebEngineWidgets import QWebEngineView
from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(800, 570)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.gridLayout = QtWidgets.QGridLayout(self.centralwidget)
        self.gridLayout.setObjectName("gridLayout")
        self.textBrowser = QtWidgets.QTextBrowser(self.centralwidget)
        self.textBrowser.setObjectName("textBrowser")
        self.textBrowser.setReadOnly(False)
        self.gridLayout.addWidget(self.textBrowser, 0, 0, 1, 1)
        self.pushButton = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton.setObjectName("pushButton")
        self.gridLayout.addWidget(self.pushButton, 1, 0, 1, 1)
        self.webview = QWebEngineView(self.centralwidget)
        self.webview.setObjectName("webview")
        self.webview.setMinimumWidth(400)
        self.gridLayout.addWidget(self.webview, 0, 1, 2, 1)
        MainWindow.setCentralWidget(self.centralwidget)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)
     
    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.pushButton.setText(_translate("MainWindow", "同步到web"))
```
### 前端界面：

```html
<!DOCTYPE html>
<head>
    <meta charset="utf-8"/>
    <title>QWebChannel测试</title>
    <!--引入交互js-->
    <script type="text/javascript" src="qwebchannel.js"></script>
    <style type="text/css">
        html {
            height: 100%;
            width: 100%;
        }

        #send {
            width: 90px;
            margin: 0;
        }
     
        #output {
            width: 100%;
            height: 500px;
        }
    </style>
    <!--业务js-->
    <script type="text/javascript">
        window.onload = function () {
            new QWebChannel(qt.webChannelTransport, function (channel) {
                // 获取qt中绑定的交互对象
                window.pyjs = channel.objects.interact_obj
     
                // js 绑定qt中的信号
                pyjs.sig_send_to_js.connect(function (str) {
                    
                    document.getElementById("output").value = str;
                });
     
                // 按钮点击事件
                document.getElementById("send").onclick = function () {
                    var text_area = document.getElementById("output");
                    if (!text_area.value) {
                        return;
                    }
                    // js调用qt中的方法
                    pyjs.receive_str_from_js(text_area.value)
                    text_area.value = "";
                }
            });
        }
    </script>
</head>

<body>
<textarea id="output">web控件内容!</textarea>
<input type="submit" id="send" value="同步到Qt" onclick="javascript:click();"/>
</body>
</html>
```
## 中间涉及到的qwebchannel.js文件：

```
/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
"use strict";

var QWebChannelMessageTypes = {
    signal: 1,
    propertyUpdate: 2,
    init: 3,
    idle: 4,
    debug: 5,
    invokeMethod: 6,
    connectToSignal: 7,
    disconnectFromSignal: 8,
    setProperty: 9,
    response: 10,
};

var QWebChannel = function(transport, initCallback)
{
    if (typeof transport !== "object" || typeof transport.send !== "function") {
        console.error("The QWebChannel expects a transport object with a send function and onmessage callback property." +
                      " Given is: transport: " + typeof(transport) + ", transport.send: " + typeof(transport.send));
        return;
    }

    var channel = this;
    this.transport = transport;
     
    this.send = function(data)
    {
        if (typeof(data) !== "string") {
            data = JSON.stringify(data);
        }
        channel.transport.send(data);
    }
     
    this.transport.onmessage = function(message)
    {
        var data = message.data;
        if (typeof data === "string") {
            data = JSON.parse(data);
        }
        switch (data.type) {
            case QWebChannelMessageTypes.signal:
                channel.handleSignal(data);
                break;
            case QWebChannelMessageTypes.response:
                channel.handleResponse(data);
                break;
            case QWebChannelMessageTypes.propertyUpdate:
                channel.handlePropertyUpdate(data);
                break;
            default:
                console.error("invalid message received:", message.data);
                break;
        }
    }
     
    this.execCallbacks = {};
    this.execId = 0;
    this.exec = function(data, callback)
    {
        if (!callback) {
            // if no callback is given, send directly
            channel.send(data);
            return;
        }
        if (channel.execId === Number.MAX_VALUE) {
            // wrap
            channel.execId = Number.MIN_VALUE;
        }
        if (data.hasOwnProperty("id")) {
            console.error("Cannot exec message with property id: " + JSON.stringify(data));
            return;
        }
        data.id = channel.execId++;
        channel.execCallbacks[data.id] = callback;
        channel.send(data);
    };
     
    this.objects = {};
     
    this.handleSignal = function(message)
    {
        var object = channel.objects[message.object];
        if (object) {
            object.signalEmitted(message.signal, message.args);
        } else {
            console.warn("Unhandled signal: " + message.object + "::" + message.signal);
        }
    }
     
    this.handleResponse = function(message)
    {
        if (!message.hasOwnProperty("id")) {
            console.error("Invalid response message received: ", JSON.stringify(message));
            return;
        }
        channel.execCallbacks[message.id](message.data);
        delete channel.execCallbacks[message.id];
    }
     
    this.handlePropertyUpdate = function(message)
    {
        for (var i in message.data) {
            var data = message.data[i];
            var object = channel.objects[data.object];
            if (object) {
                object.propertyUpdate(data.signals, data.properties);
            } else {
                console.warn("Unhandled property update: " + data.object + "::" + data.signal);
            }
        }
        channel.exec({type: QWebChannelMessageTypes.idle});
    }
     
    this.debug = function(message)
    {
        channel.send({type: QWebChannelMessageTypes.debug, data: message});
    };
     
    channel.exec({type: QWebChannelMessageTypes.init}, function(data) {
        for (var objectName in data) {
            var object = new QObject(objectName, data[objectName], channel);
        }
        // now unwrap properties, which might reference other registered objects
        for (var objectName in channel.objects) {
            channel.objects[objectName].unwrapProperties();
        }
        if (initCallback) {
            initCallback(channel);
        }
        channel.exec({type: QWebChannelMessageTypes.idle});
    });
};

function QObject(name, data, webChannel)
{
    this.__id__ = name;
    webChannel.objects[name] = this;

    // List of callbacks that get invoked upon signal emission
    this.__objectSignals__ = {};
     
    // Cache of all properties, updated when a notify signal is emitted
    this.__propertyCache__ = {};
     
    var object = this;
     
    // ----------------------------------------------------------------------
     
    this.unwrapQObject = function(response)
    {
        if (response instanceof Array) {
            // support list of objects
            var ret = new Array(response.length);
            for (var i = 0; i < response.length; ++i) {
                ret[i] = object.unwrapQObject(response[i]);
            }
            return ret;
        }
        if (!response
            || !response["__QObject*__"]
            || response.id === undefined) {
            return response;
        }
     
        var objectId = response.id;
        if (webChannel.objects[objectId])
            return webChannel.objects[objectId];
     
        if (!response.data) {
            console.error("Cannot unwrap unknown QObject " + objectId + " without data.");
            return;
        }
     
        var qObject = new QObject( objectId, response.data, webChannel );
        qObject.destroyed.connect(function() {
            if (webChannel.objects[objectId] === qObject) {
                delete webChannel.objects[objectId];
                // reset the now deleted QObject to an empty {} object
                // just assigning {} though would not have the desired effect, but the
                // below also ensures all external references will see the empty map
                // NOTE: this detour is necessary to workaround QTBUG-40021
                var propertyNames = [];
                for (var propertyName in qObject) {
                    propertyNames.push(propertyName);
                }
                for (var idx in propertyNames) {
                    delete qObject[propertyNames[idx]];
                }
            }
        });
        // here we are already initialized, and thus must directly unwrap the properties
        qObject.unwrapProperties();
        return qObject;
    }
     
    this.unwrapProperties = function()
    {
        for (var propertyIdx in object.__propertyCache__) {
            object.__propertyCache__[propertyIdx] = object.unwrapQObject(object.__propertyCache__[propertyIdx]);
        }
    }
     
    function addSignal(signalData, isPropertyNotifySignal)
    {
        var signalName = signalData[0];
        var signalIndex = signalData[1];
        object[signalName] = {
            connect: function(callback) {
                if (typeof(callback) !== "function") {
                    console.error("Bad callback given to connect to signal " + signalName);
                    return;
                }
     
                object.__objectSignals__[signalIndex] = object.__objectSignals__[signalIndex] || [];
                object.__objectSignals__[signalIndex].push(callback);
     
                if (!isPropertyNotifySignal && signalName !== "destroyed") {
                    // only required for "pure" signals, handled separately for properties in propertyUpdate
                    // also note that we always get notified about the destroyed signal
                    webChannel.exec({
                        type: QWebChannelMessageTypes.connectToSignal,
                        object: object.__id__,
                        signal: signalIndex
                    });
                }
            },
            disconnect: function(callback) {
                if (typeof(callback) !== "function") {
                    console.error("Bad callback given to disconnect from signal " + signalName);
                    return;
                }
                object.__objectSignals__[signalIndex] = object.__objectSignals__[signalIndex] || [];
                var idx = object.__objectSignals__[signalIndex].indexOf(callback);
                if (idx === -1) {
                    console.error("Cannot find connection of signal " + signalName + " to " + callback.name);
                    return;
                }
                object.__objectSignals__[signalIndex].splice(idx, 1);
                if (!isPropertyNotifySignal && object.__objectSignals__[signalIndex].length === 0) {
                    // only required for "pure" signals, handled separately for properties in propertyUpdate
                    webChannel.exec({
                        type: QWebChannelMessageTypes.disconnectFromSignal,
                        object: object.__id__,
                        signal: signalIndex
                    });
                }
            }
        };
    }
     
    /**
     * Invokes all callbacks for the given signalname. Also works for property notify callbacks.
     */
    function invokeSignalCallbacks(signalName, signalArgs)
    {
        var connections = object.__objectSignals__[signalName];
        if (connections) {
            connections.forEach(function(callback) {
                callback.apply(callback, signalArgs);
            });
        }
    }
     
    this.propertyUpdate = function(signals, propertyMap)
    {
        // update property cache
        for (var propertyIndex in propertyMap) {
            var propertyValue = propertyMap[propertyIndex];
            object.__propertyCache__[propertyIndex] = propertyValue;
        }
     
        for (var signalName in signals) {
            // Invoke all callbacks, as signalEmitted() does not. This ensures the
            // property cache is updated before the callbacks are invoked.
            invokeSignalCallbacks(signalName, signals[signalName]);
        }
    }
     
    this.signalEmitted = function(signalName, signalArgs)
    {
        invokeSignalCallbacks(signalName, signalArgs);
    }
     
    function addMethod(methodData)
    {
        var methodName = methodData[0];
        var methodIdx = methodData[1];
        object[methodName] = function() {
            var args = [];
            var callback;
            for (var i = 0; i < arguments.length; ++i) {
                if (typeof arguments[i] === "function")
                    callback = arguments[i];
                else
                    args.push(arguments[i]);
            }
     
            webChannel.exec({
                "type": QWebChannelMessageTypes.invokeMethod,
                "object": object.__id__,
                "method": methodIdx,
                "args": args
            }, function(response) {
                if (response !== undefined) {
                    var result = object.unwrapQObject(response);
                    if (callback) {
                        (callback)(result);
                    }
                }
            });
        };
    }
     
    function bindGetterSetter(propertyInfo)
    {
        var propertyIndex = propertyInfo[0];
        var propertyName = propertyInfo[1];
        var notifySignalData = propertyInfo[2];
        // initialize property cache with current value
        // NOTE: if this is an object, it is not directly unwrapped as it might
        // reference other QObject that we do not know yet
        object.__propertyCache__[propertyIndex] = propertyInfo[3];
     
        if (notifySignalData) {
            if (notifySignalData[0] === 1) {
                // signal name is optimized away, reconstruct the actual name
                notifySignalData[0] = propertyName + "Changed";
            }
            addSignal(notifySignalData, true);
        }
     
        Object.defineProperty(object, propertyName, {
            configurable: true,
            get: function () {
                var propertyValue = object.__propertyCache__[propertyIndex];
                if (propertyValue === undefined) {
                    // This shouldn't happen
                    console.warn("Undefined value in property cache for property \"" + propertyName + "\" in object " + object.__id__);
                }
     
                return propertyValue;
            },
            set: function(value) {
                if (value === undefined) {
                    console.warn("Property setter for " + propertyName + " called with undefined value!");
                    return;
                }
                object.__propertyCache__[propertyIndex] = value;
                webChannel.exec({
                    "type": QWebChannelMessageTypes.setProperty,
                    "object": object.__id__,
                    "property": propertyIndex,
                    "value": value
                });
            }
        });
     
    }
     
    // ----------------------------------------------------------------------
     
    data.methods.forEach(addMethod);
     
    data.properties.forEach(bindGetterSetter);
     
    data.signals.forEach(function(signal) { addSignal(signal, false); });
     
    for (var name in data.enums) {
        object[name] = data.enums[name];
    }
}

//required for use with nodejs
if (typeof module === 'object') {
    module.exports = {
        QWebChannel: QWebChannel
    };
}
```
------------------------------------------------
版权声明：本文为CSDN博主「褶皱的包子」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_37193537/java/article/details/90904331