# bypy-命令行下使用百度网盘
因为常常使用云端服务器，特别希望能有一个命令行下的网盘来使用，于是就发现了bypy，这个工具利用了百度网盘开放的api，将文件储存在百度网盘/apps/bypy/之下，从而实现使用百度网盘上传下载。
在管理一些需要备份的大文件的时候，git与GitHub就不是那么好用了，毕竟GitHub主要用来管理代码版本，在生物信息学中，如genome index、genome、annotation、snp等文件信息一般不发生变动，生成或者下载好了之后就可以放在那里一直用下去，我们唯一的需求就是找个网盘备份，以便不时之需，这个时候bypy就派上用场了。
![img](https://pic4.zhimg.com/80/v2-067d123d29554839cbad90cfefcf25d3_720w.webp)

## 1 Install

```text
pip install bypy
```

## 2 第一次使用

第一次使用的时候，因为需要注册访问百度网盘api，所以随便输入一个bypy命令，如：

```text
bypy info
```

这时会命令行返回一个网址，打开此网址，登录百度网盘之后，得到验证码，返回命令行输入此验证码，即可使bypy得到百度网盘api使用权限，接下来就可以使用bypy管理百度网盘文件的上传下载了。

## 3 上传文件

指定路径上传

```text
bypy syncup xxx
# 或者
bypy upload xxx
```
不加 xxx 时，则上传当前目录
## 4 下载文件
下载单个文件 xxx
```text
bypy downfile xxx
```
指定路径下载
```text
bypy syncdown 
# 或者 
bypy downdir /
```
bypy downdir /aaa/bbb 可以选择文件夹，下载**百度网盘/apps/bypy/aaa/bbb**文件夹的内容到本地
### 4.1 更多命令和使用帮助 
```text
bypy -h
```