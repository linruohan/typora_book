# 给 Mintty / Wsltty 添加背景图片

[toc]



## 给你的终端添加一张背景，能增加你的工作沉浸感，让你在命令行下更加专注，

使用 Windows Terminal 的话，[官方文档](https://link.zhihu.com/?target=https%3A//docs.microsoft.com/zh-cn/windows/terminal/customize-settings/profile-settings%23background-image-settings) 已经详细解释了如何设置背景图片和半透明。

而要在 Wsltty 以及其背后的 Mintty 中设置背景图片，只需要向终端发送一串控制码：

```text
ESC]11;_image.pngESC\ 
```

其中 ESC 代表 ASCII 的 27，即 ESC 键的控制码，该前缀一般用来做终端控制，测试一下：

```bash
 printf "\e]11;_/mnt/c/Users/Linwei/Pictures/MacOS/Sierra.jpg\e\\"
```
使用 `printf` 中的 `\e` 代表 ESC，输出控制码，带上图片路径，注意路径前有个下划线：
设置成功，但是图片太亮的话，会影响前景颜色，刚好图片名字后面可以跟一个图片亮度：

```bash
printf "\e]11;_/mnt/c/Users/Linwei/Pictures/MacOS/Sierra.jpg,50\e\\"
```

> 不要在 tmux 里运行，直接在终端里运行，使用 50% 的亮度：
看起来舒服很多，封装成一个独立脚本，处理好图片路径和亮度：

```bash

q_mintty_set_bgimg() {
    if [ "$#" -eq 0 ] ; then
        echo "require image file name !"
    elif [ "$1" = "/dev/null" ] ; then
        printf "\e]11;\e\\"
    elif [ -f "$1" ] ; then
        FILE="$(realpath -s """$1""" 2> /dev/null)"
        BRIGHT="${2:-100}"
        printf "\e]11;%s\e\\" "_${FILE},${BRIGHT}"
    else
        echo "'$1' is not a valid file !"
    fi
}
src="/d/pics/ai"
q_mintty_set_bgimg "$src/$(ls -1 $src | shuf -n 1)" 22
```


那么什么桌面图片最养眼呢？答案是每次都是不一样的图片看起来最舒服，跟现在的随机桌面一样，再漂亮的图，多看几次就厌烦了，因此我们在登录脚本 `.bashrc` 最后加两句：
每次打开 wsltty，就能有一张新背景了。

最后是 vim 里配置最后（设置完 color 以后），加那么两句：
```vim
hi! Normal ctermbg=None
hi! NonText ctermbg=None
```

- 最新脚本：[q-mintty-image](https://link.zhihu.com/?target=https%3A//github.com/skywind3000/vim/blob/master/tools/bin/q-mintty-image)
- [MacOS 壁纸下载 [1/59\]](https://link.zhihu.com/?target=https%3A//www.aoaod.com/Img-2/20195/27728.shtml)