# Windows系统下载安装MinGW（包括32位和64位）

2018-12-18 19:14:22  更多

[“widnows”]

版权声明：本文为博主原创文章，遵循[ CC 4.0 BY-SA ](http://creativecommons.org/licenses/by-sa/4.0/)版权协议，转载请附上原文出处链接和本声明。本文链接：https://blog.csdn.net/skh2015java/article/details/85075032

**一、MinGW简介**
MinGW是是将GCC编译器和GNU Binutils移植到Win32平台下的产物，包括一系列头文件（Win32API）、库和可执行文件。MinGW是从Cygwin（1.3.3版）基础上发展而来。GCC支持的语言大多在MinGW也受支持，其中涵盖C、C++、Objective-C、Fortran及Ada。对于C语言之外的语言，MinGW使用标准的GNU运行库，如C++使用GNU libstdc++。但是MinGW使用Windows中的C运行库。因此用MinGW开发的程序不需要额外的第三方DLL支持就可以直接在Windows下运行，而且也不一定必须遵从GPL许可证。这同时造成了MinGW开发的程序只能使用Win32API和跨平台的第三方库，而缺少POSIX支持[3]，大多数GNU软件无法在不修改源代码的情况下用MinGW编译。

**二、下载**
下载地址：
https://sourceforge.net/projects/mingw-w64/

**三、安装**
 注意区分64位和32位
 下图是双击可执行文件后点Next后的页面，Architecture是区分64位和32位的，如果你的电脑是64位的，请选择x86_64，如果电脑是32位的，请选择i686

![img](D:\Topora_pic\2018121819115418.png) 

**四、设置环境变量**
  将安装路径对应的bin目录添加到PATH环境变量中。
  假如安装路径是D:\tools\mingw，则将D:\tools\mingw\mingw64\bin 对应的bin目录添加到PATH环境变量中。

**五、测试是否安装成功**
 在命令提示符中输入： gcc -v ，如果显示版本号则表示下载并安装成功