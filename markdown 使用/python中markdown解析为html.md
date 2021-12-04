# 使用misaka格式化GFM markdown

> python里`markdown`和`markdown2`各有缺点， markdown不支持GFM代码格式， markdown2 虽说可以支持， 但格式化之后的代码下面有下划线， 找了好多原因， 未解。google过程中发现markdown2不好的消息， markdown2作者经常自我吹嘘， 而我在github看源码的时候， 觉得markdown2开发结构不是很好。所以抛弃markdown， 选择其他。

在众多的python markdown parsers我们该如何选择呢？

这里[Markdown Parsers in Python](https://link.jianshu.com/?t=http://lepture.com/en/2014/markdown-parsers-in-python)对python几个常用markdown parser多了对比评测， 最后我选择了`misaka`。

`misaka` 里， 没有直接对`pygments`封装生成代码高亮的逻辑，所以代码高亮部分需要定义一遍。

**Code Example**

定义`code` 渲染类， 然后在实例化`Markdown`的加入自定义的渲染类即可。

~~~python
# -*- coding: utf-8 -*-
import misaka as m
from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import HtmlFormatter
 
# Create a custom renderer
class BleepRenderer(m.HtmlRenderer, m.SmartyPants):
    def block_code(self, text, lang):
        if not lang:
            return '\n<pre><code>%s</code></pre>\n' % \
                text.strip()
        lexer = get_lexer_by_name(lang, stripall=True)
        formatter = HtmlFormatter()
        return highlight(text, lexer, formatter)

if __name__ == '__main__':
    # And use the renderer
    renderer = BleepRenderer()
    md = m.Markdown(renderer,
        extensions=m.EXT_FENCED_CODE | m.EXT_NO_INTRA_EMPHASIS)

    print md.render("""```python
    # -*- coding:utf-8 -*-
    import os
    import sys
    ```""")
~~~