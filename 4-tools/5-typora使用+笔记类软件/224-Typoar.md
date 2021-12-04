# 优雅的 Typora

**前言**

上一篇介绍了markdown，说到其最大的优势在于完备的生态，那整个生态中最重要的当属编辑器了。今天就介绍一款我正在使用的 markdown 编辑器——[Typora](https://www.typora.io/)（官网国内访问不畅）。

[![img](F:\Typora_book\typora_pic\f024858b1bb83ef56ced69a0b035b3b4-1576372722469.jpg)](https://www.zypnet.cn/b25c/f024858b1bb83ef56ced69a0b035b3b4.jpg)

预警：Typora在GitHub上有一个账号，但是软件本身并不开源，账号上开源的都是Typora的语言包、文档、主题等。官网最下面有句话Only free during beta. Available for mac OS X 10.9 and later，Typora当下依旧免费，但是作者应该有后期商用计划。
请事先==打开即使渲染功能==，默认并不开启。这样你每输入一段源码，它就即使将其渲染为预览结果，你写到哪它就渲染到哪，这样你操作的都是源码，但是看到的都是预览，再也不用两头兼顾了。如下图所示：

[![img](F:\Typora_book\typora_pic\typora-gif-1576372722557.gif)](https://www.zypnet.cn/b25c/typora-gif.gif)

**完备的语法支持**


Typora对于Markdown基础语法的支持十分完备，对一些高级语法的支持也考虑周全，满足一般人需求基本没有问题。配合快捷键，用起来行云流水，包括但不限于以下：



- 各种内联格式：支持emoji，完整的[emoji参考](https://github.com/guodongxiaren/README/blob/master/emoji.md)；各种超链接，如内部跳转链接、外部文件链接、外部网络链接；高亮；删除线；下划线；上下标；内联数学公式等

  <img src="F:\Typora_book\typora_pic\inline-1576372723078.png" alt="img" style="zoom: 50%;" />

- 图片支持：图片的插入可以设置为，插入后自动复制图片到相对路径下，此路径可以在YAML Front Matters

  中设置，详情见官方Support

  <img src="F:\Typora_book\typora_pic\image-1576372723331.png" alt="img" style="zoom:50%;" />

- TOC-Table Of Content目录：

  <img src="F:\Typora_book\typora_pic\toc-1576372723935.png" alt="img" style="zoom: 33%;" />

- 列表：有序列表；无序列表；任务计划表

  <img src="F:\Typora_book\typora_pic\lists-1576372724105.png" alt="img" style="zoom:33%;" />

- 独立数学公式：

  <img src="F:\Typora_book\typora_pic\math-1576372724273.png" alt="img" style="zoom:50%;" />

- 各种作图：次序图、流程图、甘特图。支持Mermaid语法

  <img src="F:\Typora_book\typora_pic\diagram-1576372724448.png" alt="img" style="zoom:50%;" />

- 表格、独立代码块、内联代码块、脚注、引用等


以上功能有一些需要在调整设置。


**高级功能专注模式**


Typora完美解决了Markdown源码与预览相互干扰的问题，但是作者还嫌你不够专注，特意制作了专注模式。在此模式下，只有你当前编辑的块会显示，其他的会被模糊化：

[<img src="F:\Typora_book\typora_pic\snipaste20180325_150933-1576372724577.png" alt="img" style="zoom: 80%;" />](https://www.zypnet.cn/b25c/snipaste20180325_150933.png)

**历史恢复**


这其实不是什么高级功能，像word这种重量级编辑器都会有。但是一般Markdown编辑器都属于轻量级，有的根本就没有这项功能。Typora的历史恢复功能其实非常简单粗暴，每隔5分钟自动保存一个副本，副本总上限最多500个，这些参数在设置->高级设置中：



1. "autoSaveTimer" : 5, // default 5 minutes
2. "maxFetchCountOnFileList": 500

*复制代码*




然后需要恢复的时候，它就直接把副本文件夹扔给你就完事了，不走心啊。要我说最完美的设计应该是整合git后提供简化操作给用户。

导入导出

前一篇我们说过，markdown是不可能替代word的。倘若你最近开始喜欢用Markdown写文档，但是你的同学们都还在用word，就算你写的再有效率，如何把你写的东西给别人看啊，word不支持markdown啊。如果要是能在docx格式与markdown之间互转就好了。
这还真不是什么难事，以markdown那轻量级的小身板，转html、docx、epub等都不是难事：



[![img](F:\Typora_book\typora_pic\snipaste20180325_153515-1576372724619.png)](https://www.zypnet.cn/b25c/snipaste20180325_153515.png)


反过来转也可以，但是肯定存在排版信息的丢失：



[![img](F:\Typora_book\typora_pic\snipaste20180325_153705-1576372724623.png)](https://www.zypnet.cn/b25c/snipaste20180325_153705.png)


Markdown文档的格式转换基本都是通过一个强大的软件实现的，我先卖个关子，下篇再说。

搜索联动 
在文件中选中字符后可以右键谷歌搜索，其实这个是可以自定义：



[![img](F:\Typora_book\typora_pic\snipaste20180325_154301-1576372724661.png)](https://www.zypnet.cn/b25c/snipaste20180325_154301.png)


在设置->高级设置的json文件中，做如下修改，两个文件都要改：



1. "searchService": [
2.   ["Search with Google", "https://google.com/search?q=%s"],
3.   ["Search with Baidu", "https://www.baidu.com/s?wd=%s&ie=UTF-8"],
4.   ["Search with Github", "https://github.com/search?q=%s&utf8=%E2%9C%93"]
5.  ],

*复制代码*
我添加了Baidu与GitHub，看个人喜好。


**主题自定义**


Typora由于使用html编写界面，所以其主题可自定义程度非常高，不怎么懂html+css也没关系，去官网Support页面看看，照葫芦画瓢也差不多了。或者去GitHub上寻找别人制作好的主题下载到主题文件夹即可。

拼写检查


这个功能同样是word这样的软件必备，但是轻量级编辑器少有的。检查出错的单词会以红线标记，右键会给出可能的纠正方案，如果你认为就是没写错，可以点击Learn Spelling，它就将他纳入词库。遗憾的是，目前只支持英文，对于我们来说有点鸡肋了。



[![img](F:\Typora_book\typora_pic\snipaste20180325_155500-1576372724698.png)](https://www.zypnet.cn/b25c/snipaste20180325_155500.png)

**尾言**


为了写这个系列的文章，我也去寻找了许多Markdown编辑器，发现短短两年，现在Markdown的生态已经强大了许多。各种服务使用Markdown，也使得Markdown编辑器不断进化。


MWeb（收费）这款Mac平台上的编辑器，集成了图床、云盘、各大博客框架、文档库服务等，强大到没边；Inkdrop（收费）编辑器，基础功能简单，但是强大的插件化功能赋予更大的定制化空间；开源界也有Boostnote（免费）这种怎么看怎么像为了装X而生的编辑器；论优雅，Mac（免费）上的Mou也不遑多让。这充分体现了生态的强大力量。


这让把这个坑开到一半的我，感觉闲来无事写个文章也要被大佬们笑话了。想想两年前萌新的我，第一次接触到Markdown，满世界寻找编辑器，最后找到了Typora，十分满足，想不到今天也变成了井底之蛙，这个世界真的变化好快。现在我仍然愿意把Typora作为我心中最好的本地离线编辑器，是它带领我走入了Markdown的世界，也是从那时开始爱上编程。不过还是得加把劲啊，有空试试Boostnote，顺便祈祷MWeb啥时候出windows版，穷X买不起Mac啊！