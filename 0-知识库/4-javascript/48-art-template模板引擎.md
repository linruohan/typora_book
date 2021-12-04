# 模板引擎 -- art-template

# 1 介绍：

> art-template 是一个简约、超快的模板引擎。
> 它采用作用域预声明的技术来优化模板渲染速度，从而获得接近 JavaScript 极限的运行性能，并且同时支持 NodeJS 和浏览器。

#### 1.1 模板语法：

> art-template 同时支持两种模板语法。标准语法可以让模板更容易读写；原始语法具有强大的逻辑处理能力。

**标准语法**

```html
{{if user}}
<h2>{{user.name}}</h2>
{{/if}}
```

**原始语法**

```html
<% if (user) { %>
<h2><%= user.name %></h2>
<% } %>
```

#### 1.2 核心方法：

```js
// 基于模板名渲染模板
template(filename, data);

// 将模板源代码编译成函数
template.compile(source, options);

// 将模板源代码编译成函数并立即执行
template.render(source, data, options);
```

# 2 安装

#### 2.1 安装方法:

- 通过npm安装: `npm install art-template --save`
- 下载安装

#### 2.2 在浏览器中编译

因为浏览器不支持文件系统，所以 template(filename, data) 不支持传入文件路径，它内部使用 document.getElementById(filename).innerHTML 来获取模板，例如：

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <!-- 引入template-web.js -->
    <script src="./node_modules/art-template/lib/template-web.js"></script>
</head>
<body>
    <div id="container"></div>
    <!-- 创建 script 标签创建模板,注意下面几点 -->
    <!-- 1. type="text/该斜杠后可以是 html,template... 不是script即可)" -->
    <!-- 2. 给 script 标签添加 id ，此 id 即为模板 id -->
    <!-- 3.模板 script 标签必须在 template() 方法调用的 script 标签之前 -->
    <script type="text/html" id="tpl">
        {{if user}}
        <h2>{{user.name}}</h2>
        {{/if}}
    </script>
    <script>
        var user = {
            name: 'Template username'
        }
        var html = template('tpl', {user: user})
        var container = document.querySelector('#container');
        container.innerHTML = html;
    </script>
</body>
</html>
```

浏览器打开看到的结果如下：

<img src="D:\Typora_pic\12110282-30ccb7069087403b.webp" alt="img" style="zoom: 67%;" />

# 3 语法

> 标准语法支持基本模板语法以及基本 JavaScript 表达式；原始语法支持任意 JavaScript 语句，这和 EJS 一样。

#### 3.1 输出

------

**标准语法**

```html
{{value}}
{{data.key}}
{{data['key']}}
{{a ? b : c}}
{{a || b}}
{{a + b}}
```

**原始语法**

```html
<%= value %>
<%= data.key %>
<%= data['key'] %>
<%= a ? b : c %>
<%= a || b %>
<%= a + b %>
```

#### 3.2 原文输出

------

**标准语法**

```html
{{@ value}}
```

**原始语法**

```html
<%- value %>
```

#### 3.3 条件输出

------

**标准语法**

```html
<!-- 单 if 判断 -->
{{if value}} 
... 
{{/if}}

<!-- if ... else ... 判断 -->
{{if v1}} 
... 
{{else if v2}}
 ... 
{{/if}}
```

**原始语法**

```html
<!-- 单 if 判断 -->
<% if (value) { %>
...
<% } %>

