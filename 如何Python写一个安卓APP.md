# 如何 Python 写一个安卓 APP

[toc]

##  前言：用 Python 写安卓 APP 肯定不是最好的选择，但是肯定是一个很偷懒的选择

 可能长这样

[![如何Python写一个安卓APP_android](https://s4.51cto.com//wyfs02/M01/79/77/wKioL1aSO-mz5WNsAABnZ8Z82EA670.png)]( https://s4.51cto.com//wyfs02/M01/79/77/wKioL1aSO-mz5WNsAABnZ8Z82EA670.png )    [ ](http://s2.51cto.com/wyfs02/M01/79/77/wKioL1aSPB-wPKgzAAAvjTKJ0UU521.png)[![如何Python写一个安卓APP_android_02](http://s3.51cto.com/wyfs02/M00/79/79/wKiom1aSPDGAUGiCAAA-BVCeTpE757.png)]( http://s3.51cto.com/wyfs02/M00/79/79/wKiom1aSPDGAUGiCAAA-BVCeTpE757.png )



 然后设计应该是这样。

如果觉得可行的话，评论留言一下你觉得应该写进这个 APP 的运维常用命令吧^_^，笔者暂时想到的是 `top,free -m,df –h,uptime,iftop,iotop,`

## kivi 开源框架

**Kivy**是一套专门用于跨平台快速应用开发的开源框架，使用 `Python和Cython` 编写，对于 `多点触控` 有着非常良好的支持，不仅能让开发者快速完成简洁的交互原型设计，还支持 `代码重用和部署`，绝对是一款颇让人惊艳的 NUI 框架。

因为跨平台的，所以只写一遍代码，就可以同时生成安卓及 IOS 的 APP，很酷吧。

本文会带大家写一个 Hello world 并瞧一瞧 Python 版的 2048 的代码

 

### kivy 安装 (win10)

环境说明：笔者在用的是 Python2.7.10  这里仅介绍==windows 平台==安装

所有平台参考: [ https://kivy.org/#download](https://kivy.org/#download)

```bash
# 更新pip,setuptools
pip install --upgrade pip wheel setuptools
# 安装所需要的依赖
pip install docutils pygments pypiwin32 kivy.deps.sdl2 kivy.deps.glew kivy.deps.gstreamer --extra-index-url https://kivy.org/downloads/packages/simple/
# 安装kivy
pip install kivy
```

> 值得注意的是，上面的安卓需要访问 Google，所以请自备×××，而且 kivy. Deps. gstreamer 这个包比较大 (95MB)，可以单独本地安装，[ http://pan.baidu.com/s/1o7mlxNk](http://pan.baidu.com/s/1o7mlxNk)

#### 64 位系统: 修改 BIOS 设置，`开启虚拟化支持`

注：这里只是 kivy 的运行环境，这样我就能直接在 windows 机器上直接调试了，怎么将代码编译成 APK 文件我们会在后面讲到。

如果 kivy 在 python 中应该就能导入了。

[![如何Python写一个安卓APP_python_03](https://s4.51cto.com//wyfs02/M02/79/77/wKioL1aSPUOCRCPMAAAhlWpoOH8332.png)]( https://s4.51cto.com//wyfs02/M02/79/77/wKioL1aSPUOCRCPMAAAhlWpoOH8332.png )

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

<img src=" https://s4.51cto.com//wyfs02/M00/79/79/wKiom1aSPWez8sqnAAC28WhQqpA034.png" alt="如何 Python 写一个安卓 APP_python_04" style="zoom: 80%;" />

然后会弹出一个框，大概如下，点击”hello, kivy”会变颜色

[![如何Python写一个安卓APP_android_05](http://s5.51cto.com/wyfs02/M02/79/79/wKiom1aSPaHzKAEbAADI4wuPDXw775.png)]( https://s4.51cto.com//wyfs02/M02/79/79/wKiom1aSPYfjj-rwAADdxdZDl58889.png )

点击窗口并按“F1”会这个窗口的一些属性

[![如何Python写一个安卓APP_python_06](https://s4.51cto.com//wyfs02/M01/79/79/wKiom1aSPZaDt-hvAABzhM7sjMI004.png)]( https://s4.51cto.com//wyfs02/M01/79/79/wKiom1aSPZaDt-hvAABzhM7sjMI004.png )

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

### virtualbox，vmware 需自行下载安装

### 官方虚拟机镜像，还有很多内容需要翻出去，所以笔者在这里提供相对而言更加完善的镜像

下载地址：[ http://pan.baidu.com/s/1geyAY7x](http://pan.baidu.com/s/1geyAY7x)

root 密码：kivy/kivy123

## Virtual Machine

A Virtual Machine with Android SDK and NDK and all otherpre-requisites pre installed to ease apk generation:

- [ Kivy Buildozer VM](https://drive.google.com/open?id=0B112pXITp0hJU3dJb25hbWJ3RHM&authuser=0)
- Or select the [ Torrent](https://drive.google.com/open?id=0B112pXITp0hJaDlVTmw3Y1luTms&authuser=0)

 

在笔者提供的镜像里，桌面上有一个 dev_and，只要将上面写的代码，放入这个文件夹即可 (当然也可以在其他目录，后面会讲到)。

```bash
cd Desktop/dev_and/1.
```

\# #初始化会在当前目录生成一个buildozer . spec 文件用于配置生成的 apk 相关信息

```bash
buildozer init1.
```

\## #修改buildozer . spec 文件

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

 最后我们生成我们需要的 apk 文件

```bash
buildozer -v android debug1.
```

 

Buildozer. Spec 更详细的相关参数配置参考：

[ http://buildozer.readthedocs.org/en/latest/specifications.html](http://buildozer.readthedocs.org/en/latest/specifications.html)

 

Buildozer 命令会在当前文件夹创建一个 bin，该文件夹里面有我们想要的 apk 文件

```bash
helloapp-1.2.0-debug.apk1.
```



 安装以后应该是这样

 [![如何Python写一个安卓APP_android_07](http://s3.51cto.com/wyfs02/M02/79/78/wKioL1aSRn6zEn4PAAAtivIdfGs250.png)]( http://s4.51cto.com/wyfs02/M02/79/77/wKioL1aSPzSTFPsCAAAY0uS33Ac794.png )

话说在编译的时候可能出现空间不足的情况，根据虚拟机的不同 (vmware 或 virtualbox) 自行扩容吧。



最后我们来瞧瞧简易版 Python 开发的 2048 这个游戏的源代码。

代码来自： https://github.com/mvasilkov/kb/tree/master/6_2048

先看效果图



[ ](http://s5.51cto.com/wyfs02/M01/79/78/wKioL1aSQF-gJIVDAAGNU5RrLk4988.png)[![如何Python写一个安卓APP_android_08](http://s3.51cto.com/wyfs02/M01/79/78/wKioL1aSQTbgkXMhAACo5blBAto943.png)]( http://s2.51cto.com/wyfs02/M01/79/78/wKioL1aSQTbgkXMhAACo5blBAto943.png )[![如何Python写一个安卓APP_python_09](http://s5.51cto.com/wyfs02/M00/79/79/wKiom1aSQROA5IX_AABuwz0TiD4354.png)]( http://s5.51cto.com/wyfs02/M00/79/79/wKiom1aSQROA5IX_AABuwz0TiD4354.png )[![如何Python写一个安卓APP_kivy_10](http://s6.51cto.com/wyfs02/M01/79/79/wKiom1aSQR7xIXa5AAB2uiYmEGk878.png)]( http://s2.51cto.com/wyfs02/M01/79/79/wKiom1aSQR7xIXa5AAB2uiYmEGk878.png )



 

 试玩了一下，还是蛮流畅的，有兴趣的可以下载玩一下

 下载地址：[ http://pan.baidu.com/s/1eQZACDW](http://pan.baidu.com/s/1eQZACDW)

 这个游戏代码虽然不长，但是还是蛮占篇幅的，所以简要的说明一下流程。

 [![如何Python写一个安卓APP_android_11](http://s5.51cto.com/wyfs02/M02/79/78/wKioL1aSQ5_zW_KxAAAfzmXNyLk842.png)]( http://s5.51cto.com/wyfs02/M02/79/78/wKioL1aSQ5_zW_KxAAAfzmXNyLk842.png )

 主要由三部分组成，一是素材，图片音频之类的文件，二是 Python 代码，三是 kv 文件，这个 kv 文件有点像 html 中的 css。

 Python 代码的文件名一般命名为 main. py

 然后一定有一个叫做 XXXApp 的类，并继承 App。

 比如该类叫做 GameApp，那么该目录下的 kv 文件则必须为 Game，如上图所示，如果不是，那么 kv 文件中的一些设定就不会生效。

 比如设定一个标签

```bash
Label:
        id: time
        text: 'xxxx'
        font_size: 601.2.3.4.
```

id 为 time，text 文本内容为'xxxx', 然后字体为 60
好吧，点到为止吧，不过似乎什么都没点到~~~
从无到有做一个 App，我想我会另起一篇文章吧。