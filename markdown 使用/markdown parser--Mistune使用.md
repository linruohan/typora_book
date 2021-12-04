- ```python
  import mistune
  from mistune import escape, escape_html, escape_url
  from pygments import highlight
  from pygments.lexers import get_lexer_by_name
  from pygments.formatters import html
  from mistune.plugins import plugin_strikethrough, plugin_footnotes, plugin_table, plugin_url
  import mistune_contrib
  from mistune.directives import Admonition
  from mistune.directives import DirectiveToc
  
  
  # 自定义高亮渲染器
  class HighlightRenderer(mistune.HTMLRenderer):
      def block_code(self, code, lang=None):
          if lang:
              lexer = get_lexer_by_name(lang, stripall=True)
              formatter = html.HtmlFormatter()
              return highlight(code, lexer, formatter)
          return '<pre><code>' + escape(code) + '</code></pre>'
  
  
  class TasklistsRenderer(mistune.HTMLRenderer):
      def list_item(self, item, level=None):
          if '[ ]' in item:
              line = item.replace(r'[ ] ', '').strip()
              return '<li class="task-list-item"><input class="task-list-item-checkbox" type="checkbox" disabled/>' + escape(
                  line) + '</li>\n'
          else:
              line = item.replace(r'[x] ', '').replace(r'[X] ', '').strip()
              return '<li class="task-list-item"><input class="task-list-item-checkbox" type="checkbox" disabled checked/>' + escape(
                  line) + '</li>\n'
  
  
  markdown = mistune.create_markdown(renderer=HighlightRenderer(),
                                     plugins=[plugin_strikethrough, plugin_footnotes, plugin_table, plugin_url])
  print(markdown('```python\nassert 1 == 1\n```'))
  markdown = mistune.create_markdown(renderer=TasklistsRenderer())
  print(markdown('- [x] item 1\n- [ ] item 2'))
  
  # directive格式
  '''
  .. directive-name:: directive value
  :option-key: option value
  :option-key: option value
  
  full featured markdown text here
  '''
  text = '''
  
  .. warning::
  
     You are looking at the **dev** documentation. Check out our
     [stable](/stable/) documentation instead.
  '''
  markdown = mistune.create_markdown(plugins=[Admonition()])
  print(markdown(text))
  
  toc = '''Here is the first paragraph, and we put TOC below.
  
  .. toc::
  
  # H1 title
      
  ## H2 title
  
  # H1 title'''
  markdown = mistune.create_markdown(
      plugins=[DirectiveToc()]
  )
  print(markdown(toc))
  ```