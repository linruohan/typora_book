# 0.1 更换 `PowerShell` 字体

还记得前面显示的命令的乱码吗 ？我们更换字体解决它。示例安装 `FantasqueSansMono-NF` 字体（也可以使用系统自带字体，这一步就不需要安装）。
[GitHub - belluzj/fantasque-sans: A font family with a great monospaced variant for programmers.](https://github.com/belluzj/fantasque-sans)
```bash
> scoop search FantasqueSansMono-NF
> scoop bucket add 'nerd-fonts'
# 下面一个命令要加 sudo 提权
> sudo scoop install FantasqueSansMono-NF
```

## 1 安装 Scoop
通过以下命令，可以将Scoop安装到默认目录（`C:\Users\<username>\scoop`）：
```powershell
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
```
或者另一条更短的命令：
```powershell
iwr -useb get.scoop.sh | iex
```
### 1.1 如果你需要更改默认的安装目录，则需要在执行以上命令前添加环境变量的定义，通过执行以下命令完成：
```powershell
$env:SCOOP='D:\Applications\Scoop'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
```
其中目录 `D:\Applications\Scoop` 可根据自己的情况修改。
## 2 scoop 代理
如果你访问 Github 有问题，或下载其中的资源有问题，可尝试以下方法：
1.  设置Scoop代理。在命令行中输入（PowerShell或者CMD中都行）`scoop config proxy 127.0.0.1:7890`（一看就是clash用户）让scoop网络连接走代理，后面的ip地址和端口根据自己的代理设置。
2.  使用[Gitee镜像源](https://gitee.com/squallliu/scoop)。可能备份更新得不是那么勤快，以及实际下载软件包同样会有网络问题，所以不推荐。在命令行中输入`scoop config SCOOP_REPO https://gitee.com/squallliu/scoop`修改仓库源的地址。

（或者更直接点，找到Scoop配置文件，路径`C:\Users\username\.config\scoop\config.json`，然后直接修改里面的配置，如下图：

  

![](https://pic1.zhimg.com/v2-678d6b6e5f52caae3ea284c5d816e85c_r.jpg)

## 3 Scoop 常用命令

Scoop的操作命令十分简单，基本结构是`scoop + 动词 + 对象`，动词就是一个操作动作，如安装、卸载，对象一般就是软件名了（支持通配符*操作），当然这需要你先打开命令行工具。比如我想安装typora，通过输入`scoop install typora`即可自动完成软件的官网进入+下载+安装等操作。

以下是一些常用的命令说明：
-   search——搜索仓库中是否有相应软件。
-   install——安装软件。
-   uninstall——卸载软件。
-   update——更新软件。可通过`scoop update *`更新所有已安装软件，或通过`scoop update`更新所有软件仓库资料及Scoop自身而不更新软件。
-   hold——锁定软件阻止其更新。
-   info——查询软件简要信息。
-   home——打开浏览器进入软件官网。

如果忘记了，可通过输入`scoop help`来查询语法，以及更多不怎么常用的操作指导。

```powershell
C:\Users\skeathy>scoop help
Usage: scoop <command> [<args>]

Some useful commands are:

alias       Manage scoop aliases
bucket      Manage Scoop buckets
cache       Show or clear the download cache
cat         Show content of specified manifest.
checkup     Check for potential problems
cleanup     Cleanup apps by removing old versions
config      Get or set configuration values
create      Create a custom app manifest
depends     List dependencies for an app
export      Exports (an importable) list of installed apps
help        Show help for a command
hold        Hold an app to disable updates
home        Opens the app homepage
info        Display information about an app
install     Install apps
list        List installed apps
prefix      Returns the path to the specified app
reset       Reset an app to resolve conflicts
search      Search available apps
status      Show status and check for new app versions
unhold      Unhold an app to enable updates
uninstall   Uninstall an app
update      Update apps, or Scoop itself
virustotal  Look for app's hash on virustotal.com
which       Locate a shim/executable (similar to 'which' on Linux)


Type 'scoop help <command>' to get help for a specific command.
```

在实际使用过程中，我们可以先通过`search`命令查询一下是否有相应软件，软件名称是否正确，然后通过`install`命令完成软件的安装。另外，有两个必备的软件需要安装——git和7zip，建议完成Scoop安装后先执行以下命令：`scoop install git 7zip`（没错，Scoop支持多个软件同时依次安装），虽然后续操作中未安装这两个软件时也会提醒用户安装就是了。

## 4 推荐软件仓库
软件仓库是 Scoop 软件管理的重要基础，通过 json 文件记录仓库中每一个软件的信息，从而实现软件的管理等便捷命令行操作，并由仓库管理员（其实开源项目都是大家用爱发电）负责软件信息的更新。

前面提到，默认安装Scoop后仅有`main`仓库，其中主要是面向程序员的工具，对于一般用户而言并不是那么实用。好在Scoop本身考虑到了这一点，添加了面向一般用户的软件仓库`extras`，其中收录大量好用的小软件，足够日常的使用。

Scoop添加软件仓库的命令是`scoop bucket add bucketname (+ url可选)`。如添加`extras`的命令是`scoop bucket add extras`，执行此命令后会在scoop文件夹中的buckets子文件夹中添加extras文件夹。

此外，Scoop官方还有一些仓库可供使用，本人没有什么需求就不在此处介绍了，仅贴一下官方的介绍：

> [main](https://github.com/ScoopInstaller/Main) - Default bucket for the most common (mostly CLI) apps  
> [extras](https://github.com/ScoopInstaller/Extras) - Apps that don't fit the main bucket's [criteria](https://github.com/ScoopInstaller/Scoop/wiki/Criteria-for-including-apps-in-the-main-bucket)  
> [games](https://github.com/Calinou/scoop-games) - Open source/freeware games and game-related tools  
> [nerd-fonts](https://github.com/matthewjberger/scoop-nerd-fonts) - Nerd Fonts  
> [nirsoft](https://github.com/kodybrown/scoop-nirsoft) - Almost all of the [250+](https://rasa.github.io/scoop-directory/by-apps#kodybrown_scoop-nirsoft) apps from [Nirsoft](https://nirsoft.net/)  
> [java](https://github.com/ScoopInstaller/Java) - A collection of Java development kits (JDKs), Java runtime engines (JREs), Java's virtual machine debugging tools and Java based runtime engines.  
> [nonportable](https://github.com/TheRandomLabs/scoop-nonportable) - Non-portable apps (may require UAC)  
> [php](https://github.com/ScoopInstaller/PHP) - Installers for most versions of PHP  
> [versions](https://github.com/ScoopInstaller/Versions) - Alternative versions of apps found in other buckets

除了官方的软件仓库，Scoop也支持用户自建仓库并共享，于是又有很多大佬提供了许多好用的软件仓库。这里强推[dorado](https://github.com/chawyehsu/dorado)仓库，里面有许多适合中国用户的软件，或者你有兴趣可以去看看仓库作者[关于Scoop更多技术方面的探讨](https://chawyehsu.com/blog/talk-about-scoop-the-package-manager-for-windows-again)。添加`dorado`仓库的命令如下：`scoop bucket add dorado https://github.com/chawyehsu/dorado`。

此外，若多个仓库间的软件名称冲突，可以通过在软件名前添加仓库名的方式避免冲突，如`scoop install dorado/appname`。

## 5 最后，分享一下自己的软件列表：

```powershell
C:\Users\skeathy>scoop list
Installed apps:

  7zip 21.07 [main]
  aria2 1.36.0-1 [main]
  captura 8.0.0 [extras]
  ccleaner 5.89.9401 [extras]
  clash-for-windows 0.19.7 [dorado]
  dark 3.11.2 [main]
  dingtalk 6.3.25.1219101 [dorado]
  dismplusplus 10.1.1002.1 [extras]
  draw.io 16.5.1 [extras]
  ffmpeg 5.0 [main]
  git 2.35.0.windows.1 [main]
  github 2.9.6 [extras]
  gridea 0.9.2 [extras]
  innounp 0.50 [main]
  lessmsi 1.10.0 [main]
  marktext 0.16.3 [extras]
  neteasemusic 2.9.6.199543 [dorado]
  nodejs 17.4.0 [main]
  obs-studio 27.1.3 [extras]
  pandoc 2.17.0.1 [main]
  picgo 2.3.0 [dorado]
  potplayer 220106 [extras]
  qbittorrent 4.4.0 [extras]
  rufus 3.17 [extras]
  steam nightly-20200720 [extras]
  sublime-text 4-4126 [extras]
  sumatrapdf 3.3.3 [extras]
  trafficmonitor 1.82 [extras]
  typora 0.11.18 *hold* [extras]
  utools 2.5.2 [dorado]
  ventoy 1.0.64 [extras]
  wechat nightly-20201231 [dorado]
  xmind8 3.7.9 [extras]
```

## 6 相关类似工具对比

最好的教程肯定是官方文档，所以有需求的读者可以直接访问[官方网站](https://github.com/ScoopInstaller/Scoop)。这篇文章也主要不是来写教程的，而是一种产品体验与思考。所以，在文章的最后，我想简单做个竞品分析，说说是什么让我最终一直在使用Scoop。

有关于同类产品，这里主要总结三个：

1.  Microsoft Store软件商店，含GUI的常规软件商店。
2.  Chocolatey，另一个第三方命令行软件管理工具。
3.  Winget，微软官方近两年的开源命令行软件管理工具。

## 7 竞品对比列表

![](https://pic1.zhimg.com/v2-82ec3c70096a185a41d3fa8bd0430160_r.jpg)

（以上表格为核心需求对比，可能有不准确的地方待修改。）

-   GUI——Windows 11的Microsoft Store颜值非常高，Chocolatey有一个不怎么好看的GUI，Scoop有第三方GUI。不过实际使用下来发现命令行一行代码的体验也不差，反而清晰明了更加高效，GUI在用户体验方面也不一定是优势。
-   开源——我可太爱开源软件了，虽然开源软件一般不如商业软件稳定，但是我可以自己提需求甚至自己去改很是舒服。
-   软件搜索、安装、更新——需求中基础的基础，不能实现的话也别用了。为了更好地使用最新版的软件，体验稳定的新功能，我可是积极的更新派，但是让我去使用不稳定的beta版本当测试就不是那么愿意了。
-   回滚版本与锁定版本——并不是那么要紧的需求，但对于某些开发人员来说为了稳定就是非常重要的需求了。
-   导出与备份——并不是那么要紧的需求，但对于某些人员来说快速安装系统是非常重要的需求。
-   数据管理与清理——主要就是软件管理逻辑方面的需求了（强迫症需求），除了Scoop其他工具的数据管理一言难尽吧，虽然Scoop许多第三方仓库中的软件也没实现好。

## 8 对比总结

综合而言，Scoop最能满足我的需求——软件生态链基本满足我的需求（大型软件我会另外安装），对于小软件的管理实在方便；理论上备份Scoop中的软件只需要复制整个根目录，然后新系统上安装好Scoop再覆盖掉初始文件即可；有一些小bug，比如安装的软件在控制面板找不着，固定到任务栏有奇怪的双开bug，不过这些实际上对于用户体验影响不大，完全可以接受；另外就算有一些严重影响使用的问题，Github上提交个issue马上就有大佬解决了。

Chocolatey各方面都与Scoop类似，在软件生态和稳定性方面更优。在开源和数据管理方面略输一筹，不能设定安装目录（高级版似乎可以），使用默认安装包逻辑安装稍微有一些劝退。

Winget是一个还没怎么完善的产品，可以肯定Winget启发于Chocolatey或Scoop。但是目前似乎bug还挺多，更新软件后依旧显示未更新的版本是我忍受不了的一个bug，所以虽然系统已经自带，不过我还是没怎么使用。Winget也使用软件默认安装包的逻辑进行安装，对于小众开源软件支持不佳，此外据说甚至会有捆绑安装的现象，属实劝退。当然，winget也有其最大的优势，可以和常规安装的方式共存，通过命令行操作扫描所有已安装软件，且对大众软件的支持最佳。期待后续版本可以做得更好。

Microsoft Store挺好用的，有很多软件我也一直在应用商店下载更新。只是软件生态太差了，好多软件不支持或者更新远比不上同一桌面端软件，期待后续软件生态可以更好，做到类似Mac App Store的程度。

*_那么有没有大佬想要构建一个基于Scoop的GUI工具呢？之前找到的那个[GUI工具](https://github.com/prezesp/scoop-viewer)似乎不是那么好用。。。毕竟不是所有人都喜欢使用命令行工具的。_