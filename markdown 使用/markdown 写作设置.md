# Sublime Text 3 Markdown 写作设置

2017-03-04 

[ technique ](https://jdhao.github.io/categories/technique/)

 1799 words 4 mins read 3206 times read

## CONTENTS

[引子](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#引子)[Markdown 文件编辑插件 MarkdownEditting](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#markdown-文件编辑插件-markdowneditting)[Markdown 主题](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#markdown-主题)[为 Markdown 文件设定默认的语法高亮](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#为-markdown-文件设定默认的语法高亮)[Markdown 预览插件 Markdown Preview](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#markdown-预览插件-markdown-preview)[LiveReload 的使用](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#livereload-的使用)[更改 Sublime Text 的显示字体](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#更改-sublime-text-的显示字体)[增加一个插入图片的 snippet](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#增加一个插入图片的-snippet)[更新历史](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#更新历史)[参考](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#参考)

# 引子

由于受不了 VSCode 打开文件的龟速，我决定换一个编辑器，以前就大致了解有三款评价不错的编辑器，分别是 [GitHub Atom](https://atom.io/), [Sublime Text 3](https://www.sublimetext.com/) 以及微软的 [VSCode](https://code.visualstudio.com/)。

这三个编辑器我都使用过，总的感觉是 Atom 和 Visual Studio Code 打开文件的速度比较慢，Sublime Text 打开文件速度是最快的。Atom 和 Sublime Text 由于推出的比较早，都有大量的插件可以使用，VSCode 相对来说插件少一些，现在也在迎头赶上。这三个产品，除了 Sublime Text 是付费产品[1](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#fn:1)，其余两个都是开源托管在GitHub. 我也找到了一篇对[三个编辑器的最新评测](https://blog.xinhong.me/post/sublime-text-vs-vscode-vs-atom-performance-dec-2016/)。最终，由于我比较在意打开文件的速度，我决定使用 Sublime Text。以下介绍一些Markdown 写作中常用的插件。

# Markdown 文件编辑插件 MarkdownEditting

根据推荐，我使用了[MarkdownEditting](https://github.com/SublimeText-Markdown/MarkdownEditing) 这款插件，这款插件支持 Markdown 的多种「方言」， 支持快捷键插入多种常用的Markdown 格式模版，非常方便。

## 常用的技巧

MarkdownEditting 提供了一些方便的 snippet 以及快捷键，熟练使用这些快捷操作会极大提升输入 Markdown 文档的速度。

- 快速插入 link，image link 以及 code block 模板，分别输入 `mdl`, `mdi` 以及 `mdc`， 然后按下 Tab, 对应的模板就能快速生成，避免重复劳动。
- 快速把复制的网页地址变成 inline link，使用快捷键 Ctrl+Win+V[2](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#fn:2)。
- 快速把复制的地址变为 inline image，使用快捷键 Shift+Win+K
- 插入 footnote，使用 Alt+Shift+6 快速插入各级标题。Markdown 语言提供了六级标题，MarkdownEditting 提供了对 1，2，3 级标题的快捷输入支持，分别输入 `mdh1` 到 `mdh3`，然后按 Tab，即可生成对应级别的标题模板。 如果要把某段文字变为标题或者想要更改某个标题的级别，首先选中该段文字，然后按下 Ctrl+NUM， `NUM` 代表标题级别 。

# Markdown 主题

从 Sublime Text 的 package control 网站发现了 [Boxy Theme](https://github.com/ihodev/sublime-boxy), 该主题提供的 `Boxy Monokai` color scheme 渲染出的 Markdown 文档显示效果更好，推荐使用。

# 为 Markdown 文件设定默认的语法高亮

发现每次打开新的 `*.md` 文件时，默认的语法高亮并不是 MarkdownEditting, 可以通过点击菜单栏, `View->Syntax->Open all with current extension as ...` 来选择 MarkdownEditting 支持的一种语法, 这样以后打开以 md 作为后缀的文件，默认渲染语法就是 MarkdownEditting。

# Markdown 预览插件 Markdown Preview

预览 Markdown 文件的效果我选用了 [Markdown Preview](https://github.com/revolunet/sublimetext-markdown-preview)。安装插件以后，使用快捷键 `Ctrl + Shift + M` 可以在浏览器预览当前文件生成 html 以后的效果，Markdown Preview 支持两个 parser: github 以及 markdown，所以每次预览的时候都会弹出一个小窗口，让你选择使用哪个 paser 转换 md 文件，比较烦，可以通过设置 Markdown Preview 的 user setting 中的

```fallback
"enabled_parsers": ["markdown"],
```

默认使用 markdown parser，这样每次使用快捷键预览，就不会弹出弹窗提示，让你选择 parser 了。

# LiveReload 的使用

Markdown Preview 可以在浏览器预览 Markdown 文件生成的 html 效果，如果当前正在编辑的 Markdown 文件修改以后，要预览修改后的效果，必须手动刷新浏览器，比较繁琐。[LiveReload](https://packagecontrol.io/packages/LiveReload) 可以自动刷新网页，免去了手动刷新之苦。

可以使用 [Package Control](https://packagecontrol.io/installation) 安装LiveReload, 直接使用 `livereload` 关键词搜索安装即可。 安装以后，在 LiveReload的 user setting 里面加上如下设置：

```fallback
{
  "enabled_plugins": [
     "SimpleReloadPlugin"
  ]
}
```

使用 `Ctrl + Shift + M` 在浏览器预览生成的 html 文件，继续编辑 Markdown 文件，保存，你会发现浏览器的 html 文件也随之自动更新。 参考了 [这里](https://github.com/SublimeText-Markdown/MarkdownEditing#enable-wysiwyg) 的设置。

# 更改 Sublime Text 的显示字体

参考网上的建议，选用了 [`Source Code Pro`](https://github.com/adobe-fonts/source-code-pro) 这款字体，安装字体以后，在 `Preferences` 下的 `Settings` 加入下面的 User 配置：

```fallback
"font_face": "Source Code Pro",
```

如何查看字体的名字，可以参考 [这里](https://jdhao.github.io/2017/05/13/guide-on-how-to-use-chinese-with-matplotlib/)。

发现了另外一款不错的免费字体 [Space Mono](https://fonts.google.com/specimen/Space+Mono)， 显示效果更好，推荐使用。

# 增加一个插入图片的 snippet

在写作 Markdown 的时候，经常会使用到原始的 HTML 语法插入图片，因此想写一个snippet 作为插入图片的模板代码，方便插入图片，关于 snippet 的介绍，可以参考[这里](http://docs.sublimetext.info/en/latest/extensibility/snippets.html)，一个比较简单的插入 html 图片的 snippet 如下：

```fallback
<snippet>
    <description>insert an image in html syntax</description>
    <content>
        <![CDATA[<img src="${1:image link}"
         title="${2:image title}"
         style="float: middle;"
         >]]></content>
    <!-- Optional: Set a tabTrigger to define how to trigger the snippet -->
    <tabTrigger>iimg</tabTrigger>
    <!-- Optional: Set a scope to limit where the snippet will trigger -->
    <scope>text.html.markdown, text.html.markdown.multimarkdown</scope>
</snippet>
```

使用方法：在需要插入图片的地方，输入 `iimg`，然后敲击 Tab，预设的模板就会出现。

# 更新历史

- 2017-10-11: 增加了如何创建一个简单的插入图片 snippet 的方法。
- 2017-12-14: 增加了 MarkdownEditting 使用 tips。
- 2017-12-17: 增加了 LiveReload 的安装使用方法。
- 2018-01-04: 修改了一些错误
- 2018-02-08: 增加了在 Windows 10 Fall Creator 上，修改 inline 快捷键的方法。

# 参考

- [Markdown 插件安装使用](http://www.jianshu.com/p/335b7d1be39e)
- [v2ex 上对编程字体的介绍](https://www.v2ex.com/t/217878)
- [为某种后缀名文件设定默认的语法高亮](http://stackoverflow.com/questions/7574502/set-default-syntax-to-different-filetype-in-sublime-text-2)
- [Source Code Pro 字体安装使用](http://t.cn/RiaAdZ0)
- [Sublime Text package 的在线仓库](https://packagecontrol.io/)
- [MarkdownEdit 的一个 snippet](https://goo.gl/KsVtS3)
- [create single image with tile in html syntax](https://hypjudy.github.io/2017/02/04/tips-about-blog/)

------

1. 虽然 Sublime Text 是付费产品，但是，如果你愿意，可以一直试用。 [↩︎](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#fnref:1)
2. 如果你使用的是最新的 Windows 10 Fall Creator 更新，[该快捷键不再有效](https://github.com/SublimeText-Markdown/MarkdownEditing/issues/488)，可以使用 [PackageResourceViewer](https://github.com/skuroda/PackageResourceViewer) 打开 MarkdownEditing 插件，然后进入 MarkdownEditing 库的目录下，找到文件 `Default (Windows).sublime-keymap`，把 `ctrl+super+v` 换成 `ctrl+alt+v`。 [↩︎](https://jdhao.github.io/2017/03/04/Sublime-Windows-Markdown/#fnref:2)

Author jdhao

LastMod 2020-02-13

License [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/)