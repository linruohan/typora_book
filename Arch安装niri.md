# 1 安装 Arch
## 1 脚本方式 命令：
archinstall 会出现一个终端选择界面选择不同的配置进行安装
## 2 手动命令安装 用exf4 文件格式
### 2.1 #禁用 reflector 服务
 避免时不时自动换一些用不了的源
```
systemctl stop reflector.service
```
### 2.2 连接网络
1. &解锁被内核屏蔽的wifi固件: rfkill unblock wifi
2. &进入连接模式 ：iwctl
3. &列出 网卡名【假设名为wlan0,需根据实际网卡名 替换下文 wlan0】： device list
4. &扫描网络 正常无输出 仅错误会有输出： station wlan0 scan
5. &列出可用网络： station wlan0 get-networks
6. &指定wifi连接【回车后会让输入密码 连接完成】： station wlan0 connect <wifi实际名>
7. &退出连接模式： exit
#### 2.2.1 #检测网络连接【会自动连续输出 应答】
ping bing.com
&退出应答
Ctrl + C
#### 2.2.2 ********确保时间同步到系统******
```
timedatectl
```

### 2.3 ********换软件源***********************************
```bash
curl -L 'https://archlinux.org/mirrorlist/?country=CN&protocol=https' -o /etc/pacman.d/mirrorlist
# 配置源文件，取消链接最前面的# 号 修改好 用 ctrl+o 回车保存，ctrl+x 退出
vim /etc/pacman.d/mirrorlist
# 生效应用软件源
sudo pacman -Sy
```
**************************************************************************************
### 2.4 ************分区**************************************************************
```bash
***********无需的操作，更改硬盘类型为 gpt**********************
【可以快速清除掉所有分区】 
# 1 执行 parted，进行磁盘类型变更
parted /dev/nvme0n1
# 2 输入 mktable
(parted) mktable
# 3 输入 gpt，磁盘类型GPT，有数据会警告，输入 Yes 即可
New disk label type? gpt
# 4 退出 parted 命令行交互
(parted) quit
# 5 查看当前分区情况
【会显示对应的硬盘名 以实际名字替换下列 nvme0n1 硬盘名】
lsblk
#建立分区【使用cfdisk分区 启动分区   交换分区 根目录】
cfdisk /dev/nvme0n1
# 6 复查分区情况
lsblk
#格式化分区 【建立对应的文件系统，名字为分区名，不在是硬盘名】
# 7 格式化 EFI 分区  【双系统无需操作此命令】: mkfs.fat  -F32  /dev/sdxn
&格式化 Swap 交换分区 : mkswap /dev/sda2
&格式化 根目录 : mkfs.ext4 /dev/sda3
&挂载 : mount /dev/sda3 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot
# 8 启用 swap 分区: swapon /dev/nvme0n1p2
&【非必要操作】复查 
df -h
free -h  #复查swap大小
```
### 2.5 安装系统基础软件【选用长期内核，注重稳定性和长期维护】
```bash
pacstrap -K /mnt base base-devel  linux-firmware linux-lts linux-lts-headers intel-ucode
# 挂载信息载入系统
genfstab -U /mnt >> /mnt/etc/fstab
# 复查  
cat /mnt/etc/fstab
```
### 2.6 &进入新系统
arch-chroot /mnt
*********************************************************************
### 2.7 ********root密码/网络/文本编辑器*********************************
&安装文本编辑器 与网络管理【编辑后 ctrl + o 回车保存  ctrl + x 退出】
pacman -S  nano networkmanager
&开机自启网络
systemctl enable  NetworkManager
&设置 root 密码
passwd root
******************************************************
### 2.8 ******************建立启动引导***********************************************
```bash
&安装 grub 【双系统 记得命令尾部 空格后  在加上 os-prober】
pacman -S grub efibootmgr os-prober
&执行命令【--bootloader-id= 是自定义名 在efi里面显示 一般也看不到】
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Arch
显示"Installation finished. No error reperted" 是正常输出
&【不明觉厉的小优化】
【仅双系统需要 取消此配置文件最后一行 GRUB_DISABLE_OS_PROBER=false 前面的# 号后再保存】
cd /
 nano /etc/default/grub
去掉 GRUB_CMDLINE_LINUX_DEFAULT 一行中最后的 quiet 参数
把 loglevel 的数值从 3 改成 5。这样是为了后续如果出现系统错误，方便排错
加入 nowatchdog 参数，这可以显著提高开关机速度
【例子：GRUB_CMDLINE_LINUX_DEFAULT="loglevel=5 nowatchdog"】
&最后生成 GRUB 所需的配置文件
grub-mkconfig -o /boot/grub/grub.cfg
&继续操作命令
exit              # 退回安装环境
umount -R /mnt    # 卸载新分区
reboot            # 重启
```

