# 升级 Win11 条件不满足，有哪些解决办法？

[toc]

## 首先使用WhyNotWin11或者微软官方检测工具进行检测，看看是哪一项不符合要求

1. 如果是CPU，内存的话不建议升级，硬升会卡
2. 要是只是TPM 2.0或者Safe Boot安全启动的话可以升级要么使用网上的办法删除dll文件（但是不保证可以在正式版里面成功），

​	要么使用OfflineInsiderEnroll（网上搜cmd）进行强制进入如果没有使用任何方法使用U盘升级在你打开设置里面的预览体验计划并登录账号后你会看到一个红色的框，一大堆英文大概意思是你电脑不满足硬件要求也就是你被wip踢掉了无法收到更新建议滚回Win10或者回到release preview



==不满足最低要求的设备将继续运行 Windows 10，在2025年10月14日之前，微软将继续支持 Windows 10 安全更新。具体可以查询官方的Windows 10生命周期文档。==

**1.**通过更新推送升级，微软这次用了分阶段推送的政策，如果满足了升级要求，但是没有收到推送升级，等下一批吧。

**2.**先在官网下载Win11的安装助手，然后通过Win11安装助手升级

**3.**通过下载Win11镜像升级。

**4.**通过创建Windows11 安装媒体工序，制作Windows 11的启动盘安装Win11,虽说听起来很麻烦。如果不着急体验Win11的话建议先不要升级。不建议更新啊小伙伴们。





## 绕开限制，直接安装，B站有教程。

时间：2022/3/13 上午我的电脑是i5-7300hq，不符合升级win11的标准，但是又想体验win11，于是去网上找了很多方法，结果很多方法都已经无法使用了，最后结合了几种方法才成功，于是给大家分享一下我使用的方法。首先本文的方法是针对配置达不到win11的用户的，若配置已达到，无需使用此方法。

### 第一步先修改[注册表](https://www.zhihu.com/search?q=注册表&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2387053491})：win+R键，然后输入[regedit](https://www.zhihu.com/search?q=regedit&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2387053491})，敲击回车进入注册表。

### ![img](https://picx.zhimg.com/80/v2-f247df0bcda3c2537d3c2e917a161783_720w.webp?source=1940ef5c)然后找到HKEY_LOCAL_MACHINE，进入之后再找到SYSTEM，进入之后再找到Setup，然后点击，在右侧空白区域右键，选择新建项，新项的名字为LabConfig![img](https://picx.zhimg.com/80/v2-282621c3e3d8a57f3bacd5969a2853ff_720w.webp?source=1940ef5c)新建完成后点击进入LabConfig，在LabConfig中右键，选择新建字符串值，名字为BypassTPMCheck，然后点击刚才新建的BypassTPMCheck，右键选择修改，将数值数据修改为00000001![img](https://pic1.zhimg.com/80/v2-e00c9cfdb0af046b6a01de931e75f32b_720w.webp?source=1940ef5c)之后再按照同样的方法新建BypassSecureBootCheck，值也是00000001都新建完成后关闭注册表，去

## 官网下载升级工具，链接：[win11下载链接](https://link.zhihu.com/?target=https%3A//software-download.microsoft.com/download/pr/888969d5-f34g-4e03-ac9d-1f9786c69161/MediaCreationToolW11.exe)下载完成后正常解压，注意：不要下载到C盘，我下载到了E盘安装完成后，

## 进入刚才下载的目录找到[sources文件夹](https://www.zhihu.com/search?q=sources文件夹&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2387053491})![img](https://pica.zhimg.com/80/v2-5e9192db07ac445cde39742605dd5876_720w.webp?source=1940ef5c)进入sources文件夹后找到[appraiserres.dll](https://www.zhihu.com/search?q=appraiserres.dll&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A2387053491})并删除，有很多名字类似的文件，注意不要删错了。

## 删除之后回到上层目录，双击setup.exe进行安装

## ![img](https://pica.zhimg.com/80/v2-611749a1a324e6656617929bf3b91595_720w.webp?source=1940ef5c)最后附一张刚刚升级的win11图![img](https://picx.zhimg.com/80/v2-d08f626c4fda4febc0f02c053d7a516b_720w.webp?source=1940ef5c)