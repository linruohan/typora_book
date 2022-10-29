# github hosts （github直连访问方法，长期更新的）

[toc]

## 1 轻松直连github：

[ineo6 / Hosts · GitLab](https://gitlab.com/ineo6/hosts)

```bash
# New！欢迎使用基于DNS的新方案
# https://gitlab.com/ineo6/hosts
# GitHub Host Start
```

## 2 如何修改hosts

### 2.1 **修改 hosts 文件**

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

### 2.2 **激活生效**

大部分情况下是直接生效，如未生效可尝试下面的办法，刷新 DNS：

1. Windows：在 CMD 窗口输入：`ipconfig /flushdns`
2. Linux 命令：`sudo rcnscd restart`
3. Mac 命令：`sudo killall -HUP mDNSResponder`

**Tips：** 上述方法无效可以尝试重启机器。