### 2.9 **********联网***********************************
```bash
&使用 nmtui 来配置网络
nmtui
&再次检查网络情况
ping bing.com
```
************************************************************
### 2.10 ******************新建用户***************************************
```bash
【root 用户是隐藏的，安装图形界面需要设置可以提权的 普通用户】
&通过以下命令添加用户，比如新增加的用户叫 fufumi
useradd -m -G wheel -s /bin/bash fufumi
&根据提示设置新用户 myusername 的密码
passwd  fufumi
&设置权限
 nano /etc/sudoers
找到如下这样的一行，把前面的注释符号 # 去掉：
#%wheel ALL=(ALL:ALL) ALL
保存
```
*******************************************************************
### 2.11 ********安装图形化niri桌面以及必要配套*************
```bash
pacman -S sddm  niri   alacritty fuzzel  thunar  xwayland-satellite  egl-wayland
#执行这个命令后会有选项  建议先输入 2  在输入  1  是sddm 的note 字体和niri 最小框架
systemctl enable  sddm
#安装完图形桌面后可能遇到重启黑屏，主要是没有装显卡驱动，可以这个时候就装显卡驱动，或者黑屏了 通过ctrl+alt+F2～F6 进入tty终端可以装，我只遇到过一次，所以后来就没在这装显卡驱动了
我nvidida 卡是直接 
 #nvidia  显卡驱动【二选一命令】 
sudo pacman -S nvidia-dkms nvidia-utils nvidia-settings
sudo pacman -S nvidia nvidia-utils nvidia-settings
装的
#最后重启
reboot
```
********************************************************
### 2.12 关于虚拟机的内容
```bash
***VMware SSH**********************************************
*启动UEFI:虚拟机目录  Arch.vmx   命令加入到第三行保存
firmware="efi" 
*虚拟机插件  自动缩放和传输文件（没成功）
sudo pacman -Sy open-vm-tools
sudo systemctl enable --now vmtoolsd.service
sudo systemctl enable --now vmware-vmblock-fuse.service
*SSH 是否开启		
sudo systemctl status sshd
*启动SSH 
sudo systemctl status sshd
*修改SSH配置（nano  ctrl+q 搜索 继续按 在空白回车 搜索下一个）
sudo nano /etc/ssh/sshd_config
PermitRootLogin yes
PasswordAuthentication  yes
*配置完成后，重启SSH服务以应用更改：
sudo systemctl restart sshd
*设置root连接密码  查看虚拟机ip
passwd
ip a 
*powershell 连接 SSH
ssh 用户名@Arch的ip
*连接不上警告运行下列命令，再连接
ssh-keygen -R 想要访问的IP地址
*扩展：安装SSH 和启动
pacman -S openssh
systemctl start sshd
```
### 2.13 ************先设置thunar 文件管理器能挂载************
```bash
#就可以复制文档进来直接粘贴
sudo pacman -S thunar-volman gvfs
sudo systemctl enable udisks2.service
#thunar 插件
sudo pacman -S thunar-volman gvfs thunar-archive-plugin file-roller ffmpegthumbnailer tumbler libgsf webp-pixbuf-loader ristretto
********************汉化***************************
 # 安装谷歌开源字体及表情
sudo pacman -S  --needed noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-dejavu ttf-liberation
&编辑 locale.gen文件
cd /etc
sudo nano locale.gen
去掉 # en_US.UTF-8 UTF-8 以及 zh_CN.UTF-8 UTF-8 前#号后保存
【如果是需要设置双系统  可以此时将此配置最后一行提前就设置好 取消掉GRUB_DISABLE_OS_PROBER=false    前面的# 号后再保存】
&生成 locale 信息
sudo locale-gen
&su授权并创建 locale.conf文件写入数据
su
 echo  "LANG=zh_CN.UTF-8"  > /etc/locale.conf
reboot
```
***************************************************************************************
### 2.14 更换终端字体
```bash
sudo pacman -S  ttf-fira-code
#先mkdir 建立文件夹
mkdir   ~/.config/alacritty
#在建立并写入下列数据
sudo nano  ~/.config/alacritty/alacritty.toml
[font]
normal = { family = "FiraCode", style = "Regular" }
bold = { family = "FiraCode", style = "bold" }
italic = { family = "FiraCode", style = "italic" }
bold_italic = { family = "FiraCode", style = "bold italic" }
size = 12
[window.padding]
x = 15
y = 15
[selection]
save_to_clipboard = true
**********原文链接************************************************
https://github.com/tonsky/FiraCode/wiki/Linux-instructions
https://www.51cto.com/article/754779.html
```
*************************************************************************
### 2.15 设置北京时间 并系统时间同步到硬件时间
```bash
su
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc
```
*************************************************************
### 2.16 ********************设置网络*********************************
```bash
&设置自定义主机名 会体现在命令行【不要包含特殊字符以及空格】
sudo nano /etc/hostname
&设置 host文件【两个Arch为刚刚 上面设置的主机名 】
sudo nano /etc/hosts
加入
127.0.0.1   localhost
::1         localhost
127.0.1.1   Arch.localdomain    Arch
```

