
# manjaro配置攻略
[toc]

 

## 1 更新源的配置：


```sh
 # 在 /etc/pacman.conf 文件末尾添加行：
===============================================================================
[archlinuxcn]
SigLevel = TrustedOnly
# 阿里源
Server = https://mirrors.aliyun.com/archlinuxcn/$arch
# 清华源
Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
# 中科大源
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch

[arch4edu]
SigLevel = Optional TrustAll
Server = https://mirrors.aliyun.com/arch4edu/$arch
Server = http://mirrors.tuna.tsinghua.edu.cn/arch4edu/$arch

[antergos]	# 已经没有这个库了，早几年就停掉了
SigLevel = TrustAll
Server = http://mirrors.tuna.tsinghua.edu.cn/antergos/$repo/$arch
Server = https://mirrors.ustc.edu.cn/antergos/$repo/$arch  

===============================================================================
# 排列中国镜像的速度，首先用下面这条命令：对国内的manjaro镜像源按网速进行排名，并选择前几名。
sudo pacman-mirrors -i -c China -m rank
# 接着更新并导入GPG key：安装 archlinuxcn-keyring 包以导入 GPG key，否则的话key验证失败会无法安装的。
sudo pacman -Syy
sudo pacman -S archlinuxcn-keyring
sudo pacman -S antergos-keyring
#最后，进行全面的系统更新：说明：-Sy是同步软件包，-Syy强制同步，-Su依据本地软件包全面更新系统，-Syu是同步软件包并全面更新系统
sudo pacman -Syu

```



## 2 输入法
```sh
# 因为没安装 fakeroot、binutils 等打包基本工具，所以 装一下。
sudo pacman -Sy base-devel make gcc

# 安装搜狗输入法
sudo pacman -S fcitx fcitx-qt4 fcitx-im fcitx-configtool fcitx-sogoupinyin
# 修改fcitx为默认输入法，编辑vim ~/.xprofile输入：
===============================================================================
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
===============================================================================


```
```bash
# =====================其他一些设置=================================
# manjaro 设置 fcitx 输入法:
1、设置它只有在使用额外切换键隐藏输入法后，才可以再使用额外切换键将其唤醒：
直接运行 fcitx-configtool 即可进行图形界面配置。
然后查看 .config/fcitx/config 里的相应值是否已经改变，然后立即手动将 .config/fcitx/config 和  .config/fcitx/profile 的所有写属性去掉，即 chmod a-w .config/fcitx/config; chmod a-w .config/fcitx/profile;
打开配置文件 .config/fcitx/config，
将 UseExtraTriggerKeyOnlyWhenUseItToInactivate=False 改成 UseExtraTriggerKeyOnlyWhenUseItToInactivate=True
将 SwitchKey=SHIFT Both  注释掉
将 IMSwitchIncludeInactive=True 改为 False
即可。
- ### **双拼配置自选方案**
- #### **图形化工具配置**
如果装了 fcitx-configtool 这个图形化工具，可以在里面搜索「pinyin」找到双拼的选项，直接配置。
- #### **手动配置**
fcitx 自带双拼输入法，使用的是自然码。如需修改为其它双拼方案，按如下操作即可。
打开 ~/.config/fcitx/conf/fcitx-pinyin.config。
能看到默认双拼方案是自然码（Ziranma）。
我用的小鹤双拼，所以取消注释并修改为 XiaoHe。
DefaultShuangpinSchema=XiaoHe
修改后重启输入法就能生效啦。（右键任务栏的键盘，选择重新启动。）
**PS****：该文件里还有一些配置项，可以按自己需求修改……**
- ### **简体中文输入法使用直角引号**
修改 /usr/share/fcitx/data/文件夹下以「zh-CN」结尾的文件。
「zh-CN」对应的就是简体中文输入法。
该文件名因系统不同有差异。比如在我当前的 Manjaro 版本，该文件为punc.mb.zh_CN。而在我之前使用的 deepin 系统上，该文件为punc-ng.mb.zh_CN。我还在网络上看到一些人的是punc-ng.mb-zh_CN。
将对应的「"」与「’」按如下修改即可。
" 「 」' 『 』
注意！/usr/share/fcitx/data/ 下的文件是「全局配置文件」。建议将该文件复制到用户目录，即~/.config/fcitx/data/下面再进行修改。
```

## 设置字体

```sh
打开终端，编辑->首选项->外观，自己看着调就行，怎么舒服怎么来
调终端字体大小，设置->外观->字体
- # **中文字体**
- ## **文泉驿家族：****#**
sudo pacman -S --noconfirm wqy-microhei &&fc-cache -fv
sudo pacman -S wqy-microhei-lite
sudo pacman -S wqy-bitmapfont
sudo pacman -S wqy-zenhei
- ## **YaHei-Consolas****字体****#**
cd /tmp&&git clone https://github.com/GitHubNull/YaHei-Consolas-Hybrid-1.12.git --depth 1&&sudo sh YaHei-Consolas-Hybrid-1.12/setup.sh
yaourt -S ttf-meslo
sudo pacman -S adobe-source-han-sans-cn-fonts
sudo pacman -S adobe-source-han-serif-cn-fonts
sudo pacman -S noto-fonts-cjk

#===============================================================================
Linux#
方式一：
git clone https://github.com/ryanoasis/nerd-fonts.git --depth 1
cd nerd-fonts 
./install.sh
cd ..
rm -rf nerd-fonts
安装完后，终端客户端需要选择名字带 nerd fonts 的字体
# 上述方式非常不友好，完全下载，整个包有1G
#===============================================================================
方式二：
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
# 生成字体信息缓存
fc-cache -vf ~/.local/share/fonts/
# 查看是否安装成功
fc-list | grep -i droid
/home/kylin/.local/share/fonts/Droid Sans Mono for Powerline Nerd Font Complete.otf: DroidSansMonoForPowerline Nerd Font:style=Book
```


## AUR助手
AUR是Arch User Repository的缩写，是Arch/Manjaro用户的社区驱动存储库。AUR助手有很多，这里推荐yay。yay是用Go编写的Arch Linux AUR帮助工具，可以帮助以自动方式从PKGBUILD安装软件包。

```sudo pacman -S yay```

## git 配置
```sh
git config --global user.name "linruohan"
git config --global user.email "mjt1220@126.com"
git config --global http.proxy 'socks5://127.0.0.1:1080' 
~/.gitconfig
[http]
    proxy = socks5://127.0.0.1:1080
```
## 录屏软件

```sh
sudo pacman -S simplescreenrecorder  
```

## 音乐播放软件

```sh
sudo pacman -S  deadbeef
```

## npm换源

```sh
由于node下载第三方依赖包是从国外服务器下载，虽然没有被墙，但是下载的速度是非常的缓慢且有可能会出现异常。
所以为了提高效率，我们还是把npm的镜像源替换成淘宝的镜像源。有几种方式供我们选择
永久使用
npm config set registry https://registry.npm.taobao.org
# 检测是否修改成功
# // 配置后可通过下面方式来验证是否成功
npm config get registry
#// 或
npm info express
### 使用cnpm
使用阿里定制的cnpm命令行工具代替默认的npm，输入以下代码
npm install -g cnpm --registry=https://registry.npm.taobao.org
检测是否安装成功
cnpm -v
```

## pip换源

```sh
　　  如果提示目录不存在，自行创建一个(如果目录存在，可跳过此步)，如下：
mkdir ~/.pip
cd ~/.pip
　　  在 .pip目录下创建一个 pip.conf 文件，如下：
touch pip.conf
　　（2）编辑 pip.conf 文件
　　  首先打开文件，命令如下：
sudo vi ~/.pip/pip.conf
　　  接着，写入以下内容：
　　  
[global] 
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host = https://pypi.tuna.tsinghua.edu.cn  # trusted-host 此参数是为了避免麻烦，否则使用的时候可能会提示不受信任

```



## 常用软件

```sh
## sudo pacman -S google-chrome
- # **软件安装**
##谷歌google-chrome vim git vs vlc neofetch 网易云 foxitreader 火狐汉化 uget
 yay -S chromium netease-cloud-music  vim git visual-studio-code-bin vlc neofetch netease-cloud-music   uget
sudo pacman -S wps-office
#===============================================================================
- ## **4.6 VScode**
sudo pacman -S visual-studio-code-bin
#===============================================================================
- ## **4.8** **微信**
	# 微信可以使用electronic-wechat或者deepinwine-wechat，推荐后者。
yay -S deepin-wine-wechat
	# 若签名出现问题可以加上：
	yay -S deepin-wine-wechat --mflags --skipinteg
#===============================================================================
- ## 深度截图 火焰截图
sudo pacman -S flameshot deepin-screenshot
- ### **添加快捷键：**
    - 打开Settings
    - 选择Devices，选择Keyboard
    - 滑到底部选择添加
#===============================================================================
- ## **4.11 JetBrains**
tar -zxvf pycharm-professional-2020.1.1.tar.gz
sudo mv pycharm-2020.1.1/* /usr/local/pycharm
然后添加.desktop文件：
sudo vim /usr/share/applications/pycharm.desktop
加上
[Desktop Entry]
Name=PyCharm
Type=Application
Exec=/usr/local/pycharm/bin/pycharm.sh
Icon=/usr/local/pycharm/bin/pycharm.svg
#===============================================================================
- ## **4.12 web****服务器**
sudo pacman -S tomcat9 apache nginx
xmind zen
pdf-footer-zh-CN.svg
png-watermark-zh-CN.svg
print-watermark-zh-CN.svg
ncdu 可视化分析目录占用
redshift 色温调节
virtualbox 虚拟机 安装对应内核
qalculate 计算器
wiznote 为知笔记
Albert 软件启动器
wps wps字体 wps-office ttf-wps-fonts
file-roller unrar unzip p7zip 压缩解压缩
motrix
aria2
# 需要安装以下工具即可正常使用ifconfig
sudo pacman -S net-tools dnsutils inetutils iproute2
# spacevim
curl -sLf https://spacevim.org/cn/install.sh | bash
cool-retro-term 一个怀旧的终端
- # **开发软件**
java: as idea tomcat maven gradle
- ## **nodejs****#**
sudo pacman -S nodejs
- ## **flutter****#**
git clone -b stable https://github.com/flutter/flutter.git
	vim ~/.zsh	
	export PATH=~/Downloads/flutter/bin:$PATH
	//path为你安装flutter的目录
	source ~/.zshrc
flutter channel
#切换master
flutter channel master
- ## **anaconda****#**
sudo vim ~/.zshrc
export PATH=/opt/anaconda/bin:$PATH

- ## **vscode****调试****html****#**
{
  "version": "0.2.0",
  "configurations": [{
​    "type": "chrome",
​    "request": "launch",
​    "name": "chrome linux",
​    "webRoot": "${workspaceFolder}",
​    "runtimeExecutable": "/usr/bin/google-chrome-stable",
​    "runtimeArgs": [
​      "--remote-debugging-port=9222",
​      "--no-first-run",
​      "--no-default-browser-check",
​      "--user-data-dir=/tmp/vscode-chrome-debug-rix",
​      "${file}"
​    ]
  }]
}
- ## **lnmp****#**
- ### **nginx****#**
sudo pacman -S nginx 
# systemctl来查看其状态
systemctl status nginx
sudo systemctl start nginx
## 设置Nginx开机自启动。
sudo systemctl enable nginx
nginx -v
- ### **mariaDB****#**
sudo pacman -S mariadb
在启动MariaDB服务之前，需要用下面的mysql_install_db命令初始化MariaDB的数据目录，
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mysqld
systemctl status mysqld
#运行安全脚本
sudo mysql_secure_installation
mysql --version
sudo pacman -S php-fpm
安装后，我们要让Nginx使用php-fpm来运行php。编辑/etc/nginx/nginx.conf文件。
sudo nano /etc/nginx/nginx.conf
找到location ~ \.php$这部分的配置，将这部分配置修改成如下。
location ~ \.php$ {
​      root      /usr/share/nginx/html;
​      fastcgi_pass  unix:/run/php-fpm/php-fpm.sock;
​      fastcgi_index index.php;
​      fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
​      include    fastcgi_params;
​    }
#保存文件。然后启动php-fpm，并设置开机自启动。
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
#测试PHP
在网站根目录创建一个test.php文件。默认的网站根目录是/usr/share/nginx/html。
sudo nano /usr/share/nginx/html/test.php
在文件中添加如下PHP代码。
<?php
 phpinfo();
?>
保存文件。重新加载Nginx。
sudo systemctl reload nginx
然后在浏览器地址栏输入http://server-ip/test.php。将server-ip替换成Arch Linux的IP 。你应该可以看见服务器的PHP信息。
test.php文件只是用来测试PHP的，为了不让他人看见服务器的信息，测试之后要将它删除。
sudo rm /usr/share/nginx/html/test.php
启用PHP扩展
编辑 /etc/php/php.ini配置文件。
sudo nano /etc/php/php.iniwps-office  ttf-wps-fonts
找到如下两行文字，去掉前面的#符号以启用mysqli和pdo_mysql。
;extension=mysqli.so
;extension=pdo_mysql.so
mysqli.do用来建立数据库连接。pdo_mysql.so是drupal内容管理系统所必要的PHP扩展。如果需要在WordPress, Drupal内容管理系统中剪裁、旋转图片，那么需要启用imagemagick这个扩展。
好了！我们成功地在Arch Linux服务器安装了LNMP (Nginx, MariaDB, PHP7)
### **总结****#**
sudo pacman -S nginx php php-fpm php-gd mariadb
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mysqld
sudo systemctl enable mysqld
sudo mysql_secure_installation
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
sudo gedit /etc/nginx/nginx.conf
  location ~ \.php$ {
​      root      /usr/share/nginx/html;
​      fastcgi_pass unix:/run/php-fpm/php-fpm.sock;
​      fastcgi_index index.php;
​      include fastcgi.conf;
​    }
tomcat8 jdk8 notepadqq sublime-text-dev-zh-cn
androidstudio idea pycham node
typora filezilla
```

- ## **5.3** **阴影边框**

