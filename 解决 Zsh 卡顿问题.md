# 解决 Zsh 卡顿问题

2020-02-09 22:42:16 +0800 

[ tool ](https://networm.me/categories/tool/)

 约 487 字 预计阅读 1 分钟

## 文章目录

[介绍](https://networm.me/2020/02/09/zsh-slow/#介绍)[环境](https://networm.me/2020/02/09/zsh-slow/#环境)[粘贴内容缓慢](https://networm.me/2020/02/09/zsh-slow/#粘贴内容缓慢)[启动缓慢](https://networm.me/2020/02/09/zsh-slow/#启动缓慢)

## 介绍

> Z shell（Zsh）是一款可用作交互式登录的shell及脚本编写的命令解释器。Zsh对Bourne shell做出了大量改进，同时加入了Bash、ksh及tcsh的某些功能。\
>
> Z shell - 维基百科，自由的百科全书 https://zh.wikipedia.org/wiki/Z_shell

Zsh 兼容 Bash 语法，因此网上搜索到的 Bash 脚本可以直接使用。

## 环境

- macOS 10.14.6
- zsh 5.7.1

## 粘贴内容缓慢

问题表现为由粘贴的内容像是一个字符一个字符的手动快速敲入的，但是依然不如内容一下子上屏的速度快。其次还会出现粘贴的内容会覆盖原有命令行里的内容，在动画完成后才会调整为同时显示。

这里也包括将 Finder 中的目录拖动到 Zsh 中，目录路径出现的效果与粘贴内容一致。

将以下内容粘贴到 `~/.zshrc` 配置文件中重启 Zsh 即可：

| ` 1 2 3 4 5 6 7 8 9 10 11 12 ` | `# This speeds up pasting w/ autosuggest # https://github.com/zsh-users/zsh-autosuggestions/issues/238 pasteinit() {  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`? } pastefinish() {  zle -N self-insert $OLD_SELF_INSERT } zstyle :bracketed-paste-magic paste-init pasteinit zstyle :bracketed-paste-magic paste-finish pastefinish ` |
| ------------------------------ | ------------------------------------------------------------ |
|                                |                                                              |

Issue 中还给出了粘贴缓慢效果的 Gif 图。

- [Maybe fix for slow pastes · Issue #238 · zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/issues/238#issuecomment-389324292)

## 启动缓慢

具体表现为在 iTerm2 中新建标签，Zsh 需要大概 5 秒才会显示命令提示符，这实在是太慢了。

下面这篇文章中提到插件 `command-not-found` 是比较耗时的，实测禁用后耗时由 5 秒降为 1 秒。

这篇文章中还实践了测量-修正的方法，仔细地查找速度缓慢的原因，值得学习与借鉴。

- [Speeding up zsh and Oh-My-Zsh - JonLuca’s Blog](https://blog.jonlu.ca/posts/speeding-up-zsh)