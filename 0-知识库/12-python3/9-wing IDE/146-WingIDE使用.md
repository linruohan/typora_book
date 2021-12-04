[Python]WingIDE的使用经验总结

嗨学编程 2019-03-21 15:17:46  1095  收藏
展开
0：WingIDE的使用
好的工具可以让你做事时，事半功倍！这一点在写代码的过程中尤为明显，使用Pyhton写程序有一年多了！各类编辑器IDE也使用了不少，如Pycharm,sublime,Qtcreator等等，最近开始使用WingIDE，发现使用起来非常顺手，而且支持目前所有主流操作系统！这篇博文用来记录总结，在安装和使用WingIDE过程中的一些有用的经验，技巧！

- 在windows平台下的安装

```
1：首先安装python开发环境
2：添加python路径到系统path
3：下载安装WingIDE (破解)
```

- Debain平台下的安装

```
由于在Linux平台下，python一般是默认安装的，所以直接到官方下载Deb包，然后安装即可
sudo dpkg -i xxx.deb
```

### `2:WingIDE主题的选择`

- 选择如上图主题风格的方法，看下面的动态图的操作
- 默认的字体对本人来说有点小，通过Edit->Preferences->User Interface->Fonts进行调整
  ![图片描述](https://image-static.segmentfault.com/424/569/4245690624-573af9996c5c1_articlex)

## `3:常用快捷键`

- F1 = 上下框的开合
- F2 = 左右框的开合
- Tab = 自动补全功能
- 习惯使用enter or space键补全的朋友可以通过下面方法设置
- 设置补全键：Edit->Keybord Personality->Config auto..->Editors->Auto-completion
- 显示行号的选项：Edit -> Show(Hide) Line Numbers

下面图看不清时，请单击图片，放大观看

| F1 F2操作效果 | ![图片描述](D:\Typora_pic\1763311561-573b023350abf_articlex.gif) |
| ------------| ------------------------------------------------------------ |
| 单文件分成多编辑窗口 | ![图片描述](D:\Typora_pic\317838250-573b0243c4f6b_articlex.gif) |

官网下载链接：http://wingware.com/downloads



想要学习Python？Python学习交流群：984632579满足你的需求，资料都已经上传群文件，可以自行下载！

1:WingIDE的安装
在windows平台下的安装

1：首先安装python开发环境

2：添加python路径到系统path

3：下载安装WingIDE (破解)

Debain平台下的安装

由于在Linux平台下，python一般是默认安装的，所以直接到官方下载Deb包，然后安装即可sudodpkg-ixxx.deb

2:WingIDE主题的选择
选择如上图主题风格的方法，看下面的动态图的操作

默认的字体对本人来说有点小，通过Edit->Preferences->User Interface->Fonts进行调整



3:常用快捷键

```
F1 = 上下框的开合
F2 = 左右框的开合
Tab = 自动补全功能
```

==习惯使用enter or space键补全的朋友可以通过下面方法设置==

设置补全键：Edit->Keybord Personality->Config auto..->Editors->Auto-completion

显示行号的选项：Edit -> Show(Hide) Line Numbers
------------------------------------------------
3.设置WingIDE运行环境为系统安装的Python

WingIDE运行时会运行IDE自带的Python，不是系统的Python，所以需要进行配置。

Project-->Project properties，在Python Path中选择Custom，然后点击Insert，在弹出的对话框中选择Python安装路径，点击OK

![img](D:\Typora_pic\20160108111656682.png)![img](D:\Typora_pic\20160108111828859.png)



为了验证是否配置成功 ，我们先在命令行执行

pip install xlrd

然后我们在WingIDE新建一个Python文件，如果能正常的import这个库说明配置成功，能正常import的都在提示里，不能正常import的不在提示里并且运行时会报错

![img](D:\Typora_pic\20160108112406242.png)