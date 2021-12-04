## Python OpenCV使用摄像头捕获视频

我们知道，OpenCV是一款强大的跨平台的计算机视觉库，使用它能完成我们对于==图像和视频处理==的很多功能，今天，我们使用OpenCV来==捕获计算机摄像头==的视频。

我们知道，视频是将一系列==静态影像==以电信号的方式加以捕捉、记录、处理、储存、传送与重现的各种技术。OpenCV恰好提供了对于视频的**捕捉、记录、处理、存储、传送**等功能。这一系列动作通过cv2.VideoCapture类来实现。它的原理基本上就是通过获取视频中的一系列祯来实现对于视频的各种操作。

要进行视频处理捕获视频是前提

```python
#!/usr/bin/env python
# coding:utf-8
import numpy as np
import cv2

capture = cv2.VideoCapture(0) # 0 系统摄像头 1 计算机外置摄像头，比如usb连接的摄像头
# 使用一个循环表示持续获取摄像头数据
while True:
    ret, frame = capture.read() #ret 是否获取到了图像数据,验证获取到的视频是否到达结尾部分;frame一帧的图像数据
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    cv2.imshow('frame', gray)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

capture.release()
cv2.destroyAllWindows()
```

前面的导入模块内容不用解释了

**capture = cv2.VideoCapture(0)**

这一句表示调用计算机内置摄像头来获取视频，如果传入参数为1时，表示调用计算机外置摄像头，比如usb连接的摄像头等。VideoCapture对象也可以传入视频文件地址。

**ret, frame = capture.read()**

这里使用一个循环表示持续获取摄像头数据，VideoCapture对象的read()方法返回两个值。

**第一个值**一般为ret，它是一个布尔值，表示是否获取到了图像数据，如果获取成功返回True，获取失败返回False，这一句后可以判断ret是否为True，如果为True则向下执行，False则执行相应的操作，这样可以使得我们的应用程序更加健壮。它还有一个功能就是验证获取到的视频是否到达结尾部分。

**第二个值**表示获取到的一帧的图像数据。下一步我们将这个图像数据直接转化为灰度图像进行了处理。

后面的代码就不用解释，关于OpenCV的处理键盘事件方法可以参照我的另一篇博文（使用Python OpenCV处理图像之详解使用OpenCV处理键盘鼠标事件）。

由于我的电脑摄像头被我拆掉了，这里就不演示捕获的具体内容了，感兴趣的朋友们自己测试下上述代码吧。

好了，今天的内容就到这里了，后续我们会推出关于视频处理的一些应用。欢迎大家持续关注，感兴趣的朋友们要多练哦。

![img](D:\Typora_pic\5fdf8db1cb1349546b97adee7dce315dd0094a30.jpeg)

**转载请注明出处，百家号：Python高手养成**