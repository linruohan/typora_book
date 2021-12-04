## 用Python写个Metro风格的桌面程序

![img](F:\Typora_book\typora_pic\f1b877ad7ef30c4d6679ae6930706c13.jpeg)

DigiHacker

发布时间：18-10-0512:10

Python有很多GUI库，比如自带的tkinter, Qt, wxPython等, 还有基于OpenGL的Kivy。但是学习曲线都很高，要学习layout, 组件库，事件驱动等。现在有了electron的话，我们可以用Python写个后台服务，但还是要学习electron的API。搜了搜发现了eel这个库，可以直接用Python和一点html知识就可以创建桌面程序。

首先当然要`pip install eel,` 然后写个简单的python程序，初始化和启动eel



```python
import eel
eel.init()
```



<img src="d:\typora_pic\u=3857751769,1900717845&amp;fm=173&amp;app=25&amp;f=JPEG.jpg" alt="img" style="zoom:200%;" />

init方法会读取web目录下的文件，ssl.expose会暴露下面的方法给前端，javascript就可以通过eel.hello()调用它了. 最后启动eel

第二步我们创建一个web目录，新建一个index.html

![img](F:\Typora_book\typora_pic\u=82041708,2054882243&fm=173&app=25&f=JPEG.jpg)

在head里，我们要引用下metroui必需的css和js文件，eel也需要引用一个eel.js。因为后台python和前端是两个进程，要获取数据的话，我们就需要async和await两个关键字去从后台取数据，同时方法名后加一对额外的括号。如果不需要数据的话，则直接eel.hello()就好。

在copyval方法里我们调用python hello方法，获取值后用jQuery赋值给textarea。

![img](F:\Typora_book\typora_pic\u=13642212,572288084&fm=173&app=25&f=JPEG.jpg)

nav里用的是metroui自带的菜单和图标，并没有什么神秘的地方。

最后的效果如下，象不象最新版的Office?

![img](F:\Typora_book\typora_pic\u=3133174934,1126146377&fm=173&app=25&f=JPEG.jpg)