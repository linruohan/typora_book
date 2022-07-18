# markdown Editting快捷键使用说明

[toc]

## 文本格式

MarkdownEditing 支持通过以下方式格式化文本

- 自动配对相应的标记字符
- 特殊用途的键绑定

## 自动配对

MarkdownEditing 扩展了 ST 的自动配对功能。

- 星号 ( *)、反引号 ( `) 和下划线 ( _) 会自动配对并自动换行
- ~`~~`用（删除线）包裹选定的文本
- Backspace删除一个空对
- Space或Tab删除空星号或下划线对的右元素

此功能由全局`auto_match_enabled`设置控制。

## 键绑定

这些必然是粗体和斜体。他们在有选择和没有选择的情况下都可以工作。如果没有选择，他们只会转换光标下的单词。如果选择已经是粗体/斜体，这些键绑定将取消粗体/单斜体。

| 标记       | 渲染       | Linux/Windows | 苹果系统 |
| ---------- | ---------- | ------------- | -------- |
| **大胆的** | **大胆的** | Alt+B         | ⌘+ ⌥+B   |
| _斜体_     | *斜体*     | Alt+I         | ⌘+ ⌥+I   |
| ~~罢工~~   | ~~罢工~~   |               |          |
| `代码`     | `code`     |               |          |

# 标题

## 标题样式

### ATX风格

MarkdownEditing 通过保持关闭哈希平衡或自动删除它们来帮助维护所需的 ATX 标题样式。

*可以通过设置禁用此功能`"mde.auto_match_heading_hashes": false`。*

您可以通过命令面板在活动视图的打开和关闭标题样式之间切换：

- **MarkdownEditing：添加关闭标题哈希**
  集：`"mde.match_heading_hashes": true`并向所有标题添加关闭哈希。
- **MarkdownEditing：删除关闭标题哈希**
  集：`"mde.match_heading_hashes": false`并删除所有标题的关闭哈希。
- **MarkdownEditing: Fix Closing Heading Hashes**
  根据 的值添加或删除关闭哈希`"mde.match_heading_hashes"`而不修改它。

默认情况下，在加载或保存文件并存储在视图特定设置中时会检测到标题样式。

值`"mde.match_heading_hashes": false`表示*“开放式”*：

```
## ATX heading

Open style without closing hashes.
```

值`"mde.match_heading_hashes": true`表示*“封闭式”*：

```
## ATX heading ##

Closed style with closing hashes.
```

*可以通过禁用自动检测`"mde.detect_heading_style": false`。*

`"mde.match_heading_hashes"`在这种情况下，您可以通过用户首选项或项目特定设置手动强制执行样式。

### 文本样式

MarkdownEditing 有助于在输入过程中保持带下划线的标题的宽度。

只需Tab在`-`or之后点击`=`，下划线宽度将调整为标题文本长度。

[![标题-文本](https://github.com/SublimeText-Markdown/MarkdownEditing/raw/master/docs/img/headings-setext.png)](https://github.com/SublimeText-Markdown/MarkdownEditing/blob/master/docs/img/headings-setext.png)

所有标题都可以通过命令面板一次固定或转换：

- **MarkdownEditing：修复带下划线的标题**
  调整每个 setext 样式的标题以根据需要添加或删除`=`字符`-`以匹配其标题文本的长度。
- **MarkdownEditing：将带下划线的标题转换为 ATX**
  将每个 setext 样式的标题转换为 ATX 样式的标题。如果选择了某些内容，则只会转换选择中的标题，否则转换将应用于整个视图。

## 标题级别

可以通过将插入符号放置到所需的行并通过命令面板运行命令来修改标题级别：

- **MarkdownEditing：将标题转换为文本**
  删除所有哈希。
- **MarkdownEditing：设置标题级别 x**
  用哈希 替换任意数量的现有`x`哈希。
- **MarkdownEditing：增加标题级别**
  添加一个额外的哈希。
- **MarkdownEditing：降低标题级别**
  删除一个哈希。

或使用以下绑定之一：

| Linux/Windows    | 苹果系统     | 描述                  |
| ---------------- | ------------ | --------------------- |
| Alt+ k, Alt+0    | ^+ k, ^+0    | 将标题转换为普通文本  |
| Alt+ k, Alt+1..6 | ^+ k, ^+1..6 | 将标题级别设置为 1..6 |
| Shift+ Alt+,     | ⇧+ ^+,       | 将标题级别减少一级    |
| Shift+ Alt+.     | ⇧+ ^+.       | 将标题级别提高一级    |

可以通过禁用键绑定`"mde.keymap_disable.set_heading_level": true`。

`#`在行首添加或删除也会隐式修改标题级别，同时保持开放或封闭的标题样式。

### 约束

1. 无序列表不会转换为标题。

   ```
   * item
   * [ ] task
   ```

2. 所有功能都适用于多项选择。

3. 如果选择跨越多行，则会为每行单独创建一个标题。

## 折叠部分

可以通过命令面板折叠/折叠文档的不相关部分：

- **MarkdownEditing：切换折叠当前部分**
  子部分是否折叠或展开取决于通过调用以下命令之一定义的折叠级别。

  如果`Fold All Sections`之前调用过*（“大纲模式”处于活动状态）*，则当前和后续兄弟或子标题之间的区域仅（未）折叠。

  如果`Fold Level 1-6 Sections`之前调用过，所有具有较低级别的子部分在展开其父部分时保持折叠。

  如果`Unfold All Sections`之前调用过，则所有子部分都（未）折叠。

- **MarkdownEditing：折叠级别 1-6 部分**
  折叠特定级别标题的所有部分。还隐藏较低级别的标题。

- **MarkdownEditing：折叠所有部分**
  折叠任何级别的所有部分，但保持其标题可见。我们称之为“大纲模式”。

- **MarkdownEditing：展开所有部分**
  自我解释。

默认情况下，折叠绑定到以下键：

| Linux/Windows      | 苹果系统     | 描述                                   |
| ------------------ | ------------ | -------------------------------------- |
| Ctrl+ k, Ctrl+0    | ⌥+ k, ⌥+0    | 展开所有部分                           |
| Ctrl+ k, Ctrl+1..6 | ⌥+ k, ⌥+1..6 | 按级别折叠部分 1..6                    |
| Ctrl+ k, Ctrl+9    | ⌥+ k, ⌥+9    | 折叠所有部分，但保持任何级别的标题可见 |
| Shift+Tab          | ⇧+Tab        | 折叠/展开当前部分。                    |
| Ctrl+ Shift+Tab    | ^+ ⇧+Tab     | 折叠一定级别标题下的所有部分。         |

## 自动链接网址折叠

如果插入符号不在 url 括号内，MarkdownEditing 会自动折叠图像/链接/参考 url，以提高文档的可读性。

可以通过命令面板为活动视图临时启用或禁用此功能

- **MarkdownEditing：切换自动链接 URL 折叠**

要全局禁用它，请将以下设置添加到*Perferences.sublime-settings*

```
    "mde.auto_fold_link.enabled": false,
```

可以调整折叠选择器以添加或删除某些类型的 url，使其不被自动折叠。

```
    "mde.auto_fold_link.selector": "( meta.image | meta.link ) & ( markup.underline | constant.other) - meta.link.reference.footnote - meta.link.reference.def - meta.link.inet",
```

## 导航

MarkdownEditing 提供了多种在部分之间导航的方法。

标题通过列出

- 转到符号 ( Ctrl+ R)
- 项目中的转到符号 ( Ctrl+ Shift+ R)

相关命令通过命令面板公开：

- **MarkdownEditing：转到上一个/下一个标题（任何级别）**
  跳转到上一个或下一个标题
- **MarkdownEditing：转到上一个/下一个标题（相同或更高级别）**
  跳转到相同或更高级别的上一个或下一个标题

默认情况下，导航绑定到以下键：

| Linux/Windows                    | 苹果系统             | 描述                                  |
| -------------------------------- | -------------------- | ------------------------------------- |
| Ctrl+ Shift+PageUp/PageDown      | ⌘+ ⇧+PageUp/PageDown | 转到任何级别的上一个/下一个标题       |
| Ctrl+ Alt+ Shift+PageUp/PageDown | ⌘+ ⌥+PageUp/PageDown | 转到相同或更高级别的上一个/下一个标题 |

# 块报价

MarkdownEditing 创造了一种自然自然的块引用编辑体验。

1. 要将选定的文本转换为块引用，只需点击>.
2. 通过点击Enter一个新的空块引用行被添加。
3. 通过点击Del块引用行的末尾，通过删除其前导引号来合并以下行。
4. 引用的文本可以缩进 ( Tab) 和不缩进 ( Shift+ Tab)，因为它没有被引用。

更多可用的键绑定：

| Linux/Windows | 苹果系统    | 描述                                                         |
| ------------- | ----------- | ------------------------------------------------------------ |
| Ctrl+ Shift+. | ⌘+ ⇧+.      | 提高块报价水平（再增加一个`> `）                             |
| Ctrl+ Shift+, | ⌘+ ⇧+,      | 降低块引用级别（删除 a `> `）                                |
| Ctrl+Enter    | ⌘+Enterkbd> | 通过添加两个换行符来终止块引用。 如果当前行为空，则删除块引号。 |

# 列表和任务

默认情况下，缩进或取消缩进列表项时，列表项目符号会自动更改。可以通过禁用此行为`"mde.list_indent_auto_switch_bullet": false`。

如果设置，Markdown 可以支持保持列表项文本与选项卡宽度对齐`"mde.list_align_text": true`。

通过命令面板提供以下命令：

- **切换列表项目符号类型** 在编号和项目符号样式之间切换突出显示的列表。

以下键绑定可用于创建或切换任务。

| Linux/Windows | 苹果系统 | 描述                                  |
| ------------- | -------- | ------------------------------------- |
| Alt+t         | ⌘+ ⌥+t   | 创建新的 GFM 任务 ( `* [ ] task`)     |
| Alt+x         | ⌘+ ⌥+x   | 切换 GFM 任务复选标记 ( `* [x] task`) |

# 参考

通过命令面板提供以下命令：

- **添加缺少的链接标签**
  扫描文档以查找引用的链接用法（`[some link][some_ref]`和`[some link][]`）并检查它们是否都已定义。如果有未定义的链接引用，命令将自动在文件底部创建它们的定义片段。
- **魔术脚注命令**
  在光标下的单词后添加脚注。如果光标已经在脚注上，则跳转到其定义或引用。
- **收集缺失的脚注**
  为所有脚注引用添加定义存根（如果没有）。
- **跳转引用**
  在定义和引用之间跳转光标。
- **新参考**
  在光标下添加一个新链接。
- **新内**
  联链接 在光标下添加一个新的内联链接。
- **新**
  内嵌图像 在光标下添加一个新的内嵌图像。
- **新**
  图像 在光标下添加新图像。
- **新脚注**
  在光标下添加脚注。
- **删除参考**
  删除链接的定义和参考。
- **组织参考**
  对当前链接参考使用情况进行排序并提供报告。

重要功能默认绑定到以下键：

| Linux/Windows | 苹果系统  | 描述                                             |
| ------------- | --------- | ------------------------------------------------ |
| Ctrl+ Alt+V   | ⌘+ ⌥+V    | 创建或粘贴剪贴板的内容作为选定文本的内联链接。   |
| Ctrl+ Alt+R   | ⌘+ ⌥+R    | 创建或粘贴剪贴板的内容作为参考链接。             |
| Shift+ Win+K  | ⌘+ ⇧+K    | 在选定文本上创建或粘贴剪贴板的内容作为内嵌图像。 |
| Alt+ Shift+6  | ⌥+ ⇧+6    | 插入脚注。                                       |
| F12           | F12       | 跳转到参考/脚注定义。                            |
| Shift+F12     | Shift+F12 | 从定义跳转到引用。                               |

# 评论家标记

MarkdownEditing 通过突出显示评论家标记来支持文档审查，并允许通过键绑定添加评论家或接受和拒绝提议的更改。

## 审稿人

文档审阅者可以通过以下键绑定插入批评者或建议对单个单词或选择进行更改：

| Linux/Windows | 苹果系统        | 描述                                                 |
| ------------- | --------------- | ---------------------------------------------------- |
| Alt+ c, Alt+a | ⌘+ ⌥+ c, ⌘+ ⌥+a | 将所选内容插入或转换为`{++ addition ++}`.            |
| Alt+ c, Alt+c | ⌘+ ⌥+ c, ⌘+ ⌥+c | 将所选内容插入或转换为`{>> comment <<}`.             |
| Alt+ c, Alt+d | ⌘+ ⌥+ c, ⌘+ ⌥+d | 将单词或选择转换为`{-- deletion --}`.                |
| Alt+ c, Alt+h | ⌘+ ⌥+ c, ⌘+ ⌥+h | 将单词或选择转换为`{== highlight==}{>> comment <<}`. |
| Alt+ c, Alt+s | ⌘+ ⌥+ c, ⌘+ ⌥+s | 将单词或选择转换为`{~~ substitution ~> by ~~}`.      |

## 作者

一旦插入符号被移动到批评标记中，文档作者可以接受或拒绝具有以下键绑定的建议：

| Linux/Windows | 苹果系统       | 描述                         |
| ------------- | -------------- | ---------------------------- |
| Alt+Enter     | ⌘+ ⌥+Enter     | 接受批评并应用提议的更改。   |
| Alt+Backspace | ⌘+ ⌥+Backspace | 拒绝批评者并放弃提议的更改。 |

!!!注意“注意” `{>> comment <<}`并被`{== highlight==}`两个绑定删除。

# 维基

Wiki 链接是通过用双方括号将（wiki）词括起来来定义的，例如：

```
[[SampleWikiPage]]
```

用户可以`open`使用 sublime 命令创建 wiki 页面。这将在当前打开文件的目录（和子目录）中搜索具有匹配名称和降价扩展名的文件。例如，打开上一个 wiki 链接将查找并打开一个名为：

```
SampleWikiPage.md
```

请注意，如果 wiki 页面*尚不*存在，if 将使用与页面名称匹配的标题创建。但是，只有在用户保存文件时，才会在文件系统上实际创建文件。

用户`list back links`当然可以打开它们。反向链接是引用当前页面的页面。这允许将页面绑定到个人 wiki 中。一种常见的技术是定义*标记*wiki 页面并列出页面的任何标记作为对页面底部标记页面的引用，例如：

```
[[TagSyntax]] [[TagDev]] [[TagPython]]
```

这允许用户通过打开标签页面并列出所有反向链接来列出具有特定标签的所有页面。

还支持期刊 wiki 页面。期刊页面只是一个名称与当前日期匹配的 wiki 页面。

最后提供了打开*主页*的命令，主页只是一个名为`HomePage`.

| Linux/Windows | 苹果系统 | 描述                   |
| ------------- | -------- | ---------------------- |
| Ctrl+ Alt+H   | ⌘+ ⌥+H   | 打开主页               |
| Ctrl+ Alt+J   | ⌘+ ⌥+J   | 打开今天的期刊页面     |
| f12           | f12      | 在光标下打开 wiki 页面 |
| Shift+f12     | ⇧+f12    | 列出返回链接           |

*注意：默认情况下，通过首选项禁用键绑定，以防止与某些键盘布局发生冲突。*