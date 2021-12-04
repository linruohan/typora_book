# [vscode python开发插件推荐](https://www.cnblogs.com/liuyanhang/p/10984465.html)

 vscode作为一款好用的轻量级代码编辑器，不仅支持代码调试，而且还有丰富的插件库，可以说是免费好用，对于初学者来说用来写写python是再合适不过了。下面就推荐几款个人觉得还不错的插件，希望可以帮助大家更好的写代码，先上一张最终效果图。

 ![img](F:\Typora_book\typora_pic\1423526-20190606133059026-1990342693.png)

 

Python
    首先当然要推荐这个必备插件python了，提供了代码分析，高亮，规范化等很多基本功能，装好这个就可以开始愉快的写python了。

 ![img](F:\Typora_book\typora_pic\1423526-20190606133114571-1756031552.png)

 

 

vscode-icons
    vscode现在虽然已经自带了文件图标，但是作为一个颜控还是觉得略丑，这个插件提供各种图标就非常漂亮了，推荐给各位颜控。

 ![img](F:\Typora_book\typora_pic\1423526-20190606133136812-1017261798.png)

 

 

One Dark Pro  &  Brackets Light Pro 
    这两款主体是我比较喜欢的，一个深色主体一个亮色主体，可以换着来。

 

 ![img](F:\Typora_book\typora_pic\1423526-20190606133200238-1715927950.png)

![img](F:\Typora_book\typora_pic\1423526-20190606133213676-747831202.png)

 

 

filesize
    一款在左下角显示文件大小的插件，还是挺实用的

 ![img](F:\Typora_book\typora_pic\1423526-20190606133224096-1878281008.png)

 

 


Bracket Pair Colorizer
   代码颜色高亮一般只会帮你区分不同的变量，这款插件给不同的括号换上了不同的颜色，括号的多的时候非常实用。

 ![img](F:\Typora_book\typora_pic\1423526-20190606133235785-1598632377.png)

 

 

Anaconda Extension Pack
    这个插件就推荐给用anaconda的同学了，大大增强了代码提示功能。原始的代码提示基本只包含了python标准库，有了这个插件之后各种第三方库基本都能实现代码提示了，并且还会额外显示每个方法的帮助。

 ![img](F:\Typora_book\typora_pic\1423526-20190606133245115-2101212823.png)

 

 

Settings Sync
   这个插件可以实现同步你的vscode设置，包括setting文件，插件设置等，不过你要先有github的账户，因为它利用了github的token功能，相当于把这样文件上传到了你的github账户中，这样你就可以在其它的电脑上直接下载的配置文件了，不用再配置一次了，相当方便省事了。

 ![img](F:\Typora_book\typora_pic\1423526-20190606133300949-1652629549.png)

 

 

​    先推荐这么多，以后遇到好用的插件还会继续更新！

 

4.30更新

Path Autocomplete
   有时候程序需要读取文件，自己手动去复制文件路径还是比较麻烦的，不过有了这个插件就方便多了，它能自动感知当前目录下所有的文件，只需要你自己选择就好了。

 ![img](F:\Typora_book\typora_pic\1423526-20190606133325345-553646614.png)

VS code的常用python插件推荐，建议全部安装
以下插件建议全部安装，绝对都是最热门，最好用的插件

1. Python（必备）
VScode自带的官方插件

2. Anaconda Extension Pack
可以自动补全anaconda包中的属性名称

3. Code Spell Checker
单词拼写检查，非常推荐，有时候会拼错单词，这个不仅可以指出错误，还能提供正确单词的拼写方式。
安装好之后，选中拼写错误的单词，旁边出现黄色小灯泡，点击选择单词，直接替换。

4. Guides
提供缩进检查，有时候for, if 写多了，就分不清对应的列数，VScode虽然自带的有缩进检查，但是不明显，这个将缩进线显示为红色，非常醒目。

5. Settings Sync
将VScode的配置上传到github，以后换机器，重装系统，随时下载，不用重新找教程了

6. vscode-icons
文件图标主题，能够让你的各种文件一目了然，不用再去看扩展名，而且超级好看

7. SynthWave‘84
字体颜色主题，我个人非常喜欢的一套高亮字体方案

8. koroFileHeader
文件头注释（ctrl+alt+i） 和函数头注释（ctrl+alt+t）工具，一键生成头注释

点赞 2
------------------------------------------------
版权声明：本文为CSDN博主「yaologos」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/yaologos/article/details/94433516 

 

如何使vscode运行程序时在当前文件夹中打开终端？
vscode运行task,调试或者直接在终端运行文件时都是默认在vscode打开的文件夹中打开终端运行或者调试程序的，这时候存在的问题是，如果运行一个在子文件夹中需要读取文件的程序，按照其默认设置只能把文件放在主文件夹中，虽然也能通过cd之类的操作解决，但本着能省事就省事的原则，可以通过修改launch.json文件实现调试程序时在当前文件夹中打开终端运行程序，我的launch.json的文件如下：

{
"name": "Python",
"type": "python",
"request": "launch",
"stopOnEntry": false,
"pythonPath": "${config:python.pythonPath}",
"program": "${file}",
"cwd": "${fileDirname}",
"env": {},
"envFile": "${workspaceRoot}/.env",
"debugOptions": [
"WaitOnAbnormalExit",
"WaitOnNormalExit",
"RedirectOutput"
]
}
其实重点在于修改了cwd参数，有如下变量可以选择：

${workspaceRoot} the path of the folder opened in VS Code(VSCode中打开文件夹的路径)
${workspaceRootFolderName} the name of the folder opened in VS Code without any solidus (/)(VSCode中打开文件夹的路径, 但不包含"/")
${file} the current opened file(当前打开的文件)
${relativeFile} the current opened file relative to workspaceRoot(当前打开的文件,相对于workspaceRoot)
${fileBasename} the current opened file's basename(当前打开文件的文件名, 不含扩展名)
${fileDirname} the current opened file's dirname(当前打开文件的目录名)
${fileExtname} the current opened file's extension(当前打开文件的扩展名)
${cwd} the task runner's current working directory on startup()

这样设置cwd参数为${fileDirname} ，调试程序时就是直接在当前文件中打开终端了。至于其它方法我在网上找了很久，自己也尝试过，但只有这种是成功了，也只能安慰自己能用就行了。
\---------------------

原文：https://blog.csdn.net/hnshhshjq/article/details/80140401 