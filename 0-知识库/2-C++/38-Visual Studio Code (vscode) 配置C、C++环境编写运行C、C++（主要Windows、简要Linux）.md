# 整理：Visual Studio Code (vscode) 配置C、C++环境/编写运行C、C++（主要Windows、简要Linux）

置顶  更多

版权声明：本文为博主原创文章，遵循[ CC 4.0 BY-SA ](http://creativecommons.org/licenses/by-sa/4.0/)版权协议，转载请附上原文出处链接和本声明。本文链接：https://blog.csdn.net/bat67/article/details/76095813

现在是2019.7.21，由于这阵一直在忙，今天我用最新的VSCode（[Version 1.36.1](https://code.visualstudio.com/updates)） 和最新的Cpp插件（version 0.24.0）按照本文的安装步骤从零开始试了一下，由于vscode版本和cpp插件版本更新确实变化了很多，2019年7月21日更新的我会用这个颜色（粉色？）标示出来，供大家参考[进行配置](https://code.visualstudio.com/docs/cpp/config-mingw)。[也可以参考官方文档：https://code.visualstudio.com/docs/cpp/config-mingw](https://code.visualstudio.com/docs/cpp/config-mingw)

弄了半天，总算弄好了，结合网上的教程，整理分享一下~

发现总有童鞋问相同的问题，开始我还以为是没有配置好，今天我自己按照我原来写的尝试了以下，确实出现了问题，可能是VScode或者cpp的插件版本问题，2018.12.29更新，我会用绿色的字体表示。

另外要是本文的更新内容仍然不能解决您的问题，可以看看[这篇文章](https://blog.csdn.net/bat67/article/details/81268581)，这篇文章是之后写的，比这篇有条理些，配置过程也简单些。要是始终有问题，欢迎留言，我会抽时间**尽我所能**解答（非大神有好多解答不了。。。）

总体流程：

1. 下载安装vscode
2. 安装cpptools插件
3. 安装编译、调试环境
4. 配置系统环境变量path
5. 修改vscode调试配置文件
6. 其他
7. Linux版本配置（简要）

# 1、下载安装vscode

https://code.visualstudio.com/Download 


# 2、安装cpptools插件 

打开vscode，按ctrl+p打开快速命令框，输入以下命令后等待

> ext install cpptools

vscode在短暂的联网查找后会列出插件列表，如图： 

![image](D:\\Topora_pic\aHR0cDovL2Jsb2ctMTI1MjAxNTc4Mi5jb3Nnei5teXFjbG91ZC5jb20vdnNjb2RlJUU1JUFFJTg5JUU4JUEzJTg1MC5wbmc.jpg)

![这里写图片描述](D:\\Topora_pic\20160608214306180) 


点击箭头所指处的按钮安装插件，安装过程可能会有些慢耐心等待 
安装完成后vscode会提示你重启vscode，此时重启即可

更新：因为我装这个插件已经是几年之前了，不确定现在界面还是不是这样，但是意思不变，装完后点重新加载就行了

# 3、安装编译、调试环境

（若是电脑上原来装着codeblocks，Dev C++等可以跳过这步，

直接跳到  【4、配置系统环境变量path】 这步即可）

目前windows下调试仅支持 Cygwin 和 MinGW。 
这里使用的是MinGW. 
下面是MinGW的安装配置过程： 
http://mingw.org/ 
进入官网点击右侧 Download Installer下载安装器 
打开安装器点击install准备安装： 
![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608215745424)

选择一个安装目录，默认为C:\MinGW这里选择的是A:\MinGW 
点击Continue开始安装，安装过程需联网，若安装时提示error则需翻墙安装 
安装过程很快，结束后Continue按钮恢复为可用状态，点击完成安装。

![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608220258320) 
打开MinGW安装管理器进行进一步配置

![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608220513630)

注意这里gdb必选，否则无法调试 
![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160609000552086)

选中几个需要的项右键Make for Installation进行标记，其中gcc和g++为c和c++编译器 
选择完全部想要安装的项后点击左上角Installation菜单下的Apply Changes应用修改，过程需联网，中间出现error可先继续，若最后失败则需翻墙更新，建议翻墙。

更新：单独装MinGW ，我最早是这么搞的，要是发现不可以（无法下载或者很怀疑自己MinGW没安装好等），可以试试codeblocks或者Dev-cpp等等，这些IDE自带编译器，还是看[这篇文章](https://blog.csdn.net/bat67/article/details/81268581) 里面有使用codeblocks自带的MinGW的细节，当然要是可以就继续。

# 4、配置系统环境变量path

然后配置系统环境变量path，这一步为必须 
在 我的电脑 上右键 属性： 
然后按照下面步骤做即可，注意最后新建的项要与之前MinGW安装位置相对应 

Windows7注意，**要加入，不是覆盖！**我第一次不小心把原来路径覆盖了。。。（因为win7不像win10那么明显是加入。。）
![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608221746698)

再次打开vscode，注意配置系统环境变量path后重启一下vscode 
注意vscode调试需要在打开的文件夹中进行（注意！是用VSC打开文件夹！！，单独打开一个单独的cpp是没有下面的几个配置文件出现的！！也就是说，这个cpp要在一个文件夹里！不像DevCpp和C-Free可以直接调试一个单独的cpp！！）

# 5、修改vscode调试配置文件

打开文件夹后，新建test.cpp（随便建，或者main.cpp）进行输入代码[测试](https://blog.csdn.net/bat67/article/details/76095813)： 
![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608222838684)

如图示进入调试界面选择C++： 
![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608223007858) 
![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608223103765)

更新：现在点击之后变成了这样的：VScode还会让你再选一个，都选第一个吧

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20190721200228827.png)![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20190721200525206.png)

然后会在工作目录下的生成一个launch.json的启动配置文件: 
![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608223303441)

使用下面代码替换该文件：（只是在vsc自己产生的json文件加了一些行）

launch.json中有很多属性可以设置, 通过智能提示查看有那些属性可以设置, 如果要查看属性的具体含义, 可以把鼠标悬停在属性上面, 会属性的使用说明.

```ruby
{  
    "version": "0.2.0",  
    "configurations": [  
        {  
            "name": "(gdb) Launch", // 配置名称，将会在启动配置的下拉菜单中显示  
            "type": "cppdbg",       // 配置类型，这里只能为cppdbg  
            "request": "launch",    // 请求配置类型，可以为launch（启动）或attach（附加）  
            "program": "${workspaceFolder}/${fileBasenameNoExtension}.exe",// 将要进行调试的程序的路径  
            "args": [],             // 程序调试时传递给程序的命令行参数，一般设为空即可  
            "stopAtEntry": false,   // 设为true时程序将暂停在程序入口处，一般设置为false  
            "cwd": "${workspaceFolder}", // 调试程序时的工作目录，一般为${workspaceFolder}即代码所在目录  
            "environment": [],  
            "externalConsole": true, // 调试时是否显示控制台窗口，一般设置为true显示控制台  
            "MIMode": "gdb",  
            "miDebuggerPath": "C:\\Program Files (x86)\\CodeBlocks\\MinGW\\bin\\gdb32.exe", // miDebugger的路径，注意这里要与MinGw的路径对应  
            "preLaunchTask": "g++", // 调试会话开始前执行的任务，一般为编译程序，c++为g++, c为gcc  
            "setupCommands": [  
                {   
		    "description": "Enable pretty-printing for gdb",  
                    "text": "-enable-pretty-printing",  
                    "ignoreFailures": true  
                }  
            ]  
        }  
    ]  
}
```

更新：注意：如评论区所说，workspaceRoot已被弃用，现改为workspaceFolder，上面的代码我已经改好了

更新：vscode默认的"externalConsole": false,，而我这里改为了true，改为true即在控制台内部运行，不显示黑框，但是要是不显示黑框似乎没法输入（cin或者scanf）了（没怎么试过，读者可以试试）

注意miDebuggerPath要与MinGw的路径对应 ，我用的codeblocks的gdb，见上面的json文件。

注意miDebuggerPath是\\，与直接粘贴过来的路径不一样，需要加一个”\”（冒号后面的两个反斜杠“\\”）,或者使用一个“/”

替换后保存，然后切换至test.cpp，按F5进行调试，此时会弹出一个信息框要求你配置任务运行程序，点击它~ 
![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608224046717)

【注意】，上面的那个目前的cpp插件似乎没有了，若是直接按F5会出现下面这个图，不清楚评论区童鞋说的是不是这个？![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20181229184204935.jpg)

请点击第二个“配置任务”，然后出现这个：点就行了~

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20181229184445557.jpg)

之后出现：

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20181229184557639.jpg)

在这里随便选一个：（我选的others）【随便选，反正最后tasks.json文件要被覆盖】【下面的图是更新之前的图】

![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608224840837)

更新：现在变成这样的了：我选的第三个，g++那个

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\2019072120143561.png)

然后用下面代码替换：【更新：原来的"version": "0.2.0"似乎会有下划线报错，那就按照vscode说的改为2.0.0好了，下面的是最新的复制即可。】

```kotlin
{
    "version": "2.0.0",
    "command": "g++",
    "args": ["-g","${file}","-o","${fileBasenameNoExtension}.exe"],    // 编译命令参数
    "problemMatcher": {
        "owner": "cpp",
        "fileLocation": ["relative", "${workspaceFolder}"],
        "pattern": {
            "regexp": "^(.*):(\\d+):(\\d+):\\s+(warning|error):\\s+(.*)$",
            "file": 1,
            "line": 2,
            "column": 3,
            "severity": 4,
            "message": 5
        }
    }
}
```

更新：我发现使用vscode自己生成的`tasks.json`，似乎也可以成成功运行，我把VSCode自己生成的这个json文件也贴上来（稍加改动）：这个json文件和上面那个都是可以使cpp正常运行的

```python
{    // See https://go.microsoft.com/fwlink/?LinkId=733558     // for the documentation about the tasks.json format    "version": "2.0.0",    "tasks": [        {            "type": "shell",            "label": "g++", //这里注意一下，见下文            "command": "C:\\Program Files (x86)\\CodeBlocks\\MinGW\\bin\\g++.exe",            "args": [                "-g",                "${file}",                "-o",                "${fileDirname}\\${fileBasenameNoExtension}.exe"            ],            "options": {                "cwd": "C:\\Program Files (x86)\\CodeBlocks\\MinGW\\bin"            },            "problemMatcher": [                "$gcc"            ]        }    ]}
```

注意：“label”那一行，要和前面的`launch.json`中的"preLaunchTask": "g++"这里写的一样，因为前面`launch.json`中的"preLaunchTask"里我改为了g++，所以这里我也改为g++，vscode默认的是`g++.exe build active file`【`launch.json`（"preLaunchTask": "g++.exe build active file"）和`tasks.json`（"label": "g++.exe build active file"）,都是默认的这个，当然无论是什么，只要保持一致就行】

保存一下，然后切换至test.cpp，再次按F5启动调试~

![这里写图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608230053730)

【更新：似乎下面的步骤配置c_cpp_properties.json不需要了，因为我按照上面的步骤来似乎没有在头文件有下划线和原来有的灯泡图标什么的，所以下面的开始到 “6、其他” 之前可以不用看，到这里基本配置完成】

### 配置c_cpp_properties.json

- 保存一下，然后切换至a.cpp，再次按F5启动调试。
- 如果前面的配置都对的话，这个时候会进行编译，然后跳出黑框输出Hello World，之后窗口又迅速消失。
- 可能大多数人已经习惯了VS/VC的便利，其实我们这只要在末尾加上一个cin输入即可。加上`int pause;cin>>pause;`后再按F5。
- 但是这个貌似不够高大上，其实我们一般是使用`system('pause');`实现，换上后再次运行，这时候报错了。因为我们我们引用的库有问题，没有正确引用进来，注意这里不是VS/VC，需要我们自己配置路径。
- 注意：之前在下载安装GNU哪里已经配置了相应的环境变量，但是VScode中有个配置文件，他是根据自己的配置文件来找的。
- 在编辑器中，有小波浪的就是代码有问题，看下`#include`，左边有个灯泡，点击后跳出配置文件，修改其中的Win32的"includePath"如下，和上文一样，根据自己的路径进行调整即可。经测试，下图中代码的注册部分仍是必要部分

```
{    "name": "Win32",    "includePath": [        "C:/Program Files/MinGW/include/*",        "C:/Program Files/MinGW/lib/gcc/mingw32/5.3.0/include/*"        "C:/MinGW/lib/gcc/mingw32/5.3.0/include/c++/*",        "C:/MinGW/lib/gcc/mingw32/5.3.0/include/c++/mingw32/*",        "C:/MinGW/lib/gcc/mingw32/5.3.0/include/c++/backward/*"    ],    "browse": {        "limitSymbolsToIncludedHeaders": true,        "databaseFilename": ""    }}
```

 

![image](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\aHR0cDovL2Jsb2ctMTI1MjAxNTc4Mi5jb3Nnei5teXFjbG91ZC5jb20vdnNjb2RlJUU1JUFFJTg5JUU4JUEzJTg1My5wbmc.jpg)

# 6、其他

**一劳永逸：因为VS需要为每一个文件夹做单独配置，所以建议把`.vscode`文件夹放到你常用的文件夹的顶层，这样就不用重复配置了。
不用每个新cpp文件就要一套配置。这些配置在你配置好的文件夹内的所有子文件夹和文件都能使用。**

 

**![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\aHR0cDovL2Jsb2ctMTI1MjAxNTc4Mi5jb3Nnei5teXFjbG91ZC5jb20vdnNjb2RlJUU1JUFFJTg5JUU4JUEzJTg1NC5wbmc.jpg)**

最后效果： 
设置断点，变量监视，调用堆栈的查看： 
![设置断点，变量监视，调用堆栈的查看](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608210322984)

条件断点的使用： 
![条件断点的使用](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20160608210405892)

新更新：【红色的是很早很早前更新的，2018.12.29更新，会用绿色的字体表示】

最后补一句：

vscode似乎还仅仅支持英文文件名的调试，中文调试的话就会出现“找不到文件XXXXX.cpp”（大意，原文记不清了，因为距离这个问题我已经解决很长时间了，今天看到想补一下，别让新人踩坑了。。。），然后问是否要创建，不知道是BUG还是啥，这纠结了我N久，因为我有些cpp文件是中文命名的，我去Github上找相应的issue也没有找到我想要的这个问题解答，最后偶然间发现英文命名的文件调试时不会出现这个问题，才解决了！！真的很坑！！！新人注意！！！这里浪费了我很长很长时间！！

【要是根据上述方法还没有配置成功，请看评论区是否有人提出了类似问题，还可以按照我在这篇文章之后一段时间写的一篇：[这篇文章](https://blog.csdn.net/bat67/article/details/81268581)，那篇文章使用了codeblocks自带的MINGW，而且配置方法比这个简单一些（因为这个是最早写的），要是始终有问题，欢迎留言，我会抽时间尽我所能解答（非大神有好多解答不了。。。） 】

 

# Linux版本配置（简要）

也是很早之前配置过Linux的，今天我偶然发现了有以前用Linux配置的文件，感觉步骤都和windows配置不多（似乎没有miDebuggerPath这一项），直接上文件了：

【注意：不确定这个还能不能用，因为是很早之前的了，仅仅做参考】

launch.json:

```cpp
{    "version": "0.2.0",    "configurations": [        {            "name": "(gdb) Launch",	// 配置名称，将会在启动配置的下拉菜单中显示            "type": "cppdbg", 		// 配置类型，这里只能为cppdbg            "request": "launch",	// 请求配置类型，可以为launch（启动）或attach（附加）            "program": "${workspaceRoot}/${fileBasenameNoExtension}.o",// 将要进行调试的程序的路径            "args": [],				// 程序调试时传递给程序的命令行参数，一般设为空即可            "stopAtEntry": false, 	// 设为true时程序将暂停在程序入口处，一般设置为false            "cwd": "${workspaceRoot}",// 调试程序时的工作目录，一般为${workspaceRoot}即代码所在目录            "environment": [],            "externalConsole": true,// 调试时是否显示控制台窗口，一般设置为true显示控制台            "MIMode": "gdb",            "preLaunchTask": "g++",	// 调试会话开始前执行的任务，一般为编译程序，c++为g++, c为gcc            "setupCommands": [                {                    "description": "Enable pretty-printing for gdb",                    "text": "-enable-pretty-printing",                    "ignoreFailures": true                }            ]        }    ]}
```

tasks.json：

```cpp
{    "version": "0.1.0",    "command": "g++",    "args": ["-g","${file}","-o","${fileBasenameNoExtension}.o"], // 编译命令参数    "problemMatcher": {        "owner": "cpp",        "fileLocation": ["relative", "${workspaceRoot}"],        "pattern": {            "regexp": "^(.*):(\\d+):(\\d+):\\s+(warning|error):\\s+(.*)$",            "file": 1,            "line": 2,            "column": 3,            "severity": 4,            "message": 5        }    }}
```

 

文章最后发布于: 2017-07-25 21:13:12

- ![zzq275913866](https://profile.csdnimg.cn/2/B/1/3_zzq275913866)

  [**zzq275913866**](https://me.csdn.net/zzq275913866)9个月前#97楼楼主你好，你好，按照你的教程，我执行调试时终端显示“终端将被任务重用，按任意键关闭”，并没有显示helloworld，你知道这种情况怎么解决吗？

- - ![huang_chongqing](https://profile.csdnimg.cn/0/D/5/3_huang_chongqing)

    [**阿小庆**](https://me.csdn.net/huang_chongqing)回复 zzq2759138663小时前我执行调试时终端显示“终端将被任务重用，按任意键关闭”，请问解决了吗？

  - ![weixin_44157999](https://profile.csdnimg.cn/C/F/1/3_weixin_44157999)

    [**周周复始**](https://me.csdn.net/weixin_44157999)回复 zzq2759138661个月前我也是这个问题

  - ![Whatfizzer](https://profile.csdnimg.cn/D/8/5/3_whatfizzer)

    [**Whatfizzer**](https://me.csdn.net/Whatfizzer)回复 zzq2759138662个月前按博主代码敲就知道啦，getchar()可防止窗口关闭 #include <stdio> int main(int argc, char *args[]) { int i, k; printf("Hello, World! \n"); printf("argc:%d\nargs:\n",argc); for(int i=0;i&lt;argc;i++){ printf("%d : %s \n",i, args[i]); } getchar(); return 0; }

  - ![weixin_45675475](https://profile.csdnimg.cn/F/3/D/3_weixin_45675475)

    [**DestinyArbiter**](https://me.csdn.net/weixin_45675475)回复 zzq2759138662个月前请问你问题解决了吗

- ![weixin_42297855](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\3_weixin_42297855.jpg)

  [**就是那个李豪**](https://me.csdn.net/weixin_42297855)6天前#96楼现在gdb32.exe没了，直接改成gdb.exe了

- ![qq_40752913](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\3_qq_40752913.jpg)

  [**floatLig**](https://me.csdn.net/qq_40752913)2周前#95楼感谢博主，很有用，很多坑也说出来，避免了很多坑，感谢！ 有一点可能要注意，过多的vscode插件（c和C++）会让这个过程出现一些问题，可以先把无关紧要的插件先删除，后面再添加

- ![qq_40969864](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\3_qq_40969864.jpg)

  [**拢龙的第416个小笼包**](https://me.csdn.net/qq_40969864)2周前#94楼可以参考VScode官方文档，链接https://code.visualstudio.com/docs/cpp/config-msvc

- ![qq_40969864](https://profile.csdnimg.cn/D/5/E/3_qq_40969864)

  [**拢龙的第416个小笼包**](https://me.csdn.net/qq_40969864)2周前c_cpp_properties.json:`{    "configurations": [        {          "name": "Win32",          "includePath": ["${workspaceFolder}/**"],          "defines": ["_DEBUG", "UNICODE", "_UNICODE"],          "windowsSdkVersion": "10.0.17763.0",          "compilerPath": "D:\\mingw-w64\\mingw32\\bin\\g++.exe",          "cStandard": "c11",          "cppStandard": "c++17",          "intelliSenseMode": "${default}"        }      ],      "version": 4}`

- ![qq_40969864](https://profile.csdnimg.cn/D/5/E/3_qq_40969864)

  [**拢龙的第416个小笼包**](https://me.csdn.net/qq_40969864)2周前launch.json:`{      "version": "0.2.0",      "configurations": [          {              "name": "(gdb) Launch",               "type": "cppdbg",            "request": "launch",             "program": "${workspaceFolder}/${fileBasenameNoExtension}.exe",// 将要进行调试的程序的路径              "args": [],            "stopAtEntry": true,            "cwd": "${workspaceFolder}", // 调试程序时的工作目录，一般为${workspaceFolder}即代码所在目录              "environment": [],              "externalConsole": true,             "MIMode": "gdb",              "miDebuggerPath": "D:\\mingw-w64\\mingw32\\bin\\gdb.exe", // miDebugger的路径，注意这里要与MinGw的路径对应                "setupCommands": [                  {   		            "description": "Enable pretty-printing for gdb",                      "text": "-enable-pretty-printing",                      "ignoreFailures": true                  }              ]          }      ]  }`

- ![qq_40969864](https://profile.csdnimg.cn/D/5/E/3_qq_40969864)

  [**拢龙的第416个小笼包**](https://me.csdn.net/qq_40969864)2周前preLaunchTask"g++"已终止，退出代码为1。解决办法： 1、下载MinGW-w64 - for 32 and 64 bit版本的，然后将bin添加到系统变量中。 2、修改三个json文件，见下面代码。 tasks：`{    // See https://go.microsoft.com/fwlink/?LinkId=733558     // for the documentation about the tasks.json format    "version": "2.0.0",    "tasks": [        {        "label": "build hello world",        "type": "shell",        "command": "g++",        "args": ["-g", "-o", "${workspaceFolder}", "${fileBasenameNoExtension}.cpp"],        "group": {`

<iframe width="900" frameborder="0" height="104" scrolling="no" src="https://pos.baidu.com/s?hei=104&amp;wid=900&amp;di=u3501897&amp;ltu=https%3A%2F%2Fblog.csdn.net%2Fbat67%2Farticle%2Fdetails%2F76095813&amp;psi=19200072451649f27a81b4ddd5c4a1b4&amp;dtm=HTML_POST&amp;cec=UTF-8&amp;cfv=0&amp;pcs=1349x640&amp;par=1366x744&amp;cdo=-1&amp;chi=1&amp;cmi=4&amp;cce=true&amp;tcn=1575465754&amp;exps=111000,110011&amp;ti=%E6%95%B4%E7%90%86%EF%BC%9AVisual%20Studio%20Code%20(vscode)%20%E9%85%8D%E7%BD%AEC%E3%80%81C%2B%2B%E7%8E%AF%E5%A2%83%2F%E7%BC%96%E5%86%99%E8%BF%90%E8%A1%8CC%E3%80%81C%2B%2B%EF%BC%88%E4%B8%BB%E8%A6%81Windows&amp;col=zh-CN&amp;ccd=24&amp;pis=-1x-1&amp;dri=0&amp;cja=false&amp;dai=3&amp;psr=1366x768&amp;ps=17678x48&amp;ari=2&amp;pss=1349x17784&amp;tlm=1575465753&amp;dis=0&amp;drs=1&amp;ant=0&amp;dc=3&amp;prot=2&amp;cpl=3&amp;tpr=1575465753606" style="box-sizing: inherit; outline: 0px; margin: 0px; padding: 0px; font-family: &quot;Microsoft YaHei&quot;, &quot;SF Pro Display&quot;, Roboto, Noto, Arial, &quot;PingFang SC&quot;, sans-serif;"></iframe>
![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\1.png)