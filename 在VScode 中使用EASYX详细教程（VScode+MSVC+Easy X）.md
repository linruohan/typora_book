# 在VScode 中使用EASYX详细教程（VScode+MSVC+Easy X）

[toc]



众所周知，[vscode](https://so.csdn.net/so/search?q=vscode&spm=1001.2101.3001.7020)是一款强大的IDE，深受广大码友喜爱，博主曾尝试过用它实现各种脱离特定平台的写码，这里给大家介绍vscode配置EASYX的详细教程。

------

## 1.配置MSVC编译环境

首先要知道的是EASYX官方库只支持vs的[编译器](https://so.csdn.net/so/search?q=编译器&spm=1001.2101.3001.7020)，不支持MinGW，除非是自己从github上下的代码重新编译过的并且封装的库。
可以借鉴一下其他优秀博主的教程，这里不详细介绍。
[参考教程1](https://blog.csdn.net/heilone6688/article/details/91050508)
[参考教程2](https://blog.csdn.net/qq_38981614/article/details/99629597)

> 个人推荐教程1的方式，因为将vs的库配置到了电脑的系统环境变量，所以更加方便，而且后面库文件的迁移工作也是在这个基础之上的，教程2没有包含vs的库，所以每次编译都要从vs的develop模式进入，有些麻烦，但是教程2的配置文件写的很详细，大家可以结合着看。如果配置文件有问题的话，博主下面会贴配置文件的代码
>
> 

### 下载vs2022

**官网：**[Visual Studio 2022 IDE - 适用于软件开发人员的编程工具](https://visualstudio.microsoft.com/zh-hans/vs/)

进入官网，选择community 2022下载。

**安装的时候注意：**![img](https://img-blog.csdnimg.cn/914cf95cdcda43919e359e0a3f82215b.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6ZOD5pyo5Zyt5L2R,size_20,color_FFFFFF,t_70,g_se,x_16)

### 这个界面中，勾上==c++桌面开发==，右边一定要勾上==MSVC相关==的。

### ==配置的环境变量名和值==

| 变量名  | 变量值                                                       |
| ------- | ------------------------------------------------------------ |
| path    | C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64 |
| INCLUDE | C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\include |
| INCLUDE | D:\Windows Kits\10\Include\10.0.17763.0\shared               |
| INCLUDE | D:\Windows Kits\10\Include\10.0.17763.0\ucrt                 |
| INCLUDE | D:\Windows Kits\10\Include\10.0.17763.0\um                   |
| INCLUDE | D:\Windows Kits\10\Include\10.0.17763.0\winrt                |
| LIB     | C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\lib\x64 |
| LIB     | D:\Windows Kits\10\Lib\10.0.17763.0\ucrt\x64                 |
| LIB     | D:\Windows Kits\10\Lib\10.0.17763.0\um\x64                   |

变量值的路径可能会略有不同，一般只要安装了visual studio这些路径都会存在，如果变量名不存在时可以新建变量，然后添加对应的值即可。

## vscode 配置步骤

1、由于vscode默认使用“utf-8”编码，而在Windows控制台默认使用的是“gbk”编码，如果直接新建文件编译会出错，为此先对vscode做一些配置修改，确保新建的C/C++文件使用“gbk”编码。

```json
==========settings.json============================
	"[c]": {
        "files.encoding": "gbk"
    },
    "[cpp]": {
        "files.encoding": "gbk"
    },
```



2、启动vscode，点击左下角“**管理**”按钮选择“**设置**”进入“**用户设置**”界面，在搜索框内输入“**编码**”会出现与编码相关的设置。取消“**Files: Auto Guess Encoding**”项的勾选，仍在此界面点击右上角”花括号（**{}**）“按钮进入**json**文件设置。

### ==VScode各种json的配置==

如果之前你的MSVC环境配置好的话，并且能正常编译C++/C的代码的话，4个json文件的样子大概如下（已经安装MSVC环境还没安装EASYX的代码），大家如果配置文件不会配的话直接复制下面的代码也行，有些目录需要根据实际情况写入。

> 这里提醒一个常识：因为task是任务，launch想要调取任务两个名字就要相对应。
>
> 1. launch.json中的preLaunchTask参数
>
> 2. task.json中的label参数必须要对应，
> 

#### ***c_cpp_properties.json***：

==Ctrl + Shift + P，点击进入“**C/C++：编辑配置（JSON）**”项。==

此时vscode会在”**.vscode**“子文件夹中创建一个**c_cpp_properties.json**的配置文件，

打开此文件，里面会包含一些默认设置。 C / C ++扩展会检测到visual studio的安装位置并自动设置**compilerPath**项。如果没有，您应该修改“**cl.exe**”的路径到**compilerPath**项。

在默认的Visual Studio 2017 Build Tools安装中，“**cl.exe**”路径类似于这样：“**C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/VC/Tools/MSVC/14.16.27023/bin/Hostx64/x64/cl.exe**”，具体请自行查看所安装的visual studio的路径。

另外确保将**intelliSenseMode**值设置为"**msvc-x64**"。“**includePath**”项暂时不需要，可以完全删除该设置。

```
{
    "configurations": [
        {
            "name": "Win32",
            "includePath": [
                "${workspaceFolder}/**"
            ],
            "defines": [
                "_DEBUG",
                "UNICODE",
                "_UNICODE"
            ],
            "windowsSdkVersion": "10.0.18362.0",
            "compilerPath": "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.28.29333/bin/Hostx64/x64/cl.exe",
            //cl.exe文件的目录要自己找，我这个是装的vs2019community版本，具体目录要根据你的情况，可以参考上面教程2的配置方式
            "cStandard": "c17",，
            "cppStandard": "c++17",
            "intelliSenseMode": "msvc-x64"
        }
    ],
    "version": 4
}
```
#### ***最重要的task.json***

==打开“**命令面板**”，选择“**任务：配置默认测试任务**”=>选择“**使用模板创建task.json文件**”=>选择“**Others 运行任意外部命令的示例**”。==

此时vscode创建一个**tasks.json**文件并且打开它，使用下面代码替换其内容：

**label**项将在vscode命令行中使用，可以是您喜欢的任何名称；
	**command**项表明我们正在使用cl.exe（MSVC编译器）；
	**args**项指定将传递给上一步中指定的编译器的命令行参数。

它们必须按编译器预期的顺序出现。在此示例中，我们指定了异常处理模式（**EHsc**）并告诉编译器生成带符号（Zi）的调试版本。**/Fe**项参数告诉编译器将可执行文件命名为“hello.exe”。最后的“hello.cpp”为当前要编译的C++源文件名称

```
{
	"version": "2.0.0",
	"tasks": [
		{
			"type": "cppbuild",
			"label": "C/C++: cl.exe build active file",
			"command": "cl.exe",
			"args": [
				"/Zi",
				"/EHsc",
				"/Fe:",
				"${fileDirname}\\${fileBasenameNoExtension}.exe",
				"${file}"
			],
			"options": {
				"cwd": "${workspaceFolder}"
			},
			"problemMatcher": [
				"$msCompile"
			],
			"group": "build",
			"detail": "compiler: cl.exe"
		}
	]
}
```
#### ***launch.json***

==点击“**调试**”菜单选择“**添加配置**”=> 选择“**C++（Windows）**”=>选择“**Default Configuration**”==

此时vscode创建“**launch.json**”文件并打开，用以下内容替换默认内容：

**stopAtEntry**项设置为**false**表示取消设置的默认断点；
	**externalConsole**项设置为**true**表示使用外置的Windows系统控制台而不是vscode内置的调试控制台（原因在于由于前文所述的编码问题会导致在调试控制台输出中文时出现乱码）
	请注意，程序名称hello.exe与**tasks.json文件**指定的名称相匹配

```
{
    // 使用 IntelliSense 了解相关属性。 
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "msvc launch",
            "type": "cppvsdbg",
            "request": "launch",
            "program": "${fileDirname}\\${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": true,
            "preLaunchTask": "C/C++: cl.exe build active file"
        }
    ]
}
```



#### ***settings.json***

```
{
    "files.associations": {
        "iostream": "cpp",
        "algorithm": "cpp",
        "chrono": "cpp",
        "codecvt": "cpp",
        "forward_list": "cpp",
        "functional": "cpp",
        "istream": "cpp",
        "limits": "cpp",
        "list": "cpp",
        "memory_resource": "cpp",
        "random": "cpp",
        "regex": "cpp",
        "utility": "cpp",
        "vector": "cpp",
        "xhash": "cpp",
        "xlocale": "cpp",
        "xmemory": "cpp",
        "xstring": "cpp",
        "xtree": "cpp",
        "xutility": "cpp"
    },
    "C_Cpp.dimInactiveRegions": true
}
```



------

## 安装EASYX

[EASYX链接](https://easyx.cn/)
官网界面如下：
<img src="https://img-blog.csdnimg.cn/20201206191846751.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM1NTk4MDc0,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述" style="zoom: 33%;" />
下载完直接安装（前提是你电脑要有vs系列，其实在安装MSVC环境的时候就已经应该有了)

## 3.EASYX文件路径的调整

**如果你的vs2022是默认安装路径，那么就在**C:\Program Files (x86)\Microsoft VisualStudio\2022

1.进入Community\VC\Auxiliary\VS\lib\x64，把这两个文件复制一下

![img](https://img-blog.csdnimg.cn/e317d141370342a7a3ef4206f1e5bba4.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6ZOD5pyo5Zyt5L2R,size_20,color_FFFFFF,t_70,g_se,x_16)

粘贴到：Community\VC\Tools\MSVC\14.30.30705\lib\x64 **（注意这里14.30.30705每个人可能不一样，下面也是）**

2.进入Community\VC\Auxiliary\VS\lib\x86，把这两个文件复制一下

![img](https://img-blog.csdnimg.cn/81a37d75edf64bd79b756fea5d68b6df.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6ZOD5pyo5Zyt5L2R,size_20,color_FFFFFF,t_70,g_se,x_16)

 粘贴到：Community\VC\Tools\MSVC\14.30.30705\lib\x86

3.进入Community\VC\Auxiliary\VS\include，把这两个文件复制一下

![img](https://img-blog.csdnimg.cn/09372f9fd3e54ce98d27c2e1e521d266.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA6ZOD5pyo5Zyt5L2R,size_20,color_FFFFFF,t_70,g_se,x_16)

 粘贴到：Community\VC\Tools\MSVC\14.30.30705\include



如果安装EASYX成功后你的vs应该可以索引到graphics.h这个文件：
<img src="https://img-blog.csdnimg.cn/20201206193823672.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM1NTk4MDc0,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述" style="zoom: 33%;" />
如果你就这样直接调试用EASYX的代码就会出现如下情况：
<img src="https://img-blog.csdnimg.cn/20201206194223713.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM1NTk4MDc0,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述" style="zoom: 33%;" />经典的VS link2019问题
这是因为你少了把lib链接起来的命令
所以我们只要修改task.json就可以了

## 这里强调一下在type里的那个参数默认生成的是"cppbuild",要给它改成"shell"！！!(这个是关键）

***task.json***

```
{
    "version": "2.0.0",
    "tasks": [
        {
			"type":"shell",//不要用"cppbuild"!!!
            "label": "C/C++: cl.exe build active file",
            "command": "cl.exe",
            "args": [
                "/EHsc",
				"/Zi",
				"kernel32.lib",
				"gdi32.lib",
				"winspool.lib",
				"comdlg32.lib",
				"advapi32.lib",
				"shell32.lib",
				"ole32.lib",
				"oleaut32.lib",
				"uuid.lib",
				"odbc32.lib",
				"odbccp32.lib",
				"User32.lib",
				"EasyXa.lib",
				"EasyXw.lib",
				"/nologo",
				"/Fd.\\",
				"/Fo.\\",
				"/Fe:",
				"${fileDirname}\\${fileBasenameNoExtension}.exe",
				"${file}"
            ],
            "options": {
                "cwd": "${workspaceFolder}"
            },
            "problemMatcher": [
                "$msCompile"
            ],
            "group": "build",
            "detail": "compiler: cl.exe 调试器生成的任务"
        },
    ]
}
```

1. 中间那些增加的lib是vs调用编译时所必须的,其中包括easyx的库,

2. 为啥有人添加了那些lib结果发现还是报错,是因为你调错了模式,原task.json的type是`cppbuild`,应该给他改成`shell`命令行模式,这样才能执行下面arg里面的命令。
3. 还有就是"`${fileDirname}\f i l e B a s e n a m e N o E x t e n s i o n . e x e `" 和 " `{fileBasenameNoExtension}.exe`"和"*`f**i**l**e**B**a**s**e**n**a**m**e**N**o**E**x**t**e**n**s**i**o**n*.*e**x**e`*"和"`{file}`“分别代表生成的exe(名字中不带拓展名，如你写的源文件是1.cpp，对应的是1.exe而不是1.cpp.exe)。
4. 最后就是”/Fd.\\“和”/Fo.\\“，其中/Fd和/Fo是命令，后面跟的是vc140.pdb和XX.obj文件的目录，如果用.\就表示工作区目录。如果你的vc140.pdb和XX.obj放在工作区下的一个build文件目录下的话那就可以改成”/Fdbuild\\" 和 “/Fobuild\\”,但没必要，因为一般默认都生成在工作区内
   <img src="https://img-blog.csdnimg.cn/20201206195856601.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM1NTk4MDc0,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述" style="zoom: 33%;" />
   这是我写的代码，相应的文件位置关系如上图；
   若环境配置正确那么结果如下图：
   <img src="https://img-blog.csdnimg.cn/20201206200028902.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM1NTk4MDc0,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述" style="zoom:33%;" />

## 效果测试

```cpp
main.cpp
========================调试代码=================================

#include <graphics.h>
#include <conio.h>
#include <math.h>
#define Width 640
#define Height 480
#define PI 3.14159
int main()
{
 // 初始化绘图窗口
 initgraph(640, 480, SHOWCONSOLE);
 //秒针起始坐标
 int center_x = Width / 2, center_y = Height / 2;
 //秒针终点坐标
 int secondEnd_x, secondEnd_y;
 //分针终点坐标
 int minuteEnd_x, minuteEnd_y;
 //时针终点坐标
 int hourEnd_x, hourEnd_y;
 //秒针长度
 int secondLength = Width / 4;
 //分针长度
 int minuteLength = Width / 5.5;
 //时针长度
 int hourLength = Width / 7;
 //秒针对应转到角度
 float secondAngle = 0;
 //分针对应转到角度
 float minuteAngle = 0;
 //时针对应转到角度
 float hourAngle = 0;
 //定义变量存储系统时间
 SYSTEMTIME ti;
 BeginBatchDraw();
 while (1)
 {
  setfillcolor(YELLOW);
  setlinestyle(PS_DASHDOTDOT, 5);
  setlinecolor(0x555555);
  circle(center_x, center_y, secondLength + 30);
  setcolor(0xAAAAAA);
  setlinestyle(PS_DOT | PS_ENDCAP_SQUARE, 2);
  circle(center_x, center_y, secondLength + 15);
  for (int i = 0; i < 12; i++)
  {
int x = center_x + cos(i * 30.0 / 360 * 2 * PI) * (secondLength + 15.0);
   int y = center_y - sin(i * 30.0 / 360 * 2 * PI) * (secondLength + 15.0);
    fillcircle(x, y, 5);
  }
  GetLocalTime(&ti);
  secondAngle = (ti.wSecond / 60.0) * (2 * PI);
  minuteAngle = (ti.wMinute / 60.0) * (2 * PI);
  hourAngle = ((ti.wHour % 12) / 12.0) * (2 * PI) + (ti.wMinute / 60.0) * (2 * PI / 12.0);
  secondEnd_x = center_x + secondLength * sin(secondAngle);
  secondEnd_y = center_y - secondLength * cos(secondAngle);
  minuteEnd_x = center_x + minuteLength * sin(minuteAngle);
  minuteEnd_y = center_y - minuteLength * cos(minuteAngle);
  hourEnd_x = center_x + hourLength * sin(hourAngle);
  hourEnd_y = center_y - hourLength * cos(hourAngle);
  //画秒针
  setlinestyle(PS_SOLID, 1);
  setcolor(WHITE);
  line(center_x, center_y, secondEnd_x, secondEnd_y);
  //画分针
  setlinestyle(PS_SOLID, 2);
     setcolor(GREEN);
  line(center_x, center_y, minuteEnd_x, minuteEnd_y);
  //画时针
  setlinestyle(PS_SOLID, 5);
  setcolor(RED);
  line(center_x, center_y, hourEnd_x, hourEnd_y);
  FlushBatchDraw();
  setlinestyle(PS_SOLID, 1);
  setcolor(BLACK);
  line(center_x, center_y, secondEnd_x, secondEnd_y);
  setlinestyle(PS_SOLID, 2);
  setcolor(BLACK);
  line(center_x, center_y, minuteEnd_x, minuteEnd_y);
  setlinestyle(PS_SOLID, 5);
  setcolor(BLACK);
  line(center_x, center_y, hourEnd_x, hourEnd_y);
 }
 EndBatchDraw();
 system("pause");
 closegraph();
 return 0;
}
```

### 点击“**终端**”菜单选择“**运行生成任务**”（或使用快捷键Ctrl + Shift + B），

vscode会启动生成任务并自动打开终端显示其生成过程。在左侧资源管理器可以看到生成一系列文件。

<img src="https://img-blog.csdnimg.cn/20190607000222791.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2hlaWxvbmU2Njg4,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述" style="zoom:33%;" />
2、点击“**调试**”菜单选择“**在不调试的情况下启动**”（或使用快捷键Ctrl + F5)，会看到在在弹出的控制台黑框中输出我们想要的结果。

<img src="https://img-blog.csdnimg.cn/20190607000537383.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2hlaWxvbmU2Njg4,size_16,color_FFFFFF,t_70" alt="在这里插入图片描述" style="zoom:33%;" />

## 总结

到这里我们的环境配置已经圆满完成，经过测试也达到了预期效果，需要提醒的是，vscode编译调试C/C++必须在文件夹中进行，因此我们在其他文件夹使用这些配置时，只需要将当前的**c_cpp_properties.json**文件、**tasks.json**文件和“**launch.json**”文件复制到对应文件夹的“**.vscode**”子文件夹下，然后修改其中相应的的**C/C++文件和可执行文件名称**即可。
