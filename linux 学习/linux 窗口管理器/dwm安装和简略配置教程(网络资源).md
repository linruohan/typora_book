# DWM安装及简略配置教程

[toc]



## 一、安装
### 1.添加用户
```bash
# pacman -S base-devel		# 安装开发工具集,里面有编译源码的make工具
# useradd -m -G wheel kler	# 添加一个用户到wheel用户组，用于日常操作
# passwd kler
# pacman -S vi
# visudo					# 必须先安装vi，才能使用visudo快捷命令，否则只能找到文件进行更改
```
### 2.找到# %wheel ALL=(ALL) ALL,按下x,删除前面的#号,然后wq保存退出

### 3.安装DWM的依赖组件xorg
```bash
# su kler
$ sudo pacman -S xorg-server
$ sudo pacman -S xorg-apps
$ sudo pacman -S xorg-xinit

$ sudo pacman -S noto-fonts-cjk		#安装中日韩字体，避免不能正常显示
$ sudo pacman -S w3m				# 安装终端内网页浏览器，用于下载dwm源码
$ w3m suckless.org					# 访问dwm官网，下载源码
```
### 4.找到DWM标签，Enter进入页面，下拉找到dwm_6.2,Enter下载,下载完成后qy退出。
```bash
$ tar -zxvf dwm-6.2				# 解压压缩包
$ cd dwm-6.2
$ make							# 编译源码包
$ sudo make clean install		# 安装源码包
$ cd ~							# 返回家目录
$ vim .xinitrc
exec dwm
```
### 5.使用同样的方法安装st和dmenu

在dwm上官网下载解压st和dmenu，然后编译安装
(dmenu在tools栏目里)

### 6.安装显卡驱动

$ sudo pacman -S nvidia		# 安装英伟达显卡驱动，其他显卡驱动请参看archwiki
## 二、DWM左侧图标设置
### 1.首先安装图标字体nerd-fonts和font-awesome

awesome及桌面配置：https://wiki.archlinux.org/index.php/Awesome

```bash

$ sudo pacman -Ss nerd-fonts
$ sudo pacman -S ttf-nerd-fonts-symbols-mono
$ sudo pacman -Ss font-awesome
$ sudo pacman -S otf-font-awesome
```
### 2.安装适合编程的等宽字体anonymous-pro、source-code-pro

```bash
$ sudo pacman -Ss anonymous-pro 
$ sudo pacman -S ttf-anonymous-pro
$ sudo pacman -Ss source-code-pro
$ sudo pacman -S adobe-source-code-pro-fonts
```
### 3.设置dwm字体和左侧状态栏图标

```bash
$ nvim ~/.local/applications/dwm/dwm-6.2/config.h
static const char *fonts[] = {"Symbols Nerd Font:size=14"};		/*设置dwm采用图标字体*/
static const char *tags[] = {"\ue795","\ufc6e","\ue235","\uf308"};		/*图标对应的ASCLL码：https://www.nerdfonts.com/cheat-sheet*/
```
## 三、安装DWM自动执行脚本补丁
### 1.下载补丁

### 2.将自动运行脚本的补丁复制到dwm的安装目录

```bash
# cp dwm-autostart-20161205-bb3bd6f.diff ~/.local/applications/dwm/dwm-6.2/
```
### 3.安装自动运行脚本的补丁

```bash
# cd ~/.local/applications/dwm/dwm-6.2/
# patch < dwm-autostart-20161205-bb3bd6f.diff
```
### 4.切换到dwm安装目录，编辑dwm.c文件的runAutostart函数

```bash
runAutostart(void) {
     system("cd ~/kler_profiles/.dwm; ./autostart.sh &");
}
```
## 四、设置DWM状态栏
### 1.编写~/kler_profiles/.dwm/autostart.sh文件

```bash
#!/bin/bash
/bin/bash ~/kler_profiles/.dwm/dwm-status.sh &
```
### 2.编写dwm每秒刷新状态栏~/kler_profiles/.dwm/dwm-status.sh文件

```bash
#!/bin/bash

while true
do
    bash ./dwm-status-refresh.sh
    sleep 1
done
```
### 3.编写dwm状态栏的配置~/kler_profiles/.dwm/dwm-status-refresh.sh文件

