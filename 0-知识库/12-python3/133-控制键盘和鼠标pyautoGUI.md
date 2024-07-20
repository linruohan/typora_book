# Python PyAutoGUI模块控制鼠标和键盘实现自动化任务详解

 更新时间：2018年09月04日 09:40:31  作者：斗大的熊猫  [![img](https://www.jb51.net/skin/2018/images/text-message.png) 我要评论](https://www.jb51.net/article/146786.htm#comments)

这篇文章主要介绍了Python PyAutoGUI模块控制鼠标和键盘实现自动化任务,结合实例形式详细分析了pyautogui模块的安装、导入以及针对鼠标与键盘的各种常见响应操作实现技巧,需要的朋友可以参考下

本文实例讲述了Python PyAutoGUI模块控制鼠标和键盘实现自动化任务。分享给大家供大家参考，具体如下：

PyAutoGUI是用Python写的一个模块，使用它可以控制鼠标和键盘。

利用它可以实现自动化任务，再也不用担心有重复枯燥的任务了。

**pyautogui模块的功能：**

- 移动鼠标、点击左右键和滚轮
- 发送虚拟按键

**# 安装pyautogui**

这个模块支持Windows, Mac OS X 和 Linux。

根据系统不同，你可能需要安装一些依赖。

**Linux系统（Debian系列）：**

```
$ sudo apt``-``get install python3``-``pip``$ sudo pip3 install python3``-``xlib``$ sudo apt``-``get install scrot``$ sudo apt``-``get install python3``-``tk``$ ``and` `sudo apt``-``get install python3``-``dev
```

Scrot是pyautogui使用的截图工具。

**Mac OS X：**

```
$ sudo pip3 install pyobjc``-``framework``-``Quartz``$ sudo pip3 install pyobjc``-``core``$ sudo pip3 install pyobjc``$ sudo pip3 install pillow
```

OS X上的Python3可以通过brewhome或port安装。

Windows系统不用安装依赖。

安装完依赖之后，安装pyautogui：

```
$ sudo pip3 install pyautogui``# Windows``pip install pyautogui
```

导入模块测试：

```
import` `pyautogui
```

**# 准备**

Python移动鼠标、点击键盘非常快，有可以导致其他应用出现问题。如果出现了问题，而鼠标还一直瞎晃，在这种情况下，你很难点击窗口退出程序。

两种解决方法：

**#1 pyautogui的暂停和Fail-Safe**

你可以告诉你的Python脚本在每执行一个函数后暂停几秒钟，这样你就有了几秒种的控制权。

```bash
import` `pyautogui``pyautogui.PAUSE ``=` `1.5
```

fail-safe：当鼠标移动到屏幕的左上角时触法PyAutoGUI的FailSafeException异常。你可以使用try except语句处理异常，或直接让脚本异常退出。如果你想终止程序，只要你快速的把鼠标移动到屏幕左上角就可以了。

```
import` `pyautogui``pyautogui.FAILSAFE ``=` `True
```

**#2 注销系统**

这个方法比较粗暴直接，不建议使用。Windows和Linux的快捷键是：Ctrl–Alt–Del；Mac OS X的快捷键是Command–Shift–Option-Q。

**# 移动鼠标**

PyAutoGUI使用x，y坐标，屏幕左上角坐标是(0, 0)。

1366×768分辨率：

 ![img](D:\Typora_pic\201894100059717.png)

使用`pyautogui.size()`函数获得屏幕的分辨率：

```
import` `pyautogui``pyautogui.size()``# (1366, 768)``width, height ``=` `pyautogui.size()
```

![img](D:\Typora_pic\20189493755842.png) 

Ok，现在我们得到了屏幕的分辨率，下面我们来控制鼠标移动。

`moveTo`函数，绝对坐标。(block.py)：

```
import` `pyautogui``for` `i ``in` `range``(``10``):``  ``pyautogui.moveTo(``300``, ``300``, duration``=``0.25``)``  ``pyautogui.moveTo(``400``, ``300``, duration``=``0.25``)``  ``pyautogui.moveTo(``400``, ``400``, duration``=``0.25``)``  ``pyautogui.moveTo(``300``, ``400``, duration``=``0.25``)
```

执行：

```
$ python3 block.py
```

上面代码让鼠标顺时针移动，并划10次方框。

划圆：

```
import` `pyautogui``import` `math``width, height ``=` `pyautogui.size()``r ``=` `250` `# 圆的半径``# 圆心``o_x ``=` `width``/``2``o_y ``=` `height``/``2``pi ``=` `3.1415926``for` `i ``in` `range``(``10``): ``# 转10圈`` ``for` `angle ``in` `range``(``0``, ``360``, ``5``): ``# 利用圆的参数方程`` ``X ``=` `o_x ``+` `r ``*` `math.sin(angle``*``pi``/``180``)`` ``Y ``=` `o_y ``+` `r ``*` `math.cos(angle``*``pi``/``180``)`` ``pyautogui.moveTo(X, Y, duration``=``0.1``)
```

`moveRel()`函数，相对坐标。以当前鼠标所在位置为基点：

```
import` `pyautogui``for` `i ``in` `range``(``10``):`` ``pyautogui.moveRel(``100``, ``0``, duration``=``0.25``)`` ``pyautogui.moveRel(``0``, ``100``, duration``=``0.25``)`` ``pyautogui.moveRel(``-``100``, ``0``, duration``=``0.25``)`` ``pyautogui.moveRel(``0``, ``-``100``, duration``=``0.25``)
```

获得鼠标所在坐标：

```
import` `pyautogui``x, y ``=` `pyautogui.position()
```

实时获得鼠标位置坐标：

```
import` `pyautogui``try``:`` ``while` `True``:``  ``x, y ``=` `pyautogui.position()``  ``print``(x,y)``except` `KeyboardInterrupt:`` ``print``(``'\nExit.'``)
```

**# 鼠标点击、拖拽和滚轮**

**鼠标点击**

使用`click()`函数发送虚拟鼠标点击，默认情况下在鼠标所在的位置点击左键。函数原型：

```
pyautogui.click(x``=``cur_x, y``=``cur_y, button``=``'left'``)
```

- x，y是要点击的位置，默认是鼠标当前位置
- button是要点击的按键，有三个可选值：‘left', ‘middle', ‘right'。

要在当前位置点击右键：

```
import` `pyautogui``pyautogui.click(button``=``'right'``)
```

要在指定位置点击左键：

```
import` `pyautogui``pyautogui.click(``100``, ``100``)
```

click函数完成了一次鼠标点击。一次完整的点击包括两部分，按下`mouseDown()`和弹起`mouseUp()`。上面这两个函数参数和click函数一样，其实click函数只是简单的封装了`mouseDown()`和`mouseUp()`函数。

其他函数：

- pyautogui.doubleClick()：鼠标双击，其实就是执行两次click()函数。
- pyautogui.rightClick()：右击
- pyautogui.middleClick()：中击

**鼠标拖拽**

拖拽的意思是：按下鼠标键并拖动鼠标。PyAutoGUI提供了两个函数：`dragTo()` 和 `dragRel()`。它的参数和`moveTo()` 和 `moveRel()` 一样。

注意：duration时间不能太短，拖动太快有些系统会吃不消。

使用它你可以在简单的画图程序中绘制复杂的图形。

![img](D:\Typora_pic\20189494304188.png)

**滚轮**

使用函数`scroll()`，它只接受一个整数。如果值为正往上滚，值为负往下滚。

```
pyautogui.scroll(``200``)
```

**# 定位某个按钮的位置**

pyautogui有截屏功能。你可能会疑惑，它怎么还带截屏？

假如你有一个按钮要10秒种点击一下，这个任务使用上面介绍的函数可以轻松实现。但是我们假设你每次点击这个按钮它都会变换一个位置（随机），这时你该怎么办？下面我们就来解决这个问题。

首先看一下怎么使用pyautogui截屏：

```
import` `pyautogui``im ``=` `pyautogui.screenshot()``# 获得某个坐标的像素``im.getpixel((``50``, ``200``))``# (30, 132, 153)``# 判断屏幕坐标的像素是不是等于某个值``pyautogui.pixelMatchesColor(``50``, ``200``, (``30``, ``132``, ``153``))``# True
```

小测试：实时获得鼠标所在位置的像素值。

现在我们来解决前面提出的问题。问题的关键是怎么找到按钮所在的坐标。其实很简单，首先对你要点击的按钮截个图，就叫button.png吧。然后使用`locateOnScreen`函数找到按钮所在的位置：

```
import` `pyautogui``pyautogui.locateOnScreen(``'button.png'``)``# (643, 745, 70, 29)
```

locateOnScreen其实就是简单的颜色对比，如果有一个像素不匹配，它就会返回None。这个函数返回了匹配图形的坐标，找到中间点：

```
x, y ``=` `pyautogui.center((``643``, ``745``, ``70``, ``29``)) ``# 获得中心点``pyautogui.click(x, y)
```

`locateAllOnScreen()`：找到所有匹配的位置坐标。

**# 键盘按键**

前面是鼠标相关，下面我们看看键盘。

**输入字符串**

`pyautogui.typewrite()`：

```
import` `pyautogui``pyautogui.click(``100``, ``100``)``pyautogui.typewrite(``'Hello world!'``)
```

![img](D:\Typora_pic\20189494638174.png)

上面的字符串是一次输入，为了唬人可以延迟输入：

```
typewrite(``'Hello world!'``, ``0.25``)
```

PyAutoGUI输入单个字符还可以，但是一些特殊字符怎么办呢？例如上面输入完Hello World，然后换行继续输入。

PyAutoGUI键盘表：



| ‘enter' (或‘return' 或 ‘\n')           | 回车                                   |
| -------------------------------------- | -------------------------------------- |
| ‘esc'                                  | ESC键                                  |
| ‘shiftleft', ‘shiftright'              | 左右SHIFT键                            |
| ‘altleft', ‘altright'                  | 左右ALT键                              |
| ‘ctrlleft', ‘ctrlright'                | 左右CTRL键                             |
| ‘tab' (‘\t')                           | TAB键                                  |
| ‘backspace', ‘delete'                  | BACKSPACE 、DELETE键                   |
| ‘pageup', ‘pagedown'                   | PAGE UP 和 PAGE DOWN键                 |
| ‘home', ‘end'                          | HOME 和 END键                          |
| ‘up', ‘down', ‘left', ‘right'          | 箭头键                                 |
| ‘f1', ‘f2', ‘f3'….                     | F1…….F12键                             |
| ‘volumemute', ‘volumedown', ‘volumeup' | 有些键盘没有                           |
| ‘pause'                                | PAUSE键                                |
| ‘capslock', ‘numlock', ‘scrolllock'    | CAPS LOCK, NUM LOCK, 和 SCROLL LOCK 键 |
| ‘insert'                               | INS或INSERT键                          |
| ‘printscreen'                          | PRTSC 或 PRINT SCREEN键                |
| ‘winleft', ‘winright'                  | Win键                                  |
| ‘command'                              | Mac OS X command键                     |



```
import` `pyautogui``pyautogui.click(``100``, ``100``)``pyautogui.typewrite(``'Hello world!'``, ``0.25``)``pyautogui.typewrite([``'enter'``, ``'a'``, ``'b'``, ``'left'``, ``'left'``, ``'X'``, ``'Y'``], ``'0.25'``)
```

![img](D:\Typora_pic\201894100259561.png)

**按键的按下和释放**

和鼠标按键非常类似。

- keyDown()：按下某个键
- keyUp()：松开某个键
- press()：一次完整的击键，前面两个函数的组合。

alt＋F4：

```
pyautogui.keyDown(``'altleft'``);``pyautogui.press(``'f4'``);``pyautogui.keyUp(``'altleft'``)
```

也可以直接使用热键函数：

```
pyautogui.hotkey(``'altleft'``, ``'f4'``)
```

关于PyAutoGUI的介绍就到这里，如果你使用它做了什么好玩的自动化脚本，欢迎留言。

更多关于Python相关内容感兴趣的读者可查看本站专题：《[Python数据结构与算法教程](https://www.jb51.net/Special/663.htm)》、《[Python Socket编程技巧总结](https://www.jb51.net/Special/648.htm)》、《[Python函数使用技巧总结](https://www.jb51.net/Special/642.htm)》、《[Python字符串操作技巧汇总](https://www.jb51.net/Special/636.htm)》、《[Python入门与进阶经典教程](https://www.jb51.net/Special/520.htm)》及《[Python文件与目录操作技巧汇总](https://www.jb51.net/Special/516.htm)》

希望本文所述对大家Python程序设计有所帮助。

#### 0.1.1 您可能感兴趣的文章:

- [Python pyautogui模块实现鼠标键盘自动化方法详解](https://www.jb51.net/article/180619.htm)
- [python PyAutoGUI 模拟鼠标键盘操作和截屏功能](https://www.jb51.net/article/166879.htm)
- [使用 python pyautogui实现鼠标键盘控制功能](https://www.jb51.net/article/166877.htm)
- [Python使用pyautogui模块实现自动化鼠标和键盘操作示例](https://www.jb51.net/article/146791.htm)
- [pyautogui自动化控制鼠标和键盘操作的步骤](https://www.jb51.net/article/183928.htm)