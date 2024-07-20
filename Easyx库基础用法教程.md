---
number headings: auto, first-level 2, max 6, _.1.1
---

# Easyx库基础用法教程

[toc]

许多人学习编程都是从c语言入门的，但目前现状是：

- 学校只交基础语法，一直都是在枯燥的黑色控制台上进行练习，十分无聊，大大减弱了我们的学习热情
- 即使有的学校交图形编程，也是使用一些难度较高的，比如Win32,OpenGL门槛就很高，初学者很容易受打击
- 而且我们也难在程序中加入有趣的图像或者图行，做出的c语言小游戏也只局限于文本风格
- 那有没有即容易上手，学习门槛又不高的呢，于是就有了Easyx库，ok,冲冲冲；
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/0b5b32fb2b174df78b1192e0f6c0856e.png#pic_center)

------

1.Easyx库

## 1 1.1简单介绍

首先Easyx是针对C++的[图形库](https://so.csdn.net/so/search?q=图形库&spm=1001.2101.3001.7020)，可以帮组C/C++初学者快速上手图形和游戏编程，比如可以基于Easyx图形库画一个房子，或者一辆移动 的小车，可以编程俄罗斯方块，贪吃蛇，和白棋等小游戏。详情见文档链接[Easyx帮助文档](https://docs.easyx.cn/zh-cn/intro)

### 1.1 1.2Easyx原理

基于Windows图形编程，将Windows下的复杂程序过程进行封装，将windows下的编程过程隐藏，给用户提供一个简单熟悉的接口（函数），用户对于图像库中函数的调用，最终都会由Windows的底层API（函数）实现。

# 2.Easyx基础知识

## 1 2.1Easyx颜色

1. 相信大家都知道，光的三原色是**红，绿，蓝**。咋们表示颜色就用三原色来表示
2. 用RGB宏合成颜色，实际上合成出的颜色是一个十六进制的整数。RGB(红色部分，绿色部分，蓝色部分)；每个颜色部分值为0~255

### 1.1 2.2Easyx坐标和设备

1. 坐标默认的原点在窗口的左上角，X向右为正，Y向下为正，度量单位是像素点。
2. 设备：就是绘图表面，在Easyx中，设备分两种，一种是默认的绘图窗口，另一种是IMAGE对象。通过SetWorkingmage()函数可以设置当前用于绘图的设备。设置当前用于绘图的设备后，所有的绘图函数都会绘制在该设备上（后面再理解）

# 3.Easyx图形编程----[窗口函数](https://so.csdn.net/so/search?q=窗口函数&spm=1001.2101.3001.7020)

## 1 initgraph()创建窗口函数

```c
void initgraph(int width,int height,int flag=NULL)
1. width指创建窗口的宽度
 2.height指创建窗口的高度
 3.flag指创建窗口的样式，默认为NULL
 #define SHOWCONSOLE		1		// 创建图形窗口时，保留控制台的显示
#define NOCLOSE			2		// 没有关闭功能
#define NOMINIMIZE		4		// 没有最小化功能
1234567
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(1024,480);
	getchar();
	//关闭窗口，closegraph();
	closegraph();

	return 0;
}
123456789101112
```

![运行结果](https://img-blog.csdnimg.cn/de64219ad3634f38aa6d9fe059d48125.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

***需要注意的是此时的窗口没有滚动条，也就是说该窗口不是控制台，而是由窗口创建函数创建的一个绘制窗口***( •̀ ω •́ )✧

### 1.1 closegraph()关闭绘图窗口函数

```
 此函数是与窗口创建函数搭配使用的函数，关闭窗口
```

#### 1.1.1 cleardevice()清空绘图设备函数

# 图形绘制函数–画圆为例（部分）

## 1 circle()–无填充

```
  void circle(int x,int y,int R)
  x是纵坐标，y是横坐标，R是圆的半径（窗口原点坐标默认为在左上角）
12
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(640, 480);
	//例如画一个原点在（50.50），半径为50的圆
	circle(50,50,50);
	getchar();
	//关闭窗口，closegraph();
	closegraph();

	return 0;
}
1234567891011121314
```

![运行结果](https://img-blog.csdnimg.cn/c79f38b860344e7fbacec27d57c01eda.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

### 1.1 fillcircle()–有边框填充

```
  与上一个函数用法一致，但圆有边框填充
1
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(640, 480);
	//例如画一个原点在（50.50），半径为50的圆
	setfillcolor(YELLOW);//圆的填充颜色函数
	setlinecolor(BLUE);//边框线条颜色函数
	setlinestyle(PS_SOLID, 10);//边框线条形式函数
	//circle(50,50,50); //无填充
	fillcircle(50, 50, 50);//有边框填充
	//solidcircle(50, 250, 50);//无边框填充
	getchar();
	//关闭窗口，closegraph();
	closegraph();

	return 0;
}
12345678910111213141516171819
```

![运行结果](https://img-blog.csdnimg.cn/325aae6c61a94b29b4548b9ec84670fa.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

#### 1.1.1 solidcircle–无边框填充

与上一个函数用法一致，但圆无边框填充

```cpp
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(640, 480);
	//例如画一个原点在（50.50），半径为50的圆
	setfillcolor(YELLOW);//圆的填充颜色函数
	setlinecolor(BLUE);//边框线条颜色函数
	setlinestyle(PS_SOLID, 10);//边框线条形式函数
	//circle(50,50,50); //无填充
	//fillcircle(50, 50, 50);//有边框填充
	solidcircle(50, 50, 50);//无边框填充
	getchar();
	//关闭窗口，closegraph();
	closegraph();

	return 0;
}
12345678910111213141516171819
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/a63d056d8e69420f81fde85e391a97e6.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

# 4.背景颜色函数

## 1 4.1setbkcolor()–背景颜色设置函数

```cpp
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(400,480);
	setbkcolor(RED);
	cleardevice();
	getchar();
	//关闭窗口，closegraph();
	closegraph();
	return 0;
}
12345678910111213
```

![运行结果](https://img-blog.csdnimg.cn/3b37d09f9adb456a8bd1b1562fe1a707.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

### 1.1 4.2cleardevice()–清屏函数

```
   ***正如上方setbkcolor()函数的用法，cleardevice()函数必须在设置完新的背景颜色后才清楚上一个背景颜色***🐱‍🚀
1
```

# 5.窗口文字绘制函数

## 1 outtextxy()指定位置输出[字符串](https://so.csdn.net/so/search?q=字符串&spm=1001.2101.3001.7020)函数

```
  void outtextxy(int x,int y,char*str);
  (x,y)窗口坐标，str为要输入的字符数组名或字符串
12
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(400, 480);
	outtextxy(100, 100,L"我是帅比");
	getchar();
	//关闭窗口，closegraph();
	closegraph();
	return 0;
}
123456789101112
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/a528ff5b1e0c44c4a9317e5ebfdec5f3.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

***注意👀：为什么要在字符串前面加一个L呢？，其实是由于字符集导致的，解决方案就是在字符串前面加上L,或者在项目->属性->常规->字符集改为多字符集即可。
还有一个问题就是有的小伙伴认为既然是输出字符串那为什么不直接scanf函数打印呢，原因其实是有的同学在这里把控制台和这里的项目窗口搞混淆了，scanf函数的字符串输出只能打印在控制台窗口上，而项目窗口是不能直接用scanf函数读入，并用printf函数打印的🐱‍🚀***

### 1.1 settextcolor（）设置当前文字颜色函数

```cpp
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(400, 480,NOMINIMIZE);
	settextcolor(RED);//设置文字颜色
	outtextxy(100, 100,L"我是帅比");//指定位置打印字符串
	
	getchar();
	//关闭窗口，closegraph();
	closegraph();
	return 0;
}
1234567891011121314
```

![运行结果](https://img-blog.csdnimg.cn/20ce6b740e5a4e23aa18ed62b6aa477d.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)
***注意👀：一定是先设置文字颜色在输出文字***

#### 1.1.1 settextstyle（）设置字体样式函数

```
       void settextstyle(int nHeight,int nWidth,LPCTSTR lpszFace);
       nHeight  指定高度（逻辑单位）
       nWidth 字符的平均宽度（逻辑单位）。如果为 0，则比例自适应
       lpszFace字体名称。
1234
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(400, 480,NOMINIMIZE);
	settextstyle(20,0,L"楷体");//设置字体形式（高度，宽度，字体）
	setbkmode(TRANSPARENT);//考虑到文字背景也有默认颜色，可能发生遮挡，所以将文字背景改为透明
	outtextxy(100, 100,L"我是帅比");//指定位置打印字符串
	
	getchar();
	//关闭窗口，closegraph();
	closegraph();
	return 0;
}
123456789101112131415
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/4eece42c1f8041fc8829a989000d0887.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)
***注意👀：区分这里的文字背景透明的setbkmode函数与上方讲窗口背景颜色设置中的cleardevice函数的区别***

##### 1.1.1.1 textheight()获取字符串实际占用的像素高度（调整字符串）

```
  计算字符串的像素高度
1
```

###### 1.1.1.1.1 textwidth获取字符串实际占用的像素宽度（调整字符串）

```
 计算字符串的像素宽度
1
```

# 6.窗口图像处理函数

## 1 6.1使用图像函数须知

```
   ***与前面直接使用的函数不同的是：在使用图像之前，需要定义一个变量，然后把图片加载进变量才能使用。Easyx为我们提供了了变量类型IMAGE，如IMAGE img。***
1
```

### 1.1 loadimage()–从文件中读取图像函数

// 从资源文件获取图像(bmp/gif/jpg/png/tif/emf/wmf/ico)
void loadimage(
IMAGE* pDstImg, // 保存图像的 IMAGE 对象指针
LPCTSTR pResType, // 资源类型
LPCTSTR pResName, // 资源名称
int nWidth = 0, // 图片的拉伸宽度
int nHeight = 0, // 图片的拉伸高度
bool bResize = false // 是否调整 IMAGE 的大小以适应图片
);

#### 1.1.1 putimage()–当前设备上绘制图像函数

// 绘制图像(指定宽高和起始位置)
void putimage(
int dstX, // 绘制位置的 x 坐标
int dstY, // 绘制位置的 y 坐标
int dstWidth, // 绘制的宽度
int dstHeight, // 绘制的高度
IMAGE *pSrcImg, // 要绘制的 IMAGE 对象指针
int srcX, // 绘制内容在 IMAGE 对象中的左上角 x 坐标
int srcY, // 绘制内容在 IMAGE 对象中的左上角 y 坐标
DWORD dwRop = SRCCOPY // 三元光栅操作码
);

```cpp
//两函数组合使用如下
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(400, 480,NOMINIMIZE);
	IMAGE img;//创建一个加载图像的变量
	loadimage(&img, "./mm.jpg",400,480);//加载图像
	putimage(0, 0, &img);//在窗口中打印图像
	getchar();
	//关闭窗口，closegraph();
	closegraph();
	return 0;
}
123456789101112131415
```

![运行结果](https://img-blog.csdnimg.cn/01b315d825374d6685cb481d1d678c0b.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/91f35f178370443db863186bf77e1c26.png#pic_center)

注意🐱‍🚀👀：图片的存储位置一定要放在相应的项目文件夹中如图
![在这里插入图片描述](https://img-blog.csdnimg.cn/7be39e0ef78845b1ae3f0745cb55220d.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

# 7.获取鼠标信息函数

## 1 7.1使用鼠标信息函数须知

```
   ***与窗口图像处理函数相同，在使用鼠标处理函数之前也要先定义一个鼠标信息结构体变量即类型为ExMessege,因为我们是初学者，所以先学习结构体中的成员变量，成员变量一message：其中包括（鼠标左键信息，鼠标右键信息，滚轮，），成员变量二，X：鼠标当前横坐标，成员变量三，Y：鼠标当前纵坐标***
1
```

### 1.1 peekmessege()–检查是否有鼠标消息函数

```cpp
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(400, 480, EW_SHOWCONSOLE);
	solidcircle(0, 0, 50);//无边框填充画圆
	while (true)
	{
		ExMessage msg = { 0 };
		if (peekmessage(&msg, EM_MOUSE));//检测鼠标信息
		{
			switch (msg.message)//筛选鼠标信息类型
			{
			case WM_LBUTTONDOWN://左键信息
				if (msg.x >= 0 && msg.x <= 50 && msg.y >= 0 && msg.y <= 50)
				{
					printf("左键激活\n");
				}
				break;
			default:
				break;
			}
		}
	}
	getchar();
	//关闭窗口，closegraph();
	closegraph();
	return 0;
}
123456789101112131415161718192021222324252627282930
```

![运行结果](https://img-blog.csdnimg.cn/662acbb85f87436986ac1d3d0b663dc0.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

1. ***注意🐱‍🚀👀：这里只举了鼠标左键的操作，希望大家照猫画虎，也可以独自完成右键等其他激活***
2. ![在这里插入图片描述](https://img-blog.csdnimg.cn/284cc44014cd44f58c54c1003e6dea01.png#pic_center)

# 8.非Easyx函数–键盘消息函数

## 1 8.1使用键盘消息函数须知

```
   getch()函数需要引用头文件conio.h,GetAsyncKeyState(键值)需要引头文件windows.h,但是由于Easyx包含了windows.h,所以无需自己包含。
   getch()需要使用返回值来判断
   1. 与非ASCLL表字符的按键比较，需要使用虚拟键值（上:72,下:80,左:75,右:77）
   2.如果是与字母比较直接写字母如‘A’
   GetAsyncKeyState(键值）：
   1.需要传入一个键值，如果按下返回（上:VK_UP,下:VK_DOWN,左:VK_LEFT,右:VK_RIGHT）
    为了防止控制物体移动打印时窗口发生频闪，我们可以使用双缓冲绘图避免频闪，即在绘画代码块前后分别加上FlushBatchDraw()和EndBatchDraw()
1234567
```

### 1.1 getch()–获取键盘消息函数(第一种)

```cpp
#include<conio.h>
#include<stdio.h>
#include<easyx.h>
//#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(400, 480, EW_SHOWCONSOLE);
	int x=50;
	int y=50;
	while (true)
	{
		cleardevice();//清除上一次绘画的图形防止发生重叠
		solidcircle(x, y, 50);//无边框填充画圆
		char input;
		input=_getch();
		switch (input)
		{
		//case 119:
		case 'w':
		case 'W':
			y -= 3;
			printf("向上移动\n");
			break;
		//case 115:
		case 's':
		case 'S':
			y += 3;
			printf("向下移动\n");
			break;
		//case  97:
		case 'a':
		case 'A':
			x -= 3;
			printf("向左移动\n");
			break;
		//case 100:
		case 'd':
		case 'D':
			x += 3;
			printf("向右移动\n");
			break;
		}
	}
	getchar();
	//关闭窗口，closegraph();
	closegraph();
	return 0;
}
12345678910111213141516171819202122232425262728293031323334353637383940414243444546474849
```

***这里由于不能发本地视频，所以大家可以拷贝代码在vs上试一试，查看效果😂😂😂😂😂
如果你尝试之后就可以发现，这种方式只能让图形直线移动，并不能像游戏角色可以斜着移动，那我们紧接着学习下一个函数***

#### 1.1.1 GetAsyncKeyState()–获取键盘消息函数(第二种)

```cpp
#include<stdio.h>
#include<easyx.h>
//#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(650, 650, EW_SHOWCONSOLE);
	int x = 10;
	int y = 10;
	while (true)
	{
		FlushBatchDraw();
		cleardevice();//清除上一次绘画的图形防止发生重叠
		solidcircle(x, y, 10);//无边框填充画圆
		EndBatchDraw();
		if (GetAsyncKeyState(VK_UP))
		{
			y -= 1;
			printf("向上运动");
		}
		if (GetAsyncKeyState(VK_DOWN))
		{
			y += 1;
			printf("向下运动");
		}
		if (GetAsyncKeyState(VK_LEFT))
		{
			x -= 1;
			printf("向左运动");
		}
		if (GetAsyncKeyState(VK_RIGHT))
		{
			x += 1;
			printf("向右运动");
		}
	}
	getchar();
	//关闭窗口，closegraph();
	closegraph();
	return 0;
}
1234567891011121314151617181920212223242526272829303132333435363738394041
```

***这里由于不能发本地视频，所以大家可以拷贝代码在vs上试一试，查看效果😂😂😂😂😂
如果你尝试之后就可以发现，这种方式不仅能让图形直线移动，还可以像游戏角色可以斜着移动，🐱‍👤🐱‍👓🐱‍🏍🐱‍🐉***

# 9.Easyx函数–窗口名与消息框函数（联合使用）

## 1 消息框

```
   ***首先什么是消息框呢，我举个简单的例子，当我们在玩某个小游戏的过程中，游戏可能需要弹出一个承载是否继续或退出选项的消息框，这时我们就必须了解下列函数的联合使用***