### 2.17 **************声音固件**************************
```bash
sudo pacman -S  --needed sof-firmware alsa-firmware alsa-ucm-conf pipewire-pulse pipewire-alsa wireplumber
```

### 2.18 **********显卡驱动*************************************************
```bash
#inter cpu 核显驱动【刚开始可能找不到，最后添加cn源后再装】
 sudo pacman -S --needed mesa lib32-mesa vulkan-intel lib32-vulkan-intel
 #nvidia  显卡驱动【二选一命令】
sudo pacman -S nvidia-dkms nvidia-utils nvidia-settings
sudo pacman -S nvidia nvidia-utils nvidia-settings
#检测开源驱动是否运行,安装驱动后 应该没有输出
 lsmod | grep nouveau
```
******************************************************************
### 2.19 *********************** 输入法*********************
```bash
sudo pacman -S --needed fcitx5-im fcitx5-chinese-addons  fcitx5-qt fcitx5-pinyin-zhwiki fcitx5-configtool fcitx5-material-color
#执行后 直接回车 默认全部选择 不用输入数字会少装
#设置单行模式
在 输入法 点击拼音的旁边设置中，启用“在程序中显示预编辑文本”即可启用单行模式
# 诊断
fcitx5-diagnose
#配置输入法
sudo nano /etc/profile
#第一个启用了会有提示 ，新版chromium 已经支持，旧版可以增加启动参数
#实在不行可以试试
# --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime
#写入
#export GTK_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx
```
***************************************************************
### 2.20 *****************权限设置********************
#安装授权包
```bash
sudo pacman -S polkit  polkit-kde-agent
# 在niri 配置文件~/.config/niri/config.kdl加入下列
spawn-at-startup "/usr/lib/polkit-kde-authentication-agent-1"
```
*******************************************************************************
### 2.21 **********************家目录*********************************************
```bash
#  安装 【可以不生成 重启就自动生成 当前语言的了】
sudo pacman -S xdg-user-dirs
【如果已经有了 需要修改 需要先删除  ~/.config  下面的  user-dirs.locale  user-dirs.dirs 两个文件】
#运行生成中文的家目录
xdg-user-dirs-update
#或者生成英文的家目录
 LANG=en_US.UTF-8 xdg-user-dirs-update
******************************************************************
在 ～/.config/ user-dirs.dirs  可以修改路径
```
****************************************************************
### 2.22 **************双系统开机引导**************************************************
```bash
cd /
sudo nano /etc/default/grub
【需要 取消此配置文件最后一行 ！！！
 GRUB_DISABLE_OS_PROBER=false    前面的# 号后再保存】
#安装os-prober
sudo pacman -S os-prober
# 输入root密码 进入root权限
su
#查看 win 启动分区  分区名
lsblk
#挂载win引导启动分区
mount /dev/nvme0n1p1 /mnt
#建立引导项
os-prober
#生成
grub-mkconfig -o /boot/grub/grub.cfg
```
****************************************************
### 2.23 **************开启 32 位支持库与 Arch Linux 中文社区仓库**********
```bash
sudo nano /etc/pacman.conf
去掉 [multilib] 一节中 下列两行的前 # 号注释，来开启 32 位库支持
[multilib]
Include = /etc/pacman.d/mirrorlist
&【非必要操作 取消前#号】
之后在 [options] 下找到并取消注释：Color，启用彩色高亮；VerbosePkgLists，在安装或升级软件时显示详细变化；
在文档最后新启一行 结尾处加入下面的文字，来添加 archlinuxcn 源。推荐的镜像源一并列出：
[archlinuxcn]
Server = https://mirrors.bfsu.edu.cn/archlinuxcn/$arch
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Server = https://mirrors.hit.edu.cn/archlinuxcn/$arch
Server = https://repo.huaweicloud.com/archlinuxcn/$arch
&编辑退出后 此命令作为生效
pacman -Syyu
#【必要操作】最后执行安装 archlinuxcn 源所需的相关步骤
sudo pacman -S archlinuxcn-keyring
&安装yay 命令可以让用户安装 AUR 中的软件
sudo pacman -S yay
```