微信运行后，切换到其他窗口会有一个阴影边框。
 对于v2.8.0.133-2之后的版本应该不会出现这个问题，因为自带了shadow.exe，但是不能传输文件与大图片（issue中已有反映，这是一个bug，建议使用2.7版本），对于之前的版本，参照[这里](https://blog.kangkang.org/index.php/archives/397)的办法，把shadows.exe复制到对应目录：

git clone https://github.com/countstarlight/deepin-wine-wechat-arch.git

sudo cp deepin-wine-wechat-arch-master/shadow.exe ~/.deepinwine/Deepin-WeChat/drive_c/

然后修改run.sh：
 ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA7IAAAGXCAYAAACOfmxYAAAgAElEQVR4XuydBXQUyRaG/yRYggZ3h8Xd3V2Du7tDcNdgQRJCcLfgi7u7s7u4uwQnEEgCeecWr2cnyWR6gLAw4a9z3nlLurq66rvVNfXXvVVtExgYGAgmEiABEiABEiABEiABEiABEiABErASAjYUslZiKVaTBEiABEiABEiABEiABEiABEhAEaCQZUcgARIgARIgARIgARIgARIgARKwKgIUslZlLlaWBEiABEiABEiABEiABEiABEiAQpZ9gARIgARIgARIgARIgARIgARIwKoIUMhalblYWRIgARIgARIgARIgARIgARIgAQpZ9gESIAESIAESIAESIAESIAESIAGrIkAha1XmYmVJgARIgARIgARIgARIgARIgAQoZNkHSIAESIAESIAESIAESIAESIAErIoAhaxVmYuVJQESIAESIAESIAESIAESIAES+CYh6+f/CZ8+fyY9EiABEiABEiABEiABEiABEiABEgiVgJ2tLSJFtAtzQl8tZCliw9wGLJAESIAESIAESIAESIAESIAEwi2BHyFmv1rI+n70D7eA2TASIAESIAESIAESIAESIAESIIGwJ2AfOWKYFkohG6Y4WRgJkAAJkAAJkAAJkAAJkAAJkEBwAhSy7BMkQAIkQAIkQAIkQAIkQAIkQAJWRYBC1qrMxcqSAAmQAAmQAAmQAAmQAAmQAAlQyLIPkAAJkAAJkAAJkAAJkAAJkAAJWBUBClmrMhcrSwIkQAIkQAIkQAIkQAIkQAIkQCHLPkACJEACJEACJEACJEACJEACJGBVBChkrcpcrCwJkAAJkAAJkAAJkAAJkAAJkACFLPsACZAACZAACZAACZAACZAACZCAVRGgkLUqc7GyJEACJEACJEACJEACJEACJEACFLLsAyRAAiRAAiRAAiRAAiRAAiRAAlZFgELWqszFypIACZAACZAACZAACZAACZAACVDIsg+QAAmQAAmQAAmQAAmQAAmQAAlYFQEKWasyFytLAiRAAiRAAiRAAiRAAiRAAiRAIcs+QAIkQAIkQAIkQAIkQAIkQAIkYFUEKGStylysLAmQAAmQAAmQAAmQAAmQAAmQAIUs+wAJkAAJkAAJkAAJkAAJkAAJkIBVEaCQtSpzsbIkQAIkQAIkQAIkQAIkQAIk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AiRAAiRAAiRAAiRAAiRAAiTwQwlQyP5QvCycBEiABEiABEiABEiABEiABEggrAlQyIY1UZZHAiRAAiRAAiRAAiRAAiRAAiTwQwlQyP5QvCycBEiABEiABEiABEiABEiABEggrAlQyIY1UZZHAiRAAiRAAiRAAiRAAiRAAiTwQwlQyP5QvCycBEiABEiABEiABEiABEiABEggrAmEKyF75eo19Os/AG/e+iBCxAhYv3ol7O3tw5oZyyMBEiABEiABEiABEiABEiABEviJBMKVkB08ZBhsbGwwYvjQn4iUjyYBEiABEiABEiABEiABEiABEviRBMKVkO3p3Bfp0qZBh/ZtfyQzlk0CJEACJEACJEACJEACJEACJPATCYQrIdujVx+kT5eWQvYndig+mgRIgARIgARIgARIgARIgAR+NIFwI2Rv3LyJ1m3bY+iggShRoviP5sbySYAESIAESIAESIAESIAESIAEfhKBcCFkZ82ei2nTPdG2TSt07tjhJ6HkY0mABEiABEiABEiABEiABEiABP4LAuFCyAqoCxcvoX3HTpji6orcuXP+F+z4DBIgARIgARIgARIgARIgARIggZ9AINwIWWHXpVtPZMmSCe3atP4JKPlIEiABEiABEiABEiABEiABEiCB/4JAuBKyPLX4v+gyfAYJkAAJkAAJkAAJkAAJkAAJ/FwC4UrI9urdF2nT8PM7P7dL8ekkQAIkQAIkQAIkQAIkQAIk8GMJhCshO26CK7yfeWPiuLE/lhpLJwESIAESIAESIAESIAESIAES+GkEwpWQffL4Cbr1csbjx08QIUIEbFy/Bvb29j8NLh9MAiRAAiRAAiRAAiRAAiRAAiQQ9gTClZANezwskQRIgARIgARIgARIgARIgARI4FcjQCH7q1mE9SEBEiABEiABEiABEiABEiABEjBLgEKWHYQESIAESIAESIAESIAESIAESMCqCFDIWpW5WFkSIAESIAESIAESIAESIAESIAEKWfYBEiABEiABEiABEiABEiABEiABqyJAIWtV5mJlSYAESIAESIAESIAESIAESIAEKGTZB0iABEiABEiABEiABEiABEiABKyKAIWsVZlLv7IPHj5AxcrV4bV8KTJm+CPEDceOn8CEia64e+8+bGxskDtXLnh6uOkX/P8cU6a6Y9kKLzjGdlR/WbJwPuLFjWvx/ZJx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8OsRoJD99WzCGpEACZAACZCANROgkLVm6/2EulPI/gTofCQJhAMCFLLhwIhsAgmQAAmQAAn8QgQoZH8hY1hDVUTILl2+AjFjxlTVXb50EeLFjWsNVWcdSYAE/mMC8h3gTl2+nNb98uULOPfs8UP23/7HzeLjSIAESIAESIAEfgECFLK/gBFYBRIgARIgARIgARIgARIgARIgAcsJUMhazoo5SYAESIAESIAESIAESIAESIAEfgECFLK/gBFYBRIgARIgARIgARIgARIgARIgAcsJUMhazoo5SYAESIAESIAESIAESIAESIAEfgECFLK/gBFYBRIgARIgARIgARIgARIgARIgAcsJUMhazoo5SYAESIAESIAESIAESIAESIAEfgECFLK/gBFYBRIgARIgARIgARIgARIgARIgAcsJUMhazuqXz/nq9Wu0bNUWa1d7hajr0ePH0bfvABzYt/uXbwcrSAIkQAIkQAIkQAIkQAIkQALmCFDIhqP+cez4CYybMBHrVq+kkA1HdmVTSIAESIAESIAESIAESIAEghKgkA0nPWLx0mXw9JwJ3w8fECtWTNWqIoUKYeSIYeq/xSPbf8BgdGzfFsuWe+HVq1coVrQIhg0dDFtbW5XnwKFD8PCYgffvfRExYgQ0adIINatXU9c+fPiAfAWLYPTI4diyZRuev3gOewcHjB8zGgkSJggnFNkMEiABEiABEiABEiABEiABayBAIWsNVrKwjus3bMTCRYtD9ch27tINrVu2RIf2bfHU2xs1nOpg9IhhKFmyBG7euoW69Rpiuocb8uXNi/sPHqBho6aY5DoBeXLnQkBAAHLlLYAqVSph1PBhSvx27NwVyZMnR78+zhbWkNlIgARIgARIgARIgARIgARI4PsJUMh+P8NfpgQ9IduxU1ecOHpYeVsltWjdBsWLFkPzZk3gOXMWTp48hXlzZhnaM9plLAL8AzB0yCCDkF0wdzZy5cqp8njOmIULFy5imvuUX4YBK0ICJEACJEACJEACJEACJBD+CVDIhiMb6wnZ4Ic9tWnXAQXy50Orli0wcrQLNm3egliOsQxE/P38kD1bdkx2HW8QsmtWeSFd2jQqz8zZc3Du7Hl4TncPRxTZFBIgARIgARIgARIgARIggV+dAIXsr26hr6jf9wjZ2XPm4fTpM5jhOc3kE7XQYgrZrzAIs5IACZAACZAACZAACZAACfwQAhSyPwTrzyl01+7dGDnKBRvWr0XUqA545v0MCRMlVJUx9fkdY4/s3bt3Uad+I0x3d0Pu3Dnh4+ODSVPcULFCOeTNk4ce2Z9jUj6VBEiABEiABEiABEiABEjABAEK2XDULXx9fdGrd1+cPnMWdnZ2SJY0CbyWL7VIyDtCO60AACAASURBVEqmw0eOwG3adLx5/Rb+Af4oV7Y0unXpjMiRI1PIhqN+wqaQAAmQAAmQAAmQAAmQgLUToJC1dguy/iRAAiRAAiRAAiRAAiRAAiTwmxGgkP3NDM7mkgAJkAAJkAAJkAAJkAAJkIC1E6CQtXYLsv4kQAIkQAIkQAIkQAIkQAIk8JsRoJD9zQzO5pIACZAACZAACZAACZAACZCAtROgkLV2C7L+JEACJEACJEACJEACJEACJPCbEaCQ/c0MzuaSAAmQAAmQAAmQAAmQAAmQgLUToJC1dguy/iRAAiRAAiRAAiRAAiRAAiTwmxGgkP3NDM7mkgAJkAAJkAAJkAAJkAAJkIC1E6CQtXYLsv4kQAIkQAIkQAIkQAIkQAIk8JsRoJD9zQzO5pIACZAACZAACZAACZAACZCAtROgkLV2C7L+IQjUqlMPs2fNQGxHx/+cjrvHdNy6dQeTJo77pme/f++LUS4uOH/uLzx5+hRx48RF6tQpMWLYULx4+RK169bHof17ESNG9CDlL1/hhVWr12Ltai+ULFMOz5+/CHK9aZPGcO7ZXf2tWInSSJ4iOZYsnK/+/ebNWxQpXhL79uxUzOT6q9evQ9R/zSovpEubBj2d+2LX7t2wtbVFhAgRkCxpEjRp0ghONWqoe6QuLuMmqOuSYsWMidy5c6GPcy8kSBDfcD34A8qULm3glidfQfj5+wfJYm9vj+NHDqq/9e7XH9u37wxyPWPGDPBatgRXr11HoybNMHfWDGTLllXlefzoMZzq1MOYUSNQokTxEG3z9w9A3QYN0b5NG5QvX/abbBfaTYOGDMWbtz5wm+wapuVKYWKnlq3aKrt/S+rTbwDOnD2HFy9eYOCAfqhV84sNtbR02XLMX7gYPj5vUbJEcbiMHvUtjzHcc/T4cfTtOwAH9u3+rnJ4MwmQAAmQAAmQAAlQyLIPhCsCfn5+yF+oKHbv3GaVQtZz5iycPn0W06dNRZPmLZUYE1H44cMHuIweibwFCmP50sXIlDFDELtNnDQFjx49guuEfwV0nXoNULlSJTRv1iRIXhGq/v7+8HCfily5cpoUsv379UHFCuVN9g0RsrFixcSQQQMgvEWcOPfuhwnjXFCieDElVJevWIkN69eo+588eYphI0bBxgaYPs0txHVTDxEhO37sGJQqVdJs/xw3wRX37t7DNPcpQfLNnjMPGzZuxiqvpYgSJQrate+EOPHiYMzIESbLm79gEY4cPYrZMz1DfV5gYCBspBFfme7du4dPnz8jZYoUX3mnfvZjx09g3ISJWLd6pX5mMzmkr9SvXy+EkNVuEc6vXr2kkP0uyryZBEiABEiABEggLAlQyIYlTZb1Uwn8/fc/6Ny1O16+eoXYsWMr4RQtanRs/POLoJJ0/cYNjJ/gigcPH8HWxhZ58+ZGzx7dEC1qVAQEBCBX3gLQPI+Sf+bsOTh39jw8p7ur+33evcOUqe44fPgo/AP8kSxZEuVpzJjhi7AUj+zNm7cRO7ajIU+bVi1Qv15di9iIYBBxOHhgf9Rr2Bjz5szCu3fv8OzZcyVeK1Wpju7duqBc2TKqLTFixED8ePHQq3dfpEqVEp07djA8x5yQLVWyJJ6/eAH3qZO+S8hqD3Pu0xfRo8fA0MEDTQrV9Rs2wmO6J3Zu2/KfCNlPnz6hcbMWyJkjuxKQM2bNUWIvZswYIezw5PET1K7fAAvnz0XqVKkMdi5UpLjqO1PdpuP06dN48/Ytli1ZhIwZ/lB5Dhw6BA+PGRAvesSIEZRXumb1aobyJ7hOxpatW9X1/PnzBfHIysJEvoJFMHrkcGzZsg3PXzyHvYMDxo8ZjQQJE3ypg48PRowagwsXL6l/x40bB/379kGGP9Krfy9eugyenjPh++GDWliQVKRQIYwcMUz9t/Tn8RMnYf/Bg/j8+TOSJE6sFh+0NhqD+FYhe+v2bYwbNxH3Hz6Ena0tihYtgq6dOyJSpEiq+PsPHmDw0GHqfRNvf/FiRbF8uRc9shaNBsxEAiRAAiRAAiRgjgCFLPtHuCLw4OEDVKxc3RAma9y4jx8/onrNOqhXtzZaNG8K+XenLt2ROnUqDOjXxyIhO3DwULz18cF4l9HK0zd33nwsWbYc27duRqSIEZWQXbJ0OSZPmoBCBQrg4KHD6Nq9J/bs2g7HWLF0WZ89ew7tO3WBU80a2LfvAGbPmo6kSZIY7uvUpZsK023WpDGKlSyDMqVKYviwIajfqAkaN2yIKpUrGvKaE7KTJo5HT+c+mD9vNuLFjRcitNhSj6z2sM5de6iwYRHgwT2yT58+Rb8Bg5SQEpEV/LopKN/rkZUyb9y8ifoNmygv6vhxY1CiWDGT/GURIFnSpGqBwDiVq1QF0Ryiqr4i3mk7Ozt1Wcq7eesW6tZriOkebsiXN68SbA0bNcUk1wnIkztXkHI8Z8zCpStXgghZbdGkSpVKGDV8mArD7ti5K5InT45+fZzV/XLfzdu3MN5ljHrmjp27cOXqVXTp1NFQviwQLFy02KRH1mvlaixavAQrvZbBwd4eg4YMwzPvZ5g5wyMEh28RshL6XdOpDqQNHdq1VYK9Q+cuKJA/n/q3pM5duiOWY0yMGjFcRRXI+3bt2jUKWd2RgBlIgARIgARIgAT0CFDI6hHidasiYE7Injh5Eh06dcGxw4eUB03Sjh07MXaCK/bs3KYrZEV8iBdt9gxP5M6dU90vnr93794b9qyKkBUxKp5U7XrOPPmxfMkiZM6cySKWt+/cweo167B27Tp89PuI7NmyYfCgAUiVMiXEyyeCoHrVKpg01Q1PHj/F1s1/onjJMpju4Y7MmTIanmFOyHp6uGPPvn3wfuoN5149QwhZ8TzbGoXRZs2WBfPnzFZlG4cWy97S3Xv2YMCgISoMOmfOHEqojh0/EVH/7+WOFCmiEuYibmSfq7aHVoS/cXJzm6zEv6SwELJSTsMmzfDg/gNs27JRPTt4Onz0qAp7/nPNajg4BL1er0EjpEmTGmNGjQxxn4SAnzx5ymBnyTDaZSwC/AMwdMigIPnNCdkFc2er8G5Jku/ChYuGMGlZEFm1eg169eqO3LlyIaqDQ4h6mBOy0jd9fX0RLVo0dd/mLdswxd0dO7duDlHOtwjZU6fPoG37jjh25KBaxNHeJzcPT2z6c63BjjOmT0OePLnVvzdt2oLxE10pZC0aCZiJBEiABEiABEjAHAEKWfaPcEXAnJDdtHkrJk2ZqkSrlmQy3qpNO5w7fUKJUnOhxbLXs2yFSmrvZ2j7HU0d9pQjdz4smj/XcPCQpcAltNh96mTMnbcABw8ewuaN67Fm3Xrs3rUHOXJmV6GcO3fvwbAhg1CvQWMcPXwgiNjRE7IJEiRAtRpOWLxwHmrWrhfksCc9j+z+A/sROXIU1RTxZrZt0xKlS5VS/zb2uB4/cVJ5pNeuXoEkib94li31yAY/7Ek7zMmYX2h7ZCXPylWrsWy5FxIlSoTkyZOhf9/eQdBLCLdTnfro1qUTypYpHcIswl8WDBo2qB/i2sjRLti0eQtiOf7rZff380P2bNkx2XV8kPzmhKy5MHbZkytt2Lp9By5evIQsmTOht3NPQxi7PMSckJV3wWP6DNy8dVt5fOVQL1kE2bV9S4j2fIuQ3bZ9h/K0a6HQUujnT5/UgtDeXTtUGL6EZ69euQLp06VVz5Rw7EGDhlLIWjoIMB8JkAAJkAAJkECoBChk2TnCFQFLPLJHD//rQZLJuByUJJN72UcoonPlimWGfYiuk6fi+rXrao+sTNDlsKXZM6YbPEzikRQPaooUyQ2hxcFPLbZUyIpwmTFztvJeSpiutkdWBJd4XOUAq7t37inPX5w4sdGlUyfs3L0bct/2HTvU/lPjpCdkxUM8fMQo2DvYq3Bo41OL9YSsdtiTqc4TXKjKybhv3/rA08Ptq4Ts9xz2JKG+EvornucE8ePDqW59FdqreQalIrL/+eyZc5jhOc3kOyD869apbfIAJDlM6vTpM6Hea1zgtwpZ4zLEs7rcayUWLlys7KQdOmVOyLZs3Vbt1R4zepTqm+INneI+LcyE7Llz59GmfUd1krR2QrVxnaVf5slfUNlAwq8lrV67Dm5u0yhkw9Woy8aQAAmQAAmQwM8hQCH7c7jzqT+IgHyORE7llTDYXLly4MWLlypkVMJKRRBWrVkLDerWVSf5ijiQ/ag5smdDj25dVY1kX2SXjh1QtUpl5cFq3LS52tupHfbUb8BA+Pi8h+uEsYgcObLan7hoyTJs3bzhu4WsPF/2STo6OqpDk+TUYglRFpE6zWOGEiDSvuo1a6mDgbZt2qBODJYDgVIkS4ZZM6Z/tZAVEd6oSXN1oJTs49U+vxOWQlb2yFavWRsDB/RXe3gt9ch+q5AVAdW6TXukS5/OsN/Ua+UqLFi4BGtWrVD9QRY86tZvjKWLF4TqXTcnZO/evYs69RthurubCjOXg5kmTXFDxQrlkDdPniB2+FYhK6dVZ86UCdWqVlblia2HDB0eZMFCPoM0cpQLNqxfi6hRHdQe2ISJEqr8NZzqoGaNamjWtInqy71691Ghy0cO7Q/x9olHX57TqGEDk2+mhLQ/ePgQU1wnGK7LIo5T7XqoUb0KWrVsAfm3fK5Hwva1cuS06NhxHDF65Ai1mNGpazfcvXOXQvYHjX8slgRIgARIgAR+JwIUsr+TtX+TtsqpwqvWrMWnTwGIGzee+iTNH+nTqdbLSb9jx03E4ydPYAMbFCtaGF06d1QHN0nauWu3OpU4Xvx4iBsnNlKnSo1z588bRKIIgslTpkJCZiX0NUXy5Ojbx9kQOvm9ocXyrdgJE11x9uxfePbMG/HixUeiRAnQq2cPw/5XEep58+ZR7ZJQ0SLFSsLJqaY6sEpSmfKV8OzZM+VhFs+d/K9Z08YGsS73i5dM27Pbracz9u7dF8Qj+/rNmxCfmunZvSvke7TGe2RNdSlTQnXxkqUqRHrd2lXYtm17kO/MamU4ODjgyMF96p96e2RlQWHb9p2qjZLEIyjtWbpogRJTi5csV99W1fa9irht2aYt0qROg0ED+qFLt55Ily6tOmE3tGROyMo9h48cgdu06Xjz+q06wbpc2dLo1qWzWuAQ0Tlg4GBVtByC9CkgANH//+1fD3c31V/0Tsi+fOUqXMaNx4vnLxEhgi2ix4gB5x7dg4Soy2KMHFZ1+sxZdRiVfNPXa/lS9dw9e/aqaAMRko6xYqNjh7bo3qu38lBLqLtxmjV7LubMm6/EsCxmSMizcZK29h8wWPUJWztbLJw3Rx1MdefuHYwb74rbt+/A94MvsmfPjn7OvQxiWhZK5JAp+URSwoQJULuWEyZPdTfY+TcZkthMEiABEiABEiCBH0CAQvYHQGWRJBAWBLTQYlOH/IRF+SyDBEiABEiABEiABEiABKyVAIWstVqO9SYBEiABEiABEiABEiABEiCB35QAhexvang2mwRIgARIgARIgARIgARIgASslQCFrLVajvUmARIgARIgARIgARIgARIggd+UAIXsb2p4NpsESIAESIAESIAESIAESIAErJUAhay1Wo71JgESIAESIAESIAESIAESIIHflACF7G9qeDabBEiABEiABEiABEiABEiABKyVAIWstVqO9SYBEiABEiABEiABEiABEiCB35SA1QtZ+/fvf1PTsdkkQAIkQAIkQAIkQAIkQAIk8JsScIwZpg23CQwMDPyaEn0/+n9N9hB5KWS/Cx9vJgESIAESIAESIAESIAESIAHrI0Aha302Y41/TQKnevaDfcIEyNynR4gKbi9WHtkG94Pfy5f4e/T4ENcrHtkDu6gOuL18Ff4Z64r8nlMRr1B+le/C+MkIDPiELAOc8fb6Deyv1SjE/RFjxkT5A9uDXLeLEgXR06ZGqoZ1kaRyBcM98oxbK1ah5J8rTYLUuy43XZ+9ALdXrsXHly8RI30aZHbujti5cuD5idM42q4Lyu7YgMjx4hrKD/z0CTvLVEGGLh3w+eNH1cbgKWGZksjj6vJvG2xtVZYI9vaIkT4tMnbvBMcc2dTfhKf/mzeAjQ1sI0aAQ5IkSNO0IZLVrKqun+kzCA+37wryiJiZMqDo8gXqb6d69cfjXXsBW1tEiRtHsf6jUztEiR8v6PVglczSrxdSNqij/np97kLcXbcBAe99YWNni4TFiyJz7x6wjRzJog56b/1mnB86EhWP7cX9jVtVv6h08iBsI0W06H4tk++DR9hdqSaKeS1CjAzpv+reXz3z5Wkz4HPrjuoX35t2V6iJ1I3qIVWT+kGKurXUCzcWLIG/zzskLFEUOV2Gm33Us6MncLrvYPW+/a4pMCAAm3MXQfE1SxE9bRqFQfgmLlcKGXt2wY5SlZC8RlVk6NpBF9GtZStxb91GFFu1OEReeU+jxI2LLP17qTL9nr8Ikid1k4bI5NzVMCZES5EchRfPVv/2f/MW24uWRbl92xDJMdaXMeP16xDP0NpgPCZoY0rqJg2Q3Kmaukcbm2XMkBQpZgzEyZNTvfNREsT/93qwJ2jjmvx5S96i+OwXdPHezt5ejQGSzI1bb69dx8FGrVBw9jQ4Zs+q8vs+foz9To2Qc/RQJChZTJe1np0+vX+Pv0ZPwMvzf+HDU29EjhMH0VKlRI4Rg9Rv1/7ajVH+4E5EjBE9yLOEzZ3V61V/+F47GewQrDXa2Bte7PSt74tgCQs76f1Gyvti7n3Ss5MlnfHFmbO4OGka3ly9hojRoyNplYpqzLCxs8PdtX/ir+EuyDlmmGH+crb/UDzYsh0yX3r/6JFhLhTaXEevDj43b+NvlwnwffQYH548ReQ4cZGgeBFk7tNd1UFLFydOxc3Fy1Fg1jTEzZ/H8HfjMcHGxgZR4sdHorIlkaFzO9hGjhxkzDB13Xg+F1obLLGTublQcAaB/v7YX68Z0rdricTly5jtSw937NYdm1PUqWF2TqqNUxfGTYb38ZOwsbFF3AJ5kW1Ab0SKE9swdmcd0AuJK5RT/35z+SoO1GtqGLvN2eH5yTOIU66knqm/6jo9sl+Fi5nDE4HL7p54e+0G8rpNDNKsT+/eY2uhUkEmfY/37MfZAcMMExjtBhkYL7l7wjFLJjVoSjIlZMvu2hREKGr3awOjXBeR5334GP4ZP1kNrJoA0xOqlly/PG0m8k4eBxGHMsDfWLQMJdevUEJwdyWnL4Kh8b+CQepxskdflNu9Gfc3bTUrpI3bIGI4wOcdrs9fhNtea1Bu9xYlFOVHVhv4ZGL49NARnHYegMILZiJWtiwG/sLu3d37yDctqHCWH+FIsWIiS5+eeHf3Li65zcDbGzdQfOUSRIgWVQlduS6LD6bSox178PeY8SiyeC4ckiVRP4JH23RGonKlkKFze4u69eO9+3G69yBUPnUQD7ftxPmho1Hx+D6L7jXO9PmjH15fvqLEvkyKw1MKSyH7+tIVtWhhvMBizEr6it/LV/+NkJXAJRsbqzWVKSF7oG4TJC5XBmlbN8O+GvWQrEZVpGneWLeN3keO45RzfzU5DZ4ONmiOZNUrI2X9L4tHkg7UaYIkVSogTbOgC3oyJnwO8Ef+aZPUopopIWs8WQr+LON3Xt6pZ8dP4JTzQOQePwoJShRVk1LjBUB5588PG6PsmH/65BDXTTVchGyucaOQsFRxs1xCG7dkAfHexi0otnIRZOJ7rH1XJTZFyFqazNnp6ow5eH76LPJPm4zDzdui4Kxp+GfcJHz64Iuco4djS/7iKLpsvhr3jdPFiW7wffwIuSf+u+D0rXbSG3vDi52+9X0R7mFpp9D6mt77pGcnvf4oC7B7a9ZXY0SaJvXx4ekzNQ4kKFYEGXt0VkL2iscsRE+TSs2FZB6wv05j+D58FETImpvr6NXhaOuOanE8XYumONK6IwrOcsehpm2Rsp6TYcyRsW5nuWrwf/0GSSqWQ45RQwzFBhkTPn/Gm+s31GJU/CKFkMm5W9AxwcR1S+Zr2sPM2cmSuZBWjizaeh85ZphfmutLyZ1q6I7NcfLkUkI2tDmpODEO1G2qnDzZhvSDbaRI+GvUODVnKrJ4jho/jedzUk9TQtacHUCPrF5X53VrIvD04GE1+ImXzDZiRMiKerIaVVQTPn34gK35S6iB6MHm7fj44gUiODgg19gRiJIwAf4aORbv7t5DwdkehibLy7arQg0lkLRV8NB43N+4BdfnL0GJtcsQ8PYtfO7cQ6wsmb54GOs0QaXj+w3eNnNC9umR43h98RLyubuqCcO3Clltwn5z0XJcn7cQ5fZsUR5IS4SqOY/tvpoNEL9wQYMnBIGB2FWuOlLWr4W0rZrhyvTZ8D58FEWWzjOgOjdoBGQgyjl2hO7zgwtZKUTzOpbatBoOyZKGGPgkj6xwp2vbwuBBkb/pCVlNqErf2FP5S/3Fg633I31t1jw8OXAYRZbMNbRR+o5dpEiqL1mSXpw+g9N9BqPs7s2QybwI2TI7N6hbDzdpg6TVKiFFnZpBipJ7Tvbor7yBH58+w/76TdV18VQF98hemjwNH1+8VH3u3e27agU7dcOgCwzm3pcL4yYh4P07vLtzHwG+vkhZ1wniRY4YM4ZhYUC8pRfGT8L7+w+VVzp+kcLI0KW9wSt9qFFLJCxZHK8uXFR18Xv1CtkG9UOcvLm+tLNZWySpUNawyPLizDkca9dFeaYlKSF74xYixoiBp0eOwtY2AtK1ExtXV9dNeUePte2MuPnzKltKOtS4Nd4/fKgmIpm6dw7hkTWeKJgSstK2c4NHqglUpDix1ETr1rJVBo+svOsXXd2VAICtDaKnToUs/Z0N3n2ZgG0rXBolN6zEJTdPvDh1Bv5vfZQgsNSDbs5OPtdv4nCL9igwww0xM38RGH+PnoD39+8jv8dk9c7r2Umvv8r78feo8Xh2/KSyRYraNVRUhbFHViaFicuXVX1W+q9ER2jeTHPli1dxd/kaX1bfY8XEy7/+QYx0aWDn4IAdxcsr4Scr+FoyJ5ASlSquxnVZTPweIas9SxbHpL0yATM1bsr7cMVjpnpv9cZVKfN7haxMCg81aY3YObMhWooUuDprnvq9kTpamszZScbLz35+yDqoL2QRodCc6Qh49x4fnj1Tv0V7KjshY7cvC3YyTkeKEROR48fFaef+iJYyJf7o3O677aQ39pq6bo12+tb3RftdCys7mRNI5t4nPTvp9cernnNwf9MWlNq0xrCo9/riZXx8/hzxixZWQvbpoaOQ3wQZK58dP4UX587j3vpNIYRsaHMdvTrIWJK2VVMkKFpYCVmJ2JJ+HcHeAfZJEqnbn+w7iJPd+yB9u1a4sXApyu3ZrMYmSabe+dteq3Fr6Uo13utdNzXXCT5fM/59MrUoH1wESn5TcyH5+4fHT9RctPDCWYiWOqUq2tw7Hyl2LN2xOXLc2GaFrHhMpa+X3rLOwFR+Mx9s24XkNarAJmJEi4SsOTtQyOr1dF63GgISJnKgXhPk95iCOPlyq8n1wYYtkHeyC2LnzqWElITDJalSETlHDlYTvOMdeyBaimTI3LenCm+RgU0TS9JwWa16vPeAEgl66dU/F3G0VUflVbu5aBkuurqh9Pb1eHv1Ov4ZP0WVqyU9IRs7Wxa8uXYducaP+m4hqw2WMrBGTZFcd8JlbkIm3s8vk7ERhjAQadPJbr2VhyDXuJF4f+8B9lSphZIbVyFq8mQqlHhHyUrIPXGMCuHVm/AFH9wljOqyx0w82X9YeX1tIkQIMvCJXR/t2oNzQ0ah+Kolqo16g7+pH2H5m13EiEps6/1Iv75wGYeatVErtEkqlEHsHNlVaLiW5Afv2qz5JrtM8dWLYZ8oESRUUIRsiXXLIX1HvDvFVy9R9/w1Yizs7COrsEURQoGfP6nJqvxIPtq5BwXnTA9S9qbsBUIIWRGBtxavQOFFsxDjj/R49dc/ONSsrVrQkFBLvfdFvCzPTpxU5UpIoWOOrMjSpwe2FiqNUptWqTCsfU71VThY+vatVYiSvE8iOuTfkkSoimiThSAJR7w+bxEebNlhaKclQlbeJQktlsnNs2MncaxDN5TetEb9KFoiZDVQR1p2RKKSxb5ayJ7o3EvxyjFysFoMO9FZxoobBiErkRV+r14j7+SxKpxMwtDEQ25sIxFq4ulP07yR6jOGsDULvLJ6dpL2Pdy2A5enzUKxFQvx/ORp/DNuMoquWKCEobyz5uz08vzfym6mUtaBvZGkUnk1gbv352YUXTxH9fPLbp4qtN5YyMrWiiTlyyJR+dI40amnErEJS5fQGzbV9a0FSylviI2tHQ42bK4WGxOVLqH+XmbHBhW6qyVzQjbPJBec6tkfhefPUJ734KHFlnpktWed6OIM+wTxlLAL4ZF96o0z/YbCIWki5BgxWHdckzK/V8hKGbKwc6BBc0ioovw+SCiklmRSK2I3eEpSqRyyDuyj/mzOTi/OnsfxDt2V7R7vO4CCszzgkDSxoTixq4RTp27aENuLl1c2yj58kLJZ6kb1g2xh+VY76Y29pq5bm5307KD30oSlncwJWXPvk56d9Nog4lCcDbknjDaZVYSseA4jOcaGffx48D5xEmlbNMXxDt1CFbLB5zp6dZBx7cb8xUhRt5b6XS26dK5BpGr3nurRFwHv3ql67ihdBdmH9EPSapXVZVNzGfm9krqXWO+le92UkA2tDZZ4ZM3NhaS+suDkkDSp2qalJb2+pDc2+799a1bIyhzkmjhS9m4N1RyWeGTN2YFCVq+n87rVEBDR+ezEGRSa9+8kXzwT8nJnG9rfIGQLzZ+hQs8kyargqwuXDB6mw03bQEIl1N6uz5+xu6IT0rVraZFnQfO8iIdNPJCf/f3VJP/Txw94evg48rn/G3JsVsgePqb2heyu+GXf461lXiH2yAbfR5mmWWO1Gm5qYPz47Dl2lq6MossWKI+NnpA0d13zcuTzmKTCZ7Qk7ZV9GlpY9ZEW7dVeEhE0Eob7z4RJKLt9KknXRAAAIABJREFUg8EjLN6c4G3IO3WiErpaGyJEjYpABOLTe1/ltZP9tdoqqQp7+vhRiVr5kYmdMzv+6NBGLWAYJ0s9snLP36PGwfeJt7KT2v+zZz9sI/y7T0byVDi02+BtlHreWbVe/di+f/gICUsWU/ujtX22ui9OYCA+ffyoFgCkr33y8/vy3wBk36CsRkvI4pEWHfDB+ylKbVyNv8dMUD/+wfdhhyZkRbxqIeriOd+UsxCKLp2HmJkzqkUac++LCFlhK++OhDDK/lEJ8dxRogLyT5+CT77vcbRtV1Q8utdgy0fbdysvqixiSBKhGr9wAaRr21L9+/mpMxBhqO0JtETIeh86iqIrFhpw7q1aB2lbNUeyGpX/EyEr4kP2rMu4IOnBpq1qYUq84iIatuQrrryhmpfZ78VL7ChZEWV2bjT0BdnvEz1NavVef23Ss5NW3j8urvB99AgSQp13ynhlY0nixdezk16dZPLomC0r0nf4skAhK/u7ylcPImQlHNcmgp0S6dq7abzPzNwzDtZvpkIM3z94qKITJKohbYvGONS0TYiQY3MCqYDnFDzaux8fvb2RqVf3EEJW+rON7b8h3bGyZEGh+Z6qasYTc9lH9mj3PpwdOBwF53io8UXthxs3CWpcCghQfT55zWqKiYT0a/vlQhvX5BlhIWSlHIl0eH//AUpvW//V2wn07CTRG7LfVSbjMiaJ3bMN7otoqVKoRRpZzElatRIuTfGA75MnytMinvP806caIgKkjt9qJ72xN7zYSc8Oeu9kWNnJnEAy9z7p2Umv/hI5I6JKoh1MJeWRPXwMaZs3VovU8s7JPnqJqjPeI2sc0hp8rqNXB7kunt57Gzbj4dYdKqpIFn0yO/dAhOjR1FaTnWWrIvvQ/qrPn+reB/7v3hmi9oLMlQIDIR5lEegp69VWWyz0rlsyX9PaYDYE3IK5kIr6GjYGJdcvDyHWzfUlvbFZa0Noc1KJXru/aZvyUIeWtAU47XwRORNGzjPQzjfQs0O4EbLH23fDq4uXFaeI0aOi1Oa1lvRh5glHBESIyAsTKVYsQ6s++/upkOA8k8YahKyxF0FeshdnziP/jKmGSerFKR4os+2LQJGJjExINYGhh2tn2SrI5TICp3sPRLZBfSGb5WVvQODnz8jU68uhJJL0hKzs6bwwYTIC/T/BJqKd+n/jw54s2SOrhdtonmYttON7hKxM8DbnLab2EYpnSUsnuzojcty4hh+lu2s34MbCJepAKVlJEy+ptgqo93zjwV2E6t5qdRVL8fRoyXgFT4SeHGol3qPg6WuErNQzQrRoyvP2tavN8kNwbugo5VHSJsZ6fcXcdQnHOTd0JIosmqM8JA7JkyJts0a4ONlD7RnUwuW1MkITssEPShIhq4XJ670vImTFEyyiWcZXCSeUkF45zCW/uyve3buPM/2Hwj7Bv6HUIuw+fwr4EsZuQeiwJUJWIhqM953LYpN4+mSP5I/2yGqLU+Ipj54urWqThPmeHTjiS3j3/xeJZPHCxi6CwaT+Pm+VuJWtBZIkTFMmQhK2/rVJz05aeR+9n6ltEAmKFkKeKf8eKCf7r/XspFcnmcyIF0Kr/ydfX2wtUDKIkNUrw9z1s/2GIHq6NCp0WewqEy6Z4F7xnK0W4IyTnkAS762MGUUWzca+Wg2DHPak55F9sv8Q7CJHVo+LmiwJ0rVpYfAqG49bMvmVKJQSa5YZFtf0xjUp09RhT8aH0GntDG3ckut3Vq7FreUrYZ8wIaKmSAY5BOlHJOmz+aZOVN4U6fMSAiri4tHOvYidK7sa6x7t3otsQ/pD+od2YKFWl2+1k97YK9dpp38t/r120hOyob1PenbS65NyvwSkGO+rNr5HE7ISjSPbmRKXK420LZuohcPQhGzwuY5eHbTrco6JhBbnmTwWZ/sPQ9TkSZB9+GDcWrIClz1modzuTUr8yQGRUu/S29apqCrjxS1ZKI7kGBPJa1RT4craNi5t8cvUdVNCNrQ2WOKRDW0uJIsm+2s3QoauHdVhVKElU31JDtgyNzabaoNx+cJIFmPL7Q/9cESZz8mWJFksl/T2xi21xUgTsnp2CDdCVtS7dhqgja2t4TQsSzsy81k/ATkI4/mZs8p7YiqZOqAkuJCVF35XuarIPmKwOpE2atKk/+4FtQDR0Tad1KE7PjfvIPf4kdjn1AhxcudAnHx5gnh1LRGy4l3ZX6sxElcoC9sIEb5ZyF6fs1AdlKTtv9SbcOldlzDTuPly/+sV/PxZHYaQrlUzw15HEQDiBS4wy10dglRs+QJES5NKEdQrP/jAeGfVOjUQlli3wnBaprGQlfwH6st+Lg/DqcZ6E8LgP8ISFrurfA1k7NFJiTW9H2nZDx0jXdogexzF83x+xBhUOLRLhWLqhRab604SqipePQnl/fjyFRwSJ1aHUt1dvxH53ScF8XxIOd8iZPXeFz0hKxEHR9t2QSU5cfX/J7kGb5OeUJUf3kSlixsOBnt64JBib7xHVkS97OnRkogU6WtJq1dWp2Sf7NlXMdeShDkmKl3SsEdW+/s3hRYHBqqFmwLTv2xXkHR3zXpcmur5JbT482d1AI6EEZvbQy8TBNk7qu3ttWAoMWTRs5PKGBgICa+UMFDx5MukQE6klPTy3F9m7WRJaLFMKhyzZ8MfHduoMt/duavEovGi4Ne0KXjeazPnqmgIOQCt7M6NONS0NeLkyqX2uwb3YusJJPFEy2mndg5RcGuJ11cJWXMHvAUft870Haz24eb3nGLRuCaZvtcjK9tl5JAgeWaUBPHU70PeqeMN0QKWhBaHaqfAQFydMVf9Tol40fbIfvL3Vx5XWTx9d+8e/h49EZHjOKpD7R7u3AMEQp0Qr/2+aOV/q530xl6969Zgp+95V+RdD0s76QnZ0N4nPTvotVFCeiXyqMz2Pw2/H7LwemPBImQfNkjNv8QjK0JWFs4kEkmLgAlNyAaf65irg5zKLXOLPzq1hSZkZY+sLNRcnuapFuHlXXt787ZhcUvYS1SH9P20bZrrzmW+dq4j9Q2tDZYI2dDmQmqee/Z8yLmxBX1JFhTMjc16QvbV3xdwqHErFWotUR3q58rfX507IYd6yVijF1qsZ4dwI2T1XhpeD/8E5LAdOR0t/3Q5tTInAt764OKUaUhSoZwK+7NEyAqlS5PcVajokwOHUGLNcnUqraVJQpmfHjyiPBepmzZQh5588H6GnC7DVHialiwRspJXVsNkYirez6/1yEq4m5zmK/st5RMV2iRab3DVuy4TeTncRrzc4nGSU4sl/Ln01vVqH6CWpO7v7j1QXj05rEFLeuWHGBg/f8bBxq0QM306ZBs2QBUTfOAT0fX08FEVim0c4qLrkR3UV4XoXXB1U3vP1Gmg9va6QlYGYTnlOM8EF+WRkdCX80NHqboFP7Xa0r4TPJ8sBERydETO0UMQJUECSCjW2+s3UfHoHrUX0zh9i5DVe1/0hKws2Oyr1Uh5iOVgJflxurlspVp0SdWonqqenpCVkHQJ55J9diIKZb+peHmMheyNBUtRZOFsJd7l4A9ZGCm1ebXySGn7sbUVcgmrPdysjTqYQzvsSeOkJ2QlbFJCW/NMHheErToZVtlhKPx9fHCiUy/43Llr2CMrn1Dye/0WuceNVHaRE7of7tipVvS1ZImQvbNyDa7MmIviKxapA3S0pGcnyXdt9nz1XAmDfXPlutpHLJ53OdBD7KJnJ70+KmL6/uatKLxoDiJEdYB8SkH2a4eVkJWQ9IuTpyHGH2mRd+oEtQdX9lInr1VNeUWNkyUCSSIkDjZuqQ4q0vaEmzoUxbhcvYm5qT2ye2vUQ7aBfdTeUL1xTZ71XUI2MBBHW39ZKJUzHSSJDWTRrMTqpSHCBfVsauq67JWOHNtRndYupxbLYU8Ptu/Clemz1CfV/F6/UQsYckhi6a1r4X3spPp9iZoiKQrMdA8TO+nZQe867fR1drJEyJp6n/TsoNf/ZAvG3hr1kbRqRaRv2wL+b3xwus9A5e2XsyGMPbJaWbJlwZRHNrS5jrk6iDjeXaGG+uxe0soVlEdWTtH9a6QI54/KqyrzSflb8C8hyJwstMOcjJ+pNyYYz3X02mCJkJVnB58LyUGZ++s1QdEl8xA15b/nh2j11HvnRdibG5v1hKw8R7aaiYNRzhKIGCMa/pkwRZ0do+aFtrZmheyHp0917UAhq/e28bpVEZDJnOzR83v9GoH+ASocMmPXjmqCaamQVZPjqrXVybyyF/RrkrZPSpvgyQnKshomYRWy2n939Xr8Jd+Rlc9vyP/+78mqeHiXmojI/bIKqX0u5s2Vq+ollj0XQb4ja8IDJgOVbeSIX77pZWur9qrJYUtpmjZS+wm1pNUxuBctn9sEdaCO3nUpRw7tkXziLYz5Rzpk6dszyGAveSTsU0SAfAPS+PMZoZUvk6MKh3eZ3Of7+sIlJWblG4qyVzH4pFRWVGVSmbxWdbUvV0IVZQIm4kglW1vEypzRcMqw2t/z/+/IRowWFfEKFUSmnl9WByUZXze2f4JihdVEW/aJyWRbBvkA3/fqW7fSXzJ076TsHBZJ2InIVqc6AuogMTnRUVY2JUm47+ur19R/y6nF8i1h2aMYN28edRiXqU/XGIcWy33m3hc9ISsr9eKZk4OF3t25gwDfD4idPSsy9+2hRKYkPSEriwdnBgxVfVW2BCQqU1LtVa585rC6X05elkUlEceyl10+r/JHu9bKG6sl+eyVeITsEyVEjLRp8MHbWx1uJQJIPPnyvWNJcmqx7MGRbQJ2kSKr8DDjJCwkBFedv2Rnp4SgvD8qbHzwSOURl72bKWrXVPsDpa9K0hbMJNxU+oW0PVOPjuqAOS1ZImRFkMgimngogp98bc5O4pU+3W+winrQ+q+EYt1Z86fh8BI9O+n1V3m/zo9wgffREyoqQjyzsm+t6JK5Fp+8bO4Z2mRIGyuEpSzcSNihFgq3q2xVfHj2/Ms7LUaysVHfjpZVfUkyJsiePm1vsOxnk4P6gnxH9v/fnjaui7z38j1avYm56YNdvpwIL++k7LFT38cONjZr45o8U0/Imhu35HvHN5esQIk1RqI1MBCyQBM9bSrDYU56tjR3XRbkZML84txf+PjsmTowyz5hImTu1dUQBSKc4+bLpWwj/V0O1JLPdIjtJH2vnfTGXtoJauH0e+2k9xup9z7p2cmSfijzmwsTpuDlXxfUIniyapVVNIn2HVnNI6uVZUrImpvr6NVB9rRenOSG9/cf4ePzZ+pMA9k3n6VvD1ybs0Adwlh40ZfvUmtJfUGhSi31+yD3m/vCg6VC1lwbLLGT8ZaJ4HMh2fYlocFyxoippNeX9MZmw7dwQ5mTygK0RJhJf5UtATLvjVcoH7L0k+1ocQxjd2jfkZVFWj07OJb498A7PZtbcp3fkbWEEvOQAAmQAAmQAAmQwC9KQAstNj6N/Ret6m9dLdrp+81vHFr8/aVZbwlW25f4HVnr7XSsOQmQAAmQAAmQAAmQAAn8KgRkn6ccBhhakq8QxC2Y71epLuth7QQoZK3dgqw/CZAACZAACZAACZAACZAACfxmBChkfzODs7kkQAIkQAIkQAIkQAIkQAIkYO0ErF3IWjt/1p8ESIAESIAESIAESIAESIAESODrCNhHjvh1N+jk/s8PewrT2rMwEiABEiABEiABEiABEiABEiCBX54AhewvbyJWkARIgARIgARIgARIgARIgARIwJgAhSz7AwmQAAmQAAmQAAmQAAmQAAmQgFURsHoh6xfZz6qAs7IkQAIkQAIkQAIkQAIkQAIkQALfRyAmon5fAcHu/s/3yFLIhqn9WBgJkAAJkAAJkAAJkAAJkAAJ/PIEKGR/eROxgtZCwHntCCSMHhfOZTuGqHLJKbUxqEI3vHj/Ci7b3UNcP9hrPaJGcsCK039i/A4PeNR3QcFUuVW+iTunI+DzJ/Qr3wXXvG+j3py2Ie6PaR8De7uvDnI9SoTISBMvJRrkrYFKmUsb7pFneJ3agHXt5ppEq3ddbpp7ZBlWn9mEF+9eIV381OhVph1yJsuKk3fOocPyftjWZRniRo1tKP9T4CeUd2uAziVa4EOAn2pj8FTqj6KY6DTY0AZbG1uVxSFiFPWMLiVbIUfSzOpvwvON71vY2Ngggm0EJHVMiCb5aqN69grqer/1o7Hj0v4gj8iYMB2WtvjyXOe1I7HnykHIM+JGdUSB1HnQsXhzxI8WJ8j14HXsU64T6ueurv48/+gKrDu3De/93sPO1g7F0xWEc9n2iGQXyaIuu+Gv7Ri22RWHnTdg0987Vb841mczItl93Ql8D18/RpXpTbG8pSf+SJDGomdbSyaP/Qtw6/k91S++N1X2aIxG+ZzQMK9TkKKWnVqPRUe94PPxPYqnL4jR1fqZfdTx22fQb/0Y9b79rknGo3zjKsKr9Syki5dSYRC+ZTMWR/dSbVBmal31LnYp0VIX0fJT6/Hn+W1Y0WpGiLzynsaL5oi+5TqrMmX8NE6N89VCz9LtDGNCithJsaDpFPXvtx/eovjkWtjdbSUcHWKpMeO175sQz9DaYDwmaGOKlF8je0V1jzY2a+NSTPvoyJU8G5zLdECC6HEN14M/QBvX5O8FxleG3yf/IFnsI0ZRY4Akc+PWNe9baLqgC2Y2HI9sSTKp/I/ePEW92W0xoloflEhXSJe1np3e+/vCZZsbzt+/hKdvnyFONEekjpMcw6o4K/b15rTD/h5rED1K9CDPEjZrz2zGyjazvttOmh2CN0Ybe8OLnb71fREuYWEnvd9IeV/MvU96drKkM5659zem7JmNq09uInqUqKiStayaI9jZ2GHduS0YuXUKRlXra5i/DNwwFlsv7IHMlx6+fmqYC4U219Grw63ndzF2+zQ8ev0UT996I05URxRLVwDOZTuoOmjJdfdMLD2xBjMajke+FDkMfzceE2xgg/jR46BMxmLoWKw5IkeIFGTMMHXdeD4XWhsssZO5uVBwBv6fA9Bwbge0KdIY5TIWN9uXZA6lNzY75axidk6qjVMTd3rixO2zsLWxQd6UuTCgQhfEdohlGLtljK+QqYT695UnN9BgXgfD2G3ODqfunkfp5JaNfXr9Qbv+Uz2y0inffXyPLIkzWFpf5iOBMCMwbf98XH96C1PqjAhS5ju/9yjqWkP9yKeN+2XSt/fqYQzaMM4wgdFukIHRY998ZE6UXg2akkwJ2R1dVwQRitr92sAo12XgPHzzJFx3eqJD8eYGAaYnVC257rl/ASbWGoqMidJj6fE1WHx8Nda0m6sGchFVIhYa5a1p4HDk5in0WjMMO7p6YfM/u8wKaeM2iBj28XuPBUe9sPL0RuzqtkIJRfmR1QY+mRgevnECfdaOwrymk5A1cUbDc4XdvZePMLXuyCA2kR9hR4cY6F22A+68eIBp++bhhvcdrGg9A9EiOSihK9cHVuhmsn/sunxACc+FzaYiaazEePL2Gdot64OyGYqhU/HmFvWpvVePoN+6UTjedwu2X9qH4ZtccaT3RovuNc7k98kPlx9fV2JfJsXhKYWlkL385DriRott8r3R3rOXvm/+EyEbiED1flprMiVk68/tgHIZi6FloQZwmtUK1bOVR7MCdXWbeOzWafReO1JNToOnRvM7oVq28qiXu5rhUv257VEpS2k0zV8nSHYZEwI+BcCt7ki1qGZKyBpPloI/y/idl3fq+K2z6LNuJMbWGKgWqYKPi/LOj9wySdnRvd7oENdNNVyErEuNASiZvrBZLqGNW7KAuPHvXVjRyhMy8ZVFw7jRHDGyal9dzloGc3aaeWgxztz9G+71RqHFoh7qN2jCDg/4BnzE6Gp9UXB8VSxpMQ2yKGicJu2eqUT1hJr/Ljh9q530xt7wYqdvfV+Ee1jaKbS+pvc+6dlJr0PKAmytWa3VGCELjN5vn6txQIRkt5KtlZCdfmAh0sRNofqhzANkIeXR6ydBhKy5uY5eHdou7Y3sSTOjecG6kP+e0XAcWizqjjq5qhnGHBnrKrg3wJsPb1EhU0mMqNrHUKzxmPA58DOue99Wi1GF0+RDr9LtgowJpq5bMl/THmbOTpbMhbRyFh5biaM3Txnml+b6Uq0clXTHZlnME+dKaHNScWI0mNMBCWPGx8CK3RHJLgJGb3NXCwcyf5Lx03g+J/U0JWTN2SFceWSlU91/8cCkR0yvQ/N6+CBw8MZxeO5fiPf+HxDJNgIa56+lJkKSPgR8RKEJVdVAtPWf3Xj+7hWiRrLH6Br9kTB6PIzeNhV3XzxQK95aksmKrJzObTIJ2f+/Ch4aqf+xdx5gVRxdH/+LvRtjiSaxtxh7j72CNYiCiB2xgAIWbCgqdpCioIKIiihiVyzYsPeuqUZj771iF32fc3x3veDl7kXEiJz5nvf5Irt3d+Y3s7Pzn1N23Z9bELp/CZb1DMbjF9F8rZ/zlcSZOxfQfrY9ixTF2mZIyNIk8/f10/BvN54XDB8rZBWLKO0kzt2/GFHOS9gCaYxQNWSxtQzugZpFqqqWEFqUN5/eEe0q/wrbX9pj5u752Hv2MBZ0e295HrV2MmLexGCCuavm/eMKWeKtWB1X28/Dj9/k/2Dio3Oon3rW7qhaUBRxYkjIKkKVxkargC68CLep0lpTyAbvXYjdZw5ifld/dThcun8V6dKk47FkTDl66Xd+6VG/7D9/FGMjfbDBMZx/2m1+f7Qs2xiWFVvGuhT9hiz/ZA28HX0XNnMc+DhZS+JaZP22z8a9J/e5ThfuXuZdZ5uqFrE2GAw9L15RAXjy8hku37vKu7ZWlVphze+bkT1DVnVjgK47OSoA1x7cgImJCWoXrcY76opVuvM8JzQoURN/XT+N+08f4P7TRxjRzBlVCpTnendfMACmpeurmyzHL//Bi3OyTFMhIXvuzkVky5gV+84eRhqT1OhRqwMsKjTn4/qso/bhQ1C9cCUei1S6hvbD1QfXeSFC1sK4FlndhYI+IUu/Hb3OmxdQZNmrU7w6Fh9ZrVpk6VmfsjUYxy79jlSpTFAkVwEMNXNUrfu0AKvr0xoRvefCf0cIn/f4eTQLAmMt6Ib66eydC7Bb4IIAm0ko/V0Jbs6kTf68gTPdegI/81r9pDVe6fmYuMGPd9TJEmlRsQV7VehaZGkhaFq6Ho9ZGr+ty5vFehbjuwcJIHp2yXKaI1N2/HH1JIrlKYxMaTOi4VQreLQejmqFKqo/NySQSCDSmKfNxMQIWeVmJGSzZcgKt2b99c5b5FURuCuUn1uteZWumVghS4tCGs/kmULWsuA9C7G8VzDX0dhiqJ/oXfMy5jWGN3UGbSLM6uiFpy+f4U70PX4XtQrsin4N7NC4VF1+r9FckDvLtxi8ahwKf/sjW6KU8rH9pCWQ9B1Pjv30sc+L8l77VP1kSCAZep60+klrPAbtXgBaM61xmKdu6p288S/uPLmHOkWrs5Dde+4I6J2woNt0HL5wHMev/AV65nQtsroCKu5aR6sONEZta7bn9xb1B3ls0bgmL7D82b/jn+/8dz8GLndHr9qdMP/gMkT1W8JzExV9z/zSY2sQfjiC53ut4/rWOvG1wRghq7RX31qIjt14fJvXoiFdpqDwtwX4dEPPPM3HWnPzN5m/MShkyWJKbNf1ma8ypXfmpr93sNdOWpM0RglZQ/0gQlZrpMvxZEOALPK0sKfd8aoFK/DitdM8J3i3GYXKBcqxey65w7Uo0whjWg7mBZ7TkhEokPN7DG7SB6dvnQNNbIpYoobTbtWO0/tYJGiVv66fQs+wQSxYyUI5ZdssRPYNYyut95ZAvq5StIRsue9/wr+3zrM1ILFCVpksaWItkPMHzQWXoQUZWT9pMTbRfLjqBkJtGrB8NFsIyNpw5cE1/BrYDRH2ISjwzfd48folmvi1g2ebkewurbXgizu5k4gK2DmPheOKXnNYzOju4FG/bvlnN9zXeWNpj5ncRqVoWWR1La70Yk5Pu4XmrppC9u8bp2Eb2h9Nf27AQowWluQarhR64c3Z+06Uxi2LewQhX7Y8IFdB14gJWN5zNmjsjI30xZIeQXz6+A1TkSFtenZbJCH05k0ML1bpJbnl5G5eYOqWSpNMPxCyJALppRjSdSpK5imKP66dZCtLlPNiFmRazwtZWQ5dOIFFdgGwDu6N8j/+zPWp42OO1Q6h7IZlOasnWpRthN61O7PYdVo8AtUKV+R/UyGhSqJtbmdfdkcM2b8EG//aprbTGCFLz5JX25G8uCEh1WexKy9+aKFhjJBVOPVcOIhFdUKFbL+lI5EjUzaeM0jQOS9x475TXIvJs4JcVslDgdzJyA3t1I0zsfqIFgM0Prr80o539VObvHObN8Yqq9VPdJ2Nf+9A4K55WNg9AEcunoDX5gAs7D4DOTJmZ1dWQ/30+9W/eR7UVyicodnPDXkBt/b3zZjX1Y/bMW3HXHat1xWytMFiVroempSqB+elbmhdvikalqytNW3y8dre5mwNoc2QTiGOvNnYsGQt/juJRHLdVYohgeTVZiRbEOZ08kHuLDk/cC021iKr3KvfspHImzU3C7u489at6LsYsXoSj8MxLQdpzmt0zcQKWboGbeyQyKSx42ExAnWL1VDZ0LxIc0Xc0vTnhnA1c+I/G+qn41f+hOPi4bAo3xQ7/j2AoA6e+D5HPvVy1K+VCpRF5+qWaDDFivvIvYUL91mHahaxQlg+tp+0BJK+48mtn7T6Qeuh+ZT9ZEggGXqetPpJqw0kDtOmTgNPCze9p5KQ3Xf+KHJmyo48WXPxu8j2F2ue/+MTsnHXOlp1oHmNLJS0SUteVvO7TVNFqvJblxVj8OTFE66nqX97uDUfgFZlm/BhfWsZel+t+m0DVvaao3lcn5CNrw3GCFlDayGqL204/ZgjP5wb2KlotMaS1tz86Hm0QSEbfngl5u5bjC39lsbbHcZYZA31Q7IXskfunFBfwvTCfvPmDS8AqSh0HmYDAAAgAElEQVQvYa3BLMe/DgIkOo9c/A3BHb3VBpFl4vWbNxjZrL8qZGmRQ65nVOg3f187rVqYyK2EXCUototcQchKF9fKFx8txfJCFjayQNJ4bFmmMceE7jt3GH5W791bDQrZs0cw/tch7KIb3j0Aiw6v+iBGNm4cZZcaVrwbrm9ivPvkPpr4W7MFiCw2WkLS0HHFykHWYtrFVAq1lyY0xa3aLswF1QpVYEFDLwivqEBscFyoWoTJmhO3DfTbGoUrq20gF9+3FA/08hmL5r71bdUdPZr4Xrx6wS9Cim2s8GMZ2NfpzBsYuiUhQnbiRn/cfHyb+4le0jtO72XRrFt2uaxSrY20c7vi2DrsP3eULcb1S9RkbxAlzlbrqSJLNol82gCgsUbjhf6bCsUNkgWSNmV6hLng1uO7WO0QwvE8aU1Sf+B1Ep+Q/ePq36oLEd2vyqSmbCkvna8Ej31DzwsJWbLI0rNDVlJqH7l4NvKzwnTridwvDouGYs+gNWpfRv2zEzN2zONNDCokVH8pUgU9a3Xkf9PuLAlDJSbQGCFLbuP0HCil9UxbdK/Znj0tPoeQJfExvf1E1Yoc+edW3pgiIUsWsl8mt0SAjYd6/N7T+2jsZ42NTovUsUDxPkVzFeJ4r4QWrX5Srue5+V2s1z83/oWv5RjuYypkxdfqJ6060eKx/A+l1Q0K2tknLwxdIUvuuBQrTrFlNK7TpH7338aUDnP7oOsv7diyT2EI32XLja6/WPNmUVyXY0MCaYb1RJDLPnkruDTq9YGQpQWpEuNK9aIwpNmdfLiKugtziiPbdmoPRq7xRFBHL1T8oQzPm7RBkCV9JryKeY20adKx4OtdpzO79CvxcvHNa3SPTyFk6Trk6XD1wQ1E9l2Q4HACrX66eO8yVhxfj4gTG7gfy/1QmkMsCn37I2/S0LxL3iJ+2+fg5qPbbGkhy/n09hNUjwCq48f2k9bc+7X0k1Y/aD03n6qfDAkkQ8+TVj9p1Z88Z374Jj97O+gr7yyyR9GthhXcI73xOiaGQ3/Iqy4+IRt3raNVBzp+6OIJrP19Ezb+tYM3GGnTx6WxPbKmz8xeRE2ndcDIFgN5LTdwhTuHLypee7prJXq/nrz+LwYuH83eaeTdpXXcmPWa0gZD/WTMWoi8vsZF+mJ579kfiHVDY0lrblbaEN+alLzX6J1JhpT4irIBl/b/+UFi3r7hzWElv4FWPyR7IaubtVhci415bL/ec0iIUPxljozZ1EaSOKAYCLLK6ovroofsxOU/ObkSFXrg/LYFY73jQo4jcFs7GZucwlWBoUXPbJoNJpgPw7BVE3gXP+rkLo4NIKEyoOH7JE1aQpZiOmmxTDFfaVKn4f+vm+zJmBhZxbVYsTQrrh2JEbK0wKvh2QLjzYehWekGKo7+y0Zx/KHyUor4bQNCDyznhFK0k0ZucMouoNb9dSf31KlMYBFkx+6oZOlRiu4OHgm9orkLwtXM+YPuSYiQpXrSIpUsbwndbaYXwZhIX14kKwtjrbFi6DgJPvd1PhxD0nexK3745nt0rWEJv22z8Ws5U9VdXrlGfEI2bqKkKh5N2TpKyWK0nhcSsmTdIXFOdWhcqg679FLSHdrIuPzgGkas9ohlLaNxTot8ZfdVS6hqHSer8r+3zsWKO6fNpgYla3GMZFILWWVziizlxXMXZtzk5jtqrRcLWWXhRJsXJOKU8vjFUwTaTOLQAipkQaNEJuS2ntCi1U/K9cglj8Rl7WLV4dvWXb0NxV9r9ZNWnWgx06qcqVr/Z6+eo5b3r7GErNY1DB0nyya5Ex88fwyda1jxgmtE8/4I2rWAN+B0i5ZAypstNyxm2rInglVwr1jJnrQssrv/3a9uhJMlktzYFauy7rxFi98By0ZhWc9Z6uaa1rxGbdCX7Ek3CZ3WopWOLzu2ll3b82XPwx4vlAQpKQqNWdpcDNm3GLvPHmIviFUnNmDrP7t545Dm5q0k9psPAI0PJWGhUpeP7SetuZeOSz+97/HE9pOWkI3vedLqJ60xSb9PlQqx4qp1f6MIWUr0R+FM9P7v9os1fvFqGa+QjbvW0aqDcpzymJD7K3nVkIcNhS+Rp8HCw6tA+UA291vM4o8SRFK9ydOOvKp0N7fevn2L7Jmyc0gFhbUoYVzK5pe+4/qEbHxtMMYiG99aiDZN2gX3ZgNNo1J14sWibyy5rfYwODfra4PuDYjRrN1h2NZ/Wbz3pfUc5RahzXIq525fhP2ioercrdUPImSNHely3hdPgBJhHL30BwL+L0rjVtgYIUsPfNNpHeHe0gURJzbih2/yqbGgxgCghD/F8xTmmDRys20X3AuVfiyLqoUqxIoXM0bIKhkpyXWVLIMfK2Tn7lvEix8l/lJrwaV1nBIuVC1YXrUKknihXcvutWzUWEcSAKZ+1gjs4AnaeaXYkyK5CjJCrevHnRiXH18HiqdZ2Wu2mi1TV8jS+Z3m9mHLiZLVWGtBGPclTG6xzad34vgvEmtaL2mK7SFhoxvjSJbnseunYtfAleyKqeVabGg8PXj2kK16lD3xwdOHyJ89LyelogyC/tbjY1k+6DofI2S1nhctIUubRGTpI+uqrpVLt11aQpVevA1K1lbjdsl9fPDKsbFiZI9e+g1zO09RL9s6qPs7i2xZU86S7bJiLDNXCrk5NipVW42RVf7+Ma7FtMtOGzdkkVWs/StPrGfXWhKyNPbJQkBjz1AMPS0QLCu2UGN7jZlLlHO0+onOo3r2XzoK3+f4jhO89a1nyxkpqZy48pfBfjLGtZgWFfRs2dfpwte8dO8KqB90LbIJaVPcc2ftCeMsuRTGQZbsbqH92IWVsqLHtWJrCSSyRFO204xp0yP88KoECVlDCd7izluuERM5FwJ5Jxgzr9E5ibXIUrgMh8+0n8julu1n94aPpbvqDWCMa3F8/URjiPqBsjSTK7cSI/sq5hVbXGnzlPI+eGychpyZc7CHDIV00AI96uRO9f2iXP9j+0lr7tU6nhz6KTHPyqfuJy0hG9/zpNUPWm2cd2AJFh+OYKOB8v6gddO8A0sxusVA9gggiywJWdo4I2sd5dkwJGTjrnUM1YFCA8ijyqFuVyhCltYptFEzfec83oSnhFzn71xUN7dorNPahkSXXc0OmmuZhK51qL7xtcEYIRvfWogMNscv//nB2tiYsbTy+HqDc7OWkP3z2j/oEurMrtbk1UGFDCLua73g3LAnzzVarsVa/SBCVutpk+PJhgAl21FiZEk8Pn7xBP7bZ8OsdH1+0RsjZKmxlA6eXEV3/XsQy3vN4qy0xhZyZd5z5hA6UFKdam056cntx3fYgknuaUoxRsjSuZRunhInkWttQoVsBvqsw9lDmLB+KgY06qUuorUmV63jtJCfunUW716Wzl+SsxbTJ0zIzY3cgZVCdb9y/zq7X4Z1e29V0bp+3ImRxAJNhCXyFMWo5gP48nEnPhJd5L4d3j0wlsuylkWWrOZUxylbZ3Hs2SK7QHbV03pJj17nxVmOJ7dxY4sMub6QRZbHT5ys1caOnbjnkTs4paenT2vQZG8fPgxnb1/AnkGrORZTt3yMkNV6XrSEbPG8RdjiZV7OlEUjvZzIDT5N6rTo8H/Lo5aQJZd0E5PUvPtN/UyunGTl0U32NP/AUraukVs8Jf6gzSKK0aUdcSUeW9khp8zE3UL7o3edTgkWsuQ2Sa6tPm1Hx2JLbtW0cB/XagiiXzyB89KRuHjvihojS59Qos8f0MYV9Qu5xtJnC6hNSjFGyNJmE23Y0BikBDpK0eonOm/23nD2ICFBffrWWfRdPJwt75TQg/pFq5+0xiiJafJWCe0yFZnSZ2IX26XH1n4yIUsu6VO3BqNE3qKYYjmGNwoolpo2lcgqqluMEUjkIdF5Xj/+NJYSEx53zojbZq1nXl+MbNsgO7g2deLYUK15je6XGCFLi06yGpXIU4RzOlChmPn5B5Zjac+gD9wFtfpU33GKlf4mU3a4Ne/P8fQUi08iNWBnKH9Sjdz9yEOGkiSu7TMfBy8cx/j1U/Bjzu8x08bzk/STVj9oHZd+Slg/GSNk9T1PWv2gNf4oBKMt5Vgo0xg9a3XgTaGhqyag4o9lOBeDrkVWuRa5uusTsvGtdQzVgcRxixmd4VC3C2dBp2crtKs/56d4/uo5J4Gi9SR5RcX9EsKec0fiTeake0+tOUF3raPVBmOELN077lqI1rLt5/TBgm5+KJjznZDULVrP/NZTuw3OzVpClu5FoWb02R3KJZA1QxZ4R81kTyvytqFNDENCljYctPrhqxKyWg+OHP/6CdAicsbOEDx89hivY17xN72c6tvxAtNYIUuLY/NAW9QqWpVdKBNSlDgp5VM7lNGSdsPIrYISr6w4HsmfbaGdPfo/ZSeSYi/JdYV+v//sETVm99Sts/wQt6vUKpaQ1WcBm9/NH2lTp+PAezpOrl+UyIoScyiZm6ktSh3jXmOK1RhOqKN1nK5BSXuWHInA/acPefE5xLRPrMmeziG3TxIB5M6n+/mM+K5Pi6OdA1fpjfOlLM4kZikhDG1KxJ34aEeVFpUWFZtzHB+5Km46uZPFERVqK+0sK1mG6SWsfEc2c/rMqFWkMvo17KW6yeoe1+3/OsWq80Kbkv5M3z6HRdeTl8+RKW161CxaDc4NunM/f4pC7CgOjlz6qJBFkVxZaWeTCrn7Upp6KpS1mL4lTH1OscmUjEvfp2t0XYvpd4aeFy0hSzzJMkfxzxfuXcGzl8/YjZ+syCQyqWgJWdo8oA0Pcsv9JmN2tqRO2OCPw8M28O8p8zKJS3Kvp8zH5GLfq04ntsYqhT57tfnvnexqWSx3IdCLj5JbkQCi+NJlR9990oiyFqdPk57nAvofiV/dQiyoLpREh166c7tMYddNWsSNXufD1qi82XKhbcUWmLZ9Do9VKsqGGSWievbyOfJlz8tu9JRgTinGCFmy4tMmGlko4ma+NtRPZJUm6yAlelKSIpEr1qoTkWryEq1+0hqv9HyNXz8VBy4cQ7YMWdgyS8nVKDmKsZmXDd1DWQwpcwW57pInB33ORXGFo09g3Hlyn59p6iP6hjTNbfSpDio0J1BMnxIbTPFsZOHV/Y6s8r1F3bpQJmv6XqzWwlzfolTJMLqi12xOuEWx/3HnVWVeo3tqCVlD8xZtFtL9yJ1ZyZpK7xBKMEjfC1eSOWn1paHjtCHnvWUmW/HvRt9Drizf8nNFG6FKRmziXKVgee4bmgfr+7aBRYVmPM9TSWw/ac290k/gjdPE9pPWO1LredLqJ2PGIa1vfKJmciJCSiJH65S+9bup35FVLLLKtfQJWUNrHa06UJZk2sQmTwd6t+bOmgtl85fkd9jcvYv4nRPy/+9SK9ciYUjJLGmj8O8b/xr8lKCxQtZQG4zpJ92QibhrIQr7orANx3q2enFojSWtuVk5Ht+alOYN8jAj8br7zAFe+1YvUhnDTB05YaQyd8f3HVnybNPqhzrfV9Xq6gQd/0+/I5ugmsrJQkAICAEhIASEgBAQAh8QUFyLdbOxC6Yvj4D0U+L7RNe1OPFXS75XSK5jSSyyyXfMSc2FgBAQAkJACAgBISAEhMAXQ4DiPC8/uB5vfShUqnqhSl9MfaUiyZuACNnk3X9SeyEgBISAEBACQkAICAEhIASEQIojIEI2xXW5NFgICAEhIASEgBAQAkJACAgBIZC8CSR7IZu88UvthYAQEAJCQAgIASEgBISAEBACQiChBDKmT5vQnxg8/7Mne/qktZeLCQEhIASEgBAQAkJACAgBISAEhMAXT0CE7BffRVJBISAEhIAQEAJCQAgIASEgBISAENAlIEJWxoMQEAJCQAgIASEgBISAEBACQkAIJCsCImSTVXdJZYWAEBACQkAICAEhIASEgBAQAkJAhKyMASEgBISAEBACQkAICAEhIASEgBBIVgREyCar7kpcZYcMG45jx0/g3r17GDF8GNpatE7cBeXXQkAICAEhIASEgBAQAkJACAiB/4CACNn/APp/fUsraxu0b28tQva/7gi5vxAQAkJACAgBISAEhIAQEAIfRUCE7Edh+/J+9PbtW8wLXYDVa9bizZs3yJY9G4a4DES5cmU/qGx8QnbL1q2YGRSM5y9egq7XrKkp+tj3homJCV/j/IUL8PT0xpVr15DaxAR16tSGs2MfpEuX7ssDIjUSAkJACAgBISAEhIAQEAJC4KslIEL2K+nalRERCAwKRljIXOT9Li927NgJt9Hu2LBuDbJmzRqrlfqE7IsXL1CrTn0sWRSGokWL4unTZxg7fjx69rBD0SJF8PLVK1i0sULLls3h0LsXH3dwdEKN6tX431KEgBAQAkJACAgBISAEhIAQEAKfi4AI2c9FOonvY9fTHlUqV4KD/XtRadHWCj3s7NCieVNNIfv69Ws0atIUbdpYoFXL5ihSuHCs3xw5egy97PvgwL7dSJc2LR/bvDkK/jMCsW71yiRunVxeCAgBISAEhIAQEAJCQAgIASHwnoAI2a9kNJhbWOL+/fvImDmT2qLnT5+hh50tOnfqqClk6QRyHZ43bz72HTiAmJgYtLFozdbW1KlTY+OmzRg23I2tvUp5ExMDEsDbt2z+SihKM4SAEBACQkAICAEhIASEgBBIDgREyCaHXjKijr3t+6Jq1croYddd82xjkj2dOXsWg4cMQzsrS9i0t8aJE7+hp30fHNy3W42Z1byRnCAEhIAQEAJCQAgIASEgBISAEEgCAiJkkwDqf3HJNWsjMTNoFkLmBCNv3jy4fOUKfKf4Y4TrUOTK9W2sKlnbdMKvrVqgYwcb9e+n/z2DqX7+mOw5CVkyZ8arV69h79AXLVo2Q5vWrfnfbSyt0dq8Jey62/K/F4YvQtq0aWJd579ou9xTCAgBISAEhIAQEAJCQAgIgZRFQITsV9LflGV4QdhCrFgZgWcvniNDuvTo3KkDrCzbftDCWcFzMHtuCDJnzoSc33yDFcuWcJbi6QGB2LR5C2ckplK3bh30d3Zk12IqFy9dhOdkH1y4cBHPnj9D+fLlMWyQC77L991XQlGaIQSEgBAQAkJACAgBISAEhEByICBCNjn0ktRRCAgBISAEhIAQEAJCQAgIASEgBFQCImRlMAgBISAEhIAQEAJCQAgIASEgBIRAsiIgQjZZdZdUVggIASEgBISAEBACQkAICAEhIAREyMoYEAJCQAgIASEgBISAEBACQkAICIFkRUCEbLLqLqmsEBACQkAICAEhIASEgBAQAkJACIiQlTEgBISAEBACQkAICAEhIASEgBAQAsmKgAjZZNVdUlkhIASEgBAQAkJACAgBISAEhIAQECErY0AICAEhIASEgBAQAkJACAgBISAEkhUBEbLJqrukskJACAgBISAEhIAQEAJCQAgIASEgQlbGgBAQAkJACAgBISAEhIAQEAJCQAgkKwIiZJNVd2lXtmdvBwQHBfKJLoOHYvRIN2TLlpX/PWduCFauWo2nz57CxCQ16teri6GDXZAuXTrtC38hZzx4+BDd7Xph5fIlX0iN/ptqtLWyRvCsmcj5zTfxVsBt1Gg8ehwN/yk+/0klDxw8BC9vH1y6fAWpUqVC5UqVEDjDP1ZdzFq0QqcONujcsUOsvy8MX4SQ0AWIjn6MBvXrYdKE8UnahtevX6NS1RpYsWwJihcrqt7r6rWraNbCHEsWLcRPpUomqA6fuw0JqpycLASEgBAQAkJACAiBZE5AhGwy70Dd6r989QoDBg7CjGl+/Gd7B0fMDJzO/705agsmTvLEgvkh+PGHH3Dz5i306OUAU9NGcOrb54ul8PbtWxZBSiFx5OnljVXLl36xdU7qir18+RLVa9bB1qiNBoXs5cuXEfPmDQoVLJjUVdJ7/U5dbfFz6dIYNHAA0qZNg7h9ST86+c8/yJUrF3LnyqX3Gp5ePnjw4P5/JmSJ9T//nELx4sWQMWPGj+L4udrwUZWTHwkBISAEhIAQEAJCIJkSECGbTDtOX7VJFKzfsAkuA/rh6dNncBvlDl9vTz41KHg2du3eg4Xz56k/vXTpEtKnS4+83+XF/oMHMXTocOzasVU9TtbdGtWrwa67LZ4/f45qv9TG8GFDsGXrdjx+/Bjf5MiBsWNHI0/u3PybDp27okb16jh96jQePHqIly9eYPiwoahQoTwff/jwEXx8p+Do8RMsTgv8+AOGDRmEAgUK8PHoJ09Qs3Y9rF29An7+ATh69CgePX6M8LD5bA1bsDAcgYFBePb8OXLkyM6/qV2zJsaNdTeqF/VZ3YjLieO/ITBgGl/j3zNnMdHDA3du3wOdX6Zsabi5uiJ79mx8nNrt4+uHI8eOwSRVKhQpWgTDhw5Gnjx5jKrDFD9/3L17F+nSpcfFCxdx7foNdOzQHp062qi/X7Z8BUIXLMTLVy+RKUNG9Hd2RP369fj4H3/8CUfn/rj/4AFy5swJ0vhZMmdlZkrx8pmC9Rs28BioXr1aLIvsho2bMHbcBGyN2oRMmd4LM3MLS7Rq2Rw97Lonuo1+02YgYvVq3L//AJkyZUL69O8s/s2bNcNglwH83526dsPVq9d4TAzo7/yBRVZpS3wiMLH9QON53IRJOHjoMLJnywrLtm0wydNLtcjeun0b1jYduRp3797Ta5E11E+6gyG+Npw5exaTvXxw9dp1mKQyQdWqlTFwQD9kyZyZf07W4FGjx+HipUvImzcP13HChEk4cmi/UWNNThICQkAICAEhIASEwNdMQITsV9C7L168wOBhw3Hzxg2QssmbNy8ePXqE+/fuo3jxovCe7Im//j6JLt1s0aypGZqamaFixQrInCmT2notIauIwKZmpvCcNIGF6FDXEWxpGz92DF+ni60d7t97gPCweciaNStooR8ybz7WrVkFExMTDB7mipcvX8Hb04N/5z89ALt27cLSxeF8nIpp85bIkikzbLt14bqmTp2a/65YZSPWrEXo/AUfZZE1Rsh279ELZqZNYN3Oii2IgTNnoVjRIjA1bcL1GO42Eg8ePMQUHy+kT58eJBrJYjcneKZRI2najAAsCAvH/HlzUapkCfz++5/oYtsd27ZsYuvq2XPn0MbSGiuXLUbRokWxMmI1PCd7Y/fObUiXNq0qcMjddce2KIMWWar7yVOnYgnZV69ew7RZczg59kWb1uZ8vSNHj8HeoS82b4xkcZzYNiogfm3dFg72vbgf4yvEu0GD+gkWsomt47zQBVi9di3C5s/j54DEN7nex3UtpnqXq1jlAyFrTD8pbdYnZOmZNbewgnU7Sx7r9O++Tv1RpEhh3iyi0m/gIH5OJk+aiOjoJ3BwdMKZM2dxcN9uo8aanCQEhIAQEAJCQAgIga+ZgAjZr6h3J0zyRPt2liyAFoQtRIGCBVCvTh21hWQBWrpsBfbtP4Br166hYYN6GDLIha2JxgpZinGsVbMmX5Pclb2nTMXm9ev43yRkK1esiH7Ojvzve/fvo37DJli/bjW+y5sXVarXxOxZM1GlcqV3x+/dQ/1GplgTsUJ1fyUrWNGiRTBx/Di9PZPUQpbEw9s3b9Cjuy1Kl/4JadKkUesRExODqjVqIShwOqpWqRKrDVs2rTfKKktC9vff/1DjmEksV6hcDeELQvHzz6VZPD9+HK3GNd+6dQuNzZojcm0Eu4RTUeI2P0bI0u9pA+HQ4cMICw3h6w0bPoI3Eoj5p2ijAiyphOynqCO53ZcvX46FNpWbN26iSbMWRgtZY/pJ4aBPyBJ/h75OOLB3D4tVfp42R8HDywfbojbyv8k7YbLnJNSu9e55W7V6DTw8vUTIfkVztjRFCAgBISAEhIAQ+HgCImQ/nt0X98ve9n0RMMOfrZiuI9zQ39mZXRL1lQsXL2KU+1ikTm2CkNnBRgvZJYvC8FOpUnzJfQcOYMDAwerCmoRsk0YN0bnTO5dMsv5VrlYDi8Lmcxxkk6bNY4lWRcTNIXFbpTL/xrpDJ5i3aokONu311juphWx0dDTmzJ2Hnbt24/r166hTpzZchw1hN+o7d+6iYRMzFqyp07yzFFOJfhyNoIDpKFPmZ80xQUL2/PmLqss3/YCE7PyQOShXrixb5mYEzsThI0fZCk2i7eTJf7Bu9UrVBTuxQpY2MZq3ao3lSxfh22+/RRPTZpg7OxjlypX5JG1UICSVkP0U/WBt0wnmv74fZ8+ePeO4Y2Mtssb0k8JBn5BdF7kBvlP9VNFK55Jl3K5nb5w4egivX8eozw5tcFChzab+AwaJkNV8yuQEISAEhIAQEAJCICUQECH7FfQyLXAXLlyMv0/+jTJlynCLfjvxG8pXKI8ypUujV087rF0XiWLFisXKvEoW1THjJmDvru1soRvgMoT/WyntO3ZmYUoxsopbLiWPqlmjBp8SuX4jpk0PwMb1a/jfJGSrVK4MZ8d3yaMUa+LGyDXInTsPqtaoidlBgapoVQSJrkgjIdvOyhJtLVrr7ZnECNk3b96waCRXZnLrpeIzxQ9n/j2jxsjq3pRiIydNnow3MW9ZeNLvq9WohTnBQWzN+5iiJWTJHThyw0bMmxOMXLm+VS2Fn1LIUr0dnQegUKGCvNGxLnI9loSHcXM+RRsVLkklZD9FHXvZ90GF8uXRx6E3V/fipYtoZd7WaCFrTD8pHAxZZPfv3a26jG/ctBnevlNB1n0qJKyn+09Rrf/LV66Cl7evCNmPefDkN0JACAgBISAEhMBXR0CE7FfSpcePnwBl9CVXydt37sB3ytRYmV7pUyxnzp6Dj5cHvs//Pbv9jnZ/5747zc8Xl69cQYtWrbEpci3y5c/H2WQ7d+0Oh949YwlZM7Mm8Pj/p1AcnfpzPK77aDdVyD64/wDzQmZz7CYlUlq7bj3WRqxg66ISI+sz2YNddim+9MRvv7GLqxIDqyVkt2zdinHjJ2FNxEpkzpwJd27fwXf5vjO6FykG16mPA1q1bIFHjx6jU5du+D5/fhaylPW5t0MfuE96dYkAACAASURBVA13RdEiRd6xmRHAllnF1XnU6DF48OgRvDwmcozs3n37sGlTFMaOGW1UHbSE7PiJHrhx4yYLGLJY+07155jgxeFhKP3TO0s4fYKobv1GbEmvVKkC7t27z4mb4mbV1Rcjq1Ry15498Jzsw0msaOOg9a+t1Ponto2fUsjSGLl67Rqm+njF4pvYOgbPnssCfkFoCI8jj8neWLJ0mdFC1ph+Uiqsrw2UDbmVRVvYtGuHbl07gyzC9n2dUKF8OQzo58w/JbFdsGABjHAdxonQnPsN4Fh3iZE16lGTk4SAEBACQkAICIGvnIAI2a+kg0k0VqlUGZUrVwS5LZJLKrlOKoWytFJCGxKClM2WRA9l/O3Xz5HdZqlQ7OSmTZuRL18+FCtWFLdv30bJEiXYoqtYZAcN7M+W2Hv376FY0WIYP9Yd336bUxWy5cqWxcm/T3Im1ixZMvF3bMuWfWclpgy1Xj4+OPHbHyzS6JMmwwa5xBKiWkKWFvz0fdyjx46zC/WPP3zPiXiMLVFbtmKq3zTkzpMbub7NiSKFi7CYnjUzgC9BWX1nz5nLrp1UihQpghGuQ9k6SoVcj0lcUrZbqkv+/N+xC7cS96tVDy0hSy7fQ4a6IpWJCYvTvvb2mBMSigsXLmJmoD8KFnj3KR1qw7IVKxET8xq5cuWGj5cnSpYozu6nw0eM5HOon2Nev0bW/39HeMY0f1UMk1WzRSsLPHkSjahN61mUKyWxbVSuE59FNjBoFpYuW66OifTp0iFDxgxIlz49b6ToFtoocB0+kjc6TFKbIHTubHaxTmwdnzx9ijFjx+PAgYPImi0b+tj3xih3d4TND2WvBYc+Tvjn9CmuClnmc2TPzu7k1apW5WRnxvYT/T6+NlDMuoenN27cvIlUSIW6dWrBybEPMmTIwPc9e/Ys3EaPwcMHD/mZbNrUlLN+H9gryZ60njM5LgSEgBAQAkJACHz9BETIfv19/ElaqAjZlcuXoFjRonqvSa7FzZuaob11u09yT7mIEBAC7wns3L0bZAmO2hApWISAEBACQkAICAEhkOIJiJBN8UPAOAD6Pl0T95ckZJuZmcKmvbVxF5WzhIAQiJcAeT7MnjsXC+bN5e/xuo4gyzTgMXGCUBMCQkAICAEhIASEQIonIEI2xQ8B4wCIkDWOk5wlBD4VAYqjnThpMvYe2I80Jmn4m9BuI1yRJ3fuT3ULuY4QEAJCQAgIASEgBJItARGyybbrpOJCQAgIASEgBISAEBACQkAICIGUSUCEbMrsd2m1EBACQkAICAEhIASEgBAQAkIg2RIQIZtsu04qLgSEgBAQAkJACAgBISAEhIAQSJkERMimzH6XVgsBISAEhIAQEAJCQAgIASEgBJItARGyybbrpOJCQAgIASEgBISAEBACQkAICIGUSUCEbMrsd2m1EBACQkAICAEhIASEgBAQAkIg2RIQIZtsu04qLgSEgBAQAkJACAgBISAEhIAQSJkERMimzH7/z1q9ZetWHDx0BCNch350Hbx8pmBB2EIEBwWierWq6nXKVawS7zXXrV4J97HjceToMb3njB7lhrYWrfnY/QcP0Ni0KcqWLYt5c4JjnU/f9pzqPw0bNm5CdPQTlCpVEkNcBqJs2TJ83sBBQ5EjR3aMchuu/q5mnfpwH+UG0yaNNdv8++9/oFNX2w/Oq1u7NqZPm4pz58+jdRurD477+/mift268dZB9wd16zfCg4cPP7jGimVLULxYUc06UhupH01MTJArVy7U+qUG+vaxR548efi3xtSRztuxcxec+w9E7549+Pe6RR9H3ePR0dHwmOyF7Tt2gb5xTONghOsw5M37rg4vXryAt+9UREVtwdNnz1CyZAkMHjgQ5cq96ydjy71792DRth3Xr52VpbE/k/OEgBAQAkJACAgBISAEkpiACNkkBpzSL//mzRsWPEqZHhCIhw8ffbSQJdHSpGlzvkazpmaYMG7MB4gfPXqM2vUaYFHYfPz8c2m9XWBlbYMWzZujW9fOHxwPX7SYRRDdK3JtBH784Qf1nPETPbBv3374eHuicKFCCFsYjrkhoVgdsQK5c+X6ZEJ2z87tyJYta7zDx1AbtUQgCVnXYUOY38cU5frDhgzChYuX4D9tBs6ePYdlS8ORJXNm9ZJa/TDAZQh27tqF3HlyY+O6NUiVKpX6W6020PFLly5iio8XMmXKjFHuY3Dnzl0sDl/A1xkzdjwOHz0GHy9PFCpYAIsWL8Ws4NlYt2YVcubMqdnsZ8+e4dCRI/D19cPt27fRv5+TCFlNanKCEBACQkAICAEhIAQ+HwERsp+PdZLe6e3bt5gXugCr16wFicds2bOxpbBcubJ83zVrIxE4cxaWLg5D1qxZ8fLVK3Tu0g2NGjZEr5522L1nL8aMm4AONtbYu3c/7t27i8qVK2Po4EFImzYNX+PM2bOY7OWDq9euwySVCapWrYyBA/qp4mXHrl3w85sGT49JGDNuPC5cuAjSJiTKqAwaMhQ7du5mYZs5cyb+W98+DrBsY2E0G7Li9RvgAvtePTFv/gJs37IZmTJljPV7LQFFJxsSstY2nVgA79y1m+vmYN+Lr//8+XPUrtcQo9xG4NdWLdR7LluxEg3r18e33+ZMUUJWsToTl+atzNGjuy062LQ3SsgqVu+ePewQEBiEOcEzUbXKe4u6ISFLgrWRaVP4TfVRrdAXL11EK/O2CAsNQfHixVCnXkO4jx6Fli2aqfU5eOgwKpQvh/Tp02uOt34DB+Hli5fo0qUjpvpNY2u9WGQ1sckJQkAICAEhIASEgBD4bAREyH421El7o5UREQgMCkZYyFzk/S4vduzYCbfR7tiwbg0LVypjx0/Eo8eP4O3pAS9vX1y8dBnT/HzZgrX/4EHYOzhi+LAhsG5nhadPn7HY69nTDq1/bcWumuYWVrBuZwnbbl34332d+qNIkcL8GypXrl5Fi1atUaVSJfRzdmQRHRMTg9SpU6uNdxs1GhkzZvpoi2x/l8F4Eh0Nr8keaNTEDKNHjowlKulGiRGyp/89A8t27dmleNuOndi2bTtbZYnRyX9OwdqmI1atWIqiRYro7dBP5VqcHCyyuu7T1O506dLAY+IEo4TswvBFmD4jENu2bEI3u54oWbw4xo4Zrf7WkJClsdrbvi+2Rm1kK7hSatauhwH9nVGmTBnup4iVy1CkcGG9/URW6dcxMR8ca96sKdyGD4v1d+sOnUTIJu30JVcXAkJACAgBISAEhECCCYiQTTCyL/MHdj3tUaVyJdV6SLW0aGuFHnZ2aNG8KVea4js7d+vOcZDHT/zOrreK+6oiDg4f2KtarCZM8sTTp0/ZfffQ4cNw6OuEA3v3qBbazZuj4OHlg21RG/n6FLfI8aCj3dCm9bt407glMUL23v37aGLWDO6jRqJVyxYgq9mT6CeYPSsw1m0SI2RJ4JPVl8TrP6dOo137DgiZHYzKlSvi2LHjLLq2bN6APLlzxytkd+/ZgyxZ3rvY3r17D96TPRIUI5vUQjb6yROY6Ljyli1XhttpTNEnMsdNmISbN29huv8U9RKG+oGEZqmSJTHGfRTCFi7CjIB3ojZjxnfWdUNCljYXaEPj0P49yJAhg3o/0+Yt0cmmPcqVLYsutnZqP7Xv2Bk3b97k88aNcUftWjWNaaZ6jgjZBOGSk4WAEBACQkAICAEh8FkIiJD9LJiT/ibmFpa4f/8+Mv7fZZfu+PzpM/Sws0XnTh3VCkRt2QqXwUMxZJALOnW0Uf9OQtbFZQj27dmp/s1/egBOnzrNSYbWRW6A71Q/VbTSSZQ4ya5nb5w4eogtlk+ePsUvtepi+dLFKFG8mN5GJ0bIkuCZHhCAbVHv3Ikp4RAJnk2Ra5Evfz6jBJRykj7XYoqJbWzWnK3ODr3fuROTdbbMzz/DffRI/HvmLNpaWWPl8iUoVlR/UiSqT8aMGTimUinmrdvy7xOT7KlL504YNLC/UW3Uii/9VDGyuhZZEpZZMmfC+LHvY5bjE7KnTv/L1v65s2fx5gsJ/cZmzTDOfTRatmyuKWTJRbhnb4cPNhRo7I10G4Hy5cugWQtztZ8oYVPMmzdoY9kOY0aNRMOGDRL0QIqQTRAuOVkICAEhIASEgBAQAp+FgAjZz4I56W9CrpYUs9rDrnu8N6O4RFqUW1tZYkFYOEJDglGwQEE+X7HIHjm4D+nSpeO/UcIcEnfjxrqrFtn9e3cjXdq0fHzjps2cFGnLpvX8b0XIUobgAgUKfHIhS9bRs+fOIX36/1vh3r4FWRad+vZBzx7v2/2xFtnt23ewlTdzpkxI9f8EVWTFpvaStTB16jSo16ARBgzoB6u2bdT2keCvUb0qqlWtmiJjZMkN3ax5C/Tv56xmfiY48fXDZG8fLAxfjMw6iaEouVK1KlUQNHOGppAly3zDxmbw9fJURamSKZkyLxcuVBCNmjSFY18HWFm2VfuJBDxljyYhK67FST8nyR2EgBAQAkJACAgBIZCUBETIJiXdz3htSuY0M2gWQuYE8ydILl+5At8p/hyLmivXt5wAqq9jP/5cDMWvLlq8BCtWrkLY/HnsnklC1qGPE1wG9kfnjh1AVixL6w4Y2L8fJ8whQdfKoi1s2rXjTL8kPOz7OnHynAH9nI0WspM8vXDp4iW28pJIfvT4caw4x/iQKW6+YaHzYn1CxdPLB3v27MPa1SvUn36skHUe4IJXL18hcIa/ei1KLNS0eUuMHeOO5s3MMCNgJlatXgOfyR7MMmL1WvhNm44VSxaxVTglxciOHOGKK1euwMt3Ks6dO49lixeqrsHxCdlXr16ze3jnzh1hZ9tN5UzuwgMGDcHm9es4xlvLqjxs+AicPn0GflO81azFNEbpk0xUZs+Zi8VLl8PXazJKlSqB3//4E30cneExYZxYZD/jvCS3EgJCQAgIASEgBIRAUhEQIZtUZD/zdSlrMX1bdcXKCDx78RwZ0qVH504dVItUYNAs7D9wEHODg5AmzbssxLruoCRkXV3dWGBERm7Aw0eP0KhhAwwZNFA9n7IWe3h648bNm0iFVKhbpxacHPuocYrGWGTpGsNcR+DS5SvIkD49zMya8Pc/tQoJ1j//+gsL5s2NderVa5RgygLzQ+aoGZo/RsiScCe3YhLYNWvUiHWP0e5jcevWbQQGTOMNgaBZs7FiVQQePnyYZN+RjS9G9vyFC/xdUyq6nzai78jSt2ap6H7nVbch+3bvZJdsskZS/+p+7oZ/198Z5MKsVXSvT7HAtWrW5A0P5Ruuhur4+uUruLqNQtTG9bE+L0Rt+dXCEhbmrWDX3VazDTTWPD29sGXbdk4o9ssvNXjTRkn+RH+bERiEVRERvOlSqFAhTlpm0drcqKzFJJT37TvAKB5HR7OXQvp06VChQnn4T/XVQiTHhYAQEAJCQAgIASEgBJKYgAjZJAacXC5PQnbYsBHYuX1Lcqmy1FMICAEhIASEgBAQAkJACAiBFEpAhGwK7fi4zSYhO3TocOzasVWIJBEBcne9cuVqvFc3a2qKX6pXT6K7a1+WXL3HT5hk8ET6fu93+b7TvpicIQSEgBAQAkJACAgBISAEkpCACNkkhJucLi1CNjn1ltRVCAgBISAEhIAQEAJCQAikbAIiZFN2/0vrhYAQEAJCQAgIASEgBISAEBACyY6ACNlk12VSYSEgBISAEBACQkAICAEhIASEQMomIEI2Zfe/tF4ICAEhIASEgBAQAkJACAgBIZDsCIiQTXZdJhUWAkJACAgBISAEhIAQEAJCQAikbAIiZFN2/0vrhYAQEAJCQAgIASEgBISAEBACyY6ACNlk12VSYSEgBISAEBACQkAICAEhIASEQMomIEI2Zfe/tF4ICAEhIASEgBAQAkJACAgBIZDsCIiQTXZdJhUWAkJACAgBISAEhIAQEAJCQAikbAIiZFN2/0vrhYAQEAJCQAgIASEgBISAEBACyY6ACNlk12VSYSEgBISAEBACQkAICAEhIASEQMomIEI2Zfe/tF4ICAEhIASEgBAQAkJACAgBIZDsCIiQTXZdJhUWAkJACAgBISAEhIAQEAJCQAikbAIiZFN2/0vrhYAQEAJCQAgIASEgBISAEBACyY6ACNlk12VSYSEgBISAEBACQkAICAEhIASEQMomIEI2Zfe/tF4ICAEhIASEgBAQAkJACAgBIZDsCIiQTXZdJhUWAkJACAgBISAEhIAQEAJCQAikbAIiZFN2/0vrhYAQEAJCQAgIASEgBISAEBACyY6ACNlk12VSYSEgBISAEBACQkAICAEhIASEQMomIEI2Zfe/tF4ICAEhIASEgBAQAkJACAgBIZDsCIiQTXZdJhUWAkJACAgBISAEhIAQEAJCQAikbAIiZFN2/0vrhYAQEAJCQAgIASEgBISAEBACyY6ACNlk12VSYSEgBISAEBACQkAICAEhIASEQMomIEI2Zfe/tF4ICAEhIASEgBAQAkJACAgBIZDsCIiQTXZdJhUWAkJACAgBISAEhIAQEAJCQAikbAIiZFN2/0vrhYAQEAJCQAgIASEgBISAEBACyY6ACNlk12VSYSEgBISAEBACQkAICAEhIASEQMomIEI2Zff/J2t93fqN4D7KDQ0bNoh1zX/PnEVbK2vs3L4FEz08sWlTVKzjP/1UCkvCw/hvAwcNxd59+7BpwzrkyJ6d/2ZlbYOePexg2qQxH9+ydesHdXYdOhg27a2xaPESTPL0gomJCVKlSoU8efPAtHFjOPaxR/r06aHUhY5TyZQxI4qXKI4Bzk6oUKG8ejzuDaguu3a8u69DHyfs3b//gzosCpuPn38ujaXLlmP8RI8Pju/fuwsmqVLB0roDLNtYwLZbFz4nJiYGnbraolLFihjsMsCo/nAbNRpnz50H3XPwMFdcv34DYaEh6m9nz5mLiDXr8ODBfaRLlx65c+XCsCGDULFiBXyOflL6IW5jGjdqBF9vz0T3E12X2vHg4cMPeK1YtgTFixX9LP2k1Q/xdebpf8/Asl177Nm5HdmyZY11GrFbtnwlVi5fwn37OZ4XqgDVo3y5crDv1RNly5bhOmn1o+7zRM9UjhzZUbVKFQxyGcBj7tGjx6hdrwGPU3o2qMT924sXL+DtOxVRUVvw9NkzlCxZAoMHDkS5cu/qkFIKjeXudr243z+mxPfMZ86S5YsYa8a06ejR4/D188OpU6d5PLZq2QLOjn2ROnVqrFgVgTFjx2Pi+HFo2aIZX851hBsi128Eza2ZM2VS54S0adPg+/zfo1lTM9jZ2SJd2rTG3J7PMWvRCmb0runfDw0am6K1uTn6OfU1+veGTvz75D/o6+SMVSuWqe833fO1jivz3sNHj/j9ljFDBpQoWQL9HPuiUqWKn6SOyeEic+aGwG/ajA+qSn3WrWvnWH+n/uzUwQadO3aI9fchw4bj2PETuHfvHkYMH4a2Fq0/WdOfPn0G87aWmDR+HKpUrqT3uv0GDsJPpUryfKuvlKtYJd76rFu9EgUKFPhk9U3KCxma18IWLsLOXbsQHBSotwqGngdj36HGtG3Z8hUIXbAQN65fR758+dGzR3f82qoF/3TajACcP3+R1y2JKbQGDp41Ezm/+SbWZbSeea2xZMx67pscOTSrbmju3X/wIIYOHa6ugTUvFs8JtDavXKkir+U/dREh+6mJptDrde7WHU0aNUSXzp1iEdixaxdGjx7LQlYpnl4+uHzpMqZPmxrrXBKq+/fvR7duXdC7Zw8+FlfI0mJ5lNtwvZRp4b1o8VKsiViBN2/esDAdMtQVtWvXYpGoLLy3Rm3khXb0kyeYGxKKJUuXYfuWTbh46TKLbuW4vpuQkC1UuBCGDnYx2NPbtm2Hq9soHNy3O9Z5x44dh31fJywKC0XRokUxK3gO1q5bj2VLFiJDhgxGjZ7J3j44d/Y8ZgZOx7gJk3Djxg3MmObHvz1y9BhcBg3BsqWLMH/BQlSpUgl3797DjICZ2LxhHWx79EryftLtB30NSmw/pUuXjhetrsOG8GL1v+onQ/1gqCNfvnyJqjVqYdHCBSj9U6lYp5Kou379Ony83r84k/p5iVi5DNeuX8eqiNUIDV2A0Hlz8XPpn1jIKs+TvvbEfZ6uXbuGocPdkCd3bq6/MUKWxMnho8f4/EIFC/D9ZgXPxro1q5AzZ06jnofkeNLbt29ZjCjlwMFD8PTyxqrlSxPcHEPPPC16f6ld7z8fa1qNunrtKlq3aQfbrl3QuVMH3Lp9Gy6DhqJevToY0M+ZheyMgEAULVKEF740d1ta2eDa9WuxhCzNCXVq18Jff5/EJI/JKFKkSIIWoe3ad+CFVg+77jC3sERr81/VTUetNhhzfMIkD8TEvIn3HaZ1XHfeIwbh4YsRMi8Uq1ctR548efRWIe5YM6aeCT3nc9xDqRMJ2Y2bNmPZkkWa1Tz5zz/IlSsXv+/1FVpftG9v/UmFLN1n8+YozJw1G0sXL0SaNGk+uDXNle07dEb4wvn44fvv422HvjlUs9Ff0AmG5jXaxLe26Qi77rbxvsfjex4S+g6NDwltFI8YNRoeE8ehdq1aOHTkCK8ZJ3tOQt3atT+JkKW6Vq9Zh9eVcYUs1UvrmTc0lhKy7o6Pgdbc+6mEbNfuPdDRpr0I2S/o+fziqkIvknmhC7B6zVoWcdmyZ8MQF7JslOW67t6zF94+U9DGwhz79x/ElWvXUK7szxg3xp13vFu3sULTpqaxdgg3bNzE1sUtm9YjY8aMBts82n0s0qVPjxGuQ3Hj+g08e/EchQsVwuIlS7Fh02aEzp2t/t7Qwjxb1qwg8btp/Vq2on6skFVuRiI1bOFirF294gMhS+fQQ9yshTki16zC8xcvk1zI0j29vH1x9PhxjHIbgS7dumN2UCBbhI0tgUGzcP78BUz2mMg70zdv3mBLBRUS0PQ3WtiQKCIhW7tmTRw9dpytvuMnTEzyftISQPqOJ6SffvzxxyQXssb0k6F+0OrL5i3N0b+fE0/qZ86eRbZs2VgAugweisKFC8Gxj8N/8rw49x+I1KnTYIrP5AQLWaowLTI3bY7C0sXhmkK2SJHCqFOvIdxHj1KtbHSNg4cOo0L5cvz8J7aQ5btGjRrYt28/eyRkyZIZO3fu5vuRWKFCgnyihwfu3L6H169fo0zZ0nBzdUX27NlAc+DYcROwNWoTMmV6PweSyGnVsjlfgwTFVL9p2Lt3P169foUff/weQwa54KdS7zYp6HjN2vV4DvLzD8DRo0fx6PFjhIfNZ6vMgoXhCAwMwrPnz9mqTYWe2XFj3Y1qvtYzb27R9j8fa1oNCZw5C2vXRSJybYQq8MlacefuHV5QkpDds2cfjh8/jvCwUBw4dBi/nfgNq1av+UDIKptbJGKsbTph+dLFKFG8mFYV+LhdT3s0NWsCK8u27ClD78s2rd9b6/YdOIBp0wNw584dmKROjVYtmqOPfW/2AlLKX3/9DZtOXTBx3Fi0bNk81n1JmLRuawn/Kb4oU+bnD+qkdVzfBl79RqY83po3M9Mca7Q2mDN3HrN++xbIlDkjnJ36otYvv6h1mb8gDAsXL0Eak9Ro1KgBW6QqlC/LgoMKvVdevHjO3hc07u/fv49q1avBz9ebj5N1Z7KPj+ox06a1uboxvXXbNixbthLpMqTHyZMn0c/JCRs2bsSFi5d4jZAr17ea/WSMkO3UtRuuXr2Ghw8fYUB/5w8ssspN4hOy5y9cgKenN6+TUpuYoE6d2nB27APaROVnOjoaY8dP5A0TKlRv16FDUKpkCbX+ve37ombNGujaJbaVWDmBNrF//+NPTPefEm+bDQnZXXv2YMaMmSCrHXkhdO7cERbmv/K1nj9/jmq/1MaEcWOwfv1G3L13FxkzZcLkiROQ97u8fM6lS5cw2csXp8+ewZuYN6hUsQKGuw5VvQUeP34MH18/HDl2jL3JihQtguFDB6sbJlP8/HH37l32+rp44SKuXb+Bjh3ao1NHG76+MfMabewPcR0B2kzNkjlzgp4HY96hWm3o3qMXbySMHTNavff27Tvw/Q8/8JxBFtlz5y4gZ85v1Pm9p50t2lu3U89XLLovX71EpgwZ0d/ZEfXr1+Pjf/zxJxyd++P+gwe8MUt7l1kyZ+V3gVK0nnk6L76xZMy6W0sbaM29JGRdh49EH/teCF+0BA8ePEDdOrXhPnqkOu8Zeuap/o3NmuP27dvIkiUL0qV75yFDG5LFihbVfN7pBK02iEXWKIxf/kkrIyIQGBSMsJC5PFHt2LETbqPdsWHdGmTNmhU0GMmaOHzYELSzssSTp0/RoqU5Rrq5olHDhlgYvgjzF4Zjw9rV6uCklzpNzIMHDdQEEDJvPg4fOYKA6f5wdB6Ac+fOYf261fCZ4ofHjx7DfbSbeg1DQrZ8uTLYt+8Av0CpnokVsqHzF2DlqtUs7OJakOgFMD0gADt37cHqlctw/sLFzyJk6SXTrn1H3Lp9C5Zt22LQwP4qG+cBLjhy5OgHvPN9lxfkNkslfNFi0It2hOswEPebt26x6zAVenFbtrfBTyVL4uWLlzBraqq+3Oj45+injxGyCekn2uFOaousshiIr5+0+kHrgenr1A+VK1dC186dULdBYzRu2ABj3EehfcfO6NShQyxh9zmfF+q72XPnYevmDQkWsmRlGOAymMU5LXq1LLIkBGhHnhYxRQoX1ouM+vl1TMwHx5o3awq34cO0MMO6QyfewOndqwfqNWiMCePG8qJzzNgJ2BC5mn9Pixkz0yawbmfFL0x6sRcrWgSmpk3w6tVrmDZrDifHvqAFORWygNo79MXmjZG8OBkxcjQeR0dj8qQJ7FVBC+2w8EXYtCFSdWs1bd4SWTJlZuseCS3aPKSiWGUj1qwFPQMfY5HVeua/hLGm1VE079ECx9vzw7AM+i0JWdqMoAVlntx5eLOje/eusHdwjFfI0u9o/Dg7O3I4hzFlgMsQNDNrwn1P3EjIT9ZnmQAAIABJREFU0vuRyoWLF2Fl3QGBM6axyyhZjbt0teOFu7J4p/P+OXUaDn0dMXzYUDRp3OiD25L4po278AWhsQSwcqKh43HnPRKmtes1ZAtvUzNTvoShsUahL7ThHTpvDlspSZj36++CdREred1Adbfp2Jkt+PTup7pMmOjBG2uK2y79bdasObxhQxvhefPm4RAZGtNUH1q02vfqwe9vek+1tWqPucFBvFlLm9QDXYYgauN6BAXPxqFDh9mdnjyF2lpYqC6dhvrKGCGr/J6e7QYN6idIyL589QoWbax4E8Khdy8Wig6OTqhRvRr/mwrNEecunMfkSRP5Gd4ctQWnTp+GU98+atWp7V272bHlmBjFLXSfNpbWGDSgnyp84p4Tn5A9d/482ll3QMAMf1SrWhVXrl5Fh45d4OvjxWOTNuQqVa3BbRg/xp3HWR9HZ3ZJprWCcm8L81bobtsNZDUcPGw4t0XZkBjuNhIPHjzEFB8v3lT08pmCf/45hTnBM7maJPIWhIVj/ry5PFZ+//1PdLHtjm1bNqmWR2PmNZo/KXwrvnVmfM+DMfOaVhtq1qmPfk6OsG5nqXfIURvJBXqKrxdq1qjBBiHa7KU2ksvu2XPnuA9XLlvMHnYrI1bDc7I3du/cps79irFkx7YovRZZurHWnBDfWDJmPaelDbTmXtIOjk790KN7dzjY9+J5jwxfE8a687Ol9cwrYMnN36V/v4+yyGq1QYSsMW+3ZHAOiU6awGigKcWirRV62NmhRfOmLGRpMB7av1ddRNn16M07jfSCop2rRqbN+IGl3dmLly7i19aWWBOxHAULFNQksGPnLkyZ6s+7301btOLFovdkD96xLVe2TKxdSUMLczq3ZKkSGD/BA2sjVvBCVzdGdtv27Ujz/0WgUql9e3byTqmugKIF6d9/nwTForRvZ8mWE0XI0s4fHaeYvGZNTeHk2IdjqpTjcWOqyNVZsZAl1rVYqbPvVD9eUNBiRt/OvCHg9JJ68/YtT5S00H6Ld/+tFIpLWbVqNZavWInrN24gX758GDJ4IOrVqYPP0U9KbGVcjv7+U/hlkNh+onbSgo4sXbRTrJSy5cogZHYw//Nz9JNWPxjqQ1oU0IaGeauW8PXzx80bt1hYkdgKmDGNXXuV8jmeF+Ve5LLnPnYcDuzdrcbIxtePcZ8n2hyjxR55B9DzryVkX716hS62dtiyeQNbo0nE37x5k6tCC+TatWpqzjtaJ5CQ7dKpE8+BtLAjVz8aMZ262LIAokJzxNs3b9Cjuy1Kl/7pA1dA/+kBOHT4sBqHPmz4CF4YUjtpDJDlI3hmICpXfhenSIv6J0+exop/pnmsaNEiqudE3Hobs+Az1FZDz/yXMNa0+qlnbwf88MMPGD1yhN5TSciSxdu2a2eMch+DV69jsHxJOLPXjZGNG25AlnMSo/FZxeLejBb0JMjofxS/TZtmyqYDiRfybJk9631MH1nmyBMpIXG49O4hN7sWzZrpXUAbOq4rZOl5CwgMQuT6DfyupA1rKobGmm2Pnix8FEFG59M6oUMHG1i1bYMFYQuxcXMUFs6fp6KhBahNu3aqkKVNclr8khcTecfELTQvZ0ifXn2OWpq3QXfbrrwRRELW22cqyOU9ePZc/HPqFIcVDBoyFOXKlv0gNEnfYEhqIUsbVb3s++DAvt1qv5J7p/+MQK43FRI3ZIlzcemPypUqcYy2vkLeUZevXI53g4bybYwbNwkRK5fqDS2KT8iSN9Dhw0cwd/Ys9bbkovr61WuMHuWmCtl5c4LV+Gkav+QtQCFdtFlu38eR26i4PtP76M2bt+x5QnMYhb8EBU5nyzsViicm6z956JEbO4m833//Q41xpXFboXI1XtMoORGMmdco9KmNZTuOIdXnORHf86A1r5G41moD1ZfmcfJm0FeojcePn1A5E5eKVaqreR+obo8fR6tz/a1bt3gjhzxLfvzhB76kMUJWa06g6+gbS8as57S0gdbcS9qhT19n1g5k+adC80i9OnXVOcHQM69wTYyQ1WqDCFmtN2wyOU4vbHLxyZj5/YT6/Okz9LCzRedOHVnIxg3YpgFMC0/FZch9zDhEP4mG92RPtqSeOXMWgTP8jSJAwretlQ2CAmYgePYcFCteDAUL/Mg7TWwNqVNHvY7WwpyEtRI7QUlMSIQqyZ60YmQ9JnsjM7movH2LHDlywKK1Oey6d+OFp65FlhYn5HI3crgr775TiWux1dfw+JI9KYsp5TfxxcjS8VOn/4Vt9x5o1qwp/vzzLyxcME9vHI1R4A2cRC5glSqUR/STpxg7fgLvGpLoTep+MsYim5h+oiYbY5HVl5TrS+mn5StXYeuWbahQsTy7rkVt3cbJ0sgVMm4dk/J5iRsDq3hmbIpcm2CLLFkuVkVEIHhOCJYvWYT06dOhVt0GsTZrSHBR3y1ZFMYvf3LrJ4sMuRjRQinmzRte1IwZNfKDxHHxDXWyzg0e8t46SxtT5BpKhYRs7x52fK0q1X7he5GF16ZjFzV+ncQIuVvu3LWb45Npc48EkZIkgyzNzVu1xvKli/Dtt9+iiWkzzJ0dzAmpbt68hSZNm3NcfqGC8W/4UT1o06KDTXu9zTBmwWfMfKDvmT905Oh/Pta06k75EWhPSjc2XPc3ipClpCskvEybNGFxRAtVQ0KWko0NchmI1r+20qqC5nH3MePx7PkzeE6aoHmu1glk+ext3werVizVGwse33F6dp7/X2CbmKRCmdI/w8VlACe4U4qhsdbiVwtefJJoVYruIpE2bU6fOh0rfwVtNjWsX/+9kN21CyNHuWP3jm16m7lsxUp2XaZNHrLwnT79L4YNHcxxqCRkZ8wIZCslCVIKq5g0YTwntvv5p9IfJGvSd4P4kj35+/mift26sX7yMRZZ2swbNtxNdcGlC76JieH2bN+yma9PwoOs2xQ2RRvmZX4uzRZFJZxAqcSzZ5T4yYrndtrE1Vdo7BcuXDCWNVc5Lz4hS7kx1kWuR45v3ifyefXyJcqXK89hIYpFVkl+SNcjC/iJ478hMGAa1kVuAG2mb4vaqLdOd+7cRcMmZixYU6d55z1CJfpxNIICpvPmu75ESCQM54fMUUPajJ3XaM1AGygkvHVzByj31fc8aL1Dnz19ptkGep76OPSO5SqsC0SrjbTZNSNwJg4fOcr1JqF78uQ/vOGhJOQyRsjSPbXmBH1jyZh1t5Y20Jp7jdEOhp55hWdihKxWG0TIar1xkslx8qGvWrWyGvcVt9rGDEaK9+jSzRYb16+DpVV7jBkz6oMXQ3w46AGu9kstds+jxV6xYkURGbmBd7DnzZkVa+fWmIU5ZaMMCw9ngUcZB40VsglJTkM7qrSzGbFiOS+qjRWyiUn2RBbUjp27wMzMFN26dEaHzl1Rv15ddYfcGNdiQ0OSXlB58uTiXXclRpZe7uT+Qtn4iGNS95MxQjYx/UTtN0bIJmU/JXZaoJgS2kH/9tuccOrbF1Fbt/LiaNPmzex2p1s+5/NCrprf5MzBi0utfozveaF40NEj3WBq2hhVq9fEFF9vTsBDhRauNBYp8QUJxUZNmsKxr4MqPJW+VTKgG+NaTG5yD3UyWJPHhRLTb4yQ1WVN1oFJkyfjTczbWEmCKFyiUKGC7CJIC0gl0zotGElMBc8MQJUqlflS9IyTG2rBggVUiw7Vg1wt48uOauyCT9+403rmyRX3vx5rWs/L3HmhHH9FCemUeFNypwsJCWWXe3LZI4ssCVla0KVNm1a1GsUnZH/77XdQMhSKRzPGq0irjmT9PHr0GObMDlJPpY0M2jRV4g61rqF7nLJ4Pn3yJN5YaH3HteY9ur6hscYW2SpVY3lu0SKxS5dOPDbJVXH3nj2xLH3kqUXvYMW1mMQoeUyRZS5uIUufXS/7WFa5Fq1ao3v3bp9UyBqb7OljhOyJE7+hp30f3ujSjX2Or29pPC5aspQT5ZH7aFwhRl9aoNj4FcsX67XcU04RK5sOWBAa8sFmWHxClqzZNBYp4aO+oiVkycPEoa8T9u99b3Wme1EsLeU2IXfRajVqYU5wEMqXL6f3Hloij35k7LxG68cOnbqgg40NzH9tqfd+cZ8HrXeoMW0gd2vyZNDdnFq/YRN/8YE2HbXaSFbuyA0bWYCTF9LNGzfRpFmLjxKy1GitOSHuWDJm3a2lDbTm3gOHDhk0gmk9859CyGq1QYRsQt48X/C5a9ZGYmbQLITMCebF1uUrV+A7xZ+TL9EDZoyQpeZRkgrKHnrixB+IXLvKqIlcwUI75U+fP8dUHy9eOFBszL3797Bv9w7VPYvONWZhThNxC3MLftGPHDE8SYQsTXQdu3RDyeIlOIb3cwhZWgyR5YcSlpBVmKyznbvaqnEmiR1iNClFRq7HrJmBCAmdz8me8ufLj67dumPB/BC2fCV1P2kJIK3jcfshbj8pYicpsxYndT/du3+fPQIoAcfGdWv4+aTkIQV//BGzZgYkWMgm9nmhHXja2OGXWth8tvAktJ9od3pt5HpMnOSJFcsW84KIXkDkejl+LMVppQJZ4k+dOsUhCFTI42Lx0uXw9ZqMUqVKcPITWlx4TBhntEXW0DOjJWRJBPd26AO34a6cEZcKLV7IMqskUKO/UWIVz8k+nACKBKmuhY9cjaOjn8LHy4NjySjWdX5YODZErjFayNICZdz4SVgTsRKZM2fCndt38F2+74yaDrSeeYrj/a/HmlZDyBpPcVf0yZ2ePe041GXQkGH8uQZKZKRrkVWuReNNn0WWPvNFiYRGjh6D0qVL8abMpygUD2fdviNmBs7gMB7a9KC5m7Is0+fflKIVI6ucR200b2MJn8menIgsbtF3PLFCVomRJdFEm2jkmug63A1rV6/idQK5Ufbu44iIFUuRP39+TnY2esw4TmhljJClLLDjJ03i5Gjkbk2bLBMnecC+d092G/5UFtlPJWTJA4Y+tdKxw7sERVRoI4o221qbt2RvNfo3eaqQW6VyHgmOn0uXVmN6af4eNXrMB5uQyjUd+jpzMiXaTNZXyMp86NARBM2M/Vmh+IQsJWqyat8RAdP8OaSBvEp8p/pzqBS5AmsJWXKhN7ewYrd7qhPNg0OHjWARrnxqhtrz4NEjeHlM5HmNP424KUpNjKQl8qidCZnXaOOpv8sgrF654oPP0tG14j4PxrxDtdpA/ebk1J/dsRs3asjJuwa4DFI9grTaSMlQb9y4yQm7aCOa+oDm/8XhYeoXCRQvJAp7qlSpAu7du8/u2/oSqGrNCcQh7ljSWs9paQOtuVdLO2g988p4py+CNGnSmBPKUjvJ+0r5zKZyDsU0X7p8GWGh70Mb6JhWG0TIfoo33BdwDXqIKL5lxcoIzhicIV16fsEqLnZag1FpArkCUyY0+uSB8q1TY5tHLgrHjh/nT9nQhNjNricePXykfhuRFnwbN0Xxbh8V2u2kWAolHod+TzGyyguT4lDoEycUa6v7Hdm4u6SUQc1/qm+CF95UB4oZITFLmYOz58jByZ707cIupLiP0j9pxl6SiwUlx6D+oP8p19q3eydbabra2vHOq252w+kBgdi5cxfCwxaoMQjGMo97HrGlXcL1GzZypjxKPvNNjuyw695djQNJ6n7S/Z6vbv0yZcrEmxoJFUhx+4ksX7SgU76nqHuPgf2decGkFSP7X/cT1ZnaULVqFXanpPik2nUboE0bC07IRuVzPC/Kd5cpxpzc4yjxhbIDr9WPcWPK6RqU2ZIWRkooASUh8fDwwonff+MsqWVKl8bQoYPU5E60ozwjMIhdksmyUahQIRaJFBLwKbIWawlZ4kyLdRLUr1+/SypFn2xRNgCVsUXPVYtWFnjyJBpRm9bHqhstNqdM9eMERLQgLFigAIYOGRQr3kvLIkttp4zV5MFCG1w//vA9lixaaNQ0YMwz/1+PNWMaQgKQMrr//scfnF3avFUrzl+gfEdWscgq19InZJU5IXee3GjZrBkcHHonKH5Vq547d+/muFRanJrAhIUMiTRdK5yhrMVxr08uuMrCV99nWuIeT6yQpeeN3OjJq4Cex+w5smJgv36xvkNLi/c16yLxTfbsqFe3Lk789hvHqytxxoYsstQng4a4ckbc7Dmyo5mZKaKjn/DaZKTbcKRNl/aTuBYbErLkZUWCnQolQkufLh0yZMzAG2oUMqFbKHPw7LkhvHlEn0ZREiqSyyZtXF24cJHdycuXL49hg1zUzSUaq5M8J+Pe3ftIk8YEWbNlw6AB/VWX2rj9TDzI+4pCKigfR9xCYpkyrNOGgZnZu1AnKoayFpOwJFfwRw8fc7Z00yaNeP6meVNLyNK1KWGUl/cU/gLC65jXqFatCoYOGsSbdVQUcUzzGs1P+fN/h/7Ozuq3cbVEHl0jofMarT3TpksXbyI/fc+DoXeoVhuojhT/TGOGBBR9R7Z3TzveUKOi1UZa09HnelKZmLA47WtvjzkhoTxuZgb6q54glCuG1hwxMa+RK9e7z9OVLFFc73SjNSfEHUta6zktbUCVMDT3amkHrWdeSXhHnL18p/AzSV9pIE+suCEfjk79OUEcxRjrFkNtoPdf5oyJ/8KB7v1SvaU7JqA8e/EqAWfLqUJACBhLQNe12NjfyHlCQAgkXwLyzCffvvtSa05J2MgLQcna/aXWU+olBIRAyiQgFtmU2e/SaiEgBISAEBACSU6A3AvpG7DxlVL/a+8swKpM1jj+BxQ7V1117Y61u7u7Axuwu3NX1+4OQMUG7FaMtbvXXLu7UQQUuM877jn3IMj5gCNyDv+5z33uxW+++WZ+78x35j/vO/PlyP7dw1Z+eOX4gCAExLshB6Hpwm1l64tdqzZY7bHqu5/IIkISIAES+JkEKGR/Jn0+mwRIgARIgARIgASiCIHjJ05iytRp6vupEu7cvn3bIN8ijyLVZDVIgARIQBGgkGVHIAESIAESIAESIAESIAESIAESMCsCFLJmZS5WlgRIgARIgARIgARIgARIgARIgEKWfYAESIAESIAESIAESIAESIAESMCsCFDImpW5WFkSIAESIAESIAESIAESIAESIAEKWfYBEiABEiABEiABEiABEiABEiABsyJAIWtW5mJlSYAESIAESIAESIAESIAESIAEKGTZB0iABEiABEiABEiABEiABEiABMyKAIWsWZnLeGWXr1wF+e/rl69ga2uLtm1bo5OjQ5Abq9Wqg1YtW6C1XUvjBTIHCZAACZAACZAACZAACZAACUQxAhSyUcwgEamOj48PipUsg0njx6Fq1cqwsrJCYGCg+l/DdPXaNSRLlgzJkyWLyON4LwmQAAmQAAmQAAmQAAmQAAn8FAIUsj8Fu+kf2sGhI27fvoPXb94gaZIksLL+Kl6HDh6EKpUrqf/fqm07PHr0GO/evUef3j3pkTW9GVgiCZAACZAACZAACZAACZBAJBCgkI0EyJH1iBcvX6JSlerYu3tnqN5WEb0VKpSnkI0sw/A5JEACJEACJEACJEACJEACJiVAIWtSnD+3MArZn8ufTycBEiABEiABEiABEiABEogcAhSykcM5Up5CIRspmPkQEiABEiABEiABEiABEiCBn0yAQvYnG8CUj6eQNSVNlkUCJEACJEACJEACJEACJBBVCVDIRlXLhKNeFLLhgMZbSIAESIAESIAESIAESIAEzI4AhazZmez7FQ5N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kAAJRE0CFLJR0y7hqhWFbLiw8SYSIAESIAESIAESIAESIAEzI2BRQtbM2Ju8uqEJWafDy7HmzBb1TDm1OFaMWIgVw1b9d1u3FeB3ZE1uDhZIAiRAAiRAAiRAAiRAAiTwgwhQyP4gsOZWLIWsuVmM9SUBEiABEiABEiABEiCB6EuAQjb62j5Iyylk2RFIgARIgARIgARIgARIgATMhQCFrLlY6gfXk0L2BwNm8SRAAiRAAiRAAiRAAiRAAiYjQCFrMpTmXRCFrHnbj7UnARIgARIgARIgARIggehEwOyFbHQyFttKAiRAAiRAAiRAAiRAAiRAAiQAUMiyF5AACZAACZAACZAACZAACZAACZgVAQpZszIXK0sCJEACJEACJEACJEACJEACJEAhyz5AAiRAAiRAAiRAAiRAAiRAAiRgVgQoZM3KXKwsCZAACZAACZAACZAACZAACZAAhSz7AAmQAAmQAAmQAAmQAAmQAAmQgFkRsAgh26ptOzx79hzWNjb4Y/hQlCpRwqyMwMqSAAmQAAmQAAmQAAmQAAmQAAloJ2ARQlbX3EWLXXHw8BEsXbxQOwHmJAESIAESIAESIAESIAESIAESMCsCFiVkd+z0xGLXJVjj4WZWRmBlSYAESIAESIAESIAESIAESIAEtBOwKCG703MXFi5ajLWr3bUTYE4SIAESIAESIAESIAESIAESIAGzImBRQvb6jZto3bY95s2ehUKFCpiVIVhZEiABEiABEiABEiABEiABEiABbQQsSshKkz09d2PwsOGoXbMGRv81UhsF5iIBEiABEiABEiABEiABEiABEjAbAhYlZJ88foKGTZph/LgxKFe2DKysrMzGEKwoCZAACZAACZAACZAACZAACZCANgIWJWR37d6DefOdsHH9Gm2tZy4SIAESIAESIAESIAESIAESIAGzI2BRQpanFptd/2OFSYAESIAESIAESIAESIAESCDMBCxOyLouWYrV7qvCDII3kAAJkAAJkAAJkAAJkAAJkAAJmAcBixKyc+ctwNWr1zBn9gzzoM9akgAJkAAJkAAJkAAJkAAJkAAJhJmARQjZ5nat8fz5c8SNGw+TJ45Dzhw5wgyCN5AACZAACZAACZAACZAACZAACZgHAYsQsuaBmrUkARIgARIgARIgARIgARIgARIwBQEKWVNQZBkkQAIkQAIkQAIkQAIkQAIkQAKRRoBCNtJQ80EkQAIkQAIkQAIkQAIkQAIkQAKmIEAhawqKLIMESIAESIAESIAESIAESIAESCDSCFDIRhpqPogESIAESIAESIAESIAESIAESMAUBChkTUGRZZAACZAACZAACZAACZAACZAACUQaAQrZSEPNB5EACZAACZAACZAACZAACZAACZiCAIWsKSiyDBIgARIgARIgARIgARIgARIggUgjQCEbaaj5IBIgARIgARIgARIgARIgARIgAVMQoJA1BUWWQQIkQAIkQAIkQAIkQAIkQAIkEGkEKGQjDTUfRAIkQAIkQAIkQAIkQAIkQAIkYAoCFLKmoMgySIAESIAESIAESIAESIAESIAEIo0AhWykoeaDSIAESIAESIAESIAESIAESIAETEGAQtYUFFkGCZAACZAACZAACZAACZAACZBApBGgkI001HwQCZAACZAACZAACZAACZAACZCAKQhQyJqCIssgARIgARIgARIgARIgARIgARKINAIUspGGmg8iARIgARIgARIgARIgARIgARIwBQEKWVNQZBkkQAIkQAIkQAIkQAIkQAIkQAKRRoBCNtJQ80EkQAIkQAIkQAIkQAIkQAIkQAKmIBAlhKyNtbUp2sIySIAESIAESIAESIAESIAESIAELJyAf0AAKGQt3MhsHgmQAAmQAAmQAAmQAAmQAAlYEoEoJ2Rv376Ns2fP4O3bt5bEmW0hARIgARIgARIgARIgAc0EEidOjIIFCyFTpkya72FGEohOBKKckF27dg1FbHTqgWwrCZAACZAACZAACZBAiAREzDZu3IR0SIAEQiAQ5YTswoUuNBQJkAAJkAAJkAAJkAAJkAAABwdHciABEjAHIUuPLPspCZAACZAACZAACZAACQD0yLIXkMD3CUQ5jyz3yLK7kgAJkAAJkAAJkAAJRHcC3CMb3XsA22+MQJQQsn6f/Y3Vk9dJgARIgARIgARIgARIgARIgARIQE/ANqaNSWlYBQYGBoa1xC/+AQgICPNtYX0M85MACZAACZAACZAACZAACZAACZgxAWtrK8SwsTZ5C8IlZE1eCxZIAiRAAiRAAiRAAiRAAiRAAiRAAhoJUMhqBMVsJEACJEACJEACJEACJEACJEACUYMAhWzUsANr7RjApgAAAUFJREFUQQIkQAIkQAIkQAIkQAIkQAIkoJEAhaxGUMxGAiRAAiRAAiRAAiRAAiRAAiQQNQhQyEYNO7AWJEACJEACJEACJEACJEACJEACGglQyGoExWwkQAIkQAIkQAIkQAIkQAIkQAJRgwCFbNSwA2tBAiRAAiRAAiRAAiRAAiRAAiSgkQCFrEZQzEYCJEACJEACJEACJEACJEACJBA1CFDIRg07sBYkQAIkQAIkQAIkQAIkQAIkQAIaCVDIagTFbCRAAiRAAiRAAiRAAiRAAiRAAlGDAIVs1LADa0ECJEACJEACJEACJEACJEACJKCRAIWsRlDMRgIkQAIkQAIkQAIkQAIkQAIkEDUIUMhGDTuwFiRAAiRAAiRAAiRAAiRAAiRAAhoJUMhqBMVsJEACJEACJEACJEACJEACJEACUYPA/wDrTT1+YJvyaQAAAABJRU5ErkJggg==)

\#修改/opt/deepinwine/apps/Deepin-WeChat/run.sh，可以先备份一下
\#找到CallApp()，在env WINEDLLOVERRIDS这一行的末尾加上&
\#同时在fi后面加上
```sh
if [[ -z "$(ps -e | grep -o 'shadow.exe')" ]]; then
  env WINEPREFIX="$WINEPREFIX" WINEDEBUG=-msvcrt $WINE_CMD "c:\\shadow.exe" &
fi
```

## 终端美化
```sh
sudo pacman -S zsh
# 替换bash
zsh替换默认bash：
chsh -s `which zsh`
# 安装oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# 安装powerline字体
需要安装Powerline字体，不难，clone一下，直接安装就好了。
git clone https://github.com/powerline/fonts.git && cd fonts && ./install.sh
#切换主题
	## 1 spaceship主题
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
ZSH_THEME="spaceship"
ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"
	## 2 终极美化使用PPowerlevel10k，步骤倒是不多只是配置多，需要耐心仔细去调，具体可以看笔者另一篇文章，
	安装powerlevel10k#
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
p10k configure
    ZSH_THEME="powerlevel10k/powerlevel10k"
    source ~/.zshrc


#安装插件
	## 1 高亮插件 zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
	## 2 自动补全 zsh-autosuggestions**
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
	## 3 zsh补全插件
    [点击下载](http://mimosa-pudica.net/zsh-incremental.html)
    mkdir ~/.oh-my-zsh/custom/plugins/incr
    把下载的文件移动进去
    sudo vi ~/.zshrc 
    plugins=(git zsh-syntax-highlighting incr)
    source ~/.oh-my-zsh/plugins/incr/incr*.zsh #在~/.zshrc文件末尾加上

#启用插件
vim ~/.zshrc  在plugins后括号里添加安装的插件名字
plugins=( git zsh-autosuggestions zsh-syntax-highlighting incr)
source ~/.zshrc  # 最后刷新
```


### 常用别名
\#.bashrc加上
```sh
alias m='sudo mkdir -p' #新建文件夹
alias d='cd ~/Desktop && ls'
alias rrr='shutdown -r now'
alias sss='shutdown now'
```
### 脚本
1. 使用c代替常用的cd，同时执行完之后自动ls一次：
```sh
if [ $# -eq 0 ] ; then
  cd .. && ls
else
  cd $1 && ls
fi
```
2. 如果只是输入一个c，回到上层目录并ls，如果带目录参数，切换到对应目录并且ls。需要加上别名使用：
alias c='source ~/.cd.sh' #脚本文件名为.cd.sh，位于～下
3. 使用r代替rm，无需加上rf参数，使用回收站机制，也就是直接移动。
```sh
for i in $*; do
  mv $i /home/YOUR_USER_NAME/.Trash/`basename $i`_`date +%Y_%m_%d__%H_%M_%S`
done
```
4. 移动的文件名后面加上了时间，回收站位置为用户目录下的.Trash，同时加上别名：
```sh
alias r='sudo sh ~/.rm.sh' # 脚本名字为.rm.sh，用户目录下
alias trash='cd ~/.Trash && ls'
```


## 其他
### 挂载硬盘
```sh
sudo mount -t ntfs-3g /dev/sda1 /mnt
sudo fdisk -l
＃查看ＵＵＩＤ
sudo blkid
sudo vim /etc/fstab
UUID=DA18EBFA09C1B27D /mnt/Windows ntfs-3g rw,umask=0000,defaults 0 0
```
### 常用命令
```
安装 pacman -S package_name |yay -S package_name 
删除 pacman -R package_name 
查询net pacman -Q |grep net
```

### 解决Windows和Linux双系统时间不一致问题
```sudo timedatectl set-local-rtc 1```
### SSR
```sh
yay -S electron-ssr
http://127.0.0.1:12333
socks5://127.0.0.1:1080
## 谷歌代理
google-chrome-stable --proxy-server=socks5://127.0.0.1:1080
## 终端代理
yay -S proxychains-ng
vim /etc/proxychains.conf
//最后加入
socket5 127.0.0.1 1080
alias gfw='proxychains4'
gfw curl ip.gs
```



## manjaro美化
### 主题文件
```sh
/usr/share/themes
[Flat-Remix-GTK](https://github.com/daniruiz/Flat-Remix-GTK)
Ant-Dracula
```
### 图标文件
```sh
/usr/share/icons
Zafiro icons
```
### logo 修改
```sh
sudo vim /etc/lsb-release
# 改第一行跟最后一行，比如改成ArchLinux和Arch Linux
```


## 中文环境破坏

```sh
1、sudo vim /etc/locale.gen
#将下面两行前面的#号去掉， 存盘退出
en_US.UTF-8
zh_CN.UTF-8
2、sudo locale-gen
3、在系统设置那里就可用选中文环境了。
```

## 游戏
1. 0ad 跨平台的“帝国时代”
2. wesnoth 回合制策略
3. 2048-qt 经典的2048游戏
4. zaz 经典的泡泡射击游戏；
5. gnome-mines 扫雷

## 个性化

应用程序 ➡ 位置 ➡ 更换个人文件位置 ➡ 改英文名 //方便使用
desktop / document / download / movie / music / picture

#### 外观
1. 字体 ➡ *思源黑体*
   **常规** ➡13 **小字** ➡11 **工具栏和菜单** ➡13 **窗口标题** ➡14
   **等宽字** *Source Code Pro Medium* ➡13
2. 图标主题 ➡ `epapirus` `numix circle`
3. 标题栏样式： `Breezemite` `BreezemiteForman`
4. 应用程序风格 ➡ Gnome风格 ➡ 更换图标与字体 *思源黑体 13*
### HotKey
1. 系统设置 ➡ 快捷键 ➡ 自定义快捷键 ➡ 编辑
2. 新建 ➡ 全局快捷键 ➡ 命令/url ➡ 编辑名字 ➡ 右边窗口 ➡ 触发器 ➡ 设置快捷键 ➡ 动作 *软件名称*
3. 自定义快捷键 Eg: **dolphin** `Meta+e` ...
- 添加KWin快捷键
  - `Meta Shift PgUp` 窗口铺至左上方
  - `Meta Shift PgDown` 窗口铺至右上方
  - `Meta Shift Left` 窗口铺至左下方
  - `Meta Shift Rigth` 窗口铺至右下方
  - `Meta F1` 更改窗口大小
  - `Meta F2` 移动窗口
### 全局菜单
1. 右键桌面 - 添加部件 - 全局菜单
2. 安装一堆包
   ```bash
   yay -S appmenu-gtk-module gmenu-dbusmenu-proxy-git libdbusmenu-glib libdbusmenu-gtk2 libdbusmenu-gtk
   ```
3. 适配 Firefox 和 LibreOffice
   `.xprofile` 中加入下面这一行：
```bash
export SAL_USE_VCLPLUGIN=gtk
```






