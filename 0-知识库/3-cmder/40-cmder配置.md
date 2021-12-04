# 使用Cmder替换cmd，让开发更高效

![image-20191207195258979](D:\Topora_pic\image-20191207195258979.png) 

# 一、cmder

在做项目时，有些时候我想复制控制台上面的代码时，**cmd**有的时候复制粘贴很麻烦，**Cmder**则不会，并且**Cmder**可以分屏多开窗口，可以设置窗口颜色,字体大小，并且很多快捷键和谷歌浏览器操作类似,等等很多功能。

# 二、官网下载地址:

> [http://cmder.net/](https://links.jianshu.com/go?to=http%3A%2F%2Fcmder.net%2F)

##### 关于下载

进入官网以后，有**mini版**和**完整版**，建议完整版，完整版功能更齐全，还可以使用`git`，下载好解压文件包以后就可以使用。

![image-20191207195313741](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\image-20191207195313741.png) 

# 三、关于cmder的一些配置

#### 1. 配置环境变量:

在系统属性里面配置环境变量，将`Cmder.exe`所在文件路径添加至`Path`里

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\13479263-e2f1e706bf445886.webp) 

#### 2. 配置右键快捷启动:

以管理员身份打开`cmd`，执行以下命令即可，完了以后在任意地方点击右键即可使用cmder

```cpp
// 设置任意地方鼠标右键启动Cmder
Cmder.exe /REGISTER ALL
鼠标右键启动Cmder
```

![image-20191206222440043](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\image-20191206222440043.png) 

#### 3. 界面效果的设置

首先使用`windows+alt+p`进入界面设置
背景色设置

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\13479263-cd9f51de6a6464e6.webp)


字体设置

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\13479263-5d90f5c67e4be767.webp)


背景透明度

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\13479263-7b1f5ba987021346.webp)


隐藏标签栏

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\13479263-5ef33c025ac01d61.webp)


显示底部状态栏

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\13479263-be5705ebc73910bf.webp)


将Cmder默认的命令提示符`"λ"`改为`“$”`，
在`cmder\vendor`中的`clink.lua`内做如下修改"λ"替换成"$"

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\13479263-7de88efa37a7999b.webp)



# 四、关于Cmder的一些常用快捷键



```css
Tab       自动路径补全
Ctrl+T    建立新页签
Ctrl+W    关闭页签
Ctrl+Tab  切换页签
Alt+F4    关闭所有页签
Alt+Shift+1 开启cmd.exe
Alt+Shift+2 开启powershell.exe
Alt+Shift+3 开启powershell.exe (系统管理员权限)
Ctrl+1      快速切换到第1个页签
Ctrl+n      快速切换到第n个页签( n值无上限)
Alt + enter 切换到全屏状态
Ctr+r       历史命令搜索
Tab         自动路径补全
Ctrl+T      建立新页签
Ctrl+W      关闭页签
Ctrl+Tab    切换页签
Alt+F4      关闭所有页签
Alt+Shift+1 开启cmd.exe
Alt+Shift+2 开启powershell.exe
Alt+Shift+3 开启powershell.exe (系统管理员权限)
Ctrl+1      快速切换到第1个页签
Ctrl+n      快速切换到第n个页签( n值无上限)
Alt + enter 切换到全屏状态
Ctr+r       历史命令搜索
Win+Alt+P   开启工具选项视窗
```

# 五、关于中文乱码问题：

将下面的4行命令添加到cmder/config/aliases文件末尾,如果还是不行参考前面字体设置，将前面提到的字体设置里面的Monospace的复选框不选中。还有就是养成良好的编码习惯文件命名最好不要有中文。

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\36wexq52ly.png)

如上图，在tasks中添加一个task

