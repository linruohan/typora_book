## SL4A、QPython学习笔记 顶 原

[![泊松](D:\Typora_pic\1468102_50.png) 泊松](https://my.oschina.net/u/1468102) 发布于 2014/03/16 17:54

[QPython;](https://my.oschina.net/u/1468102?q=QPython;)[sl4a;](https://my.oschina.net/u/1468102?q=sl4a;)[Python;](https://my.oschina.net/u/1468102?q=Python;)[android;](https://my.oschina.net/u/1468102?q=android;)[kivy;](https://my.oschina.net/u/1468102?q=kivy;)[compass;](https://my.oschina.net/u/1468102?q=compass;)[webview](https://my.oschina.net/u/1468102?q=webview)

耐着性子钻研了一下sl4a与QPython之类，取得了些经验，汇报如下：

本文使用的apk安装包如下: QPython: QPython70.apk；sl4a+Python：sl4a_r6.apk；PythonForAndroid_r4.apk。安装与使用方法十分简单，网上参考很多，本文不再重复安装方法与HelloWorld之类。

I. sl4a+Python

\1. 重要参考资料：

(1)[Pro Android Python with SL4A(PDF)](http://ishare.iask.sina.com.cn/f/23302234.html)(2) [SL4A API HELP](http://www.mithril.com.au/android/doc/)；(3) 如何使用Webview：[Webviews with SL4A: A Call and Two Hooks](http://www.pythoncentral.io/python-for-android-using-webviews-sl4a/)

\2. 以下一例，演示如何通过sl4a api取得Gps与罗盘信息，相关技术资料详见详见参考资料(2)中LocationFacade;SensorManagerFacade章节

```
# -*- coding: utf-8 -*-
import android
import time
from math import radians
droid = android.Android()
droid.startSensingTimed(1, 250)
droid.startLocating()
while 1:
    gpsdata = droid.readLocation().result
    s6data = droid.sensorsReadOrientation().result
    if len(gpsdata)>0:
        print gpsdata['gps']['bearing'] #取得Gps导向(bearing)(角度)
    if len(s6data)>0:
        print s6data[0] #取得罗盘方位角(azimuth)(弧度)
    time.sleep(0.5)
droid.stopLocating()
droid.stopSensing()
```



\3. 关于使用webview做UI，请参考资料(1)与(3)，如下提供一个例子（简单指北针），演示Python后端如何与Webview通信，不过此例仅含Python向Webview单向发送数据：webview作为前端，用svg做了一个简单的指北针，每0.5秒根据Python后端读取的方位角数据更新一次。

```
import android
import time
from math import radians
droid = android.Android()
droid.webViewShow('file:///sdcard/sl4a/scripts/compassSVGDrawing.html')
droid.startSensingTimed(1, 250)
while 1:
    s6data = droid.sensorsReadOrientation().result
    if len(s6data)>0:
        try:
            az = s6data[0]
            droid.eventPost('dataout', str(az))
        except:
            pass      
       
    time.sleep(0.5)
droid.stopSensing()

# compassSVGDrawing.html
'''
<!DOCTYPE html>
<html>
<body bgcolor="#000000">
<svg width="100%" height="100%" xmlns="http://www.w3.org/2000/svg">
<circle cx="45" cy="45" r="40" stroke="green" stroke-width="3" fill="black"/>
<line id="azim" x1="45" y1="5" x2="45" y2="45" stroke="green"
stroke-width="3"/>
</svg>
<script>
var droid = new Android(); #注意此行代码与之后的Callback是Python后端与Webview通信的关键技术细节
droid.registerCallback('dataout', function(e) { 
var az = String(-1*180 * parseFloat(e.data) / Math.PI);
var cmd = "rotate(" + az + " 45 45)"
document.getElementById("azim").setAttribute("transform", cmd);
});
</script>
</body>
</html>
'''
```





\4. SL4A与蓝牙

手头有个蓝牙GPS，就拿来操练了一下，尝试了一下读取蓝牙设备，没想到在我的华硕FonePad上实验很顺利，效果相当不错。

```
import android
import time
droid = android.Android()
droid.toggleBluetoothState(True)
result = droid.bluetoothConnect('00001101-0000-1000-8000-00805F9B34FB', '00:02:76:C9:92:44')
#SSP之默认UUID与蓝牙设备物理地址
print repr(result)
if result:
    while True:
        message = droid.bluetoothReadLine().result
        print message
droid.toggleBluetoothState(False)
```





II. Qpython

QPython安装仅需一个apk，界面也比sl4a丰富一些，内容已然相当成熟，已经整合了不少好东西，我尝试了其中的androidhelper(基于sl4a)、kivy(出色的图形库)、bottle(精悍的web架构)。

\1. 先详细说说QPython与sl4a+Python方案的区别：

(1)QPython整合了sl4a api，如下是QPython调用sl4a api的代码：

```
import androidhelper
droid = androidhelper.Android()
```



(2)需强调的一点，QPython目前没有实现sl4a与webview的内在通信机制(上文中的指北针代码不适用于QPython)，我认为这是个不足，不过QPython能够制作功能相当的web app，且可以使用kivy制作精良的图形界面、游戏之类的，这是其优势所在。

(3)QPython内置了bottle web架构，也可以从QPypi安装其他一些流行的web工具，对于制作web app、服务器之类而言肯定更有优势。

(4) 两者对webview的调用功能有别，细节尚不清楚，兼容性有差异，在我的平板上，QPython在支持svg方面与sla4相比较表现出一些差异，不支持 width ="100%"这样的设置，使用sl4a时却支持。若使用sl4a调用Webview显示含canvas的网页，其画质十分粗糙。

\2. kivy

据我的感受，QPython中的kivy真是个好东西，做出来的界面很漂亮，很稳定，就是貌似不太好学。鉴于我还没有一知半解，贴几个对我有所启发的代码和我自己做的一个例子，均在Android设备上测试通过：

(1) 使用StackLayout：

注意#1，这部分使用的语言是kivy语言，对kivy核心元素，即widget，安排布局、设定属性。注意如下代码中<ScreenUI>(#2、#4)，其性质是一个用户定义的widget，继承StackLayout，如果无需对StackLayout 编程，则不需要在kivy语言中与Python中专门定义<ScreenUI>，使用StackLayout就可以。ScreenUI这个widget也就成为了一个root，可以用来控制widget的行为与属性(#3、#5)。

```
from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.label import Label
from kivy.lang import Builder
from kivy.uix.textinput import TextInput
from kivy.uix.stacklayout import StackLayout
from kivy.uix.button import Button
Builder.load_string("""     #1
<ScreenUI>:                 #2
    orientation: 'lr-bt'
    Button:
        text: root.text     #3
        size: 100, 100
        size_hint: None, None
    Button:
        text: 'Button 2'
        size_hint: None, None
        size: 200, 100""")
class ScreenUI(StackLayout):  #4
    text = "Button 1"         #5
class WidgetApp(App):
    def build(self):
        app = ScreenUI()
        return app
if __name__ == '__main__':
    WidgetApp().run()
```



(2) 旋转图片：尝试旋转三张重叠图片，角度可控，将角度显示在一个标签

```
from kivy.app import App
from kivy.uix.image import Image
from kivy.lang import Builder
from kivy.properties import NumericProperty
from kivy.uix.floatlayout import FloatLayout
Builder.load_string('''
[Title@Label]
    pos_hint: {'center_x': .5, 'y': .3}
    text: ctx.text
    font_size: 16
<RotationWid>:
    FloatLayout:
        Title:
            text: root.message
        Image:
            source: 'kivy.png'
            canvas.before:
                PushMatrix
                Rotate:
                    angle: root.angle
                    origin: self.center
            canvas.after:
                PopMatrix
        Image:
            source: 'Red.png'
            canvas.before:
                PushMatrix
                Rotate:
                    angle: root.angle
                    origin: self.center
            canvas.after:
                PopMatrix
        Image:
            source: 'tinyCompass.png'
            canvas.before:
                PushMatrix
                Rotate:
                    angle: root.angle
                    origin: self.center
            canvas.after:
                PopMatrix
''')
class RotationWid(FloatLayout):
    angle = NumericProperty(-45)
    message = '45 degrees'
   
class RotationApp(App):
    def build(self):
        return RotationWid()
RotationApp().run()
```



(3)通过旋转图片实现的指北针

```
from kivy.app import App
from kivy.uix.image import Image
from kivy.clock import Clock
from kivy.lang import Builder
from kivy.properties import NumericProperty
from math import pi
import androidhelper
import time
droid = androidhelper.Android()
droid.startSensingTimed(1, 250)
Builder.load_string('''
<RotateCompass>:
    source: 'Red.png'
    size: 256,256
    canvas.before:
        PushMatrix
        Rotate:
            angle: root.angle
            origin: self.center
    canvas.after:
        PopMatrix
''')
class RotateCompass(Image):
    angle = NumericProperty(0)
    def __init__(self, **kwargs):
        super(RotateCompass,self).__init__(**kwargs)
        Clock.schedule_interval(self.my_callback, 1) 
        #clock时间处理，周期为1秒，动作定义在my_callback中，周期性给angle赋值
    def my_callback(self,dt):
        s6data = droid.sensorsReadOrientation().result
        if len(s6data)>0:
            self.angle = 180 * s6data[0] / pi 
class RotationApp(App):
    def build(self):
        return RotateCompass()
RotationApp().run()
droid.stopSensing()
```



\3. QPython Web App

QPython只给了一个简单的例子，资料少的可怜。尝试了一下，也整出一罗盘来。用XMLHttpRequest与长轮询(long polling)这个解决方法实现网页客户端与服务器的通信。

```
#qpy:webapp:Compass_Long_Polling 
#qpy:fullscreen
#qpy://localhost:8080/ #此行必须
"""
This is a sample for qpython webapp
"""

from bottle import route, run
import androidhelper
import signal, os
import time

code = '''
<html>
<body>
<center>
<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg">
<circle cx="100" cy="100" r="80" stroke="navy" stroke-width="5" fill="none"/>
<line id="azim" x1="100" y1="20" x2="100" y2="100" stroke="navy"
stroke-width="5"/>
<text id="degree" x="0" y="20" stroke="navy">90</text>
</svg><br>
<button onclick="shutdown()">
shut down</button>
</center>
<script>
var az;
var deg;
var url = "http://localhost:8080/"
var xhr;
xhr=new XMLHttpRequest();
xhr.onreadystatechange=function()
{
    if (xhr.readyState==4)
    {
    if (xhr.status==200)
    {
    az=parseFloat(xhr.responseText);
    if(az>=0){
    deg = az*180/Math.PI;
    }else{
    deg = 360+az*180/Math.PI;
    }
    deg=String(deg.toFixed(2));
    az = String(-180 * az / Math.PI);
    var cmd = "rotate(" + az + " 100 100)";
    document.getElementById("degree").textContent="^"+deg;
    document.getElementById("azim").setAttribute("transform", cmd);
    }
    xhr.open("GET",url+"azimuth",true);
    xhr.send();
    }
}
xhr.open("GET",url+"azimuth",true);
xhr.send();

function shutdown()
{
var xhr = new XMLHttpRequest();
xhr.open("GET", url+"shutdown", false);
xhr.send(null);
}
</script>
</body>
</html>
'''

droid = androidhelper.Android()
droid.startSensingTimed(1, 250)

@route('/')
def index():
    return code

@route('/azimuth')
def azimuth():
    time.sleep(0.3)
    s6data = droid.sensorsReadOrientation().result
    if len(s6data)>0:
        return str(s6data[0])

@route("/shutdown")
def shutdown():
    droid.stopSensing()
    os.kill(os.getpid(), signal.SIGTERM)

run(host='localhost', port=8080)
```



\4. jQuery Mobile

尝试了一下jQuery Mobile，也就是拷贝到某个子目录后观察了一下例子，在QPython中使用没问题，暂没用它干什么，不多说了。