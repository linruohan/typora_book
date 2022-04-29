# vim的分屏功能小记

[toc]



## 从shell启动vim打开多个文件并分屏显示：

```text
vim -on file1 file2
o为小写字母，水平分割，即上下分屏，n是分屏的个数（可缺省），后面是待打开的文件

vim -On file1 file2
O为大写字母，垂直分割，即左右分屏，n是分屏的个数（可缺省），后面是待打开的文件
```

## 在已经打开的vim中对文件进行分屏

```text
对光标所在的窗口进行上下分屏
:sp [file2]
或者 :split [file2]
ctrl + w s
# 后面不跟文件名是将当前文件垂直分屏;跟文件名是将新文件在垂直分屏中打开

对光标所在的窗口进行左右分屏
:vsp [file2]
或者 :vsplit [file2]
ctrl + w v

# 创建空白分屏
:new [file2]
```

## 不同窗口间的移动（可直接Ctrl + w + w 自动切换到另一个分屏）

```text
移动到光标左边的窗口
ctrl + w h
ctrl + w ←

移动到光标上边的窗口
ctrl + w k
ctrl + w ↑

移动到光标下边的窗口
ctrl + w j
ctrl + w ↓

移动到光标右边的窗口
ctrl + w l
ctrl + w →
```

## 关闭当前窗口

```text
ctrl + w c （不能用于最后一个分屏）
ctrl + w q  （可用于最后一个分屏）
:q

#取消其它分屏，只保留当前分屏
:only 

#关闭所有分屏
:qa
```



## 1，在一个窗口中，VIM 的小tab标签页命令：

 :tabnew [++opt选项] ［＋cmd］ 文件      建立对指定文件新的tab

 :tabc    关闭当前的tab
 :tabo    关闭所有其他的tab
 :tabs    查看所有打开的tab
 :tabp   前一个
 :tabn   后一个

一般使用标准模式下的 Ngt 来进行切换，这个很方便。另外，如果需要在当前的tab页中也可以打开多个文件，文件之间用 ctrl + 6 来切换。如果习惯了前一种方法，后面这种基本上是用不到了。

 

## 2，分屏

:vsplit 这个命令太长，没人用的。大家都用 :vsp ，:sp filename来分屏。

分屏的相关动作都是ctrl+w 开始的，然后再跟一个其他字母

ctrl+w = ：让左右上下各个分屏宽度，高度均等。

ctrl+w _(shift + -) :当前屏幕高度扩展到最大

ctrl+w |(shift + \) :当前屏幕宽度扩展到最大

ctrl+w c：关闭当前屏幕

有了以上3个基本够了。