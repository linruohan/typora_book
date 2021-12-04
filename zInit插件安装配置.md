# [zInit插件安装配置](https://www.cnblogs.com/hongdada/p/14048612.html)

[toc]

## 安装[#](https://www.cnblogs.com/hongdada/p/14048612.html#安装)

### 自动安装[#](https://www.cnblogs.com/hongdada/p/14048612.html#自动安装)

官方推荐的安装方式，一键完成。不过让我很没有安全感，我倾向于手动安装。

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)" 
```

### 手动安装[#](https://www.cnblogs.com/hongdada/p/14048612.html#手动安装)

首先 clone repo 到随便哪个位置

```
git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
```

然后在你的 ~/.zshrc 顶端添加如下语句

```
source ~/.zinit/bin/zinit.zsh
```

安装完成，非常简单。

## 配置[#](https://www.cnblogs.com/hongdada/p/14048612.html#配置)

### 从 GitHub repo 加载插件[#](https://www.cnblogs.com/hongdada/p/14048612.html#从-github-repo-加载插件)

最为常见的加载方式，和其他插件管理器的用法是一致的，直接 `zinit light {用户名}/{repo名}` 即可。

```bash
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
# PS. zinit 和 fast-syntax-highlighting 是同一个作者，这位作者对速度的追求确实让人钦佩
```

### 加载 oh my zsh 插件[#](https://www.cnblogs.com/hongdada/p/14048612.html#加载-oh-my-zsh-插件)

OMZ 别的不说，插件是真的多，如果不能加载 OMZ 插件那就太遗憾了。因此像 antigen 这样的插件管理器甚至直接提供了整合 OMZ 框架的能力。

zinit 并没有直接整合 OMZ，不过提供了更为强大的 `snippet` 命令来加载单独的插件。

### 单文件插件[#](https://www.cnblogs.com/hongdada/p/14048612.html#单文件插件)

`snippet` 命令可以接 URI 来直接加载单个文件。比如加载 OMZ 的 sudo 插件：

```bash
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
```

后面那部分看起来好像不像一个 URI？因为 OMZ 实在太常用了，因此可以用 `OMZ::` 来代替它的 repo 地址（对于 Prezto 则是 `PZT::`），上面的写法其实等价于：

```bash
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/sudo/sudo.plugin.zsh
```

### 多文件插件[#](https://www.cnblogs.com/hongdada/p/14048612.html#多文件插件)

有时候，插件目录里不止一个文件（比如包含插件+补全），这时就需要使用 `svn` 修饰词来加载了：

```bash
zinit ice svn
zinit snippet OMZ::plugins/extract
```

这里不详细解释什么叫修饰词了，你可以理解成一种实现可选参数的手段，修饰词只对接下来的**一条**命令起效。 格式是 `zinit ice {修饰词1} {修饰词2} ...`

`svn` 修饰词，表示下一行的 URI 需要使用 SVN 协议加载。此时 zinit 会使用 SVN 协议下载整个目录，自动识别并加载需要的文件。

### 加载补全[#](https://www.cnblogs.com/hongdada/p/14048612.html#加载补全)

补全文件，有两种加载方式：1. 使用 `svn` 修饰词直接加载目录，zinit 会自动识别并加载补全。 2. 直接加载补全文件，此时需要使用 `as="completion"` 这个修饰词，它会让 zinit 将下一行命令加载的文件作为补全安装到指定目录：

```bash
zinit ice as="completion"
zinit snippet OMZ::plugins/cargo/_cargo
```

### 加载 OMZ 插件时需要注意的点[#](https://www.cnblogs.com/hongdada/p/14048612.html#加载-omz-插件时需要注意的点)

OMZ 的部分插件/主题会依赖 OMZ 本身提供的功能。比如 git 插件，如果想要正常使用的话，需要加载 OMZ 的 git 库。

```bash
# 加载 OMZ 的 git 库
zinit snippet OMZ::lib/git.zsh
# 加载 OMZ 的 git 插件
zinit snippet OMZ::plugins/git/git.plugin.zsh
```

也就是说，虽然 zinit 并没有提供直接加载 OMZ 框架的能力，但是你可以使用 snippet 功能选择性加载框架的部分功能。这比其他插件管理器的做法更为灵活。

比如我的配置里就直接加载了 OMZ 的部分库，**如果你也是 OMZ 的用户，建议同样加载这些库，能保证体验一致。**（比如键位绑定）

```bash
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
```

### Turbo Mode[#](https://www.cnblogs.com/hongdada/p/14048612.html#turbo-mode)

终于说到 zinit 的最强 feature 了。没有 Turbo Mode 的 zinit 不过是略为优秀的插件管理器。然而有了 Turbo Mode，zinit 可以说是顶级 zsh 插件管理器，没有之一！

这个功能非常强大，基本用法却很简单。举例来说，下面的代码，就实现了 OMZ git 插件的延迟加载。

```bash
zinit ice lucid wait='0'
zinit snippet OMZ::plugins/git/git.plugin.zsh
```

延迟加载用到了两个修饰词：`lucid`，用于静默加载。`wait={秒}`，在 prompt 加载完毕后的若干秒后再加载。上面的例子就是让 prompt 启动后立刻加载 git 插件。

如果坚持追求极致速度的话，可以参考：[zplugin_tutorial/#turbo-mode-加载复杂的命令提示符](https://link.zhihu.com/?target=https%3A//www.aloxaf.com/2019/11/zplugin_tutorial/%23turbo-mode-加载复杂的命令提示符)。

## 安装一些下面用到的插件[#](https://www.cnblogs.com/hongdada/p/14048612.html#安装一些下面用到的插件)

### 安装lua[#](https://www.cnblogs.com/hongdada/p/14048612.html#安装lua)

```
yum -y install libtermcap-devel gc ncurses-devel libevent-devel readline-devel gc lua.x86_64
```

### 安装unzip[#](https://www.cnblogs.com/hongdada/p/14048612.html#安装unzip)

```
yum install -y unzip.x86_64
```

### 安装svn[#](https://www.cnblogs.com/hongdada/p/14048612.html#安装svn)

```
yum install -y subversion
```

### 安装exa[#](https://www.cnblogs.com/hongdada/p/14048612.html#安装exa)

安装make

```
dnf group install "Development Tools"
dnf -y install glibc.x86_64
yum install -y gcc pcre pcre-devel zlib zlib-devel openssl openssl-devel make.x86_64 cmake.x86_64 autoconf.noarch
```

安装exa

```
# 下载对应二进制版本并解压安装到指定目录
cd /usr/local/src
wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
unzip exa-linux-x86_64-0.9.0.zip
mv exa-linux-x86_64 /usr/local/bin/exa

