
pacman -Sy make gcc
pacman -Sy base-devel #因为没安装 fakeroot、binutils 等打包基本工具，所以pacman -S base-devel 装一下。
pacman -Sy arandr # 图形化设置屏幕输入的软件

    ​ manjaro配置攻略

    ​ 1 源
一、更新源的配置：
1）、自动方法:
在 终端 执行下面的命令从官方的源列表中对中国源进行测速和设置
sudo pacman-mirrors -c China
2）、手动方法 
自动方法(上面的方法1，自动测速)的源ping虽然低但是更新时不是很稳定，下载速度忽高忽低，所以也可以用下面的方法手动指定想要使用的源。
创建一个名为 /etc/pacman.d/mirrors/Custom 的文件，并在里面加入：
## Pacman Mirrorlist
##

[Custom]
Server = http://mirrors.tuna.tsinghua.edu.cn/manjaro/stable/$repo/$arch
Server = https://mirrors.ustc.edu.cn/manjaro/stable/$repo/$arch
# 目前中国有四个源我去除了两个实际速度不加的，查看官方的源列表 http://repo.manjaro.org/
# 可以加入其它的软件源，格式与这个类似。
                ​ 手动在该文件添加源地址
PS：可以使用 Arch 提供的镜像生成器[1]找到最新的镜像：Pacman Mirrorlist Generator
##
## Arch Linux repository mirrorlist
## Generated on 2020-03-06
##
## China
#Server = http://mirrors.163.com/archlinux/$repo/os/$arch
#Server = http://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch
#Server = http://mirror.lzu.edu.cn/archlinux/$repo/os/$arch
#Server = http://mirrors.neusoft.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.neusoft.edu.cn/archlinux/$repo/os/$arch
#Server = http://mirror.redrock.team/archlinux/$repo/os/$arch
#Server = https://mirror.redrock.team/archlinux/$repo/os/$arch
#Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux/$repo/os/$arch
#Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
#Server = http://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
#Server = https://mirrors.xjtu.edu.cn/archlinux/$repo/os/$arch
#Server = http://mirrors.zju.edu.cn/archlinux/$repo/os/$arch
生成如上源后，手动粘贴至 /etc/pacman.d/mirrorlist 。
保存后接着编辑 /etc/pacman-mirrors.conf ，使 pacman-mirrors 只对这个文件列出的镜像站进行排行：
OnlyCountry = Custom
如果需要关闭测速则进一步修改
Method=random
保存后终端执行
sudo pacman-mirrors -g
            ​ 二、额外增加Arch Linux CN源
Manjaro是基于Arch的，而AUR是Arch社区用户维护的软件包（也是arch可用软件量巨大的所在），我们等下要安装的搜狗拼音、chrome等不少软件都在这里维护。不过网慢啊～！所以我们可以为Manjaro增加这个中文社区的源来方便我们安装一下软件。ArchLinuxCN 是 Arch 中文组维护的一个软件合集，包含了中文用户常用的 WPS Office、搜狗拼音、Google Chrome 等软件。不过，Arch 本身和它的常见衍生版（如：Manjaro）默认都不包含这个源，因此我们需要手动来配置使用这个源。
在 /etc/pacman.conf 文件末尾添加行：
[archlinuxcn]
SigLevel = Optional TrustedOnly
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
然后安装 archlinuxcn-keyring 包以导入 GPG key，否则的话key验证失败会无法安装的。
            ​ 【可选】AUR 源
AUR 源可以使用清华源，文档[3]见这：清华大学开源软件镜像站
yay 用户执行以下命令修改 aururl :
yay --aururl "https://aur.tuna.tsinghua.edu.cn" --save
修改的配置文件位于 ~/.config/yay/config.json ，还可通过以下命令查看修改过的配置：
yay -P -g
yay 是一个包管理软件，与 pacman 的不同之处在于 yay 用于在终端安装 AUR 的包。具体，阔以查看下面的 包管理 。

排列中国镜像的速度，选择一个。
sudo pacman-mirrors -i -c China -m rank
接着更新并导入GPG key：
sudo pacman -S archlinuxcn-keyring && sudo pacman -Syy
    ​ 2 输入法
sudo pacman -S fcitx-im fcitx-configtool
# 输入法看个人，这里装的是谷歌拼音
sudo pacman -S fcitx-googlepinyin
#搜狗
#sudo pacman -S fcitx-sogoupinyin
#rime
#sudo pacman -S fctix-rime
#更多输入法使用

    ​ Manjaro安装fcitx5-rime

thepoy关注
字数 289阅读 5,247
时代在进步，技术在革新，fcitx已经是过去式了，虽然作者更新频率不高，但fcitx5已悄然走向了未来。
fcitx5有了，fcitx5-rime自然也就有了。
首先，先看一下安装好fcitx5-rime后的相关包：
fcitx5 0.0.0.20201030-1
fcitx5-configtool 0.0.0.20201101-1
fcitx5-gtk 0.0.0.20200913-1
fcitx5-material-color 0.0.0.20200729-1   # fcitx5主题
fcitx5-qt 0.0.0.20201029-1
fcitx5-rime 0.0.0.20200913-1
只需要上面这些包，就能使用了，命令如下：
sudo pacman -S fcitx5-rime fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-material-color
安装成功后，还需要配置一下系统输入法选择，为fcitx5添加自启动，修改fcitx5皮肤。
                ​ 配置fcitx5为默认输入法
vim ~/.xprofile
添加下面的内容：
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx
                ​ 添加自启动
方法有几种，选择一个就可以。
比如，直接在系统设置里找到“开机和关机”——“自动启动”，左下角添加程序，找到“fcitx5”即可。
                ​ 修改皮肤
vim ~/.config/fcitx5/conf/classicui.conf
添加内容：
# 垂直候选列表
Vertical Candidate List=False

# 按屏幕 DPI 使用
PerScreenDPI=True

# Font (设置成你喜欢的字体)
Font="思源黑体 CN Medium 13"

# 主题
Theme=Material-Color-Pink
Theme可选项有：
    • Material-Color-Pink
    • Material-Color-Blue
    • Material-Color-Brown
    • Material-Color-DeepPurple
    • Material-Color-Indigo
    • Material-Color-Red
    • Material-Color-Teal
自己选择心宜的颜色即可。
另外，与fcitx不同的是，fcitx5-rime的输入方案配置目录改变了，为.local/share/fcitx5/rime。

