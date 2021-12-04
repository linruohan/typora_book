![](D:/Typora_pic//markdown parser-- Mistune0.png)# Mistune: Python Markdown Parser

Release v2.0.0a4.

A fast yet powerful Python Markdown parser with renderers and plugins, compatible with sane CommonMark rules.

Using old Mistune? Checkout docs: https://mistune.readthedocs.io/en/v0.8.4/

## Installation

Installing Mistune is quite easy with [pip](http://www.pip-installer.org/):

```
$ pip install mistune==2.0.0a4
```

Mistune has no external dependencies.

## User Guide



### Introduction

#### Extendable

The v2 Mistune is created to be extendable. With the plugins and directives system, developers can extend it easily.

#### Sane CommonMark

CommonMark has paid too much attention to the insane cases. Their tests contain so many weird cases that normal people wouldn’t write. Instead, they missed some real problematic cases, take an example:

```
[<https://lepture.com>](/hello)
```

It turns out on https://spec.commonmark.org/dingus/:

```
<p><a href="/hello"><a href="https://lepture.com">https://lepture.com</a></a></p>
```

A link can not contain another link in HTML. This case is an usual case, unlike other cases, we may generate different HTML in different parsers, but we should not generate invalid HTML.

Mistune has tests for CommonMark, but when some insane tests failed, we ignore them.

#### Safety



### How to Use Mistune

Mistune is super easy to use. Here is how you can convert Markdown formatted text into HTML:

```
import mistune

mistune.html(YOUR_MARKDOWN_TEXT)
```

The `.html()` methods has enabled all the features you might want by default:

- No escape of HTML tags
- With **strikethough** plugin
- With **table** plugin
- With **footnote** plugin

#### Customize Mistune

Mistune provides a function to create Markdown instance easily:

```
import mistune

markdown = mistune.create_markdown()
```

This method will create a “escaped” Markdown instance without any plugins, which means:

```
markdown('<div>hello</div>')
# ==>
'<p>&lt;div&gt;hello&lt;/div&gt;</p>'
```

Non escaped version:

```
markdown = mistune.create_markdown(escape=False)
markdown('<div>hello</div>')
# ==>
'<div>hello</div>'
```

Adding plugins:

```
markdown = mistune.create_markdown()
markdown('~~s~~')
# ==>
'<p>~~s~~</p>'

markdown = mistune.create_markdown(plugins=['strikethough'])
markdown('~~s~~')
# ==>
'<p><del>s</del></p>'
```

Find out what plugins mistune has built-in in [**Mistune Markdown Plugins**](index.html#plugins) sections.

#### Customize Renderer

Mistune supports renderer feature which enables developers to customize the output. For instance, to add code syntax highlight:

```
import mistune
from pygments import highlight
from pygments.lexers import get_lexer_by_name
from pygments.formatters import html


class HighlightRenderer(mistune.HTMLRenderer):
    def block_code(self, code, lang=None):
        if lang:
            lexer = get_lexer_by_name(lang, stripall=True)
            formatter = html.HtmlFormatter()
            return highlight(code, lexer, formatter)
        return '<pre><code>' + mistune.escape(code) + '</code></pre>'

markdown = mistune.create_markdown(renderer=HighlightRenderer())

print(markdown('```python\nassert 1 == 1\n```'))
```

In this way, we can use Pygments to highlight the fenced code. Learn more at [**Use renderers**](index.html#renderers).

#### AstRenderer

Mistune can produce AST by default with `mistune.AstRenderer`:

```
markdown = mistune.create_markdown(renderer=mistune.AstRenderer())
```

This `markdown` function will generate tokens instead of HTML.





### Mistune Markdown Plugins

#### strikethrough

```
~~here is the content~~
```

`mistune.html()` has enabled strikethrough plugin by default. To create a markdown instance your own:

```
markdown = mistune.create_markdown(plugins=['strikethrough'])
```

Another way to create your own Markdown instance:

```
from mistune.plugins import plugin_strikethrough

renderer = mistune.HTMLRenderer()
markdown = mistune.Markdown(renderer, plugins=[plugin_strikethrough])
```

#### footnotes

```
content in paragraph with footnote[^1] markup.

[^1]: footnote explain
```

`mistune.html()` has enabled footnote plugin by default. To create a markdown instance your own:

```
markdown = mistune.create_markdown(plugins=['footnotes'])
```

Another way to create your own Markdown instance:

```
from mistune.plugins import plugin_footnotes

renderer = mistune.HTMLRenderer()
markdown = mistune.Markdown(renderer, plugins=[plugin_footnotes])
```

#### table

Simple formatted table:

```
First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell
```

Complex formatted table:

```
| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |
```

Align formatted table:

```
 Left Header |  Center Header  | Right Header
:----------- | :-------------: | ------------:
 Conent Cell |  Content Cell   | Content Cell


| Left Header |  Center Header  | Right Header  |
| :---------- | :-------------: | ------------: |
| Conent Cell |  Content Cell   | Content Cell  |
```

`mistune.html()` has enabled table plugin by default. To create a markdown instance your own:

```
markdown = mistune.create_markdown(plugins=['table'])
```

Another way to create your own Markdown instance:

```
from mistune.plugins import plugin_table

renderer = mistune.HTMLRenderer()
markdown = mistune.Markdown(renderer, plugins=[plugin_table])
```

#### url

URL plugin enables creating link with raw URL by default:

```
For instance, https://typlog.com/
```

Will be converted into:

```
<p>For instance, <a href="https://typlog.com/>https://typlog.com/</a></p>
```

This plugin is **NOT ENABLED** by default in `mistune.html()`. Mistune values explicit, and we suggest writers to write links in:

```
<https://typlog.com/>
```

To enable **url** plugin with your own markdown instance:

```
markdown = mistune.create_markdown(plugins=['url'])
```

Another way to create your own Markdown instance:

```
from mistune.plugins import plugin_url

renderer = mistune.HTMLRenderer()
markdown = mistune.Markdown(renderer, plugins=[plugin_url])
```

#### task_lists

Task lists plugin enables creating GitHub todo items:

```
- [x] item 1
- [ ] item 2
```

Will be converted into:

```
<ul>
<li class="task-list-item"><input class="task-list-item-checkbox" type="checkbox" disabled checked/>item 1</li>
<li class="task-list-item"><input class="task-list-item-checkbox" type="checkbox" disabled/>item 2</li>
</ul>
```

This plugin is **NOT ENABLED** by default in `mistune.html()`. To enable **task_lists** plugin with your own markdown instance:

```
markdown = mistune.create_markdown(plugins=['task_lists'])
```

Another way to create your own Markdown instance:

```
from mistune.plugins import plugin_task_lists

renderer = mistune.HTMLRenderer()
markdown = mistune.Markdown(renderer, plugins=[plugin_task_lists])
```



### Directives

Directive is a special plugin which is inspired by reStructuredText. The syntax is very powerful:

```
.. directive-name:: directive value
   :option-key: option value
   :option-key: option value

   full featured markdown text here
```

It was designed to be used by other plugins. There are three built-in plugins based on directive.

#### Admonitions

```
.. warning::

   You are looking at the **dev** documentation. Check out our
   [stable](/stable/) documentation instead.
```

Admonitions contains a group of `directive-name`:

```
attention  caution  danger  error
hint  important  note  tip  warning
```

To enable admonitions:

```
import mistune
from mistune.directives import Admonition

markdown = mistune.create_markdown(
    plugins=[Admonition()]
)
```

#### TOC Plugin

```
.. toc:: Table of Contents
   :depth: 3
```

TOC plugin is based on directive. It can add a table of contents section in the documentation. Let’s take an example:

```
Here is the first paragraph, and we put TOC below.

.. toc::

# H1 title

## H2 title

# H1 title
```

The rendered HTML will show a TOC at the `.. toc::` position. To enable TOC plugin:

```
import mistune
from mistune.directives import DirectiveToc

markdown = mistune.create_markdown(
    plugins=[DirectiveToc()]
)
```

#### Include

```
.. include:: hello.md
```

`include` is a powerful plugin for documentation generator. With this plugin, we can embed contents from other files.



### Advanced Guide of Mistune



#### Use renderers

You can customize HTML output with your own renderers. Create a subclass of `mistune.HTMLRenderer`:

```
class MyRenderer(mistune.HTMLRenderer):
    def codespan(self, text):
        if text.startswith('$') and text.endswith('$'):
            return '<span class="math">' + escape(text) + '</span>'
        return '<code>' + escape(text) + '</code>'

# use customized renderer
markdown = mistune.create_markdown(renderer=MyRenderer())
print(markdown('hi `$a^2=4$`'))
```

Here is a a list of available renderer functions:

```
# inline level
text(self, text)
link(self, link, text=None, title=None)
image(self, src, alt="", title=None)
emphasis(self, text)
strong(self, text)
codespan(self, text)
linebreak(self)
newline(self)
inline_html(self, html)

# block level
paragraph(self, text)
heading(self, text, level)
thematic_break(self)
block_text(self, text)
block_code(self, code, info=None)
block_quote(self, text)
block_html(self, html)
block_error(self, html)
list(self, text, ordered, level, start=None)
list_item(self, text, level)

# provided by strikethrough plugin
strikethrough(self, text)

# provide by table plugin
table(self, text)
table_head(self, text)
table_body(self, text)
table_row(self, text)
table_cell(self, text, align=None, is_head=False)

# provided by footnotes plugin
footnote_ref(self, key, index)
footnotes(self, text)
footnote_item(self, text, key, index)
```



#### Create plugins

Mistune has some built-in plugins, you can take a look at the source code in `mistune/plugins` to find out how to write a plugin. Let’s take an example for GitHub Wiki links: `[[Page 2|Page 2]]`.

A mistune plugin usually looks like:

```
# define regex for Wiki links
WIKI_PATTERN = (
    r'\[\['                   # [[
    r'([\s\S]+?\|[\s\S]+?)'   # Page 2|Page 2
    r'\]\](?!\])'             # ]]
)

# define how to parse matched item
def parse_wiki(self, m, state):
    # ``self`` is ``md.inline``, see below
    # ``m`` is matched regex item
    text = m.group(1)
    title, link = text.split('|')
    return 'wiki', link, title

# define how to render HTML
def render_html_wiki(link, title):
    return f'<a href="{link}">{title}</a>'

def plugin_wiki(md):
    # this is an inline grammar, so we register wiki rule into md.inline
    md.inline.register_rule('wiki', WIKI_PATTERN, parse_wiki)

    # add wiki rule into active rules
    md.inline.rules.append('wiki')

    # add HTML renderer
    if md.renderer.NAME == 'html':
        md.renderer.register('wiki', render_html_wiki)

# use this plugin
markdown = mistune.create_markdown(plugins=[plugin_wiki])
```

Get more examples in `mistune/plugins`.



#### Write directives





### API Reference

- `mistune.``html`(*text*)

  PARAMETERS:**text** – markdown formatted textTurn markdown text into HTML without escaping. For instance:`text = '**hello** <span>world</span>' mistune.html(text) # => '<p><strong>hello</strong> <span>world</span></p>' `

- `mistune.``create_markdown`(*escape=True*, *renderer=None*, *plugins=None*)

  Create a Markdown instance based on the given condition.PARAMETERS:**escape** – Boolean. If using html renderer, escape html.**renderer** – renderer instance or string of `html` and `ast`.**plugins** – List of plugins, string or callable.This method is used when you want to re-use a Markdown instance:`markdown = create_markdown(    escape=False,    renderer='html',    plugins=['url', 'strikethrough', 'footnotes', 'table'], ) # re-use markdown function markdown('.... your text ...') `



### Changelog

Here is the full history of mistune v2.

#### Version 2.0.0a1

Released on Dec 7, 2019

This is the first release of v2. Features included:

- whole new mistune
- plugins
- directives