- 名字为Ubuntu，这个名字随便你
- 下面的大框里面`set "PATH=%ConEmuBaseDirShort%\wsl;%PATH%" & %ConEmuBaseDirShort%\conemu-cyg-64.exe --wsl --distro-guid={ee577c3b-a228-43d0-9794-816762880988} -cur_console:pm:/mnt`。这里面的`9df562ee-848c-4af4-ab4e-aedad54ceba9`指的是Ubuntu的唯一标识符，如果重装了子系统，那么这个标识符实惠变得。可以在在注册表(regedit)中查找 `计算机\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss`。`win+R搜索regedit`。

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\dfw5r29l8s.png)

在常规里面设置刚刚的名字为默认的启动项。如果你要打开其他的，比如cmd，可以点窗口右下角的`+`，里面有所有的配置。

## 安装oh-my-zsh

在Ubuntu系统中使用命令行而不是win中

安装任何包之前一定要先更新！ `sudo apt-get update`

安装zsh `sudo apt-get install zsh`

安装oh-my-zsh `sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"`

安装成功

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\4lqf8gzae6.png)

如果 遇到证书类似问题 apt-get install ca-certificates

自动启动zsh `vim ~/.bashrc`或者`nano ~/.bashrc`（推荐使用）打开编辑`.bashrc`文件	，添加以下内容：

```javascript
if test -t 1; then
    exec zsh
fi
```

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\2g6plfs0a6.png)

如果你使用的是`vim ~/.bashrc`，编辑后使用`:wq`退出。

如果你使用的是`nano ~/.bashrc`，使用`Ctrl+Shift+X`保存并退出。

修改主题：

```javascript
nano ~/.zshrc

# 主题名字ys，你可以搜索其他的主题使用，ys挺好的
ZSH_THEME="ys"
```

修改以后保存。

终端字体补全 `sudo apt-get install fonts-powerline`

客户端字体补全 注意： 有些字符在windows 上无法显示，所以需要安装字体 [nerdfonts.com](http://www.lyt007.cn/nerdfonts.com)，选择 Hack

修改**cmder**字体为

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\7d7yz9cwnl.png)

当然，你也可以设置为其他你认为好看的字体。

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\tnbm9dd75h.png)

这个是我的配置的最后的效果，还设置了透明度以及背景什么的，你们也可以自己进行配置。

## 在VSCode上使用WSL

由于博主是做前端开发的，用的是VSCode所以这里说一下，怎么在VSCode上面使用。

在VSCode的设置文件中添加这一句

```javascript
"terminal.integrated.shell.windows": "C:\\\\Windows\\\\System32\\\\wsl.exe",
```

如果需要使用node，npm等工具，WSL里面是不能够直接使用windows自带的这些环境变量的，我们需要在WSL中安装，具体的安装方法可以google–`Ubuntu安装软件`

## 说在结尾

之前说的字体`fonts-powerline`，`Hack Nerd Font Mono`这个字体，其实还是挺好看的，大家可以使用，包括在PC上面也可以。这个字体可以使用Git下载`https://github.com/powerline/fonts`，不过这个实在是有点慢，这里我已经下载下来放在了[![YPSuperKey Checked](data:image/png;base64,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)这里](https://www.lanzous.com/i3ldpcj)。

下载下来以后使用`PowerShell`，到字体目录下，运行以下命令

```javascript
.\install.ps1
```

可能会遇到报错，此时先执行`set-Executionpolicy Remotesigned`

![img](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\8i7igeg8bz.png)

**关于启动时候报错** 有时候我们启动子系统的时候会报错，错误代码：**`0x800703fa`**

具体错误内容：**WslRegisterDistribution failed with error: 0x800703fa**

此时`win+R`在运行窗口中执行“services.msc”指令，在本地服务中重启 LxssManager 服务即可

## 参考文献

[1]. https://segmentfault.com/a/1190000016827068 [2]. https://blog.joaograssi.com/windows-subsystem-for-linux-with-oh-my-zsh-conemu/

本文参与[腾讯云自媒体分享计划](https://cloud.tencent.com/developer/support-plan)，欢迎正在阅读的你也加入，一起分享。

发表于 2019-07-31