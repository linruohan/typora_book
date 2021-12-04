# [you-get下载酷我音乐付费歌曲](https://www.cnblogs.com/aloe-n/p/7616909.html)

[You-Get](https://github.com/soimort/you-get)是一个基于 **Python 3** 的命令行下载工具。使用 You-Get 可以很轻松的下载到网络上的视频、图片及音乐。

下面以下载酷我音乐付费歌曲为例说明:

有关you-get的详细说明请移步[中文说明](https://github.com/soimort/you-get/wiki/中文说明).

1.安装you-get,打开命令行,输入

```
pip install you-get
```

 

2.在酷我网页中找到歌曲链接,以阿桑女神的<寂寞在唱歌>为例 http://www.kuwo.cn/yinyue/104599?catalog=yueku2016

 

3.输入命令开始下载(默认下载到C:\Users\用户名目录下)

```
you-get http://www.kuwo.cn/yinyue/104599?catalog=yueku2016
```

 

#### 注意:文件默认保存在`C:\Users\用户名`目录下，如果想自定义保存位置，使用如下命令即可,比如要保存在E:/download

```
C:\Users\hookb>you-get -o E:/download http://www.kuwo.cn/yinyue/104599?catalog=yueku2016
```

 

标签: [you-ge](https://www.cnblogs.com/aloe-n/tag/you-get 下载付费内容/)