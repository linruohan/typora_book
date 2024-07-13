# 使用msys2打造优雅的开发环境

[toc]



## 1 windows下常用的类似unix终端软件

windows下常用的类似unix终端软件有git fow windows(内置简版msys2)、mingw、msys2、cgwin。

- git fow windows： 不想折腾的同学，直接使用该软件就够用了。缺点是自带的预编译的软件包比较少。
- mingw： 打包了gcc等编译器，默认没有git，自带的预编译的软件包比较少。
- cygwin： 最全的类Unix环境支持。缺点：比较庞大。
- msys2：自带大量预编译的软件包，提供pacman便捷安装git、zsh、gcc等软件。推荐使用该软件。
### 1.1 msys2背景

msys2产生的背景：由于 MinGW 万年不更新，MSYS 更是，Cygwin的许多新功能 MSYS 没有同步过来，于是 Alex 等人建立了新一代的 MSYS 项目。仍然是 fork 了 Cygwin（较新版），但有个更优秀的包管理器 pacman，有活跃的开发者跟用户组，有大量预编译的软件包（虽然肯定没有Cygwin多）。

> 同时安装git fow windows和msys2，y运行命令可能出现"using incompatible versions of the cygwin DLL"问题。
>
> windows 10新增的wsl2也可以作为开发环境备选。但是由于IO性能差，git操作非常慢，所以用的不多，而 **msys2带有的 Bash 感觉是个不错的选择。**
>
本文基于 **msys2-bash + zsh + oh-my-zsh** 搭建类UNIX开发环境，效果：

