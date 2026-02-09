# [npm更换成淘宝镜像源以及cnpm](https://www.cnblogs.com/onew/p/11330439.html)

#### 0.1.1 1.需求由来

由于node安装插件是从国外服务器下载，受网络影响大，速度慢且可能出现异常。所以如果npm的服务器在中国就好了，所以我们乐于分享的淘宝团队（[阿里巴巴](https://links.jianshu.com/go?to=https%3A%2F%2Fbaike.baidu.com%2Fitem%2F%E9%98%BF%E9%87%8C%E5%B7%B4%E5%B7%B4%E9%9B%86%E5%9B%A2%2F9087864%3Ffromtitle%3D%E9%98%BF%E9%87%8C%E5%B7%B4%E5%B7%B4%26fromid%3D33)旗下业务[阿里云](https://links.jianshu.com/go?to=https%3A%2F%2Fbaike.baidu.com%2Fitem%2F%E9%98%BF%E9%87%8C%E4%BA%91)）干了这事。来自官网：“这是一个完整 npmjs.org 镜像，你可以用此代替官方版本(只读)，同步频率目前为 10分钟 一次以保证尽量与官方服务同步。

也就是说我们可以使用阿里布置在国内的服务器来进行node安装。

#### 0.1.2 2.使用方法

1.使用阿里定制的 cnpm 命令行工具代替默认的 npm，输入下面代码进行安装：

```
$ npm install -g cnpm --registry=https://registry.npm.taobao.org
```

2.检测cnpm版本，如果安装成功可以看到cnpm的基本信息。

```
cnpm -v
```

3.以后安装插件只需要使用`cnpm intall`即可

------

> 假如我已经习惯了`npm install`的安装方式，我不想去下载阿里的cnpm命令工具将命令变成cnpm怎么办？很容易我们想到，我直接将node的仓库地址改成淘宝镜像的仓库地址不就好了吗？

#### 0.1.3 3.单次使用

```
npm install --registry=https://registry.npm.taobao.org
```

#### 0.1.4 4.永久使用

设置成全局的下载镜像站点，这样每次install的时候就不用加--registry，默认会从淘宝镜像下载，设置方法如下：

```
1.打开.npmrc文件（nodejs\node_modules\npm\npmrc，没有的话可以使用git命令行建一个( touch .npmrc)，用cmd命令建会报错）
2.增加 registry =https://registry.npm.taobao.org  即可。
```

也可以按如下方式直接在命令行设置

```
npm config set registry https://registry.npm.taobao.org
```

检测是否成功


```bash


npm config set registry https://mirrors.huaweicloud.com/repository/npm/
npm config set prefix C:\software\nodejs\npm_global
npm config set progress true
npm i -g pnpm
pnpm config set prefix C:\software\nodejs\pnpm_global

```