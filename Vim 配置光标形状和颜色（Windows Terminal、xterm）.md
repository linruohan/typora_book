# Vim 配置光标形状和颜色（Windows Terminal、xterm）

[![img](https://upload.jianshu.io/users/upload_avatars/6875152/28d4a1ff-5c5a-4e5d-922a-bd2f7bea3fb7.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/58f183c39554)

[rollingstarky](https://www.jianshu.com/u/58f183c39554)关注

0.2612021.06.08 21:10:13字数 497阅读 2,302

Windows Terminal 里的 Vim 设置了浅的配色，刚好光标默认是白色的竖线，不容易看出来。很有点费眼睛。

想把光标改成其他颜色的方块样式。因为不是 gvim，`guicursor` 之类的配置不起作用。
上网查了些资料，测试如下配置可以正常生效（貌似这个 Terminal 是属于 `xterm` 那一类）：



```vim
" Set cursor shape and color
if &term =~ "xterm"
    " INSERT mode
    let &t_SI = "\<Esc>[6 q" . "\<Esc>]12;blue\x7"
    " REPLACE mode
    let &t_SR = "\<Esc>[3 q" . "\<Esc>]12;black\x7"
    " NORMAL mode
    let &t_EI = "\<Esc>[2 q" . "\<Esc>]12;green\x7"
endif
" 1 -> blinking block  闪烁的方块
" 2 -> solid block  不闪烁的方块
" 3 -> blinking underscore  闪烁的下划线
" 4 -> solid underscore  不闪烁的下划线
" 5 -> blinking vertical bar  闪烁的竖线
" 6 -> solid vertical bar  不闪烁的竖线
```

其中各配置项的含义如下：

- `&t_SI` 表示插入模式
- `&t_SR` 表示替换模式
- `&t_EI` 表示 Normal 模式
- `.` 号左边的 `"\<Esc>[6 q"` 用来配置光标的形状。其中 `6` 的取值可以是 `1 - 6`，分别指代不同的光标样式（参考前面的注释）
- `.` 号右边的 `"\<Esc>]12;blue\x7"` 用来配置光标颜色，其中的 `blue` 可以替换为其他颜色名词

设置光标颜色时也可以使用 RGB 颜色，格式为 `rgb:RR/GG/BB`。比如纯白色的光标即为 `"\<Esc>]12;rgb:FF/FF/FF\x7"`。

若只想设置光标形状，直接去掉 `.` 号以及右边的颜色配置部分即可。如 `let &t_SR = "\<Esc>[3 q"`。
同理，只想修改颜色时也可以将 `.` 号左边的形状配置部分删掉。
`.` 号在这里的作用其实是字符串拼接，方便区分形状配置部分和颜色配置部分而已。去掉 `.` 号直接将两部分配置写在一个字符串里也是可以的。
即 `let &t_SR = "\<Esc>[3 q" . "\<Esc>]12;black\x7"` 等同于 `let &t_SR = "\<Esc>[3 q\<Esc>]12;black\x7"`





Normal 模式（绿色方块）：

![img](https://upload-images.jianshu.io/upload_images/6875152-ae01d0d4a9671096.png?imageMogr2/auto-orient/strip|imageView2/2/w/1031/format/webp)

Normal





插入模式（蓝色竖线）：

![img](https://upload-images.jianshu.io/upload_images/6875152-4fa8045616982bdd.png?imageMogr2/auto-orient/strip|imageView2/2/w/1036/format/webp)

Insert





替换模式（黑色下划线）：

![img](https://upload-images.jianshu.io/upload_images/6875152-426522041791876e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1045/format/webp)

Replace

#### 参考资料

[Cursor color in xterm; change accordingly to the syntax in vim](https://links.jianshu.com/go?to=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F14920634%2Fcursor-color-in-xterm-change-accordingly-to-the-syntax-in-vim)



vim改变光标形状

Linux
专栏收录该内容
28 篇文章0 订阅
订阅专栏
日常在Terminal中使用vim，insert模式的光标是块状的，不利于区分，如何修改呢，（注意改gursursor是没用的，那是gvim的设置
如果和我一样，用的是gnome-terminal，则添加以下内容到~/.vimrc

```bash
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

```


不同的终端不同，具体见如下
https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes

最终效果
normal模式
------------------------------------------------
版权声明：本文为CSDN博主「CHAOS_ORDER」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/CHAOS_ORDER/article/details/110880991