## 1 简介

很久之前在文章：[vscode 配置及插件推荐](https://www.jianshu.com/p/21c99e461ad3)，
1. VSCodeVim 只是在 IDE 上对 Vim 的一个操作模拟，它事实上并不具备完整的 Vim 功能（甚至都不能加载自定义 `.vimrc`），可以说 VSCodeVim 本质是一个阉割版的 Vim。
2. Neovim 的一个开发目标就是将 Vim/Neovim 嵌入到其他编辑器中，实现完整的 Vim 功能。与以往通过插件模拟 Vim 按键方式不同，这种嵌入的方式使用的就是我们自定义的 Vim 配置，连插件都能使用...

## 2 工作原理

在 vscode 中嵌入 Neovim，需要借助插件 [vscode-neovim](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fasvetliakov%2Fvscode-neovim)，它的工作原理如下：
1.  首先，启动 vscode 后，vscode 会启动一个 Neovim 实例，并进行连接。
2.  当 vscode 打开一个文件时，Neovim 实例就会创建一个相应的缓冲区，填入文件内容。
3.  `normal`模式和`visual`模式下的操作都会直接传递给 Neovim 实例，vscode-neovim 插件会监听缓冲区事件并将 Neovim 的编辑操作应用到 vscode 中。
4.  当进入`insert`模式时，vscode-neovim 插件会停止监听按键操作事件，由 vscode 响应输入模式下的操作（此时不存在 vscode 与 Neovim 实例通信）。
5.  当按下`esc`退出插入模式后，vscode-neovim 会将这阶段的内容更改发送给 Neovim，同步更新文件内容。

理论上，vscode-neovim 可以实现 100% Neovim 功能（除了插入模式下的操作，窗口/缓冲区/文件管理）。  
**注**：事实上，其实 VSCodeVim 也支持集成 Neovim，但功能受限较多，目前似乎只能实现命令行模式增强...相对来说，vscode-neovim 功能更加强大，其可以实现完整 Neovim 功能。

## 3 安装

### 3.1 Vscode 安装插件：[vscode-neovim](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fasvetliakov%2Fvscode-neovim)
    ![](https://upload-images.jianshu.io/upload_images/2222997-629d9ad6a7cefd72.png?imageMogr2/auto-orient/strip|imageView2/2/w/1077/format/webp)
### 3.2 安装 [Neovim](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fneovim%2Fneovim%2Fwiki%2FInstalling-Neovim)，要求 `0.5.0 neovim` 及以上版本
### 3.3 Vscode 配置 Neovim 可执行文件完整路径：  
    1). 打开设置：_File - Preferences - Settings_，也可以通过快捷键`Ctrl+Shift+p`，输入`Open User Settings`。  
    2). 依据不同系统，分别进行如下设置：
```json
// Windows
"vscode-neovim.neovimExecutablePaths.win32": "D:\\Program Files (x86)\\Neovim\\bin\\nvim.exe",
// Linux
"vscode-neovim.neovimExecutablePaths.linux": "/usr/local/bin/nvim",
// Mac
"vscode-neovim.neovimExecutablePaths.darwin": "/usr/local/bin/nvim",
```
    以上选择自己的系统进行配置即可，也可以全部进行配置，vscode-neovim 会自动选择匹配当前系统的设置。
### 3.4 **注**： WSL（Windows Subsystem for Linux）里面的 Neovim，则进行如下配置：
```json
"vscode-neovim.useWSL": true,
"vscode-neovim.neovimExecutablePaths.linux": "/usr/local/bin/nvim",
```
1.  其实前面步骤已配置完成，此时启动 vscode 即可，但是如果用户已自定义一个`init.vim`配置文件，那么当前的配置或某些插件可能会导致一些问题，比如显示行号、缩进、括号高亮等渲染 vscode 的插件都可能带来性能问题，因此刚开始时最好使用空白配置或者不加载用户自定义配置内容，如下所示：
```vim
if exists('g:vscode')
	" VSCode extension
else
	" ordinary neovim
endif
```
## 4 一些注意事项
-   Neovim 可以调用 vscode 命令，只需在 Neovim 中调用函数：`VSCodeCall`/`VSCodeNotify`等等，其中，`xxxCall`是一个同步调用，`xxxNotify`是一个异步调用。
-   `visual`模式并不会导致 vscode 产生真正的文本选择，因此，最好将 Neovim 的可视模式映射为 vscode 本身可以产生选择的操作，即 Neovim 接收到可视操作后，回调 vscode 相应操作，并传入相应选择范围。Neovim 回调 vscode 相应范围方法为：`VSCodeNotifyRange`/`VSCodeNotifyRangePos`，其中，`VSCodeNotifyRange`是基于行的范围选择，`VSCodeNotifyRangePos`是基于字符的范围选择，一个具体的例子如下所示：
```vim
function! s:openVSCodeCommandsInVisualMode()
	normal! gv
	let visualmode = visualmode()
	if visualmode == "V"
		let startLine = line("v")
		let endLine = line(".")
		" 最后一个参数 1 表示操作后仍处于选择模式，0 则表示操作后退出选择模式
		call VSCodeNotifyRange("workbench.action.showCommands", startLine, endLine, 1)
	else
		let startPos = getpos("v")
		let endPos = getpos(".")
		call VSCodeNotifyRangePos("workbench.action.showCommands", startPos[1], endPos[1], startPos[2], endPos[2], 1)
	endif
endfunction

" workaround for calling command picker in visual mode
xnoremap <silent> <C-P> :<C-u>call <SID>openVSCodeCommandsInVisualMode()<CR>
```
    
