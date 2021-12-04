
# Sublime Text3 安装Markdown Editing 后打开 .md 文件样式有点丑，如何改善一下。
文件确实变成黑色背景了。不过，左侧空白依然在。

## 设置黑色主题
我遇到同样的问题，保存为中文名字.md没问题，保存为数字或者英文名字就变成有空白，而且怎么也回不去。
如果要背景颜色的话，可以在markdown editing setting的GFM user里面修改一句话：改成你想要的配色方案就可以了。
在官网有介绍：
```js
In order to activate the dark or the yellow theme, put one of these lines to your user settings file of the flavor:
"color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Dark.tmTheme",
"color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Yellow.tmTheme",
```
我想，但是却没有作用?
请问该如何设置，谢谢。
2016-07-27 追加：
## ==左侧留有大部分空白==，不能进行编辑。
```js
// 我在markdown editing setting的GFM user里面添加
{
    // 设置黑色主题
    "color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Dark.tmTheme",
    "color_scheme": "Packages/Monokai Extended/Monokai Extended Bright.tmTheme"，
    // 解决左侧留有大部分空白
    "wrap_width": 120,
    // 左侧空白的问题完美解决了
    "draw_centered": false,
}
```
解决思路，我发现markdown的内容是根据最长一行的内容，水平居中显示的。然后就到markdown editing GFM default中找与位置相关的配置项。最终找到这一段
```js
    // Layout
    "draw_centered": true,
    "word_wrap": true,
    "wrap_width": 80,
    "rulers": [],
```
layout是布局，draw_centered这一项应该是设置页面居中，把属性改成false，结果成功了。也就是
`"draw_centered": false,`
。不过还是不要直接修改默认设置文件，而是在用户设置文件中添加"draw_centered": false,这一句就好了。
>

MarkdownEditing 文档中是这样写的：
> By default, when you install the plugin, files with these extensions will be assigned to Markdown syntax: "md", "txt", "mdown", 
>"markdown", "markdn". If you want to prevent any of these extensions to be opened as Markdown, follow these steps:

Click on the language menu at bottom right
Select "Open all with current extension as"
Choose your preferred syntax for that extension
也就是说，打开一个txt文件，右下角，然后重新指定语法。针对txt，可以选择Textile.
同理，针对后缀为sql的文件，可以选择sql。

相似问题
sublime-text3，jsp文件语法如果选jsp，按tab键会卡很久
sublime-text 3安装ctags时，官网下载的ctags可执行文件压缩包是损坏的
ubuntu sublime-text3 git pull push 失败
关于前端渲染Markdown文件  1 回答
sublime-text3 的侧边栏选项怎么是灰色的？  3 回答
Mac下sublime-text3无法打开preferences？
sublime-text3 安装插件提示找不到node.js路径变量  2 回答
sublime-text 3 右侧minimap可以设置成默认鼠标悬停的效果吗？  1 回答
