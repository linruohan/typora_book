# 如何Python写一个安卓APP

[toc]

##  前言：用Python写安卓APP肯定不是最好的选择，但是肯定是一个很偷懒的选择

 可能长这样

[![如何Python写一个安卓APP_android](https://s4.51cto.com//wyfs02/M01/79/77/wKioL1aSO-mz5WNsAABnZ8Z82EA670.png)](https://s4.51cto.com//wyfs02/M01/79/77/wKioL1aSO-mz5WNsAABnZ8Z82EA670.png)    [ ](http://s2.51cto.com/wyfs02/M01/79/77/wKioL1aSPB-wPKgzAAAvjTKJ0UU521.png)[![如何Python写一个安卓APP_android_02](http://s3.51cto.com/wyfs02/M00/79/79/wKiom1aSPDGAUGiCAAA-BVCeTpE757.png)](http://s3.51cto.com/wyfs02/M00/79/79/wKiom1aSPDGAUGiCAAA-BVCeTpE757.png)



 然后设计应该是这样。

如果觉得可行的话，评论留言一下你觉得应该写进这个APP的运维常用命令吧^_^，笔者暂时想到的是`top,free -m,df –h,uptime,iftop,iotop,`

## kivi开源框架

**Kivy**是一套专门用于跨平台快速应用开发的开源框架，使用`Python和Cython`编写，对于`多点触控`有着非常良好的支持，不仅能让开发者快速完成简洁的交互原型设计，还支持`代码重用和部署`，绝对是一款颇让人惊艳的NUI框架。

因为跨平台的，所以只写一遍代码，就可以同时生成安卓及IOS的APP，很酷吧。

本文会带大家写一个Hello world并瞧一瞧Python版的2048的代码

 

### kivy安装(win10)

环境说明：笔者在用的是Python2.7.10  这里仅介绍==windows平台==安装

所有平台参考: [ https://kivy.org/#download](https://kivy.org/#download)

```bash
# 更新pip,setuptools
pip install --upgrade pip wheel setuptools
# 安装所需要的依赖
pip install docutils pygments pypiwin32 kivy.deps.sdl2 kivy.deps.glew kivy.deps.gstreamer --extra-index-url https://kivy.org/downloads/packages/simple/
# 安装kivy
pip install kivy
```

> 值得注意的是，上面的安卓需要访问Google，所以请自备×××，而且kivy.deps.gstreamer这个包比较大(95MB)，可以单独本地安装，[ http://pan.baidu.com/s/1o7mlxNk](http://pan.baidu.com/s/1o7mlxNk)

#### 64位系统:修改BIOS设置，`开启虚拟化支持`

注：这里只是kivy的运行环境，这样我就能直接在windows机器上直接调试了，怎么将代码编译成APK文件我们会在后面讲到。

如果kivy在python中应该就能导入了。

[![如何Python写一个安卓APP_python_03](https://s4.51cto.com//wyfs02/M02/79/77/wKioL1aSPUOCRCPMAAAhlWpoOH8332.png)](https://s4.51cto.com//wyfs02/M02/79/77/wKioL1aSPUOCRCPMAAAhlWpoOH8332.png)

## hello world

```python
from kivy.app import App
from kivy.uix.button importButton
 
class TestApp(App):
    def build(self):
        return Button(text='Hello,kivy')
 
TestApp().run()
```

 运行

<img src="https://s4.51cto.com//wyfs02/M00/79/79/wKiom1aSPWez8sqnAAC28WhQqpA034.png" alt="如何Python写一个安卓APP_python_04" style="zoom: 80%;" />

然后会弹出一个框，大概如下，点击”hello,kivy”会变颜色

[![如何Python写一个安卓APP_android_05](http://s5.51cto.com/wyfs02/M02/79/79/wKiom1aSPaHzKAEbAADI4wuPDXw775.png)](https://s4.51cto.com//wyfs02/M02/79/79/wKiom1aSPYfjj-rwAADdxdZDl58889.png)

点击窗口并按“F1”会这个窗口的一些属性

[![如何Python写一个安卓APP_python_06](https://s4.51cto.com//wyfs02/M01/79/79/wKiom1aSPZaDt-hvAABzhM7sjMI004.png)](https://s4.51cto.com//wyfs02/M01/79/79/wKiom1aSPZaDt-hvAABzhM7sjMI004.png)

然后我们回过头看一看代码。

```python
##导入App，然后让TestApp这个类继承
from kivy.app import App
##导入一个Button,运维有这个button，当你点击的时候才会有所反应
from kivy.uix.button importButton
 
###定义类，名字必须是xxxApp
class TestApp(App):
    ###build一个Button
    def build(self):
        ###返回一个Button,文字内容是“Hello,kivy”
        return Button(text='Hello,kivy')
 
##运行,因为继承了App，所以才有的run这个方法
TestApp().run()1.2.3.4.5.6.7.8.9.10.11.12.13.14.
```

## 安装编译环境

 官方说明的环境，如下：You’ll need:

```
- A   linux computer or a [ virtual machine](https://kivy.org/docs/guide/packaging-android-vm.html#kivy-android-vm)
- Java
- Python   2.7 (not 2.6.)
- Jinja2   (python module)
- Apache   ant
- Android   SDK
```

### virtualbox，vmware需自行下载安装

### 官方虚拟机镜像，还有很多内容需要翻出去，所以笔者在这里提供相对而言更加完善的镜像

下载地址：[ http://pan.baidu.com/s/1geyAY7x](http://pan.baidu.com/s/1geyAY7x)

root密码：kivy/kivy123

## Virtual Machine

A Virtual Machine with Android SDK and NDK and all otherpre-requisites pre installed to ease apk generation:

- [ Kivy Buildozer VM](https://drive.google.com/open?id=0B112pXITp0hJU3dJb25hbWJ3RHM&authuser=0)
- Or select the [ Torrent](https://drive.google.com/open?id=0B112pXITp0hJaDlVTmw3Y1luTms&authuser=0)

 

在笔者提供的镜像里，桌面上有一个dev_and，只要将上面写的代码，放入这个文件夹即可(当然也可以在其他目录，后面会讲到)。

```bash
cd Desktop/dev_and/1.
```

\##初始化会在当前目录生成一个buildozer.spec文件 用于配置生成的apk相关信息

```bash
buildozer init1.
```

\###修改buildozer.spec文件

```bash
vi buildozer.spec1.
```

至少修改下面三项

```bash
# (str) Title of your application
title = helloworld
 
# (str) Package name
package.name = helloapp
 
# (str) Package domain (needed for android/ios packaging)
package.domain = youer.com1.2.3.4.5.6.7.8.
```

然后注释

```bash
# (str) Application versioning (method 1)
#version.regex = __version__ = ['"](.*)['"]
#version.filename = %(source.dir)s/main.py1.2.3.
下面这行改为非注释
version = 1.2.01.2.
```

 最后我们生成我们需要的apk文件

```bash
buildozer -v android debug1.
```

 

buildozer.spec更详细的相关参数配置参考：

[ http://buildozer.readthedocs.org/en/latest/specifications.html](http://buildozer.readthedocs.org/en/latest/specifications.html)

 

buildozer命令会在当前文件夹创建一个bin，该文件夹里面有我们想要的apk文件

```bash
helloapp-1.2.0-debug.apk1.
```



 安装以后应该是这样

 [![如何Python写一个安卓APP_android_07](http://s3.51cto.com/wyfs02/M02/79/78/wKioL1aSRn6zEn4PAAAtivIdfGs250.png)](http://s4.51cto.com/wyfs02/M02/79/77/wKioL1aSPzSTFPsCAAAY0uS33Ac794.png)

话说在编译的时候可能出现空间不足的情况，根据虚拟机的不同(vmware或virtualbox)自行扩容吧。



最后我们来瞧瞧简易版Python开发的2048这个游戏的源代码。

代码来自：https://github.com/mvasilkov/kb/tree/master/6_2048

先看效果图



[ ](http://s5.51cto.com/wyfs02/M01/79/78/wKioL1aSQF-gJIVDAAGNU5RrLk4988.png)[![如何Python写一个安卓APP_android_08](http://s3.51cto.com/wyfs02/M01/79/78/wKioL1aSQTbgkXMhAACo5blBAto943.png)](http://s2.51cto.com/wyfs02/M01/79/78/wKioL1aSQTbgkXMhAACo5blBAto943.png)[![如何Python写一个安卓APP_python_09](http://s5.51cto.com/wyfs02/M00/79/79/wKiom1aSQROA5IX_AABuwz0TiD4354.png)](http://s5.51cto.com/wyfs02/M00/79/79/wKiom1aSQROA5IX_AABuwz0TiD4354.png)[![如何Python写一个安卓APP_kivy_10](http://s6.51cto.com/wyfs02/M01/79/79/wKiom1aSQR7xIXa5AAB2uiYmEGk878.png)](http://s2.51cto.com/wyfs02/M01/79/79/wKiom1aSQR7xIXa5AAB2uiYmEGk878.png)



 

 试玩了一下，还是蛮流畅的，有兴趣的可以下载玩一下

 下载地址：[ http://pan.baidu.com/s/1eQZACDW](http://pan.baidu.com/s/1eQZACDW)

 这个游戏代码虽然不长，但是还是蛮占篇幅的，所以简要的说明一下流程。

 [![如何Python写一个安卓APP_android_11](http://s5.51cto.com/wyfs02/M02/79/78/wKioL1aSQ5_zW_KxAAAfzmXNyLk842.png)](http://s5.51cto.com/wyfs02/M02/79/78/wKioL1aSQ5_zW_KxAAAfzmXNyLk842.png)

 主要由三部分组成，一是素材，图片音频之类的文件，二是Python代码，三是kv文件，这个kv文件有点像html中的css。

 Python代码的文件名一般命名为main.py

 然后一定有一个叫做XXXApp的类，并继承App。

 比如该类叫做GameApp，那么该目录下的kv文件则必须为Game，如上图所示，如果不是，那么kv文件中的一些设定就不会生效。

 比如设定一个标签

```bash
Label:
        id: time
        text: 'xxxx'
        font_size: 601.2.3.4.
```

id为time，text文本内容为'xxxx',然后字体为60

好吧，点到为止吧，不过似乎什么都没点到~~~



从无到有做一个App，我想我会另起一篇文章吧。







- 打赏
-  

- 22赞
-  

- 13收藏
-  

- 29评论
-  

- 分享
-  

- 举报

上一篇：[初识数据中心Mesos](https://blog.51cto.com/youerning/1732682)

下一篇：[从无到有写一个运维APP(一)](https://blog.51cto.com/youerning/1735450)

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/)

提问和评论都可以，用心的回复会被更多人看到**评论**

**全部评论** (29)

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/u_14134259)

### [wx5c14c240a9fcd](https://blog.51cto.com/u_14134259)

2018-12-15 17:02:29

萌新求助！！！！按照您的步骤，apk做出来了，但是手机安装过后，一点App就闪退！求大佬指点！！！

回复点赞

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/u_13449490)

### [qq59fbd3cc475ae](https://blog.51cto.com/u_13449490)

2018-04-15 11:52:43

博主可否重新分享下镜像 您这个链接已经挂了 QQ：201488427

回复点赞

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/u_13680443)

### [wx5abcc21076382](https://blog.51cto.com/u_13680443)

2018-03-29 18:38:39

求镜像yui.911@qq.com,大佬帮帮忙

回复点赞

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/u_13603253)

### [wx5a813aa6d323c](https://blog.51cto.com/u_13603253)

2018-02-12 14:59:38

你好，大佬还能再分享一下你的虚拟镜像吗?1148462196@qq.com

回复点赞

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/u_13585571)

### [wx5a6869fb2eeb5](https://blog.51cto.com/u_13585571)

2018-01-24 19:15:34

你好，大大能再分享一下你的虚拟镜像吗?1581541331@qq.com

回复点赞

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/u_13547996)

### [mb5a3f10687bafe](https://blog.51cto.com/u_13547996)

2017-12-24 10:27:04

博主 但Ubuntu×××好多问题，您可以私发一下虚拟镜像链接吗？1148648777@qq.com，非常感谢！

回复点赞

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/u_13506983)

### [wx5a1e6f5faae7b](https://blog.51cto.com/u_13506983)

2017-11-29 16:30:55

楼主能发一下镜像链接吗 万分感谢 xiang_long_liu@163.com

回复点赞

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/u_13506983)

### [wx5a1e6f5faae7b](https://blog.51cto.com/u_13506983)

2017-11-29 16:29:39

你好，我是一个小小白，刚学python 想着用Python写一个app 可以链接上手机app上各种语音识别技术，方便控制，大神有思路吗，可否指点一二

回复点赞

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/u_12507302)

### [mb58732f70c22b8](https://blog.51cto.com/u_12507302)

2017-10-20 11:15:40

博主大大 你的kivy完整虚拟镜像链接挂了，能重新发一个吗。官方的那个我下了之后，ubuntu用梯子有点问题，所以部分依赖下不了。万分感谢！！！QQ：598481331

回复点赞

[![img](https://s1.51cto.com//oss/202003/17/5ea9517121a715595caf622893387dc5.jpg?x-oss-process=image/resize,m_fixed,h_120,w_120)](https://blog.51cto.com/u_13488879)

### [baby_006](https://blog.51cto.com/u_13488879)*回复了***mb58732f70c22b8**

2021-10-18 11:18:51

博主大大 你的kivy完整虚拟镜像链接挂了，能重新发一个吗。官方的那个我下了之后，ubuntu用梯子有点问题，所以部分依赖下不了。万分感谢！！！QQ：598481331

你的问题解决了么？同求

回复点赞

[![img](https://ucenter.51cto.com/images/noavatar_middle.gif)](https://blog.51cto.com/u_12327526)

### [x2yline](https://blog.51cto.com/u_12327526)

2016-11-22 23:07:33

求百度云镜像链接，谢谢大神了！1010006220@qq.com

回复点赞