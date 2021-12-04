vscode调试运行c#详细操作过程

```shell
#路径跳转
cd
#新建项目
dotnet new console -o 路径
#//运行
dotnet run
#//用于发布exe
<RuntimeIdentifier>win10-x64</RuntimeIdentifier>
#//在项目根目录执行命令运行程序 :
dotnet run -p ceshi002.csproj
#发布exe :
dotnet publish ceshi002.csproj
```

1. 安装 .NET Core SDK.  [.NET Core SDK下载](https://www.microsoft.com/net/learn/get-started/windows#create)
2. 安装Visual Studio Code.[Visual Studio Code.下载](https://code.visualstudio.com/docs?start=true)

3. 安装 C# extension 在VSCode市场中有，直接搜索即可.

4. 首先用cmd试试创建C#程序与运行

- 1.快捷键：win+R
- 2.输入dotnet -h查看帮助：

- 3.在任意地方指定一个项目文件夹：

- 4.然后在cmd中用命令指定到路径新建项目：

```shell
dotnet new console -o D:\c#cmd测试\myceshi001
```

>
> new 是初始化.NET项目
>
> console 是模板
>
> -o 是要放置生成的输出的位置。
>
> 后面跟路径 D:\c#cmd测试\myceshi001
>
> myceshi001是项目的命名
>

5.此时文件夹中已经创建了myceshi001项目：

6.cmd中进入项目路径然后尝试运行:

输入 d: 跳转到d盘
输入 cd 路径 跳转到项目路径

输入 dotnet run 尝试运行

成功！！！



7.在cmd中输入type也能查看文件文本内容：
注：输入 help 能查看cmd命令




5.用vscode创建和运行：

1.创建个项目文件夹：//这里我创建的是  c#vscode测试
2.打开vscode:
3.在vscode中打开这个文件夹：
快捷键：ctrl+k + ctrl+o

2.快捷键：ctrl+shifit+y 打开控制台
3.进入终端...


2.接下来的创建操作和上面cmd的一样：
敲入代码：
dotnet new console
还原成功！！！
然后文件夹里面就多了点东西
点击打开Program.cs就是你创建的主程序文件了
里面已经默认写了个Hello World程序...

3.接下来直接按下F5运行！！！
他会让你选择环境运行,点击: .NET Core

4.等待一段时间后...
跳出一个json文件让你设置？
跳出一个警告：
译：缺少必需的资产构建和调试的c# vscode测试”。加入他们吗?
点击：yes
然后关掉文件就好了

第一次运行就会这样....

5.设置好了，接下来再按下F5
等待一段时间后...
成功在调试控制台打印出Hello world!


而在终端则显示一些生成信息：




..........完美运行！！！



6.开始书写自己的程序并调试：
写个例子:
新建了个名为 Name001 的类文件
然后还加了个断点上去


然后在main程序里面调用...


然后按下F5运行！！！
进入调试页面：
调试断点监视什么的都齐全了！！！
成功输出：Hello World!闪电黑客



vscode运行调试C#的教程完结。。。



最后的最后：

你应该发现了
debug里面没有exe文件,只有一个dll?


解决办法：

在项目的 . csproj 文件里面加入这行代码：

<RuntimeIdentifier>win10-x64</RuntimeIdentifier>

然后点击F5运行就可以了：

注意：生成exe的话 , 编译等待的时间会比较长...
完成后打开文件夹就能看见多了点东西...


<RuntimeIdentifier>win10-x64</RuntimeIdentifier>

用于最后的exe生成。。。
新的程序都会生成在win10-x64  里面

不过vscode还是在调试之前的程序 netcoreapp2.1 里面的.dll程序

不会去调试 win10-x64 这个新路径的

建议是 确定程序完成 后最加上，用于生成.exe

//=============================================

当然你不嫌麻烦的话也可以加多短短的一个路径：
打开.vscode文件夹的launch.json文件

里面这条：

```c
"program": "${workspaceFolder}/bin/Debug/netcoreapp2.1/C#vscode测试.dll",
就是调试路径：在netcoreapp2.1/后面加上win10-x64/,变成：
"program": "${workspaceFolder}/bin/Debug/netcoreapp2.1/win10-x64/C#vscode测试.dll",
```


然后就一点问题都没有了，调试并同时产生新的exe，都在win10-x64里面
