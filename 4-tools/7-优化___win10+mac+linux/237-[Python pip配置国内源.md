# [Python pip配置国内源](https://www.cnblogs.com/schut/p/10410087.html)

　　众所周知，Python使用pip方法安装第三方包时，需要从 https://pypi.org/ 资源库中下载，但是会面临下载速度慢，甚至无法下载的尴尬，这时，你就需要知道配置一个国内源有多么重要了，通过一番摸索和尝试，总结了一些经验，分享给大家：

```
清华大学：https://pypi.tuna.tsinghua.edu.cn/simple
阿里云：http://mirrors.aliyun.com/pypi/simple/
豆瓣：http://pypi.douban.com/simple/
```

　　接下来，按照不同需要和不同平台依次演示安装方法：

　　 **方式一：临时使用国内pypi镜像安装**

```
pip install -i http://pypi.douban.com/simple/ numpy
pip install -i http://pypi.douban.com/simple/--trusted-host pypi.douban.com  #此参数“--trusted-host”表示信任，如果上一个提示不受信任，就使用这个
```

　　**方式二：永久使用国内pypi镜像安装**

　　 **1、 Linux平台安装方式：**

```c#
vim ~/.pip/pip.conf

[global] 
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host = https://pypi.tuna.tsinghua.edu.cn
```

　　**2、Window平台安装方式：**

　　（1）![image-20191213232457382](F:\Typora_book\typora_pic\image-20191213232457382.png)

　　（2）接着在 pip 文件夹中创建一个名为 pip .ini 

```
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host = https://pypi.tuna.tsinghua.edu.cn
```

　　　修改完成后保存，启动cmd，使用 " pip install xxx "(xxx为你要下载的包名)，即可默认使用国内源下载。