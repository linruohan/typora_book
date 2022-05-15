# 在WSL2中安装ArchLinux



## **1. 启用WSL**

用管理员打开powershell输入

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

## **2. 升级为WSL2的必要条件**

- 对于x64的系统要求win10版本为**1903** 或者更高
- win + R 输入 `winver`查看版本

## **3. 启用虚拟平台**

用管理员打开powershell输入

```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

## **4. 下载Linux内核升级包**

下载地址：[https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi](https://link.zhihu.com/?target=https%3A//wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

下载完成后双击安装

## **5. 将WSL2设置为默认版本**

用管理员打开powershell输入

```powershell
wsl --set-default-version 2
```

到这里WSL就安装好了，下面安装ArchLinux

## **6. 安装LxRunOffline**

下载地址：[https://github.com/DDoSolitary/LxRunOffline/releases](https://link.zhihu.com/?target=https%3A//github.com/DDoSolitary/LxRunOffline/releases)

选择最新版下载，解压后将LxRunOffline.exe放入任意一个path文件夹下（比如C:/Windows/System32）

## **7. 下载Archlinux**

下载地址：[https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/](https://link.zhihu.com/?target=https%3A//mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/)

找到 `archlinux-bootstrap-2020.10.01-x86_64.tar.gz`， 注意是 `tar.gz`文件

## **8. 安装archlinux到WSL**

命令1：

```text
LxRunOffline i -n <自定义名称> -f <Arch镜像位置> -d <安装系统的位置> -r root.x86_64
```

比如：

```bash
LxRunOffline i -n ArchLinux -f D:\archlinux-bootstrap-2022.05.01-x86_64.tar.gz -d d:\archlinux -r root.x86_64
wsl --set-version ArchLinux 2
```

## **9. 进入系统**

命令：

```text
wsl -d <名字>
```

比如:

```text
wsl -d ArchLinux
```

在这里我们就进入了archlinux内部，然后以下操作在archlinux中进行

删除`/etc/resolv.conf`文件

执行命令

```text
rm /etc/resolv.conf
```

重新启动Archlinux

```text
exit
```

执行上述命令后会退出arch,回到powershell,然后在powershell中执行

```text
wsl --shutdown <名字>
```

比如：

```text
wsl --shutdown ArchLinux
```

然后再次进入Arch

```text
wsl -d ArchLinux
```

在Arch中执行

```text
cd /etc/
explorer.exe .
```

注意后面的点，执行这条命令后会用windows的文件管理器打开/etc目录，然后找到pacman.conf，在这个文件最后加入

```text
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```

然后进入下一级目录`pacman.d`,编辑里面的mirrolist文件，将China的源注释去掉（选择部分即可）

然后回到Arch，执行

```text
pacman -Syy
pacman-key --init
pacman-key --populate
pacman -S archlinuxcn-keyring
pacman -S base base-devel vim git wget
```

然后别忘了给当前的root设置密码

```text
passwd
```

然后新建一个普通用户

```text
useradd -m -G wheel -s /bin/bash <用户名>
passwd <用户名>
```

将文件`/etc/sudoers`中的`wheel ALL=(ALL) ALL`那一行前面的注释去掉

```text
vim /etc/sudoers
```

查看当前用户id

```text
id -u <用户名>
```

## **10. 设置使用普通用户登录Archlinux**

紧接上一步，退出Arch

```text
exit
```

在powershell中执行

```text
lxrunoffline su -n <你的arch名字> -v <账户id>
```

到这里就结束了