### 2.24 ****************蓝牙**********************
对于蓝牙及无线网卡，在 Linux 下推荐使用英特尔产品。博通以及瑞昱产品在兼容性，稳定性方面在 Linux 中表现很差，会带来很多不必要的麻烦，如在驱动，BLE 方面的支持很差或者没有。
如果你有蓝牙设备，需要安装蓝牙软件包并启用蓝牙服务。随后在系统设置中进行添加设备与连接即可。注意，文件传输功能现在需要额外安装包bluez-obex，其功能与 2024 年已从 bluez 包中分离出来。
&启动蓝牙（若有）通过以下命令开启蓝牙相关服务并设置开机自动启动：
```bash
sudo systemctl enable --now bluetooth
sudo pacman -S bluez bluez-utils bluez-obex
蓝牙任务栏
sudo pacman -S blueman
```
**************************************************************************
### 2.25 已经没用---代理
alias | grep prx
alias prx='export https_proxy=http://127.0.0.1:8888;export http_proxy=http://127.0.0.1:8888'
alias unprx='export https_proxy= ; export http_proxy='
#### 2.25.1 **************Clash Rev******************************************
```bash
其实可以直接装  sudo pacman -S clash-verge-rev
#如果是2.4.3版本 tun安装不了   可以先添加订阅，点击软件里面的退出，  然后在临时使用 sudo pacman -U  clash-verge-rev-autobuild.pkg.tar.zst  安装2.4.4的包覆盖后，
再安装tun 可能没变化,在重启正常就可以用了
2.4.4 的包https://wwug.lanzouq.com/ipswu3bcjggd
密码:5i5f
过一段时间更新更高版本 那就直接装正常没问题了
#或者AUR  或者离线包
yay -S clash-verge-rev-bin
Clash：
        https://www.clashverge.dev/
        https://github.com/clash-verge-rev/clash-verge-rev
#如果不行最好早准备好 pkg.tar.zst 文件安装
git clone  https://aur.archlinux.org/clash-verge-rev-bin.git
cd clash-verge-rev-bin
makepkg
#运行makepkg报错需要依赖  就直接sudo pacman -S  将缺失的依赖名放这后面先安装
#然后再运行makepkg  会生成 .pkg.tar.zst 后缀文件
#安装
sudo pacman -U  文件名.pkg.tar.zst
【或者直接 makepkg -si 安装】
```
*****************************************************************
********************************
### 2.26 文本编辑器 选择sublime-text4
```bash
yay -S sublime-text
```
*************************
### 2.27 *****************安装 paru************************
```bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```
****************************************************
### 2.28 **********安装dms 任务栏*****************************
```bash
直接一行脚本安装（选择自己的桌面 比如 niri  ala的终端）
curl -fsSL https://install.danklinux.com | sh
手动安装以及网站教程（自动不用管）
 https://danklinux.com/docs/dankmaterialshell/installation
#自启动
systemctl --user enable dms.service
安装 paru -S qt6ct-kde
sudo pacman -S  papirus-icon-theme breeze-icons adwaita-icon-theme
启用 Qt 主题：
请重启合成器会话以使环境更改生效。
打开设置 → 主题和颜色
切换应用 Qt 主题
查看图标使用的是否是 qt6ct
echo $QT_QPA_PLATFORMTHEME
重启dms的命令 让图标生效，
dms restart
#如果dms任务栏输入法图标缺失
可以在 /etc/environment 文件中加入
 QT_QPA_PLATFORMTHEME=qt6ct
 然后重启
#配置写入niri配置文件 /home/kongjue/.config/niri/config.kdl 开头就行
spawn-at-startup "bash" "-c" "wl-paste --watch cliphist store &"
spawn-at-startup "/usr/lib/polkit-kde-authentication-agent-1"
environment {
  XDG_CURRENT_DESKTOP "niri"
  QT_QPA_PLATFORM "wayland"
  ELECTRON_OZONE_PLATFORM_HINT "auto"
 QT_QPA_PLATFORMTHEME "qt6ct"
  QT_QPA_PLATFORMTHEME_QT6 "qt6ct"
}
layer-rule {
    match namespace="^quickshell$"
    place-within-backdrop true
}
layer-rule {
    match namespace="dms:blurwallpaper"
    place-within-backdrop true
}
window-rule {
    match app-id=r#"^org\.gnome\."#
    draw-border-with-background false
    geometry-corner-radius 12
    clip-to-geometry true
}
window-rule {
    match app-id=r#"^org\.wezfurlong\.wezterm$"#
    match app-id="Alacritty"
    match app-id="zen"
    match app-id="com.mitchellh.ghostty"
    match app-id="kitty"
    draw-border-with-background false
}
#这个是 非焦点的其他窗口会变得透明 不需要可以取消
window-rule {
    match is-active=false
    opacity 0.9
}
window-rule {
    geometry-corner-radius 12
    clip-to-geometry true
}
--------------------------------------------------------------------
#在配置原本的layout 增加 background-color
layout {
    background-color "transparent"
```
***************************************************************
### 2.29 *********thunar 在这里打开终端**************
```bash
sudo nano ~/.config/xfce4/helpers.rc
#写入下列两行配置
TerminalEmulator=alacritty
TerminalEmulatorDismissed=true
#下列命令无用 直接忽略
// exo-open --working-directory %f --launch TerminalEmulator
```
**************
### 2.30 #输入法词库有代理最后在装
```bash
yay  fcitx5-pinyin-sougou-dict
```
### 2.31 ***********sublime text 汉化**************
```bash
#在打开sublime text 里面  按键ctrl+shift+p  弹出框内输入 install
然后等一会 可能会报错  就重新打开  在重复上面操作
直到 弹出另一个 插件按住的弹出框  输入 chinese  安装第一个描述有中文的插件
```
*******************************************
### 2.32 ***************截图********************************
```bash
sudo pacman -S flameshot grim
【 修改一下设置
先右键任务栏火焰截图，打开配置 勾选自启动 就会自动生成配置文件 在添加下列内容】
调整 ~/.config/flameshot/flameshot.ini  内容
sudo nano  .config/flameshot/flameshot.ini
#追加下列两行内容
disabledGrimWarning=true
useGrimAdapter=true
之后,Flameshot 可以正常工作grim如预期。
真正的截图软件
yay gscreenshot
sudo pacman -S --needed wl-clipboard slurp  xdg-desktop-portal
#niri配置文件中写入快捷键binds,火焰截图延迟两秒，gsc区域截图到剪切板和gsc延迟3秒全屏截图
Mod+A{ spawn-sh  "flameshot gui -d 2000";}
Mod+S { spawn-sh "gscreenshot -s -c  --select-border-weight 1"; }
    Mod+Shift+S { spawn-sh "gscreenshot  -c -d 3"; }
项目地址 https://github.com/thenaterhood/gscreenshot
```
### 2.33 ***************SDDM 主题*****************************
```bash
#代理环境下  终端运行下列命令
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh
装好换绫波丽
sudo nano /usr/share/sddm/themes/silent/metadata.desktop
例子 其他都是注释的， rei.conf是非注释的：
ConfigFile=configs/rei.conf
;ConfigFile=configs/default.conf
; ConfigFile=configs/default-left.conf
; ConfigFile=configs/default-right.conf
; ConfigFile=configs/ken.conf
; ConfigFile=configs/silvia.conf
; ConfigFile=configs/catppuccin-latte.conf
; ConfigFile=configs/catppuccin-frappe.conf
; ConfigFile=configs/catppuccin-macchiato.conf
; ConfigFile=configs/catppuccin-mocha.conf
```
### 2.34 ***************应用切换器 fuzzel主题*****************
git clone https://github.com/dracula/fuzzel.git
克隆后会在home目录下生成fuzzel文件夹，直接连带文件夹 剪切到 ~/.config 中 就可以了
### 2.35 **********安装常用的火狐、或者chrome
#chrome 浏览器
```bash
yay  google-chrome
# chromium 浏览器（谷歌味没这么浓，但保留代理翻译，多一些测试功能）
sudo pacman -S  chromium
或者火狐？
sudo pacman -S firefox
```
******************************************************
### 2.36 安装 LocalSend  【局域网传输 不需要不装】
```bash
https://localsend.org/zh-CN
yay -S localsend-bin
安装 Feem 【局域网传输 不需要不装】
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install feem
```

