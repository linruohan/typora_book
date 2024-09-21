# git 显示中文和解决中文乱码

[toc]

## 1 **现象：**

`git status`查看有改动但未提交的文件时总只显示数字串，显示不出中文文件名，非常不方便。如下图：

![img](https://pic3.zhimg.com/80/v2-bc86ea90ae02e6b27713420b3d52bc3e_720w.webp)



## 2 **原因：**

在默认设置下，中文文件名在工作区状态输出，中文名不能正确显示，而是显示为八进制的字符编码。

## 3 **==解决办法：==**

### 3.1 设置git

将git配置文件 `core.quotepath`项设置为`false`。`quotepath`表示引用路径，加上`--global`表示全局配置

`git bash`终端输入命令：

```text
git config --global core.quotepath false
```

### 3.2 解决git bash 终端显示中文乱码 zh_CN + UTF-8

要注意的是，这样设置后，你的`git bash`终端也要设置成中文和`utf-8`编码。才能正确显示中文.

在`git bash`的界面中右击空白处，弹出菜单，选择`选项->文本->本地Locale`，设置为`zh_CN`，而旁边的字符集选框选为`UTF-8`。

![img](https://pic2.zhimg.com/80/v2-735f07fdbb0da3b73ac3678815026761_720w.webp)



### 3.3 修改.gitconfig配置文件,添加  git status不乱吗

```text
[gui]  
    encoding = utf-8  
[i18n]  
    commitencoding = utf-8  
[svn]  
    pathnameencoding = utf-8  
[core]
    quotepath = false 
```

编辑`etc\git-completion.bash`文件,在文件末尾增加以下内容：

```text
# 让ls命令能够正常显示中文
alias ls='ls --show-control-chars --color=auto' 
```

编辑`etc\inputrc`文件，修改`output-meta`和`convert-meta`属性值：

```text
set output-meta on  # bash可以正常输入中文  
set convert-meta off  
```

编辑`profile`文件，在文件末尾添加如下内容：

```text
export LESSHARESET=utf-8
```