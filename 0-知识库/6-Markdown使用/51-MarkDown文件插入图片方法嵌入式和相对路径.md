### MarkDown文件插入图片方法嵌入式和相对路径

![img](D:\Typora_pic\reprint.png)![img](D:\Typora_pic\articleRead.png) 6485 ![img](D:\Typora_pic\collect.png) 收藏 2

### 第一种方法：相对路径

1. 将md文件和图片放在同级目录下
2. 引用图片时写成这种格式，就表示引用的是相对路径，当然其他路径可自行更改。以后复制文件的时候需要将图片一起打包进行传输。![img](D:\Typora_pic\20190215143312575.PNG)

### 第二种方法:绝对路径:

==插入本地图片==
只需要在基础语法的括号中填入图片的位置路径即可，支持绝对路径和相对路径。
例如：
![avatar](/home/picture/1.png)<font color=red>不灵活不好分享，本地图片的路径更改或丢失都会造成markdown文件调不出图。</font>	

==插入网络图片==
只需要在基础语法的括号中填入图片的网络链接即可，现在已经有很多免费/收费图床和方便传图的小工具可选。<font color=red>将图片存在网络服务器上，非常依赖网络。</font>例如：
![avatar](http://baidu.com/pic/doge.png)



### 第三种方法：内嵌式

1. 通过[imageTobase64](http://imgbase64.duoshitong.com/)网站，将图片编程base64格式。
2. 然后调用的时候参见以下方式，括号中为转换的base64格式的图片，但是这样有一个不好的地方，就是文件内容太大，一般需要设置一个中间变量。如下面的方式。![img](D:\Typora_pic\20190215144220769.PNG)
3. 设置中间变量进行调用。(如果能够把大段的base64字符串放在==文章末尾==，然后在文章中通过一个id来调用，)
```
![avatar][doge]
[doge]:data:image/png;base64,iVBORw0......

```
![img](D:\Typora_pic\20190215144141324.PNG)

参考文章：

 [MarkDown添加图片的三种方式](https://blog.csdn.net/SlaughterDevil/article/details/79255933)

## 插图最基础的格式就是：

![Alt text](图片链接 "optional title")

1. Alt text：图片的Alt标签，用来描述图片的关键词，可以不写。最初的本意是当图片因为某种原因不能被显示时而出现的替代文字，后来又被用于SEO，可以方便搜索引擎根据Alt text里面的关键词搜索到图片。

2. 图片链接：可以是图片的本地地址或者是网址。”optional title”：鼠标悬置于图片上会出现的标题文字，可以不写。




然后，base64的图片编码如何得来？
图片转化为base64字符串

```python
import base64
f=open('723.png','rb') #二进制方式打开图文件
ls_f=base64.b64encode(f.read()) #读取文件内容，转换为base64编码
f.close()
print(ls_f)
```

base64字符串转化为图片

```python
import base64
bs='iVBORw0KGgoAAAANSUhEUg....' # 太长了省略
imgdata=base64.b64decode(bs)
file=open('2.jpg','wb')
file.write(imgdata)
file.close()
```

