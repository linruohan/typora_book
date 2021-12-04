# github hosts （github直连访问方法，长期更新的）

[toc]

## 轻松直连github：

### 项目地址

**某大佬写的，菜鸡不生产代码，但是可以搬运代码，https://github.com/521xueweihan/GitHub520**

如果你能访问github，直接看这个项目吧，不需要下面内容

### ==获取github hosts（win）==

访问此链接直接下载hosts，**https://cdn.jsdelivr.net/gh/521xueweihan/GitHub520@main/hosts**

复制里面内容添加到系统hosts文件的最后（详细看下面）

## 什么是hosts

修改hosts是防止dns污染，加速域名解析等，并非翻墙

## 如何修改hosts

### **修改 hosts 文件**

hosts 文件在每个系统的位置不一，详情如下：

- Windows 系统：`C:\Windows\System32\drivers\etc\hosts`
- Linux 系统：`/etc/hosts`
- Mac（苹果电脑）系统：`/etc/hosts`
- Android（安卓）系统：`/system/etc/hosts`
- iPhone（iOS）系统：`/etc/hosts`

修改方法，把第一步的内容复制到文本末尾：

1. Windows 使用记事本。
2. Linux、Mac 使用 Root 权限：`sudo vi /etc/hosts`。
3. iPhone、iPad 须越狱、Android 必须要 root。

###  **激活生效**

大部分情况下是直接生效，如未生效可尝试下面的办法，刷新 DNS：

1. Windows：在 CMD 窗口输入：`ipconfig /flushdns`
2. Linux 命令：`sudo rcnscd restart`
3. Mac 命令：`sudo killall -HUP mDNSResponder`

**Tips：** 上述方法无效可以尝试重启机器。



## hosts内容如下：

![img](https://i0.hdslb.com/bfs/article/bd013a68d3387386f2233516ca8d9b17ac49168a.png@942w_666h_progressive.webp)hosts
