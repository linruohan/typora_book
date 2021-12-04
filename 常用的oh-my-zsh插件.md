## 常用的oh-my-zsh插件

[toc]

### 手动安装oh-my-zsh

```
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s $(which zsh)

```

首先安装[oh-my-zsh](https://link.zhihu.com/?target=http%3A//ohmyz.sh/)，打开`~/.zshrc`文件找到`plugins=( git )`

如果想要启用某个插件，装好之后直接修改

> plugins = (插件A 插件B 插件C)

### ==git==

这个是装好[oh-my-zsh](https://link.zhihu.com/?target=http%3A//ohmyz.sh/)就默认已经开启的

查看所有的git命令[alias](https://link.zhihu.com/?target=http%3A//man.linuxde.net/alias%3Foqnsle%3Docthb)

> ~/.oh-my-zsh/plugins/git/git.plugin.zsh

### ==z==

这个是oh-my-zsh默认就装好的，需要自己开启。还有一个`autojump`的插件和`z`功能差不多，`autojump`需要单独装，

如果z插件历史记录太多，并且有一些不是自己想要的，可以删除

> z -x 不要的路径

### ==sublime==

又是一个自带的插件，同样需要自己开启，针对喜欢用[sublime](https://link.zhihu.com/?target=https%3A//www.sublimetext.com/)的小伙伴

如果想要用[sublime](https://link.zhihu.com/?target=https%3A//www.sublimetext.com/)打开一个文件

> st 文件路径

### vscode

[官网](https://link.zhihu.com/?target=https%3A//github.com/Microsoft/vscode)，随着Visual Studio Code越来越火，用的人也越来越多，可以装一下这个插件

打开一个文件

> vs 文件路径

```
git clone https://github.com/valentinocossar/vscode.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vscode
```

### zsh-autosuggestions

[官网](https://link.zhihu.com/?target=https%3A//github.com/zsh-users/zsh-autosuggestions)，非常好用的一个插件，会记录你之前输入过的所有命令，并且自动匹配你可能想要输入命令，然后按→补全

```
git clone https://github.com/zsh-users/zsh-autosuggestions  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://gitee.com/yuhldr/zsh-autosuggestions.git  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### zsh-syntax-highlighting

[官网](https://link.zhihu.com/?target=https%3A//github.com/zsh-users/zsh-syntax-highlighting)，命令太多，有时候记不住，等输入完了才知道命令输错了，这个插件直接在输入过程中就会提示你，当前命令是否正确，错误红色，正确绿色

```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://gitee.com/jklash1996/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### ==sudo==

偶尔输入某个命令，提示没有权限，需要加sudo，这个时候按两下ESC，就会在命令行头部加上sudo

### powerlevel10k主题

```
git clone --depth=1 https://gitee.com/jonykchen/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

### zinit加速  zinit配置

[zinit配置 ](https://www.cnblogs.com/hongdada/p/14048612.html#新版的zinit配置)

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

```
github 个人身份令牌Personal access tokens

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
```

```
 73 plugins=(                                                                                                                                                                       74     git                                                                                                                                                                         75     sudo                                                                                                                                                                        76     zsh-syntax-highlighting                                                                                                                                                     77     zsh-autosuggestions                                                                                                                                                         78 )
```

### zsh命令行界面/zsh终端界面粘贴卡顿的问题

```bash
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

```