```bash
#!/bin/bash

#battery
Battery=$(cat /sys/class/power_supply/BAT1/capacity)%
BatteryStatus=$(cat /sys/class/power_supply/BAT1/status)
if [[ $BatteryStatus == D* ]];then
    BatteryStatus='未充电'
else
    BatteryStatus="充电中"
fi

# backlight
BackLight=$(xbacklight | cut -d. -f1)

# volume
Volume=$(amixer get Master |tail -n1 |cut -d'[' -f4 |cut -d']' -f1)
if [[ $Volume == off ]];then
    Volume='mute'
else
    Volume=$(amixer get Master | sed -n '5p' | cut -d'[' -f2 | cut -d% -f1)
fi

# datetime
DateTime=$(date +"%a %m-%d %T" )
xsetroot -name "Bat.$BackLight|Vol.$Volume|$DateTime|[$BatteryStatus:$Battery]"
```
### 赋予～/kler_profiles/.dwm/目录下的文件执行权限

```bash
#  sudo chmod -R +x ~/kler_profiles/.dwm/
```
## 五、设置DWM自动更换壁纸
### 1.创建壁纸目录

```bash
# mkdir -p ~/pictures/wallpapers
```
### 2.安装图片查看器feh,编写更换壁纸的配置文件

```bash
# pacman -Ss feh
# nvim ~/kler_profiles/.dwm/dwm-wallpaper.sh
```
```bash
#!/bin/bash

while true
do
  feh --recursive --randomize --bg-fill ~/pictures/wallpapers/
  sleep 5m
done
```
### 3.启动DWM时，自动执行壁纸配置文件

```bash
# nvim ~/kler_profiles/.dwm/autostart.sh

#!/bin/bash

/bin/bash ~/kler_profiles/.dwm/dwm-wallpaper.sh &
```
## 六、picom安装及配置
picom是Xorg的独立合成器，适用于不提供合成功能的窗口管理器（例如 i3，dwm）
他可以给窗口设置淡入淡出、半透明、阴影等视觉效果。

### 1.安装picom

`sudo pacman -Ss picom`

### 2.picom的默认配置文件路径为/etc/xdg/picom.conf

### 3.创建用户的picom配置文件

```bash
# mkdir -p ~/.config/picom
# cp /etc/xdg/picom.conf ~/.config/picom/
```

### 4.picom.conf配置文件

```bash
picom配置文件的每一项都示例及说明，一共包含五个部份。
第一部份：Shadows（阴影设置）
第二部份：Fading（渐变设置）
第三部份：Transparency/Opacity（透明度设置）
第四部份：Background-Blurring（背景模糊设置）
第五部份：General Setting（常规设置）
```
## 七、picom对特定窗口设置
如果你不想让浏览器变的透明化，这时你就需要对浏览器进行特殊设置，就会用到选择器。
就比如现在要获取firefox浏览器的选择器.

### 1.确定窗口的值，比如class_g,id,name。在终端输入

```bash
# xprop
或
# xwininfo
```
### 2.点击需要查找的窗口，以xprop为例，会在终端输出如下内容

```bash
_NET_WM_OPAQUE_REGION(CARDINAL) = 0, 0, 540, 741
_NET_WM_WINDOW_TYPE(ATOM) = _NET_WM_WINDOW_TYPE_NORMAL
_NET_WM_SYNC_REQUEST_COUNTER(CARDINAL) = 14680148, 14680149
_NET_WM_USER_TIME(CARDINAL) = 23929732
_NET_WM_USER_TIME_WINDOW(WINDOW): window id # 0xe00053
WM_CLIENT_LEADER(WINDOW): window id # 0xe00001
_NET_WM_PID(CARDINAL) = 417157
WM_LOCALE_NAME(STRING) = "en_US.UTF-8"
WM_CLIENT_MACHINE(STRING) = "FZ"
WM_NORMAL_HINTS(WM_SIZE_HINTS):
                program specified minimum size: 450 by 95
                program specified maximum size: 16384 by 16384
                program specified base size: 450 by 95
                window gravity: NorthWest
WM_PROTOCOLS(ATOM): protocols  WM_DELETE_WINDOW, WM_TAKE_FOCUS, _NET_WM_PING, _NET_WM_SYNC_REQUEST
WM_CLASS(STRING) = "Navigator", "firefox"
WM_ICON_NAME(STRING) = "Mozilla Firefox"
_NET_WM_ICON_NAME(UTF8_STRING) = "Mozilla Firefox"
WM_NAME(STRING) = "Mozilla Firefox"
_NET_WM_NAME(UTF8_STRING) = "Mozilla Firefox"
```