#pacman -Ss fcitx
#查看
安装完后在~/.xprofile加上：
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
manjaro 设置 fcitx 输入法:
1、设置它只有在使用额外切换键隐藏输入法后，才可以再使用额外切换键将其唤醒：
直接运行 fcitx-configtool 即可进行图形界面配置。
然后查看 .config/fcitx/config 里的相应值是否已经改变，然后立即手动将  .config/fcitx/config 和  .config/fcitx/profile 的所有写属性去掉，即 chmod a-w  .config/fcitx/config;  chmod a-w  .config/fcitx/profile;
打开配置文件  .config/fcitx/config，
将 UseExtraTriggerKeyOnlyWhenUseItToInactivate=False 改成 UseExtraTriggerKeyOnlyWhenUseItToInactivate=True
将 SwitchKey=SHIFT Both    注释掉
将 IMSwitchIncludeInactive=True 改为 False
即可。
            ​ 双拼配置自选方案
                ​ 图形化工具配置
如果装了 fcitx-configtool 这个图形化工具，可以在里面搜索「pinyin」找到双拼的选项，直接配置。
                ​ 手动配置
fcitx 自带双拼输入法，使用的是自然码。如需修改为其它双拼方案，按如下操作即可。
打开 ~/.config/fcitx/conf/fcitx-pinyin.config。
能看到默认双拼方案是自然码（Ziranma）。
我用的小鹤双拼，所以取消注释并修改为 XiaoHe。
DefaultShuangpinSchema=XiaoHe
修改后重启输入法就能生效啦。（右键任务栏的键盘，选择重新启动。）
PS：该文件里还有一些配置项，可以按自己需求修改……
            ​ 简体中文输入法使用直角引号
修改 /usr/share/fcitx/data/文件夹下以「zh-CN」结尾的文件。
「zh-CN」对应的就是简体中文输入法。
该文件名因系统不同有差异。比如在我当前的 Manjaro 版本，该文件为punc.mb.zh_CN。而在我之前使用的 deepin 系统上，该文件为punc-ng.mb.zh_CN。我还在网络上看到一些人的是punc-ng.mb-zh_CN。
将对应的「"」与「’」按如下修改即可。
" 「 」
' 『 』
注意！/usr/share/fcitx/data/ 下的文件是「全局配置文件」。建议将该文件复制到用户目录，即~/.config/fcitx/data/下面再进行修改。
            ​ 拼音云输入
# 安装
sudo pacman -Sy fcitx-cloudpinyin
安装后在「配置—附加组件」里找到可以修改云拼音来源，大陆用户就修改为百度吧～
不过我现在（码这篇博文的现在）没感觉到这云拼音有啥用……
            ​ 其它
网络上提到的 wine 系软件不能输入中文之类的问题倒是没遇到……
不过遇到了网易云不能输入中文，非刚需自己就没折腾。

    ​ 3 AUR助手
AUR是Arch User Repository的缩写，是Arch/Manjaro用户的社区驱动存储库。AUR助手有很多，这里推荐yay。yay是用Go编写的Arch Linux AUR帮助工具，可以帮助以自动方式从PKGBUILD安装软件包。
sudo pacman -S yay
    ​ 4 常用软件
        ​ 4.1 chrome/chromium
sudo pacman -S google-chrome
sudo pacman -S chromium
        ​ 4.2 网易云音乐
sudo pacman -S netease-cloud-music
        ​ 4.3 git
sudo pacman -S git
        ​ 4.4 vim
默认只有vi，没带vim。
sudo pacman -S vim
        ​ 4.5 wps
sudo pacman -S wps-office
        ​ 4.6 VScode
sudo pacman -S visual-studio-code
        ​ 4.7 qq
qq可以选择的版本比较多，可以选择wine版的qq，deepinwine版的qq，deepinwine版的tim。这里推荐使用deepinwine的qq或者tim。
直接使用yay安装即可：
yay -S deepin-wine-qq
yay -S deepin-wine-tim
若直接安装失败可以使用本地打包安装：
git clone https://github.com/countstarlight/deepin-wine-tim-arch.git
cd deepin-wine-tim-arch
makepkg -si

git clone https://github.com/countstarlight/deepin-wine-qq-arch.git
cd deepin-wine-qq-arch  
makepkg -si
        ​ 4.8 微信
微信可以使用electronic-wechat或者deepinwine-wechat，推荐后者。
yay -S deepin-wine-wechat
若签名出现问题可以加上：
yay -S deepin-wine-wechat --mflags --skipinteg
若deepin-wine-wechat安装失败可以从本地打包安装
git clone https://github.com/countstarlight/deepin-wine-wechat-arch.git
cd deepin-wine-wechat-arch 
makepkg -si
但目前从2.8.0.106-1以上的版本开始大图片发送失败，没办法发送压缩包，推荐使用2.7.1.88-1版本，并且关闭自动更新，戳这里下载，然后安装：
sudo pacman -U deepin-wine-wechat-2.7.1.88-1-x86_64.pkg.tar.xz
        ​ 4.10 深度截图
sudo pacman -S deepin-screenshot
            ​ 添加快捷键：
    • 打开Settings
    • 选择Devices，选择Keyboard
    • 滑到底部选择添加


        ​ 火焰截图

sudo pacman -S flameshot
Flameshot 自带一系列非常好的功能，例如：
    • 可以进行手写 
    • 可以划直线 
    • 可以画长方形或者圆形框 
    • 可以进行长方形区域选择 
    • 可以画箭头 
    • 可以对要点进行标注 
    • 可以添加文本 
    • 可以对图片或者文字进行模糊处理 
    • 可以展示图片的尺寸大小 
    • 在编辑图片是可以进行撤销和重做操作 
    • 可以将选择的东西复制到剪贴板 
    • 可以保存选区 
    • 可以离开截屏 
    • 可以选择另一个 app 来打开图片 
    • 可以上传图片到 imgur 网站 
    • 可以将图片固定到桌面上 
看一下操作的的GIF动画效果：


        ​ 4.11 JetBrains
对于这种大型的IDE笔者喜欢从官网下载，以PyCharm为例，下载解压移动：
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
        ​ 4.12 web服务器
sudo pacman -S tomcat9 apache nginx
    ​ 5 deepin-wine常见问题处理
        ​ 5.1 无法切换中文输入法
在
~/.xinitrc
加上
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
然后在对应的run.sh加上：
env locale=zh_CN
export XIM=fcitx
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
这里的run.sh位于
/opt/deepinwine/apps/Deepin-xxx
下。
# QQ
/opt/deepinwine/apps/Deepin-QQ/run.sh
# WeChat
/opt/deepinwine/apps/Deepin-WeChat/run.sh
# Tim
/opt/deepinwine/apps/Deepin-Tim/run.sh
        ​ 5.2 字体发虚
