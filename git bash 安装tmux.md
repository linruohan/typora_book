# 如何在Windows下 git bash 环境内使用tmux

以下步骤按照如下链接一一实践。[https://blog.pjsen.eu/?p=440](https://link.zhihu.com/?target=https%3A//blog.pjsen.eu/%3Fp%3D440) 。

> I did a little research and have found that GIT Bash uses MINGW compilation of GNU tools. It uses only selected ones. You can install the whole distribution of the tools from [https://www.msys2.org/](https://link.zhihu.com/?target=https%3A//www.msys2.org/) and run a command to install*Tmux*. And then copy some files to installation folder of Git.

因为git bash使用的是mingw编译的gnu工具集。所以先要有windows平台下编译好的 tmux 可用才行。这时 msys2 工具派上用场了。

![img](https://pic3.zhimg.com/80/v2-7382e0c8225a4a54083c47652624c4b6_720w.jpg)

使用msys2的pacman安装 tmux如下：

![img](https://pic2.zhimg.com/80/v2-ae477a7948011205f96b52b86bc7bcd9_720w.jpg)

然后再路径 C:\msys64\usr\bin\tmux.exe 已经生成。

> 1 - Install before-mentioned msys2 package and run bash shell
>
> 2 - Install tmux using the following command: `pacman -S tmux`
>
> 3 - Go to msys2 directory, in my case it is `C:\msys64\usr\bin`
>
> 4 - Copy `tmux.exe` and `msys-event-2-1-4.dll` to your Git for Windows directory, mine is `C:\Program Files\Git\usr\bin`. Please note, that in future, you can see this file with the version number higher than *2-1-4*

第四步，是把 tmux.exe 还有 msys-event-2-1-4.dll动态链接库放到git bin目录下即可在git bash上下文调用tmux了。

由于pacman安装的是 libevent-2.1.8-2 tmux-2.9-1。所以最终得到的是 msys-event-2-1-6.dll。不同版本可能有所区别。

------

最终结果。

![img](https://pic3.zhimg.com/80/v2-77c5c45879813517b6dec60f6559b1b2_720w.jpg)

执行之后抛出个127是几个意思？先到这里，解决了再来续。