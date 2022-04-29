# wsl2中安装中文输入法

[toc]

在安装qgc那篇教程中已经说过，安装好后的xfce4桌面默认就是英文，没有中文字库，所以需要显示中文的地方会乱码，同时你没法输入中文。首先，按照之前说的，先安装：

`sudo apt install ttf-wqy-zenhei`

## 方案一

参考了这篇知乎文章：wsl2+kali+中文输入法 搭建开发环境 - 知乎[https://zhuanlan.zhihu.com/p/263013536]

### 安装kali

### 安装中文输入法

`sudo apt install ibus ibus-pinyin `

### 安装ibus

### `im-config` 配置输入法 #选择ibus

## `ibus-setup` 设置ibus输入法

1. input-method->add->chinese
2. 设置完成 :win+空格切换输入法
   #这里有个要注意点的是 ibus不是daemon进程 不能关掉  最小化即可

## 方案二

参考了这篇文章：win10 配置 wsl2 终极开发环境 | Server 运维论坛[https://learnku.com/articles/37918]

记录一下这篇文章中有个重要的点：

## 启动 xfce4

为了避免电脑重启后wsl2的ip变化导致我们需要在.bashrc中修改相应ip的麻烦，可用此方式。

```bash
#启动 xfce4
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
# 完整启动
startxfce4
# 仅启动核心
xfsettingsd --sm-client-disable; xfce4-panel --sm-client-disable --disable-wm-check &
```

​	

## 中文设置相关

1. 安装中文支持包 language-pack-zh-hans

`sudo apt install language-pack-zh-hans`

2. 修改 /etc/environment（在文件的末尾追加）
   LANG="zh_CN.UTF-8"
   LANGUAGE="zh_CN:zh:en_US:en"

3. 修改 /var/lib/locales/supported.d/local (没有这个文件就新建，同样在末尾追加)
   en_US.UTF-8 UTF-8
   zh_CN.UTF-8 UTF-8
   zh_CN.GBK GBK
   zh_CN GB2312

4. 编译完成设置
   sudo locale-gen

5. 对于中文乱码是空格的情况，安装中文字体解决
   sudo apt-get install fonts-droid-fallback ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming

6. 中文输入法

 ` sudo apt install fcitx-pinyin`

```bash
export XMODIFIERS=@im=fcitx 
export GTK_IM_MODULE=fcitx 
export QT_IM_MODULE=fcitx
```

> 另外，这篇文章也可以看看：输入法安装配置 · 从零开始搭建你的wsl2 · 看云[https://www.kancloud.cn/qiangshao/wsl2/2033929]

ibus这个输入法不太好用，一般都习惯用搜狗输入法。

## 安装搜狗输入法

### 首先，安装Fcitx输入框架

`sudo apt install fcitx`

### 搜狗输入法官网下载Linux版本的搜狗输入法

`sudo dpkg -i sougoupinyin-xxx.deb `

在用这个命令时，由于我前面安装了fcitx，出现一些报错，如下：

中文的报错信息：处理归档 sogoupinyin_2.3.2.07_amd64-831.deb (–install)时出错：安装 sogoupinyin 将破坏 fcitx-ui-qimpanel