<!-- if ... else ... 判断 -->
<% if (v1) { %>
...
<% else if (v2) { %>
...
<% } %>
```

#### 3.4 循环输出

------

**标准语法**

```html
{{each target}}
  {{$index}} {{$value}}
{{/each}}
```

> `target`是一个数组，`each`用于对数组遍历，`$index` 是数组的下标， `$value`是数组的值

**原始语法**

```html
<% for (var i = 0; i < target.length; i++) { %>
<%= i %> <%= target[i] %>
<% } %>
```

`注意`:

1. `target` 支持 `array` 与`object` 的迭代，其默认值为 `$data`。
   具体看下面的例子：

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="./node_modules/art-template/lib/template-web.js"></script>
</head>
<body>
    <div id="container"></div>
    <script type="text/html" id="tpl">
        <ul>
            {{each user.arr}}
            <li>
                {{$index + 1}} ---- {{$value.type}} ---- {{$value.price}}
                {{$data}}
            </li>
            {{/each}}
        </ul>
    </script>
    <script>
        var user = {
            obj: {
                name: 'Bruce Lee',
                age: 32,
                gender: 'male'
            },
            arr: [
                {type: 1, price: 10},
                {type: 2, price: 12},
                {type: 3, price: 18}
            ] 
        }
        var html = template('tpl', {user: user})
        var container = document.querySelector('#container');
        container.innerHTML = html;
    </script>
</body>
</html>
```

看输出结果：

![img](D:\Typora_pic\12110282-8b8b2f7aceefe808.webp)

each遍历对象target(默认为$data).png

图中可以看出`$data`其实就是传入模板的总数据对象(原始数据对象)

1. `$value` 与 `$index` 可以自定义：`{{each target val key}}`。
   具体看下面例子：

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="./node_modules/art-template/lib/template-web.js"></script>
</head>
<body>
    <div id="container"></div>
    <script type="text/html" id="tpl">
        <h4>each 遍历数组，采用默认的索引 $index 和默认的值 $value</h4>
        <ul>
            <!-- each 遍历数组，采用默认的索引 $index 和默认的值 $value -->
            {{each user.arr}}
            <li>
                {{$index}} ---- {{$value}}
            </li>
            {{/each}}
        </ul>

        <h4>each 遍历数组, 采用自定义的索引 b 和默认的值 a</h4>
        <ul>
            <!-- each 遍历数组, 采用自定义的索引 a 和默认的值 b -->
            {{each user.arr b a}}
            <li>
                {{a}} ---- {{b}}
            </li>
            {{/each}}
        </ul>

        <h4>each 遍历对象， 采用默认的键 $index 和默认的值 $value</h4>
        <ul>
            <!-- each 遍历对象， 采用默认的键 $index 和默认的值 $value  -->
            {{each user.obj}}
            <li>
                {{$index}} ---- {{$value}}
            </li>
            {{/each}}
        </ul>

        <h4>each 遍历对象，采用自定义的键 key 和自定义的值 val</h4>
        <ul>
            <!-- each 遍历对象，采用自定义的键 key 和自定义的值 val -->
            {{each user.obj val key}}
            <li>
                {{key}} ---- {{val}}
            </li>
            {{/each}}
        </ul>
    </script>
    <script>
        var user = {
            obj: {
                name: 'Bruce Lee',
                age: 32,
                gender: 'male'
            },
            arr: [
                { type: 1, price: 10 },
                { type: 2, price: 12 },
                { type: 3, price: 18 }
            ]
        }
        var html = template('tpl', { user: user })
        var container = document.querySelector('#container');
        container.innerHTML = html;
    </script>
</body>
</html>
```

看输出结果：

![img](D:\Typora_pic\12110282-8b992200df9ef802.webp)

each遍历数组和对象以及自定义$data和$index.png

#### 3.5 定义变量

**标准语法**

```html
{{set temp = data.sub.content}}
```

**原始语法**

```html
<% var temp = data.sub.content %>
```

#### 3.6 模板继承

**标准语法**

```html
{{extend './layout.html'}}
{{block 'head'}}
...
{{/block}}
```

**原始语法**

```html
<% extend ('./layout.html') %>
<% block('head', function () { %>
...
<% }) %>
模板继承允许你构建一个包含站点共同元素的基本“模板骨架”,实例：
```

```html
<!--layout.art-->
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>{{block 'title'}}My Site{{/block}}</title>

    {{block 'head'}}
    <link rel="stylesheet" href="main.css">
    {{/block}}
</head>
<body>
    {{block 'content'}}{{/block}}
</body>
</html>
```



```xml
<!--index.art-->
{{extend './layout.art'}}

{{block 'title'}}{{title}}{{/block}}

{{block 'head'}}
    <link rel="stylesheet" href="custom.css">
{{/block}}

{{block 'content'}}
<p>This is just an awesome page.</p>
{{/block}}
```

渲染 index.art 后，将自动应用布局骨架。

#### 3.7 子模板

**标准语法**

```html
{{include './header.art'}}
{{include './header.art' data}}
```

**原始语法**

```php
<% include('./header.art') %>
<% include('./header.art', data) %>
```

看如下例子：

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>art-template-filter</title>
    <!-- 引入 template-web.js -->
    <script src="./node_modules/art-template/lib/template-web.js"></script>
</head>
<body>
    <div class="container"></div>
    <script type="text/html" id="filterTpl">
        <h3>{{date | format 'YYYy-mM-dd' | addQuotationMarks}}</h3>
        <h3><%= $imports.addQuotationMarks($imports.format(date)) %></h3>
    </script>
    <script>
        var data = {
            date: Date.now(),
        }
        // 定义日期格式化过滤器 format 方法：
        template.defaults.imports.format = function (date, format) {
            if (!format || format.toLowerCase() === 'yyyy-mm-dd') {
                var dt = new Date(date);
                var y = dt.getFullYear();
                var m = (dt.getMonth() + 1).toString().padStart(2, '0');
                var d = dt.getDate().toString().padStart(2, '0');
                return `${y}/${m}/${d}`;
            } else {
                return 'invalid date';
            }
        }
        // 定义给字符串加引号过滤器 addQuotationMarks 方法:
        template.defaults.imports.addQuotationMarks = function (str) {
            return `"${str}"`;
        }
        // 调用 template 方法，渲染模板和数据
        var html = template('filterTpl', data);
        document.querySelector('.container').innerHTML = html;
    </script>
</body>
</html>
注意：
```

- `{{date | format 'YYYy-mM-dd' | addQuotationMarks}}`
  `date` 默认为 format 过滤器(方法)的第一个参数， 'YYYy-mM-dd' 才是format 过滤器的第二个参数,`date` 经过 `format` 过滤器过滤后，得到的结果，又作为
  `addQuotationMarks` 过滤器的默认参数，如果有更多的过滤器，那么就把前一层过滤器过滤的结果，作为下一个过滤器的参数一层层过滤下去

# 4 调试

`template.defaults.debug`
art-template 内建调试器，能够捕获到语法与运行错误，并且支持自定义的语法。在 NodeJS 中调试模式会根据环境变量自动开启：`process.env.NODE_ENV !== 'production'`
设置 template.defaults.debug=true 后，等同于：

```js
{
    "cache": false,
    "minimize": false,
    "compileDebug": true
}
```

# 5 模板变量

`template.defaults.imports`
模板通过 `$imports` 可以访问到模板外部的全局变量和导入的变量。

#### 5.1 导入变量

```js
template.defaults.imports.log = console.log;
```

```html
<% $imports.log('Hello, template.defaults.imports.log') %>
```

看下面例子：

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>template.defaults.imports</title>
    <script src="./node_modules/art-template/lib/template-web.js"></script>
</head>
<body>
    <div class="container">
    </div>
    <script type="text/html" id="importsTpl">
        <% $imports.log('Hello, template.defaults.imports.log') %>
        <%= $imports.date %>
    </script>
    <script>
        var data = {};
        template.defaults.imports.log = console.log;
        template.defaults.imports.date = new Date();
        template.defaults.debug = true;
        var html = template('importsTpl', data);
        document.querySelector('.container').innerHTML = html;
    </script>
</body>
</html>
注意：
```

> 这些语法必须写在模板中，在模板中才会起作用；

#### 5.2 内置变量清单

- `$data`   传入模板的数据;
- `$imports` 外部导入的变量以及全局变量；
- `print`   字符串输出函数;
- `include` 子模板载入函数
- `extend`  模板继承模板导入函数
- `block`   模板块生命函数