# i3wm的使用和配置

[toc]

## i3wm 安装

`sudo pacman -S i3`

登录时选中i3即可

### mod+<—- mod+—> 左右切换窗口

![image-20210620113021361](imgs/image-20210620113021361.png)

### mod + h/v 不同分屏

![image-20210620113046557](imgs/image-20210620113046557.png)

### mod + d 打开dmenu

### mod +t 全屏

## i3配置

`~/.config/i3/config`

### 设置mod键: win键

![image-20210620113351219](imgs/image-20210620113351219.png)

### 启动项

variety 壁纸

![image-20210620113415935](imgs/image-20210620113415935.png)

### 绑定按键

![image-20210620113624578](imgs/image-20210620113624578.png)

### 切换主窗口

![image-20210620113826605](imgs/image-20210620113826605.png)

### 控制音频大小

![image-20210620113944247](imgs/image-20210620113944247.png)

## polybar

```bash
# 卸载默认的i3-status
sudo pacman -R i3-status
# 安装polybar
sudo pacman -S polybar
```

### polybar配置

`./config/polybar/config`

![image-20210620114144492](imgs/image-20210620114144492.png)

### i3中启动polybar![image-20210620114300320](imgs/image-20210620114300320.png)

![image-20210620114326116](imgs/image-20210620114326116.png)

### mod + shift + r 重新加载i3wm 配置

 