### 3.根据WM_CLASS或者WM__NAME的值进行设置，例如设置firefox浏览器不透明

```bash
# nvim ~/.config/picom/picom.conf
opacity-rule = [
"100:class_g = 'firefox'",
"100:name *? = 'firefox'",
];
```

# Ubuntu DWM安装配置文档

## 前言

本教程直接使用本人配置好的DWM，建议新手直接使用我的配置，等上手之后在在行下载官方源码进行编译安装配置。

## 关于DWM

可以看B站CW大佬的[视频](https://link.zhihu.com/?target=https%3A//www.bilibili.com/video/BV11J411t7RY)

## 准备工作

### 基础依赖

```text
$ sudo apt-get install suckless-tools libx11-dev libxft-dev libxinerama-dev gcc make
```

### 后期功能性软件

透明配置支持

```text
$ sudo apt install compton

或者用下面的工具

$ sudo apt install xcompmgr
```

背景图片设置工具

```text
$ sudo apt install feh
```

电源监控工具

```text
$ sudo apt install acpi acpitool
```

背光灯调整工具

```text
$ sudo apt install light
```

为背光灯调整工具设置sudo免密码

```text
$ sudo visudo
```

然后在文本最后加入如下代码

```text
{登录系统的用户名} ALL=NOPASSWD:/usr/bin/light
```

安装截图工具

```text
$ sudo apt install flameshot
```

安装数字键盘工具

```text
$ sudo apt install numlockx
```

虚拟机可能需要以下软件

virtualbox

```text
$ sudo apt-get install virtualbox-guest-utils virtualbox-guest-X11
```

vmware

```text
$ sudo apt-get install open-vm-tools open-vm-desktop
```

## DWM安装

获取源码

```text
$ git clone https://github.com/chuanzhangjiang/dwm.git
```

移动到源码目录修改config.h文件，自行修改下图中用户目录名称



![img](https://pic2.zhimg.com/80/v2-ca24f110f5ec032591f53cb0f6c87d4d_720w.jpg)修改



获取dwm自定义脚本

```text
$ git clone https://github.com/chuanzhangjiang/dwm-script.git
```

将脚本文件软链接到`～/.dwm`目录

```text
$ ln -s  ~/dwm-script的目录 ~/.dwm
```

移动到dwm源码目录执行安装命令

```text
$ sudo make clean install
```

## 设置DWM启动方式

有两种启动方式可以选择

### ==使用display manager启动==

以ubuntu 20.04为例,ubuntu 20.04使用gdm3做为display manager，配置完成之后可以在登录界面选择dwm作为桌面启动，如下图：

<img src="https://pic4.zhimg.com/80/v2-4882d922beda138d5e779beff552187b_720w.jpg" alt="img" style="zoom:33%;" />入口

具体配置方式，进入`/usr/share/xsessions/`目录，新建文件`dwm.desktop`,输入内容：



```text
[Desktop Entry]
Encoding=UTF-8
Name=Dwm
Comment=Dynamic window manager
Exec=dwm
Icon=dwm
Type=XSession
```

### 使用startx命令从文字界面启动(推荐)

此方式开机更加快速，使用更加灵活，系统资源占用更少。

**首先将系统改为默认进入文字界面**

修改grub配置,打开文件`/etc/default/grub`,将`GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"`的改为`GRUB_CMDLINE_LINUX_DEFAULT="text"`然后执行命令

```text
$ sudo update-grub
```

将启动等级改为多用户等级，执行如下命令：

```text
$ systemctl set-default multi-user.target 
// 如果想改回启动图形界面执行下面
$ systemctl set-default graphical.target
```

最后修改`~/.xsession`文件（如果没有就新建），在最后一行加入

```text
exec dwm
```

重启电脑，执行startx命令，直接进入dwm，同时也可以执行`sudo systemctl start gdm.service`命令，打开gdm3的用户登录界面。

## 为软件指定打开标签

```text
xprop | grep WM_CLASS
```

鼠标会变为十字架,用十字架点击想要被指定的软件的打开窗口，terminal就会显示该软件的instance和class:

```text
WM_CLASS(STRING) = instance, class
```

将信息填入config.h的下列位置:

![img](https://pic2.zhimg.com/80/v2-d4df0957054d82e5bdfb61da83a57599_720w.jpg)rule



`tags mask`用于指定打开的表情序号，一号标签为二进制`000000001`,二号为`000000010`,类推。

重新编译安装即可。 完。