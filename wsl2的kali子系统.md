# 使用自带远程桌面映射出wsl2的kali子系统 OAO kali篇

[toc]



## WSL2和kali安装

### 管理员权限打开PowerShell，输入以下命令，启用Linux子系统：

```
#启用Linux子系统
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

#启用虚拟化
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart


wsl --set-version kali-linux 2
```

### **下载WSL2的Linux内核**

下载地址：[https://aka.ms/wsl2kernel](https://link.zhihu.com/?target=https%3A//aka.ms/wsl2kernel)

下载后安装。

### **设置子系统的默认版本为WSL2**

使用管理员权限打开PowerShell，输入以下命令： 如果原本就安装有WSL，可以直接升级到WSL2。`wsl --set-version kali-linux 2`

```text
wsl --set-default-version 2
```

### **安装Kali Linux**

打开应用商店，搜索安装Kali Linux。

<img src="D:\codehub\.config\win10\Typora_book\library\img\image-20211127202419856.png" alt="image-20211127202419856" style="zoom:33%;" />

## kali更新源+安装kex图形界面

### 更新国内源：sudo vi /etc/apt/sources.list

```bash
#aliyun 阿里云
deb http://mirrors.aliyun.com/kali kali-rolling main non-free contrib
#deb-src http://mirrors.aliyun.com/kali kali-rolling main non-free contrib
# ustc 中科大
deb http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
#deb-src http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
# tsinghua 清华
deb http://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main contrib non-free
#deb-src http://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main contrib non-free
#浙大源
deb http://mirrors.zju.edu.cn/kali kali-rolling main contrib non-free
#deb-src http://mirrors.zju.edu.cn/kali kali-rolling main contrib non-free

```



```
sudo apt update && sudo apt -y upgrade
```

### **安装Win-Kex工具包**

Win-Kex工具包是Kali提供的在Windows上运行的==图形化工具包==，可以一键式傻瓜化在WSL中跑图形界面。

在Kali命令行中输入命令安装：

```text
sudo apt update && sudo apt install kali-win-kex
```

### **配置Windows Terminal快捷方式**

下次就可以通过这个下拉菜单打开Kex的图形界面了。

打开Windows Terminal的配置文件，加入以下配置项：

```
{
        "guid": "{55ca431a-3a87-5fb3-83cd-11ececc031d2}",
        "hidden": false,
        "name": "Win-KeX",
        "commandline": "wsl kex wtstart",
},
{
         "guid": "{55ca431a-3a87-5fb3-83cd-11ececc031d2}",
         "hidden": false,
         "icon": "file:///c:/users/<windows user>/pictures/icons/kali-menu.png",
         "name": "Win-KeX",
         "commandline": "wsl kex wtstart",
    "startingDirectory" : "//wsl$/kali-linux/home/<kali user>"
},
```

<img src="./imgs\image-20211127203620683.png" alt="image-20211127203620683" style="zoom:33%;" />![image-20211127203638098](.\imgs\image-20211127203638098.png)

> ❝ PS：进入全屏的图形界面之后，按F8可以打开context菜单。==退出全屏==❞
>
> 问题

### **无法联网问题**

1. Create a file: /etc/wsl.conf.
2. Put the following lines in the file

```text
[network]
generateResolvConf = false
```

1. In a cmd window, run wsl --shutdown
2. Restart WSL2
3. Create a file: /etc/resolv.conf. If it exists, replace existing one with this new file.
4. Put the following lines in the file

```text
nameserver 8.8.8.8
Repeat step 3 and 4. You will see git working fine now.
```

1. Repeat step 3 and 4. You will see git working fine now.

参考自：[https://github.com/microsoft/WSL/issues/4285](https://link.zhihu.com/?target=https%3A//github.com/microsoft/WSL/issues/4285)

### **kex无法启动问题**

错误信息如下：

> ❝ unable to connect to socket: No connection could be made because the target machine actively refused it. (10061)
> 中文的提示就是什么远程主机积极拒绝❞

解决方法是在bash中运行`kex stop`，然后重新启动kex。

参考：[https://unix.stackexchange.com/questions/605309/not-able-to-initialize-gui-for-kali-linux-in-wsl-2](https://link.zhihu.com/?target=https%3A//unix.stackexchange.com/questions/605309/not-able-to-initialize-gui-for-kali-linux-in-wsl-2)

### **参考资料**

- [https://www.kali.org/docs/wsl/win-kex/#install-win-kex](https://link.zhihu.com/?target=https%3A//www.kali.org/docs/wsl/win-kex/%23install-win-kex)
- [https://www.kali.org/news/kali-2020-3-release/](https://link.zhihu.com/?target=https%3A//www.kali.org/news/kali-2020-3-release/)

编辑于 2020-09-17 23:10

## 【第二种桌面】下载xfce桌面

```bash
sudo apt -y install kali-desktop-xfce
sudo apt -y install xrdp
vi /etc/xrdp/startwm.sh
echo "xfce4-session" >~/.xsession
#将端口映射到3389
sudo sed -i 's/3389/3390/g' /etc/xrdp/xrdp.ini
#启动xrdp远程端口服务
sudo service xrdp start
```

<img src="D:\codehub\Typora_book\library\img\image-20211127204852675.png" alt="image-20211127204852675" style="zoom:33%;" />localhost:3390


如果想要关闭映射出来的桌面输入`sudo service xrdp stop`

## 工具包安装 ==耐心等待。。。。。。。。==

```bash
#安装标准工具包
sudo apt install kali-linux-default
#安装大工具包（大概7 8G）
sudo apt install kali-linux-large
```

下载工具也是很漫长的,其中会弹出一些安装选项,
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200919023716374.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM5NjExMjMw,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200919023722353.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM5NjExMjMw,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020091902403425.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM5NjExMjMw,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200919024053195.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM5NjExMjMw,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200919024635939.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM5NjExMjMw,size_16,color_FFFFFF,t_70#pic_center)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200919024630833.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM5NjExMjMw,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200919024748180.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM5NjExMjMw,size_16,color_FFFFFF,t_70#pic_center)
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200919024800132.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM5NjExMjMw,size_16,color_FFFFFF,t_70#pic_center)
完成上述选项后,我们可能需要等待半个小时甚至更长的时间才能安装完成。




## 安装其他软件

### 汉化自带火狐浏览器

https://addons.mozilla.org/zh-CN/firefox/addon/chinese-simplified-zh-cn-la/
在kali的火狐中打开此链接，然后点击安装

### 中文输入法安装

```
sudo apt install fcitx  fcitx-googlepinyin 
在linux中切换输入法按下Ctrl+Space！
```

## 汉化

直接汉化,可能会导致乱码,所以我们将Windows主系统中的字体先移动到kali中,在汉化

```
# 创建一个文件夹用于存放字体
sudo mkdir -p /usr/share/fonts/windows 
# 将Windows系统中的字体导入到kali中
sudo cp -r /mnt/c/Windows/Fonts/*.ttf /usr/share/fonts/windows/
# 下载字体管理器
sudo apt install -y fontconfig

```

### 临时汉化

```
临时汉化只是本次kali生效,这里kali不需要重启,关闭kali控制台后再打开即会失效,变回英文模式
# 设置临时汉化
export LC_ALL=zh_CN.UTF8 and LANG=zh_CN.UTF8 and LANGUAGE=zh_CN.UTF8
# 清除字体缓存
fc-cache
```
### 永久汉化

永久汉化需要我们修改一个配置文件,永久汉化后,就算重启kali,还是会保持汉化
```
# 打开配置文件
sudo vi /etc/profile
# 在上述文件中添加
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
```

## wsl重启操作

wsl环境下reboot和shutdown都是没有作用的，wsl可以通过windows命令行进行重启，使用管理员权限运行下面脚本实现重启：

 以管理员权限运行cmd

```bash
net stop LxssManager
net start LxssManager
```

其他脚本（Linux 4.19.104、Debian 10、gcc 8.3.0）：

/etc/apt/sources.list：

deb http://mirrors.163.com/debian/ buster main non-free contrib
deb http://mirrors.163.com/debian/ buster-updates main non-free contrib
deb http://mirrors.163.com/debian/ buster-backports main non-free contrib
deb-src http://mirrors.163.com/debian/ buster main non-free contrib
deb-src http://mirrors.163.com/debian/ buster-updates main non-free contrib
deb-src http://mirrors.163.com/debian/ buster-backports main non-free contrib
deb http://mirrors.163.com/debian-security/ buster/updates main non-free contrib
deb-src http://mirrors.163.com/debian-security/ buster/updates main non-free contrib

#运行 apt-get update 进行更新
/etc/vim/vimrc.tiny：

" set compatible
set nocompatible
启动sshd：

service ssh status
if [ $? != "0" ]; then
        service ssh start
        echo "sshd start..."
fi

## wsl2 kali修改语言

```
sudo apt install locales
sudo dpkg-reconfigure locales
```

kali linux2020.06版如何使用中文语言包
原来kali还需要使用独立的汉化包，现在中文语言包是集成在系统中的，但安装上去默认的还是英文，对于我这种英文欠佳的不太友好，于是：
提示输入密码，kali默认密码是kali

### 然后按TAB键选择字符编码：zh_CN.GBK、zh_CN.UTF-8、en_US.UTF-8这三个，用空格键选定，然后TAB键切换到OK确认。

### 然后选择字符编码：zh_CN.UTF-8

### 完成之后重启:sudo reboot