env WINEPREFIX="$HOME/.deepinwine/Deepin-QQ" winecfg
env WINEPREFIX="$HOME/.deepinwine/Deepin-WeChat" winecfg
env WINEPREFIX="$HOME/.deepinwine/Deepin-Tim" winecfg
执行其中一个命令，然后修改dpi：

        ​ 5.3 阴影边框
微信运行后，切换到其他窗口会有一个阴影边框。
对于v2.8.0.133-2之后的版本应该不会出现这个问题，因为自带了shadow.exe，但是不能传输文件与大图片（issue中已有反映，这是一个bug，建议使用2.7版本），对于之前的版本，参照这里的办法，把shadows.exe复制到对应目录：
git clone https://github.com/countstarlight/deepin-wine-wechat-arch.git
sudo cp deepin-wine-wechat-arch-master/shadow.exe ~/.deepinwine/Deepin-WeChat/drive_c/
然后修改run.sh：

#修改/opt/deepinwine/apps/Deepin-WeChat/run.sh，可以先备份一下
#找到CallApp()，在env WINEDLLOVERRIDS这一行的末尾加上
&

#同时在fi后面加上
if [[ -z "$(ps -e | grep -o 'shadow.exe')" ]]; then
    env WINEPREFIX="$WINEPREFIX" WINEDEBUG=-msvcrt $WINE_CMD "c:\\shadow.exe" &
fi
    ​ 6 终端美化
终端美化当然是用zsh+oh-my-zsh。
        ​ 6.1 安装zsh
默认安装了，没安装的话：
sudo pacman -S zsh
        ​ 6.2 安装oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        ​ 6.3 字体
需要安装Powerline字体，不难，clone一下，直接安装就好了。
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
        ​ 6.4 主题
oh-my-zsh的配置文件如下：
~/.oh-my-zsh
其中的themes下有不少主题，具体效果可以来这里查看。
这里推荐使用agnoster与powerlevel9k主题（当然还有一个powerlevel10k主题，感兴趣可以自行github），agnoster已自带，powerlevel9k需要安装：
sudo pacman -S zsh-theme-powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
然后修改配置文件：
#修改~/.zshrc
ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"
        ​ 6.5 替换bash
zsh替换默认bash：
chsh -s `which zsh`
        ​ 6.6 别名
原来bash的别名在zsh需要重新配置一下，直接在
～/.zshrc
加上原来的alias即可。
        ​ 6.7 进一步修改
笔者用的主题是agnoster，直接使用的话效果不怎么样：

忍不住了，直接去修改配置文件（themes/agnoster-zsh.thene），agnoster的核心函数是这个：

其中prompt_context是用户名与主机名的部分，注释后就不会显示用户名与主机名了，其他也类似，比如prompt_dir是当前工作目录，定位后：

prompt_segment接受两个参数，一个背景，一个前景，其中blue就是上图的那个不怎么好看的深蓝色，CURRENT_FG是前景色，这里是黑色，也就是文字颜色。
经过一番摸索 ，发现能支持十六进制RGB，真香： 

于是就没有深蓝色的背景啦：

终端为XFCE Terminal，在系统设置中根据个人需要修改背景壁纸，修改文字颜色等：

整体效果：

        ​ 6.8 终极美化
终极美化使用Powerlevel9k/Powerlevel10k，步骤倒是不多只是配置多，需要耐心仔细去调，具体可以看笔者另一篇文章，链接戳这里。
    ​ 7 常用别名与脚本
        ​ 7.1 常用别名
仅供参考，一些常用别名：
#.bashrc加上
alias m='sudo mkdir -p' #新建文件夹
alias d='cd ~/Desktop && ls'
alias rrr='shutdown -r now'
alias sss='shutdown now'
        ​ 7.2 cd脚本
