# vim 基本命令

[toc]



## i 写入模式
    i插入之前、a插入之后、A行尾插入、I行首插入、o下行插入、O上行插入

## x 删除光标后一个字符

    d + ←→删除光标←→字符（d +3←）、dd删除一行（其实是剪切，p粘贴）

## y+ ←→复制光标←→字符 （y+3←）

## c 删除并进入写入模式、
    w 		光标向下移动一个词、
    cw 		删除一个词并进入写入模式、
    b		光标到上一个词 、
    ciw		词中删除一个词并进入写入模式，yi

## f 找词

## / 搜索、n下 N上
    【y i c d f 】
    esc 回到正常模式

## 文件操作
：w保存
：q退出vim
：source $MYVIMRC 刷新vim

## 光标移动
jkhl上下左右
## 分屏
    ：split 上下分屏 、
    ：vsplit 左右分屏 
    Q退出

## 键位映射(~/.vim/vimrc)

```bash
let mapleader=" "
syntax on 打开高亮
set number 显示行号
set norelativenumber  不显示相对行数,当前为0行,上下多少行
set wildmenu   ：命令补全
set wrap
set hlsearch  /搜索高亮
exec "nohlsearch" [没有高亮]
set cursorline 显示|竖线
set showcmd 显示输入的命令
set incsearch  一面输入一面高亮
set ignorecase 忽略大小写()
set smartcase 智能大小写(完全匹配大小写)
noremap a b [a键改b键]
noremap = nzz [=下一个关键字并作为中心点]
noremap - Nzz [-上一个关键字并作为中心点]
noremap <LEADER><CR> :nohlsearch<CR> [空格 + 回车 取消高亮]
map a b a键改b键
```



## 美化vim

### 插件

1. nerd-commmentator:注释和去注释

2. vim-surround:字符快速替换 

(1)单个修改: `cs”‘` 光标放在目标字符串内,输入cs”}

(2)批量修改: V选中需要修改行, `:norm $cs"''`

3. switch: True和False快速切换工具 `gs`

<img src="imgs/image-20210619210424694.png" alt="image-20210619210424694" style="zoom:50%;" />

4. Tabularize:等号对齐 `:Tabularize /=`

<img src="imgs/image-20210619210539655.png" alt="image-20210619210539655" style="zoom:50%;" />

==录制宏==

```bash
# 录制宏
qa   q开始录制,a绑定宏的按键
v}:Tabularize /=
# 调用宏
@a
```

5. SimpylFold: 代码折叠 `o`
6. Tagbar:函数和 变量列表查看 `T` 上下键跳转,回车直接跳到函数代码处,ctrl+o 返回之前的代码行,ctrl+i 返回到之前的函数处

<img src="imgs/image-20210619211053372.png" alt="image-20210619211053372" style="zoom:50%;" />

7. vim-signature:添加书签 `ma` m=mark标记,a为书签名, `m + space` 跳到下一个书签位置处 `ma`第二次取消标记
8. semshi:函数中选中变量全部高亮, 

<img src="imgs/image-20210619211651896.png" alt="image-20210619211651896" style="zoom:50%;" />

9. coc-rename: 批量变量重命名 `rn`  输入要修改的名

<img src="imgs/image-20210619211819326.png" alt="image-20210619211819326" style="zoom:50%;" />

10. coc-paste:剪切板 多次剪切后,打开剪切板可以选择粘贴

<img src="imgs/image-20210619212042611.png" alt="image-20210619212042611" style="zoom:50%;" />

11. coc- 函数引用位置查询 `gr`

![image-20210619212234847](imgs/image-20210619212234847.png)

12. Far: 查找函数引用插件 `:F math %` 

<img src="imgs/image-20210619212429268.png" alt="image-20210619212429268" style="zoom:47%;" />

13. 代码运行和执行  `r` 

自定义代码

14. Undotree:修改记录表 `L` 打开undotree `jk上下移动查阅`

<img src="imgs/image-20210619212823276.png" alt="image-20210619212823276" style="zoom:50%;" />

15. FZF:编辑模式下搜索打开文件 `ctrl + p`   