# 下载并安装对应的 MAN 手册
wget https://raw.githubusercontent.com/ogham/exa/master/contrib/man/exa.1
mv exa.1 /usr/share/man/man1
```

## zinit常用命令:[#](https://www.cnblogs.com/hongdada/p/14048612.html#zinit常用命令)

```
# 加载插件
$ zinit load {plg-spec}

# 加载插件，不打印加载信息
$ zinit light [-b] {plg-spec}

# 加载单文件，-f 表示不使用缓存，即强制重新下载
$ zinit snippet [-f] {url}

# 卸载插件，-q 表示 quiet
$ zinit unload [-q] {plg-spec}

# 显示插件加载时间，以插件加载顺序排序。-s 表示以秒进行显示（默认毫秒），-m 表示显示插件加载时刻
$ zinit times [-s] [-m]

# 显示 Zinit 状态
$ zinit zstatus

# 显示插件加载状态，--all 表示显示所有插件
$ zinit report {plg-spec} | --all

# 显示已加载的插件（使用关键字进行过滤）
$ zinit loaded [keyword],list [keyword]

# 显示每个插件的设置的按键绑定
$ zinit bindkeys

# 编译插件
$ zinit compile {plg-spec} | --all

# 移除已编译的插件
$ zinit uncompile {plg-spec} | --all

# 显示已编译的插件
$ zinit compiled

# 更新 Zinit
$ zinit self-update

# 更新插件/脚本，--all 表示更新所有插件/脚本，-q 表示静默更新，-r | --reset 更新前执行 git reset --hard / svn revert
$ zinit update [-q] [-r] {plg-spec} | URL | --all

# 为下一条 zinit 命令添加 ice 描述符
$ zinit ice <ice specification>

# 磁盘删除插件/脚本，--all 表示清除，--clean 表示删除未加载的插件/脚本
$ zinit delete {plg-spec} | URL | --clean | --all

# 进入插件目录
$ zinit cd {plg-spec}
```

## zinit 管理[#](https://www.cnblogs.com/hongdada/p/14048612.html#zinit-管理)

- zinit 升级

```
zinit self-update
```

- 升级其他插件

```
zinit update
```

- 清理没有加载的插件

```
zinit delete --clean
```

## 我的zsh配置[#](https://www.cnblogs.com/hongdada/p/14048612.html#我的zsh配置)

```
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source your own zsh file if exists
[ -f ~/.config/.zsh.sh ] && source ~/.config/.zsh.sh