使用c代替常用的cd，同时执行完之后自动ls一次：
if [ $# -eq 0 ] ; then
    cd .. && ls
else
    cd $1 && ls
fi
如果只是输入一个c，回到上层目录并ls，如果带目录参数，切换到对应目录并且ls。需要加上别名使用：
alias c='source ~/.cd.sh' #脚本文件名为.cd.sh，位于～下
        ​ 7.3 rm脚本
使用r代替rm，无需加上rf参数，使用回收站机制，也就是直接移动。
for i in $*; do
    mv $i /home/YOUR_USER_NAME/.Trash/`basename $i`_`date +%Y_%m_%d__%H_%M_%S`
done
移动的文件名后面加上了时间，回收站位置为用户目录下的.Trash，同时加上别名：
alias r='sudo sh ~/.rm.sh' # 脚本名字为.rm.sh，用户目录下
alias trash='cd ~/.Trash && ls'
Manjaro Linux的美化
    ​ 切换源
Copy
sudo vi /etc/pacman.conf
加入arch源
Copy
[archlinuxcn]
SigLevel = Optional TrustedOnly
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch 
blackarch源(可以选择加入)
Copy
[blackarch]
SigLevel = Optional TrustAll
Server = https://mirrors.ustc.edu.cn/blackarch/$repo/os/$arch
面对高校的源
Copy
[arch4edu]
SigLevel = Never
Server = http://mirrors.tuna.tsinghua.edu.cn/arch4edu/$arch
ck源
Copy
[repo-ck]                         
Server = http://repo-ck.com/$arch
设置国内源 选择前三个 快的
Copy
sudo pacman-mirrors -i -c China -m rank
全局更新
Copy
sudo pacman -Syyu
数据库被锁,删除/var/lib/pacman/db.lck
Copy
rm /var/lib/pacman/db.lck
导入key
Copy
sudo pacman -Sy archlinuxcn-keyring

导入失败
Copy
sudo pacman -Syu haveged
sudo systemctl start haveged
sudo systemctl enable haveged
sudo rm -rf /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux
pacman-key --populate archlinuxcn

    ​ 挂载硬盘
Copy
sudo mount -t ntfs-3g /dev/sda1 /mnt

Copy
sudo fdisk -l
＃查看ＵＵＩＤ
sudo blkid
sudo vim /etc/fstab
UUID=DA18EBFA09C1B27D /mnt/Windows ntfs-3g rw,umask=0000,defaults 0 0


    ​ 常用命令
Copy
安装 pacman -S package_name  |yay -S  package_name 
删除 pacman -R package_name  
查询net  pacman -Q |grep net


解决Windows和Linux双系统时间不一致问题
sudo timedatectl set-local-rtc 1
    ​ 搜狗拼音
Copy
sudo pacman -S fcitx-im
sudo pacman -S fcitx-configtool
sudo pacman -S fcitx-sogoupinyin

添加配置文件
Copy
sudo vi ~/.xprofile

内容
Copy
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

Copy
fcitx-configtool
#对于jetbrians系列fcitx无法跟随的情况 fcitx输入法配置>附加组件>勾选高级>xim前端>勾选on the spot


    ​ 安装工具
Copy
sudo pacman -S yaourt yay


    ​ SSR
Copy
yay -S electron-ssr
http://127.0.0.1:12333
socks5://127.0.0.1:1080

谷歌代理
Copy
google-chrome-stable --proxy-server=socks5://127.0.0.1:1080


终端代理
Copy
yay -S proxychains-ng
vim /etc/proxychains.conf
//最后加入
socket5 127.0.0.1 1080
alias gfw='proxychains4'
gfw curl ip.gs



    ​ ZSH
Copy
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh 


            ​ 可选插件安装#
                ​ 高亮插件#
高亮zsh-syntax-highlighting 高亮你的zsh可用命令插件
Copy
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


激活插件
Copy
sudo vi ~/.zshrc 


加入插件
Copy
plugins=(git zsh-syntax-highlighting)


让他生效
Copy
source ~/.zshrc 


                ​ zsh-autosuggestions#
Copy
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


加入插件
Copy
   plugins=(git zsh-syntax-highlighting zsh-autosuggestions) 


生效 source ~/.zshrc
                ​ zsh补全插件#
点击下载
创建目录
Copy
mkdir ~/.oh-my-zsh/custom/plugins/incr


把下载的文件移动进去
Copy
sudo vi ~/.zshrc 


添加
Copy
plugins=(git zsh-syntax-highlighting incr)


在~/.zshrc文件末尾加上
Copy
source ~/.oh-my-zsh/plugins/incr/incr*.zsh


更新.zshrc文件：
Copy
source ~/.zshrc


                ​ spaceship主题#
Copy
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


打开~/.zshrc 设置主题
Copy
ZSH_THEME="spaceship"


    ​ 中文字体
        ​ 文泉驿家族：#
Copy
sudo pacman -S --noconfirm wqy-microhei &&fc-cache -fv
sudo pacman -S wqy-microhei-lite
sudo pacman -S wqy-bitmapfont
sudo pacman -S wqy-zenhei


        ​ YaHei-Consolas字体#
Copy
cd /tmp&&git clone https://github.com/GitHubNull/YaHei-Consolas-Hybrid-1.12.git --depth 1&&sudo sh YaHei-Consolas-Hybrid-1.12/setup.sh


        ​ 选用：#
Copy
yaourt -S ttf-meslo
sudo pacman -S adobe-source-han-sans-cn-fonts
sudo pacman -S adobe-source-han-serif-cn-fonts
sudo pacman -S noto-fonts-cjk


    ​ 软件安装
谷歌 vim git vs vlc neofetch 网易云 foxitreader 火狐汉化 uget
Copy
 yay -S google-chrome vim  git visual-studio-code-bin  vlc  neofetch netease-cloud-music foxitreader  firefox-i18n-zh-cn   uget


bat cat的克隆
xmind zen
Copy
pdf-footer-zh-CN.svg
png-watermark-zh-CN.svg
print-watermark-zh-CN.svg

ncdu 可视化分析目录占用
redshift 色温调节
virtualbox 虚拟机 安装对应内核
qalculate 计算器
wiznote 为知笔记
Albert 软件启动器
wps wps字体 wps-office ttf-wps-fonts
file-roller unrar unzip p7zip 压缩解压缩
motrix
aria2
需要安装以下工具即可正常使用ifconfig
Copy
sudo pacman -S net-tools dnsutils inetutils iproute2

spacevim
Copy
curl -sLf https://spacevim.org/cn/install.sh | bash

cool-retro-term 一个怀旧的终端
    ​ 开发软件
java: as idea tomcat maven gradle
        ​ nodejs#
        ​ flutter#
Copy
git clone -b stable　https://github.com/flutter/flutter.git


Copy
vim ~/.zsh


加上
Copy
export PATH=~/Downloads/flutter/bin:$PATH
//path为你安装flutter的目录
source ~/.zshrc


切换分支
Copy
查看分支
flutter channel
切换master
flutter channel master


        ​ anaconda#
Copy
sudo vim ~/.zshrc
export PATH=/opt/anaconda/bin:$PATH


        ​ git 设置#
Copy
git config --global user.name "your_name"
git config --global user.email "your_email"
git config --global http.proxy 'socks5://127.0.0.1:1080' 


~/.gitconfig
Copy
[http]
        proxy = socks5://127.0.0.1:1080


        ​ vscode调试html#
Copy
{
    "version": "0.2.0",
    "configurations": [{
        "type": "chrome",
        "request": "launch",
        "name": "chrome linux",
        "webRoot": "${workspaceFolder}",
        "runtimeExecutable": "/usr/bin/google-chrome-stable",
        "runtimeArgs": [
            "--remote-debugging-port=9222",
            "--no-first-run",
            "--no-default-browser-check",
            "--user-data-dir=/tmp/vscode-chrome-debug-rix",
            "${file}"
        ]
    }]
}


        ​ lnmp#
            ​ nginx#
Copy
sudo pacman -S nginx 
systemctl来查看其状态
systemctl status nginx
sudo systemctl start nginx
设置Nginx开机自启动。
sudo systemctl enable nginx
版本
nginx -v
在浏览器地址栏输入127.0.0.1


            ​ mariaDB#
Copy
sudo pacman -S mariadb
在启动MariaDB服务之前，需要用下面的mysql_install_db命令初始化MariaDB的数据目录，
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
启用
sudo systemctl start mysqld
systemctl status mysqld
运行安全脚本
sudo mysql_secure_installation
版本
mysql --version


            ​ PHP7#
Copy
sudo pacman -S php-fpm
安装后，我们要让Nginx使用php-fpm来运行php。编辑/etc/nginx/nginx.conf文件。

sudo nano /etc/nginx/nginx.conf
找到location ~ \.php$这部分的配置，将这部分配置修改成如下。

location ~ \.php$ {
            root           /usr/share/nginx/html;
            fastcgi_pass   unix:/run/php-fpm/php-fpm.sock;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }
保存文件。然后启动php-fpm，并设置开机自启动。

sudo systemctl start php-fpm
sudo systemctl enable php-fpm
测试PHP
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

sudo nano /etc/php/php.iniwps-office   ttf-wps-fonts
找到如下两行文字，去掉前面的#符号以启用mysqli和pdo_mysql。

;extension=mysqli.so
;extension=pdo_mysql.so
mysqli.do用来建立数据库连接。pdo_mysql.so是drupal内容管理系统所必要的PHP扩展。如果需要在WordPress, Drupal内容管理系统中剪裁、旋转图片，那么需要启用imagemagick这个扩展。
好了！我们成功地在Arch Linux服务器安装了LNMP (Nginx, MariaDB, PHP7)


            ​ 总结#
Copy
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
            root           /usr/share/nginx/html;
            fastcgi_pass unix:/run/php-fpm/php-fpm.sock;
            fastcgi_index  index.php;
            include fastcgi.conf;
        }


