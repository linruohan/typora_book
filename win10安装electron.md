win10下载安装electron

1.1、下载Nodejs
官网：https://nodejs.org/

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200426140547342.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjY3NjE0OQ==,size_16,color_FFFFFF,t_70)

1.2、根据电脑配置选择合适的版本进行安装。window下载.msi文件或者.zip压缩包，我这里选择的是（node-v12.16.2-x64.msi）。安装，自动将路劲加入了Path路径，即可全局使用。

1.3、验证安装
验证是否安装成功：

cmd下

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200426140855183.png)

node -v
npm -v
1
2

2.1安装electron
cmd下

`npm install electron -g
`1
但是安装到

node install.js
1
时卡了很久，可能是一些源被墙的问题
这里使用cnpm安装

**cnpm**

“”
cnpm跟npm用法完全一致，只是在执行命令时将npm改为cnpm。
npm安装插件是从国外服务器下载，受网络影响大，可能出现异常，如果npm的服务器在中国就好了，于是淘宝团队干了这事。来自官网：“这是一个完整 npmjs.org 镜像，你可以用此代替官方版本(只读)，同步频率目前为 10分钟 一次以保证尽量与官方服务同步。
官方地址：http://npm.taobao.org
安装：$ npm install -g cnpm --registry=https://registry.npm.taobao.org
https://blog.csdn.net/qq_32614411/article/details/80894605

2.2安装cnpm

`nup install -g cnpm
`

3.1 安装electron

```sh
cnpm install -g electron
```



3.2测试
在cmd窗体中输入electron弹出以下窗口说明安装成功

electron

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200426141353435.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NjY3NjE0OQ==,size_16,color_FFFFFF,t_70)