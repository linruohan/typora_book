# i3wm的使用说明

[toc]



# 1. 默认键位

给那些“太长不看”的人，以下图片是默认热键。

与$mod（Alt）一起按：

![img](https://upload-images.jianshu.io/upload_images/7212299-aa2e88822a63cc8f.png?imageMogr2/auto-orient/strip|imageView2/2/w/900/format/webp)

Alt

与Shift+$mod一起按：

![img](https://upload-images.jianshu.io/upload_images/7212299-4f7d190baa8d954f.png?imageMogr2/auto-orient/strip|imageView2/2/w/900/format/webp)

Alt+Shift



红色按键是你需要按的修饰键（默认配置），蓝色按键是盲打键位。

要注意的是，若是没有配置文件就启动i3,i3-config-wizard 会帮助你创建一个配置文件，键位位置会跟上图所示一样，不管你是什么键盘布局。
如果你喜欢上图的设置，可以拒绝 i3-config-wizard的引导，默认以 *etc/i3/config* 作为配置文件

# 2. 使用i3

贯穿整个使用文档，关键字$mod将当作已配置好的修饰键，修饰键默认为Alt键（Mod1），windows（Mod4）键也是一个受欢迎的替换方案

## 2.1 打开虚拟终端和移动位置

打开一个新的虚拟终端是非常简单的操作，默认情况下，这个操作的组合键是 *$mod+Enter* ,默认配置下是Alt+Enter。按下$mod+Enter,将会打开一个新的虚拟终端，它将占满你屏幕的所有空间。

![img](https://upload-images.jianshu.io/upload_images/7212299-9cfe8ea71fab6bfd.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

termialFillTheScreen

如果你现在打开另一个虚拟终端，i3会把屏幕空间一分为二，各占一半。新创建的窗口会被i3放在已有窗口的旁边（宽屏）或者下面（竖屏）

![img](https://upload-images.jianshu.io/upload_images/7212299-ff290fc586dd8f1d.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

newATerminal

要在两个终端之间移动焦点，你可以使用vi编辑器风格的方向键。然而，在i3里，盲打键位就是方向键(vi编辑器里的方向键为了兼容大多数键盘布局，都向左移动了一个键位)。因此，*$mod+j*是向左，*$mod+k*是向上，*$mod+l*是向下，*$mod+;*是向右。像上图的情况，用*$mod+k*或*$mod+l*在两个终端之间切换。当然，你也可以使用箭头方向键。

现在，你的workspace是按特定方向（默认水平方向）划分（容器里包含两个终端）。你可把每个window都再分离一次（水平或者垂直），就像workspace一样。“window”指一个容器包含一个X11窗口（如一个浏览器或者一个终端），“split container”指的是容器包含一个或多个窗口。

TODO:picture of the tree

垂直分割窗口，在创建新窗口前按*$mod+v*，水平分割窗口，按*$mod+h*。

## 2.2 改变容器布局

一个split container 可以设置成下面所列出的布局之一。

##### splith/splitv

容器里的每个窗口都获得等量大小的空间。splith 控制每个窗口在彼此的左右方。splitv 控制每个窗口在彼此的上下方。

##### stacking

容器里只显示一个正在活动的窗口。在容器上方得到一个窗口的列表。

##### tabbed

与stacking是一个原理，不过tabbed的窗口列表是单行显示的标签页。

切换模式：*$mod+e*打开splith/splitv，*$mod+s*打开stacking，*$mod+w*打开tabbed

![img](https://upload-images.jianshu.io/upload_images/7212299-6a902b1e21d0f37c.png?imageMogr2/auto-orient/strip|imageView2/2/w/600/format/webp)

layoutmode

## 2.3 把一个窗口切换到全屏模式

把一个窗口全屏显示或者退出全屏，按 *$mod+f*。

在i3里还有全局全屏模式，那么这个窗口将占据所有的显示输出（多屏显示）（配置命令： **fullscrren toggle global**）

## 2.4 打开其他应用程序

除了通过终端打开应用程序，你也可以使用dmenu来打开程序，默认情况下通过*$mod+d*调出。只需要输入你要打开的应用的名字（或者是名字的一部分），应用必须在$PATH中才能正常打开。

另外，如果你有一个需要经常打开的应用，你可以创建一个组合键来直接打开它，细节请看 [配置](https://link.jianshu.com/?t=https://i3wm.org/docs/userguide.html#configuring) 部分.

## 2.5 关闭窗口

如果一个程序未提供一个关闭的机制（很多程序都提供了一个关闭方案，Esc键或者一个快捷键，比如**Ctrl+w**），你可以按*$mod+Shift+q* 来杀掉这个窗口。对于支持 WM_DELETE 协议的应用程序，它将正确地关闭（保存任何修改或进行其他清理）。如果程序不支持 WM_DELETE 协议。X server 将杀掉这个程序并且之后的动作取决与此程序。

## 2.6 使用workspaces

使用**工作空间**是分组归类一堆窗口的好方法。默认情况下，你处在第一个workspace,就像i3bar左下角所指示的一样。要切换到其他workspace，按下*$mod+数字键*（你要切换到的workspace的数字）。如果工作空间不存在，它将被创建。

一个常见的例子是把网页浏览器放在第一workspace，聊天工具放在另一个workspace，还有另一个你运行的其他软件放在第三个workspace。当然，你可以不必照着做。

如果你拥有多个显示屏，在启动时将会在每个屏幕创建一个workspace。如果你打开一个新的workspace，他会绑定到你正在工作的显示屏。当你切换一个在其他 显示屏的workspace时，i3会把焦点设置到那个显示屏。

## 2.7 移动一个window到另一个workspace

移动一个窗口到另一个工作空间，按*$mod+Shift+目标工作区数字*。跟切换workspaces时一样的情况，如果目标工作空间不存在，它将被创建。

## 2.8 调整窗口大小

调整容器大小最简单的办法是用鼠标：拖拽边框到想要的大小。

你也可以定义快捷键来调整，可以看看这个例子，[default config](https://link.jianshu.com/?t=https://github.com/i3/i3/blob/next/etc/config.keycodes)--由i3提供

## 2.9 重启i3

为了重启i3你可以使用*$mod+Shift+r*(例如当有一个bug时，恢复到正常状态，或者升级到一个新版本i3)。

## 2.10 退出i3

不关掉Xserver且利落地退出i3，你可以按*$mod+shift+e*。通常，会有一个对话向你确认是否退出。

## 2.11 浮动模式

浮动模式是相对于平铺模式的。窗口的位置和大小不是由i3自动管理的，而是由你手工调整。使用这个模式有违于平铺模式，但是他对一些案例如"Save as"对话窗口，或者toolbar窗口（GIMP或类似的）是有用的。这些窗口通常会设置恰当的提示和默认情况下被打开于浮动模式。

你可以通过按*$mod+Shift+space*来切换一个窗口的浮动模式。通过鼠标拖动标题栏，你可以移动这个窗口，通过拖动边框，你可以调整窗口大小。你也可以通过使用[floating_modifier](https://link.jianshu.com/?t=https://i3wm.org/docs/userguide.html#floating_modifier)来操作。另一个调整浮动窗口大小的方法是鼠标右击标题栏并且拖拽。

关于用键盘来调整浮动窗口的大小，请看调整大小的绑定模式，由i3提供
[default config](https://link.jianshu.com/?t=https://github.com/i3/i3/blob/next/etc/config.keycodes)

浮动窗口一直处于平铺窗口的上方

# 3 树

i3保存着所有关于 X11 output 的数据，workspace和窗口布局在里面是树形图的结构。根节点是X11根窗口，随后是X11 putputs，然后是 dock areas 和一个 content container，随后是workspace，最后是window本身。在旧版本的i3，每个workspace有多个list和table，这个方法的结果是难以使用（真的难），理解和实现。

## 3.1 树是由容器组成的

我们把树的组件叫做Containers。一个容器可以掌控一个窗口（意思是一个X11 window，你可以真正看到的，使用的，比如说一个浏览器）。另外，Containers可以再包含一个或者多个Containers。一个简单的workspace例子是：当你在单个显示器打开i3时，只有一个workspace，你这时打开了两个终端，你最后得到的树是：

![img](https://upload-images.jianshu.io/upload_images/7212299-26a2599d76a050f0.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

Two terminals on standard workspace



![img](https://upload-images.jianshu.io/upload_images/7212299-140263d9367b8932.png?imageMogr2/auto-orient/strip|imageView2/2/w/300/format/webp)

tree

## 3.2 定位和Split Containers

当以树作为数据结构时，为了构建一个布局，使用所谓的 Split Containers 是很正常的。在i3里，每个容器都有属于自己的方位（水平，垂直，或者未指定），并且定位取决于上一级容器的布局（垂直的有splitev和stacking，水平的有splith和tabbed）。所以我们以一个workspace作为例子，workspace 容器的默认布局是splith(如今很多显示器是宽屏的)。如果你把布局切换成splitv（默认情况下按*$mod+v*）然后打开两个终端，i3会把你的窗口设置成这个样子：

![img](https://upload-images.jianshu.io/upload_images/7212299-e6fffd31e2034c26.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

vertical

从version 4开始，i3多了一个有趣的新特性，它能够分割任何东西：让我们假设你现在在workspace里打开了两个终端（以splith布局打开，也就是水平定位）焦点处于右边的终端，现在你想要要在当前终端下面打开另外一个终端。如果你直接打开新终端，它会被放在最右边而不是下面。解决办法是按*$mod+v*用splitv布局来分割容器（要打开Horizontal Split Container，用*$mod+h*）。现在你可以在当前终端下面打开一个新终端了：

![img](https://upload-images.jianshu.io/upload_images/7212299-ec8e838ecbf80f62.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

Vertical Split Container



![img](https://upload-images.jianshu.io/upload_images/7212299-4f71b2a96969d31d.png?imageMogr2/auto-orient/strip|imageView2/2/w/300/format/webp)

tree

你可能已经猜到了：它能够无限分割到下一层。

## 3.3 聚焦于父容器

$mod+a

我们继续以上图为例。我们在左边有一个终端，右边有两个垂直分布的终端，焦点处在右下角的终端。当你又打开一个新终端，他会被放在右下角终端的下面。

所以说，要怎么把新终端放到右边而不是下面呢，答案是使用focus parent，它会把焦点转移到当前容器的父容器。在这种情况下，你会把焦点放在水平方向的workspace里的vertical split Container。因此，新窗口会被打开在Vertical Split Container的右边：

![img](https://upload-images.jianshu.io/upload_images/7212299-e98f37499c488785.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

Focus parent, then open new terminal

## 3.4 隐式容器

在一些情况下，i3需要隐式地创建一个容器来完成你的命令。

一个例子如下：你在单个显示器启用i3，在单个workspace打开3个终端。workspace节点在i3的layout tree里，这些终端窗口直属于workspace节点。默认workspace节点的方向设置是水平的。

现在你往下移动其中一个终端（*$mod+Shift+k* by default）。那么workspace节点会被设置成**垂直布局**，你移动的这个终端就会出现在屏幕的下面并且直属于workspace。一个新的容器被创建，用于容纳另外两个终端。当你切换到tabbed模式，你会注意到这个情况。你最终会得到一个有标签页容器，里面有两个窗口（比如 "H[urxvt firefox]"），还有一个你刚才移动到下面的终端窗口。

# 4 配置i3

到这里，真正有趣的事情才刚刚开始;-)。很多东西都非常依赖于你样要的工作环境，所以我们无法提供一个默认的且合理的配置。

虽然没有使用编程语言来进行配置，i3在你希望让窗口管理器怎么做的方面依然保持着灵活的特性。

例如，你可以配置一个绑定用来跳到指定的窗口，可以设置打开指定的应用程序到指定的workspace，可以自动启动某个程序，可以改变i3的配色，还可以设置快捷键来做一些有用的事情。

要改变i3的配置，复制 **/etc/i3/config** 到 **~/.i3/config**并且用一个文本编辑器来编辑它（或者是复制到**~/.config/i3/config**，如果你喜欢XDG目录方案）

第一次启动i3时，i3会引导你创建一个配置文件，你可以告诉向导程序在配置文件里设置Alt（Mod1）或windows（Mod4）键作为辅助按键。当然，创建的配置文件会使用你当前键盘布局的键盘符号。要启动向导程序，请在终端输入命令**i3-config-wizard**。
请确认你当前并没有**~/.i3/config/**。否则向导程序将会退出。

## 4.1 备注

在配置文件里使用备注是可行的和推荐的，为了以后参考或修改，适当地记录你的配置。备注以**#**开始，而且只能用在每行的开头：

**例子**

```
# This is a comment
```

## 4.2 字体

i3支持以 X core字体和 FreeType 字体来渲染窗口标题

你可以使用xfontsel(1) 生成一个 X core字体类型。你需要使用一个支持ISO-10646编码的字体来显示特殊字符（Unicode）。

一个FreeType字体类型是由一个字体系列，风格，粗细，便提，伸延组成的，FreeType字体支持从右到左的渲染和往往比 X core字体支持更多的Unicode符号。

如果i3不能打开配置好的字体，i3会吧错误输出到日志文件，退回到可以工作的字体

**语法：**



```xml
font <X core font description>
font pango:<family list> [<style options>] <size>
```

**例子：**



```css
font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
font pango:DejaVu Sans Mono 10
font pango:DejaVu Sans Mono, Terminus Bold Semi-Condensed 11
font pango:Terminus 11px
```

## 4.3 键盘绑定

一个键盘绑定会让i3在按下特定的按键后执行一个命令。i3允许以keycode或keysym绑定（你可已随便更改绑定，虽然i3并不会帮你解决键位冲突）

- Keysym(key symbol)是指键盘上的符号。像是"A"或者"B"，但是像是那些奇怪的"underscore"而不是"_"。这些符号是你们用Xmodmap重新映射的按键。要获得当前键盘的映射，使用命令 `xmodmap -pke` 。要以交互方式输入一个按键，查看它是被设置成什么keysym，使用命令 `xev` 。
- Keycode 不需要拥有一个已赋值符号（方便某些笔记本热键），而且他们即使在你换了键盘布局后，也不会改变keycode本身（当使用xmodmap）。

我的建议是：如果你经常更换键盘布局，但是不想改变绑定键位的物理位置，使用keycodes。如果你不改变键盘布局，而且想要一个简单干净的配置文件，使用keysyms。

某些工具（例如import或者xdotool）可能无法运行在一些KeyPress事件，因为键盘/指针被占用了。针对这些情况，可以使用 **--release** 标记,这将在按键被松开后执行命令。

**语法：**



```css
bindsym [--release] [<Group>+][<Modifiers>+]<keysym> command
bindcode [--release] [<Group>+][<Modifiers>+]<keycode> command
```

**例子：**



```bash
# Fullscreen
bindsym $mod+f fullscreen toggle

# Restart
bindsym $mod+Shift+r restart

# Notebook-specific hotkeys
bindcode 214 exec --no-startup-id /home/michael/toggle_beamer.sh

# Simulate ctrl+v upon pressing $mod+x
bindsym --release $mod+x exec --no-startup-id xdotool key --clearmodifiers ctrl+v

# Take a screenshot upon pressing $mod+x (select an area)
bindsym --release $mod+x exec --no-startup-id import /tmp/latest-screenshot.png
```

可以使用的修饰键：

**Mod1-mod5，Shift，Control**



```undefined
默认修饰请看 xmodmap（1）
```

**Group1, Group2, Group3, Group4**
当使用多个键盘布局（例如setxkbmap -layout us，ru）时，您可以指定哪个XKB组（也称为“布局”）键盘绑定应处于活动状态。默认的，键盘绑定会被转换成Group1并且活跃在所有键盘布局。如果你想为其中一个键盘布局重写键盘绑定，指定到相应的group。为了向后兼容，“Mode_switch” 是Group2的别名。

## 4.4 鼠标绑定

在容器范围内按下一个已经绑定的鼠标按键，i3将会执行一个命令。你可以用绑定键盘的方法设置鼠标绑定。

**语法：**



```css
bindsym [--release] [--border] [--whole-window] [<Modifiers>+]button<n> command
```

默认的，绑定只会在点击到标题栏的时候运行。如果添加了**--release**标记，它会在按键松开时运行。

如果添加了**--whole-window**标记，绑定会在你点击到窗口任何一个部位时运行，但是边框除外。为了让一个绑定在点击到边框时运行，指定一个**--border**标记。

**例子:**



```bash
# The middle button over a titlebar kills the window
bindsym --release button2 kill

# The middle button and a modifer over any part of the window kills the window
bindsym --whole-window $mod+button2 kill

# The right button toggles floating
bindsym button3 floating toggle
bindsym $mod+button3 floating toggle

# The side buttons move the window around
bindsym button9 move left
bindsym button8 move right
```

## 绑定模式

你可以拥有多套键位绑定模式，当你切换到其他绑定模式的时候，所有当前键位绑定会被释放，并且只有你新切换的绑定模式生效。唯一的预设的绑定模式是**defalut**的，他伴随i3的启动，并且没有定义任何指定的绑定模式。

使用绑定模式有以下两部分组成:定义一个绑定模式和切换到它。为了做到这个，需要一个配置指令和一个命令，他们被称为**mode**。配置指令被用来定义一组绑定并且把它放到一个绑定模式，而命令是用来切换到一个绑定模式。

建议与**[variables]**组合使用绑定模式，以便维护更容易。以下是一个简单案例

请注意定义一个退回默认模式的绑定键

注意，可以使用**[pango_markup]**来设置绑定模式， 但是你需要通过添加 **--pango_markup**标记给定义模式来明确地开启它。

**语法**



```bash
# config directive
mode [--pango_markup] <name>

# command
mode <name>
```

**例子**



```bash
# Press $mod+o followed by either f, t, Esc or Return to launch firefox,
# thunderbird or return to the default mode, respectively.
set $mode_launcher Launch: [f]irefox [t]hunderbird
bindsym $mod+o mode "$mode_launcher"

mode "$mode_launcher" {
    bindsym f exec firefox
    bindsym t exec thunderbird

    bindsym Esc mode "default"
    bindsym Return mode "default"
}
```

## 4.6 浮动调节

移动浮动窗口。你可以选择其中一个方式，1拖动标题栏，2配置可以通过按键和鼠标点击窗口来移动窗口的浮动调节器。最常见的设置是用与管理窗口相同的按键（例如Mod1）。也就是说，你可以按住Mod1,同时鼠标左键点击拖动动窗口到你想要的方位。

当你按住浮动调节器时（Mod1）,你可以通过按住鼠标右键并拖动，来调整那一个窗口的大小。如果你同时按住了Shift键，窗口将会按比例缩放（宽高比会保留）。

**语法**



```xml
floating_modifier <Modifier>
```

**例子**



```undefined
floating_modifier Mod1
```

## 4.7 限制浮动窗口的大小

浮动窗口的最大最小面积可以被指定。如果其中的**floating_maximum_size**被指定为-1，那么对于窗口的最大值将不会被约束。如果其中的**floating_maximum_size**为定义，或者被制定为0,i3会使用默认值来限制窗口最大值。**floating_minimum_size**的处理方法一定程度上与**floating_maximum_size**的相同。

**语法**



```xml
floating_minimum_size <width> x <height>
floating_maximum_size <width> x <height>
```

**例子**



```undefined
floating_minimum_size 75 x 50
floating_maximum_size -1 x -1
```

## 4.8 工作区的定位

新工作区有一个默认合适的定位：宽屏用水平定位，竖屏用垂直定位。

你可以重写**default_orientation**的行为

**语法**



```cpp
default_orientation horizontal|vertical|auto
```

**例子**



```undefined
default_orientation vertical
```

## 4.9 新容器的布局模式

这个选项决定了工作区级别的容器该用什么布局模式

**语法**



```cpp
workspace_layout default|stacking|tabbed
```

**例子**



```undefined
workspace_layout tabbed
```

## 4.10 新窗口的边框风格

此选项决定新窗口拥有什么样的边框风格。默认是**normal**。注意，new_float 仅应用于作为浮动窗口呼出的窗口。例如对话窗口，而不是到后来才被设置成浮动窗口的窗口。

**语法**



```ruby
new_window normal|none|pixel
new_window normal|pixel <px>
new_float normal|none|pixel
new_float normal|pixel <px>
```

**例子**



```undefined
new_window pixel
```

"normal" 和 "pixel" 边框风格支持设置边框像素大小的可选项。

**例子**



```bash
# The same as new_window none
new_window pixel 0

# A 3 px border
new_window pixel 3
```

## 4.11 隐藏靠近屏幕边缘的边框

你可以使用**hide_edge_borders**来隐藏与屏幕边缘靠近的边框。如果你使用滚动条的话这很有用，或者不想浪费甚至两像素的显示空间。"smart"选项是在工作区内只有一个可见窗口时才隐藏边框，而在工作去内有多个窗口，他不会隐藏边框。

**语法**



```ruby
hide_edge_borders none|vertical|horizontal|both|smart
```

**例子**



```undefined
hide_edge_borders vertical
```

## 4.12 指定窗口的任意命令（for window）

使用**for_window**指令，当i3碰到特定的窗口，你可以让i3执行任何命令。它可以用在让窗口浮动，改变他们的边框的方面，等。

**语法**



```xml
for_window <criteria> <command>
```

**例子**



```bash
# enable floating mode for all XTerm windows
for_window [class="XTerm"] floating enable

# Make all urxvts use a 1-pixel border:
for_window [class="urxvt"] border pixel 1

# A less useful, but rather funny example:
# makes the window floating as soon as I change
# directory to ~/work
for_window [title="x200: ~/work"] floating enable
```

有效的命令请[command_criteria](https://link.jianshu.com/?t=https://i3wm.org/docs/userguide.html#command_criteria)

## 4.13 不把焦点放在新建窗口

当一个新窗口出现时，焦点会移到它那里。**no_focus** 指令允许预防这种情况发生，而且它必须与[command_criteria](https://link.jianshu.com/?t=https://i3wm.org/docs/userguide.html#command_criteria)一起使用

注意，他不会在所有情景下生效，例如，当数据正输送给一个运行中的程序，使得焦点必须移到它身上。设置这种情况的行为，参考[focus_on_window_activation](https://link.jianshu.com/?t=https://i3wm.org/docs/userguide.html#focus_on_window_activation)

在工作区的第一个窗口中，no_focus也会被忽略，在这种情况下，没有理由不把焦点放在这个窗口。与workspace_layaout结合使用会有更好是可用性。

**语法**



```xml
no_focus <criteria>
```

**例子**



```bash
no_focus [window_role="pop-up"]
```

## 4.14 变量

正如您在有关键盘绑定的章节中了解到的，你将要配置许多包含修饰键的绑定，如果你想要保存一些输入并能够改变你之后要用的修饰键，那么变量就很方便了。

**语法**



```csharp
set $<name> <value>
```

**例子**



```bash
set $m Mod1
bindsym $m+Shift+r restart
```

在解释过程中，变量会在文件中被替换。变量扩张不是递归的，所以不可能用一个包含另一个变量的值来定义变量。对于这个没有其他的想法，而且绝对没有改变的计划。如果你需要更多的动态配置，你应该创建一些用来生成配置文件在i3启动之前运行的脚本。