tomcat8 jdk8 notepadqq sublime-text-dev-zh-cn
androidstudio idea pycham node
typora filezilla
    ​ 美化
            ​ 主题文件#
/usr/share/themes
Flat-Remix-GTK
Ant-Dracula
            ​ 图标文件#
/usr/share/icons
Zafiro icons
            ​ 改logo#
Copy
sudo vim  /etc/lsb-release
改第一行跟最后一行，比如改成ArchLinux和Arch Linux

    ​ 游戏
0ad 跨平台的“帝国时代”
wesnoth 回合制策略
2048-qt 经典的2048游戏
zaz 经典的泡泡射击游戏；
gnome-mines 扫雷

manjaro配置攻略

1 源
一、更新源的配置：
因为没安装 fakeroot、binutils 等打包基本工具，所以pacman -S base-devel 装一下。


1）、自动方法:
在 /etc/pacman.conf 文件末尾添加行：
[archlinuxcn]
SigLevel = Optional TrustedOnly
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
然后安装 archlinuxcn-keyring 包以导入 GPG key，否则的话key验证失败会无法安装的。
排列中国镜像的速度，选择一个。
sudo pacman-mirrors -i -c China -m rank
接着更新并导入GPG key：
sudo pacman -S archlinuxcn-keyring && sudo pacman -Syy
2 输入法
sudo pacman -S fcitx-im fcitx-configtool
# 输入法看个人，这里装的是谷歌拼音
sudo pacman -S fcitx-googlepinyin
#搜狗
#sudo pacman -S fcitx-sogoupinyin
#rime
#sudo pacman -S fctix-rime
#更多输入法使用

sudo pacman -Sy fcitx
sudo pacman -Sy fcitx-configtool
yay fcitx-sogoupinyin
yay fcitx-qt4
# 以上四步是fcitx和搜狗拼音的配置
安装完后在~/.xprofile加上：
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
manjaro 设置 fcitx 输入法:
1、设置它只有在使用额外切换键隐藏输入法后，才可以再使用额外切换键将其唤醒：
直接运行 fcitx-configtool 即可进行图形界面配置。
然后查看 .config/fcitx/config 里的相应值是否已经改变，然后立即手动将  .config/fcitx/config 和  .config/fcitx/profile 的所有写属性去掉，即 chmod a-w  .config/fcitx/config;  chmod a-w  .config/fcitx/profile;
打开配置文件  .config/fcitx/config，
将 UseExtraTriggerKeyOnlyWhenUseItToInactivate=False 改成 UseExtraTriggerKeyOnlyWhenUseItToInactivate=True
将 SwitchKey=SHIFT Both    注释掉
将 IMSwitchIncludeInactive=True 改为 False
即可。
双拼配置自选方案
图形化工具配置
如果装了 fcitx-configtool 这个图形化工具，可以在里面搜索「pinyin」找到双拼的选项，直接配置。
手动配置
fcitx 自带双拼输入法，使用的是自然码。如需修改为其它双拼方案，按如下操作即可。
打开 ~/.config/fcitx/conf/fcitx-pinyin.config。
能看到默认双拼方案是自然码（Ziranma）。
我用的小鹤双拼，所以取消注释并修改为 XiaoHe。
DefaultShuangpinSchema=XiaoHe
修改后重启输入法就能生效啦。（右键任务栏的键盘，选择重新启动。）
PS：该文件里还有一些配置项，可以按自己需求修改……
简体中文输入法使用直角引号
修改 /usr/share/fcitx/data/文件夹下以「zh-CN」结尾的文件。
「zh-CN」对应的就是简体中文输入法。
该文件名因系统不同有差异。比如在我当前的 Manjaro 版本，该文件为punc.mb.zh_CN。而在我之前使用的 deepin 系统上，该文件为punc-ng.mb.zh_CN。我还在网络上看到一些人的是punc-ng.mb-zh_CN。
将对应的「"」与「’」按如下修改即可。
" 「 」
' 『 』
注意！/usr/share/fcitx/data/ 下的文件是「全局配置文件」。建议将该文件复制到用户目录，即~/.config/fcitx/data/下面再进行修改。
拼音云输入
# 安装
sudo pacman -Sy fcitx-cloudpinyin
安装后在「配置—附加组件」里找到可以修改云拼音来源，大陆用户就修改为百度吧～
不过我现在（码这篇博文的现在）没感觉到这云拼音有啥用……
其它
网络上提到的 wine 系软件不能输入中文之类的问题倒是没遇到……
不过遇到了网易云不能输入中文，非刚需自己就没折腾。

3 AUR助手
AUR是Arch User Repository的缩写，是Arch/Manjaro用户的社区驱动存储库。AUR助手有很多，这里推荐yay。yay是用Go编写的Arch Linux AUR帮助工具，可以帮助以自动方式从PKGBUILD安装软件包。
sudo pacman -S yay
4 常用软件
4.1 chrome/chromium
sudo pacman -S google-chrome
sudo pacman -S chromium
4.2 网易云音乐
sudo pacman -S netease-cloud-music
4.3 git
sudo pacman -S git
4.4 vim
默认只有vi，没带vim。
sudo pacman -S vim
4.5 wps
sudo pacman -S wps-office
4.6 VScode
sudo pacman -S visual-studio-code-bin
4.7 qq
qq可以选择的版本比较多，可以选择wine版的qq，deepinwine版的qq，deepinwine版的tim。这里推荐使用deepinwine的qq或者tim。直接使用yay安装即可：
yay -S deepin-wine-qq
yay -S deepin-wine-tim
若直接安装失败可以使用本地打包安装：
git clone https://github.com/countstarlight/deepin-wine-tim-arch.git
cd deepin-wine-tim-arch
makepkg -si

