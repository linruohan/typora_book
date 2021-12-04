# [Typora优化-适合不懂CSS代码的小白](https://www.cnblogs.com/nreg/p/11116176.html)

*转载请注明出处：https://www.cnblogs.com/nreg/p/11116176.html* 

搜索扩展

```shell
  "searchService": [
    ["Search with Google", "https://google.com/search?q=%s"],
    ["Search with Baidu", "https://www.baidu.com/s?wd=%s&ie=UTF-8"],
    ["Search with Github", "https://github.com/search?q=%s&utf8=%E2%9C%93"]
  ],
```



先来一张**优化前与优化后的对比图**：

**优化前：**

**![img](F:\Typora_book\typora_pic\1485694-20190914084450941-692874725.png)**

**优化后：**

![img](F:\Typora_book\typora_pic\1485694-20190914084528429-1405515439.png)

1.通过 文件-偏好设置 打开主题文件夹：

 应该在C:\Users\用户名\AppData\Roaming\Typora\themes下，非安装文件夹

![img](F:\Typora_book\typora_pic\1485694-20190712183841630-838459478.png)

2.打开主题文件夹 弹出如下文件：

![img](F:\Typora_book\typora_pic\1485694-20190712183938951-1937734330.png)

3.修改字体：将下载好的字体文件放在github下：

![img](F:\Typora_book\typora_pic\1485694-20190712184006911-1233938364.png)

 在github.css中配置字体：

![img](F:\Typora_book\typora_pic\1485694-20190712184045415-1542225708.png)

4.扩展编辑器宽度(解决因图片过大，即使编辑器全屏也模糊的问题)及其它配置(都有注释)：

![img](F:\Typora_book\typora_pic\1485694-20190718185852753-1700325640.png)

关于整体居中那段代码的说明：

代码图示：

![img](F:\Typora_book\typora_pic\1485694-20190718190025807-1296013453.png)

 注：不喜欢整体居中的可以注释掉：注释掉之后就是**传统左对齐**

**整体居中与传统左对齐图：**

**传统左对齐：注释掉上文整体居中那段代码即可**

![img](F:\Typora_book\typora_pic\1485694-20190914085942488-2877020.png)

**整体居中：**

![img](F:\Typora_book\typora_pic\1485694-20190914090001052-1655947561.png)

**普通居中与整体居中的对比图：**

普通居中方式：用的是text-align:center，样式古怪，本文件优化没有采用该方式

![img](F:\Typora_book\typora_pic\1485694-20190718191100689-592052832.png)

整体居中方式：用到的是弹性盒模型flex，管理了主轴和侧轴的富余空间，样式较为美观，本文优化采用该方式

![img](F:\Typora_book\typora_pic\1485694-20190718191111941-1864970058.png)

5.更改默认搜索google为bing:(以后选中文字右击选择search with bing 就能搜索了)

  1).文件-偏好设置：

  ![img](F:\Typora_book\typora_pic\1485694-20190712184226546-999655109.png)

  2).打开高级设置后，弹出如下文件：

  ![img](F:\Typora_book\typora_pic\1485694-20190712184256977-377481190.png)

  3).对这两个文件进行更改：

  ![img](F:\Typora_book\typora_pic\1485694-20190712184322119-481357297.png)

  ![img](F:\Typora_book\typora_pic\1485694-20190712184338652-56528039.png)

  

6.设置图片存储路径：最好为图床(七牛云等)，其次同步盘(oneDrive等)，最次本地硬盘

  使用本地硬盘的缺点：把文档发给别人同时还得发图片文件夹

  使用同步盘的缺点：只能自己看(因为同步盘是私人帐号)，可以跨设备

  使用图床的缺点：别人需要联网才能看你文档中的图片

  ![img](F:\Typora_book\typora_pic\1485694-20190712184423808-1313195992.png)

7.设置自动保存：

![img](F:\Typora_book\typora_pic\1485694-20190712184451967-700010203.png)

 

8.取消自动编号：

![img](F:\Typora_book\typora_pic\1485694-20190712184514074-582915823.png)

# Typora优化-适合不懂CSS代码的小白

转载[weixin_30517001](https://me.csdn.net/weixin_30517001) 发布于2019-07-01 19:22:00 收藏

展开

typora：不开源，测试期间免费，实时预览模式将「写作」和「预览」合二为一

1.扩展编辑器宽度：(解决因图片过大，即使编辑器全屏也模糊的问题、解决一行只能写860px宽度的文字限制)

1).通过文件-偏好设置 打开主题文件夹：

![img](F:\Typora_book\typora_pic\1485694-20190701184429374-154095391.png)



2). 打开主题文件夹 弹出如下文件：(我用的github主题，用什么主题就改 主题名.css)

   注：这个弹出的文件夹是在***\*C:\Users\用户名\AppData\Roaming\Typora\themes\****下的

​      并不是Typora安装目录中的 主题名.css，修改它不会生效，别找错了。

![img](F:\Typora_book\typora_pic\1485694-20190701184448481-860213723.png)



3).对该文件进行更改：max-width设置成显示器分辨率的宽度像素值

![img](F:\Typora_book\typora_pic\1485694-20190705105931356-1163611891.png)



给图片加阴影和圆角，使其更美观：

![img](F:\Typora_book\typora_pic\1485694-20190701214601448-1940180267.png)

4).找到Typora的安装目录：

![img](F:\Typora_book\typora_pic\1485694-20190705105956122-941627582.png)



5).对这3个文件进行修改：

![img](F:\Typora_book\typora_pic\1485694-20190705110018740-573841672.png)

![img](F:\Typora_book\typora_pic\1485694-20190705110035934-1655281918.png)

 

 取消图片的水平居中：

![img](F:\Typora_book\typora_pic\1485694-20190701205136842-457632435.png)

![img](F:\Typora_book\typora_pic\1485694-20190701205144475-880925106.png)





2.更改默认搜索google为bing:(以后选中文字右击选择search with bing 就能搜索了)

1).文件-偏好设置：

![img](F:\Typora_book\typora_pic\1485694-20190701184729772-188094811.png)



2).打开高级设置后，弹出如下文件：

![img](F:\Typora_book\typora_pic\1485694-20190701184736789-1227838203.png)



3).对这两个文件进行更改：

![img](F:\Typora_book\typora_pic\1485694-20190701184747920-1372092049.png)

 

![img](F:\Typora_book\typora_pic\1485694-20190701184807757-20599378.png)

 

3.设置图片存储路径：最好为图床(七牛云等)，其次同步盘(oneDrive等)，最次本地硬盘

 使用本地硬盘的缺点：把文档发给别人同时还得发图片文件夹

 使用同步盘的缺点：只能自己看(因为同步盘是私人帐号)，可以跨设备

 使用图床的缺点：别人需要联上网才能看你的md文档中的图片

![img](F:\Typora_book\typora_pic\1485694-20190701191154276-1660057312.png)

oneDrive既是网盘也是同步盘：

![img](F:\Typora_book\typora_pic\1485694-20190701191204015-350829374.png)

网盘：可以像某云一样上传下载文件

![img](F:\Typora_book\typora_pic\1485694-20190701191211927-514148714.png)

同步盘：5T容量配合Typora，绝配，当然用图床更好

![img](F:\Typora_book\typora_pic\1485694-20190701191220979-436510582.png)



4.设置自动保存：(以防万一)

![img](F:\Typora_book\typora_pic\1485694-20190701184847135-1440177032.png)

 



 

结。

 

转载于:https://www.cnblogs.com/nreg/p/11116176.html