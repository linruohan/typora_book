# WSL+cmder+oh-my-zsh美化win10命令工具（terminal）

## 安装WSL

win10系统需要更新到1067及其以后的版本，并且是64位的系统才可以安装。

win10打开程序和功能

![image-20191214001025857](F:\Typora_book\typora_pic\image-20191214001025857.png)

勾选适用于系统的Linux的子系统，然后重启系统。

![image-20191214001039902](F:\Typora_book\typora_pic\image-20191214001039902.png)

重启以后，此时我们已经可以使用Linux系统，但是我们还差一个系统，所以需要安装一个

我们在win10应用商店里面搜索linux，安装Ubuntu。

![image-20191214001117458](F:\Typora_book\typora_pic\image-20191214001117458.png)

安装完成后在开始菜单里面找到程序，启动。

刚开始的时候需要等一下，在配置环境。完成后需要设置用户名以及密码。

### WSL初步配色调料包

- 字体：consolas
- 字体大小：24
- 屏幕文字颜色：220 220 220
- 屏幕背景颜色：50 50 50
- 不透明度：95%

## WSL采用Solarized配色调料包

背景rgb（0，43，53），文字rgb(147,161,161)

## WSL的主题配色临时工具：ColorTool

1. 微软官方出品，github开源。看样子应该是Windows未来的新终端里会带的工具。可能未来的新终端里就会集成主题功能了。这个工具貌似是可以使用那些iTerm2上的漂亮主题，挺不错的。
2. github源码：[https://github.com/Microsoft/Terminal/tree/master/src/tools/ColorTool](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2FMicrosoft%2FTerminal%2Ftree%2Fmaster%2Fsrc%2Ftools%2FColorTool)
3. github下载：[https://github.com/microsoft/terminal/releases/tag/1904.29002](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fmicrosoft%2Fterminal%2Freleases%2Ftag%2F1904.29002)
4. 下载后解压缩得到一个ColorTool.exe以及一个schemes文件夹。schemes文件夹内包含很多主题文件。比如我==想要，然后使用WSL终端在目录里执行（PowerShell也行）：

```shell
# 配置solarized_dark主题
./ColorTool.exe -d schemes/solarized_dark.itermcolors
```

终端中显示：==Wrote selected scheme to the defaults.== 表示已经成功。重启WSL即可。

# 如何离线安装 Oh My Zsh

 zsh 的 yum 包管理族的离线安装包：
链接：https://pan.baidu.com/s/1AwgEImRRAyhOb6CHNRMTWg 提取码：c7co

```shell
# 安装 yum 离线下载插件
$ sudo yum install -y yum-plugin-downloadonly

# 下载 zsh 包到 /home/wangying/third-party/zsh 目录下
$ sudo yum install -y --downloadonly --downloaddir=/home/wangying/third-party/zsh zsh

离线安装 zsh
$ sudo rpm -ivh zsh-5.0.2-31.el7.x86_64.rpm
```

# ==离线安装 Oh My Zsh==

## 1. 获取 Oh My Zsh 仓库代码

Oh My Zsh 的仓库代码托管在 GitHub 上，地址为：[GitHub: oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

码云上的该项目的镜像仓库：[码云: oh-my-zsh](https://gitee.com/mirrors/oh-my-zsh)

百度网盘上：[![YPSuperKey Unlocked](data:image/png;base64,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)https://pan.baidu.com/s/1Vrkzj-N-DeW0P4SmWISKHg](https://pan.baidu.com/s/1Vrkzj-N-DeW0P4SmWISKHg) 提取码：16yc

```shell
$ mv oh-my-zsh ~/.oh-my-zsh
```

## 3. 

接下来就是重头戏，我们要对 Oh My Zsh 的安装脚本进行魔改，将其联网下载仓库的代码全部删掉。这里，我建议将 install.sh 备份下再进行修改：

```shell
修改 $HOME/.oh-my-zsh/tools 下的 install.sh 安装脚本
cp install.sh install.sh.back
vi install.sh
**a. 删除 setup_ohmyzsh 函数**
**b. 搜索 setup_ohmyzsh 字符串，将调用的地方删除**
```

**c. 搜索字符串 `You already have Oh My Zsh installed.`，并将附近 if 语句全部删除**
![image-20191214003342730](F:\Typora_book\typora_pic\image-20191214003342730.png)
如果有迷惑的地方，这里我把我修改前的 install.sh.back 和修改后的 install.sh 文件上传到了百度网盘，供读者查看修改内容：
链接：[![YPSuperKey Unlocked](data:image/png;base64,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)https://pan.baidu.com/s/1KIDsK19xZREr3HkhDO1w_w](https://pan.baidu.com/s/1KIDsK19xZREr3HkhDO1w_w) 提取码：7v9j

## 4. 执行安装脚本 install.sh

```shell
$ sh install.sh
```

# ==在线安装 Oh My Zsh==

## 在线安装zsh终端

```shell
# 安装zsh终端
sudo apt-get install zsh

#切换zsh
chsh -s `which zsh`
```
## 在线安装oh-my-zsh

```
 # 通过在线脚本安装
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

```shell
## zsh的配置
vi ~/.zshrc
 # 配置主题agnoster
ZSH_THEME="agnoster"
# 隐藏终端前缀的用户名和主机名
DEFAULT_USER="xiaohan"

```
## 终端前缀字体乱码--------------安装字体 FiraCode

[https://raw.githubusercontent.com/tonsky/FiraCode/master/distr/ttf/FiraCode-Retina.ttf](https://links.jianshu.com/go?to=https%3A%2F%2Fraw.githubusercontent.com%2Ftonsky%2FFiraCode%2Fmaster%2Fdistr%2Fttf%2FFiraCode-Retina.ttf)

下载后打开，点击安装。再进入终端设置（WSL的话，点击窗口左上角，然后属性），修改字体为FiraCode Retina。

## 在custom目录中安装插件和修改主题

~/.oh-my-zsh中有个custom目录，其中可以存放自定义插件和主题。为了不影响原有的安装目录，我决定把新增的插件放到这里面。这里面有themes和plugins目录，看名字应该知道，其实是跟根目录下的对应文件夹功能是一致的。所以应该知道怎么用了吧。

### （WSL）修改agnoster主题

由于默认的agnoster主题，当前目录的==高亮蓝配色==有点蛋疼，故进行修改：
```bash
# Dir: current working directory
prompt_dir() {
  prompt_segment blue $CURRENT_FG '%~'
}
```
将其中blue修改为075，

### 配置主题后光标看不到了？

```bash
显示光标闪烁：
echo -e "\033[?25h"
隐藏光标闪烁：
echo -e "\033[?25l"
```

### 安装插件

```ruby
 安装语法高亮插件
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
自动提示插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Activate the plugin in ~/.zshrc:

```undefined
plugins=(z git zsh-autosuggestions zsh-syntax-highlighting)
```

![image-20191214004952362](F:\Typora_book\typora_pic\image-20191214004952362.png)



## 安装cmder

[cmder](https://cmder.net/)有两个版本，Mini版与完整版（包含了git以及一些其他的命令）。推荐安装完整版。 安装完成后打开，我们需要进行配置一下

![image-20191214001141680](F:\Typora_book\typora_pic\image-20191214001141680.png)

如上图，在tasks中添加一个task

![image-20191214012139705](F:\Typora_book\typora_pic\image-20191214012139705.png) 

- 名字为Ubuntu，这个名字随便你
- 下面的大框里面`set "PATH=%ConEmuBaseDirShort%\wsl;%PATH%" & %ConEmuBaseDirShort%\conemu-cyg-64.exe --wsl --distro-guid={9df562ee-848c-4af4-ab4e-aedad54ceba9} -cur_console:pm:/mnt`。这里面的`9df562ee-848c-4af4-ab4e-aedad54ceba9`指的是Ubuntu的唯一标识符，如果重装了子系统，那么这个标识符实惠变得。可以在在注册表(regedit)中查找 `计算机\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss`。`win+R搜索regedit`。![image-20191214012711139](F:\Typora_book\typora_pic\image-20191214012711139.png)

![img](F:\Typora_book\typora_pic\7d7yz9cwnl.png)

当然，你也可以设置为其他你认为好看的字体。

在设置界面的Starup里的Command line输入

![image-20191214010420630](F:\Typora_book\typora_pic\image-20191214010420630.png)

```shell
%windir%\system32\bash.exe ~ -cur_console:p:n


4.中文和命令ll支持

Cmder 是不支持中文和 ll 命令的，这需要你在 Startup 下的 Environment 中设置一下。将 
set LANG=zh_CN.UTF-8 
alias ll=ls -al --show-control-chars --color $* 
```

![image-20191214010816978](F:\Typora_book\typora_pic\image-20191214010816978.png)

## 在VSCode上使用WSL

由于博主是做前端开发的，用的是VSCode所以这里说一下，怎么在VSCode上面使用。

在VSCode的设置文件中添加这一句

```javascript
"terminal.integrated.shell.windows": "C:\\\\Windows\\\\System32\\\\wsl.exe",
```

如果需要使用node，npm等工具，WSL里面是不能够直接使用windows自带的这些环境变量的，我们需要在WSL中安装，具体的安装方法可以google–`Ubuntu安装软件`

## 说在结尾

之前说的字体`fonts-powerline`，`Hack Nerd Font Mono`这个字体，其实还是挺好看的，大家可以使用，包括在PC上面也可以。这个字体可以使用Git下载`https://github.com/powerline/fonts`，不过这个实在是有点慢，这里我已经下载下来放在了[![YPSuperKey Checked](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAN1wAADdcBQiibeAAAABx0RVh0U29mdHdhcmUAQWRvYmUgRmlyZXdvcmtzIENTNui8sowAAAePSURBVGiBxZpbbBTXGcd/58zser3rtbkGQVtCIiWgioS0ywY19CJFWVrKpYQQtUoUUgmbpk1BUau2D+1WlbZ9aC6URiZNSG3SSHloUzVKEEntNaYllzaUpRG5QEEyGDfmYhsw9t5n5vRhZl3bu+udtY3zf5s5t993zjcz3/nOCKUU06FQPCqBLwP3AHcBtwILnOKLwCngHaADOJyIxKzpGFdMxYBQPOoH7ga+CqwClgANgAcQ46orIA8MAmeBd4E2oDMRiaUmyzApA0Lx6I3Ao8CDwKLJDu6oF3gJ2JOIxLqrbVyVAaF4tB74KfB9wF/tYBWUApqBXyUisWtuG7k2IBSPbgCexnaT66mzwM5EJLbfTWXpplIoHv018BrXHx5njNecMStqwhUIxaMe4I/AvdOCVr1eAb6ZiMTy5SqUNSAUj+rAG9ivxU9SHcDaRCRmlCqcyIVe5pOHB5vh5XKFJQ1w/G/T9SKahDaVeyaKXCgUj34N23VmVKaykAiEGP/9G6O1iUjsr6NvjDEgFI/WAf9h6h8nVxJAXpmkjBwNnlqylkHOMqjTfeWa9AJLE5HYcOGGPq7Cz5kxeEHazOHTPPzytvtZPfcWBvMp9nb9jf29x5jtDZRqtgiIAj8Z6aewAqF4dBHQBdRcf3hImTl80sPe8DZWzr5pTHn0gz/z4tm3mFcTLNU8C9yciMR6YexD/BgzAi9seM3L78ONRfAAseVb2LrkiwzmU0URocP42Eh/SilC8agPOAfMv37oBfgsPs1Ly8pGPjf7xgnrP3zkOf51pYta6R1f1AcsTkRimcIK3M0MwddqXlrDleEB7plzB33JNJosWof52MwjLrTOLYipLAxlUk0QPhq+JdzIHbMqwwOkjDz9fcMMpfPoxUasA5BOyLDKTYfX8mk8UqNe95MysuQsA1HKS8fBJ80sfs1La7jJNXzeMnn+5GGk5qW7P8WVZJERq0LxqK4Dq6kQZSoUV3MpHl7yJbbd9BWCHh9HLnfxiw//wkB2mDrdhyqxJoWZD2heWsJNrJi12BW8YVls7niWxKUu/L46lKXoGUhiKj/z6rwYlsJhXq0Da4D6ieAvZ5PsvGUNP1i6duR+ZMFyFvvn8u0je7mSSxYZMQKv19CysonbZ33GFXzeMrm341kOdCXw1wZBKYQAhODjyylMy+KGeh+WpeoVrJHYG/DxH7QRXctn2DEOvqClwYXsu3M7s70BkkZ2xJ0KbhPQa2gNu4fPWSab4r/jwBkHfpQEoEnBhasZzl9NI6XQpRB3SWApxRtwAIaNDJEFy/lhCfiClgUXsu/OJhq8tSSNDFLY8EHdx75wE7c1VAP/DK+fOYbfV/IDBo4Rl65l6b2SFgq1VALzylXOWybrFq6oOPiy4CJaw03Ue/xcyg4R1H20hptYXiX8G2f+XTTzpaRLwcBwltMXhhZU3FIOGRlXEJ+t/xQt4UaWBRfSEm5kecOnXbXLmgYb2wvwZR/FIkkhMEwlxefbf9YLLCxVKWPmWRKYx5++sIOA7i7KUJTxxxLKWgbfaH+Gtu73JnSbcpJCXJbY4XPJ71Kt5uXU0AW2J1pJmTlXnbqFz5h5Nk4BHpv5hMRO95XcbyoUDR4//+g/zfajLaRdGlFJGdNgQ/se2rvfw+9z7zbjZAjBOxJoB8omkhSKOd463u4/zfajrWTMsgkCV8qYeTa0N9Nx7rgz85NObQ4JQZsE3sZOJpWVQjHXW8db/afYnpi8EWkzz/q2PXR0H5/KzAMg4FyD3/umdNIV71ZqUDDizb6TPJLYR7ZKI9JGnvVtzRzsOe68baaYFRfin+c2P54rvEYPuGljGxHk730n+e6xF8hZJR+dIqXNPOvbm+nsed+Z+amn9KXgdfh/ON2JvUmoqMJKHLp0gkcS+yoakTUN1rU109nzwbTBCxjwaPIgOAYkIrEM8ILbDmwjAhy69BHfm2AlDGVx38HnONTz/lQf2DESghcHHtiVgrF74t3YG2ZXUsBcbx0HL37Eo8f+QN4yx5QbymJz3IkqpxMecromdxWuRwxwdvlPV9OZbUSAgxc/5DuJVk4Mnidl5Dhx9QLr2prZf+aoq9imGglB85UHf/PfkevpSGzZ4XMGYelkhjXOpwbJGFn8nlqma+btcbhQW6Pf2vetp4YK98YEc07Ga1u1HSsUfq2GWq9E1mYBhU/3MZ3wAFKKxtHwUCK56+QeH5/UCEowx+/j5huCSAHWNJ2AAkghnrr20O6i1/1E5wOvMMkMtSYFyaxBd18SUynkxAnbipKC/UNbf7uxZNkE7e7HPlyoWqalCNToLJkfQBNiSishhegM+r33lS0vV+CEGF/HPuapWqal8E/RCCnEq3MC3rW9W56o/ohptJzDhR9XTcDk3MlOQognh7bu/lHFujNxzFqNEUJwThNi5+BDu19107erY1YA59x2BfYbqqpfAwrPxI0TuJMQpKUQTwZ9ntvdwsMM/2qgSUEqa9Ddn8K07ISVEJwXQrzk1eSegQd2na2WZcZ/9tCkGBxK58/2DKSOaJpsq/PpnR9veSI5WYYpGTBabn+3UUp1HFuz4zAsmJbfbf4HePY0woFjuIwAAAAASUVORK5CYII=)这里](https://www.lanzous.com/i3ldpcj)。