### 2.37 安装snap 商店以及操作命令 无需要可不看
```bash
sudo snap install snap-store
snap --version
snap find <关键字或软件包名称>
snap info <软件包名称>
sudo snap install <软件包名称>
sudo snap remove <软件包名称>
sudo snap remove <软件包1> <软件包2>
sudo snap remove <软件包名称> --purge
sudo snap refresh <软件包名称> 更新
```

### 2.38 KCalc —— 科学计算器
sudo pacman -S kcalc
### 2.39 第三方网易云播放器 高颜值
yay -S yesplaymusic
### 2.40 另一个播放器
yay -S go-musicfox
安装完之后通过 musicfox 命令启动，快捷键可参考
https://github.com/go-musicfox/go-musicfox/blob/master/README.md#%E5%BF%AB%E6%8D%B7%E9%94%AE
### 2.41 推荐网站 arch 简明指南
https://arch.icekylin.online/
### 2.42 Android Studio 开发历史存档 请忽略
https://developer.android.google.cn/studio/archive
### 2.43 桌面全局圆角【配置中有的 只需要取消前面的 /-  之前的文档已添加】
```bash
window-rule {
    geometry-corner-radius 12
    clip-to-geometry true
}
***********************透明度***************
可以通过配置窗口规则来修改透明度，这里只匹配了终端窗口，使得终端窗口具有透明效果
window-rule {
    match app-id="Alacritty"
    opacity 0.9
}
需要配合 取消注释 prefer-no-csd
如果取消注释 prefer-no-csd不行就使用
window-rule {
    match app-id="Alacritty"
    opacity 0.9
    draw-border-with-background  false
}
match all
********边框**********
焦点窗口 边框颜色
focus-ring {
active-color "#FFFF37"  #01ffff
}
取消焦点环
    focus-ring {
        off
    }
添加边框
    border {
    //off
        width 2
    }
透明度博客
https://blog.csdn.net/gitblog_00628/article/details/151257962
********************************间隙***************************************************
layout {
    默认间隙宽度
    gaps 12
    通过负距离 左右贴边
     struts {
        left -12
        right -12
        // top 4
        // bottom 64
    }
#gaps  和 struts 配合好 可以丝滑让鼠标点击左右边缘可以切换到下一个窗口
gaps 间隙越宽 下一个屏幕往外挤开 容易点不到  ，struts 是屏幕内的窗口缩小保持设置值距离，以看得到下一个窗口的边最容易丝滑
间隙博客
https://blog.csdn.net/gitblog_00988/article/details/151269654
```
### 2.44 ****************关于字体但没用********************************
下载字体：
https://www.nerdfonts.com/#features
霞鹜文楷屏幕阅读版 https://github.com/lxgw/Lxgwwenkai-screen
https://github.com/subframe7536/maple-font
fc-cache -f -v
fc-list :lang=zh
usr/share/fonts
https://jichu4n.com/posts/how-to-set-default-fonts-and-font-aliases-on-linux/
**********************************************************************
### 2.45 非挂载硬盘断电
```bash
udisksctl power-off -b /dev/sda1
禁止升级 (个人需要  正常不用)
sudo nano /etc/pacman.conf
IgnorePkg   = linux-firmware   chromium   linux-firmware-amdgpu       20251linux-firmware-atheros  linux-firmware-broadcom   linux-firmware-cirrus  linux-firmware-intel     linux-firmware-mediatek     linux-firmware-nvidia      linux-firmware-other        linux-firmware-radeon       linux-firmware-realtek      linux-firmware-whence  linux-firmware-atheros
#另一个源仅记录
https://github.com/chaotic-aur
```
### 2.46 双系统时间不一致
Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1
### 2.47 关闭win10 搜索广告
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\explorer" /v DisableSearchBoxSuggestions /t reg_dword /d 1 /f
### 2.48 win10 任务栏透明
```
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAcrylicOpacity /t reg_dword /d 0 /f
 任务栏透明来源资料
https://zhuanlan.zhihu.com/p/152629320
需要修改注册表以下数据
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
修改TaskbarAcrylicOpacity为0，默认是没有的，请自己手动添加一个，类型为DWORD
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
如果存在UseOLEDTaskbarTransparency数据，将其修改为0，或者删除
重启explorer.exe
效果
这样无需第三方程序也能实现任务栏完全透明了
TaskbarAcrylicOpacity是explorer.exe用来控制任务栏透明度的一个选项，0为完全透明，从1开始会有磨砂效果，255为完全不透明，默认值为217(0xD9)
当UseOLEDTaskbarTransparency为1时，TaskbarAcrylicOpacity锁定为153(0x99)，手动修改无效
```
### 2.49 设置 DNS
一般来说，如今大多电脑连接的路由器是可以自动处理 DNS 的，如果你的路由器不能处理，则需要额外进行 DNS 的设置。同时，如果使用 ISP 提供的默认 DNS,你的网络访问记录将存在更大的，被泄露或被当局存储记录的风险。除此之外，使用 ISP 提供的 DNS 还有可能将某些服务解析至一些已经失效或劣化的服务器。即使你的网络环境可以自动处理 DNS 设置，我们还是建议你使用可信的国际通用 DNS 设置。如下的配置将固定使用谷歌的 DNS,但是网络访问延迟可能增加。在阅读完随后的代理设置一节后，你的 DNS 请求将均通过代理发送，这将在 DNS 发送方面最大限度的保障你的隐私和安全。
sudo  nano /etc/resolv.conf，删除已有条目，并将如下内容加入其中
nameserver 223.5.5.5
nameserver 114.114.115.115
nameserver 1.1.1.1
如果你的路由器可以自动处理 DNS,resolvconf 会在每次网络连接时用路由器的设置覆盖本机/etc/resolv.conf 中的设置，执行如下命令加入不可变标志，使其不能覆盖如上加入的配置[3][4]。
sudo chattr +i /etc/resolv.conf
如果需要编辑文件 需要取消一下锁定
sudo chattr -i /etc/resolv.conf
****************************************************
### 2.50 &视频 查看器安装
sudo pacman -S   mpv
obs
sudo pacman -S obs-studio
#【非必要软件 可选安装】
&使系统可以识别 NTFS exfat 格式的硬盘
sudo pacman -S ntfs-3g exfat-utils
**********************************************
### 2.51 *********安装JDK  21不需要忽略************************
yay amazon-corretto-21-bin
查看
archlinux-java status
设置默认
 archlinux-java set <JAVA_ENV_NAME>