# 下面都是zinit配置
source ~/.zinit/bin/zinit.zsh

# 加载 powerlevel10k 主题
zinit ice depth=1; zinit light romkatv/powerlevel10k

# 快速目录跳转
zinit ice lucid wait='1'
zinit light skywind3000/z.lua

zinit light Aloxaf/fzf-tab
zinit light paulirish/git-open
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
# zinit light zsh-users/zsh-syntax-highlighting

# 加载 OMZ 框架及部分插件
# zinit snippet OMZL::git.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh

zinit snippet OMZP::cp
# zinit snippet OMZP::brew
# zinit snippet OMZP::extract
# zinit snippet OMZP::vi-mode
# zinit snippet OMZP::sublime
zinit snippet OMZP::gitignore
zinit snippet OMZP::colored-man-pages

# zinit snippet OMZ::plugins/git/git.plugin.zsh
# zinit snippet OMZ::plugins/mvn/mvn.plugin.zsh
# zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
# zinit snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh


zinit ice svn
zinit snippet OMZ::plugins/extract

#zinit wait="1" lucid as="completion" for \
#  OMZ::plugins/docker/_docker \
#  OMZ::plugins/docker-compose/_docker-compose \
#  OMZ::plugins/gradle/_gradle \
#  OMZ::plugins/vagrant/_vagrant

# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat


# ---- (可选)加载了一堆二进制程序 ----
zinit light zinit-zsh/z-a-bin-gem-node

zinit as="null" wait="1" lucid from="gh-r" for \
    mv="exa* -> exa" sbin       ogham/exa \
    mv="*/rg -> rg"  sbin		BurntSushi/ripgrep \
    mv="fd* -> fd"   sbin="fd/fd"  @sharkdp/fd \
    sbin="fzf"       junegunn/fzf-bin

# 加载它们的补全等
zinit ice mv="*.zsh -> _fzf" as="completion"
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/completion.zsh'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'
zinit ice as="completion"
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/fd/_fd'
zinit ice mv="*.zsh -> _exa" as="completion"
zinit snippet 'https://github.com/ogham/exa/tree/master/completions/completions.zsh'
# ---- 加载完了 ----


# source your own shrc file if exists
[ -f ~/.config/.env.sh ] && source ~/.config/.env.sh

# source your own alias file if exists
[ -f ~/.config/.alias.sh ] && source ~/.config/.alias.sh

# source your own function file if exists
[ -f ~/.config/.fun.sh ] && source ~/.config/.fun.sh

# source your proxy shrc file if exists
[ -f ~/.config/.proxy.sh ] && source ~/.config/.proxy.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# 补全快捷键重设
bindkey ',' autosuggest-accept
```

## 新版的zinit配置[#](https://www.cnblogs.com/hongdada/p/14048612.html#新版的zinit配置)

```
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source your own zsh file if exists
[ -f ~/.config/.zsh.sh ] && source ~/.config/.zsh.sh

# 下面都是zinit配置
source ~/.zinit/bin/zinit.zsh

# 加载 powerlevel10k 主题
zinit ice depth=1; zinit light romkatv/powerlevel10k

# zinit light zinit-zsh/z-a-bin-gem-node
zinit light zinit-zsh/z-a-meta-plugins

# Installs total of 22 plugins
zinit for annexes zsh-users+fast console-tools fuzzy ext-git

# 快速目录跳转
zinit ice lucid wait='1'
zinit light skywind3000/z.lua

zinit light Aloxaf/fzf-tab
 
# source your own shrc file if exists
[ -f ~/.config/.env.sh ] && source ~/.config/.env.sh

# source your own alias file if exists
[ -f ~/.config/.alias.sh ] && source ~/.config/.alias.sh

# source your own function file if exists
[ -f ~/.config/.fun.sh ] && source ~/.config/.fun.sh

# source your proxy shrc file if exists
[ -f ~/.config/.proxy.sh ] && source ~/.config/.proxy.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# 补全快捷键重设
bindkey ',' autosuggest-accept
```

在这里使用了第三方插件`zinit-zsh/z-a-meta-plugins`

在使用过程中使用问题（都是WSL2.0中的，Mac未发现问题）：

### 问题一：[#](https://www.cnblogs.com/hongdada/p/14048612.html#问题一)

```
 source ~/.zshrc