`ctrl + o` 上一个文件 `CTRL+ i` 上一个文件 进行文件间跳转

<img src="imgs/image-20210619212954451.png" alt="image-20210619212954451" style="zoom:50%;" />

16. NERDTree:文件树 `tt`  i 编辑文件, l分屏打开文件, h隐藏文件 E回到文件树,B书签 `,a` 新建文件

17. MarkdownPreview.nvim :`r` 打开浏览器同步编译

定义各种snippets简化markdown编写

`,1` 标题h1 `,f` 跳到下一段段首,换行

`,d` 行内代码段

![image-20210619214016649](imgs/image-20210619214016649.png)

![image-20210619213955584](imgs/image-20210619213955584.png)

`,p` 插入图片

<img src="imgs/image-20210619214125756.png" alt="image-20210619214125756" style="zoom:50%;" />

`,m` task list

<img src="imgs/image-20210619214257103.png" alt="image-20210619214257103" style="zoom:50%;" />

`,a` 插入链接

`,c` 插入代码块

- [ ]  vim-table-mode markdown表格格式化 `space +  tm` 打开,再次关闭

19. 近义词:`space + th` 

<img src="imgs/image-20210619214929316.png" alt="image-20210619214929316" style="zoom:50%;" />

## init.vim

vim-startify:进入vim的启动界面

<img src="imgs/image-20210619215502570.png" alt="image-20210619215502570" style="zoom:50%;" />

![image-20210619215149902](imgs/image-20210619215149902.png)

修改历史保留

![image-20210619215206496](imgs/image-20210619215206496.png)

打开终端

![image-20210619215227472](imgs/image-20210619215227472.png)

一键编译

<img src="imgs/image-20210619215303182.png" alt="image-20210619215303182" style="zoom:50%;" />

<img src="imgs/image-20210619215318994.png" alt="image-20210619215318994" style="zoom:50%;" />

<img src="imgs/image-20210619215356482.png" alt="image-20210619215356482" style="zoom:50%;" />

vim小裙子

<img src="imgs/image-20210619215618585.png" alt="image-20210619215618585" style="zoom:50%;" />

ariline状态栏

![image-20210619215657303](imgs/image-20210619215657303.png)

<img src="imgs/image-20210619215716448.png" alt="image-20210619215716448" style="zoom:50%;" />

NERDtree

<img src="imgs/image-20210619215740737.png" alt="image-20210619215740737" style="zoom:50%;" />

<img src="imgs/image-20210619215823801.png" alt="image-20210619215823801" style="zoom:50%;" />

coc

![image-20210619215901511](imgs/image-20210619215901511.png)

![image-20210619215944237](imgs/image-20210619215944237.png)

python 对齐

<img src="imgs/image-20210619220005814.png" alt="image-20210619220005814" style="zoom:50%;" />

markdown

<img src="imgs/image-20210619220034878.png" alt="image-20210619220034878" style="zoom:50%;" />

<img src="imgs/image-20210619220052621.png" alt="image-20210619220052621" style="zoom:50%;" />

python高亮 显示函数列表 表格自动格式化

![image-20210619220115479](imgs/image-20210619220115479.png)

文件查找

![image-20210619220201407](imgs/image-20210619220201407.png)

书签

<img src="imgs/image-20210619220221866.png" alt="image-20210619220221866" style="zoom:50%;" />

<img src="imgs/image-20210619220242442.png" alt="image-20210619220242442" style="zoom:67%;" />

undotree

![image-20210619220313317](imgs/image-20210619220313317.png)

多光标 快速选择同样的文本

![image-20210619220332234](imgs/image-20210619220332234.png)

近义词查找

![image-20210619220402044](imgs/image-20210619220402044.png)

startify 显示台

![image-20210619220417215](imgs/image-20210619220417215.png)

Far查找字符串

![image-20210619220450515](imgs/image-20210619220450515.png)

emmet html编写

![image-20210619220554068](imgs/image-20210619220554068.png)

自动编号

![image-20210619220620531](imgs/image-20210619220620531.png)





`gf` 打开光标处的文件