git clone https://github.com/countstarlight/deepin-wine-qq-arch.git
cd deepin-wine-qq-arch  
makepkg -si
4.8 微信
微信可以使用electronic-wechat或者deepinwine-wechat，推荐后者。
yay -S deepin-wine-wechat
若签名出现问题可以加上：
yay -S deepin-wine-wechat --mflags --skipinteg
若deepin-wine-wechat安装失败可以从本地打包安装
git clone https://github.com/countstarlight/deepin-wine-wechat-arch.git
cd deepin-wine-wechat-arch 
makepkg -si
但目前从2.8.0.106-1以上的版本开始大图片发送失败，没办法发送压缩包，推荐使用2.7.1.88-1版本，并且关闭自动更新，戳这里下载，然后安装：
sudo pacman -U deepin-wine-wechat-2.7.1.88-1-x86_64.pkg.tar.xz
4.10 深度截图
sudo pacman -S deepin-screenshot
添加快捷键：
	打开Settings
	选择Devices，选择Keyboard
	滑到底部选择添加


火焰截图

sudo pacman -S flameshot
Flameshot 自带一系列非常好的功能，例如：
	可以进行手写 
	可以划直线 
	可以画长方形或者圆形框 
	可以进行长方形区域选择 
	可以画箭头 
	可以对要点进行标注 
	可以添加文本 
	可以对图片或者文字进行模糊处理 
	可以展示图片的尺寸大小 
	在编辑图片是可以进行撤销和重做操作 
	可以将选择的东西复制到剪贴板 
	可以保存选区 
	可以离开截屏 
	可以选择另一个 app 来打开图片 
	可以上传图片到 imgur 网站 
	可以将图片固定到桌面上 
看一下操作的的GIF动画效果：


4.11 JetBrains
对于这种大型的IDE笔者喜欢从官网下载，以PyCharm为例，下载解压移动：
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
4.12 web服务器
sudo pacman -S tomcat9 apache nginx
5 deepin-wine常见问题处理
5.1 无法切换中文输入法
在
~/.xinitrc
加上
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
然后在对应的run.sh加上：
env locale=zh_CN
export XIM=fcitx
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
这里的run.sh位于
/opt/deepinwine/apps/Deepin-xxx
下。
# QQ
/opt/deepinwine/apps/Deepin-QQ/run.sh
# WeChat
/opt/deepinwine/apps/Deepin-WeChat/run.sh
# Tim
/opt/deepinwine/apps/Deepin-Tim/run.sh
5.2 字体发虚
env WINEPREFIX="$HOME/.deepinwine/Deepin-QQ" winecfg
env WINEPREFIX="$HOME/.deepinwine/Deepin-WeChat" winecfg
env WINEPREFIX="$HOME/.deepinwine/Deepin-Tim" winecfg
执行其中一个命令，然后修改dpi：
5.3 阴影边框
微信运行后，切换到其他窗口会有一个阴影边框。对于v2.8.0.133-2之后的版本应该不会出现这个问题，因为自带了shadow.exe，但是不能传输文件与大图片（issue中已有反映，这是一个bug，建议使用2.7版本），对于之前的版本，参照这里的办法，把shadows.exe复制到对应目录：
git clone https://github.com/countstarlight/deepin-wine-wechat-arch.git
sudo cp deepin-wine-wechat-arch-master/shadow.exe ~/.deepinwine/Deepin-WeChat/drive_c/
然后修改run.sh：
#修改/opt/deepinwine/apps/Deepin-WeChat/run.sh，可以先备份一下
#找到CallApp()，在env WINEDLLOVERRIDS这一行的末尾加上
&

#同时在fi后面加上
if [[ -z "$(ps -e | grep -o 'shadow.exe')" ]]; then
    env WINEPREFIX="$WINEPREFIX" WINEDEBUG=-msvcrt $WINE_CMD "c:\\shadow.exe" &
fi
6 终端美化
终端美化当然是用zsh+oh-my-zsh。
6.1 安装zsh
默认安装了，没安装的话：
sudo pacman -S zsh
6.2 安装oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
6.3 字体
需要安装Powerline字体，不难，clone一下，直接安装就好了。
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
6.4 主题
oh-my-zsh的配置文件如下：
~/.oh-my-zsh
其中的themes下有不少主题，具体效果可以来这里查看。这里推荐使用agnoster与powerlevel9k主题（当然还有一个powerlevel10k主题，感兴趣可以自行github），agnoster已自带，powerlevel9k需要安装：
sudo pacman -S zsh-theme-powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
然后修改配置文件：
#修改~/.zshrc
ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"
6.5 替换bash
zsh替换默认bash：
chsh -s `which zsh`
6.6 别名
原来bash的别名在zsh需要重新配置一下，直接在
～/.zshrc
安装插件#
高亮插件 zsh-syntax-highlighting
Copy
# 执行下面指令自动安装
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

自动补全 zsh-autosuggestions
Copy
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

安装后启用插件
Copy
# 编辑~/.zshrc   vim ~/.zshrc    # 在plugins后括号里添加安装的插件名字plugins=( git 
          zsh-syntax-highlighting
        )# 最后刷新source ~/.zshrc    

