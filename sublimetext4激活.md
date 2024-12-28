# Sublime Text V4189(2024.12.20) 激活方法(同步更新)

[丑的猪都傻眼了](https://blog.csdn.net/wangzhizhuo)![img](https://csdnimg.cn/release/blogv2/dist/pc/img/newUpTime2.png)已于 2024-12-27 15:58:40 修改

https://blog.csdn.net/wangzhizhuo/article/details/141190550

## 问题描述

- 2024.12.20 Sublime Text 更新了最新版本(V4189)，本文介绍该版本的激活注册方法。
- 2024.08.06 Sublime Text 更新版本(V4180)，本文激活注册方法同样适用。

> 激活过程无需第三方软件或替换原文件

------

## 下载地址

- 官方网址：https://www.sublimetext.com
- 更新日志：https://www.sublimetext.com/download
- V4189 64位：https://www.sublimetext.com/download_thanks?target=win-x64
- V4180 64位：https://download.sublimetext.com/sublime_text_build_4180_x64_setup.exe

## 激活方法

1. 未激活表现![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/3299130dca48493b947673092b0f9e1c.png)
2. 找到Sublime Text安装路径

> - 右键快捷方式→打开文件所在的位置
> - 默认安装路径：C:\Program Files\Sublime Text

1. 找到`sublime_text.exe`，拷贝一份副本，使用Sublime Text打开副本(或任意文本编辑软件都可以)![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/d63c67b6ec754db9a4d0ea5cbd00db6a.png)
2. 使用快捷键`Ctrl + H`打开搜索替换功能

> - 查找以下十六进制字段
>
> ```c
> 8079 0500 0f94 c2
> ```
>
> - 替换为
>
> ```c
> c641 0501 b200 90
> ```

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/ecaee568bc0746c79d6fe9bc126355ea.png)

1. 替换完成后使用快捷键`Ctrl + S`保存并关闭
2. 移除**原sublime_text.exe文件**(或改为其它名称备份)，然后将编辑后的副本文件名称修改为`sublime_text.exe`
3. 激活后表现
    ![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/2cc104bea081486792d3955646955193.png)

*以上方法仅供学习交流，请勿用于商业或非法用途，一切后果请用户自负。如果您喜欢该软件，请支持购买注册正版软件，以得到更好的正版服务。