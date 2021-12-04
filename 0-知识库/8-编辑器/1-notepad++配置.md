# [Notepad++]打造Python开发利器

转载自：https://blog.csdn.net/humanking7/article/details/80464000

# 1.问题需求

我一般写`Python`项目都是用 `PyCharm`，这是绝对的利器，不过就是打开慢，吃资源[机壕请无视这条]，而一般测试，我则是，用 `Console Emulator + IPython` 的运行环境，如下图所示：

![pic0](D:\Typora_pic\20180526182123913)

体验还是不错的，但是就是编写代码不舒服，相当于一个加强版的`IDEL`，我需要`编辑 + 运行` 这两个功能。所以瞄上`Notepad++`

# 2.Notepad++最终效果

```
Ctrl + F5 # 编译运行Python，调用 cmd 运行Python，执行当前py文件



Ctrl + F6 # 运行IPython， 调用 cmd 运行 IPython
```

- 1
- 2

![pic1_all](D:\Typora_pic\20180526181335921)

# 3.配置Notepad++

## 3.1.配置快捷键

### 3.1.1.配置快捷键

**设置**`运行Python`

- 1.按 `F5` （或者 `运行` => `运行`）
- 2.在弹出的窗口内输入以下命令：

```
# run_Python [Ctrl + F5]



cmd /k cd /d "$(CURRENT_DIRECTORY)" &  python "$(FULL_CURRENT_PATH)" & ECHO. & PAUSE & EXIT
```

- 1
- 2

- 3.然后点击`保存`，取一个名字，比如`[run_Python]`，配置快捷键（这里设置为 `Ctrl + F5`），点**OK**。

**PS：**注意不要和已有快捷键发生冲突，在 `运行` => `管理快捷键`进行快捷键设置。

**设置**`运行IPython`

```
# run_IPython [Ctrl + F6]



cmd /k cd /d "$(CURRENT_DIRECTORY)" & ipython
```

- 1
- 2

**设置**运行`ConEmu64`

```
# ConEmu64.exe 进入 当前文件工作目录



"D:\Program Files\ConEmuPack\ConEmu64.exe" /dir "$(CURRENT_DIRECTORY)"



# ConEmu64.exe直接执行ipython，但是目录在 Notepad++.exe 的根目录



"D:\Program Files\ConEmuPack\ConEmu64.exe" ipython
```

- 1
- 2
- 3
- 4

这个 `/dir` 是 `ConEmu64.exe`的命令格式，但是后面没办法加载其它命令，会报错，我没有找到对应的命令用`|`和`&`都无法链接两个命令，很无奈

![pic2](D:\Typora_pic\20180526181400679)

![pic3](D:\Typora_pic\20180526181412691)

![pic4](D:\Typora_pic\20180526181423994)

![pic5](D:\Typora_pic\20180526181435222)

### 3.1.2.命令解释

```
# run_Python [Ctrl + F5]



cmd /k cd /d "$(CURRENT_DIRECTORY)" &  python "$(FULL_CURRENT_PATH)" & ECHO. & PAUSE & EXIT
```

- 1
- 2

- `cmd /k`： 表示打开cmd窗口，运行`/k`后边的命令，并且执行完毕后保留窗口
- `cd /d "$(CURRENT_DIRECTORY)"`：`cd /d`切换目录到`$(CURRENT_DIRECTORY)`
- `&` ：用来连接多条命令
- `python "$(FULL_CURRENT_PATH)"`：用`Python` 运行**当前文件**（`$(FULL_CURRENT_PATH)`）
- `$(FULL_CURRENT_PATH)` ：Notepad++的宏定义，表示当前文件的完整路径。
- `ECHO`：换行
- `PAUSE`： 表示运行结束后暂停（cmd中显示“`请按任意键继续. . .`”），等待一个按键继续
- `EXIT`： 表示“按任意键继续…”后，关闭命令行窗口。

===========

```
cmd /k cd /d "$(CURRENT_DIRECTORY)" & ipython
```

- 1

- `cd /d "$(CURRENT_DIRECTORY)"`：`cd /d`切换目录到`$(CURRENT_DIRECTORY)`
- `$(CURRENT_DIRECTORY)` ： 当前文件所在文件夹
- `& ipython` ： 运行`IPython`

===========

**Notepad++宏定义的含义**

| 宏                | 解释                                                         | 例子                                |
| :---------------- | :----------------------------------------------------------- | :---------------------------------- |
| FULL_CURRENT_PATH | The fully qualified path to the current document.            | E:\myPath\welcome.html              |
| CURRENT_DIRECTORY | The directory the current document resides in                | E:\myPath                           |
| FILE_NAME         | The file name                                                | welcome.html                        |
| NAME_PART         | The filename without the extension                           | welcome                             |
| EXT_PART          | The extension of the current document                        | html                                |
| NPP_DIRECTORY     | The directory that contains the notepad++.exe executable that is currently running | possibly C:\Program Files\Notepad++ |
| CURRENT_WORD      | The currently selected text in the document                  |                                     |
| CURRENT_LINE      | The current line number that is selected in the document (0 based index, the first line is 0). |                                     |
| CURRENT_COLUMN    | The current column the cursor resides in (0 based index, the first position on the line is 0). |                                     |

可以参考`Notepad++`自带的帮助文档。

点击菜单`“？”`=>`[帮助]`按钮（或者`Shift+F1`快捷键）=>在打开的页面中点击右面的`[Commands]`，可以查看到各个宏定义的含义。

![pic7](D:\Typora_pic\20180526204027499)

## 3.2.配置插件

```
插件` => `Plugin Manager`=> `Show Plugin Manager`=> `Available
```

**找到插件 ：** `Explorer` 和 `Source Cookifier`

**安装后：**

![pic6](D:\Typora_pic\20180526191443944)

 