终极美化使用Powerlevel9k/Powerlevel10k，步骤倒是不多只是配置多，需要耐心仔细去调，具体可以看笔者另一篇文章，链接戳这里。
7 常用别名与脚本
7.1 常用别名
仅供参考，一些常用别名：
#.bashrc加上
alias m='sudo mkdir -p' #新建文件夹
alias d='cd ~/Desktop && ls'
alias rrr='shutdown -r now'
alias sss='shutdown now'
7.2 cd脚本
使用c代替常用的cd，同时执行完之后自动ls一次：
if [ $# -eq 0 ] ; then
    cd .. && ls
else
    cd $1 && ls
fi
如果只是输入一个c，回到上层目录并ls，如果带目录参数，切换到对应目录并且ls。需要加上别名使用：
alias c='source ~/.cd.sh' #脚本文件名为.cd.sh，位于～下
7.3 rm脚本
使用r代替rm，无需加上rf参数，使用回收站机制，也就是直接移动。
for i in $*; do
    mv $i /home/YOUR_USER_NAME/.Trash/`basename $i`_`date +%Y_%m_%d__%H_%M_%S`
done
移动的文件名后面加上了时间，回收站位置为用户目录下的.Trash，同时加上别名：
alias r='sudo sh ~/.rm.sh' # 脚本名字为.rm.sh，用户目录下
alias trash='cd ~/.Trash && ls'
Manjaro Linux的美化

切换源
Copy
sudo vi /etc/pacman.conf
加入arch源
Copy
[archlinuxcn]
SigLevel = Optional TrustedOnly
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch 
blackarch源(可以选择加入)
Copy
[blackarch]
SigLevel = Optional TrustAll
Server = https://mirrors.ustc.edu.cn/blackarch/$repo/os/$arch
面对高校的源
Copy
[arch4edu]
SigLevel = Never
Server = http://mirrors.tuna.tsinghua.edu.cn/arch4edu/$arch
ck源
Copy
[repo-ck]                         
Server = http://repo-ck.com/$arch
设置国内源 选择前三个 快的
Copy
sudo pacman-mirrors -i -c China -m rank
全局更新
Copy
sudo pacman -Syyu
数据库被锁,删除/var/lib/pacman/db.lck
Copy
rm /var/lib/pacman/db.lck
导入key
Copy
sudo pacman -Sy archlinuxcn-keyring

导入失败
Copy
sudo pacman -Syu haveged
sudo systemctl start haveged
sudo systemctl enable haveged
sudo rm -rf /etc/pacman.d/gnupg
pacman-key --init
pacman-key --populate archlinux
pacman-key --populate archlinuxcn

挂载硬盘
Copy
sudo mount -t ntfs-3g /dev/sda1 /mnt

Copy
sudo fdisk -l
＃查看ＵＵＩＤ
sudo blkid
sudo vim /etc/fstab
UUID=DA18EBFA09C1B27D /mnt/Windows ntfs-3g rw,umask=0000,defaults 0 0


常用命令
Copy
安装 pacman -S package_name  |yay -S  package_name 
删除 pacman -R package_name  
查询net  pacman -Q |grep net


解决Windows和Linux双系统时间不一致问题
sudo timedatectl set-local-rtc 1
搜狗拼音
Copy
sudo pacman -S fcitx-im
sudo pacman -S fcitx-configtool
sudo pacman -S fcitx-sogoupinyin

添加配置文件
Copy
sudo vi ~/.xprofile

内容
Copy
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

Copy
fcitx-configtool
#对于jetbrians系列fcitx无法跟随的情况 fcitx输入法配置>附加组件>勾选高级>xim前端>勾选on the spot


安装工具
Copy
sudo pacman -S yaourt yay


SSR
Copy
yay -S electron-ssr
http://127.0.0.1:12333
socks5://127.0.0.1:1080

谷歌代理
Copy
google-chrome-stable --proxy-server=socks5://127.0.0.1:1080


终端代理
Copy
yay -S proxychains-ng
vim /etc/proxychains.conf
//最后加入
socket5 127.0.0.1 1080
alias gfw='proxychains4'
gfw curl ip.gs



ZSH
Copy
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh 


可选插件安装#
高亮插件#
高亮zsh-syntax-highlighting 高亮你的zsh可用命令插件
Copy
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


激活插件
Copy
sudo vi ~/.zshrc 


加入插件
Copy
plugins=(git zsh-syntax-highlighting)


让他生效
Copy
source ~/.zshrc 


zsh-autosuggestions#
Copy
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


加入插件
Copy
   plugins=(git zsh-syntax-highlighting zsh-autosuggestions) 


生效 source ~/.zshrc
zsh补全插件#
点击下载
创建目录
Copy
mkdir ~/.oh-my-zsh/custom/plugins/incr


把下载的文件移动进去
Copy
sudo vi ~/.zshrc 


添加
Copy
plugins=(git zsh-syntax-highlighting incr)


在~/.zshrc文件末尾加上
Copy
source ~/.oh-my-zsh/plugins/incr/incr*.zsh


更新.zshrc文件：
Copy
source ~/.zshrc


spaceship主题#
Copy
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


打开~/.zshrc 设置主题
Copy
ZSH_THEME="spaceship"


中文字体
文泉驿家族：#
Copy
sudo pacman -S --noconfirm wqy-microhei &&fc-cache -fv
sudo pacman -S wqy-microhei-lite
sudo pacman -S wqy-bitmapfont
sudo pacman -S wqy-zenhei


YaHei-Consolas字体#
Copy
cd /tmp&&git clone https://github.com/GitHubNull/YaHei-Consolas-Hybrid-1.12.git --depth 1&&sudo sh YaHei-Consolas-Hybrid-1.12/setup.sh


选用：#
Copy
yaourt -S ttf-meslo
sudo pacman -S adobe-source-han-sans-cn-fonts
sudo pacman -S adobe-source-han-serif-cn-fonts
sudo pacman -S noto-fonts-cjk


软件安装
谷歌 vim git vs vlc neofetch 网易云 foxitreader 火狐汉化 uget
Copy
 yay -S google-chrome vim  git visual-studio-code-bin  vlc  neofetch netease-cloud-music foxitreader  firefox-i18n-zh-cn   uget


bat cat的克隆
xmind zen
Copy
pdf-footer-zh-CN.svg
png-watermark-zh-CN.svg
print-watermark-zh-CN.svg

ncdu 可视化分析目录占用
redshift 色温调节
virtualbox 虚拟机 安装对应内核
qalculate 计算器
wiznote 为知笔记
Albert 软件启动器
wps wps字体 wps-office ttf-wps-fonts
file-roller unrar unzip p7zip 压缩解压缩
motrix
aria2
需要安装以下工具即可正常使用ifconfig
Copy
sudo pacman -S net-tools dnsutils inetutils iproute2

spacevim
Copy
curl -sLf https://spacevim.org/cn/install.sh | bash

cool-retro-term 一个怀旧的终端
开发软件
java: as idea tomcat maven gradle
nodejs#
flutter#
Copy
git clone -b stable https://github.com/flutter/flutter.git


Copy
vim ~/.zsh


加上
Copy
export PATH=~/Downloads/flutter/bin:$PATH
//path为你安装flutter的目录
source ~/.zshrc


切换分支
Copy
查看分支
flutter channel
切换master
flutter channel master


anaconda#
Copy
sudo vim ~/.zshrc
export PATH=/opt/anaconda/bin:$PATH


git 设置#
Copy
git config --global user.name "your_name"
git config --global user.email "your_email"
git config --global http.proxy 'socks5://127.0.0.1:1080' 


~/.gitconfig
Copy
[http]
        proxy = socks5://127.0.0.1:1080


vscode调试html#
Copy
{
    "version": "0.2.0",
    "configurations": [{
        "type": "chrome",
        "request": "launch",
        "name": "chrome linux",
        "webRoot": "${workspaceFolder}",
        "runtimeExecutable": "/usr/bin/google-chrome-stable",
        "runtimeArgs": [
            "--remote-debugging-port=9222",
            "--no-first-run",
            "--no-default-browser-check",
            "--user-data-dir=/tmp/vscode-chrome-debug-rix",
            "${file}"
        ]
    }]
}


lnmp#
nginx#
Copy
sudo pacman -S nginx 
systemctl来查看其状态
systemctl status nginx
sudo systemctl start nginx
设置Nginx开机自启动。
sudo systemctl enable nginx
版本
nginx -v
在浏览器地址栏输入127.0.0.1


mariaDB#
Copy
sudo pacman -S mariadb
在启动MariaDB服务之前，需要用下面的mysql_install_db命令初始化MariaDB的数据目录，
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
启用
sudo systemctl start mysqld
systemctl status mysqld
运行安全脚本
sudo mysql_secure_installation
版本
mysql --version


PHP7#
Copy
sudo pacman -S php-fpm
安装后，我们要让Nginx使用php-fpm来运行php。编辑/etc/nginx/nginx.conf文件。

sudo nano /etc/nginx/nginx.conf
找到location ~ \.php$这部分的配置，将这部分配置修改成如下。

location ~ \.php$ {
            root           /usr/share/nginx/html;
            fastcgi_pass   unix:/run/php-fpm/php-fpm.sock;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }
保存文件。然后启动php-fpm，并设置开机自启动。

sudo systemctl start php-fpm
sudo systemctl enable php-fpm
测试PHP
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

sudo nano /etc/php/php.iniwps-office   ttf-wps-fonts
找到如下两行文字，去掉前面的#符号以启用mysqli和pdo_mysql。

;extension=mysqli.so
;extension=pdo_mysql.so
mysqli.do用来建立数据库连接。pdo_mysql.so是drupal内容管理系统所必要的PHP扩展。如果需要在WordPress, Drupal内容管理系统中剪裁、旋转图片，那么需要启用imagemagick这个扩展。
好了！我们成功地在Arch Linux服务器安装了LNMP (Nginx, MariaDB, PHP7)


总结#
Copy
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
            root           /usr/share/nginx/html;
            fastcgi_pass unix:/run/php-fpm/php-fpm.sock;
            fastcgi_index  index.php;
            include fastcgi.conf;
        }


