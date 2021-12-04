 
dwm的使用 [复制链接]


dwm（dynamic window manager）是一个非常小的窗口管理器，与Ubuntu默认的compiz不同，dwm只提供了非常少的功能，代码量也非常少，对于想要了解窗口管理器的运行的话dwm是个不错的学习资料，下面讲在Ubuntu中如何使用dwm

1、官网下载源码http://dwm.suckless.org/
2、解压编译安装
     $make
     $sudo make install （注意dwm默认安装路径是/usr/local，如果要更改的话需要把源码文件config.mk中那个PREFIX=/usr/local改成自定义的路径，比如/opt/dwm
3、把dwm安装路径下的bin目录加入PATH环境变量
4、编写一个dwm.desktop文件放到/usr/share/xsessions下，文件内容为：
```sh
[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
```
5、注销，在登录框中选择使用dwm登录
6、安装完成，现在就有了一个桌面了，可以使用一些快捷键进行操作
```bash
Alt+Shift+Enter
    打开xterm
Alt+Shift+C
    关闭窗口
Alt+t
    切换到窗口平铺模式
Alt+m
    切换到单窗口模式
Alt+f
    切换到浮动窗口模式
Alt+b
    显示/隐藏屏幕上方的那条“工具栏”
Alt+p
    打开dmenu（dmenu要自己安装，安装方法同dwm，也是下载源码，编译，安装）
Alt+[数字]
    切换到第[数字]各标签，标签类似于多个桌面
Alt+Shift+Q

注销
```
复制代码
7、最后，其实最简单的安装方式是sudo apt-get install dwm，哈哈
LZ现在也只知道这些了，去啃一下dwm代码看能不能把窗口管理搞明白{:5_108:}
