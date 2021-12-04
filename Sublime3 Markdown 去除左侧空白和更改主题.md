Sublime3 Markdown 去除左侧空白和更改主题
前言
    安装上Sublime3中Mardown Editing的包后，编辑Markdown文件（.md）时，发现如下情况：



 ![img](https://img-blog.csdn.net/20180503105056849?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1RoZU1pc2VyeV9IYW5n/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

Markdown的主题变成灰色，非常亮眼而且看不清楚
编辑区域的左侧有大量的空白，让习惯写代码的人看着也很奇怪
没有行号
打开txt文件也会这样
方法
    解决方法就在我们安装的Markdown Editing包的设置上面：

   Preferences  ->  Package Settings  ->  Markdown Editing  然后分别打开  Markdown GFM Settings - Defaults 和 Markdown GFM Settings - User

    在 Markdown GFM Settings - Defaults 中找到如下

![img](https://img-blog.csdn.net/201805031100160?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1RoZU1pc2VyeV9IYW5n/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

 

"extensions" 选择的文件类型，可以删掉"txt"，这样不会影响到txt文件的显示了
"color_scheme" markdown的主题颜色，选择其中一个，其它的都注释掉
"draw_centered" 两侧是否有空白，改为false
"line_numbers" 显示行号，改为true
    将选中的命令，粘贴复制到 Markdown GFM Settings - User 中，只能在这里更改命令。

    Markdown GFM Settings - Defaults中是不能修改参数的。
    
    修改的命令如图所示

![img](https://img-blog.csdn.net/20180503111710448?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1RoZU1pc2VyeV9IYW5n/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

   

 效果如图所示

![img](https://img-blog.csdn.net/20180503111822579?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1RoZU1pc2VyeV9IYW5n/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

