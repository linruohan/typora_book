## 1 Design philosophy

*kitty*是专为大功率键盘用户设计的。为此，它的所有控件都使用键盘(尽管它也完全支持鼠标交互)。它的配置是一个简单的、可编辑的、便于再现的单一文件(我喜欢将配置存储在源代码控制中)。

*kitty*中的代码被设计成简单、模块化和可破解的。它是用C(用于性能敏感的部分)和Python(用于UI的易侵入性)混合编写的。它不依赖于任何大型复杂的UI工具包，只使用OpenGL渲染一切。

最后，*kitty*从头开始设计，以支持所有现代终端功能，如Unicode、真颜色、粗体/斜体字体、文本格式等。它甚至扩展了现有的文本格式转义代码，以添加对其他地方无法提供的功能的支持，例如彩色和样式(花)下划线。*kitty*的设计目标之一是易于扩展，以便在未来以相对较少的努力添加新功能。

## 2 Tabs and Windows

*kitty*能够运行组织成标签和窗口的多个程序。组织的顶层是[OS window](https://sw.kovidgoyal.net/kitty/glossary/#term-os_window)。

每个操作系统窗口由一个或多个[选项卡](https://sw.kovidgoyal.net/kitty/glossary/#term-tab)组成。

每个选项卡由一个或多个[kitty窗口](https://sw.kovidgoyal.net/kitty/glossary/#term-window)组成。

kitty窗口可以被安排在多种不同的[布局](https://sw.kovidgoyal.net/kitty/glossary/#term-layout)，就像窗口组织在平铺窗口管理器。标签和窗口的键盘控件([都是可定制的](https://sw.kovidgoyal.net/kitty/conf/#conf-kitty-shortcuts))是:

### 2.1 Scrolling 页面跳转

| Action                    | Shortcut                                                                                                                                                                                                                |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Line up                   | [`ctrl+shift+up`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Scroll-line-up) (also ⌥+⌘+⇞ and ⌘+↑ on macOS)                                                                                                    |
| Line down                 | [`ctrl+shift+down`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Scroll-line-down) (also ⌥+⌘+⇟ and ⌘+↓ on macOS)                                                                                                |
| Page up                   | [`ctrl+shift+page_up`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Scroll-page-up) (also ⌘+⇞ on macOS)                                                                                                         |
| Page down                 | [`ctrl+shift+page_down`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Scroll-page-down) (also ⌘+⇟ on macOS)                                                                                                     |
| Top                       | [`ctrl+shift+home`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Scroll-to-top) (also ⌘+↖ on macOS)                                                                                                             |
| Bottom                    | [`ctrl+shift+end`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Scroll-to-bottom) (also ⌘+↘ on macOS)                                                                                                           |
| 上一个shell提示                | [`ctrl+shift+z`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Scroll-to-previous-shell-prompt) (see [Shell integration](https://sw.kovidgoyal.net/kitty/shell-integration/#shell-integration))                  |
| 下一个shell提示                | [`ctrl+shift+x`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Scroll-to-next-shell-prompt) (see [Shell integration](https://sw.kovidgoyal.net/kitty/shell-integration/#shell-integration))                      |
| Browse scrollback in less | [`ctrl+shift+h`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Browse-scrollback-buffer-in-pager)                                                                                                                |
| 浏览最后一个cmd输出               | [`ctrl+shift+g`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Browse-output-of-the-last-shell-command-in-pager) (see [Shell integration](https://sw.kovidgoyal.net/kitty/shell-integration/#shell-integration)) |

### 2.2 Tabs  tab跳转

| Action            | Shortcut                                                     |
| ----------------- | ------------------------------------------------------------ |
| New tab           | [`ctrl+shift+t`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.New-tab) (also ⌘+t on macOS) |
| Close tab         | [`ctrl+shift+q`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Close-tab) (also ⌘+w on macOS) |
| Next tab          | [`ctrl+shift+right`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Next-tab) (also ⌃+⇥ and ⇧+⌘+] on macOS) |
| Previous tab      | [`ctrl+shift+left`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Previous-tab) (also ⇧+⌃+⇥ and ⇧+⌘+[ on macOS) |
| Next layout       | [`ctrl+shift+l`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Next-layout) |
| Move tab forward  | [`ctrl+shift+.`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Move-tab-forward) |
| Move tab backward | [`ctrl+shift+,`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Move-tab-backward) |
| Set tab title     | [`ctrl+shift+alt+t`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Set-tab-title) (also ⇧+⌘+i on macOS) |

### 2.3 Windows 窗口跳转

| Action                | Shortcut                                                                                                                                                                                                                                                                                                                     |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| New window            | [`ctrl+shift+enter`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.New-window) (also ⌘+↩ on macOS)                                                                                                                                                                                                                    |
| New OS window         | [`ctrl+shift+n`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.New-OS-window) (also ⌘+n on macOS)                                                                                                                                                                                                                     |
| Close window          | [`ctrl+shift+w`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Close-window) (also ⇧+⌘+d on macOS)                                                                                                                                                                                                                    |
| Next window           | [`ctrl+shift+\]`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Next-window)                                                                                                                                                                                                                                          |
| Previous window       | [`ctrl+shift+[`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Previous-window)                                                                                                                                                                                                                                       |
| Move window forward   | [`ctrl+shift+f`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Move-window-forward)                                                                                                                                                                                                                                   |
| Move window backward  | [`ctrl+shift+b`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Move-window-backward)                                                                                                                                                                                                                                  |
| Move window to top    | [`ctrl+shift+``](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Move-window-to-top)                                                                                                                                                                                                                                    |
| Visually focus window | [`ctrl+shift+f7`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Visually-select-and-focus-window)                                                                                                                                                                                                                     |
| Visually swap window  | [`ctrl+shift+f8`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Visually-swap-window-with-another)                                                                                                                                                                                                                    |
| Focus specific window | [`ctrl+shift+1`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.First-window), [`ctrl+shift+2`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Second-window) … [`ctrl+shift+0`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Tenth-window) (also ⌘+1, ⌘+2 … ⌘+9 on macOS) (clockwise from the top-left) |

此外，你可以在' kitty.conf '中定义快捷方式来聚焦邻近的窗口并移动窗口(类似于**vim**中的窗口移动):

```
map ctrl+left neighboring_window left
map shift+left move_window right
map ctrl+down neighboring_window down
map shift+down move_window up
...
```

你也可以定义一个快捷方式来切换到以前的活动窗口:

```
map ctrl+p nth_window -1
```

[' nth_window '](https://sw.kovidgoyal.net/kitty/actions/#action-nth_window)将专注于第n个窗口的正数(从0开始)，以及之前活动的窗口的负数。要切换到第n个操作系统窗口，可以定义[' nth_os_window '](https://sw.kovidgoyal.net/kitty/actions/#action-nth_os_window)。只接受正数，从1开始。你可以定义快捷方式来分离当前窗口并将其移动到另一个选项卡或另一个操作系统窗口:

```
# moves the window into a new OS window
map ctrl+f2 detach_window
# moves the window into a new tab
map ctrl+f3 detach_window new-tab
# moves the window into the previously active tab
map ctrl+f3 detach_window tab-prev
# moves the window into the tab at the left of the active tab
map ctrl+f3 detach_window tab-left
# asks which tab to move the window into
map ctrl+f4 detach_window ask
```

类似地，你可以用以下方法分离当前选项卡:

```
# moves the tab into a new OS window
map ctrl+f2 detach_tab
# asks which OS Window to move the tab into
map ctrl+f4 detach_tab ask
```

最后，你可以定义一个快捷方式来关闭选项卡中除当前活动窗口外的所有窗口:

```
map f9 close_other_windows_in_tab
```

## 3 Other keyboard shortcuts

可以映射到按键的完整动作列表在这里(https://sw.kovidgoyal.net/kitty/actions/)。

| Action                      | Shortcut                                                     |
| --------------------------- | ------------------------------------------------------------ |
| Show this help              | [`ctrl+shift+f1`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Show-documentation) |
| Copy to clipboard           | [`ctrl+shift+c`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Copy-to-clipboard) (also ⌘+c on macOS) |
| Paste from clipboard        | [`ctrl+shift+v`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Paste-from-clipboard) (also ⌘+v on macOS) |
| Paste from selection        | [`ctrl+shift+s`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Paste-from-selection) |
| Pass selection to program   | [`ctrl+shift+o`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Pass-selection-to-program) |
| Increase font size          | [`ctrl+shift+equal`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Increase-font-size) (also ⌘++ on macOS) |
| Decrease font size          | [`ctrl+shift+minus`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Decrease-font-size) (also ⌘+- on macOS) |
| Restore font size           | [`ctrl+shift+backspace`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Reset-font-size) (also ⌘+0 on macOS) |
| Toggle fullscreen           | [`ctrl+shift+f11`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Toggle-fullscreen) (also ⌃+⌘+f on macOS) |
| Toggle maximized            | [`ctrl+shift+f10`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Toggle-maximized) |
| Input Unicode character     | [`ctrl+shift+u`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Unicode-input) (also ⌃+⌘+space on macOS) |
| Open URL in web browser     | [`ctrl+shift+e`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Open-URL) |
| Reset the terminal          | [`ctrl+shift+delete`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Reset-the-terminal) (also ⌥+⌘+r on macOS) |
| Edit `kitty.conf`           | [`ctrl+shift+f2`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Edit-config-file) (also ⌘+, on macOS) |
| Reload `kitty.conf`         | [`ctrl+shift+f5`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Reload-kitty.conf) (also ⌃+⌘+, on macOS) |
| Debug `kitty.conf`          | [`ctrl+shift+f6`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Debug-kitty-configuration) (also ⌥+⌘+, on macOS) |
| Open a *kitty* shell        | [`ctrl+shift+escape`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Open-the-kitty-command-shell) |
| Increase background opacity | [`ctrl+shift+a>m`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Increase-background-opacity) |
| Decrease background opacity | [`ctrl+shift+a>l`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Decrease-background-opacity) |
| Full background opacity     | [`ctrl+shift+a>1`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Make-background-fully-opaque) |
| Reset background opacity    | [`ctrl+shift+a>d`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Reset-background-opacity) |

## 4 Configuring kitty

*kitty* is highly configurable, everything from keyboard shortcuts to painting frames-per-second. Press [`ctrl+shift+f2`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Edit-config-file) in kitty to open its fully commented sample config file in your text editor. For details see the [configuration docs](https://sw.kovidgoyal.net/kitty/conf/).



## 5 Layouts

A [layout](https://sw.kovidgoyal.net/kitty/glossary/#term-layout) is an arrangement of multiple [kitty windows](https://sw.kovidgoyal.net/kitty/glossary/#term-window) inside a top-level [OS window](https://sw.kovidgoyal.net/kitty/glossary/#term-os_window). The layout manages all its windows automatically, resizing and moving them as needed. You can create a new [window](https://sw.kovidgoyal.net/kitty/glossary/#term-window) using the [`ctrl+shift+enter`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.New-window) key combination.

Currently, there are seven layouts available:

- **Fat** -- One (or optionally more) windows are shown full width on the top, the rest of the windows are shown side-by-side on the bottom
- **Grid** -- All windows are shown in a grid
- **Horizontal** -- All windows are shown side-by-side
- **Splits** -- Windows arranged in arbitrary patterns created using horizontal and vertical splits
- **Stack** -- Only a single maximized window is shown at a time
- **Tall** -- One (or optionally more) windows are shown full height on the left, the rest of the windows are shown one below the other on the right
- **Vertical** -- All windows are shown one below the other

By default, all layouts are enabled and you can switch between layouts using the [`ctrl+shift+l`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Next-layout) key combination. You can also create shortcuts to select particular layouts, and choose which layouts you want to enable, see [Layout management](https://sw.kovidgoyal.net/kitty/conf/#conf-kitty-shortcuts-layout) for examples. The first layout listed in [`enabled_layouts`](https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.enabled_layouts) becomes the default layout.

For more details on the layouts and how to use them see [the documentation](https://sw.kovidgoyal.net/kitty/layouts/).

## 6 Extending kitty

kitty has a powerful framework for scripting. You can create small terminal programs called [kittens](https://sw.kovidgoyal.net/kitty/kittens_intro/). These can used to add features to kitty, for example, [editing remote files](https://sw.kovidgoyal.net/kitty/kittens/remote_file/) or [inputting Unicode characters](https://sw.kovidgoyal.net/kitty/kittens/unicode_input/). They can also be used to create programs that leverage kitty’s powerful features, for example, [viewing images](https://sw.kovidgoyal.net/kitty/kittens/icat/) or [diffing files with image support](https://sw.kovidgoyal.net/kitty/kittens/diff/).

You can [create your own kittens to scratch your own itches](https://sw.kovidgoyal.net/kitty/kittens/custom/).

For a list of all the builtin kittens, [see here](https://sw.kovidgoyal.net/kitty/kittens_intro/#kittens).

## 7 Remote control

*kitty* has a very powerful system that allows you to control it from the [shell prompt, even over SSH](https://sw.kovidgoyal.net/kitty/remote-control/). You can change colors, fonts, open new [windows](https://sw.kovidgoyal.net/kitty/glossary/#term-window), [tabs](https://sw.kovidgoyal.net/kitty/glossary/#term-tab), set their titles, change window layout, get text from one window and send text to another, etc. The possibilities are endless. See the [tutorial](https://sw.kovidgoyal.net/kitty/remote-control/) to get started.



## 8 Startup Sessions

You can control the [tabs](https://sw.kovidgoyal.net/kitty/glossary/#term-tab), [kitty window](https://sw.kovidgoyal.net/kitty/glossary/#term-window) layout, working directory, startup programs, etc. by creating a *session* file and using the [`kitty --session`](https://sw.kovidgoyal.net/kitty/invocation/#cmdoption-kitty-session) command line flag or the [`startup_session`](https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.startup_session) option in `kitty.conf`. For example:

```
# Set the layout for the current tab
layout tall
# Set the working directory for windows in the current tab
cd ~
# Create a window and run the specified command in it
launch zsh
# Create a window with some environment variables set and run vim in it
launch --env FOO=BAR vim
# Set the title for the next window
launch --title "Chat with x" irssi --profile x

# Create a new tab
# The part after new_tab is the optional tab title which will be displayed in
# the tab bar, if omitted, the title of the active window will be used instead.
new_tab my tab
cd ~/somewhere
# Set the layouts allowed in this tab
enabled_layouts tall,stack
# Set the current layout
layout stack
launch zsh

# Create a new OS window
# Any definitions specifed before the first new_os_window will apply to first OS window.
new_os_window
# Set new window size to 80x24 cells
os_window_size 80c 24c
# Set the --class for the new OS window
os_window_class mywindow
launch sh
# Resize the current window (see the resize_window action for details)
resize_window wider 2
# Make the current window the active (focused) window in its tab
focus
# Make the current OS Window the globally active window (not supported on Wayland)
focus_os_window
launch emacs
```



Note

The [launch](https://sw.kovidgoyal.net/kitty/launch/) command when used in a session file cannot create new OS windows, or tabs.

## 9 Creating tabs/windows

kitty can be told to run arbitrary programs in new [tabs](https://sw.kovidgoyal.net/kitty/glossary/#term-tab), [windows](https://sw.kovidgoyal.net/kitty/glossary/#term-window) or [overlays](https://sw.kovidgoyal.net/kitty/glossary/#term-overlay) at a keypress. To learn how to do this, see [here](https://sw.kovidgoyal.net/kitty/launch/).

## 10 Mouse features

- You can click on a URL to open it in a browser.
- You can double click to select a word and then drag to select more words.
- You can triple click to select a line and then drag to select more lines.
- You can triple click while holding Ctrl+Alt to select from clicked point to end of line.
- You can right click to extend a previous selection.
- You can hold down Ctrl+Alt and drag with the mouse to select in columns.
- Selecting text automatically copies it to the primary clipboard (on platforms with a primary clipboard).
- You can middle click to paste from the primary clipboard (on platforms with a primary clipboard).
- You can right click while holding Ctrl+Shift to open the output of the clicked on command in a pager (requires [Shell integration](https://sw.kovidgoyal.net/kitty/shell-integration/#shell-integration))
- You can select text with kitty even when a terminal program has grabbed the mouse by holding down the Shift key

All these actions can be customized in `kitty.conf` as described [here](https://sw.kovidgoyal.net/kitty/conf/#conf-kitty-mouse-mousemap).

You can also customize what happens when clicking on [hyperlinks](https://sw.kovidgoyal.net/kitty/glossary/#term-hyperlinks) in kitty, having it open files in your editor, download remote files, open things in your browser, etc.

For details, see [here](https://sw.kovidgoyal.net/kitty/open_actions/).

## 11 Font control

*kitty* has extremely flexible and powerful font selection features. You can specify individual families for the regular, bold, italic and bold+italic fonts. You can even specify specific font families for specific ranges of Unicode characters. This allows precise control over text rendering. It can comein handy for applications like powerline, without the need to use patched fonts. See the various font related configuration directives in [Fonts](https://sw.kovidgoyal.net/kitty/conf/#conf-kitty-fonts).



## 12 The scrollback buffer

*kitty* supports scrolling back to view history, just like most terminals. You can use either keyboard shortcuts or the mouse scroll wheel to do so. However, *kitty* has an extra, neat feature. Sometimes you need to explore the scrollback buffer in more detail, maybe search for some text or refer to it side-by-side while typing in a follow-up command. *kitty* allows you to do this by pressing the [`ctrl+shift+h`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Browse-scrollback-buffer-in-pager) shortcut, which will open the scrollback buffer in your favorite pager program (which is **less** by default). Colors and text formatting are preserved. You can explore the scrollback buffer comfortably within the pager.

Additionally, you can pipe the contents of the scrollback buffer to an arbitrary, command running in a new [window](https://sw.kovidgoyal.net/kitty/glossary/#term-window), [tab](https://sw.kovidgoyal.net/kitty/glossary/#term-tab) or [overlay](https://sw.kovidgoyal.net/kitty/glossary/#term-overlay). For example:

```
map f1 launch --stdin-source=@screen_scrollback --stdin-add-formatting less +G -R
```



Would open the scrollback buffer in a new [window](https://sw.kovidgoyal.net/kitty/glossary/#term-window) when you press the F1 key. See [`show_scrollback`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Browse-scrollback-buffer-in-pager) for details.

If you want to use it with an editor such as **vim** to get more powerful features, you can see tips for doing so, in [this thread](https://github.com/kovidgoyal/kitty/issues/719).

If you wish to store very large amounts of scrollback to view using the piping or [`show_scrollback`](https://sw.kovidgoyal.net/kitty/conf/#shortcut-kitty.Browse-scrollback-buffer-in-pager) features, you can use the [`scrollback_pager_history_size`](https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.scrollback_pager_history_size) option.

## 13 Integration with shells

kitty has the ability to integrate closely within common shells, such as [zsh](https://www.zsh.org/), [fish](https://fishshell.com/) and [bash](https://www.gnu.org/software/bash/) to enable features such as jumping to previous prompts in the scrollback, viewing the output of the last command in **less**, using the mouse to move the cursor while editing prompts, etc. See [Shell integration](https://sw.kovidgoyal.net/kitty/shell-integration/) for details.



## 14 Multiple copy/paste buffers

In addition to being able to copy/paste from the system clipboard, in *kitty* you can also setup an arbitrary number of copy paste buffers. To do so, simply add something like the following to your `kitty.conf`:

```
map f1 copy_to_buffer a
map f2 paste_from_buffer a
```



This will allow you to press F1 to copy the current selection to an internal buffer named `a` and F2 to paste from that buffer. The buffer names are arbitrary strings, so you can define as many such buffers as you need.

## 15 Marks

kitty has the ability to mark text on the screen based on regular expressions. This can be useful to highlight words or phrases when browsing output from long running programs or similar. To learn how this feature works, see [Mark text on screen](https://sw.kovidgoyal.net/kitty/marks/).