-   失能`editor.scrollBeyondLastLine`配置，可以让 vscode-neovim 工作更好：
```json
"editor.scrollBeyondLastLine": false,
```
-   文件/标签页/窗口管理（`:w`/`q`...）等相关命令会被替换或映射为 vscode 的操作，如果不满意默认映射，则可以手动进行更改，将这些按键映射为 vscode 相应操作即可。
-   Mac 系统上，`h`，`j`，`k`和`l`在按下情况下，不会重复键入，解决这个问题执行在控制台中输入：`defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false`。
## 5 一些默认配置
vscode-neovim 本身已内置了一些默认配置，常见的如下表所示：
| 按键              | 映射                                    |
|-----------------|---------------------------------------|
| =/==            | editor.action.formatSelection         |
| gd/<C-]>        | editor.action.revealDefinition        |
| gD              | editor.action.peekDefinition          |
| gf              | editor.action.revealDeclaration       |
| gF              | editor.action.peekDeclaration         |
| \<C-w>gd/\<C-w>gf | editor. action. revealDefinitionAside   |
| gh              | editor.action.showHover               |
| gH              | editor.action.referenceSearch.trigger |

其他的内置自定义按键配置可参考：
-   [`vscode-scrolling.vim`](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fasvetliakov%2Fvscode-neovim%2Fblob%2Fmaster%2Fvim%2Fvscode-scrolling.vim)：滚动相关按键映射
-   [`vscode-file-commands.vim`](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fasvetliakov%2Fvscode-neovim%2Fblob%2Fmaster%2Fvim%2Fvscode-file-commands.vim)：文件管理相关按键映射
-   [`vscode-tab-commands.vim`](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fasvetliakov%2Fvscode-neovim%2Fblob%2Fmaster%2Fvim%2Fvscode-tab-commands.vim)：标签管理相关按键映射
-   [`vscode-window-commands.vim`](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fasvetliakov%2Fvscode-neovim%2Fblob%2Fmaster%2Fvim%2Fvscode-window-commands.vim)：窗口管理相关按键映射

## 6 Neovim 配置

Neovim 配置主要包含如下两方面配置内容：