[![img](https://img2020.cnblogs.com/blog/663847/202108/663847-20210819091430742-1398751503.png)](https://img2020.cnblogs.com/blog/663847/202108/663847-20210819091430742-1398751503.png)

下面是详细内容。

## 2 安装msys2

官网：https://www.msys2.org/

github: https://github.com/msys2/msys2-installer

镜像地址：https://mirrors.tuna.tsinghua.edu.cn/msys2/distrib/x86_64/

本文安装的版本是：https://github.com/msys2/msys2-installer/releases/download/2021-07-25/msys2-x86_64-20210725.exe

1、下载下来安装到C盘，完整路径：`C:\msys64`。没有特殊要求，请不要修改路径，后续都是参照这个路径增加功能。

2、配置环境变量。PATH里增加：`C:\msys64\usr\bin`。

### 2.1 配置pacman镜像

pacman是arclinux中的软件管理工具，也是widows上msys2默认的软件管理工具。pacman可以直接从网络上的软件仓库下载安装及删除软件，自动处理依赖关系，类似ubuntu中的apt-get。

镜像地址：https://mirrors.tuna.tsinghua.edu.cn/help/msys2/

进入`C:\msys64\etc\pacman.d`目录，分别进行如下操作：

编辑 `/etc/pacman.d/mirrorlist.mingw32` ，在文件开头添加：

```bash
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686
```

编辑 `/etc/pacman.d/mirrorlist.mingw64` ，在文件开头添加：

```bash
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64
```

编辑 `/etc/pacman.d/mirrorlist.ucrt64` ，在文件开头添加：

```bash
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/ucrt64
```

编辑 `/etc/pacman.d/mirrorlist.clang64` ，在文件开头添加：

```bash
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/clang64
```

编辑 `/etc/pacman.d/mirrorlist.msys` ，在文件开头添加：

```bash
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch
```

点击安装路径的`mingw64.exe`启动，然后执行 `pacman -Sy` 刷新软件包数据即可。

配置好 pacman 镜像源，就可以安装常用软件了。
```
pacman -Syu
```
随后根据提示关闭窗口，重新打开一个新的 bash 窗口以应用更新。
### 2.2 /etc/fstab 挂载 home

```bash
C:/Users me ntfs binary,posix=0,noacl,user 0 0
```
### 2.3 安装常用软件

#### 2.3.1 git

```undefined
pacman -S git
```

命令行里输入git version 可以查看版本：

```powershell
PS C:\Users\lenovo\Desktop> git version
git version 2.32.0
```

提示命令找不到可以重启试一下。

#### 2.3.2 安装 GCC 环境

为了开发需要，安装 GCC 环境及相关工具：

```bash
pacman -S mingw-w64-x86_64-cmake \
mingw-w64-x86_64-extra-cmake-modules \
mingw-w64-x86_64-make \
mingw-w64-x86_64-gdb \
mingw-w64-x86_64-toolchain
```
#### 2.3.3 环境变量配置
安装完成后，设置以下环境变量：
```bash
MSYS2_HOME=D:\msys64
MSYS2_PATH_TYPE=inherit
MSYSTEM=MINGW64
```
MSYS 2 有三种启动方式，分别是：
```
MSYS2 MSYS：set MSYSTEM=MSYS
MSYS2 MinGW 32bit：set MSYSTEM=MINGW32
MSYS2 MinGW 64bit：set MSYSTEM=MINGW64
```
在系统 PATH 中添加 MSYS 2 的路径：
```
%MSYS2_HOME%\bin
%MSYS2_HOME%\usr\bin
```
并在 MSYS 2 的 shell 窗口中编辑 ~/. Bashrc 文件，加入以下配置：
```
export PATH=$PATH:/mingw64/bin/
```


## 3 Pacman 的基本用法
Pacman 是 MSYS 2 和 Arch Linux 等系统中的包管理器，用于安装、更新和卸载软件包。以下是 Pacman 的一些基本命令：

安装软件
```
安装单个软件包：pacman -S 软件名
同时安装多个软件包：pacman -S 软件名 1 软件名 2 ...
安装软件，但跳过已经是最新版本的包：pacman -S --needed 软件名 1 软件名 2
更新软件包数据库后安装软件：pacman -Sy 软件名
显示操作信息后安装软件：pacman -Sv 软件名
仅下载软件包，不安装：pacman -Sw 软件名
安装本地软件包：pacman -U 软件名. Pkg. Tar. Gz
安装远程软件包（非官方源）：pacman -U http://www.example.com/repo/example.pkg.tar.xz
更新系统
更新软件包数据库：pacman -Sy
升级所有已安装的软件包：pacman -Su
同时更新软件包数据库和升级所有包：pacman -Syu
卸载软件
仅卸载软件包，保留依赖：pacman -R <软件名>
卸载软件包，并显示详细信息：pacman -Rv <软件名>
卸载软件包及其不再需要的依赖：pacman -Rs <软件名>
卸载软件包及其所有依赖（慎用）：pacman -Rsc <软件名>
卸载软件包，删除不再被任何已安装软件包所需要的依赖：pacman -Ru <软件名>
总结
通过上述步骤，你已经完成了 MSYS 2 的基本配置。有了 MSYS 2，Windows 用户可以方便地使用许多 Linux 下的工具和功能。MSYS 2 不仅提供了 Linux 风格的工作环境，还支持直接在 Windows 下运行 shell 脚本。这样的配置不仅提高了工作效率，也使得 Windows 平台上的开发体验更加接近 Linux 环境。
```

## 4 Oh My Zsh

**官方网站:** [http://ohmyz.sh](http://ohmyz.sh/)

**GitHub:** https://github.com/ohmyzsh/ohmyzsh

```bash
pacman -S zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 或者 
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

所以这时的`zsh` 基本已经配置完成,你需要一行命令就可以切换到 `zsh` 模式，终端下输入`zsh`切换，输入`bash`切回去。

ohmyzsh插件，路径：

```bash
~/.oh-my-zsh/plugins/
~/.oh-my-zsh/custom/plugins/
```

新增插件示例：

```bash
git clone git://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

启用插件：修改`~/.zshrc`文件，示例：

```ini
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

默认是`plugins=(git)`

执行下 `source ~/.zshrc`激活插件。

## 5 配置右键打开终端[#](https://www.cnblogs.com/52fhy/p/15158765.html#配置右键打开终端)

效果：

[![img](https://img2020.cnblogs.com/blog/663847/202108/663847-20210819090842125-70960725.png)](https://img2020.cnblogs.com/blog/663847/202108/663847-20210819090842125-70960725.png)

新建mingw64.reg后缀文件：

```swift
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\Background\shell\mingw64]
@="MinGW64 Here"
"icon"="C:\\msys64\\mingw64.exe"

[HKEY_CLASSES_ROOT\Directory\Background\shell\mingw64\command]
@="C:\\msys64\\msys2_shell.cmd -mingw64 -here"
```

双击导入即可。

## 6 配置 Windows Terminal 使用 msys2 bash[#](https://www.cnblogs.com/52fhy/p/15158765.html#配置-windows-terminal-使用-msys2-bash)

核心参数：

名称：msys2

命令行：C:\msys64\usr\bin\bash.exe

icon: C:\msys64\msys2.ico

```swift
{
    "guid":"{1c4de342-38b7-51cf-b940-2309a097f589}",
    "hidden":false,
    "name":"Bash",
    "commandline":"C:\\msys64\\usr\\bin\\bash.exe",
    "historySize":9001,
    "closeOnExit":true,
    "useAcrylic":true,
    "acrylicOpacity":0.85,
    "icon":"C:\\msys64\\msys2.ico",
    "startingDirectory":null
}
```

[![img](https://img2020.cnblogs.com/blog/663847/202108/663847-20210819090942591-1019444194.png)](https://img2020.cnblogs.com/blog/663847/202108/663847-20210819090942591-1019444194.png)

## 7 配置 zsh 为 bash 默认终端[#](https://www.cnblogs.com/52fhy/p/15158765.html#配置-zsh-为-bash-默认终端)

编辑 `~/.bashrc`，加入下面的几行。

```bash
# Launch Zsh
if [ -t 1 ]; then
exec zsh
fi
```

## 8 配置idea[#](https://www.cnblogs.com/52fhy/p/15158765.html#配置idea)


点击 File -> Settings -> Tools -> Terminal ，配置shell path:

```makefile
C:\msys64\usr\bin\bash.exe
```

或者

```makefile
C:\msys64\usr\bin\zsh.exe
```

这样就可以执行bash命令了。例如：

```shell
$ cd /d/Download/

$ ls | wc -l
81

$ which mvn
/e/opt/apache-maven-3.6.3/bin/mvn

$ cd ~
```

## 9 附录1: pacman常用命令[#](https://www.cnblogs.com/52fhy/p/15158765.html#附录1-pacman常用命令)

pacman命令较多，作为新手，将个人最常用的命令总结如下：

- `pacman -Sy`: 从服务器下载新的软件包数据库（实际上就是下载远程仓库最新软件列表到本地）。
- `pacman -Syu`: 升级系统及所有已经安装的软件。
- `pacman -S 软件名`: 安装软件。也可以同时安装多个包，只需以空格分隔包名即可。
- `pacman -Rs 软件名`: 删除软件，同时删除本机上只有该软件依赖的软件。
- `pacman -Ru 软件名`: 删除软件，同时删除不再被任何软件所需要的依赖。
- `pacman -Ssq 关键字`: 在仓库中搜索含关键字的软件包，并用简洁方式显示。
- `pacman -Qs 关键字`: 搜索已安装的软件包。
- `pacman -Qi 软件名`: 查看某个软件包信息，显示软件简介,构架,依赖,大小等详细信息。
- `pacman -Sg`: 列出软件仓库上所有的软件包组。
- `pacman -Sg 软件包组`: 查看某软件包组所包含的所有软件包。
- `pacman -Sc`：清理未安装的包文件，包文件位于 /var/cache/pacman/pkg/ 目录。
- `pacman -Scc`：清理所有的缓存文件

## 10 附录2：解决vscode不识别git问题[#](https://www.cnblogs.com/52fhy/p/15158765.html#附录2解决vscode不识别git问题)

使用msys2环境安装git，vscode识别不出来git，在源代码管理菜单中显示当前打开的文件夹没有git存储库，打开的文件夹实际存在.git文件夹。

解决办法：

1. 编写 git-wrap.bat：

   ```dos
   @echo off
   setlocal
   
   rem If you don't add path for msys2 into %PATH%, enable following line.
   rem set PATH=c:\msys64\usr\bin;%PATH%
   
   if "%1" equ "rev-parse" goto rev_parse
   git %*
   goto :eof
   :rev_parse
   for /f %%1 in ('git %*') do cygpath -w %%1
   ```

   将 git-wrap.bat放到某个文件夹，例如位于：`c:\msys64\git-wrap.bat`。

2. 在vscode设置 `git.path` ：
   点击： `File` -> `Preferences` -> `User Settings`, 搜索 `git.path` 将 `git-wrap.bat`写到配置文件里：

   ```swift
    "git.path": "C:\\msys64\\git-wrap.bat",
   ```

3. 重启vscode

Have fun!

## 11 附录3：Windows Terminal右键[#](https://www.cnblogs.com/52fhy/p/15158765.html#附录3windows-terminal右键)

编写wt.reg:

```swift
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\Background\shell\wt]
@="Windows Terminal Here"

[HKEY_CLASSES_ROOT\Directory\Background\shell\wt\command]
@="C:\\Users\\你的用户名\\AppData\\Local\\Microsoft\\WindowsApps\\wt.exe"
```

注意替换"你的用户名"。



