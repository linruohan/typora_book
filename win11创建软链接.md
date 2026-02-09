# 在 Windows 上创建符号链接（又名符号链接）的完整指南

------

想要轻松访问不同文件夹中的文件夹和文件而不维护重复副本吗？

### 0.1 要点

Windows 11 和 Windows 10 都支持符号链接（也称为符号链接），指向系统上的文件或文件夹。您可以使用命令提示符或称为 Link Shell Extension 的第三方工具来创建它们。

## 1 什么是符号链接？

符号链接基本上是高级快捷方式。创建指向单个文件或文件夹的符号链接，该链接在 Windows 中看起来与该文件或文件夹相同 — 即使它只是指向该文件或文件夹的链接。

例如，假设您有一个程序需要其文件位于 C:\Program。您确实希望将此目录存储在 D:\Stuff 中，但程序要求其文件位于 C:\Program 中。您可以将原始目录从  C:\Program 移动到 D:\Stuff，然后在 C:\Program 处创建指向 D:\Stuff  的符号链接。当您重新启动该程序时，它将尝试访问其位于 C:\Program 的目录。 Windows 会自动将其重定向到  D:\Stuff，一切都会像在 C:\Program 中一样工作。

这个技巧可以用于各种各样的事情，包括将任何文件夹与 Dropbox、Google Drive 和 OneDrive 等程序同步。

符号链接有两种类型：硬链接和软链接。

1. 软符号链接的工作方式与标准快捷方式类似。当您打开文件夹的软链接时，您将被重定向到存储文件的文件夹。

### 1.1 符号链接[#](https://www.cnblogs.com/czwy/p/18442267#符号链接)

