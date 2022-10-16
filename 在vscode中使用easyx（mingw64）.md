# vscode 安装 easyx 库

[toc]



如题，如何在vscode安装easyx库<img src="https://thirdqq.qlogo.cn/g?b=oidb&k=MuyK4AqQkfwWRm4UDxCQug&s=640&t=1557316034" alt="img" style="zoom:33%;" />

VS Code 并不带编译器。所以，如何配置 EasyX，取决于你的 VS Code 配置的什么编译环境。

## 对于 VSCode + MinGW （常用）

这个配置用的应该多一些。怎样在 VSCode 里面配置 MinGW 不再重述，可以自行搜索。

配置好 MinGW 之后，可以参考这篇文章配置 EasyX：https://go.easyx.cn/easyx-for-mingw

### 在 Dev-C++ 或 Code::Blocks 下面配置 EasyX（2022-6-10 更新） [![金牌收录](https://codebus.cn/content/images/gold.png)](https://codebus.cn/bestans/easyx-for-mingw?medal=3)

本文提供了将 EasyX 适配到 MinGW 上的库文件，并详细介绍如何将 EasyX 配置到 DevCpp 或 CodeBlocks 等以 MinGW 为编译器的集成开发环境。

平时我工作忙，有问题直接在后面留言，我会尽力修改。

### 库文件下载

