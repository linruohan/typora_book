# [不知道如何关闭MD文件中的变量](https://stackoverflow.com/questions/53180242/dont-know-how-to-close-a-variable-in-an-md-file)

[问问题](https://stackoverflow.com/questions/ask)

问 1年零6个月前

活跃 [1年零6个月前](https://stackoverflow.com/questions/53180242/dont-know-how-to-close-a-variable-in-an-md-file?lastactivity)

浏览了 495次



0



我的GitHub项目有问题。我正在尝试通过trustworthy.netlify.com使其联机，但是存在一个pagebuild错误：

> 您的网站在构建时遇到问题：在函数/node_modules/balanced-match/README.md的第50行上的变量{{a}未使用}}关闭。有关更多信息，请参见https://help.github.com/articles/page-build-failed-tag-not-properly-terminated/。

我以为可以在{a}之后添加“}}”，但这是它所指的代码行：

```
If the `str` contains more `a` than `b` / there are unmatched pairs, the first match that was closed will be used. For example, `{{a}` will match `['{', 'a', '']` and `{a}}` will match `['', 'a', '}']`.
```

我对Markdown语言或GitHub的了解不足，甚至不知道该在哪里添加“}}”，而且我也不想在我的网站上无意中造成大问题。我该怎么办？

[的github](https://stackoverflow.com/questions/tagged/github) [建立](https://stackoverflow.com/questions/tagged/build) [降价](https://stackoverflow.com/questions/tagged/markdown) [github页面](https://stackoverflow.com/questions/tagged/github-pages) [自述文件](https://stackoverflow.com/questions/tagged/readme)

[分享](https://stackoverflow.com/q/53180242) [改善这个问题](https://stackoverflow.com/posts/53180242/edit) 跟随  

18年11月6日在21:24 问

[![img](https://lh4.googleusercontent.com/-tH_stYLX1Xk/AAAAAAAAAAI/AAAAAAAAAAA/APUIFaOGjc_LEBpMldOCaZhAWj0WZSDBUg/mo/photo.jpg?sz=32)](https://stackoverflow.com/users/10292404/jonathan-greco)

[乔纳森·格雷科](https://stackoverflow.com/users/10292404/jonathan-greco)

**35**44枚青铜徽章

- 您正在Github上进行版本控制，并在Netlify上进行部署。此错误来自何处（github页面或netlify部署）？您正在使用Jekyll吗？ – [大卫·雅克](https://stackoverflow.com/users/1548376/david-jacquel) （ [David Jacquel）'18 ](https://stackoverflow.com/users/1548376/david-jacquel)[十一月7'在20:11](https://stackoverflow.com/questions/53180242/dont-know-how-to-close-a-variable-in-an-md-file#comment93282673_53180242)

[添加评论](https://stackoverflow.com/questions/53180242/dont-know-how-to-close-a-variable-in-an-md-file#)



## 1个回答

[活性](https://stackoverflow.com/questions/53180242/dont-know-how-to-close-a-variable-in-an-md-file?answertab=active#tab-top)[最老的](https://stackoverflow.com/questions/53180242/dont-know-how-to-close-a-variable-in-an-md-file?answertab=oldest#tab-top)[投票数](https://stackoverflow.com/questions/53180242/dont-know-how-to-close-a-variable-in-an-md-file?answertab=votes#tab-top)





2







您需要使用`{% raw %}`和来转义模板语法`{% endraw %}`。

Jekyll在[将](https://jekyllrb.com/docs/liquid/)您的Markdown传递给[Liquid](https://shopify.github.io/liquid/)模板系统之前，先将其解析为Markdown。这使您可以在文档中定义变量，Liquid会将这些变量换成内容。然后，将现在完整的文档传递给Markdown解析器，以将其转换为HTML。

当您想在文档中包含变量时这很有用，但是当您希望在Markdown中将诸如语法之类的模板作为代码样本时，这会很烦人。很容易假设由于模板语法在代码块或跨度中，因此将被忽略。但是，Liquid不了解Markdown语法，也无法说出实际模板变量和代码样本之间的区别。

在您的特殊情况下，Liquid提出了一个错误，坚持认为`{{a}`应该是`{{a}}`。当然，这是不正确的。`{{a}`仅仅是Markdown中的代码示例。但是Jekyll从来没有去过Markdown解析器，因为它挂在Liquid视为模板语法错误的东西上了。因此，您需要使用Liquid的[转义机制](https://github.com/Shopify/liquid/wiki/Liquid-for-Designers#raw)来告诉Liquid忽略代码示例：

```
{% raw %}
If the `str` contains more `a` than `b` / there are unmatched pairs, 
the first match that was closed will be used. For example, `{{a}` 
will match `['{', 'a', '']` and `{a}}` will match `['', 'a', '}']`.
{% endraw %}
```

通过将完整的段落包装在`{% raw %}`和`{% endraw %}`标记中，我们告诉Liquid忽略其内容并将其原样传递。Liquid将删除原始标签，Markdown解析器将收到您想要的内容。



[分享](https://stackoverflow.com/a/53192648) [改善这个答案](https://stackoverflow.com/posts/53192648/edit) 跟随  