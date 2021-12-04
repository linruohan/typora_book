# 爆改Typora默认样式，世界终于平静了。。。

[![img](D:\Topora_pic\252145a87c49.webp)](https://www.jianshu.com/u/821ec213b940)

[千羽之城88](https://www.jianshu.com/u/821ec213b940)关注

12018.09.11 04:07:26字数 131阅读 14,644

作为一个只关注颜值的人，用了typora很久今晚终于被官方样式丑哭，于是动手爆改了一下。以默认的github样式为基础先看看效果。

# 最终效果

![img](D:\Topora_pic\2242606-130dc27d35321b72.webp)

顶部圆角页面效果和页面阴影，标题改为“PT Serif”

![img](D:\Topora_pic\2242606-b723cf1ced0e3cf8.webp)

底部的阴影效果

![img](D:\Topora_pic\2242606-219b171ad6e79dbb.webp)

标题的Q，一眼就看上了，哈哈哈

![img](D:\Topora_pic\2242606-4f965e64efd60561.webp)

代码和简书差不多，对，我是故意的，因为喜欢！

![img](D:\Topora_pic\2242606-017c5ca32a83de6a.webp)

重新用hermit字体定义了代码块

![img](D:\Topora_pic\2242606-be83016ac012104b.webp)

表格样式

![img](D:\Topora_pic\2242606-87f59b2f5a2fea0f.webp)

LaTeX代码样式也没问题！！！

![img](D:\Topora_pic\2242606-be3af58555ed1791.webp)

数字

![img](D:\Topora_pic\2242606-292bd96b10e34f33.webp)

稍微有一点点不完美

# 大致的样式表

| 参数                                      | 子参数/注释        | 简介                                                         |
| ----------------------------------------- | ------------------ | ------------------------------------------------------------ |
| `\:root`                                  | -                  | 设置Typora背景颜色                                           |
| `html`                                    |                    | 设置正文字体                                                 |
| -                                         | `font-size`        | 正文字体大小                                                 |
| `@font`                                   | -                  | 加载自定义字体                                               |
| `body`                                    | -                  | 设置正文行高、背景色等                                       |
| -                                         | `font-family`      | 设置正文字体                                                 |
| `#write`                                  | -                  | 编辑版面的设置                                               |
| -                                         | `margin-top`       | 顶部高度                                                     |
| -                                         | `margin-bottom`    | 底部高度                                                     |
| -                                         | `padding`          | 版心与版面的间距                                             |
| `table tr:nth-child(2n)`                  | -                  | 表格偶数行                                                   |
| `table tr:nth-child(2n-1)`                | -                  | 表格奇数行                                                   |
| `code`                                    | -                  | 代码块内设置                                                 |
| -                                         | `background-color` | 背景                                                         |
| `tt`                                      | -                  | 打印块设置                                                   |
| `.cm-s-inner .cm-comment`                 | `// /**/ %`        | 代码注释                                                     |
| `.cm-s-inner .cm-keyword`                 | `function`         | 保留字符                                                     |
| `.cm-s-inner .cm-def`                     | `document`         | 保留字符                                                     |
| `.cm-s-inner .cm-operator`                | `return`           | 系统保留字符                                                 |
| `.cm-s-inner .cm-variable`                | `window`           | 保留字符                                                     |
| `.cm-s-inner .cm-variable-2`              | `jQuery`           | 变量                                                         |
| `.cm-s-inner .cm-string`                  | -                  | 字符串                                                       |
| `.cm-s-inner .cm-attribute`               | -                  |                                                              |
| `.cm-s-inner .cm-property`                | -                  | 属性                                                         |
| `.cm-s-inner .cm-variable-3`              | -                  | 变量                                                         |
| `.cm-s-inner .cm-error`                   | -                  | 错误信息                                                     |
| `.cm-s-inner .cm-atom`                    | `null/undefined`   | JS关键字                                                     |
| `.cm-s-inner .cm-number`                  | `0123456789`       | 数字                                                         |
| `.cm-s-inner .cm-builtin`                 | `bash shell`       | 系统命令行命令关键字                                         |
| `.cm-s-inner .cm-tag`                     | `\sum`             | ![\LaTeX](D:\Topora_pic\math.svg)关键字 |
| `.cm-s-inner .cm-meta`                    | -                  | ![\LaTeX](https://math.jianshu.com/math?formula=%5CLaTeX)关键字 |
| `.cm-s-inner .CodeMirror-matchingbracket` | `{}`               | 括号                                                         |

# 样式表

现在寄出样式表，重要的地方已经做了标识，哈哈哈：



```css
:root {
    --side-bar-bg-color: #d9d0bc;
    --control-text-color: #777;
}

@include-when-export url(https://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,700,400&subset=latin,latin-ext);

@font-face {
    font-family: 'Open Sans';
    font-style: normal;
    font-weight: normal;
    src: local('Open Sans Regular'),url('./github/400.woff') format('woff')
}

@font-face {
    font-family: 'Open Sans';
    font-style: italic;
    font-weight: normal;
    src: local('Open Sans Italic'),url('./github/400i.woff') format('woff')
}

@font-face {
    font-family: 'Open Sans';
    font-style: normal;
    font-weight: bold;
    src: local('Open Sans Bold'),url('./github/700.woff') format('woff')
}

@font-face {
    font-family: 'Open Sans';
    font-style: italic;
    font-weight: bold;
    src: local('Open Sans Bold Italic'),url('./github/700i.woff') format('woff')
}


html {
    font-size: 16px;
}

body {
    font-family: "Open Sans","Clear Sans","Helvetica Neue",Helvetica,Arial,sans-serif;
    /*color: rgb(51, 51, 51);*/
    background-color: #d9d0bc; /*body bg color*/
    line-height: 1.6;
}

#write{
    max-width: 860px;
    margin-top:    30px; /*top*/
    margin-bottom: 30px;
    padding: 100px 60px; /*top to title padding*/
    border-radius: 5px;
    -o-box-shadow: 0 10px 10px #333333;
    -webkit-box-shadow: 0 10px 10px #333333;
    -moz-box-shadow: 0 10px 10px #333333;
    box-shadow: 0px 50px 100px #333333;
}
#write > ul:first-child,
#write > ol:first-child{
    margin-top: 30px;
}

body > *:first-child {
    margin-top: 0 !important;
}
body > *:last-child {
    margin-bottom: 0 !important;
}
a {
    color: #4183C4;
}
h1,
h2,
h3,
h4,
h5,
h6 {
    position: relative;
    margin-top: 1rem;
    margin-bottom: 1rem;
    font-weight: bold;
    line-height: 1.4;
    cursor: text;
}
h1:hover a.anchor,
h2:hover a.anchor,
h3:hover a.anchor,
h4:hover a.anchor,
h5:hover a.anchor,
h6:hover a.anchor {
    /*background: url("../../images/modules/styleguide/para.png") no-repeat 10px center;*/
    text-decoration: none;
}
h1 tt,
h1 code {
    font-size: inherit;
}
h2 tt,
h2 code {
    font-size: inherit;
}
h3 tt,
h3 code {
    font-size: inherit;
}
h4 tt,
h4 code {
    font-size: inherit;
}
h5 tt,
h5 code {
    font-size: inherit;
}
h6 tt,
h6 code {
    font-size: inherit;
}
h1 {
    font-family: "PT Serif";
    padding-bottom: .3em;
    font-size: 3em;
    line-height: 1.2;
    border-bottom: 1px solid #9b9692;
    text-align: center;
}
h2 {
   padding-bottom: .3em;
    font-size: 1.75em;
    line-height: 1.225;
    border-bottom: 1px solid #9b9692;
}
h3 {
    font-size: 1.5em;
    line-height: 1.43;
}
h4 {
    font-size: 1.25em;
}
h5 {
    font-size: 1em;
}
h6 {
   font-size: 1em;
    color: #777;
}
p,
blockquote,
ul,
ol,
dl,
table{
    margin: 0.8em 0;
}
li>ol,
li>ul {
    margin: 0 0;
}
hr {
    height: 2px;
    padding: 0;
    margin: 16px 0;
    background-color: #e7e7e7;
    border: 0 none;
    overflow: hidden;
    box-sizing: content-box;
}

body > h2:first-child {
    margin-top: 0;
    padding-top: 0;
}
body > h1:first-child {
    margin-top: 0;
    padding-top: 0;
}
body > h1:first-child + h2 {
    margin-top: 0;
    padding-top: 0;
}
body > h3:first-child,
body > h4:first-child,
body > h5:first-child,
body > h6:first-child {
    margin-top: 0;
    padding-top: 0;
}
a:first-child h1,
a:first-child h2,
a:first-child h3,
a:first-child h4,
a:first-child h5,
a:first-child h6 {
    margin-top: 0;
    padding-top: 0;
}
h1 p,
h2 p,
h3 p,
h4 p,
h5 p,
h6 p {
    margin-top: 0;
}
li p.first {
    display: inline-block;
}
ul,
ol {
    padding-left: 30px;
}
ul:first-child,
ol:first-child {
    margin-top: 0;
}
ul:last-child,
ol:last-child {
    margin-bottom: 0;
}
blockquote {
    border-left: 4px solid #dfe2e5;
    padding: 0 15px;
    color: #777777;
}
blockquote blockquote {
    padding-right: 0;
}
table {
    padding: 0;
    word-break: initial;
}
table tr {
    border-top: 1px solid #dfe2e5;
    margin: 0;
    padding: 0;
    background-color: rgba(93, 172, 129, 0.2); /*若竹*/
}
table tr:nth-child(2n),
thead {
    background-color: rgba(93, 172, 129, 0.2); /*set even row color*/
}
tbody tr:nth-child(2n-1) {
    background-color: transparent !important; /*only odd row has color*/
}
table tr th {
    font-weight: bold;
    border: 1px solid #dfe2e5;
    border-bottom: 0;
    text-align: left;
    margin: 0;
    padding: 6px 13px;
}
table tr td {
    border: 1px solid #dfe2e5;
    text-align: left;
    margin: 0;
    padding: 6px 13px;
}
table tr th:first-child,
table tr td:first-child {
    margin-top: 0;
}
table tr th:last-child,
table tr td:last-child {
    margin-bottom: 0;
}

.CodeMirror-lines {
    padding-left: 4px;
}

.code-tooltip {
    box-shadow: 0 1px 1px 0 rgba(0,28,36,.3);
    border-top: 1px solid #eef2f2;
}


code {
    background-color: #f3f4f4;
    padding: 0 4px 2px 4px;
}

.md-fences {
    margin-bottom: 15px;
    margin-top: 15px;
    padding: 0.2em 1em;
    padding-top: 8px;
    padding-bottom: 6px;
}
.md-task-list-item > input {
  margin-left: -1.3em;
}

@media screen and (min-width: 914px) {
    /*body {
        width: 854px;
        margin: 0 auto;
    }*/
}
@media print {
    html {
        font-size: 13px;
    }
    table,
    pre {
        page-break-inside: avoid;
    }
    pre {
        word-wrap: break-word;
    }
}
#write pre.md-meta-block {
    padding: 1rem;
    font-size: 85%;
    line-height: 1.45;
    background-color: #f7f7f7;
    border: 0;
    border-radius: 3px;
    color: #777777;
    margin-top: 0 !important;
}
.md-fences,
code,
tt {
    /*border: 1px solid #e7eaed;*/
    background-color: rgb(197,137,88); /* code block inline BGcolor */
    border-radius: 3px;
    padding: 0;
    padding: 2px 4px 0px 4px;
    font-size: 0.8em;
    font-family: menlo;
    /*color: #f9f2f4; /*code block inline font color*/
}

.md-fences {
    background-color: #1e2128; /*code block bg color*/
    color: #989fad; /*comma*/
}
.cm-s-inner .cm-comment {color: #3f4450; /*comment color*/ }
.cm-s-inner .cm-keyword {color: #c678dd; /*function*/ }
.cm-s-inner .cm-def {color: #f9f2f4; }
.cm-s-inner .cm-operator {color: #b75bd0; } /*return var*/
.cm-s-inner .cm-variable {color: #d19a66; /*window*/ }
.cm-s-inner .cm-variable-2 { color: #e2b76a; } /*window jquery*/
.cm-s-inner .cm-string { color: #98c379; } /* string */
.cm-s-inner .cm-attribute { color: #FFCB6B; }
.cm-s-inner .cm-property { color: #d19a66; } /*property*/
.cm-s-inner .cm-variable-3 { color: #DECB6B; }
.cm-s-inner .cm-error {color: rgba(209, 154, 102, 1.0); background-color: #448867;
}
.cm-s-inner .cm-atom { color: #F77669; } /*null undefined*/
.cm-s-inner .cm-number { color: #F77669; }
.cm-s-inner .cm-builtin { color: #DECB6B; } /*system built in command*/
.cm-s-inner .cm-tag { color: #80CBC4; }  /*LaTeX command*/
.cm-s-inner .cm-meta { color: #80CBC4; } /*LaTeX command*/
.cm-s-inner .CodeMirror-matchingbracket {
  text-decoration: underline;
  color: white !important;
}

.mathjax-block>.code-tooltip {
    bottom: .375rem;
}

.md-mathjax-midline {
    background: ;
}

#write>h3.md-focus:before{
    left: -1.5625rem;
    top: .375rem;
}
#write>h4.md-focus:before{
    left: -1.5625rem;
    top: .285714286rem;
}
#write>h5.md-focus:before{
    left: -1.5625rem;
    top: .285714286rem;
}
#write>h6.md-focus:before{
    left: -1.5625rem;
    top: .285714286rem;
}
.md-image>.md-meta {
    /*border: 1px solid #ddd;*/
    border-radius: 3px;
    padding: 2px 0px 0px 4px;
    font-size: 0.9em;
    color: inherit;
}

.md-tag {
    color: #a7a7a7;
    opacity: 1;
}

.md-toc { 
    margin-top:20px;
    padding-bottom:20px;
}

.sidebar-tabs {
    border-bottom: none;
}

#typora-quick-open {
    border: 1px solid #ddd;
    background-color: #f8f8f8;
}

#typora-quick-open-item {
    background-color: #FAFAFA;
    border-color: #FEFEFE #e5e5e5 #e5e5e5 #eee;
    border-style: solid;
    border-width: 1px;
}

/** focus mode */
.on-focus-mode blockquote {
    border-left-color: rgba(85, 85, 85, 0.12);
}

header, .context-menu, .megamenu-content, footer{
    font-family: "Segoe UI", "Arial", sans-serif;
}

.file-node-content:hover .file-node-icon,
.file-node-content:hover .file-node-open-state{
    visibility: visible;
}

.mac-seamless-mode #typora-sidebar {
    background-color: #fafafa;
    background-color: var(--side-bar-bg-color);
}

.md-lang {
    color: #b4654d;
}

.html-for-mac .context-menu {
    --item-hover-bg-color: #E6F0FE;
}
```

# 参考

官网指南： https://support.typora.io/Code-Block-Styles/
Hermit 字体：https://pcaro.es/p/hermit/#samples
Source Pro 字体：https://github.com/adobe-fonts/source-code-pro



21人点赞



[日记本](https://www.jianshu.com/nb/4627006)