https://aws.amazon.com/cn/corretto/


### 2.52 休眠到硬盘【需要已设置好 swap交换分区】
```bash
&查看 swap 分区 UUID 后续需要
lsblk -o name,mountpoint,size,uuid
&修改文件
sudo nano /etc/default/grub
找到 GRUB_CMDLINE_LINUX_DEFAULT 一行，在其值后添加类似如下数据（根据你自身的 UUID 确定，参数之间以空格分隔）：【个个参数空格分开 填入双引号内】
resume=UUID=6e0797ea-b6a6-4227-ad44-753d52d297ef
&生效
sudo grub-mkconfig -o /boot/grub/grub.cfg
&编辑
sudo nano /etc/mkinitcpio.conf
在 HOOKS 行添加 resume 值。注意，resume 需要加入在 udev 后。若使用了 LVM 分区，resume 需要加入在 lvm2 后：
&生效
sudo mkinitcpio -P
【使用命令  用来休眠电脑  断开电源 启动后还原到内存】
systemctl hibernate
下面感觉都不需要  聊胜于无  甚至不知道有没有问题
```
### 2.53 添加或修改取消关机等待90s
```

DefaultTimeoutStopSec=3s
记得删除行首井号注释，把时间改成一个较短的时间，比如 3 秒，这样等待的时间就会大大缩短了。
sudo nano /etc/systemd/system.conf
sudo systemctl daemon-reload
```

