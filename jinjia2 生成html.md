# 使用JiaJa2通过模板生成文本文件

JiaJa2作为Flask框架中的模板系统被广泛使用,可以快速生成HTML文件;

JinJa2也可以单独使用通过模板快速生成自己想要的文件;

## python文件调用模板进行渲染的基本使用方法如下:

```python
from jinja2 import loaders, FileSystemLoader, Environment

# 指定模板文件搜索的开始位置
TemplateLoader = FileSystemLoader(searchpath="./", encoding='utf-8')
TemplateEnv = Environment(loader=TemplateLoader)
# 这里的文件位置是以searchpath作为基准的,而不是当前文件夹.
template = TemplateEnv.get_template("./test.html")
html = template.render({"config": config})
```

需要注意的是:
如果传到模板文件的变量config是一个列表(字典)等容器类型;
当config作为整体被使用时,渲染之后不会进行decode,造成的结果就是中文显示不出来,解决办法是在模板文件中将config中的元素一一取出;

- 模板文件正确写法

```JavaScript
{% for i in config %}
    i
{ endfor }
```

- 有问题的写法

```JavaScript
{{config}}  //直接渲染列表整体将造成里面的中文无法正常显示
```

------

## JiaJa2常用语法:

- 表示变量

```
{{变量}}
```

- 语句

```
{% for i in 变量名 %}
    {% if loop.index<10 %}
        i
    {% endif %}
{% endfor %}
```

- for循环中经常会结合的变量

| 写法        | 含义                               |
| ----------- | ---------------------------------- |
| loop.index  | 当前迭代的索引（从1开始）          |
| loop.index0 | 当前迭代的索引（从0开始）          |
| loop.first  | 是否是第一次迭代，返回True/False   |
| loop.last   | 是否是最后一次迭代，返回True/False |
| loop.length | 序列的长度                         |