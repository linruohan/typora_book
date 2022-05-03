# github hosts （github直连访问方法，长期更新的）

[toc]

## 轻松直连github：

https://gitee.com/ineo6/hosts

```bash
# New！欢迎使用基于DNS的新方案
# https://gitee.com/ineo6/hosts/raw/master/next-hosts
# GitHub Host Start

185.199.108.154              github.githubassets.com
140.82.113.22                central.github.com
185.199.108.133              desktop.githubusercontent.com
185.199.108.153              assets-cdn.github.com
185.199.108.133              camo.githubusercontent.com
185.199.108.133              github.map.fastly.net
199.232.69.194               github.global.ssl.fastly.net
140.82.112.4                 gist.github.com
185.199.108.153              github.io
140.82.113.4                 github.com
140.82.112.5                 api.github.com
185.199.108.133              raw.githubusercontent.com
185.199.108.133              user-images.githubusercontent.com
185.199.108.133              favicons.githubusercontent.com
185.199.108.133              avatars5.githubusercontent.com
185.199.108.133              avatars4.githubusercontent.com
185.199.108.133              avatars3.githubusercontent.com
185.199.108.133              avatars2.githubusercontent.com
185.199.108.133              avatars1.githubusercontent.com
185.199.108.133              avatars0.githubusercontent.com
185.199.108.133              avatars.githubusercontent.com
140.82.112.10                codeload.github.com
52.217.97.252                github-cloud.s3.amazonaws.com
52.217.224.241               github-com.s3.amazonaws.com
52.216.28.36                 github-production-release-asset-2e65be.s3.amazonaws.com
54.231.98.136                github-production-user-asset-6210df.s3.amazonaws.com
54.231.162.129               github-production-repository-file-5c1aeb.s3.amazonaws.com
185.199.108.153              githubstatus.com
64.71.144.211                github.community
185.199.108.133              media.githubusercontent.com
185.199.108.133              objects.githubusercontent.com
185.199.108.133              raw.github.com

# Please Star : https://github.com/ineo6/hosts
# Mirror Repo : https://gitee.com/ineo6/hosts

# Update at: 2022-04-30 09:05:47

# GitHub Host End
```





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

