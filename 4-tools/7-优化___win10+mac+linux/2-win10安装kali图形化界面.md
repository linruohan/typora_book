## kaliLinux或Win10子系统kali安装图形化界面

 ![此博文包含图片](D:\Typora_pic\sg_trans.gif) (2019-06-19 14:36:51)

[![img](D:\Typora_pic\sg_trans.gif)转载*▼*](javascript:;)

| 标签： [kalilinux](http://search.sina.com.cn/?c=blog&q=kalilinux&by=tag) [远程桌面连接](http://search.sina.com.cn/?c=blog&q=%D4%B6%B3%CC%D7%C0%C3%E6%C1%AC%BD%D3&by=tag) | 分类： [Linux知识](http://blog.sina.com.cn/s/articlelist_1441383243_9_1.html) |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
|                                                              |                                                              |

​    理论上讲，Linux系统和Win10的Linux子系统都可以通过Windows10本机远程桌面来安装使用图形化界面。

   1、安装xorg

​    xorg是xfce桌面需要的一个基础依赖性质东西，开机时候提供登陆界面。这里我说的可能不太准确，个人理解就是要装xfce必须先安装xorg，不然使用起来会有些问题，比如缺少这个组件那个组件的，如果装Ubuntu桌面的话替换成kdm，xfce也可以先装xdm，看个人喜好。

   代码：sudo apt-get install xorg

   大约需要占用361M空间。

   [![kaliLinux或Win10子系统kali安装图形化界面](D:\Typora_pic\001zxTCPzy7uLTWwS0d65&690)](http://album.sina.com.cn/pic/001zxTCPzy7uLTWwS0d65)

   选择语言区域（建议选英文，选汉语也没用，就当学英语了），一路回车：

   [![kaliLinux或Win10子系统kali安装图形化界面](D:\Typora_pic\001zxTCPzy7uLTZnPgcb0&690)](http://album.sina.com.cn/pic/001zxTCPzy7uLTZnPgcb0)

   [![kaliLinux或Win10子系统kali安装图形化界面](D:\Typora_pic\001zxTCPzy7uLTYE9Zr65&690)](http://album.sina.com.cn/pic/001zxTCPzy7uLTYE9Zr65)

   最后那行报错不用管，研究好些天都没解决掉，反正软件安装成功了。

 

   2、安装xfce4

   代码：sudo apt-get install xfce4

   [![kaliLinux或Win10子系统kali安装图形化界面](D:\Typora_pic\001zxTCPzy7uLU63XcS12&690)](http://album.sina.com.cn/pic/001zxTCPzy7uLU63XcS12)

   大概需要441M空间，如果不换国内源的话怕是需要下载一天。

 

   3、安装并配置xrdp

​    Xrdp允许Windows或Linux系统通过远程桌面的方式来访问另外一台主机，特别适合本地虚拟机使用，详情参考Linux公社文章：xrdp完美实现Windows远程访问Ubuntu 16.04。

​    (1)、安装xrdp，代码：sudo apt-get install xrdp

​    [![kaliLinux或Win10子系统kali安装图形化界面](D:\Typora_pic\001zxTCPzy7uLUjaYJB9b&690)](http://album.sina.com.cn/pic/001zxTCPzy7uLUjaYJB9b)

​    (2)设置使用3390端口

​    代码：sudo sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini

​    [![kaliLinux或Win10子系统kali安装图形化界面](D:\Typora_pic\001zxTCPzy7uLUo8Z2n87&690)](http://album.sina.com.cn/pic/001zxTCPzy7uLUo8Z2n87)

​    (3) 向xsession中写入xfce4-session

​    代码：sudo echo xfce4-session >~/.xsession

​    (4) 重启xrdp服务，代码：sudo service xrdp restart

​    [![kaliLinux或Win10子系统kali安装图形化界面](D:\Typora_pic\001zxTCPzy7uLUwp3hk36&690)](http://album.sina.com.cn/pic/001zxTCPzy7uLUwp3hk36)
​    这时，可能会有防火墙提示，允许就好。

 

   4、启动远程桌面,点击显示选项，填入本机IP（这里是局域网IP，所以你也可以用局域网内其他Windows10电脑试试，建议使用静态ip）、刚刚设置的端口号、还有你的Linux子系统用户名（也可以使用root账户登陆，比较麻烦，因为Debian默认是禁止使用root账户登陆的），如图：

   [![kaliLinux或Win10子系统kali安装图形化界面](D:\Typora_pic\001zxTCPzy7uLUInCkl4d&690)](http://album.sina.com.cn/pic/001zxTCPzy7uLUInCkl4d)
    点击连接，输入Linux子系统密码：

   [![kaliLinux或Win10子系统kali安装图形化界面](D:\Typora_pic\001zxTCPzy7uLUQxDNq8c&690)](http://album.sina.com.cn/pic/001zxTCPzy7uLUQxDNq8c)

   点击确定，然后就尽情使用吧。
   [![kaliLinux或Win10子系统kali安装图形化界面](D:\Typora_pic\001zxTCPzy7uLUZSEPP0d&690)](http://album.sina.com.cn/pic/001zxTCPzy7uLUZSEPP0d)




    