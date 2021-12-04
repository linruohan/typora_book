# gist.github.com 无法访问解决办法

```shell
编辑C:\Windows\System32\drivers\etc\hosts 在最后一行添加：

192.30.253.118 gist.github.com
```

## [![返回主页](https://www.cnblogs.com/skins/custom/images/logo.gif)](https://www.cnblogs.com/lychee/)

# [Lychee's Blog](https://www.cnblogs.com/lychee/)https://www.cnblogs.com/lychee/p/11214032.html#903404552)

==Settings Sync可以同步你当前的VSCode配置环境==，当你需要在其它的电脑工作时，您不用重头再来一遍。新机器登录一下就搞定了。再也不用折腾环境了。

大致原理：使用GitHub Gist来同步多台计算机上的设置，代码段，主题，文件图标，启动，键绑定，工作区和扩展。

## 环境版本：[#](https://www.cnblogs.com/lychee/p/11214032.html#2379894430)

Visual Studio Code 1.36

Settings Sync 3.4.0

## 初次使用：

在VSCode中点击扩展，搜索：**Settings Sync** 安装

![image-20191214090849568](F:\Typora_book\typora_pic\image-20191214090849568.png)

安装好扩展之后我们**登录GitHub开通并创建一个Gist**（代码片段管理服务）来保存你的环境配置。

登录你的Github 点击头像 进入**Settings**页面

在Settings页面点击进入 **Developer settings** （开发者设置）再点击进入**Personal access tokens** （个人授权令牌）页面生成一个令牌 点击 **Generate new token**

![img](F:\Typora_book\typora_pic\5d313635226a177061.png)

令牌的作用能帮助我们就在VSCode中使用自己的私有令牌访问自己的保存在Gist上的配置

所以我们输入令牌备注，勾选Gist，点击生成。

![img](F:\Typora_book\typora_pic\5d3136a7d65f531129.png)

然后你就获得了自己的Gist专属访问令牌，你可以用记事本保存下来，待会并且未来你可能需要在另一台电脑下载你的配置 你同样需要使用到这个令牌。（截图中生成Token演示后删除，请自己生成）

![img](F:\Typora_book\typora_pic\5d3136e320a0b54947.png)

然后再次点击你的头像 点击进入->Gist页面 点击**创建一个新Gist**。

![img](F:\Typora_book\typora_pic\5d313c6642f9569479.png)

输入创建的Gist描述和片段内容，保存即可。

![img](F:\Typora_book\typora_pic\5d313cce374fc30585.png)

手动复制刚才创建的Gist仓库的ID：它显示在浏览器url最后一串字符串或者截图中第二个框gist冒号后面的字符串（如下图）把它保存在你的记事本中

![image-20191214091458645](F:\Typora_book\typora_pic\image-20191214091458645.png)

回到VSCode编辑器中 使用快捷键`Ctrl+P` 输入命令 `>sync` 点击 **同步：高级选项**

ps：如果有问题，可以点红框下面的 **扩展设置重置** 它不会清除你现有的扩展，只恢复初始sync的配置） 快捷键的用法是 `Ctrl+P` 输入命令：`>Sync: Reset Extension Settings`

![img](F:\Typora_book\typora_pic\5d31605aab27054134.png)

然后选择同步：编辑配置设置(截图中文翻译错误)

![img](F:\Typora_book\typora_pic\5d315cdb7819980414.png)

输入你在github上创建的gist token 记得使用`Ctrl+S`保存更改

![image-20191214093548679](F:\Typora_book\typora_pic\image-20191214093548679.png)

ctrl + shift+p 打开命令输入：sync

![image-20191214093643006](F:\Typora_book\typora_pic\image-20191214093643006.png)

输入创建的Gist仓库ID 输入自动保存设置

![img](F:\Typora_book\typora_pic\5d315fba63ab391573.png)

使用Settings Sync我们需要记住两个快捷键：

`Shift + Alt + U` 将配置环境 扩展插件信息上传到云端

`Shift + Alt + D` 下载云端的配置

你还可以在你的==Gist仓库中==查看，看看Settings Sync上传了什么

![img](F:\Typora_book\typora_pic\5d3165a022f2664570.png)





快捷键Shift+Alt+D 下载配置

同步成功 需要**重启**VSCode

### 1、扩展设置重置[#](https://www.cnblogs.com/lychee/p/11214032.html#4036351607)

它不会清除你现有的扩展，只恢复初始sync的配置） 快捷键的用法是 Ctrl+P 输入命令：`>Sync: Reset Extension Settings`

### 2、更改Settings Sync配置文本[#](https://www.cnblogs.com/lychee/p/11214032.html#4163084651)

设置Token ID

### 3、设置Gist ID[#](https://www.cnblogs.com/lychee/p/11214032.html#551013439)

然后同步上传或者下载配置。

==token:	b97c1f7365e6de46231dbc8fb0835eaf1f35a8ff==
		==gist:	660ebe88f68d8e9e2ce87863e853c932==