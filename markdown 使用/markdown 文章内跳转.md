## 																				123

【更新】
typora已经支持更简单的连接跳转（link部分只写一个#就可以）
[Internal Links](https://support.typora.io/Links/#Internal Links)
谢谢@[JinTianWeiLai](https://www.jianshu.com/u/39208f967429) 提供信息Typora是一款非常简洁的轻量化markdown编辑器，下面介绍一下如何在Typora中添加内部跳转链接，实现内部跳转。

## 其他markdown编辑器的实现方法

在网上会查到一些其他编辑器提供的内部跳转方法使用，`<span>`标签来实现。

但是在Typora中这个方法行不通了，官方文档里说了：

> Span elements will be parsed and rendered right after your typing. Moving cursor in middle of those span elements will expand those elements into markdown source. Following will explain the syntax of those span element.

------

**这里的空白是为了能看出跳转的效果**
**这里的空白是为了能看出跳转的效果**
**这里的空白是为了能看出跳转的效果**
**这里的空白是为了能看出跳转的效果**
**这里的空白是为了能看出跳转的效果**
**这里的空白是为了能看出跳转的效果**
**这里的空白是为了能看出跳转的效果**
**这里的空白是为了能看出跳转的效果**
**这里的空白是为了能看出跳转的效果**
**这里的空白是为了能看出跳转的效果**
**这里的空白是为了能看出跳转的效果**

------

## Typora的实现方式

Typora==可以直接使==用header来跳转，方法是使用一个引用自`header`的`href`

比如：

```html
<a href="#其他markdown编辑器的实现方法">点击跳转</a>
```

按住Ctrl(Cmd)点击下面的连接就会跳到“其他markdown编辑器的实现方法”这一小节标题

<a href="#其他markdown编辑器的实现方法">点击跳转</a>

































asdfasd



asdf

[123](#123)

<a href="##123">点击跳转</a>



7人点赞



[TIPS](https://www.jianshu.com/nb/1400710)