zsh compinit: insecure files, run compaudit for list.
Ignore insecure files and continue [y] or abort compinit [n]? ncompinit: initialization aborted
/root/.config/.zsh.sh:143: command not found: compdef

or
_complete:96: bad math expression: operand expected at end of string
```

解决：

```
chown -R root:root ~/.zinit/plugins
```

### 问题二：[#](https://www.cnblogs.com/hongdada/p/14048612.html#问题二)

```
zsh-syntax-highlighting: unhandled ZLE widget 'autosuggest-accept'
```

解决：

```
grep -rn -3 "unhandled ZLE widget" ~/.zinit
/root/.zinit/plugins/zdharma---fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh-281-           zle -N -- $cur_widget _zsh_highlight_widget_$cur_widget
/root/.zinit/plugins/zdharma---fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh-282-         else
/root/.zinit/plugins/zdharma---fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh-283-      # Default: unhandled case.
/root/.zinit/plugins/zdharma---fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh:284:           print -r -- >&2 "zsh-syntax-highlighting: unhandled ZLE widget ${(qq)cur_widget}"
/root/.zinit/plugins/zdharma---fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh-285-         fi
/root/.zinit/plugins/zdharma---fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh-286-    esac
/root/.zinit/plugins/zdharma---fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh-287-  done
Binary file /root/.zinit/plugins/zdharma---fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh.zwc matches
```

注释掉284行就可以。

## 参考:[#](https://www.cnblogs.com/hongdada/p/14048612.html#参考)

[zinit](https://github.com/zdharma/zinit)

[fzf-tab](https://github.com/Aloxaf/fzf-tab)

[我就感觉到快 —— zsh 和 oh my zsh 冷启动速度优化](https://blog.skk.moe/post/make-oh-my-zsh-fly/)

[加速你的 zsh —— 最强 zsh 插件管理器 zplugin/zinit 教程](https://www.aloxaf.com/2019/11/zplugin_tutorial/)

[zsh 启动速度慢的终极解决方案](https://zhuanlan.zhihu.com/p/98450570)

[Quit using nvm：快删掉这个占据 Zsh 启动时间一半的怪物！](https://blog.spencerwoo.com/2020/07/remove-nvm-to-speed-up-zsh/)

[使用 zinit 管理 zsh 插件](https://einverne.github.io/post/2020/10/use-zinit-to-manage-zsh-plugins.html)

 分类: [Other](https://www.cnblogs.com/hongdada/category/420089.html)

 0

 0





登录后才能查看或发表评论，立即 [登录](javascript:void(0);) 或者 [逛逛](https://www.cnblogs.com/) 博客园首页

**编辑推荐：**
· [巧用渐变实现高级感拉满的背景光动画](https://www.cnblogs.com/coco1s/p/15596920.html)
· [工作三年的一些感悟](https://www.cnblogs.com/originator/p/15588705.html)
· [.NET Core 中的鉴权授权正确方式(.NET5)](https://www.cnblogs.com/wei325/p/15575141.html)
· [高并发异步解耦利器：RocketMQ 究竟强在哪里？](https://www.cnblogs.com/arthinking/p/15590677.html)
· [理解ASP.NET Core - 错误处理(Handle Errors)](https://www.cnblogs.com/xiaoxiaotank/p/15586706.html)

**最新新闻**：
· [天美游戏程序员被曝年薪400万登上热搜，游戏圈如何看？（2021-11-27 15:31）](https://news.cnblogs.com/n/707861/)
· [改用VSCode开发ASP.NET Core心得（2021-11-27 15:22）](https://news.cnblogs.com/n/707860/)
· [有赞创始人兼CEO白鸦：存量市场下 短视频、直播成新流量聚集地（2021-11-27 15:12）](https://news.cnblogs.com/n/707859/)
· [硅谷教父Paul Graham谈投资：我们一开始其实并不喜欢Airbnb（2021-11-27 15:05）](https://news.cnblogs.com/n/707858/)
· [网易云音乐上市在即：募资已超 21.7 亿港元 有望超购逾 15 倍（2021-11-27 13:17）](https://news.cnblogs.com/n/707857/)
» [更多新闻...](https://news.cnblogs.com/)

**历史上的今天：**
2013-11-27 [jQuery ajax 添加头部参数跨域](https://www.cnblogs.com/hongdada/p/3445157.html)

Copyright © 2021 hongdada
Powered by .NET 6 on Kubernetes & Theme [Silence v3.0.0](https://github.com/esofar/cnblogs-theme-silence)