### 2.54 BBR 算法优化 网络速度
```bash
&查看自己的算法 以及检查是否是 bbr
sysctl net.ipv4.tcp_congestion_control
&启动bbr
sudo modprobe tcp_bbr
&新建编辑文件加入下列两行
sudo nano /etc/sysctl.d/30-bbr.conf
net.core.default_qdisc = cake
net.ipv4.tcp_congestion_control = bbr
```
-----------------------------
### 2.55 ipv6  隐私拓展 具体可看https://wiki.archlinuxcn.org/zh-tw/IPv6
```bash
&三个任意选一种查看 自己的网卡名
ls /sys/class/net
 ip link
iw dev
比如叫：wlp0s20f3 并且只有一个 按照下列写入，如果有多个 需要 nic1.wlp0s20f3 这样全部列举
wiki：
添加到 sudo nano /etc/sysctl.d/40-ipv6.conf
net.ipv6.conf.all.wlan0 = 2
net.ipv6.conf.default.wlan0 = 2
net.ipv6.conf.nic0.wlan0 = 2
-----------------------------------------
模板
net.ipv6.conf.all.use_tempaddr = 2
net.ipv6.conf.default.use_tempaddr = 2
net.ipv6.conf.nic0.use_tempaddr = 2
...
net.ipv6.conf.nicN.use_tempaddr = 2
```
--------------------------------------
### 2.56 随机 MAC 地址
```bash
可以编辑并加入下列 /etc/NetworkManager/conf.d/rand_mac.conf
[device-mac-randomization]
wifi.scan-rand-mac-address=yes
[connection-mac-randomization]
ethernet.cloned-mac-address=stable
wifi.cloned-mac-address=stable
wifi.scan-rand-mac-address 决定在 wifi 扫描时是否开启随机 MAC 地址，若需要固定的 MAC 地址，可以设为 no。ethernet.cloned-mac-address 和 wifi.cloned-mac-address 决定了连接有线网络和 wifi 网络时是否开启随机 MAC 地址，可用的值有：
指定的 MAC 地址，连接时使用手动指定的 MAC 地址；
permanent，不改变 MAC 地址；
preserve，在网卡激活后不改变 MAC 地址；
random，在每次连接时都使用随机 MAC 地址；
stable，在初次连接一个网络时使用随机 MAC 地址，之后每次连接相同的网络都使用相同的 MAC 地址。
修改完后重启 NetworkManager 服务生效。
```
------------------------------------
### 2.57 时间同步 【默认也还行 没操作】
```bash
systemd 自带了一个 systemd-timesyncd 服务，提供了简单的时间同步服务，若是没有特别需求，这个服务已经够用了。不过这个服务默认使用的是 Arch Linux 自己的 NTP 服务器，在国内访问较慢，有时会导致时间同步失败，为了更快地同步时间，可以选用其他的 NTP 服务器，我选用了中国 NTP 快速授时服务和中国计量科学研究院 NIM 授时服务的 NTP 服务器，编辑 /etc/systemd/timesyncd.conf，添加或编辑如下一行：
NTP=cn.ntp.org.cn ntp1.nim.ac.cn
然后重启 systemd-timesyncd.service，之后运行 timedatectl timesync-status 便可查看时间同步状态：
$ timedatectl timesync-status
       Server: 2001:da8:9000::130 (cn.ntp.org.cn)
Poll interval: 34min 8s (min: 32s; max 34min 8s)
         Leap: normal
      Version: 4
      Stratum: 1
    Reference: PTP
    Precision: 1us (-26)
Root distance: 45us (max: 5s)
       Offset: -2.957ms
        Delay: 31.415ms
       Jitter: 4.354ms
 Packet count: 18
    Frequency: -4.740ppm
可以看到这里 offset 只有不到 3 毫秒，还是很精准的
```

