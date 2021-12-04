# 工具类Atom中的markdown插件

一直以来都奢想拥有一款全能好用的Markdown编辑器，直到遇到了Atom。废话不多说，直接开搞！

1. 安装Atom

![20200522_233556_17](image/20200522_233556_17.png)

下载安装Atom：https://atom.io/


2. 增强预览(markdown-preview-plus)

Atom自带的Markdown预览插件markdown-preview功能比较简单，markdown-preview-plus对其做了功能扩展和增强。

支持预览实时渲染。(Ctrl + Shift + M)

支持Latex公式。(Ctrl + Shift + X)

使用该插件前，需要先禁用markdown-preview。

![20200522_233604_41](image/20200522_233604_41.png)

查看实时渲染和公式编辑功能。


3. 同步滚动(markdown-scroll-sync)

同步滚动是Markdown编辑器的必备功能，方便翻阅文档修改时能快速定位到预览的位置。

markdown-scroll-sync不仅支持同步滚动，在光标位置发生变更时也会同步滚动，这个功能在很多Markdown编辑器中不具备。


4. 代码增强(language-markdown)

一般的Markdown编辑器提供了代码着色等基本功能，language-markdown除了能给代码着色，还提供了快捷的代码片段生成等功能。


5. 图片粘贴(markdown-img-paste)

图片功能支持的好坏直接决定了我是否选择使用一个Markdown编辑器。也有不少编辑器和在线的图床绑定，但是这种方式受限于网络。虽然Markdown支持插入本地图片，但是每次插入新图片都是一堆重复操作：截图－命名－保存－插入。markdown-img-paste将这些操作一步完成：

使用截图工具将图片复制到系统剪切板。

在Markdown新起一行输入文件名。

Ctrl + shift+V 会自动把图片保存到Markdown文件相同目录下(因此要求Markdown文件应该先保存)，并命名为刚输入的文件名，同时在刚才输入文件名行处生成img标签。


当然，如果想插入gif动图就不能这么简单了，还是老老实实地下载这个工具手工插入吧。

LICEcap:http://www.cockos.com/licecap/

6. 表格编辑(markdown-table-editor)

一直对Markdown的table语法很无爱，直到遇到了markdown-table-editor，这操作效率简直炸了！文字已经不能表达我的激动之情了，直接看图吧。


7. pdf导出(markdown-themeable-pdf、pdf-view)

不少Markdown编辑器都会提供pdf导出功能，甚至将其作为收费功能。而Atom的markdown-themeable-pdf、pdf-view插件可以轻松实现pdf导出和预览功能。


安装markdown-themeable-pdf时遇到了一些坑，在此分享一下：

由于GFW的问题，导致该插件使用的phantomjs模块无法安装成功，从而导出pdf报告错误。


解决办法是：

从官网下载phantomjs二进制安装包：http://phantomjs.org/download.html

解压下载的phantomjs-2.1.1-macosx.zip压缩文件。

添加index.js文件到解压后的目录。

将整个目录的内容拷贝到：~/.atom/packages/markdown-themeable-pdf/node_modules/phantomjs-prebuilt，注意目录phantomjs-2.1.1-macosx被重命名为phantomjs-prebuilt

重启Atom，右键->Markdown to PDF即可，生成的pdf文件在Markdown文件同目录。

其中index.js文件内容为：

module.exports={path: __dirname+'/bin/phantomjs'}

8. 总结

以上介绍的Atom的Markdown插件，基本上满足了我对一个Markdown编辑器的所有幻想，实时渲染、同步滚动，公式、代码、图片、表格的快捷操作与支持，以及pdf文件导出、预览等。希望此文对你有所帮助。
