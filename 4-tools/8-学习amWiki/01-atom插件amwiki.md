基于amwiki搭建属于自己的维基百科

最后更新于2019年03月10日 / 3938次浏览 / 4次点赞 / 0条评论

 [amwiki](http://www.bewindoweb.com/index.php?tagid=443)[，个人wiki](http://www.bewindoweb.com/index.php?tagid=444) [，维基百科](http://www.bewindoweb.com/index.php?tagid=445) [，知识整理](http://www.bewindoweb.com/index.php?tagid=446)

# 前言

最近突然意识到，我把过多的内容放到这个博客里面了，是时候把编程、生活日记、工具wiki三者分开了：

（1）[个人博客](http://www.bewindoweb.com/)应该记录编程的内容，比如有趣的小实验、小项目、优美的算法、数学等等，它应该是以后工作的名片。

（2）生活日记记录的才是自己去哪儿玩儿了，昨天做什么梦了，有啥想买想吃的东西。

（3）[wiki](http://wiki.bewindoweb.com/)则应该记录一些常用的、系统的知识，比如快捷键、中文文档的翻译、软件程序出错解决手册。它应该是经过多次验证的工具书，不同于平时使用的印象笔记，印象笔记都是杂乱的思绪，突然想到的方法，突然想做的事情，或者在做事过程中边做边记录不需要考虑格式问题的草稿。wiki记录的则是可以快速搜索查找、具有条理的但是非常无聊、平时不会看，关键时候又需要翻一翻的东西。

因此诞生了制作自己的wiki的想法。

# 需求分析

我主要有三个需求：

（1）可以放在服务器上便于在任何地方查看，这需要体积小巧。

（2）支持Markdown的语法，支持中文。

（3）有强大的搜索功能，能够搜索内容中的关键字而不仅仅是标题。

我的小伙伴钉子在[《使用 TiddlyWiki 打造轻便个人 Wiki 知识库》](http://blog.dimpurr.com/tiddly-wiki/)中已经提到了用TiddlyWiki，TiddlyWiki非常有用：

（1）单HTML文件，可以随时装在U盘里离线查看

（2）不需要任何服务器的配置，也不需要任何安装

（3）很多人使用，已经具有很多成熟的插件

（4）有强大的标签和搜索功能

用钉子的原话说：

>  笔记软件，例如 EverNote 、 WizNote 、 OneNote 的确十分不错，但是也会带来客户端是否跨平台、启动速度是否好看甚至默认文字排版是否美观的问题；而且，常规的笔记软件也达不到 Wiki 级别方便的 Tag 标签系统。当然， Wiki 系统有经典的 MediaWiki 系统，还有许许多多的静态 Wiki 系统、 Wiki 知识库类客户端。然而， MediaWiki 庞大、复杂和丑陋； Wiki 客户端程序有好有坏，有设计简陋也有强大美观，但是最大的限制还是往往不跨平台；一些可以用 Github Pages 部署的，基于 Markdown 的 Wiki 系统尽管几乎能在功能上满足我的需求，但是每一次撰写新条目和部署的复杂度还是令人难以接受。你可能已经看出了我口味相当的刁钻和需求相当的诡异 …… 在我看来，管理以文字、代码和数学公式为主的个人知识库， TiddlyWiki 可谓是最好的选择之一。

然而其实不太符合我的需求：

（1）无法放到小水管服务器上。

存储在单一HTML文件里，再装几个插件，写点文字，文件会原来越大，钉子的Tiddly已经到5M了，5M的东西要用1M也就是128kb/s的水管传输……而钉子的服务器是80块一个月的Linode，非常适合：

![img](D:\Typora_pic\6a46054ecba9b529202374ff9bd9680b.png)

（2）不支持markdown语法

Tiddlywiki用的是WikiText，虽然说差不多，但是也需要学习。

（3）界面凌乱

由于只有一个html文件，作者编辑和读者看是一个界面，虽然读者不会保存修改操作，但看着并不会使用却放在那里的按钮很难受。

![img](D:\Typora_pic\ab875cf01cd78b7bfb11c07a52072f2d.png)

（4）对浏览器的支持不太好

搜狗浏览器打开：

![img](D:\Typora_pic\c8056cd182d209a53d55d93a03f72f5c.png)

不过以后有机会还是想用一用TiddlyWiki的，比如等我租到大带宽服务器……

# amwiki简介

在查了一些资料，并且排除了钉子所说的不太好用的那些wiki后，发现了amwiki。[amwiki](https://github.com/TevinLi/amWiki)是国人TevinLi开发的在github上开源的wiki程序，起源也是因为觉得wiki都不太好用，于是他自己开发了一个。

![img](D:\Typora_pic\75b4cb75007b14873dbc4f44fda29a33.png)

## amwiki优点

（1）支持markdown语法、支持中文。**国人**基于**Atom**开发的产物……太棒了。

（2）有自动构建工具。写完markdown后只需要按一下按钮更新目录即可。

（3）无需数据库。所有的markdown写完都保存为.md文件，它能够自动加载，省去了数据库的备份麻烦。

（4）支持粘贴图片。非常非常实用的功能，QQ截图后在Atom里面粘贴图片，自动把图片保存到assets目录下，并且自动创建文件夹、命名，自动把markdown语句写好……无敌。

（5）支持导出github wiki。因为amwiki最开始是为github项目写wiki用的。

（6）支持全库搜索。支持标题搜索、支持内容搜索。

（7）支持手机浏览

## amwiki缺点

（1）没有更新了。amwiki的最后一次更新是在2018年1月3日，5个月没更新了，估计作者要弃坑了……有什么问题得自己去改。

（2）不支持公式。amwiki毕竟是小项目，没有成熟的插件。

（3）加载缓慢。由于没用数据库，还要在加载过程中转换为html，加载也是比较缓慢的。不过，amwiki是有缓存机制的，而且不需要像Tiddlywiki一样一次性加载完所有的文档。

## 未来的amwiki

注意到在计划中的下一个版本作者准备支持数学公式了，罒ω罒，包括评论系统，都是值得期待的，不过不知道何年何月才能等到……

![img](D:\Typora_pic\9ae169742a123d78b167895c93f0cf6d.png)

# 上手amwiki

## amwiki下载和安装

（1）从[github](https://github.com/TevinLi/amWiki)上点击`Clone or download`下载ZIP，这里提供一个百度网盘[amwikiv1.2.1](https://pan.baidu.com/s/1i4uNkF_bP59N847yJl0GYQ)（密码xvnk）

（2）安装[Atom编辑器](https://atom.io/)，安装过程是自动的，强制安装到C盘。这是一款github开发的开源免费的编辑器，amwiki是作为Atom的插件开发的。同样提供[百度网盘](https://pan.baidu.com/s/1rxafb2eo7liGzcLPeGBsvA)（密码8bui）备份下载，不过注意这个文件是**v1.27.2 For Windows7(64bit) or later**的，我的操作系统是**windows8 64**位，所以如果你的操作系统不同，需要自己去官网下载对应版本。

（3）将amwiki手动安装至Atom。

① 进入`C:\Users\BEWINDOWEB\.atom\packages`文件夹，这里的`BEWINDOWEB`是你计算机的名字，`.atom`是一个隐藏文件夹。

② 将amwiki的ZIP文件解压到这个文件夹，如果解压后的名字不是`amWiki`的话，比如是`amWiki-master`，需要把`amWiki-master`重命名为`amWiki`。

（4）顺手装一个Atom汉化插件，同样的安装方法，下载→解压到packages目录。插件名字叫atom-simplified-chinese-menu-master，给一个[百度网盘](https://pan.baidu.com/s/1Mvuqqt7qLBrOgQP7S4uuiw)（密码qqa7）地址。

（5）打开Atom，发现上面的英文菜单栏变为了中文，并且多了一个amWiki轻文库的菜单，说明安装成功了：

![img](D:\Typora_pic\3bb8a7805e51a39c75f9fadeac263eaf.png)

## amWiki的Hello World

（1）新建一个项目文件夹。我们在喜欢的地方建立一个文件夹，比如`G:\githubWorkspace\Helloworld\`，然后在Atom里面选择`文件`→`添加项目文件夹`→`选中这个Helloworld`，一个项目文件夹就建好了：

![img](D:\Typora_pic\0e8f200f4259314076c982b8cc53011b.png)

（2）编写config.json。在这个Helloworld文件夹下创建一个config.json文件，写入内容：

```txt
{  "name": "Hello wiki"}
```

（3）生成amwiki。菜单栏`amWiki轻文库`→`通过config.json创建新文库`，会在这个目录下自动生成很多文件：

![img](D:\Typora_pic\6148dbd3f2802064e02186631d0ce10b.png)

（4）启动本地服务器。菜单栏`amWiki轻文库`→`启动本地静态Web服务器`，可能会提示联网，允许就好了。

（5）查看Hello wiki内容。

① 进入library目录，选择home-首页.md：

![img](D:\Typora_pic\42344302a500974fa0c868bff90eb840.png)

② 然后菜单栏amWiki轻文库→在浏览器中打开当前文档，Helloworld！（注意这里不能直接去打开index.html，因为会有跨域的问题，很多文件无法引用，需要从静态Web服务器来操作）

![img](D:\Typora_pic\6ec44199e64cade7c51b3624351f511c.png)

## 修改amwiki

（1）看什么都不如看官方文档，[amwiki官网](http://amwiki.org/)，[amwiki文档中心](http://amwiki.org/doc)。

（2）修改config.json。

由于amwiki是自动生成的，所以你手动去更改内容非常麻烦，一切的修改都应该基于config.json，作者提供了[以下接口](http://amwiki.org/doc/?file=030-文档技术篇/100-config配置)：

| 参数名      | 默认值                 | 修改示例          | 作用                                                         |
| :---------- | :--------------------- | :---------------- | :----------------------------------------------------------- |
| name        | amWiki轻文库           | Hello wiki        | wiki名称                                                     |
| ver         | by Tevin               | v0.0.1            | wiki版本                                                     |
| logo        | amwiki/images/logo.png | /assets/logo.png  | logo图片                                                     |
| colour      | #4296eb                | /assets/logo      | 界面颜色                                                     |
| github-url  | 无                     | 你的github项目url | 作为github附属wiki                                           |
| page-mounts | false                  | true              | [页面挂载数据](http://amwiki.org/doc/?file=030-文档技术篇/100-config配置#page-mounts-) |
| imports     | 无                     | assets/bwb.css    | 引入自己的css/js                                             |

最好的地方就是，作者允许使用自己的css/js，举个例子：

① 可玩点一：修改界面样式。

我希望把文库也改成类似自己博客的界面，风格统一，那么可以建立一个assets文件夹，创建文件bwb.css。

![img](D:\Typora_pic\b787dbbbb17077988d526f4a94e7258c.png)

在bwb.css中，通过复写元素的样式就能够覆盖，比如审查头部的背景，class名称叫header：

![img](D:\Typora_pic\706265162f784a0ddabf1967ac1a2a95.png)

我们编写一个：

```css
/*头部*/.header{  background-color: #242424;  border-top:none;}
```

头部就从蓝白变成了全黑：

![img](D:\Typora_pic\9315c6f9b415d8ecdd41a8ae8773caae.png)

![img](D:\Typora_pic\8264ed4ffaabeb0f4859715e689952e4.png)

完整的界面对比和bwb.css代码如下，你可以参考：

![img](D:\Typora_pic\e685ec60a6c7a673eca67bd8377feb1a.png)

![img](D:\Typora_pic\46939b8696e05bae70f3eed86b74727c.png)

```css
a{  color:#478cdc;}/*头部*/.header{  background-color: #242424;  border-top:none;}.header .logo {  padding-top: 5px;} .header .logo img {  max-height: 59px;}  .header .logo i {  display:none;} .header .logo b {  height: 59px;  color:#f2f2f2;  line-height:59px;}/*主体背景*/.container{  background-color:#f1f5f8;  border: none;  border-radius: 4px;  box-shadow: 0px 0px 5px #f2f2f2;  box-sizing: border-box;  overflow:hidden;}/*左侧菜单*/.menubar{  border-right: 1px solid #eee;}.menu-filter svg {  color:#478cdc;}.menu-search svg {  color:#478cdc;}.menubar h4.on svg {  color:#478cdc;}.menubar h4.on a {  color:#478cdc;}.menubar h4, .menubar h5 {  border:1px solid #FFFFFF;}.menu-search{  border-left:none;  border-bottom: 1px solid #eee;}.menu-filter{  border-bottom: 1px solid #eee;  padding-left: 6px;  width: 205px;}.menu-filter input {  border-bottom: none;  width:170px;  text-align: left;  height:30px;}.menu-filter i {  line-height: 36px;  margin-top:2px;}.menu-filter:hover input {  border-bottom: none;}.menu-filter input:focus {outline: none;  border-bottom: none;}.menu-filter svg{  display:none;}.container .nav {  background-color: #ffffff;  border:none;}/*右侧内容*/.main-inner{  background-color: #ffffff;  border:none;}/*搜索功能*/.search-update input {  background-color: #eee;  font-weight: 300;  text-decoration: none;  text-align: center;  cursor: pointer;  border: none;  border-radius: 15px;  height: 30px;  line-height: 28px;  padding: 1px 10px;  width: 110px;  font-size:14px;  color: #666;}.search-update input[disabled] {  color: #ccc;  background: #f2f2f2;  border: #aaa 1px solid;  padding: 1px 10px;  border-radius: 15px;  cursor:not-allowed;}.search-update input:hover{  background-color: #f4f4f4;}.search-input input[type="button"] {  font-size: 14px;  background-color: #1B9AF7;  color:#f2f2f2;  border: none;  height: 44px;  padding-left:3px;  padding-right:3px;  outline:none;}.search-input input[type="button"]:hover{  background-color: #41afff;} .search-input{  padding-right: 105px;} .search-input input[type="text"]{  border-color:#eee;  font-size: 14px;  padding:11px;}.search-input input[type="text"]:focus{  border-color:#478cdc;  box-shadow: none;} /*返回顶部*/aside .contents{  background: #eee;  color: #666;  box-shadow: 0px 0px 5px #f2f2f2;  border: 1px solid #f2f2f2;}aside .contents-list{  background: #fafafa;  border: 1px solid #eee;}aside .contents a{  color: #444;} aside .contents a:hover{  color: #478cdc;}aside .contents .markdown-contents ol li>i{  color: #666;  background-color: #f2f2f2;  padding: 0 5px;  border-radius: 4px;  line-height: 20px;}aside .back-top{  background: #eee;  color: #666;  box-shadow: 0px 0px 5px #f2f2f2;  border: 1px solid #f2f2f2;} /*底部签名*/.signature{  display:none;} /*markdown语法*/.markdown-body h1 {  margin-top: 50px;  font-size: 30px;}.markdown-body h2 {  font-size: 26px;}.markdown-body h3 {  font-size: 22px;}.markdown-body code, .markdown-body tt {padding: 0;font-size:14px;background-color:#f1f8ff;color: #0366d6;height:20px;margin:5px 3px;padding:3px 0px;white-space: normal;line-height:2.0;}.markdown-body img {  text-align:center;  margin: 10px auto;  display:block;}.markdown-body table {  margin-left:auto;  margin-right:auto;  width:auto;  display:table;} .markdown-body pre code {    font-size:14px;} @media screen and (max-width: 720px){  .header .logo img{    display:none;  }  .header .logo b {      line-height:49px;      height:49px;  }  .header .logo {    padding-top: 0;  }  .container{    background-color:#f1f5f8;    border: none;    border-radius: none;    box-shadow: none;    box-sizing: border-box;    overflow:hidden;  }  .container .nav{    background: #242424;  }  .menu-filter{    width:100%;  }}
```

② 可玩点二：引入一些成熟的CSS。

作者只允许在config.json中引入一个CSS，其他的CSS会失效，但是我们可以在CSS里面写引入的语句。这使得功能变得强大，比如我想要使用font-awesome4.7.0的图标，[百度网盘](https://pan.baidu.com/s/1odawArgQDSRJQF_T_B4MxA)（密码vxl4），那么把font-awesome插件下载到assets目录下：

![img](D:\Typora_pic\ff49575ab58a9670833a5b39634c52d7.png)

再在bwb.css开头（注意是开头，写在结尾无效）写引入语句：

```css
/*引入其他css*/@import "font-awesome/css/font-awesome.min.css";
```

就能够在markdown里面使用啦~

```html
<font color="#478cdc"><i class="fa fa-globe"></i></font>
```

效果：

![img](D:\Typora_pic\66b626db4deb0dd0a157c8b357cf88c1.png)

## 使用amwiki的姿势

（1）剪贴板功能

QQ截图后，直接使用ctrl+shift+v，或者菜单栏amWiki轻文库→从剪贴板粘贴截图，就能够自动帮你保存图片并写好markdown：

![img](D:\Typora_pic\53205424288e179c5297eb82ab6ec47f.png)

![img](D:\Typora_pic\e29c5b516741906ff5091d13aba0a03f.png)

更好的是，它可以根据文档所在目录自动创建文件夹，让你的图片可以按文章分类。

（2）善用搜索功能

虽然amwiki没有标签，但是可以搜索文章内容是非常无敌的。先更新缓存到100%，再搜索：

![img](D:\Typora_pic\1271bb36261d3669970d96c965e49fd8.png)

（3）手机端观看

amwiki支持自适应（虽然写得并不太好），手机端也是可以浏览、搜索、查看的哦。



![img](D:\Typora_pic\fd6d6a4972e5d22108d1dbc4af752f6e.png)

（4）打开实时预览编写Markdown

在Atom中按Ctrl+shift+m可以打开Markdown实时预览~

![img](D:\Typora_pic\4c09754ff423454fd9bdfdf5f9c8b533.png)

# amwiki v1.2.1的bug

## 字符被转码

当输入`\n`的时候会被转义为`'`。原因是这一段，来源于`amWiki\js\amWiki.docs.js`：

```js
content = content.replace(/\\(.)/g, function (m, s1) {      return '&#' + s1.charCodeAt(0) + ';';});
```

看了下作者的wiki：

![img](D:\Typora_pic\3b232f7f1b99ea7c2edb731982ce1756.png)

………………目测是开发中状态，而且和作者交流后，发现作者已经用上了自己开发好了的版本了……没办法，把这段注释掉就好了，不过用不上这个新功能了。记得注释`C:\Users\BEWINDOWEB\.atom\packages\amWiki\files`下`amWiki.docs.js`中的内容，这样再次用`config.json`生成的时候就一直会是注释状态，否则只注释项目内的`amWiki.docs.js`，重新生成的时候会被重写。

## img.toPng() is not a function

Atom 1.28.0版本已经将Electron升级到2.0版本了。而Electron v2.0的NativeImage.toPng函数已经被移除，取而代之的是NativeImage.toPNG。所以修改这个代码即可。解决方法参见[《amwiki报错：img.toPng is not a function》](http://wiki.bewindoweb.com/?file=001-出错解决手册（编程类）/00041-amwiki报错：img.toPng is not a function)

# 使用github托管wiki

如果没有合适的服务器，完全可以用github来托管，和普通的上传项目的方式一致：create项目→ push本地仓库 → push到github。不过建立的项目名称必须为：**username.github.io**，比如我的wiki为[bewindoweb.github.io](https://bewindoweb.github.io/)，他会自动识别的，一打开就是`home-首页.md`的内容。赶紧尝试动手搭一个吧~

你还可以通过`github项目`→`Settings`→`Github Pages`→`Custom domain`自定义其他的域名。当然，你要提前在域名解析上面添加CNAME指向wiki的地址。

![img](D:\Typora_pic\a3901e1e3128ca143aee68e329f28122.png)

![img](D:\Typora_pic\9275c3461ebb88a1b55c22d9e6ef6ac4.png)

还能够强制启用HTTPS，不过这个证书是github的，在Chrome上会有拦截信息，这样[wiki.bewindoweb.com](http://www.bewindoweb.com/wiki.bewindoweb.com)也能访问它了。



 写得很赞 [ 微博收藏](http://service.weibo.com/share/share.php?&pic=http://www.bewindoweb.com/uploadpic/artpic_1529383259442b1969192b1359.jpg&url=http%3a%2f%2fwww.bewindoweb.com%2f199.html&title=@mark《基于amwiki搭建属于自己的维基百科》 | 文章 | BEWINDOWEB博客，内容简介：前言最近突然意识到，我把过多的内容放到这个博客里面了，是时候把编程、生活日记、工具wiki三者分开了：（1）个人博客应该记录编程的内容，比如有趣的小实验、小项目、优美的算法、数学等等，它应该是以后工作的名片。（2）生活日记记录的才是自己去哪儿玩儿了，昨天做什么梦了，有啥想买想吃的东西。（3）wiki则应该记录一些常用的、系统的知识，比如快捷键、中文文档的翻译、软件程序出错解决手册。它应该是经过多次验证的工具书，不同于平时使用的印象笔记，印象笔记都是杂乱的思绪，突然想到的方法，突然想做的事情，或者在做事过程中边做边记录不需要考虑格式问题的草稿。wiki记录的则是可以快速搜索查找、具有条理的但是非常无聊、平时不会看，关键时候又需要翻一翻的东西。因此诞生了制作自己的wiki的想法。需求分析我主要有&language=zh_cn&appkey=3055625897&searchPic=true) [ 打赏作者](http://www.bewindoweb.com/about.php#pay)

**转载请注明出处**：[http://www.bewindoweb.com/199.html | 三颗豆子](http://www.bewindoweb.com/199.html)
**分享许可方式**：[知识共享署名-非商业性使用-相同方式共享 4.0 国际许可协议](http://creativecommons.org/licenses/by-nc-sa/4.0/)
**重大发现**：转载注明原文网址的同学刚买了彩票就中奖，刚写完代码就跑通，刚转身就遇到了真爱。