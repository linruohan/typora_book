# Sublime Text3 的 Markdown 实时预览全面总结
如前文《Sublime Text3 的插件管理工具(Package Control)的安装及使用方法》所说，Sublime有强大的插件扩展功能，本文将详细介绍在用Sublime写Markdown文档时如何预览，甚至是实时刷新预览。

## 0. 温习：插件安装方式，后面会反复用到
1. MarkdownEditing	一个提高Sublime中Markdown编辑特性的插件
2. MarkdownPreview	Markdown转HTML，提供在浏览器中的预览功能
3. MarkdownLivePreview	提供在编辑框中实时预览的功能
4. LiveReload	一个提供md/html等文档的实时刷新预览的的插件

## （最强）实时自动刷新预览：MarkdownPreview + LiveReload


### 先安装并配置Markdown Preview
如前Markdown Preview安装成功后，设置前文所述的快捷键（如需），打开其配置文件 Preferences -> Package Settings -> Markdown Preview -> Settings，检查左侧enable_autoreload条目是否为true，若是，跳过。若不是，右侧栏加一条下面这个后重启Sublime:
```bash
{
    "enable_autoreload": true
}
```
Markdown Preview默认没有快捷键，我们可以自己为Markdown Preview： Preview in Browser设置快捷键。
方法是在Preferences -> Key Bindings打开的文件的右侧栏的中括号中添加一行代码：
```bash
{ "keys": ["alt+m"], "command": "markdown_preview", "args": {"target": "browser", "parser":"markdown"}  }
```

### 安装并配置LiveReload
Ctrl+Shift+p, 输入 Install Package，输入LiveReload, 回车安装
安装成功后, 再次Ctrl+shift+p, 输入LiveReload: Enable/disable plug-ins, 回车, 选择 Simple Reload with delay (400ms)或者Simple Reload，两者的区别仅仅在于后者没有延迟。

## 开始使用
如前面提到的手动或者快捷键打开预览网页，之后便再也不用管它，只要你的sublime保存一次，网页那边就会自动刷新预览，美滋滋。
