visual studio 提高速度的选项
原创张无矩 最后发布于2018-04-01 22:35:03 阅读数 3840  收藏
展开
由于好几年前的笔记本上运行visual studio 2015， 速度变得特别慢，尤其是打开大的解决方案时简直难以忍受。本文记录提升vs2015的一些选项设置。

1.关掉vs的版本管理（不要把git集成到vs），如果需要管理版本，单独用git或别的软件管理。设置：Tool| Option| Source Control| None
![image-20200328211427788](D:\Typora_pic\image-20200328211427788.png)

2.关掉编辑器的自动调整RAM模式（Auto Tune Max Cached Tranlation Unit），调到最小值2(Max Cached Tranlation Unit).设置：Tool| Option| Text Editor| Advanced| Auto Tune Max Cached Tranlation Unit=False，Max Cached Tranlation Unit=2 .

![image-20200328211405018](D:\Typora_pic\image-20200328211405018.png)

------------------------------------------------
版权声明：本文为CSDN博主「张无矩」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/baigalxy/article/details/79782816