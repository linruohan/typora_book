# GitBash：修改GitBash主题配色和字体

转载[weixin_30364147](https://me.csdn.net/weixin_30364147) 发布于2018-10-11 10:44:00 收藏

展开

打开GitBash,使用命令: cd ~ 

然后： vi .minttyrc 

使用下列内容替换已有内容：

```shell
Font=Fira Mono
FontHeight=13

ForegroundColour=131,148,150
BackgroundColour=0,43,54
CursorColour=220,50,47

Black=7,54,66
BoldBlack=0,43,54
Red=220,50,47
BoldRed=203,75,22
Green=133,153,0
BoldGreen=88,110,117
Yellow=181,137,0
BoldYellow=101,123,131
Blue=38,139,210
BoldBlue=131,148,150
Magenta=211,54,130
BoldMagenta=108,113,196
Cyan=42,161,152
BoldCyan=147,161,161
White=238,232,213
BoldWhite=253,246,227
BoldAsFont=yes
FontSmoothing=full
FontWeight=400
FontIsBold=no
Locale=C
Charset=UTF-8

Columns=110
Rows=26
CursorType=block
Term=xterm-256color
MiddleClickAction=extend
RightClickAction=paste
```

重启GitBash，最终效果：

## 控制台格式美化

**下载必要的文件**

- 将 [git-completion.bash](https://github.com/shaonianruntu/Git-setting) 保存在你的主目录（home）中（文件名为 git-completion.bash）。
- 将 [git-prompt.sh](https://github.com/shaonianruntu/Git-setting) 保存在你的主目录中（文件名为 git-prompt.sh）。
- 下载 bash_profile_course 文件，[bash_profile_course](https://github.com/shaonianruntu/Git-setting)。
- 如果你的主目录中已有一个名为 .bash_profile 的文件，则将 bash_profile_course 中的内容复制并粘贴到 .bash_profile 的底部。如果没有，将 bash_profile_course 移到你的主目录中，然后将其重命名为 .bash_profile。（可以使用 mv 指令）

**重新启动Git Bash**

必须关闭 Git Bash，然后重新打开它，这样所有更改才会生效。重新打开后，你将会看到：

![image-20191213225004905](F:\Typora_book\typora_pic\image-20191213225004905.png)

## 控制台字体美化

**雅黑Consolas混合字体下载**

这是一个 Yahei 和 Consolas 的混合字体，相当漂亮，很适合在Windows平台下编程使用。下面提供 Github 下载地址：[shaonianruntu/YaHei-Consolas-Hybrid-1.12](https://github.com/shaonianruntu/YaHei-Consolas-Hybrid-1.12) 。

**注册表配置**

- Win+R 输入 regedit 命令打开注册表。
- 在 [HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindows NTCurrentVersionConsoleTrueTypeFont] 设置：
  - “936”=”YaHei Consolas Hybrid”

 