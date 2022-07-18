# VSCode中Vim使用（详细）

[toc]



## [Vim](https://so.csdn.net/so/search?q=Vim&spm=1001.2101.3001.7020)基础

### 键映射

```json
{
  /* vim */
  "vim.incsearch": true,
  "vim.useSystemClipboard": true,
  // "vim.hlsearch": true, 对/字符串的搜索方式来说,搜索到的结果一直高亮显示,不设置这一项美观些
  "vim.easymotion": true, //  启用vim-easymotion
  "vim.leader": "<space>", //  easymotion中,leader键映射为空格键
  "vim.sneak": true, // 启用vim-sneak
  "vim.insertModeKeyBindings": [
    {
      "before": ["j", "j"],
      "after": ["<Esc>"]
    }
  ],
  "vim.normalModeKeyBindingsNonRecursive": [
    // 到行首^映射为H，到行尾$映射为L
    {
      "before": ["H"],
      "after": ["^"]
    },
    {
      "before": ["L"],
      "after": ["$"]
    },
    // easymotion快速跳转映射,s + <char>
    {
      "before": ["<leader>", "s"],
      "after": ["<leader>", "<leader>", "s"]
    },
    // leader+u/d 代替 Ctrl+u/d 使页面向上/下滚动半屏
    {
      "before": ["leader", "u"],
      "after": ["<C-u>"]
    },
    {
      "before": ["leader", "d"],
      "after": ["<C-d>"]
    },
    // 删到行首/行尾  暂时只能用leader + H/L，若dH/L会删除此处到代码开头/结尾
    {
      "before": ["leader", "H"],
      "after": ["d", "^"]
    },
    {
      "before": ["leader", "L"],
      "after": ["d", "$"]
    }
  ],
  // 可视模式
  "vim.visualModeKeyBindingsNonRecursive": [
    {
      "before": ["H"],
      "after": ["^"]
    },
    {
      "before": ["L"],
      "after": ["$"]
    }
  ],
  "vim.useCtrlKeys": true, //结合下面的"vim.handleKeys"配置
  "vim.handleKeys": {
    "<C-a>": false,
    "<C-f>": false,
    // 带有vim插件的vscode,它的Ctrl+w是由vscode控制，非vim插件扩展快捷键控制。若改为true,则就是了。
    "<C-w>": false
  }
}
12345678910111213141516171819202122232425262728293031323334353637383940414243444546474849505152535455565758596061626364656667
```

### 模式