[点击这里下载 easyx4mingw_20220610](https://easyx.cn/download/easyx4mingw_20220610.zip)

#### 支持 MinGW 版本

支持 TDM-GCC MinGW 4.8.1 及以上版本（32 位和 64 位均支持）。即支持 2013 年 9 月 28 日及之后发布的所有版本 TDM-GCC MinGW。

使用 TDM-GCC MinGW 4.8.1 及以上版本的集成开发环境都可以支持。例如：

- Code::Blocks 13.12 及以上版本
- DevCpp 5.8.0 及以上版本

同时额外支持：

- DevCpp 5.4.0 MinGW 4.7.2（第十三届蓝桥杯大赛学生机 C/C++ 编程环境）
- C-Free 5.0（内置 GCC MinGW 3.4.5）

#### 文件清单 下载的压缩包内文件如下：

```markup
easyx4mingw_20220606.zip
	├ include <folder>
	│	├ easyx.h 				// 头文件(提供了当前最新版本的接口)
	│	└ graphics.h			// 头文件(在 easyx.h 的基础上，保留了若干旧接口)
	├ lib32 <folder>
	│	└ libeasyx.a			// 针对 TDM-GCC MinGW 4.8.1 及以上版本的 32 位库文件
	├ lib64 <folder>
	│	└ libeasyx.a			// 针对 TDM-GCC MinGW 4.8.1 及以上版本的 64 位库文件
	└ lib-for-devcpp_5.4.0
		└ libeasyx.a			// 适用于 DevCpp 5.4.0 MinGW 4.7.2 和 C-Free 5.0
```

#### 配置说明

基本上，任何开发环境配置 easyx for mingw 都只需两步：

1. ==安装库文件==

下载的压缩包先解压缩，然后将 include 下的头文件和 lib32/lib64 下的库文件，分别拷贝到 MinGW 的头文件和库文件中。只需要拷贝一次，再写项目时不用重复拷贝。如果不知道具体的库文件路径，参考本文末尾的 QA 部分。

2. ==增加编译时的链接选项==

链接选项增加：-leasyx -lgdi32 -lole32。每个项目都要这样设置一次，然后编译即可。



### Code::Blocks 配置 EasyX 的详细说明

以下配置说明仅以官方原版 Code::Blocks 20.03（64 位）为例，下载地址：https://appzip.cn/codeblocks，假设 Code::Blocks 的安装路径为 D:\App\CodeBlocks。

#### 1. 安装库文件

下载 easyx4mingw_20220606.zip，解压缩。

将 include 文件夹下的 easyx.h 和 graphics.h 拷贝到 D:\App\CodeBlocks\MinGW\x86_64-w64-mingw32\include\ 文件夹里。

将 lib64\libeasyx.a 拷贝到 D:\App\CodeBlocks\MinGW\x86_64-w64-mingw32\lib\ 文件夹里。由于 Code::Blocks 20.03 只含有 64 位的 mingw，故只需要拷贝这一个库文件。

特别注意：因为 Code::Blocks 20.03 带的是 64 位 MinGW，所以从 lib64 下面拷贝 libeasyx.a。如果使用 Code::Blocks 17.12，自带的是 32 位 MinGW，就要从 lib32 下面拷贝 libeasyx.a。后面的 QA 部分列出了常见编译器自带的 MinGW 版本情况。

#### 2. 增加编译时的链接选项

(1) 创建新项目：菜单 File -> New -> Project...，选择 Console application，点 Go 进入项目向导。语言选择 C++，项目名称 Test，路径 D:\MyDocs\（或根据自己的情况填写），编译器选择 GNU GCC Compiler，其他选项基本不用动，完成。

(2) 编写基本测试代码，代码如下：

```cpp
#include <graphics.h>
#include <conio.h>

int main()
{
	initgraph(640, 480);
	circle(320, 240, 100);
	getch();
	closegraph();
	return 0;
}
```

(3) 设置链接库：菜单 Project -> Build options...，左侧选择项目名称 Test，右侧选择选项卡 Linker settings，然后在 Link libraries 逐个添加：libeasyx.a、libgdi32.a、libole32.a，或者也可以直接在 Link libraries 里面输入 -leasyx -lgdi32 -lole32，完成。

(4) 点工具栏按钮 Build and run 或按 F9 编译执行，可以看到屏幕画出一个圆。如果这时有编译错误，请根据错误提示修正程序。

#### 3. 生成项目模版，简化操作步骤

通过前面两步已经可以使用 EasyX 了。但是，每次写新项目都要设置链接库，有点麻烦。可以通过生成项目模版简化该过程：

菜单 File -> Save project as template...，填写模版名称：EasyX Application，完成。

下次再创建项目时，可以选择 User templates 下的 EasyX Application，然后选择路径、项目名称，直接开始编写 EasyX 绘图程序，不用再设置链接库。

### Dev-C++ 配置 EasyX 的详细说明

以下配置说明仅以 Embarcadero 发布的官方原版 Dev-C++ 6.3 为例，下载地址：https://appzip.cn/devcpp，假设 Dev-Cpp 的安装路径为 D:\App\DevCpp。

#### 1. 安装库文件

下载 easyx4mingw_20220606.zip，解压缩。

将 easyx.h 和 graphics.h 拷贝到 D:\App\DevCpp\TDM-GCC-64\x86_64-w64-mingw32\include\ 文件夹里。

将 lib64\libeasyx.a 拷贝到 D:\App\DevCpp\TDM-GCC-64\x86_64-w64-mingw32\lib\ 文件夹里。

将 lib32\libeasyx.a 拷贝到 D:\App\DevCpp\TDM-GCC-64\x86_64-w64-mingw32\lib32\ 文件夹里。

#### 2. 增加编译时的链接选项

(1) 创建新项目：菜单 File -> New -> Project...，选择 Console application，项目名称 Test，语言选择 C++，点 OK，然后将 Test.dev 保存到 D:\MyDocs\Test\（或根据自己的情况填写），完成。

(2) 编写基本测试代码，代码如下：

```cpp
#include <graphics.h>
#include <conio.h>

int main()
{
	initgraph(640, 480);
	circle(320, 240, 100);
	getch();
	closegraph();
	return 0;
}
```

Copy

(3) 设置链接库：菜单 Project -> Project Options...，选择选项卡 Parameters，然后在 Linker 区域点按钮 Add library or object 逐个添加：libeasyx.a、libgdi32.a、libole32.a，或者也可以直接在 Link libraries 里面输入 -leasyx -lgdi32 -lole32，完成。

(4) 点工具栏按钮 Compile & run 或按 F11 编译执行，可以看到屏幕画出一个圆。如果这时有编译错误，请根据错误提示修正程序。

### 3. 生成项目模版，简化操作步骤

通过前面两步已经可以使用 EasyX 了。但是，每次写新项目都要设置链接库，有点麻烦。可以通过生成项目模版简化该过程：

菜单 File -> New -> Project Template...，填写模版名称：EasyX Application，其他选项可以根据自己喜好填写，完成。

下次再创建项目时，可以直接选择 EasyX Application，然后填写项目名称、选择路径，直接开始编写 EasyX 绘图程序，不用再设置链接库。

### 常见问题

Q：我配置不好，如何确定是我本机的问题，还是库的问题？有没有封装好的给我测试一下？

A：封装好 EasyX 的 DevC++5.11 绿色版：https://pan.baidu.com/s/1lZNDkoPIIgLXp7OxXACopQ（提取码：p8ek）。使用方法：

1. 解压到 D:\App\DevCpp 下。
2. 运行 devcppPortable.exe（已设置好中文环境）。
3. 创建新项目，选择 Multimedia 下面的 EasyX Application。
4. 粘贴前文提到的测试代码，编译运行。

如果可以看到画出一个圆，表示库没有问题。此时，可以选择使用这个版本的 DevC++，也可以再尝试排查自己之前的配置步骤有什么问题。

Q：文件夹好多，我究竟应该把库文件拷贝到哪里？

A：不同的集成开发环境，所集成的 MinGW 版本不同，配置的路径也不完全一致。下表列出了常见集成开发环境默认的头文件和库文件路径：

| 集成开发环境               | 头文件路径                                     | 32 位库文件路径                                              | 64 位库文件路径                            |
| -------------------------- | ---------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------ |
| Code::Blocks 20.03         | 安装路径\MinGW\x86_64-w64-mingw32\include      | (无)                                                         | 安装路径\MinGW\x86_64-w64-mingw32\lib      |
| Code::Blocks 17.12         | 安装路径\MinGW\include                         | 安装路径\MinGW\lib                                           | (无)                                       |
| Code::Blocks 16.01         | 安装路径\MinGW\include                         | 安装路径\MinGW\lib                                           | (无)                                       |
| Code::Blocks 13.12         | 安装路径\MinGW\include                         | 安装路径\MinGW\lib                                           | (无)                                       |
| Dev-C++ 6.3                | 安装路径\TDM-GCC-64\x86_64-w64-mingw32\include | 安装路径\TDM-GCC-64\x86_64-w64-mingw32\lib32                 | 安装路径\TDM-GCC-64\x86_64-w64-mingw32\lib |
| Dev-C++ 5.11               | 安装路径\MinGW64\x86_64-w64-mingw32\include    | 安装路径\MinGW64\x86_64-w64-mingw32\lib32                    | 安装路径\MinGW64\x86_64-w64-mingw32\lib    |
| Dev-C++ 5.8.0              | 安装路径\MinGW64\x86_64-w64-mingw32\include    | 安装路径\MinGW64\x86_64-w64-mingw32\lib32                    | 安装路径\MinGW64\x86_64-w64-mingw32\lib    |
| Dev-C++ 5.4.0（蓝桥杯版*） | 安装路径\MinGW32\include                       | 安装路径\MinGW32\lib（需使用 lib-for-devcpp_5.4.0\libeasyx.a） | (无)                                       |
| C-Free 5.0                 | 安装路径\mingw\include                         | 安装路径\mingw\lib（需使用 lib-for-devcpp_5.4.0\libeasyx.a） | (无)                                       |

注：蓝桥杯版，指蓝桥杯官网提供的 Dev-C++ 5.4.0 版本。官方的 Dev-C++ 5.4.0 分两个版本，蓝桥杯使用的是其中的 32 位的 mingw 版。

Q：创建项目模版时提示错误：Unable to write to C:\Program Files (x86)\Embarcadero\Dev-Cpp\Templates\EasyX Application.template。

A：如果将 Dev-C++ 安装到 C:\Program Files 下面，那么文件的修改是需要管理员权限的。所以，用管理员权限启动 Dev-C++，再重复创建项目模版的步骤即可。成功创建项目模版后，平时使用时，不需要管理员权限启动。

Q：我以前安装过其他版本的 Dev-C++，这次严格按照教程来操作，还是有问题，请问怎么解决？

A：一些老版本的 Dev-C++ 的遗留配置文件可能会对新版本产生影响，配置文件路径为：C:\Users\[用户名]\AppData\Roaming\Dev-Cpp，将整个文件夹删掉就好。如果不好找到，就在文件管理器的地址栏输入 %APPDATA%\Dev-Cpp 敲回车，就可以自动跳转到该文件夹，删除即可。

Q：粘贴一些示例代码后，提示无法使用 _getch 函数。

A：用 getch 替代。

Q：系统里安装了多个编译器会有影响吗？

A：很可能会。请检查编译器设置：

- 对于 Code::Blocks，菜单 Settings / Compiler...，Global compiler settings 下，Selected compiler 选择 GNU GCC Compiler，下面的 Toolchain executables 选项卡里检查一下 Compiler's installation directory，是不是 Code::Blocks 文件夹下的 MinGW。如果你的 Code::Blocks 安装路径是 D:\App\CodeBlocks，那么这里的编译器路径应该是 D:\App\CodeBlocks\MinGW。
- 对于 Dev C++ 6.3，菜单 Tools/Compiler Options...，下面的 Directories 选显卡，检查 Binaries、Libraries、C Includes、C++ Includes，是不是在 Dev C++ 的安装路径下。

Q：怎么也配置不好，找不到问题在哪，怎么解决？

A：重点检查一下“编译日志”。以官方原版 Dev-Cpp 6.3 为例，配置好之后，点击“全部重新编译”（或按 F12），然后看编译日志：

![img](https://codebus.cn/f/a/0/0/488/easyx4mingw.png)

以示例中的 Dev-Cpp 6.3 环境为例，编译参数为：

```cpp
g++.exe -c main.cpp -o main.o -I"D:/App/Dev-Cpp/TDM-GCC-64/include" -I"D:/App/Dev-Cpp/TDM-GCC-64/x86_64-w64-mingw32/include" -I"D:/App/Dev-Cpp/TDM-GCC-64/lib/gcc/x86_64-w64-mingw32/9.2.0/include" -I"D:/App/Dev-Cpp/TDM-GCC-64/lib/gcc/x86_64-w64-mingw32/9.2.0/include/c++"
g++.exe main.o -o Test.exe -L"D:/App/Dev-Cpp/TDM-GCC-64/lib" -L"D:/App/Dev-Cpp/TDM-GCC-64/x86_64-w64-mingw32/lib" -static-libgcc -lEasyX -lgdi32 -lole32
```

- [猫屁股](https://home.redid.cn/user/09dd0438-fed2-d98e-1a13-aa8448988086)

  您好，请问这步：“3. 设置链接库：菜单 Project -> Build options... ，左侧选择项目名称 Test，右侧选择选项卡 Linker settings，然后在 Link libraries 逐个添加：libEasyX.a、libgdi32.a、libole32.a，完成。（这步也可以直接在 Link libraries 里面输入 -lEasyX -lgdi32 -lole32）”添加的时候默认打开的文件夹里面没有这三个文件怎么办呢？在Dev-Cpp文件夹里面找到的这几个文件添加后还是不行。

- main.o main.cpp:(.text.startup+0xf): undefined reference to `ege::getinitmode()'
  main.o main.cpp:(.text.startup+0x27): undefined reference to `ege::initgraph(int, int, int)'
  main.o main.cpp:(.text.startup+0x4b): undefined reference to `ege::circle(int, int, int, ege::IMAGE*)'
  main.o main.cpp:(.text.startup+0x50): undefined reference to `ege::getch()'
  main.o main.cpp:(.text.startup+0x55): undefined reference to `ege::closegraph()'
  collect2.exe [Error] ld returned 1 exit status
  mingw32-make *** [E:\source\C++\test\Makefile.win:26: test.exe] Error 1
  - 这是因为你所使用的集成开发环境中已经配置了 EGE 图形函数库。该库的头文件也叫做 graphics.h，但是你的程序中调用 EasyX 中的函数。所以编译器报告说找不到这些函数。

[BestAns](https://home.redid.cn/user/6b0dc13a-e624-651a-5a14-41d39d24a38b)

注意，启动的时候，执行devcppPortable.exe，这个用的是文件夹里的配置。如果启动devcpp.exe，可能会受到你电脑其它编译器的影响。

- 请大家遇到跟我一样的问题时：注意是否因为电脑有多个编译器导致codeblock运行当前的编译器选择为其他软件的编译器(要用codeblock原版的编译器)，然后还有就是include文件夹里的.h是否已经完全拷贝......（可能是因为各种原因比如重装，编译器太多你拷错地方了）

- codeblock 错误:
  D:\CodeBlocks\project\aaaaaa\main.cpp|7|undefined reference to `initgraph(int, int, int)'|
  D:\CodeBlocks\project\aaaaaa\main.cpp|8|undefined reference to `circle(int, int, int)'|
  D:\CodeBlocks\project\aaaaaa\main.cpp|10|undefined reference to `closegraph()'|
  ||error: ld returned 1 exit status|
  ||=== Build failed: 4 error(s), 1 warning(s) (0 minute(s), 0 second(s)) ===|

- 每次新建项目都提示“No such file or directory”，需要重新add库

  你创建项目模版成功了吗？项目模版记录了引用库的信息，从项目模版创建新项目，不会出现你说的问题。

  

## 对于 VSCode + MSVC （不常用）

### 1. 在 VS Code 配置好 Microsoft Visual C++ 的编译环境

请先按照微软的要求进行配置，参考：https://code.visualstudio.com/docs/cpp/config-msvc

配置好以后，尝试创建一个普通的 C++ 程序进行测试。确认无误后，再进行下一步安装 EasyX。

### 2. 安装 EasyX

下载最新的 EasyX 安装包，右击解压缩，得到相关的 .h 和 .lib 文件，分别拷贝到你的编译环境的对应路径中即可。参考：https://docs.easyx.cn/setup

### 3. 使用

由于微软的 C/C++ 编译环境需要配置若干环境变量，必须在 Developer Command Prompt for VS2019 里面启动 VSCode，所以，这听起来貌似不那么方便。所以，一些人自己写了适合自己习惯的脚本来简化这个过程。例如你可以参考：

- https://tieba.baidu.com/p/6828589887
- https://www.cnblogs.com/alex-zen/p/11376705.html

# 多说一句

如果觉得 VS2019 体积大，可以试试 VC2010学习版，体积很小，无需配置，即装即用。并且 EasyX 也可以自动配置，全过程不超过 1 分钟。下载地址：https://appzip.cn/vc2010