符号链接是将自己链接到一个目标文件或目录的路径上。当系统识别到符号链接时，它会跳转到符号链接所指向的目标中去，而不改变此时的文件路径。
 [![image](https://img2024.cnblogs.com/blog/3056716/202409/3056716-20240930174641480-1524142002.png)](https://img2024.cnblogs.com/blog/3056716/202409/3056716-20240930174641480-1524142002.png)

符号链接从Vista开始得到支持，NTFS内置机制。适用于文件，目录。可以理解为另一种形式的快捷方式(shortcut)，文件大小为0字节和不占用空间。可以使用相对/绝对路径，可以跨盘符，跨主机，可以使用UNC路径和网络驱动器。

### 1.2 硬链接[#](https://www.cnblogs.com/czwy/p/18442267#硬链接)

硬链接和符号链接的原理完全不同，符号链接是指向目标路径的链接，而硬链接则是指向目标数据对象的链接。因为一个卷中的数据对象都有一个独一无二文件 ID，也可以说硬链接是指向目标文件 ID 的链接。
 [![image](https://img2024.cnblogs.com/blog/3056716/202409/3056716-20240930174659695-1107612036.png)](https://img2024.cnblogs.com/blog/3056716/202409/3056716-20240930174659695-1107612036.png)

硬链接从Windows NT4开始得到支持，是NTFS内置机制，FAT32不支持。只适用于文件，只能使用绝对路径。本身无文件，不占用额外空间。hardlink与targetfile必须位于同一卷，可以简单理解成不能跨盘符。

### 1.3 目录联接[#](https://www.cnblogs.com/czwy/p/18442267#目录联接)

目录联接从Windows2000/XP开始得到支持，是NTFS内置机制。只适用于目录。只能使用绝对路径。目录链接通过[重分析点](https://learn.microsoft.com/zh-cn/windows/win32/fileio/reparse-points)实现，目录链接可以跨卷，但是不能跨主机。



### 1.4 详细对比[#](https://www.cnblogs.com/czwy/p/18442267#详细对比)

几种链接方式详细比较如下表所示

|          | shortcut                                                     | hard link                                                    | junction point                                               | symbolic link                                                |
| -------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 创建方式 | 右键 -> 创建快捷方式                                         | mklink /H Link Target                                        | mklink /J Link Target                                        | mklink /D Link Target                                        |
| 存在方式 | 以.lnk文件方式存在，适用于Explorer等应用程序。非NTFS内置机制，从Win95开始得到支持。FAT32支持。 | NTFS内置机制，从Windows NT4开始得到支持。FAT32不支持。       | NTFS内置机制，从Windows2000/XP开始得到支持。是 NTFS 3.0 及以上文件系统（Windows 2000  及以上系统）的特性，它是链接本地目录（可跨卷）的访问点，通过交接点的操作都会被系统映射到实际的目录上。通过建立交接点，可以在保证一个目录实例（目录的一致性）的前提下，允许用户或程序从本地文件系统中的多个位置访问此目录。 | NTFS内置机制，从Vista开始得到支持。文件类型是.SYMLINK        |
| 适用范围 | 同时适用于文件、目录，只能使用绝对路径。                     | 只适用于文件，只能使用绝对路径。                             | 只适用于目录。只能使用绝对路径。即使创建junction point时使用了相对路径，保存到NTFS中时将隐式转换成绝对路径。 | 同时适用于文件、目录。这是一种超级shortcut，文件大小为0字节和不占用空间。 |
| 使用限制 | 可以跨盘符，可以跨主机，可以使用UNC路径、网络驱动器。        | hard link与targetfile必须位于同一volume，可以简单理解成不能跨盘符。 | junction point必须与target directory位于同一local computer，可以简单理解成不能跨主机, 在local computer范围内，可以跨盘符。不能使用UNC路径；假设Z是通过网络映射生成的盘符，同样不适用于Z。 | 可以使用相对、绝对路径。假设创建symbolic link时使用了相对路径，保存到NTFS中的就是相对路径，不会隐式转换成绝对路径。可以跨盘符，可以跨主机，可以使用UNC路径、网络驱动器。 |
| 移动能力 | 本身有文件，可以复制，移动等操作。                           | /                                                            | /                                                            | /                                                            |
| 文件     | 文件大小仅有几百字节, 跟原文件大小无关，文件类型是.lnk。     | 本身无文件，为文件创建多入口。由于不同的文件指向的是同样的数据，所以无论给同一个文件创建多少个硬链接，他们占整个卷的数据大小都是一样的。 | 对交接点内文件和子目录的“建立、删除、修改”等操作都被映射到对应的目录中的文件和子目录上，对交接点的“复制、粘贴、剪切、配置  ACL”，只会影响此交接点，在同一卷内移动交接点，只会影响此交接点，但在不同卷间移动交接点，会将此交接点转换为正常目录，并且交接点对应目录下的所有内容都会被移动。 | 符号链接（Symlink，Softlink）是对文件或目录的引用，实际上符号链接本身是一个“记录着所引用文件或目录的绝对或相对路径”的特殊文件，通过符号链接的操作都会被重定向到目标文件或目录。对符号链接和快捷方式的“读、写、遍历”等操作都会被重定向到目标文件或目录，但对它们的“复制、删除、移动、配置 ACL”等操作只针对自身。 |
| 关联     | 删除shortcut，不影响target。                                 | 在Explorer中删除hard link，不影响targetfile。删除target  file，不影响hardlink。事实上由于hard link的语义，此时剩下的hardlink就是原始数据的唯一访问点。只有当一个文件 ID  对应的所有硬链接被删除时，数据才真正被标记为删除。 | 删除target directory，junction point仍将存在，但失效了，变得不可用。这个很好理解，因为此时junction point指向不存在的目录。 | 在Explorer中删除symboliclink，不影响target。删除target，symboliclink仍将存在，但失效了，变得不可用。它们可以像普通文件一样操作，但所有对符号链接的操作都实际作用于目标对象。符号链接对用户而言是透明的，符号链接看上去和普通的文件和文件夹没有区别，操作方法也一模一样（更类似于 Linux 的软链接）。 |

## 2 链接的应用[#](https://www.cnblogs.com/czwy/p/18442267#链接的应用)

- 硬链接：可以在不复制文件的情况下，实现文件的快速访问以及文件的备份，还可以防止重要文件误删，因为删除的是文件的链接，而非文件数据本身。
- 符号链接：可以把一个路径映射到另一个路径，或者指向远程文件或目录，甚至可以通过网络连接到其他计算机上的文件。
- 目录联接：实现路径重定向，当访问链接目录时，系统会自动重定向到实际目录，例如：Vista的"C:\Documents and  Settings"是指向"C:\Users"的junctionpoint，这样一些使用了硬编码"C:\Documents and  Settings"的老程序可以在Vista上正常工作。此外，还可以解决Windows文件路径长度限制带来的问题（从 Windows 10 版本  1607 开始，可以通过设置注册表以及应用程序清单启用长路径）。

> 请注意，Windows 实际上并不使用术语“硬链接”和“软链接”。相反，它使用术语“硬链接”和“符号链接”。在 Windows 文档中，“符号链接”与“软链接”相同。但是，`mklink` 命令可以创建硬链接（在 Windows 中称为“硬链接”）和软链接（在 Windows 中称为“符号链接”）。

## 3 如何使用 mklink 创建符号链接

您可以以管理员或普通用户身份在命令提示符窗口中使用 mklink 命令创建符号链接。要在没有管理员命令提示符窗口的情况下执行此操作，您必须首先从“设置”>“更新和安全”>“针对开发人员”启用开发人员模式。

要以管理员身份打开命令提示符，请单击“开始”按钮，搜索“cmd”或“命令提示符”，然后选择“以管理员身份运行”。

Windows 11 不需要管理权限即可创建符号链接。

![img](https://cn.windows-office.net/common-images/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/launch-command-prompt.png)

无需任何额外选项，`mklink` 即可创建指向文件的符号链接。以下命令在 `Link` 处创建一个符号或“软”链接，指向文件 `Target` ：

```bash
# 符号链接 格式
mklink Link Target
```

当您想要创建指向目录的软链接时，请使用 /D。像这样：

```
mklink /D Link Target
mklink /D C:\software\SublimeText\Data D:\codehub\my-ST-my-settings
mklink /D "C:\Program Files\Typora\resources\plugin" D:\codehub\typora_plugin\plugin
mklink /D  "C:\Users\Administrator\.glzr" "D:\codehub\windots\.glzr"
mklink /D  C:\Users\Administrator\AppData\Roaming\alacritty 
mklink /D C:\Users\Administrator\AppData\Roaming\alacritty  D:\codehub\windots\AppData\Roaming\alacritty
mklink /D  %UserProfile%\omz  D:\codehub\windots\omz

mklink /D "%APPDATA%\Code" C:\software\VSCode\data\user-data
mklink /D  %UserProfile%\.vscode  C:\software\VSCode\data
mklink /D "%APPDATA%\yazi" D:\codehub\win10\yazi
mklink /D "C:\Users\Administrator\AppData\Local\nvim" D:\codehub\nvim-config
mklink /D "C:\Users\Administrator\.config\opencode" D:\codehub\skills\opencode
```

当您想要创建指向文件的硬链接时，请使用 /H：

```
mklink /H Link Target
```

使用 /J 创建指向目录的硬链接，也称为目录连接：

```
mklink /J Link Target
```

![img](https://cn.windows-office.net/common-images/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/img_585a0d3194149.png)

因此，例如，如果您想在“C:\LinkToFolder”处创建指向“C:\Users\Name\OriginalFolder”的目录连接（文件夹的硬链接），则可以运行以下命令：

```
mklink /J C:\LinkToFolder C:\Users\Name\OriginalFolder
```

您需要在带空格的路径两边加上引号。例如，如果文件夹被命名为“C:\Link To Folder”和“C:\Users\Name\Original Folder”，则您可以使用以下命令：

```
mklink /J "C:\Link To Folder" "C:\Users\Name\Original Folder"
```

![img](https://cn.windows-office.net/common-images/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/img_585a0d4f1fbf2.png)

如果您看到消息“您没有足够的权限来执行此操作。”，则需要在运行命令之前以管理员身份启动命令提示符。

## 4 如何使用图形工具创建符号链接

如果您想使用图形工具执行此操作，请下载 Link Shell Extension。请务必先下载适当的先决条件包，然后再下载工具本身 - 两者都链接到工具的下载页面。

Link Shell 扩展适用于 Windows 11，但您需要 点击“显示更多选项”  查看选项。您还可以使用 注册表破解以启用扩展的右键单击上下文菜单 。

安装后，找到要创建链接的文件或文件夹，右键单击它，然后在菜单中选择“选择链接源”。

![img](https://cn.windows-office.net/common-images/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/img_585a0ddd965a2.png)

然后，您可以在不同的文件夹内右键单击，指向“Drop As”菜单并选择“Hardlink”以创建到文件的硬链接，选择“Junction”以创建到目录的硬链接，或选择“Symbolic Link”创建到文件或目录的软链接。

![img](https://cn.windows-office.net/common-images/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/img_585a0e25b4155.png)

## 5 如何删除符号链接

要删除符号链接，您只需删除它，就像删除任何其他文件或目录一样。请小心删除链接本身而不是其链接到的文件或目录。

![img](https://cn.windows-office.net/common-images/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/img_585a0e926eb5c.png)

这是符号链接的主要优点 - 您可以随时自由删除符号链接，而不必担心关联的文件或文件夹。