1
```

### 1.1 消息框函数

```cpp
#include<stdio.h>
#include<graphics.h>//包含图像库头文件,仅仅适用于C++
int main()
{
	//创建一个窗口，initgraph();
	initgraph(400, 480);
	HWND hn = GetHWnd();//获取窗口句柄函数；
	SetWindowText(hn, "冰墩墩");//修改窗口名字函数
	MessageBox(hn, "我是消息框", "提示", MB_OKCANCEL);//消息框弹出设置函数
	getchar();
	//关闭窗口，closegraph();
	closegraph();
	return 0;
}
1234567891011121314
```

![运行结果](https://img-blog.csdnimg.cn/03801184639449208cd94900ab024d0e.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5pma6aOO5pC66Zyy,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

# 给窗口添加背景音乐

***没有什么是一首音乐解决不了的，如果有的话，那就两首，接下来让我们为窗口配上动听的音乐吧***
![在这里插入图片描述](https://img-blog.csdnimg.cn/996dd9bd2db746ffaa351e9ffd51a3f5.png#pic_center)

```cpp
#include<stdio.h>
#include<graphics.h>
#include<mmsystem.h>//包含多媒体设备接口头文件
#pragma comment(lib,"winmm.lib")//加载静态库
void BGM()
{
	mciSendString("open ./纯音乐.mp3", 0, 0, 0);
	mciSendString("play ./纯音乐.mp3", 0, 0, 0);


}
int main()
{
	//创建一个窗口，initgraph();
	initgraph(400,480);
	BGM();
	getchar();
	//关闭窗口，closegraph();
	closegraph();
	return 0;
}
123456789101112131415161718192021
```

***由于我的知识学习有限，其实跟前面的窗口图像设置有很多相似之处，在播放音乐环节这里就不解释了，如果大家感兴趣的话，就在这里***[查询](https://docs.easyx.cn/zh-cn/intro)
🎉🎉🎉🎉好啦恭喜你已经掌握了Easyx库的基本使用，快拿去让你的代码动起来吧😉