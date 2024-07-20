# 更改kali的下载源

[泪雨凝霜心冷淡](https://me.csdn.net/qq_39728274) 发布于2019-05-13 17:00:53 收藏

展开

kali操作系统不能通过ctrl+shift+t打开终端，这是一个与我之前用过的Ubuntu操作系统的不同的地方

在终端中输入vim /etc/apt/sources.list（在root权限下）

\#中科大

deb http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib

deb-src http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib

\#阿里云

deb http://mirrors.aliyun.com/kali kali-rolling main non-free contrib

deb-src http://mirrors.aliyun.com/kali kali-rolling main non-free contrib

\#清华大学

deb http://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main contrib non-free

deb-src https://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main contrib non-free

\#浙大

deb http://mirrors.zju.edu.cn/kali kali-rolling main contrib non-free

deb-src http://mirrors.zju.edu.cn/kali kali-rolling main contrib non-free

\#东软大学

deb http://mirrors.neusoft.edu.cn/kali kali-rolling/main non-free contrib

deb-src http://mirrors.neusoft.edu.cn/kali kali-rolling/main non-free contrib

\#官方源

deb http://http.kali.org/kali kali-rolling main non-free contrib

deb-src http://http.kali.org/kali kali-rolling main non-free contrib

随便选一个覆盖原来的文件就好，这里我用的是阿里的下载源

apt-get update

ape-get upgrade

apt-get dist-upgrade

apt-get clean