-   **按键配置**：非插入模式下，所有操作都会先定向到 Neovim 中，对于 Neovim 能进行处理的操作，Neovim 自行操作，然后将结果返回给 vscode 即可，而对于 Neovim 无法进行的操作，可以转交给 vscode 处理，只需调用`VSCodeNotify`等方法即可。
    
    举个例子：如下配置可以在 vscode 中进行更方便的窗口选择移动操作：
    
    ```vim
    " init.vim
    nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
    ```
    
    其实就是 Neovim 接收到相应按键，然后通过`VSCodeNotify`调用 vscode 相应方法，让 vscode 进行处理。
    
    **注**：vscode 的全部默认命令查看方式如下：按下快捷键：_Ctrl+Shift+p_，输入：`Preferences: Default Keyboard Shortcuts (JSON)`，就可以跳转到默认的命令列表中。网上也有人整理的所有命令：[VSCode Internal Commands](https://links.jianshu.com/go?to=https%3A%2F%2Fgist.github.com%2Fskfarhat%2F4e88ef386c93b9dceb98121d9457edbf)。对于常用的一些选项，可参考官网：[vscode - keybindings](https://links.jianshu.com/go?to=https%3A%2F%2Fcode.visualstudio.com%2Fdocs%2Fgetstarted%2Fkeybindings)
    
-   **插件安装**：安装特定匹配 vscode 的插件，也可以排除一些影响 vscode 正常运行的插件：
    
    ```vim
    if exists('g:vscode')
        " VSCode extension
    else
        " ordinary neovim
    endif
    ```
    
    大多数插件默认即可进行使用，但正如前面所讲的，有些插件会对 vscode 性能上有影响，尤其是一些渲染类的插件，此类插件可通过上述代码所示方式进行规避，另外还有一些插件，为了能更好地在 vscode 上运行，这些插件以 vscode 插件形式运行（比如 [vscode-which-key](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2FVSpaceCode%2Fvscode-which-key)），此时可以通过 Neovim 调用 vscode 方法来调用该插件提供的相应命令即可。
    

## 7 vscode 配置

vscode 可自定义按键映射（快捷键），触发相应操作。  
**注**：按键映射也可作为按键拦截操作，配置相应按键后，该快捷键就会被 vscode 截取，我们可以直接调用 vscode 命令做出相应，拦截该操作，不发送给 Neovim，也可以配置相应按键操作发送给 Neovim，可以通过参数等方式将该按键映射为 Neovim 的相应按键...

vscode 按键映射配置文件为：`keybindings.json`，打开方式为：_File - Preferences - Keyboard Shortcuts_，快捷打开方式为：`Ctrl+Shit+p`，输入`Preferences: Open Keyboard Shortcuts(JSON)`。
`keybindings.json`配置方式如下所示：
```json
[
    {
        "key": "ctrl+n",
        "command": "workbench.action.quickOpen"
    },
    {
        "key": "ctrl+p",
        "command": "-workbench.action.quickOpen" // 减号表示失能，即 vscode 禁止相应操作
    },
    {
        // 将 vscode 按键 ctrl+c 发送给 Neovim，映射为 <C-c>
        "command": "vscode-neovim.send",
        "key": "ctrl+c",
        "when": "editorTextFocus && neovim.mode != insert", // 触发条件
        "args": "<C-c>"
    }
]
```

**注**：如果想实现一个快捷键映射到多个命令，当前 vscdoe 仍未直接提供该功能，通常都会通过一些扩展插件（比如 [macros](https://links.jianshu.com/go?to=https%3A%2F%2Fmarketplace.visualstudio.com%2Fitems%3FitemName%3Dgeddski.macros)）来实现这个功能，但是也可以采用 vscode 内置的 **[用户任务（user level tasks）](https://links.jianshu.com/go?to=https%3A%2F%2Fcode.visualstudio.com%2Fdocs%2Feditor%2Ftasks%23vscode)** 来间接实现单键多命令，用户任务其实是 vscdoe 提供给到开发者用于配置执行一些自动化操作，通常都会调用一些外部程序来执行相应操作，但是我们也可以配置相关任务来触发执行 vscode 内置的命令，比如，假设我们想实现按键`ctrl+b`来关闭所有的边窗，即`ctrl+b`触发执行两个内置命令：`workbench.action.toggleSidebarVisibility`，`workbench.action.togglePanel`，则可进行如下操作：
-   **配置用户任务**：首先通过快捷键：`Ctrl+Shift+p`，输入：`Tasks: Open User Tasks`，打开用户任务编辑窗口。
-   **任务编写**：为每个内置命令添加相应任务作为子任务，并在最后添加一个总任务汇总，如下所示：
```json
{
	"version": "2.0.0",
	"tasks": [
		{
			// 子任务: toggleSideBar
			"label": "toggleSideBar",
			"command": "${command:workbench.action.toggleSidebarVisibility}"
		},
		{
			// 子任务: togglePanel
			"label": "togglePanel",
			"command": "${command:workbench.action.togglePanel}"
		},
		{
			// 总任务: Toggle All Panel
			"label": "Toggle All Panel",
			"dependsOrder": "sequence",
			"dependsOn": [
				"toggleSideBar",
				"togglePanel"
			],
			"problemMatcher": []
		}
	]
}
```
    
-   **按键映射**：在`keybindings.json`中，进行按键映射，将`ctrl+b`映射到总任务`Toggle All Panel`：
    
```json
{
	"key": "ctrl+b",
	"command": "workbench.action.tasks.runTask",
	"args": "Toggle All Panel"
}
```
    现在，按下`ctrl+b`，就会触发执行`workbench.action.toggleSidebarVisibility`和`workbench.action.togglePanel`。
**注**：vscode 已内置了一些默认的按键配置，如果想查看某个按键具体配置详情，一个小技巧就是到按键配置页面复制默认配置即可，如下图所示：
![](https://upload-images.jianshu.io/upload_images/2222997-09f60af695b9c224.png?imageMogr2/auto-orient/strip|imageView2/2/w/1027/format/webp)

copy keybinding configuraion

最后，附上本人配置：

-   [vscode configuration](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2FWhy8n%2Fdotfiles%2Ftree%2Fmaster%2Fvscode)
-   [neovim configuration](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2FWhy8n%2Fdotfiles%2Ftree%2Fmaster%2Fvim%2F.vim%2Fvscode)

## 8 参考

-   [vscode-neovim](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fasvetliakov%2Fvscode-neovim)
-   [VSCode with embedded Neovim](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3Dg4dXZ0RQWdw)
-   [VSCodium & Neovim](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.chrisatmachine.com%2FNeovim%2F22-vscodium-neovim%2F)