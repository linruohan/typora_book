# flameshot截图工具的安装与快捷键设置

![img](https://csdnimg.cn/release/blogv2/dist/pc/img/original.png)

## flameshot简介

**有如下盛名**

- linux系统里面最好用的截屏工具
- 支持图形化截图
- 支持命令行截图

> v0.6.0及之后的版本就已经支持了插入字体的功能,但是需要去github上下载才可以使用

## 执行命令安装

```sh
sudo pacman -S flameshot
```

## 配置快捷键

- 打开设置
- 选择device
  ![在这里插入图片描述](https://img-blog.csdnimg.cn/20200501230715210.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NleHlsdW5h,size_16,color_FFFFFF,t_70)
- 选择键盘

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200501230222376.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NleHlsdW5h,size_16,color_FFFFFF,t_70)

- 配置快捷键
- 点击加号
- 然后command输入下面命令
- name随便填写即可

`flameshot gui`
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200501230630445.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NleHlsdW5h,size_16,color_FFFFFF,t_70)

## 命令行运行

```bash
## 1 开启捕捉界面
flameshot gui
## 2 开启捕捉并设置存储位置
flameshot gui -p /path/to/captures
## 3 开启全屏捕捉
flameshot full
## 4 开启配置界面
flameshot config
## 5 万能的man
man flameshot

1234567891011
```

## 延迟截屏

为解决无法截屏下拉菜单的问题，经过摸索后，本人采用的是延时截屏的命令行：

```
flameshot full -p /home/usr/ -d 2000
```

因为延迟2000ms，这期间我可以很从容的打开下拉菜单，然后等待截屏！

- 我们也可以像上面那样建立一个延迟截屏的快捷键

`flameshot full -p /home/usr/ -d 2000`
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200501231259125.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NleHlsdW5h,size_16,color_FFFFFF,t_70)