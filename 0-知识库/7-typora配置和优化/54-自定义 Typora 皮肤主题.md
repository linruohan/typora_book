
原创

# 自定义 Typora 皮肤主题

置顶 2019-06-20 18:15:10 [ViatorSun](https://me.csdn.net/ViatorSun) 阅读数 1933 收藏

版权声明：本文为博主原创文章，遵循[ CC 4.0 BY-SA ](http://creativecommons.org/licenses/by-sa/4.0/)版权协议，转载请附上原文出处链接和本声明。本文链接：https://blog.csdn.net/ViatorSun/article/details/89717118

> 如果对你有帮助的话，记得给博主点个赞哟！
>
> 也欢迎各位土豪朋友打赏博主，博主会继续分享优质的内容给大家的！

在写博客之前根本不知道什么是 MarkDown ，对于 MarkDown 的格式简直懵的一逼，好在一直坚持更新，对于 MarkDown 也算是较为熟悉了，所以我决定将 MarkDown 扩展到我的日常中来，虽然 Word 已经使用的炉火纯青，但是对于编写技术笔记还是不太顺手，可喜的是 Typora 带给了我希望，桌面版简直不要太好用好么！

特小的安装包，急速的打开方式，以及完美的表现，使得它完完全全俘获了我的心，还有一点就是它的图片是可以显示出来的，相比某些 MarkDown 软件强了不知道多少倍。但天下没有绝对完美的事情， Typora 的主题始终没有一个令我十分满意的(我是个很挑剔的、要求还贼多的一个极客)，好在 Typora 支持修改主题，也支持用户自定义自己的主题，这简直不要更爽了好么？

于是有了这篇博客的诞生。事先声明：继承于开源世界的开源精神，我已经将 订制的主题放在我的

[**Github ： https://github.com/ViatorSun/Typora**](https://github.com/ViatorSun/Typora)

上了，不需要积分下载，欢迎大家前去下载交流，由于能力有限，主题中可能还存在一些 Bug ，欢迎大家及时反馈，我也会及时回复大家的。

## Typora 订制主题

Typora 的主题格式是 .css 格式也就是所谓的 前端，对于没有接触过前端的小伙伴，可以参看以下方法快速入门，

前端 主要分为 Html 界面 以及 css 布局，两者是共同使用的，所以在查看 css 个时候是不能缺少 Html 的，只有理解了 Html 中的专属名词，才能顺利解读出来 css 中的代码是什么含义，在此推荐大家参考菜鸟教程

- **Html标签列表：** http://www.runoob.com/tags/html-reference.html
- **CSS参考手册：** http://www.runoob.com/cssref/css-reference.html
- **CSS颜色名称：** http://www.runoob.com/cssref/css-colornames.html

## 效果图

附上几张效果图，大家可以参看下，css 文件里已经添加备注，大家可自行修改
![在这里插入图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20190425093452465.png)
![在这里插入图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20190425093505682.png)

![在这里插入图片描述](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20190425093513608.png)

## Typora 常见快捷方式

| 功能           | 快捷键           |
| -------------- | ---------------- |
| 加粗           | Ctrl + B         |
| 查找           | Ctrl + F         |
| 斜体           | Ctrl + I         |
| 替换           | Ctrl + H         |
| 表格           | Ctrl + T         |
| 超链接         | Ctrl + K         |
| 下划线         | Ctrl + U         |
| 选中当前行     | Ctrl + L         |
| 跳转到所选内容 | Ctrl + J         |
| 引用           | Ctrl + Shift + Q |
| 代码块         | Ctrl + Shift + K |
| 公式块         | Ctrl + Shift + M |
| 内联代码片     | Ctrl + Shift + ` |
| 图片           | Ctrl + Shift + I |