普通模式 Normal 插入模式 [Insert](https://so.csdn.net/so/search?q=Insert&spm=1001.2101.3001.7020) 可视模式 Visual 命令模式 ： 替换模式Replace

![在这里插入图片描述](https://img-blog.csdnimg.cn/ca9da6d930fa41dfab56122bb23284e6.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bKB5pqW5oOF6ZW_,size_20,color_FFFFFF,t_70,g_se,x_16)
`注`：若配置了`"vim.sneak": true`则s与S就不起作用

### 光标移动

| 字符 | 单词                    | 行             | 跳转                 | 句和段   |
| ---- | ----------------------- | -------------- | -------------------- | -------- |
| h 左 | w下一个单词开头         | 0 行首         | f char 跳到char位置  | ( 到句首 |
| j 下 | b本单词或上一个单词开头 | ^ 行首非空字符 | F char 反向          | ) 到句尾 |
| k 上 | e本单词或下一个单词结尾 | $ 行尾         | t char char前一位置  | { 到段首 |
| l 右 | ge上一个单词结尾        | gg 首行        | T char char后一位置  | } 到段尾 |
|      | W长单词 E长单词 B长单词 | G 尾行         | ; 重复上次的跳转     |          |
|      |                         | ngg 第n行      | , 反向查找上次的查找 |          |

`%` 移动到与光标所在括号相对应的另一半括号上`(对小括号，中括号和大括号有用，尖括号无用)`
`注`：比较的全面，但是看每个人的习惯不同，惯用的就会不同。上述是普通模式和可视模式的光标移动，它们完全一致，由于插入模式下的光标移动快捷键和很多[VSCode](https://so.csdn.net/so/search?q=VSCode&spm=1001.2101.3001.7020)内置快捷键冲突，这里就不介绍了，在文章末尾有写

方便编辑和阅读代码的操作如下(不仅仅限于光标移动，包含tricks等)：

类型1
`zt` 屏幕滚动使得当前行成为屏幕的最上面一行
`zz` 中间一行
`zb` 最下面一行
`zc` 关闭代码块
`zo` 打开代码块
`za` 打开或关闭代码块

类型2
`Ctrl + 0`：跳转到侧边栏，并可以用jk上下移动，空格打开文件或者文件夹
`Ctrl + 2`：增加一个工作区栏，以此类推，`Ctrl + 1`：跳到第一个工作区栏
`Ctrl + N`：新建文件 `Ctrl + Shift + N`：新建文件夹（这两个在Settings -> Keyboard Shortcuts -> 搜索explorer.new -> 自定义
`l`：从侧边栏回到未跳转前的文件工作区，或者新打开的文件工作区
`gt`（go to tab）：跳到下一个标签页
`gT`（go to tab）：跳到上一个标签页
`ngt`（go to tab）：跳到第n个标签页

类型3
`gh`（go to hover）：悬浮查看一些文档，签名
`gd`（go to destination）：跳转到定义声明或具体描述的地方
`Ctrl + o`：回到跳转之前的地方 `Ctrl + i`：与之相反
`gb`：光标置于单词的任意位置，输入一个gb，就选中一相同的单词（想选中4个相同的单词就连续输入gb4次
`==`：格式化代码
`gcc`：注释本行代码
`gcnj`/`ngcj`：注释从本行和下方n行的代码
`gcnk`/`ngck`：注释从本行和上方n行的代码

### 编辑技巧

| 操作符opertator 4个                                     |
| ------------------------------------------------------- |
| d 剪切(delete)                                          |
| x 剪切光标所停留的那个字符 X 剪切光标所停留的前一个字符 |
| c 删除并进入插入模式(change)                            |
| y 复制(yink)                                            |

| 介词 2个   |
| ---------- |
| i 表示里面 |
| a 表示外面 |

| 名词 9个               |
| ---------------------- |
| 光标移动之字符 h j k l |
| 光标移动之单词 w b e…  |
| 光标移动之行 ^ $ ngg…  |
| 光标移动之跳转 f F …   |
| 光标移动之句段 ( {     |
| ( { [’`" 各种括号引号  |
| t 标签                 |
| a 全部                 |
| e 全文                 |

公式1：操作符

```
dd`：剪切一行 `3dd`/`d3d`：剪切包括本行在内的三行 `以此类推
```

公式2：操作符 + 名词(前五个)

`3dh`/`d3h`：剪切光标所停留字符的左三个字符 `3dj`/`d3j`：剪切光标所在行及下面三行
`db`：剪切光标所停留单词到开头
`dngg`：剪切本行到第n行
`dfn`：剪切到当前行到下一个n字符
`d{`：剪切到段落开头

公式3：操作符 + 介词 + 名词(重点后四个)

`diw` 剪切当前光标所停留单词，或输入`gbw`
`di(`：删除`( )`中的所有内容
`da(`：删除`( )`中同时包括`( )`的所有内容
`dit`：剪切标签对中的内容，不包含标签对
`dat`：剪切标签对中的内容，包含标签对
`yia`：这个我试了以下，在for…in和for…of里面可以复制，其它的暂且不知
`yie`：复制全文

| 其它操作符及编辑技巧 6个                                     |
| ------------------------------------------------------------ |
| rx 用字符x替换光标位置的字符 nrx 用x字符替换光标位置前的n个字符 R 进入替换模式 |
| p 粘贴到当前光标的右边/下一行 P 粘贴到当前光标的左边/上一行 np(nP) 重复粘贴内容n次 |
| << 向前缩进                                                  |
| >> 向后缩进                                                  |
| u 撤销操作                                                   |
| . 再次执行刚执行过的命令                                     |

`注`：上述展示的都是很常用的Vim普通模式下的编辑技巧

## 常用命令

相信尝试过上述的Vim基础后，用一段时间的你，一定能够掌握好适合的常用命令

`小技巧`：

1. Ctrl 键有时候可以用小拇指指根摁
2. VSCode内置的 `Alt + ↑/↓` 将当前`行或者块(visualmode选择即可)上/下移`
3. 大写字母可以使用 Shift + 字母

## 自带插件

vim-easymotion：Vim插件介绍里vim-easymotion有详细说明，常用的有以下（键映射中有）

![在这里插入图片描述](https://img-blog.csdnimg.cn/294a6c67f2e64b16a0e8f8e37c8b9798.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bKB5pqW5oOF6ZW_,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

vim-surround：同上，可以自己尝试，以下例子

> ```
> Old text                  Command     New text
> Hello world               vS"         "Hello world"
> "Hello world"             ds"         Hello world
> Hello world               ysiw[       [ Hello ] world
> Hello world               ysiw]       [Hello] world
> [Hello] world             cs]"        "Hello" world
> 
> "Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
> <div>Yo!*</div>           dst         Yo!
> <div>Yo!*</div>           cst<p>      <p>Yo!</p>
> 12345678910
> ```

vim-sneak：同上，和easymotion有些像，但是有自己的方便之处

## 其他

**切换大小写**

`~` 将光标下的字母改变大小写
`3~` 将光标位置开始的3个字母改变其大小写
`g~` 改变当前行字母的大小写，
`gUU` 将当前行的字母改成大写
`guu` 将当前行的字母改成小写
`gUaw或gUiw` 将光标下的单词改成大写
`guaw或gUaw` 将光标下的单词改成小写

**其它跳转方式**

/string，n下翻查询结果，N上翻查询结果，enter跳转（string代表你想查找的内容）

**插入模式下的光标移动**

个人习惯是，在插入模式下且移动的范围很小的时候，选择性的使用插入模式下的光标移动，它的原生vim中的快捷键如下（不过很多与VSCode内置快捷键是冲突的，我是直接使用↑/↓/←/→新手使用Vim先适应模式切换，暂且不用插入模式下的光标移动可能更锻炼一些）

| 快捷键   | 作用                         |
| -------- | ---------------------------- |
| Ctrl + p | up                           |
| Ctrl + n | down                         |
| Ctrl + b | left                         |
| Ctrl + f | right                        |
| Ctrl + a | 到行首                       |
| Ctrl + e | 到行尾                       |
| Ctrl + h | delete 1                     |
| Ctrl + w | delete back 1 word           |
| Ctrl + u | delete back to start of line |

## **屏幕滚动**

原生vim的快捷键如下

| 快捷键   | 功能       |
| -------- | ---------- |
| Ctrl + v | 向上滚屏   |
| Ctrl + e | 向下滚屏   |
| Ctrl + u | 向上滚半屏 |
| Ctrl + d | 向下滚半屏 |
| Ctrl + b | 向上滚整屏 |
| Ctrl + f | 向下滚整屏 |

# vscode + vim 全键盘操作高效搭配方案

## 基础知识vscode-vim

vscode-vim是一款vim模拟器，它将vim的大部分功能都集成在了vscode中，你可以将它理解为一个嵌套在vscode中的vim。

其实在vscode的扩展商店中，还有一个vscode neovim的插件也十分不错，但是相较于vscode-vim来说依然存在一些让我难以接受的缺点，比如visual模式下的选择并非真正的vscode选择等，基于种种原因我还是考虑使用vscode-vim，尽管它可能占用了更大的内存。

安装完成之后，需要做一些基础配置。

1）仅MAC用户，关闭MAC的重复键：

```text
 $ defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false  
```

2）设置相对行号，在settings.json中添加上以下配置项：

```text
 "editor.lineNumbers": "relative",
```

3）关闭自动传参建议和代码补全建议，使用按键手动触发（可选）：

```text
 "editor.parameterHints.enabled": false,
 "editor.quickSuggestions": false,
```

4）控制资源管理器中的键盘导航无法自动触发：

```text
 "workbench.list.automaticKeyboardNavigation": false,
```



## 配置文件

vscode-vim插件由于是一款模拟器，所以它的配置文件是放在settings.json文件中，而不是vimrc文件中，个人也并不推荐将配置放在vimrc文件中，因为这会导致多端同步变的复杂，尽管这款插件可以支持从vimrc文件中读取配置。

下面是一些我会在使用vscode-vim插件时配置的vim选项，直接放入到settings.json文件中即可：

```text
 {
   // 绑定vim前导键
   "vim.leader": "<space>",
   // 启用easymotion插件
   "vim.easymotion": true,
   // 启用系统粘贴板作为vim寄存器
   "vim.useSystemClipboard": true,
   // 由vim接管ctrl+any的按键，而不是vscode
   "vim.useCtrlKeys": true,
   // 突出显示与当前搜索匹配的所有文本
   "vim.hlsearch": true,
    // 普通模式下的非递归按键绑定
   "vim.normalModeKeyBindingsNonRecursive": [
   //在NORMAL模式下按下快捷键执行COMMAND的命令，如按下<C-n>后，取消高亮搜索
   {
       "before": [
         "<C-n>"
       ],
       "commands": [
         ":nohl"
       ]
     },
     {
       "before": [
         "<leader>",
         "g",
         "c"
       ],
       "commands": [
         "workbench.action.showCommands"
       ]
     },
   ],
    // 插入模式下的非递归按键绑定
   "vim.insertModeKeyBindings": [
//   在INSERT模式下使用jj退回到NORMAL模式
        {
       "before": [
         "j",
         "j"
       ],
       "after": [
         "<Esc>"
       ]
     },
   ],
   // 命令模式下的非递归按键绑定
   "vim.commandLineModeKeyBindingsNonRecursive": [],
   // 可视模式下的非递归按键绑定
   "vim.operatorPendingModeKeyBindings": [],
   // 下面定义的按键将交由vscode进行处理，而不是vscode-vim插件
   "vim.handleKeys": {
     "<C-a>": false,
     "<C-f>": false
   }
 }
```

> 注意！leader键只在代码编辑区域生效，它无法做到全vscode生效。

## 针对一些刚接触vscode不久的朋友，可能不知道怎么拿到vscode的热键映射命令，其实你可以从vsocde的键盘快捷键中复制命令ID获得。

![img](https://pic2.zhimg.com/80/v2-77f7e16b5c20f79d8972a84df73792c1_720w.jpg)

```text
 cmd + g c ： 显示命令面板
 cmd + g s ： 打开设置页面
 cmd + g k ： 打开热键映射
 cmd + g m ： 打开一个目录
 cmd + g f ： 打开一个文件
 cmd + g h ： 打开最近记录
 cmd + g n ： 新建vscode实例
 cmd + g q ： 关闭vscode示例
 
 cmd + f n ： 新建文件
 cmd + f o ： 打开文件
 cmd + f e ： 另存为文件
 cmd + f s ： 保存文件
 cmd + f w ： 保存所有文件
 cmd + f q ： 关闭文件
 cmd + f a ： 关闭所有文件
 
 cmd + n [ ： 切换侧边栏显示状态
 cmd + n 1 ： 显示文件资源管理器
 cmd + n 2 ： 显示TODO Tree
 cmd + n 3 ： 显示全局搜索
 cmd + n 4 ： 显示debug
 cmd + n 5 ： 显示版本控制
 cmd + n 6 ： 显示SQL Tools
 cmd + n 7 ： 显示Docker
 cmd + n 8 ： 显示测试
 cmd + n 9 ： 显示插件商店
 
 cmd + p ] ： 切换面板显示状态
 cmd + p 1 ： 显示问题
 cmd + p 2 ： 显示输出
 cmd + p 3 ： 显示终端
 cmd + p 4 ： 显示调试控制台
 cmd + p 5 ： 显示SQL CONSOLE
```

以下是编辑区域操作控制方案：

```text
 cmd + q ：关闭当前选项卡或分屏
 cmd + e ：聚焦在第一个选项卡中
 cmd + , ：切换到上一个选项卡
 cmd + . ：切换到下一个选项卡
 
 cmd + w s ：拆分一个上下分屏
 cmd + w v ：拆分一个左右分屏
 
 cmd + w k ：将光标向上移动1屏
 cmd + w j ：将光标向下移动1屏
 
 cmd + w h ：将光标向左移动1屏
 cmd + w l ：将光标向右移动1屏
```

代码控制区域：

```text
 cmd + h ： 触发帮助提示
 cmd + j ： 触发参数提示
 cmd + k ： 触发建议提示
 cmd + n ： 移动到下一个建议
 cmd + p ： 移动到上一个建议
 tab ： 选择下一个建议
 enter ： 选择当前建议
 
 cmd + alt + l ： 格式化代码（个人习惯）
 
 cmd + = ： 放大字体
 cmd + - ： 缩小字体
```

在settings.json中配置的代码控制区域热键方案：

```text
 jj ： 退出INSERT模式
 zz ： 切换代码折叠（原生vim的zz不是切换折叠）
 
 H ：跳转行首、取代^
 L ：跳转行尾、取代$
 
 g[ ： 跳转到上一个问题
 g] ： 跳转到下一个问题
```

## **我的配置文件**

以下是settings.json文件中关于代码编辑区的一些操作配置项：

```text
   "vim.normalModeKeyBindingsNonRecursive": [
     {
       "before": [
         "H"
       ],
       "after": [
         "^"
       ]
     },
     {
       "before": [
         "L"
       ],
       "after": [
         "$"
       ]
     },
     {
       "before": [
         "z",
         "z",
       ],
       "commands": [
         "editor.toggleFold"
       ]
     },
     {
       "before": [
         "g",
         "[",
       ],
       "commands": [
         "editor.action.marker.prevInFiles"
       ]
     },
     {
       "before": [
         "g",
         "]",
       ],
       "commands": [
         "editor.action.marker.nextInFiles"
       ]
     },
   ],
   // 插入模式下的非递归按键绑定
   "vim.insertModeKeyBindings": [
     {
       "before": [
         "j",
         "j"
       ],
       "after": [
         "<Esc>"
       ]
     },
   ],
   // 命令模式下的非递归按键绑定
   "vim.commandLineModeKeyBindingsNonRecursive": [],
   // 可视模式下的非递归按键绑定
   "vim.operatorPendingModeKeyBindings": [],
```

以下是keybindings.json文件，基本的键位设置就如同上面看到的一样，但是做了一些额外的限制条件，比如<C-a>和<C-c>以及<C-v>等vscode原生命令在代码编辑区域中非NORMAL模式下是不生效的：

### MAC配置文件

```text
 [
     // --- 全局命令
     // 显示命令面板
     {
         "key": "cmd+g c",
         "command": "workbench.action.showCommands"
     },
     // 打开设置页面
     {
         "key": "cmd+g s",
         "command": "workbench.action.openSettings"
     },
     // 打开热键映射
     {
         "key": "cmd+g k",
         "command": "workbench.action.openGlobalKeybindings"
     },
     // 打开一个目录
     {
         "key": "cmd+g m",
         "command": "workbench.action.files.openFolder"
     },
     // 打开一个文件
     {
         "key": "cmd+g f",
         "command": "workbench.action.files.openFile"
     },
     // 打开最近记录
     {
         "key": "cmd+g h",
         "command": "workbench.action.openRecent"
     },
     // 新建vscode实例
     {
         "key": "cmd+g n",
         "command": "workbench.action.newWindow"
     },
     // 关闭vscode实例
     {
         "key": "cmd+g q",
         "command": "workbench.action.closeWindow"
     },
     // --- 文件命令
     // 新建文件
     {
         "key": "cmd+f n",
         "command": "welcome.showNewFileEntries",
     },
     // 打开文件
     {
         "key": "cmd+f o",
         "command": "workbench.action.files.openFileFolder"
     },
     // 另存为文件
     {
         "key": "cmd+f e",
         "command": "workbench.action.files.saveAs"
     },
     // 保存文件
     {
         "key": "cmd+f s",
         "command": "workbench.action.files.save"
     },
     // 保存所有文件
     {
         "key": "cmd+f w",
         "command": "workbench.action.files.saveAll"
     },
     // 关闭文件
     {
         "key": "cmd+f q",
         "command": "workbench.action.closeActiveEditor"
     },
     // 关闭所有文件
     {
         "key": "cmd+f a",
         "command": "workbench.action.closeAllEditors"
     },
     // -- 侧边栏命令
     // 切换侧边栏显示状态
     {
         "key": "cmd+n [",
         "command": "workbench.action.toggleSidebarVisibility"
     },
     // 显示文件资源管理器
     {
         "key": "cmd+n 1",
         "command": "workbench.files.action.focusFilesExplorer"
     },
     // 显示TODO Tree
     {
         "key": "cmd+n 2",
         "command": "todo-tree-view.focus"
     },
     // 显示全局搜索
     {
         "key": "cmd+n 3",
         "command": "workbench.action.replaceInFiles",
     },
     // 显示debug
     {
         "key": "cmd+n 4",
         "command": "workbench.view.debug",
         "when": "viewContainer.workbench.view.debug.enabled"
     },
     // 显示版本控制
     {
         "key": "cmd+n 5",
         "command": "workbench.view.scm",
         "when": "workbench.scm.active"
     },
     // 显示SQL Tools
     {
         "key": "cmd+n 6",
         "command": "workbench.view.extension.sqltoolsActivityBarContainer"
     },
     // 显示Docker
     {
         "key": "cmd+n 7",
         "command": "workbench.view.extension.dockerView"
     },
     // 显示测试
     {
         "key": "cmd+n 8",
         "command": "workbench.view.testing.focus"
     },
     // 显示插件商店
     {
         "key": "cmd+n 9",
         "command": "workbench.view.extensions",
         "when": "viewContainer.workbench.view.extensions.enabled"
     },
     // --- 面板命令
     // 切换面板显示状态
     {
         "key": "cmd+p [",
         "command": "workbench.action.togglePanel"
     },
     // 显示问题
     {
         "key": "cmd+p 1",
         "command": "workbench.panel.markers.view.focus"
     },
     // 显示输出
     {
         "key": "cmd+p 2",
         "command": "workbench.action.output.toggleOutput",
         "when": "workbench.panel.output.active"
     },
     // 显示终端
     {
         "key": "cmd+p 3",
         "command": "workbench.action.terminal.toggleTerminal",
         "when": "terminal.active"
     },
     // 显示调试控制台
     {
         "key": "cmd+p 4",
         "command": "workbench.debug.action.toggleRepl",
         "when": "workbench.panel.repl.view.active"
     },
     // 显示SQL CONSOLE
     {
         "key": "cmd+p 5",
         "command": "workbench.view.extension.sqltoolsPanelContainer"
     },
     // --- 编辑区命令
     // 关闭当前选项卡或分屏
     {
         "key": "cmd+q",
         "command": "workbench.action.closeActiveEditor"
     },
     // 聚集在第一个选项卡中
     {
         "key": "cmd+e",
         "command": "workbench.action.focusFirstEditorGroup"
     },
     // 切换到上一个选项卡
     {
         "key": "cmd+,",
         "command": "workbench.action.previousEditor"
     },
     // 切换到下一个选项卡
     {
         "key": "cmd+.",
         "command": "workbench.action.nextEditor"
     },
     // 拆分一个上下分屏
     {
         "key": "cmd+w s",
         "command": "workbench.action.splitEditorDown"
     },
     // 拆分一个左右分屏
     {
         "key": "cmd+w v",
         "command": "workbench.action.splitEditor"
     },
     // 将光标向上动1屏
     {
         "key": "cmd+w k",
         "command": "workbench.action.focusAboveGroup"
     },
     // 将光标向下动1屏
     {
         "key": "cmd+w j",
         "command": "workbench.action.focusBelowGroup"
     },
     // 将光标向左移动1屏
     {
         "key": "cmd+w h",
         "command": "workbench.action.focusLeftGroup"
     },
     // 将光标向右移动1屏
     {
         "key": "cmd+w l",
         "command": "workbench.action.focusRightGroup"
     },
     // --- 代码编辑命令
     // 触发帮助提示
     {
         "key": "cmd+h",
         "command": "editor.action.showHover",
         "when": "editorTextFocus"
     },
     // 触发参数提示
     {
         "key": "cmd+j",
         "command": "editor.action.triggerParameterHints",
         "when": "editorHasSignatureHelpProvider && editorTextFocus"
     },
     {
         "key": "cmd+j",
         "command": "closeParameterHints",
         "when": "editorFocus && parameterHintsVisible"
     },
     // 触发建议提示
     {
         "key": "cmd+k",
         "command": "editor.action.triggerSuggest",
         "when": "editorHasCompletionItemProvider && textInputFocus && !editorReadonly"
     },
     {
         "key": "cmd+k",
         "command": "hideSuggestWidget",
         "when": "suggestWidgetVisible && textInputFocus"
     },
     // 移动到下一个建议
     {
         "key": "cmd+n",
         "command": "selectNextSuggestion",
         "when": "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus"
     },
     // 移动到上一个建议
     {
         "key": "cmd+p",
         "command": "selectPrevSuggestion",
         "when": "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus"
     },
     // 格式化代码
     {
         "key": "cmd+alt+l",
         "command": "editor.action.formatDocument",
         "when": "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor"
     },
     // 放大字体
     {
         "key": "cmd+=",
         "command": "editor.action.fontZoomIn"
     },
     // 缩小字体
     {
         "key": "cmd+-",
         "command": "editor.action.fontZoomOut"
     },
     // --- window 用户删除以下重映射，这里是为MAC用户准备的
     {
         "key": "cmd+r",
         "command": "extension.vim_ctrl+r",
         "when": "editorTextFocus && vim.active && vim.use<C-r> && !inDebugRepl"
     },
     {
         "key": "ctrl+r",
         "command": "-extension.vim_ctrl+r",
         "when": "editorTextFocus && vim.active && vim.use<C-r> && !inDebugRepl"
     },
     {
         "key": "cmd+a",
         "command": "extension.vim_ctrl+a",
     },
     {
         "key": "ctrl+a",
         "command": "-extension.vim_ctrl+a",
         "when": "editorTextFocus && vim.active && vim.use<C-a> && !inDebugRepl"
     },
     {
         "key": "cmd+x",
         "command": "extension.vim_ctrl+x",
     },
     {
         "key": "ctrl+x",
         "command": "-extension.vim_ctrl+x",
         "when": "editorTextFocus && vim.active && vim.use<C-x> && !inDebugRepl"
     },
     {
         "key": "cmd+u",
         "command": "extension.vim_ctrl+u",
         "when": "editorTextFocus && vim.active && vim.use<C-u> && !inDebugRepl"
     },
     {
         "key": "ctrl+u",
         "command": "-extension.vim_ctrl+u",
         "when": "editorTextFocus && vim.active && vim.use<C-u> && !inDebugRepl"
     },
     {
         "key": "cmd+d",
         "command": "extension.vim_ctrl+d",
         "when": "editorTextFocus && vim.active && vim.use<C-d> && !inDebugRepl"
     },
     {
         "key": "ctrl+d",
         "command": "-extension.vim_ctrl+d",
         "when": "editorTextFocus && vim.active && vim.use<C-d> && !inDebugRepl"
     },
     {
         "key": "cmd+i",
         "command": "extension.vim_ctrl+i",
         "when": "editorTextFocus && vim.active && vim.use<C-i> && !inDebugRepl"
     },
     {
         "key": "ctrl+i",
         "command": "-extension.vim_ctrl+i",
         "when": "editorTextFocus && vim.active && vim.use<C-i> && !inDebugRepl"
     },
     {
         "key": "cmd+o",
         "command": "extension.vim_ctrl+o",
         "when": "editorTextFocus && vim.active && vim.use<C-o> && !inDebugRepl"
     },
     {
         "key": "ctrl+o",
         "command": "-extension.vim_ctrl+o",
         "when": "editorTextFocus && vim.active && vim.use<C-o> && !inDebugRepl"
     },
     // --- 取消一些vim插件的额外功能
     {
         "key": "cmd+a",
         "command": "-extension.vim_cmd+a",
         "when": "editorTextFocus && vim.active && vim.use<D-a> && !inDebugRepl && vim.mode != 'Insert'"
     },
     {
         "key": "alt+cmd+down",
         "command": "-extension.vim_cmd+alt+down",
         "when": "editorTextFocus && vim.active && !inDebugRepl"
     },
     {
         "key": "alt+cmd+up",
         "command": "-extension.vim_cmd+alt+up",
         "when": "editorTextFocus && vim.active && !inDebugRepl"
     },
     {
         "key": "cmd+c",
         "command": "-extension.vim_cmd+c",
         "when": "editorTextFocus && vim.active && vim.overrideCopy && vim.use<D-c> && !inDebugRepl"
     },
     {
         "key": "cmd+v",
         "command": "-extension.vim_cmd+v",
         "when": "editorTextFocus && vim.active && vim.use<D-v> && vim.mode == ''CommandlineInProgress' !inDebugRepl' || editorTextFocus && vim.active && vim.use<D-v> && !inDebugRepl && vim.mode == 'SearchInProgressMode'"
     },
     {
         "key": "cmd+d",
         "command": "-extension.vim_cmd+d",
         "when": "editorTextFocus && vim.active && vim.use<D-d> && !inDebugRepl"
     },
     {
         "key": "cmd+left",
         "command": "-extension.vim_cmd+left",
         "when": "editorTextFocus && vim.active && vim.use<D-left> && !inDebugRepl && vim.mode != 'Insert'"
     },
     {
         "key": "cmd+right",
         "command": "-extension.vim_cmd+right",
         "when": "editorTextFocus && vim.active && vim.use<D-right> && !inDebugRepl && vim.mode != 'Insert'"
     },
     // --- 取消或更改一些vscode键位
     // cmd+a全选功能在非INSERT模式下不生效
     {
         "key": "cmd+a",
         "command": "editor.action.selectAll",
         "when": "vim.mode != 'Normal' && vim.mode != 'Visual' && vim.mode != 'VisualLine' && vim.mode != 'VisualBlock' && vim.mode != 'CommandlineInProgress'"
     },
     {
         "key": "cmd+a",
         "command": "-editor.action.selectAll"
     },
     // cmd+c或者cmd+v功能在非INSERT模式下不生效
     {
         "key": "cmd+c",
         "command": "-editor.action.clipboardCopyAction"
     },
     {
         "key": "cmd+v",
         "command": "-editor.action.clipboardPasteAction"
     },
     {
         "key": "cmd+c",
         "command": "-execCopy"
     },
     {
         "key": "cmd+c",
         "command": "execCopy",
         "when": "vim.mode != 'Normal' && vim.mode != 'Visual' && vim.mode != 'VisualLine' && vim.mode != 'VisualBlock' && vim.mode != 'CommandlineInProgress'"
     },
     {
         "key": "cmd+v",
         "command": "-execPaste",
     },
     {
         "key": "cmd+v",
         "command": "execPaste",
         "when": "vim.mode != 'Normal' && vim.mode != 'Visual' && vim.mode != 'VisualLine' && vim.mode != 'VisualBlock' && vim.mode != 'CommandlineInProgress'"
     },
 ]
```

## **资源管理配置**

默认的资源管理配置只包含了上下左右移动等基础命令，所以我们需要手动添加新增、删除、剪切、刷新等操作命令，它们仅在资源管理器中生效：

```text
 j ： 向下移动
 k ： 向上移动
 space ： 打开文件或目录
 
 // 手动新增：
 
 i ： 新增文件
 o ： 新增目录
 r ： 刷新目录
 a ： 重命名文件或目录
 d ： 删除文件或目录
 x ： 剪切文件或目录
 y ： 复制文件或目录
 p ： 粘贴文件或目录
```

在keybindings.json文件中加入以下配置项：

```text
     // --- 资源管理器中对文件或目录的操作
     // 新建文件
     {
         "key": "i",
         "command": "explorer.newFile",
         "when": " explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus "
     },
     // 新建目录
     {
         "key": "o",
         "command": "explorer.newFolder",
         "when": " explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus "
     },
     // 刷新资源管理器
     {
         "key": "r",
         "command": "workbench.files.action.refreshFilesExplorer",
         "when": " explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus "
     },
     // 重命名文件或目录
     {
         "key": "a",
         "command": "renameFile",
         "when": " explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus "
     },
     // 删除文件或目录
     {
         "key": "d",
         "command": "deleteFile",
         "when": " explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus "
     },
     // 剪切文件或目录
     {
         "key": "x",
         "command": "filesExplorer.cut",
         "when": "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
     },
     // 复制文件或目录
     {
         "key": "y",
         "command": "filesExplorer.copy",
         "when": "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !inputFocus"
     },
     // 粘贴文件或目录
     {
         "key": "p",
         "command": "filesExplorer.paste",
         "when": "explorerViewletVisible && filesExplorerFocus && !explorerResourceReadonly && !inputFocus"
     },
```



## **输入法切换**

如果你在INSERT模式下使用中文输入法进行编辑，当ESC到NORMAL模式下后，它将依然保持中文输入法，这会使我们需要频繁的使用ctrl+shift或者cmd+space进行输入法切换，非常麻烦。

为了解决这个问题，你必须先在你的计算机上安装一个[im-select](https://link.zhihu.com/?target=https%3A//github.com/daipeihust/im-select)脚本（根据官方文档来看，貌似只有mac和windows平台下存在这个问题）：

```text
 $ curl -Ls https://raw.githubusercontent.com/daipeihust/im-select/master/install_mac.sh | sh
```

这个脚本有2个作用，当你输入im-select后它将获取当前输入法，当你输入im-select xxx后它将切换至xxx输入法。

首先你需要先切换到英文输入法中到终端执行im-select命令，并把结果保存下来：

```text
 $ im-select
 com.apple.keylayout.ABC
```

然后再到settings.json中加入以下配置项即可完成输入法在INSERT模式以及NORMAL模式下的自动切换：

```text
   // 自动切换输入法
   "vim.autoSwitchInputMethod.enable": true,
   "vim.autoSwitchInputMethod.defaultIM": "com.apple.keylayout.ABC",  // 这里输入你刚刚获得的英文输入法名称
   "vim.autoSwitchInputMethod.obtainIMCmd": "/usr/local/bin/im-select",
   "vim.autoSwitchInputMethod.switchIMCmd": "/usr/local/bin/im-select {im}"
```



## 内置插件

vsocde-vim中内置了很多插件，使用它们可以快速的进行某一些操作。

1）vim-esaymotion插件，使用它之前你必须在settings.json中加入下面这一行：

```text
 "vim.easymotion": true,
```

它的作用是通过以下的按键组合，你可以快速的定位到任何你想修改的行中：

```text
 <leader><leader>s<char>
```

2）vim-surround插件，如果你想修改、或者删除单引号和双引号，它带给你的体验将是无与伦比的，以下是它的语法：

```text
 ds<existing>
 cs<existing><desired>
```

示例如下：

```text
 # 删除以下的[]
 [1, 2, 3] -> ds[
 
 # 将以下的[]修改为()
 [1, 2, 3] -> cs[(
```

3）vim-commentary插件，该插件能够快速的利用键盘进行行或者块的注释，它内部其实是调用了vscode的注释API：

```text
 gcc ：行注释
 gCC ：块注释
```



## 便捷操作

除此之外，vscode-vim插件也额外提供了一些非常多的快捷键用于编辑操作：

```text
 gd ： 跳转到函数定义或引用处，搭配cmd+i/cmd+o查看源码很方便
 gh ： 触发帮助提示
 gb ： 开启多光标模式，选中和当前单词相同的单词
```



## 推荐插件

有一些朋友可能和我一样安装了[google-translate](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dhancel.google-translate)插件或者[comment-translate](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dintellsmi.comment-translate)插件来查看源代码注释的翻译结果，这个时候你将会遇到一些问题。

如一次性选择翻译的文本太长，vscode的hover无法支持scroll的快捷键滚动操作，你只能通过鼠标滚轮进行hover窗口的滚动：



![动图封面](https://pic1.zhimg.com/v2-22dae510a107e6ef88fbe7166cde63c8_b.jpg)





该问题在vscode的github上多次被提到，这对全键盘操作用户来说是非常不友好的，可以参见[#69836](https://link.zhihu.com/?target=https%3A//github.com/microsoft/vscode/issues/69836)。

对此有一个折中的解决方案，安装一个[Doc View](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dbierner.docs-view)插件，将翻译结果放在侧边栏中，这样我们就有足够的空间来显示翻译结果了：



![img](https://pic2.zhimg.com/80/v2-7947085a0019c36937def19eb824c7a5_720w.jpg)



另外一个问题就是关于Error的提示信息，你可以自定义一些热键来快速查看Error，或者跟我一样安装一个[Error Lens](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dusernamehw.errorlens)插件。

如下图所示，有了该插件我们就能快速的查看到一些问题的提示信息了：



![img](https://pic2.zhimg.com/80/v2-14465a061fa548859a04423dc1d0e9d5_720w.jpg)



配合上面定义的g[或者g]热键，就可以快速的定位到某个错误并进行修改。





## 写在后面

为什么不选择使用vim来搭建一个IDE呢？

- 太麻烦、懒得折腾，vscode足够强大…

为什么不选择使用vscode neovim插件呢？

- visual模式不是vscode的真正选择，多端同步比vscode-vim麻烦是我没选择它的主要原因

vim真的很好用吗？

- 使用vim能治好你的vim崇拜症，但是vim并不是必须的

此外，网上搜了很多资料无一例外都是比较浅显的介绍了一下vsocode-vim插件就完了，但是真正让你能够搭配出一套全键盘使用方案的文章少之又少，所以这里就将我的折腾历程发了出来，很显然它比单纯的折腾vim要快很多。

## 参考文档

参考文档：

- [vscode 官方文档 按键](https://link.zhihu.com/?target=https%3A//code.visualstudio.com/docs/getstarted/keybindings%23_keyboard-shortcuts-editor)
- [vscode 官方文档 命令](https://link.zhihu.com/?target=https%3A//code.visualstudio.com/api/references/commands)
- [vscode-vim 官方文档](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dvscodevim.vim)
- [vscode-nvim 官方文档](https://link.zhihu.com/?target=https%3A//marketplace.visualstudio.com/items%3FitemName%3Dasvetliakov.vscode-neovim)
- [spacevim 官方文档](https://link.zhihu.com/?target=https%3A//spacevim.org/cn/documentation/)



## Windows热键

我在windows上进行了尝试，它令我感到惊叹。

vim插件不知为何在mac和linux上都有些许卡顿，但是windows上异常顺滑，下面是我的配置方案：

```text
[
    // --- 全局命令
    // 显示命令面板
    {
        "key": "ctrl+g c",
        "command": "workbench.action.showCommands"
    },
    // 打开设置页面
    {
        "key": "ctrl+g s",
        "command": "workbench.action.openSettings"
    },
    // 打开热键映射
    {
        "key": "ctrl+g k",
        "command": "workbench.action.openGlobalKeybindings"
    },
    // 打开一个目录
    {
        "key": "ctrl+g d",
        "command": "workbench.action.files.openFolder"
    },
    // 打开一个文件
    {
        "key": "ctrl+g f",
        "command": "workbench.action.files.openFile"
    },
    // 打开最近记录
    {
        "key": "ctrl+g h",
        "command": "workbench.action.openRecent"
    },
    // 新建vscode实例
    {
        "key": "ctrl+g n",
        "command": "workbench.action.newWindow"
    },
    // 关闭vscode实例
    {
        "key": "ctrl+g q",
        "command": "workbench.action.closeWindow"
    },
    // --- 文件命令
    // 新建文件
    {
        "key": "ctrl+f n",
        "command": "welcome.showNewFileEntries",
    },
    // 打开文件
    {
        "key": "ctrl+f o",
        "command": "workbench.action.files.openFileFolder"
    },
    // 另存为文件
    {
        "key": "ctrl+f e",
        "command": "workbench.action.files.saveAs"
    },
    // 保存文件
    {
        "key": "ctrl+f s",
        "command": "workbench.action.files.save"
    },
    // 保存所有文件
    {
        "key": "ctrl+f w",
        "command": "workbench.action.files.saveAll"
    },
    // 关闭文件
    {
        "key": "ctrl+f q",
        "command": "workbench.action.closeActiveEditor"
    },
    // 关闭所有文件
    {
        "key": "ctrl+f a",
        "command": "workbench.action.closeAllEditors"
    },
    // -- 侧边栏命令
    // 切换侧边栏显示状态
    {
        "key": "ctrl+n [",
        "command": "workbench.action.toggleSidebarVisibility"
    },
    // 显示文件资源管理器
    {
        "key": "ctrl+n 1",
        "command": "workbench.files.action.focusFilesExplorer"
    },
    // 显示TODO Tree
    {
        "key": "ctrl+n 2",
        "command": "todo-tree-view.focus"
    },
    // 显示全局搜索
    {
        "key": "ctrl+n 3",
        "command": "workbench.action.replaceInFiles",
    },
    // 显示debug
    {
        "key": "ctrl+n 4",
        "command": "workbench.view.debug",
        "when": "viewContainer.workbench.view.debug.enabled"
    },
    // 显示版本控制
    {
        "key": "ctrl+n 5",
        "command": "workbench.view.scm",
        "when": "workbench.scm.active"
    },
    // 显示SQL Tools
    {
        "key": "ctrl+n 6",
        "command": "workbench.view.extension.sqltoolsActivityBarContainer"
    },
    // 显示Docker
    {
        "key": "ctrl+n 7",
        "command": "workbench.view.extension.dockerView"
    },
    // 显示测试
    {
        "key": "ctrl+n 8",
        "command": "workbench.view.testing.focus"
    },
    // 显示插件商店
    {
        "key": "ctrl+n 9",
        "command": "workbench.view.extensions",
        "when": "viewContainer.workbench.view.extensions.enabled"
    },
    // --- 面板命令
    // 切换面板显示状态
    {
        "key": "ctrl+p [",
        "command": "workbench.action.togglePanel"
    },
    // 显示问题
    {
        "key": "ctrl+p 1",
        "command": "workbench.panel.markers.view.focus"
    },
    // 显示输出
    {
        "key": "ctrl+p 2",
        "command": "workbench.action.output.toggleOutput",
        "when": "workbench.panel.output.active"
    },
    // 显示终端
    {
        "key": "ctrl+p 3",
        "command": "workbench.action.terminal.toggleTerminal",
        "when": "terminal.active"
    },
    // 显示调试控制台
    {
        "key": "ctrl+p 4",
        "command": "workbench.debug.action.toggleRepl",
        "when": "workbench.panel.repl.view.active"
    },
    // 显示SQL CONSOLE
    {
        "key": "ctrl+p 5",
        "command": "workbench.view.extension.sqltoolsPanelContainer"
    },
    // --- 编辑区命令
    // 关闭当前选项卡或分屏
    {
        "key": "ctrl+q",
        "command": "workbench.action.closeActiveEditor"
    },
    // 聚集在第一个选项卡中
    {
        "key": "ctrl+e",
        "command": "workbench.action.focusFirstEditorGroup"
    },
    // 切换到上一个选项卡
    {
        "key": "ctrl+,",
        "command": "workbench.action.previousEditor"
    },
    // 切换到下一个选项卡
    {
        "key": "ctrl+.",
        "command": "workbench.action.nextEditor",
    },
    {
        "key": "ctrl+w s",
        "command": "workbench.action.splitEditorDown"
    },
    // 拆分一个左右分屏
    {
        "key": "ctrl+w v",
        "command": "workbench.action.splitEditor"
    },
    // 将光标向上动1屏
    {
        "key": "ctrl+w k",
        "command": "workbench.action.focusAboveGroup"
    },
    // 将光标向下动1屏
    {
        "key": "ctrl+w j",
        "command": "workbench.action.focusBelowGroup"
    },
    // 将光标向左移动1屏
    {
        "key": "ctrl+w h",
        "command": "workbench.action.focusLeftGroup"
    },
    // 将光标向右移动1屏
    {
        "key": "ctrl+w l",
        "command": "workbench.action.focusRightGroup"
    },
    // --- 代码编辑命令
    // 触发帮助提示
    {
        "key": "ctrl+h",
        "command": "editor.action.showHover",
        "when": "editorTextFocus"
    },
    // 触发参数提示
    {
        "key": "ctrl+j",
        "command": "editor.action.triggerParameterHints",
        "when": "editorHasSignatureHelpProvider && editorTextFocus"
    },
    {
        "key": "ctrl+j",
        "command": "closeParameterHints",
        "when": "editorFocus && parameterHintsVisible"
    },
    // 触发建议提示
    {
        "key": "ctrl+k",
        "command": "editor.action.triggerSuggest",
        "when": "editorHasCompletionItemProvider && textInputFocus && !editorReadonly"
    },
    {
        "key": "ctrl+k",
        "command": "hideSuggestWidget",
        "when": "suggestWidgetVisible && textInputFocus"
    },
    // 移动到下一个建议
    {
        "key": "ctrl+n",
        "command": "selectNextSuggestion",
        "when": "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus"
    },
    // 移动到上一个建议
    {
        "key": "ctrl+p",
        "command": "selectPrevSuggestion",
        "when": "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus"
    },
    // 打开快速修复
    {
        "key": "ctrl+m",
        "command": "editor.action.quickFix",
        "when": "editorHasCodeActionsProvider && editorTextFocus && !editorReadonly"
    },
    // 格式化代码
    {
        "key": "ctrl+alt+l",
        "command": "editor.action.formatDocument",
        "when": "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor"
    },
    // 放大字体
    {
        "key": "ctrl+=",
        "command": "editor.action.fontZoomIn"
    },
    // 缩小字体
    {
        "key": "ctrl+-",
        "command": "editor.action.fontZoomOut"
    },
    // --- 资源管理器中对文件或目录的操作
    // 新建文件
    {
        "key": "i",
        "command": "explorer.newFile",
        "when": " explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus "
    },
    // 新建目录
    {
        "key": "o",
        "command": "explorer.newFolder",
        "when": " explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus "
    },
    // 刷新资源管理器
    {
        "key": "r",
        "command": "workbench.files.action.refreshFilesExplorer",
        "when": " explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus "
    },
    // 重命名文件或目录
    {
        "key": "a",
        "command": "renameFile",
        "when": " explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus "
    },
    // 删除文件或目录
    {
        "key": "d",
        "command": "deleteFile",
        "when": " explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus "
    },
    // 剪切文件或目录
    {
        "key": "x",
        "command": "filesExplorer.cut",
        "when": "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !explorerResourceReadonly && !inputFocus"
    },
    // 复制文件或目录
    {
        "key": "y",
        "command": "filesExplorer.copy",
        "when": "explorerViewletVisible && filesExplorerFocus && !explorerResourceIsRoot && !inputFocus"
    },
    // 粘贴文件或目录
    {
        "key": "p",
        "command": "filesExplorer.paste",
        "when": "explorerViewletVisible && filesExplorerFocus && !explorerResourceReadonly && !inputFocus"
    },
]
```
