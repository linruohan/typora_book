# JavaScript简介

[JavaScript](http://c.biancheng.net/js/) 是面向 Web 的编程语言，获得了所有网页浏览器的支持，是目前使用最广泛的脚本编程语言之一，也是网页设计和 Web 应用必须掌握的基本工具。

==1995年==，当时的Netscape 网景公司正凭借其Navigator浏览器成为Web时代开启时最著名的第一代互联网公司。由于网景公司希望能在静态HTML页面上添加一些动态效果，于是叫==Brendan Eich==这哥们在两周之内设计出了JavaScript语言。你没看错，这哥们只用了==10天==时间。

为什么起名叫JavaScript？原因是==当时Java语言非常红火，所以网景公司希望借Java的名气来推广==，但事实上JavaScript除了语法上有点像Java，其他部分基本上没啥关系。

==1996年==，微软在 Internet Explorer 3 中也加入了脚本编程功能。为了避免与 Netscape 的 JavaScript 产生纠纷，微软特意将其命名为 JScrip

## ECMAScript

为了让JavaScript成为全球标准，几个公司联合ECMA（European Computer Manufacturers Association）组织定制了JavaScript语言的标准，被称为ECMAScript标准。(那为什么不直接把JavaScript定为标准呢？因为==JavaScript是网景的注册商标==。)

ECMAScript第一版标准发布于==1997年==

==目前 5 大主流浏览器都支持 ECMAScript 5==，具体说明如下：

- Opera 11.60+
- IE 9+
- Firefox 4+
- Safari 5.1+
- Chrome 13+

## JavaScript 构成

ECMAScript 是 JavaScript 的标准，但它并不等同于 JavaScript，也不是唯一被标准化的规范。

实际上，一个完整的 JavaScript 实现由以下 3 个不同部分组成：

- 核心（ECMAScript）：语言核心部分。
- 文档对象模型（Document Object Model，DOM）：网页文档操作标准。
- 浏览器对象模型（BOM）：客户端和浏览器窗口操作基础。

==Web 浏览器==只是 ECMAScript 实现的宿主环境之一。宿主环境不仅提供基本的 ECMAScript 实现，同时也会提供各种扩展功能。

==文档对象模型==是 HTML 的应用程序编程接口（API）。DOM 把整个文档映射为一个树形节点结构，以方便 JavaScript 脚本快速访问和操作。

IE3.0 和 Netscape Navigator 3.0 提供了一种新特性，即 ==BOM（浏览器对象模型）==。使用 BOM 可以对浏览器窗口进行访问和操作，如移动窗口、访问历史记录、动态导航等。与 DOM 不同，BOM 只是 JavaScript 的一个部分，并没有形成规范性标准，但是所有浏览器都默认支持。