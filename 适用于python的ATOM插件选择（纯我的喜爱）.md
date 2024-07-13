# 适用于python的ATOM插件选择（纯我的喜爱）

[toc]

2020年08月02日 阅读数：53

这篇文章主要向大家介绍适用于python的ATOM插件选择（纯我的喜爱）,主要内容包括基础应用、实用技巧、原理机制等方面，希望对大家有所帮助。



在通过N屡次的尝试，比较，踩坑再脱坑，增长再删减，终于肯定了一份适用于Python开发的atom插件，下面可能插件清单以下：
## Hydrogen
不管是单步运行，仍是总体运行都很自如，很给力的插件。
## MagicPython
替代atom默认的language-python,python基本的诸如自动缩进和智能换行。
## atom-ide-ui
与linter互斥，错误输出ui平台,里面使能各项功能
## atom-python-run
F5,走起，F6，带着时间走起;不过貌似没啥差异;
## autocomplete-paths
自动补全路径，没啥好说
## autocomplete-python
python的自动补全，里面的tooltips挺好用的.
而后我一般喜欢把autocomplete function parameters 选成all，这样我在写方法的时候会自动补全全部方法。
20180402 这个包第一个选项是勾选kite(在线补全工具），这个在网速好的状况下仍是比较好用，除了嵌入到atom插件中，kite也是一个独立的软件，有时我也用它来单独查看方法，里面嵌入了方法和例子，挺好用，不过目前在linux下不支持，遗憾了些。
## data-atom
链接数据库，凑合能用,不过得改下快捷键，跟atom-python-run冲突.
## file-icons
美化图标，没啥可说的。
## git-plus
ctl-shift-h,快到碗里来!
## highlight-line
高亮行，没啥可说的.
## highlight-selected
高亮选中，没啥可说的.
## hyperclick
超连接，嗯。。。。跟atom-ide-ui中的冲突，留一个就行。
## ide-python
各类语法提示，我的感受要比linter好用
## minimap
## minimap-cursorline
## minimap-find-and-replace
## minimap-git-diff
## minimap-highlight-selected
整个atom里面用的最舒服的功能，脱离了滚轮，脱离了上下翻页，脱离了git diff，炒鸡好用。
## platformio-ide-terminal
做为一个编辑器，怎能没有terminal呢
## python-indent
自动缩进，没啥好说的，
## python-tools
查看变量定义，查看变量使用，没啥好说的。
## simplified-chinese-menu
中文菜单，没啥好说的。
## symbols-tree-view
minimap在窗口左，它在窗口右，一边看全局，一边看架构，hin好！html

20180401新增
## vim-mode-plus，vim模式python

20180404新增
## django-templates, 若是你跟我同样用django， 那么这个插件应该适合你，这个插件解决了django模板语言嵌入html文件的问题，不过咱们须要按照readme的内容进行相应设置，主要就两点：
（1） 填写项目文件夹；
（2） 在“用户键盘映射”里面加入下面语句：linux

```
'atom-text-editor[data-grammar="text html django"]:not([mini])':
      'tab': 'emmet:expand-abbreviation-with-tab'
```

ok，大功告成，咱们能够愉快的写django模板语言了。git

其实为啥要选编辑器不直接选pycharm呢，速yin度wei快mei啊qian，早先在官网看这个插件也挺好，那个插件也挺好，而后开一堆，运行时间久了内存吃的高，运行速度明显下降，而后我才忽然意识到，速度快与功能多本就很难兼得，当初我退出pycharm也有一部分缘由是启动等待时间太特么长了，四开窗口太特么卡了，各类用的上的用不上的功能看着也闹心，所以也给犹豫选什么编程工具的童鞋们一些建议：我想要编辑器具备什么样的功能就能知足编程使用了，是大而全仍是少而精，这样就能有针对性的选择本身满意的编程工具了。有选择性的安装插件，既提升了编程效率，本身用的也爽，下面是我通常状况下禁用的插件，按需开启，保持atom高效运行。
## atom-beautify
## atom-bootstrap
## atom-html-preview
## autoclose-html
## busy-signal
## docblockr
## emmet
## intentions
## linter
## linter-pycodestyle
## linter-ui-default
## merge-conflicts
## python-autopep8
## python-debugger
## script
## tool-barweb

就这样吧，最近atom配置都快吐了，家里的电脑，公司的电脑，领导的服务器，不过最近据说VSC已经绑定到anaconda了，在犹豫要不要尝试下VSC呢。数据库
