# AutoHotKey (AHK) 按键表+自定义快捷键简化操作的教程

## 

## 自定义快捷键简化操作的教程

| ①    | 下载安装AutoHotKey，并用记事本新建一个MyHotKey.ahk文件，录入如②中信息 |
| ---- | ------------------------------------------------------------ |
| ②    | 下图可以实现，按F6即可触发“Ctrl+C”的复制快捷键，同理F7可实现粘贴。此处为一个简单的Demo更多操作，请看下面的AHK按键表。![img](https://images2017.cnblogs.com/blog/577880/201801/577880-20180116171310099-1584717890.png) |
| ③    | 若程序是安装的，直接点击.ahk文件，即可运行。若是使用的绿色解压版，则需要用在打开方式中使用解压的“AutoHotkey.exe”程序 |

## 鼠标

| 概述                 |                                                              |
| :------------------- | :----------------------------------------------------------- |
| LButton              | 鼠标左键                                                     |
| RButton              | 鼠标右键                                                     |
| MButton              | 鼠标中键或滚轮                                               |
| 高级                 |                                                              |
| XButton1             | 鼠标的第四个按钮。一般和 Browser_Back 执行相同功能。         |
| XButton2             | 鼠标的第五个按钮。一般和 Browser_Forward 执行相同功能。      |
| Wheel                |                                                              |
| WheelDown            | 向下转动鼠标滚轮（向您的方向）。                             |
| WheelUp              | 向上转动鼠标滚轮（远离您的方向）。                           |
| WheelLeft WheelRight | [v1.0.48+]：向左或向右滚动。需要 Windows Vista 或更高版本。这可以用在某些（但并非所有）带第二个滚轮或支持左右滚动的鼠标热键。在某些情况下，必须通过鼠标的自带软件包控制这个功能。不论鼠标如何特殊，[Send](http://blog.csdn.net/primox/article/details/46877055) 和 [Click](http://blog.csdn.net/primox/article/details/46877055) 都能在支持它们的程序里水平滚动。 |

## 键盘

**注意: 字母和数字按键的名称和单个字母或数字相同. 例如: b 表示 "b" 键而 5 表示 "5" 键.**

| 概述                                                         |                                                              |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| CapsLock                                                     | 大小写锁定键                                                 |
| Space                                                        | 空格键                                                       |
| Tab                                                          | Tab 键                                                       |
| Enter (或 Return)                                            | 回车键                                                       |
| Escape (或 Esc)                                              | 退出键                                                       |
| Backspace (或 BS)                                            | 退格键                                                       |
| 光标控制                                                     |                                                              |
| ScrollLock                                                   | 滚动锁定键                                                   |
| Delete (或 Del)                                              | 删除键                                                       |
| Insert (或 Ins)                                              | 插入改写切换键                                               |
| Home                                                         | Home 键                                                      |
| End                                                          | End 键                                                       |
| PgUp                                                         | 向上翻页键                                                   |
| PgDn                                                         | 向下翻页键                                                   |
| Up                                                           | 向上方向键                                                   |
| Down                                                         | 向下方向键                                                   |
| Left                                                         | 向左方向键                                                   |
| Right                                                        | 向右方向键                                                   |
| Numpad                                                       |                                                              |
| **NumLock 开启**                                             | **NumLock 关闭**                                             |
| Numpad0                                                      | NumpadIns0 / 插入改写切换键                                  |
| Numpad1                                                      | NumpadEnd1 / End 键                                          |
| Numpad2                                                      | NumpadDown2 / 向下方向键                                     |
| Numpad3                                                      | NumpadPgDn3 / 向下翻页键                                     |
| Numpad4                                                      | NumpadLeft4 / 向左方向键                                     |
| Numpad5                                                      | NumpadClear5 / 通常什么都不做                                |
| Numpad6                                                      | NumpadRight6 / 向右方向键                                    |
| Numpad7                                                      | NumpadHome7 / Home 键                                        |
| Numpad8                                                      | NumpadUp8 / 向上方向键                                       |
| Numpad9                                                      | NumpadPgUp9 / 向上翻页键                                     |
| NumpadDot                                                    | NumpadDel十进制分隔符 / 删除键                               |
| NumpadDiv                                                    | NumpadDiv除                                                  |
| NumpadMult                                                   | NumpadMult乘                                                 |
| NumpadAdd                                                    | NumpadAdd加                                                  |
| NumpadSub                                                    | NumpadSub减                                                  |
| NumpadEnter                                                  | NumpadEnter回车键                                            |
| 功能                                                         |                                                              |
| F1 - F24                                                     | 在大多数键盘顶部的 12 个或更多的功能键。                     |
| 按键修饰符                                                   |                                                              |
| LWin                                                         | 左边的 Windows 徽标键。对应的热键前缀为 de><#de>。           |
| RWin                                                         | 右边的 Windows 徽标键。对应的热键前缀为 de>>#de>。 注意：与 Control/Alt/Shift 不同，没有一般的/中性的“Win”键，因为操作系统不支持。不过含 de>#de> 修饰符的热键可以被任何一个 Win 键触发。 |
| Control (或 Ctrl)                                            | Control 键。单独作为热键（de>Control::de>）时它在弹起时触发，不过如果加上颚化符前缀可以改变这种情况。对应的热键前缀为 de>^de>。 |
| Alt                                                          | Alt 键。单独作为热键（de>Alt::de>）时它在弹起时触发，不过如果加上颚化符前缀可以改变这种情况。对应的热键前缀为 de>!de>。 |
| Shift                                                        | Shift 键。单独作为热键（de>Shift::de>）时它在弹起时触发，不过如果加上颚化符前缀可以改变这种情况。对应的热键前缀为 de>+de>。 |
| LControl（或 LCtrl）                                         | 左 Control 键。对应的热键前缀为 de><^de>。                   |
| RControl（或 RCtrl）                                         | 右 Control 键。对应的热键前缀为 de>>^de>。                   |
| LShift                                                       | 左 Shift 键。对应的热键前缀为 de><+de>。                     |
| RShift                                                       | 右 Shift 键。对应的热键前缀为 de>>+de>。                     |
| LAlt                                                         | 左 Alt 键。对应的热键前缀为 de><!de>。                       |
| RAlt                                                         | 右 Alt 键。对应的热键前缀为 de>>!de>。 注意：如果您的键盘布局存在 AltGr 而不是 RAlt，那么您完全可以根据这里描述的那样通过 de><^>!de> 把它作为热键前缀使用。此外，de>LControl & RAlt::de> 可以把 AltGr 自身设置成热键。 |
| 多媒体                                                       |                                                              |
| Browser_Back                                                 | 后退                                                         |
| Browser_Forward                                              | 前进                                                         |
| Browser_Refresh                                              | 刷新                                                         |
| Browser_Stop                                                 | 停止                                                         |
| Browser_Search                                               | 搜索                                                         |
| Browser_Favorites                                            | 收藏夹                                                       |
| Browser_Home                                                 | 主页                                                         |
| Volume_Mute                                                  | 静音                                                         |
| Volume_Down                                                  | 调低音量                                                     |
| Volume_Up                                                    | 增加音量                                                     |
| Media_Next                                                   | 下一首                                                       |
| Media_Prev                                                   | 上一首                                                       |
| Media_Stop                                                   | 停止                                                         |
| Media_Play_Pause                                             | Play/Pause                                                   |
| Launch_Mail                                                  | 打开默认的电子邮件程序                                       |
| Launch_Media                                                 | 打开默认的媒体播放器                                         |
| Launch_App1                                                  | 打开我的电脑                                                 |
| Launch_App2                                                  | 打开计算器                                                   |
| **注：**上面列出的每个按键的功能可以通过修改 Windows 注册表进行替换。这个表格中显示的是在 Windows 系统的大多数版本中每个按键的默认功能。 |                                                              |
| 特别                                                         |                                                              |
| AppsKey                                                      | 菜单键。这是调用右键上下文菜单的按键。                       |
| PrintScreen                                                  | 捕获屏幕                                                     |
| CtrlBreak                                                    |                                                              |
| 暂停                                                         | 暂停键                                                       |
| 中断                                                         | 中断键。由于此键和 Pause 含义相同，所以在热键中请使用 de>^CtrlBreakde> 代替 de>^Pausede> 或 de>^Breakde>。 |
| 帮助                                                         | 帮助键。此键可能在大多数键盘上不存在。它通常和 F1 不同.      |
| Sleep                                                        | 休眠键。注意在一些键盘上的 sleep 键可能不是休眠功能。        |
| SC**nnn**                                                    | 请在 **nnn** 中指定按键的扫描码。识别上面没有提到的罕见的按键。请参阅特殊按键了解详情。 |
| VK**nn**                                                     | 请在 **nn** 中指定十六进制的虚拟按键码。这种极少用的方法还可以避免某些类型的热键需要安装键盘钩子。例如，后面的热键不使用键盘钩子，但副作用是它会在按下 Home 或 NumpadHome 的*其中一个*时触发：`^VK24::MsgBox You pressed Home or NumpadHome while holding down Control. `**已知限制**：强制使用键盘钩子的 VK 热键，例如 de>*VK24de> 或 de>~VK24de>，只会触发其中一个热键，而不会触发两者（例如触发 NumpadHome 但不触发 Home）。关于 VKnn 方法的更多细节，请参阅特殊按键。 |

相关资源：