tomcat8 jdk8 notepadqq sublime-text-dev-zh-cn
androidstudio idea pycham node
typora filezilla
美化
主题文件#
/usr/share/themes
Flat-Remix-GTK
Ant-Dracula
图标文件#
/usr/share/icons
Zafiro icons
改logo#
Copy
sudo vim  /etc/lsb-release
改第一行跟最后一行，比如改成ArchLinux和Arch Linux

游戏
0ad 跨平台的“帝国时代”
wesnoth 回合制策略
2048-qt 经典的2048游戏
zaz 经典的泡泡射击游戏；
gnome-mines 扫雷


中文环境设置失效
1、sudo vim /etc/locale.gen
将下面两行前面的#号去掉， 存盘退出
en_US.UTF-8
zh_CN.UTF-8
2、sudo locale-gen
3、在系统设置那里就可用选中文环境了。


Manjaro安装后需要这样做

会写代码的王沐沐关注
0.4232020.03.07 11:28:46字数 1,066阅读 1,015
写在前面
自己以前装过很多次系统，基本上主流的Linux版本都用过，Manjaro也前后装了很多次，每次装完都要重新配置，各种软件源及其配置文件，安装各种要用的软件以及这些软件的配置，每次都要上网搜好多资料，这次把一些工作都记录下来，方便下次在出现这种情况
配置软件源
首先用下面这条命令：对国内的manjaro镜像源按网速进行排名，并选择前几名
sudo pacman-mirrors -i -c China -m rank
执行完后，会弹出一个窗口让我们选择排在前几位的源，直接选择就行，选择完之后会自动更新源列表文件，要查看源列表的话执行如下命令：
sudo nano /etc/pacman.d/mirrorlist
可以看到刚刚在窗口选择的几个镜像源都已经写在mirrorlist这个文件里了
以上，是配置manjaro在国内的源，但manjaro作为arch的优秀衍生版本怎么能不用arch本身的源呢？下面我们就来设置arch源，但在设置之前要先把本地数据包与远程数据包同步，因为manjaro默认是没有同步数据包的，因此如果执行sudo pacman -S 软件名字是会报错
同步数据包：sudo pacman -Syy
其实，在配置arch源之前，一定要先同步数据包的原因就是nano真的用不惯，我还是比较喜欢用vim
安装vim：sudo pacman -S vim
打开pacman的配置文件：sudo vim /etc/pacman.conf
在文件最后添加
[archlinuxcn]
SigLevel = Optional TrustedOnly
#USTC
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
#TUNA
Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch

[antergos]
SigLevel = TrustAll
#USTC
Server = https://mirrors.ustc.edu.cn/antergos/$repo/$arch
#TUNA
Server = http://mirrors.tuna.tsinghua.edu.cn/antergos/$repo/$arch

[arch4edu]
SigLevel = TrustAll
Server = http://mirrors.tuna.tsinghua.edu.cn/arch4edu/$arch

之后，导入GPG key
sudo pacman -Syy
sudo pacman -S archlinuxcn-keyring
sudo pacman -S antergos-keyring

最后，进行全面的系统更新：sudo pacman -Syu
说明：-Sy是同步软件包，-Syy强制同步，-Su依据本地软件包全面更新系统，-Syu是同步软件包并全面更新系统
安装搜狗输入法
sudo pacman -S fcitx fcitx-qt4 fcitx-im fcitx-configtool fcitx-sogoupinyin
修改fcitx为默认输入法，编辑vim ~/.xprofile输入：
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

修改xfce4令人不快的终端界面
xfce4默认的终端字体不好，字间距特别大，字母和汉子的块也特别大，让人看着哪哪都不爽，差点又让我产生出想换系统的冲动，下面把这个问题来解决一下：
其实，这个问题解决起来也很简单，在图形界面就能搞定
打开终端，编辑->首选项->外观，自己看着调就行，怎么舒服怎么来
调终端字体大小，设置->外观->字体
更改桌面布局
windows用惯了总是习惯桌面上有个我的电脑、回收站之类的
单机鼠标右键->桌面设置->图标
安装常用的软件
·	Chrome
·	vscode
·	yay:yaourt的替代工具
·	IDLE:python自带的IDE，极轻量
平时也装了不少软件，但想想常用的就只有Chrome和vscode，后面两个,yay是安装软件必备的，但我不常用，IDLE是我调试Python程序用的，因为我比较菜，一直不会配置vscode的调试功能
ps:manjaro自带的Python3是没有默认安装IDLE的，这点很奇怪，因为在其他系统下，IDLE都是安装Python3时自动安装上的，解决方法在这里



