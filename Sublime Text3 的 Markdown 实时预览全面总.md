# Sublime Text3 的 Markdown 实时预览全面总结

如前文《Sublime Text3 的插件管理工具(Package Control)的安装及使用方法》所说，Sublime有强大的插件扩展功能，本文将详细介绍在用Sublime写Markdown文档时如何预览，甚至是实时刷新预览。

## 温习：插件安装方式，后面会反复用到

组合键Ctrl+Shift+P 调出命令面板
输入Package Control: Install Package，回车
在搜索框中输入要安装的包名（一个一个，不能同时安多个）
静待几秒即可安装成功
插件介绍
介绍几个Markdown类的常用插件：

### 插件	功能

1. MarkdownEditing	一个提高Sublime中Markdown编辑特性的插件
2. MarkdownPreview	Markdown转HTML，提供在浏览器中的预览功能
3. MarkdownLivePreview	提供在编辑框中实时预览的功能
4. LiveReload	一个提供md/html等文档的实时刷新预览的的插件
接下来会一次介绍这几个插件。

### MarkdownEditing
顾名思义，Markdown编辑器，是Markdown写作者必备的插件，不仅可以高亮显示Markdown语法还支持很多编程语言的语法高亮显示。
特别注意：MarkdownEditing只针对 md\mdown\mmd\txt 格式文件才启用。

特性
MarkdownEditing 从视觉和便捷性上针对 Markdown 文档的编辑进行了一系列的优化。如：

颜色方案仿 Byword及iA writer
自动匹配星号（*）、下划线（_）及反引号（`）
选中文本按下以上符号能自动在所选文本前后添加配对的符号
方便粗体、斜体和代码框的输入
效果图：

![这里写图片描述](https://img-blog.csdn.net/20180803020629933?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzIwMDExNjA3/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

### MarkdownLivePreview
功能
实时预览Markdown文件，左侧为md文件，右侧为预览结果。可配合MarkdownEditing一起使用。

使用
MarkdownLivePreview默认关闭实时预览，既然安装这个插件了，那肯定是要用的。打开方式为在Preferences -> Package Settings -> MarkdownLivePreview -> Settings 的设置的右侧加一条 "markdown_live_preview_on_open": true,，重启sublime即可。

为什么不能直接将左侧对应的false改为true，这是因为左侧为默认配置，是不能改的（只读），右侧的编辑区才是用户自定义区。

效果图
以下为配合MarkdownEditing的效果：

==实际预览效果并不理想,很丑,而且不能横向滚动,也就是说如果一行显示不过来那你就看不到 了。偶然也会有些卡,所以其实推荐的是下面这个插件。==

![这里写图片描述](https://img-blog.csdn.net/20180803030607658?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzIwMDExNjA3/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
### MarkdownPreview
功能
支持在浏览器中预览markdown文件
将md文件导出为html代码
将md文件用浏览器预览——1.常规方法
组合键 Ctrl+Shift+P 调出命令面板
输入mdp找到并选中Markdown Preview： Preview in Browser
出现两个选项：github和markdown。任选其一即可，github是利用GitHub的在线API来解析.md文件，支持在线资源的预览，如在线图片它的解析速度取决于你的联网速度。该方式据说一天只能打开60次。markdown就是传统的本地打开，不支持在线资源的预览。
默认浏览器中显示预览结果
将md文件用浏览器预览——2.用快捷键打开
Sublime Text支持自定义快捷键，Markdown Preview默认没有快捷键，我们可以自己为Markdown Preview： Preview in Browser设置快捷键。
方法是在Preferences -> Key Bindings打开的文件的右侧栏的中括号中添加一行代码：

```sh
{ "keys": ["alt+m"], "command": "markdown_preview", "args": {"target": "browser", "parser":"markdown"}  }
```
这里：
```sh
"alt+m" 可设置为自己喜欢的按键。
"parser": "markdown"也可设置为"parser":"github"，改为使用Github在线API解析markdown。
```
以上两种方式都有个问题：每次预览都要打开一个新的网页，而且需要手动操作。

有没有一个方法，可以打开一个网页后，之后再也不用管，让它实时刷新预览呢？
有，还很简单，

答案就是MarkdownPreview+LiveReload！
**LiveReload是一个可实时刷新的插件，不仅可用于Markdown，也可用于HTML等**。

## （最强）实时自动刷新预览：MarkdownPreview + LiveReload

先安装并配置Markdown Preview
如前Markdown Preview安装成功后，设置前文所述的快捷键（如需），打开其配置文件 Preferences -> Package Settings -> Markdown Preview -> Settings，检查左侧enable_autoreload条目是否为true，若是，跳过。若不是，右侧栏加一条下面这个后重启Sublime:
```sh
{
    "enable_autoreload": true
}
```
安装并配置LiveReload
Ctrl+Shift+p, 输入 Install Package，输入LiveReload, 回车安装
```sh
安装成功后, 再次Ctrl+shift+p, 输入LiveReload: Enable/disable plug-ins, 回车, 选择 Simple Reload with delay (400ms)或者Simple Reload，两者的区别仅仅在于后者没有延迟。
```
## 开始使用
如前面提到的手动或者快捷键打开预览网页，之后便再也不用管它，只要你的sublime保存一次，网页那边就会自动刷新预览，美滋滋。
但是呢，

### 有个遗留的问题：
	网页预览不能跟随你的sublime编辑位置，还需要你滑动页面。
在这一点上，==CSDN-Markdown==可以说很优秀了，本文就是在该编辑器下完成的。

作者：张渊猛

显示推荐内容