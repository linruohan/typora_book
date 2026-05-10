# 30分钟手术：让Windows 终端秒变 macOS 现代终端

原创 HG0539xDC860539 

 *2026年4月10日 22:27* *山东* 5人

------

# 让Windows 终端秒变 macOS 现代终端

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/ibsibtc0Gxl3dvribdKqwX0xme1vzicsib01yT3q3cu5pnnP77AkrXLaQLxoTQhk3UjrdFTk6iaHQ9f5Iqfvc5BC42RCfC6n83KnYmY64LzaD0hxU/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=0)

## 1 0x00 效果如何

如果你用过 macOS 的 iTerm2，或者看过优化过的windows终端

![图片](https://mmbiz.qpic.cn/mmbiz_png/ibsibtc0Gxl3d2gGS9G6ic6K9LzgXicOicQQgMvUeDFFsJfY4yAUXfibZM808Q3UK7nvrwce9mTzyf9wZZ5qRgmw1m3HuQQ6nOgpuiaD8Mic3oZB304/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=1)然后你低头看了看自己的 Windows PowerShell

纯白背景，黑字，没有图标，没有高亮，没有智能补全。
仿佛时间停在了 2005 年。

**你想不想要一个同样美观、高效、信息密度拉满的现代终端？**

不需要装 Linux，不需要买 Mac，不需要任何编程基础。
30 分钟，Scoop 或 winget 一键安装，全程抄作业。

💡 **Scoop 和 winget 都是 Windows 包管理器。** winget 是 Windows 11 自带的（Windows 10 也可手动安装），开箱即用；Scoop 需要手动安装，但包更全、更新更快。本文两种方式都提供，推荐 Scoop。

**安装 Scoop**（普通用户身份打开 PowerShell）：



Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

安装完成后重启终端，`scoop` 命令即可使用。

## 2 0x01 第一步：Nerd Font——让终端认得图标

终端里那些文件夹图标 📁、Git 分支符号 🌿、对勾 ✅、箭头 ➜……
在你这里是方块或乱码？

因为你缺了一款「图标字体」。

**Nerd Font** 是为终端专门设计的字体族，内置数万个图标字形。几乎所有现代 CLI 工具（starship、lsd、lazygit……）的图标渲染都依赖它。不装，一切美化都是空中楼阁。

### 2.1 安装

**Scoop（推荐）：**



scoop install nerd-fonts/0xProto-NF

**手动下载：**

访问 Nerd Fonts 官网，搜索 `0xProto`，下载安装。

### 2.2 配置 Windows Terminal

打开 Windows Terminal → 设置 → 配置文件 → 默认值 → 外观 → 字体 → 选择 `0xProto Nerd Font` → 保存。

重启终端。图标显示正常，第一步完成。

💡 **0xProto** 是一款专为编程终端设计的等宽字体，字形清晰，图标兼容性好。如果你喜欢其他风格，也可以选 `CaskaydiaCove Nerd Font`（微软 Cascadia Code 的 Nerd Font 版）、`FiraCode Nerd Font` 或 `JetBrainsMono Nerd Font`。

## 3 0x02 第二步：Starship Prompt——换一套酷炫的命令行提示符

你每天盯着终端，看最多的就是那一行提示符。
默认的 `PS C:\Users\you>` 能告诉你什么？只有当前路径。
而 Starship 能让你一眼看到：当前目录、Git 分支和状态、语言运行时版本、命令耗时、错误码……

### 3.1 安装



\# Scoop
scoop install starship

\# winget
winget install Starship.Starship

### 3.2 配置 PowerShell

打开 PowerShell 配置文件：



notepad $PROFILE

如果提示文件不存在，先创建：



New-Item -Path $PROFILE -ItemType File -Force
notepad $PROFILE

在文件中添加这一行：



Invoke-Expression (&starship init powershell)

保存，重启终端。提示符已经变漂亮了。

### 3.3 三款推荐主题

Starship 内置几十款预设主题，一行命令切换。以下三款是我实测最适合暗色终端的：

**🍮 Catppuccin Powerline**

柔和暖色调，渐变 Powerline 箭头分段显示信息。色彩协调、信息层次清晰，长时间使用不疲劳。**最推荐的主题。**



starship preset catppuccin-powerline -o ~/.config/starship.toml

**🌈 Gruvbox Rainbow**

复古暖色系，彩虹渐变效果，辨识度极高。适合喜欢张扬风格的终端玩家。



starship preset gruvbox-rainbow -o ~/.config/starship.toml

**🌃 Tokyo Night**

紫蓝色调，高对比护眼。喜欢冷色系的话可以选这个。



starship preset tokyo-night -o ~/.config/starship.toml

💡 **选不出？直接用 Catppuccin Powerline。** 不踩雷，不后悔。

切换主题后重启终端即可生效。配置文件在 `~/.config/starship.toml`，可以手动微调每个模块的颜色和显示逻辑。

![图片](https://mmbiz.qpic.cn/mmbiz_png/ibsibtc0Gxl3dm1MliayF7RjOLMlr0LtOkAPib9aT3VDY1gUbEibnib8ISNXV4bBjRdASL8LgmotY7EovjcGyhIGShRTR8Xx5sV2MoiaJ5QiaaLmshc/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=2)



📷 starship-catppuccin.png —— Catppuccin Powerline 主题效果

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/ibsibtc0Gxl3fhmcXomLT1BhAqVAhOSEryeTsbXL1PQEicFhKh7EaQsKHTqeRDJ49Hlyjbxvfn8icxEfUUHgZIJoIV2DuHtMNY03anQ7SAJoOCw/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=3)



📷 starship-tokyo-night.png —— Tokyo Night 主题效果

![图片](https://mmbiz.qpic.cn/mmbiz_png/ibsibtc0Gxl3dEv8gXmeGju43bicMkKO5s8TRmB3xSApgicibbbM3dfQHJR6LcCwRJSicwKdRly9sT6G782Ilp2o03TbAtAulB5LaSYLFoMQBU2N4/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=4)



📷 starship-gruvbox.png —— Gruvbox Rainbow 主题效果

## 4 0x03 第三步：CLI 工具全家桶——先认识再装备

### 4.1 全家桶总览

这一步我们要装 17 个工具，按功能分成 5 大类。先看全局地图，再逐个深入。



🖥️ Windows 终端 CLI 工具全家桶
│
├── **🎨 外观与交互层（好看、好用）**
│  ├── starship  ── 命令行提示符
│  └── lsd    ── 彩色文件列表
│
├── 🚀 **导航与搜索层（文件和目录）**
│  ├── zoxide  ── 智能目录跳转
│  ├── fzf    ── 模糊搜索神器
│  └── fd    ── 快速文件查找
│
├── 📖 **查看与阅读层（内容一目了然）**
│  ├── bat    ── 语法高亮的 cat
│  ├── ripgrep  ── 超高速文本搜索
│  ├── jq    ── JSON 处理器
│  ├── jd    ── JSON Diff
│  ├── tldr   ── 简化版命令手册
│  └── yazi   ── 终端文件管理器
│
├── 🛠️ **处理与转换层（多媒体和压缩包）**
│  ├── ffmpeg  ── 音视频处理）
│  ├── ImageMagick ── 图片处理
│  ├── poppler  ── PDF 工具集
│  ├── resvg   ── SVG 渲染
│  └── 7zip   ── 压缩解压
│
└── 🔧 **基础设施层（核心能力）**
  ├── coreutils ── GNU 核心工具
  └── lazygit  ── Git 可视化界面

**一句话总结**：外观层让你赏心悦目，导航层让你指哪打哪，查看层让你信息通透，处理层让你能打能扛，基础层让 Windows 终端不再缺胳膊少腿。

💡 这 17 个工具中，`yazi` 的 PDF 预览依赖 `poppler`，SVG 预览依赖 `resvg`，图片/视频预览依赖 `ffmpeg` + `ImageMagick`。所以它们不是独立的——装 yazi 的时候顺带把预览依赖一起装上，体验才完整。

### 4.2 一键安装

**Scoop（推荐，版本更新快）：**



\# 外观与交互
scoop install starship lsd

\# 导航与搜索
scoop install zoxide fzf fd

\# 查看与阅读
scoop install bat ripgrep jq jd tldr yazi

\# 处理与转换
scoop install ffmpeg imagemagick poppler resvg 7zip

\# 基础设施
scoop install coreutils lazygit

**winget：**



winget install Starship.Starship sxyazi.yazi Gyan.FFmpeg 7zip.7zip jqlang.jq oschwartz10612.Poppler sharkdp.fd BurntSushi.ripgrep.MSVC junegunn.fzf ajeetdsouza.zoxide ImageMagick.ImageMagick sharkdp.bat tldr-pages.tlrc uutils.coreutils

⚠️ winget 缺少的包建议用 Scoop 补装，或者去 GitHub Releases 手动下载。

------

下面按 5 大分类逐个详细拆解。每个工具讲清楚：**它是什么、替代了什么、为什么用它、怎么装、基本用法、实战场景。**

## 5 0x03_01 🎨 第一层：外观与交互

### 5.1 📁 lsd —— 彩色文件列表

**替代**：`ls` / `dir`

**它是什么**：Rust 写的现代 `ls` 替代品。彩色图标区分文件类型，Git 状态直接标注在文件名旁边（修改、新增、未追踪一目了然），支持树形视图。

**为什么用它**：Windows 的 `dir` 和 PowerShell 的 `Get-ChildItem` 输出是纯文本，没有颜色、没有图标、没有 Git 状态。`lsd` 让你一眼看出哪些文件被改过、哪些是目录、哪些是可执行文件。

**安装**：



\# Scoop
scoop install lsd

**基本用法**：



lsd        # 彩色文件列表（带图标）
lsd -la      # 显示隐藏文件 + 详细信息
lsd --tree    # 树形目录结构
lsd --tree -L 2  # 树形结构，只展开 2 层

**效果对比**：



\# PowerShell 默认
  Directory: C:\projects
Mode         LastWriteTime     Length Name
----         -------------     ------ ----
d-----     2026/4/10   10:30         src
-a----     2026/4/10   09:15      2048 main.py
-a----     2026/4/9   18:00       512 README.md

\# lsd
📁 src
📄 main.py
📄 README.md

**配置别名**（添加到 `$PROFILE`）：



Set-Alias -Name ls -Value lsd -Option AllScope -Force



![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/ibsibtc0Gxl3dpVXr8gxfvxyzdcc1CrnfSKH0bWSmjxAJAN3yL0mVN0qeF4VbXoKeteYhPUtic99OFLKbJIz4RibxJXuq1EG8EhJ25rs92ez0nQ/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=5)



📷 lsd-tree.png —— lsd 树形输出效果

## 6 0x03_02 🚀 第二层：导航与搜索

### 6.1 ⚡ zoxide —— 智能目录跳转

**替代**：`cd`

**它是什么**：Rust 写的智能 `cd` 替代品。它会记住你访问过的目录和使用频率，用 `z` 命令 + 关键词模糊匹配，直接跳转。用得越久越精准。

**为什么用它**：不再需要一层层 `cd` 或者复制粘贴长路径。输入 `z proj` 直接跳到 `C:\Users\you\Documents\projects`。

**安装**：



\# Scoop
scoop install zoxide

\# winget
winget install ajeetdsouza.zoxide

**配置 PowerShell**（添加到 `$PROFILE`）：



Invoke-Expression (& { (zoxide init powershell | Out-String) })

保存后重启终端，`z` 命令就可用了。

**基本用法**：



z proj     # 跳转到最近访问的、路径包含 "proj" 的目录
z doc down   # 跳转到路径同时包含 "doc" 和 "down" 的目录
z -l proj   # 列出所有匹配 "proj" 的目录（不跳转）

💡 **zoxide 需要积累数据。** 刚装好的时候它什么都不认识——你先用 `cd` 正常访问几次目录，zoxide 会在后台记录。访问越频繁的目录，`z` 命令的匹配优先级越高。一般用一两天后，体验就会非常流畅。

------

### 6.2 🔍 fzf —— 模糊搜索神器

**它是什么**：Go 写的通用模糊搜索器。可以从文件列表、命令历史、进程列表等任何文本流中进行交互式模糊搜索。

**为什么用它**：配合 `Ctrl+R` 模糊搜索命令历史，比 PowerShell 自带的历史搜索好用十倍。还可以配合 `fd` 搜索文件、配合 `ps` 搜索进程，几乎所有文本列表都能用 fzf 交互式筛选。

**安装**：



\# Scoop
scoop install fzf

\# winget
winget install junegunn.fzf

**基本用法**：



fzf        # 从当前目录所有文件中模糊搜索
history | fzf    # 从命令历史中搜索
fd . | fzf     # 从 fd 搜索结果中选择文件

**常用场景**：



\# 搜索文件并打开
fd | fzf | ForEach-Object { code $_ }

\# 搜索进程并杀死
ps | fzf | ForEach-Object { Stop-Process -Id $_.Id }

⚠️ fzf 的 `Ctrl+R` 快捷键集成在 PowerShell 中需要 PSReadLine 配置，不同环境配置方式不同，建议根据实际环境查阅 fzf 官方文档配置。

------

### 6.3 📂 fd —— 简洁的文件搜索

**替代**：`find` / `Get-ChildItem -Recurse`

**它是什么**：Rust 写的文件查找工具。语法比 `find` 简洁得多，默认忽略 `.gitignore`，彩色输出，自动区分文件和目录。

**为什么用它**：找文件不再需要写复杂的 `find` 参数。正则表达式友好，速度快，输出美观。

**安装**：



\# Scoop
scoop install fd

\# winget
winget install sharkdp.fd

**基本用法**：



fd "\.py$"        # 查找所有 .py 文件
fd "config"       # 查找文件名包含 "config" 的文件
fd -e js -e ts      # 查找 .js 或 .ts 文件
fd -d 3         # 只搜索 3 层深度
fd -t d "src"      # 只搜索目录（-t f 搜索文件）
fd -H "hidden"      # 包含隐藏文件搜索
fd --changed-within 1d  # 最近一天修改过的文件

**实战场景**：



\# 找项目中所有图片
fd -e png -e jpg -e svg

\# 找最近 7 天修改过的配置文件
fd -e json -e yaml -e toml --changed-within 7d

\# 找并删除所有 .log 文件
fd -e log -X rm

## 7 0x03_03 📖 第三层：查看与阅读

### 7.1 🦇 bat —— 语法高亮的 cat

**替代**：`cat` / `Get-Content`

**它是什么**：Rust 写的文件查看工具，自动检测语言类型并应用语法高亮，支持行号显示、Git 变更标注、非打印字符可视化。

**为什么用它**：看代码不再是纯白文本。配合语法高亮，代码结构、注释、字符串、关键字一目了然。比在编辑器里打开文件快得多。

**安装**：



\# Scoop
scoop install bat

\# winget
winget install sharkdp.bat

**基本用法**：



bat main.py        # 语法高亮显示，自动检测语言
bat -A script.sh     # 显示 Tab、换行等不可见字符
bat -n main.py      # 只显示行号（无其他 UI）
bat -l json data.json   # 指定语言为 JSON 高亮
bat --theme=GitHub main.py  # 切换高亮主题

**配合管道使用**：



echo '{"name":"test"}' | bat -l json   # JSON 格式化 + 高亮
curl -s api.example.com | bat -l json  # API 响应直接高亮
kubectl logs pod-name | bat -l yaml   # K8s 日志高亮

**配置别名**（添加到 `$PROFILE`）：



Set-Alias -Name cat -Value bat

![图片](https://mmbiz.qpic.cn/mmbiz_png/ibsibtc0Gxl3eqGDGsM7Tic3ofQNQiaicibAH1MSBp3geMAIkVIrKftyaDibqLicpoNpFKicWNdthayJ6FWjgeic8mf2Agr8hJjPdDDGWmjbnQFyiacfYM/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=6)



📷 bat-highlight.png —— bat 语法高亮效果

------

### 7.2 🔎 ripgrep（rg）—— 搜索界的闪电

**替代**：`grep` / `Select-String` / Windows 搜索

**它是什么**：Rust 写的递归正则搜索引擎。默认忽略 `.gitignore` 中的文件，不搜索二进制文件，支持按文件类型过滤。速度比传统 `grep` 快数十倍。

**为什么用它**：大项目中搜索字符串，ripgrep 秒出结果。Windows 自带搜索和 PowerShell 的 `Select-String` 在面对几十 GB 的代码库时，差距非常明显。

**安装**：



\# Scoop
scoop install ripgrep

\# winget
winget install BurntSushi.ripgrep.MSVC

**基本用法**：



rg "TODO"           # 在当前目录递归搜索 "TODO"
rg -i "error"         # 忽略大小写搜索
rg "Error" src/        # 只在 src 目录下搜索
rg --type py "class"     # 只在 Python 文件中搜索
rg -A 3 -B 3 "pattern"    # 显示匹配行前后各 3 行
rg --stats "Error"      # 搜索完成后显示统计信息
rg -l "TODO"         # 只列出包含匹配的文件名

**实战场景**：



\# 找项目中所有 TODO 注释
rg "TODO|FIXME|HACK" --type-add 'web:*.{js,ts,jsx,tsx,vue}' -t web

\# 找某个端口号在哪些文件中出现
rg ":8080"

\# 搜索并统计匹配数
rg "import.*React" --count

------

### 7.3 🔧 jq —— JSON 处理瑞士军刀

**它是什么**：命令行 JSON 处理器。格式化、过滤、提取字段、聚合计算，一句话搞定。

**为什么用它**：AI 工具的输出大量是 JSON（API 响应、配置文件、日志）。`jq` 能让你在终端里直接解析和查询 JSON，不用复制到浏览器或编辑器里。

**安装**：



\# Scoop
scoop install jq

\# winget
winget install jqlang.jq

**基本用法**：



\# 格式化（美化输出）
echo '{"name":"test","version":"1.0"}' | jq .

\# 提取字段
curl -s api.github.com/users/octocat | jq '.name'

\# 过滤数据
cat data.json | jq '.users[] | select(.age > 30)'

\# 提取所有 key
cat config.json | jq 'keys'

\# 统计数组长度
cat package.json | jq '.dependencies | keys | length'

\# 数组排序
cat data.json | jq '.items | sort_by(.price) | reverse | .[0:5]'

**实战场景**：



\# 从 API 响应中提取所有 URL
curl -s api.example.com/endpoints | jq '.[].url'

\# 对比两个 JSON 文件的某个字段
jd diff a.json b.json   # 需要 jd 工具（见下文）

------

### 7.4 📊 jd —— JSON Diff

**它是什么**：Rust 写的 JSON 对比工具。两个 JSON 文件之间的差异高亮显示，比 `diff` 对 JSON 更友好。

**安装**：



\# Scoop
scoop install jd

**基本用法**：



jd a.json b.json        # 对比两个文件
echo '{"a":1}' | jd -     # 从 stdin 读取对比
jd -set a.json b.json     # 按集合模式对比（忽略顺序）
jd -color b.json a.json    # 指定颜色方案

**实战场景**：



\# 对比 API 修改前后的响应
jd response_before.json response_after.json

\# 对比两个配置文件
jd config_dev.json config_prod.json

------

### 7.5 📖 tldr —— 简化版命令帮助

**替代**：`man` / `--help`

**它是什么**：社区维护的简化版命令手册。不给你看几页长的完整文档，只列最常用的几个用法示例。遇到忘了怎么用的命令，`tldr tar` 比 `tar --help` 有效一百倍。

**安装**：



\# Scoop
scoop install tldr

\# winget
winget install tldr-pages.tlrc

**基本用法**：



tldr tar      # tar 的常用用法
tldr ffmpeg     # ffmpeg 的常用用法
tldr git rebase   # git rebase 的常用用法
tldr --update    # 更新本地缓存

**效果示例**：



tldr tar

 tar - 归档工具

 \- 创建归档：
  tar cf target.tar file1 file2 file3

 \- 创建 gzip 压缩归档：
  tar czf target.tar.gz file1 file2 file3

 \- 解压归档：
  tar xf source.tar[.gz|.bz2|.xz]

 \- 列出归档内容：
  tar tf source.tar

------

### 7.6 🐿️ yazi —— 终端文件管理器

**替代**：Windows 资源管理器（在终端内使用）

**它是什么**：Rust 写的终端文件管理器，支持图片、视频、PDF、SVG、压缩包的即时预览。Vim 风格键位，鼠标也可操作。

**为什么用它**：不用离开终端就能浏览文件、预览内容、批量操作。配合 Claude Code 等 AI 工具时，AI 让你"看一下某个文件"，直接在 yazi 里打开预览，不用切换窗口。

**安装**：



\# Scoop
scoop install yazi

**预览依赖**（让 yazi 能预览各种文件格式）：



scoop install ffmpeg poppler resvg imagemagick 7zip

\- `ffmpeg` → 视频/音频缩略图
\- `poppler` → PDF 预览
\- `resvg` → SVG 渲染
\- `ImageMagick` → 图片格式转换
\- `7zip` → 压缩包预览

**基本用法**：



yazi   # 在当前目录启动
yazi .  # 同上
yazi C:\projects  # 打开指定目录

**常用快捷键**（Vim 风格）：

| 按键      | 功能                     |
| :-------- | :----------------------- |
| `h/j/k/l` | 上/下/左/右              |
| `Enter`   | 进入目录/打开文件        |
| `q`       | 退出 yazi                |
| `y`       | 复制（yank）             |
| `x`       | 剪切                     |
| `p`       | 粘贴                     |
| `d`       | 删除                     |
| `a`       | 新建文件/目录            |
| `r`       | 重命名                   |
| `/`       | 搜索                     |
| `z`       | 跳跃（使用 zoxide 记录） |

⚠️ yazi 在 Windows 上需要 Windows Terminal 才能正常显示图片预览。CMD 和旧版 PowerShell 不支持。

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/ibsibtc0Gxl3dzQK9opk2zXQ9nC6ZCvfnm7Ra0nFryZIOkC5USnz2Qrkrua8puJanCjeQgrdoVuLV8RB5fwHCicp4uETIddcKe2LYqpQ8OMTQ8/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=7)



📷 yazi-preview.png —— yazi 文件预览效果

## 8 0x03_04 🛠️ 第四层：处理与转换

### 8.1 🗜️ ffmpeg —— 多媒体处理瑞士军刀

**它是什么**：命令行音视频处理工具。格式转换、裁剪、合并、提取音频、生成 GIF……几乎你能想到的音视频操作它都能做。

**安装**：



\# Scoop
scoop install ffmpeg

\# winget
winget install Gyan.FFmpeg

**基本用法**：



\# 视频转 GIF
ffmpeg -i input.mp4 -vf "fps=15,scale=640:-1" output.gif

\# 提取音频
ffmpeg -i input.mp4 -vn -acodec copy output.mp3

\# 视频裁剪（从第 10 秒开始，持续 30 秒）
ffmpeg -i input.mp4 -ss 00:00:10 -t 00:00:30 -c copy output.mp4

\# 压缩视频
ffmpeg -i input.mp4 -crf 28 output.mp4

\# 合并视频
ffmpeg -f concat -i list.txt -c copy output.mp4

------

### 8.2 🎨 ImageMagick —— 图片处理

**它是什么**：最强大的命令行图片处理工具。格式转换、缩放、裁剪、加水印、批量处理。

**安装**：



\# Scoop
scoop install imagemagick

\# winget
winget install ImageMagick.ImageMagick

**基本用法**：



magick input.png output.webp      # 格式转换
magick input.png -resize 800x600 output.png  # 缩放
magick input.png -quality 85 output.jpg   # 压缩
magick *.png -resize 50% thumbnail_%d.png   # 批量缩放

------

### 8.3 📄 poppler —— PDF 处理

**它是什么**：PDF 渲染库的命令行工具集。提供 `pdftotext`（PDF 转文本）、`pdfinfo`（PDF 信息查看）等工具。yazi 的 PDF 预览依赖它。

**安装**：



\# Scoop
scoop install poppler

\# winget
winget install oschwartz10612.Poppler

**基本用法**：



pdftotext input.pdf output.txt   # PDF 转文本
pdfinfo input.pdf         # 查看 PDF 信息（页数、大小等）
pdftoppm input.pdf output -png   # PDF 转图片

------

### 8.4 🖼️ resvg —— SVG 渲染

**它是什么**：Rust 写的高性能 SVG 渲染器。yazi 的 SVG 预览依赖它。

**安装**：



\# Scoop
scoop install resvg

------

### 8.5 📦 7zip —— 压缩解压

**它是什么**：支持几乎所有压缩格式的命令行压缩工具。zip、7z、rar、tar.gz……

**安装**：



\# Scoop
scoop install 7zip

\# winget
winget install 7zip.7zip

**基本用法**：



7z a archive.7z folder/      # 压缩
7z x archive.7z          # 解压（保持目录结构）
7z l archive.7z          # 列出压缩包内容
7z a -mx=9 archive.7z folder/   # 最高压缩率

------

## 9 0x03_05🔧 第五层：基础设施

### 9.1 📦 coreutils —— GNU 核心工具集

**它是什么**：将 Linux 的核心命令（`cp`、`mv`、`ls`、`head`、`tail`、`wc`、`sort`、`uniq`、`du` 等）移植到 Windows。PowerShell 有自己的命令，但参数语法不同；装了 coreutils 就能用标准的 GNU 语法。

**安装**：



\# Scoop
scoop install coreutils

\# winget
winget install uutils.coreutils

**基本用法**：



wc -l file.txt      # 统计行数
head -n 20 file.txt   # 查看前 20 行
tail -f log.txt     # 实时追踪日志
sort file.txt | uniq   # 排序去重
du -sh *         # 查看目录大小

------

### 9.2 🎋 lazygit —— Git 可视化界面

**它是什么**：Go 写的终端 Git UI。暂存、提交、推送、变基、解决冲突，全部用键盘操作，界面实时显示仓库状态。

**为什么用它**：`git rebase -i` 的交互式编辑器、`git stash` 的管理、复杂分支切换……这些操作命令行参数容易记混，lazygit 按 `?` 就能看所有快捷键。

**安装**：



\# Scoop
scoop install lazygit

**基本用法**：



lazygit   # 在 Git 仓库目录下启动

**核心快捷键**：

| 按键    | 功能                     |
| :------ | :----------------------- |
| `Space` | 暂存/取消暂存文件        |
| `c`     | 提交（commit）           |
| `P`     | 推送（push）             |
| `p`     | 拉取（pull）             |
| `?`     | 显示帮助                 |
| `3`     | 切换到 stash 面板        |
| `4`     | 切换到最近提交（reflog） |
| `b`     | 分支管理                 |
| `r`     | 变基（rebase）           |

![图片](https://mmbiz.qpic.cn/sz_mmbiz_png/ibsibtc0Gxl3feLAutXpnFbv3aic5PRh7J3icX0qIkmRJv3J5dIqYPnEFCUeTWlTfr3c492B9jMxuvpiaW33yUibEGDl74fnkFUMxAGNF7kYm4unU/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=8)



📷 lazygit-ui.png —— lazygit 界面

## 10 0x04 第四步：PowerShell 配置——让所有工具联动

以上工具装完后，需要统一配置 PowerShell 才能发挥作用。
以下配置写入 `$PROFILE` 文件（`notepad $PROFILE`）：



\# ============================================
\# Starship Prompt
\# ============================================
Invoke-Expression (&starship init powershell)

\# ============================================
\# zoxide 智能跳转
\# ============================================
\# 安装后添加此行，z 命令才可用
Invoke-Expression (& { (zoxide init powershell | Out-String) })

\# ============================================
\# 别名配置
\# ============================================
\# lsd 替代 ls —— 彩色文件列表
Set-Alias -Name ls -Value lsd -Option AllScope -Force



\# bat 替代 cat —— 语法高亮
Set-Alias -Name cat -Value bat -Option AllScope -Force

### 10.1 配置说明

**`zoxide` 的 `z` 命令**：

`Invoke-Expression (& { (zoxide init powershell | Out-String) })` 这行的作用是向 PowerShell 注册一个名为 `z` 的函数。每次你用 `cd` 切换目录时，zoxide 会在后台记录路径和使用频率。之后输入 `z 关键词` 就能模糊匹配跳转。

刚装好时没有历史数据，`z` 命令匹配不到任何目录。正常用 `cd` 访问几天后，zoxide 积累了足够的访问记录，`z` 命令就会非常精准。

**`lsd` 的别名**：

`Set-Alias  -Name  ls  -Value lsd -Option AllScope -Fo` 会把 PowerShell 内置的 `ls`（实际是 `Get-ChildItem` 的别名）覆盖为 `lsd`。如果你偶尔需要用回原版 `ls`，可以用 `Get-ChildItem` 直接调用。

**`bat` 的别名**：

同理，`Set-Alias -Name cat -Value bat -Option AllScope -Force` 覆盖了 PowerShell 的 `cat`（`Get-Content` 的别名）。需要原版时用 `Get-Content`。

💡 **配置文件用 Git 管理**：`$PROFILE` 的路径一般是 `C:\Users\你的用户名\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`。建议用 Git 仓库管理起来，换电脑时直接克隆恢复。

------

## 11 0x05 实战场景：当现代终端遇到命令行 AI

环境搭好后，日常和 Claude Code、GitHub Copilot CLI 等 AI 工具协作时，体验会有质的飞跃：

![图片](https://mmbiz.qpic.cn/mmbiz_png/ibsibtc0Gxl3f5GqsAYSjSfT0iaGjNT3vnVnq15MpWAn67oic4P6ibjibcRXuv4JjcTc8ibuReZdBHXekY0Y9ecfoqFc3gv5TZXFcKmI2UTJ29UOUk/640?wx_fmt=png&from=appmsg&tp=wxpic&wxfrom=5&wx_lazy=1#imgIndex=9)

**AI 让你跳到某个目录改文件**



\# 以前
cd C:\Users\you\Documents\projects\myapp\src\components

\# 现在
z myapp

**AI 输出了一段 JSON 配置**



echo '{"name":"test","version":"1.0","deps":["react","vue"]}' | jq . | bat -l json

**AI 建议你搜索项目里的某个报错**



rg "TypeError" --stats

**AI 让你看一下项目结构**



lsd --tree -L 2

**AI 生成了 Git 操作指令，但你更想可视化操作**



lazygit

**AI 让你找某个文件但忘了完整路径**



fd | fzf

每个场景都比以前少敲几秒、少出错几次。积少成多，一天下来能省出不少时间。

## 12 0x06 参考资源

\- 少数派《现代Unix命令行工具革命：30个必备替代品完整指南》
\- Nerd Fonts 官网
\- Starship 官方文档
\- yazi 官方文档
\- lazygit 官方文档

## 13 0x07 写在最后

终端的复兴不是偶然。Claude Code、GitHub Copilot CLI、Cursor 的 Agent 模式……命令行正重新成为开发者与 AI 协作的最高效界面。

但一个丑陋、低效的终端，会成为你和 AI 之间的瓶颈——AI 生成的彩色输出你看到的是乱码，AI 建议的命令你找不到文件，AI 让你改的代码你看不出结构。

30 分钟，17 个工具，从零打造一个信息密度拉满、赏心悦目的现代 Windows 终端。
命令行 AI 时代，你的终端准备好了吗？

------

阅读 1.5万

修改于2026年4月13日
## 14 bash 命令自动补全
https://github.com/akinomyoga/ble.sh
```bash
需要 Bash 3.0+ 和基础的 POSIX 工具。
**下载ble-0.4.0-devel3.tar.xz**
wget https://github.com/akinomyoga/ble.sh/releases/download/v0.4.0-devel3/ble-0.4.0-devel3.tar.xz
# DOWNLOAD with curl
curl -LO https://github.com/akinomyoga/ble.sh/releases/download/v0.4.0-devel3/ble-0.4.0-devel3.tar.xz
```

**试用与安装**

```shell
tar xJf ble-0.4.0-devel3.tar.xz -C ~/.local/share/blesh
echo 'source ~/.local/share/blesh' >> ~/.bashrc

# INSTALL (more robust)
tar xJf ble-0.4.0-devel3.tar.xz -C ~/.local/share/blesh
# Add the following line near the top of ~/.bashrc
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --attach=none
# Add the following line at the end of ~/.bashrc
[[ ${BLE_VERSION-} ]] && ble-attach
```



<iframe src="https://wxa.wxs.qq.com/tmpl/pn/base_tmpl.html" class="iframe_ad_container iframe_adv_ad_container" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); margin: 0px; padding: 0px; outline: 0px; width: 677px; height: 200px; border: none; box-sizing: border-box; display: block; left: 0px;"></iframe>

**留言 76**

写留言



- ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月14日

  

  

  赞3

  

  一键部署脚本在这里，git clone https://github.com/HG0539xDC860539/windows-terminal-setup.git （Windows 默认禁止运行 PowerShell 脚本，需要先用户身份执行Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser）

  置顶作者赞过

- ![img](https://wx.qlogo.cn/mmopen/5aBaYL2JbuoXibolp4M7sdAjIRiauLgqsRRB29bZib0c6NnT6I3ElOaXibddJ7uOSicAfjNAib9XiaE3wutlwGIPPIyKMZ243MpfKwiaKUoxkP2rriarBJqU5bHqyNT6Kfoea2f9u/64)

  404超时

  广东4月12日

  

  

  赞5

  

  巧了，外表是最无关紧要的东西，shell性能才是。powershell太重太慢了

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  哈哈哈 windows下用clade code的人还是挺多的

  ![img](https://wx.qlogo.cn/mmopen/5aBaYL2JbuoXibolp4M7sdAjIRiauLgqsRRB29bZib0c6NnT6I3ElOaXibddJ7uOSicAfjNAib9XiaE3wutlwGIPPIyKMZ243MpfKwiaKUoxkP2rriarBJqU5bHqyNT6Kfoea2f9u/64)

  404超时

  广东4月13日

  

  

  赞1

  

  回复 **HG0539xDC860539**：那不还是因为win人多

  [1条回复](javascript:;)

- ![img](https://wx.qlogo.cn/mmopen/ibsibtc0Gxl3ctn0grwJ1Echu9swU7JtzPSJKic1Y9hp33c8J2mBBRYMx4lw4Fx1aiadUCibnkYB0kMTlqYf7hELVE2ElVsjspg8l/64)

  海洋

  辽宁4月12日

  

  

  赞2

  

  都是些常用命令，还有yazi和nushell也都特别好用![[强]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  作者赞过

- ![img](https://wx.qlogo.cn/mmopen/Q3auHgzwzM5icyDuAHW7BNU2s8Bv97JWAyPt3pBSEQoeEZPJeGwQ0p0poHicbcianzHS79uNvSeQu0gdGa7vJ93JBCkj7L3KVadJp1iaBa5euu4/64)

  梅落雨黄昏

  陕西4月12日

  

  

  赞2

  

  我选择oh-my-posh

  ![img](https://wx.qlogo.cn/mmopen/ibsibtc0Gxl3fjVHOwyITm5Vlwqn3kv33ogZiaQk5ITb2TkVqFmKkIQqyiaNblbVxRzZ8KVjt9R44xRD1pn7PZ8OmDmq1OQrS36f/64)

  血色幽怜

  云南4月13日

  

  

  赞

  

  之前装过，总感觉装了后终端初始化明显慢了不少，每次命令执行完也感觉有明显停顿感才会出现路径提示符

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  starship速度快~

- ![img](https://wx.qlogo.cn/mmopen/aBsub08Jn3UU0hkb9FicWLYYLoqvQHnfDYPB55icg25AzAPibUre6ztkmrE0GLYenKp0DWcPpxeKbfhMInh1Oc5PL35wkv2xtOT/64)

  国豪

  广东4月13日

  

  

  赞2

  

  cmder+windows terminal就够顺手的了，兼容bash命令，这不比花里胡哨五颜六色，但是还是敲又长又臭的powershell命令强？

  作者赞过

- ![img](https://wx.qlogo.cn/mmhead/PZI7pLaVibDMqNzH9rWP3TcKib1tmJRKKMJz9BlkQr7AlicNk7M9ZIJQ2y5axatEMBZ02QtEkBc0rs/64)

  huan666

  北京4月13日

  

  

  赞1

  

  ![[强]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)![[强]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)![[强]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  作者赞过

- ![img](https://wx.qlogo.cn/mmopen/Q3auHgzwzM73HJic8kGq8Yw9rjPXPc2U71w2xF82cMZYovOtiazSARNblRKF6skhicqzFG0VSYxXk81tHwHWT95KgaVujDHIzmNfKEibV1cwibb4zUySrX0S38f4earfE2BPM/64)

  Tyler

  上海4月13日

  

  

  赞9

  

  黑底黑字你会搭配格调

  ![动画表情](data:image/jpg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAIAAgADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3+iiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAI5pBFEzHtXEavqpDN81dFrd15UJUHmvOtQlLu2Tk5rnqSZpCNyCa7klcsWqB7lgOpzUZOOaru3WsbnRYma5Y9WpBdEGqZNIM07sLGxb3hBratNR2ODmuVjJBq7FIc007CcT0G11fAUqwrdtNQjuBjOGrzCG5dMYate01RkIyce9aRnYzlC56LRXN2etsMBjke9btvdJcLlTz6VsppmTi0T0UUVRIUUUUAFFFFABRRRQAUUUm4eooAWijOelFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUE460Vi+JrmW201miYqfUUAaM2oWsH+smQfjUA1vTycC5TP1rxi/1O5klOZW/Ost7+6WTKysMe9K4H0PDcRTrujcMPapK8c8N+JbqGVVklOB6mvVtP1GG/gDow3Y5FFwLtRzSCOMsakrG1u+WCEru570N2Q0rnPa5fF3YZ6GuSuHLkk1oXtz5rnnOazZSMGuSTOiCKz9KrtVh6gbrUGxCeKB1pzChRTFYlQVaj4qBFwM1aQcUBYnj5q0marJgVajPFMTRdt5CuOa3bG+MbLg1zyHirMUhXHNUmS4nf2tys8YIPNWK4u01N7dwRyK6mzvoryMFWG7uK3jK+hzyg0W6KKK0ICiis3VdWi06BmYgvjgUm7AWrm8gtU3TSBa5fVfHNtZ5ES7iK5HV9dlup2LOcdhXK30jysTmociuU6LU/iVfMWERwPaubn8fayzkidx/wKs2S3L1RltipxzSuwaPXPhj4k1DWbueK6lLIq5wea9Orx74QRlNSuc/8869hrREhRRRTAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKwfFi50h63qp6pai7sJIiOcZFJgeD3S/vm+tVinrWtrFq1reOp9azQM0hhCWjkDA4rvfCur+RIA78e9cMg5q/bTNEcjilewHrdxrqJCWBH51xWr6w11M2GyM1jPfSuu0scfWq5YtyaynI0jEnebcetQu+c0w01mGKxZtER2qPOaGNM3YoNEOY4pUPIqMtzSq3NAy2KmTpVdWBFSq1MCyhqzGeBVJXqwjigC8rVMrkd6pCQDvThMPWgRoLJVm2vXt5AyNgiskTgd6eJx601KxElc9A03VYrtArMBJ3HrWnXmkF55Thg2CK6W38RxpbjzGy2PWto1DmlHU276+js4izHnFeaa7qj3czZbPPrVrWtbN2zYbjtXNM+9iSaTlcaiVpVLHPWofI3ckVcK5pRHmi4zNeH0FUp4hu6VuSRcVm3MYpodjsPhaoTU5wB1Q16xXlPwy41eUesZr1atUZMKKKKYgooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoIyKKKAPMfHGme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)

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  哈哈哈哈 抱歉抱歉 写的时候用的dark mode发之前确实没注意

  ![img](https://wx.qlogo.cn/mmopen/Q3auHgzwzM73HJic8kGq8Yw9rjPXPc2U71w2xF82cMZYovOtiazSARNblRKF6skhicqzFG0VSYxXk81tHwHWT95KgaVujDHIzmNfKEibV1cwibb4zUySrX0S38f4earfE2BPM/64)

  Tyler

  上海4月13日

  

  

  赞1

  

  回复 **HG0539xDC860539**：哈哈哈哈哈，一片黑我看了半天

  [1条回复](javascript:;)

- ![img](https://wx.qlogo.cn/mmhead/Q3auHgzwzM6PquUkibDrutn4TyFYOp1pic78Vr2MXYCF5G9lJz9diaH1w/64)

  互联网之旅

  广东4月13日

  

  

  赞2

  

  这文章背景看不到字……

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  抱歉抱歉 自己用的dark mode，发完才发现

  ![img](https://wx.qlogo.cn/mmhead/Q3auHgzwzM6PquUkibDrutn4TyFYOp1pic78Vr2MXYCF5G9lJz9diaH1w/64)

  互联网之旅

  广东4月13日

  

  

  赞

  

  回复 **HG0539xDC860539**：下次继续这么发，就这条流量大![[阴险]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  [1条回复](javascript:;)

- ![img](https://wx.qlogo.cn/mmopen/PiajxSqBRaEJibjuOajbtHYu3n7nz8D5cRjTqYO1WvhphXgOCbAvfqH157RL4dUz3m8WFTjfxLq3iaDYP8niamQzXg/64)

  Peter

  浙江4月12日

  

  

  赞37

  

  这写的啥啊，深色背景，黑色字体，你是会排版的！

  ![img](https://wx.qlogo.cn/mmopen/ibsibtc0Gxl3dY2nKzlOJxXoMUhAPfkFgAtN8NBxCoYB1TmYGWcLWkibWTDibiaibYFOezh3Kibt7PgIIY0iaMJ6YiaP50XV8QfxMwj1YRX838cBpBnLrfMcHKzLYZQ7fH6ex9Rba/64)

  5磅

  海南4月13日

  

  

  赞3

  

  相信我，晚上能看见，纯夜间模式

  作者赞过

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  抱歉抱歉 我用的dark mode没有发现问题![[捂脸]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  [4条回复](javascript:;)

- ![img](https://wx.qlogo.cn/mmopen/PiajxSqBRaEIcVj1as2wKuBEDxyEO1Turpkh2mUF3CYwicKwUaTSuObqlGIxFLuv1qfYTbLpntLKeZjgXkNefKvFLLE3kTbn60rb1JZXAa8ullByTn4kLibNVFgaS6VAqCc/64)

  altair

  江苏4月12日

  

  

  赞1

  

  看了个寂寞![[囧]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  抱歉抱歉，自己用的dark mode，发完才发现![[捂脸]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

- ![img](https://wx.qlogo.cn/mmopen/aBsub08Jn3UAiaPkrLKIz2Aib86rgZrAjxyLUKFvf8Q9YN5Yldxa33RjliayfJ58OHmdCGWls9G9geic4pfl3pbJz6dX8J0RWQwS0ibvfwiaibeWqzDzXGBNrvqj5HubCnvjLQE/64)

  玉蘅

  甘肃4月13日

  

  

  赞1

  

  不想让人看这个文字啊，排班可以![[吃瓜]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  抱歉抱歉 写的时候用的dark mode发之前确实没注意

  ![img](https://wx.qlogo.cn/mmopen/aBsub08Jn3UAiaPkrLKIz2Aib86rgZrAjxyLUKFvf8Q9YN5Yldxa33RjliayfJ58OHmdCGWls9G9geic4pfl3pbJz6dX8J0RWQwS0ibvfwiaibeWqzDzXGBNrvqj5HubCnvjLQE/64)

  星蘅

  甘肃4月13日

  

  

  赞

  

  回复 **HG0539xDC860539**：

  改一下![[晕]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)![[晕]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)![[晕]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  眼睛着实受不了![[困]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  [1条回复](javascript:;)

- ![img](https://wx.qlogo.cn/mmopen/ibsibtc0Gxl3cdfqBRhaAmQe5lFxp6GvtGsxPpzuFneln5yv2wDCBovgAFrjePQeEs0dcoOOicqxUicu8FF227ibMQ2naPrz58X9DuVskM9Ap8e5KPa0EBRHYneu95Pps0mh4/64)

  前瞻观察地球仔🌏ᰔᩚ²⁰²⁶

  北京4月13日

  

  

  赞

  

  这样的效果如何实现啊？![[脸红]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  ![img](http://mmbiz.qpic.cn/mmbiz_png/dx4Y70y9Xcucu6BfBLwCIgFYHTdpDicbqzvF4OB1P6xNRBNzhebkU9Y6RYX8AvcH7M6wJjbIvH6PnL2NhyfqvBtYwVUIqdtzckeE60dtqPok/640)

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞1

  

  ![[捂脸]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)师傅我错了，我标题党

- ![img](https://wx.qlogo.cn/mmopen/ajNVdqHZLLBDFYVhibs0Teoe1ictbeictzuYibNesAL81ApKFoV5HVt0pTjAggAAwOiceaArcBiapTP93JYKulwMaUmDtFytaFR9BCr1fJ3NHQPOs/64)

  constant

  四川4月12日

  

  

  赞4

  

  天才，发的文章自己看过吗

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  文中的图片都是我实践测试然后截图的![[呲牙]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  ![img](https://wx.qlogo.cn/mmopen/ajNVdqHZLLBDFYVhibs0Teoe1ictbeictzuYibNesAL81ApKFoV5HVt0pTjAggAAwOiceaArcBiapTP93JYKulwMaUmDtFytaFR9BCr1fJ3NHQPOs/64)

  constant

  四川4月13日

  

  

  赞1

  

  回复 **HG0539xDC860539**：黑背景黑文字，也就火星人能看你的神文

  [1条回复](javascript:;)

- ![img](https://wx.qlogo.cn/mmopen/aBsub08Jn3XeGWj4oibm2t25gWqjbOC2wvH6YHQrr31tAicbPvLThRufE2LmrCCEiagjhsfS2F0uDYV8HRId0MPZrZaHGedRsmHGq1cKcMKtmgAicKuvbia6Nc5l8qPbEkhas/64)

  vency

  广东4月13日

  

  

  赞

  

  黑底黑字你会写格调

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  抱歉 写的时候用的dark mode发之前确实没注意

  ![img](https://wx.qlogo.cn/mmopen/aBsub08Jn3V1PZ81b45icN8mUwfR5fzEzAXQIOesGmD9DQKRTdQBWA179tjlwKblyBjPK3yQ4DR3cYT5ibHsIToYT8y3NOT2Gp5FNZ6pQv6dwV4wadHY7FibRA7Fa5U3qzib/64)

  mystery

  山东4月13日

  

  

  赞

  

  回复 **HG0539xDC860539**：那你倒是改啊

  [1条回复](javascript:;)

- ![img](https://wx.qlogo.cn/mmopen/PiajxSqBRaEIGv4tXknRiaVvDfFQtjmAlWy9hROy8gxEVQm9PoicnJr8KETicH4yxxnsSkiaB8zbPDqZcibOzv7zXlibHLib5PvXvBoEDea8N8icBeE12VJWUcE5Sib7Bxoz7deyXF/64)

  薛定谔的猫

  四川4月13日

  

  

  赞1

  

  你自己看过吗？![[旺柴]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  哈哈哈 看了但是我的dark mode没有发现问题![[捂脸]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

- ![img](https://wx.qlogo.cn/mmopen/tqRiaNianNl1m2BvnqUQIJopQIjKRicxePH2hKwQKgZrTVPICU6aC3nRpPnIPd6fB9iaj9QlDORNdYyibC8icPpejibA7MvHEznibqdd/64)

  喀喇蜜

  黑龙江4月13日

  

  

  赞1

  

  那个cat不要用不支持中文

  作者赞过

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  你说的是bat（替代cat）命令吧？

- ![img](https://wx.qlogo.cn/mmopen/ibsibtc0Gxl3cVg4mWyUzM9YAqYd0eapcoe7tZPLvCDicFlM23Q2vyz2miaicSibnNauqr0ibrRu35iaBwhnQwFxLT7KxsQrWUtNBMekqr1E22u5VfkticjzT1abaa1Y1NLicT9Hibd/64)

  Evan

  广东4月13日

  

  

  赞1

  

  还不如做成一键脚本

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  好主意，一会就发

- ![img](https://wx.qlogo.cn/mmopen/Q3auHgzwzM5BicWmQ7c1d7NmnSwhMIbORibNhygToibKtf8EgTE9jwEq5qo1U8F17YvAYDApaeibNdnV8QSaWyGKf9fHiaSazcuAFn4w6Nyh02oHJu0ia0QdfZc3iaQJGoTh7ibJ/64)

  陈浩楠

  重庆4月13日

  

  

  赞2

  

  自己都没发现字都看不清楚吗

  ![img](https://wx.qlogo.cn/mmhead/tqRiaNianNl1l7TNnvSp5erib3G2JAFiclOn6jMV3gZnI2x0TAnffTVlXZxgE5ia7zMZ9cshbjdNFwuI/64)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  哈哈哈 自己用的dark mode，发完才发现，懒得重新发

- ![img](https://wx.qlogo.cn/mmopen/tqRiaNianNl1lvxtWWGat6MTGBFtNNo8g3Lap52d274HgFRibAxBHLB7S3ylKZNV9ibuVhprC9cAPsbTnxVcnIX4e3XKHWVFOG7ntbqiaGl2sO3iatu9xuRic4IBgybZwwrAkjO/64)

  ᐝོ ²⁰²⁶💨

  辽宁4月13日

  

  

  赞

  

  第一步就是错的 不能使用管理员模式

  ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  是的师傅，感谢斧正，已更正，应该使用普通用户。

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  人间梦隔西风[福]

  天津4月13日

  

  

  赞

  

  改变不了power shell难用的本质

  ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  哈哈哈 还是能稍微改善一点的

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  喀喇蜜

  黑龙江4月13日

  

  

  赞

  

  试了一下ls根本不让替换

  ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  很抱歉师傅，试试这个 Set-Alias -Name ls -Value lsd -Option AllScope -Force

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  Cyclone77

  四川4月13日

  

  

  赞2

  

  win下面真不用折腾，听我一句劝，我折腾了各种，由于不同的编辑器打开的效果不一样，最终还是觉得原生最好

  作者赞过

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  土圭垚

  内蒙古4月13日

  

  

  赞5

  

  总结两点。

  1，换ui，换指令，没bash环境，纯自嗨。

  2，黑底黑字，看个锤子。

  ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  HG0539xDC860539

  作者4月13日

  

  

  赞

  

  1、工具里有coreutils，有大部分bash下的工具，我测试过都挺好用的。

  2、抱歉抱歉 自己用的dark mode，发完才发现。

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  陈烛之

  广东4月13日

  

  

  赞1

  

  习惯用ConEmu，不想折腾其他的终端了。

  作者赞过

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  WeChat

  上海4月13日

  

  

  赞1

  

  WSL

  作者赞过

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  小范Drummer

  辽宁4月12日

  

  

  赞

  

  路边

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  uni

  上海4月12日

  

  

  赞3

  

  一个包皮有啥用，bash命令才是最有用的东西。wsl也挺蠢的。

  作者赞过

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  冬离

  广东4月13日

  

  

  赞

  

  甜菜

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  福建4月15日

  

  

  赞1

  

  我选择wsl

  作者赞过

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  所遇

  贵州4月14日

  

  

  赞1

  

  UP背景色 黑色看不清文字![[破涕为笑]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

  作者赞过

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  ᯤUHC.LEI

  广西4月14日

  

  

  赞1

  

  看不到字。直接翻一下评论，阅毕！

  作者赞过

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  O.o

  辽宁16小时前

  

  

  赞

  

  ![动画表情](data:image/png;base64,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)

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  Disguiser

  江苏4天前

  

  

  赞

  

  你家powershell默认是纯白背景黑字的？

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  🍊Leo Lee

  广东4月16日

  

  

  赞

  

  ![[强]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)![[强]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)![[强]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)![[强]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)![[强]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)![[强]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  Albafica

  黑龙江4月15日

  

  

  赞

  

  看你点东西还挺费劲

  ![img](http://mmbiz.qpic.cn/mmbiz_jpg/nMl9ssowtibWicb4YFMbROYaMNQefdE0dQ8dLRvib08ESfqCyQxrv8eFJZJ0ltpa5B1pgiagiaZOCaeXjHGV4bhF2hiaYzNe1ltYkrvGsiamkAiajt4/640)

  ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  HG0539xDC860539

  作者4月15日

  

  

  赞

  

  ![[呲牙]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)![[呲牙]](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=)抱歉抱歉 可以直接clone仓库原文也放上去了

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  林卡 Rinca

  湖北4月13日

  

  

  赞

  

  哈哈，ai 太好用啦

  ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  HG0539xDC860539

  作者4月14日

  

  

  赞

  

  优化的太好大家都被排版吸引了，内容都被忽略了🙈

- ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  草莓蛋糕

  上海4月13日

  

  

  赞

  

  powershell 经常搞得智普改路径相关代码

  ![img](data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHZpZXdCb3g9IjAgMCA0MCA0MCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBjbGlwLXBhdGg9InVybCgjY2xpcDBfNDIyMF8yNjc0KSI+PHBhdGggZmlsbD0iI2ZmZiIgZD0iTTAgMGg0MHY0MEgweiIvPjxwYXRoIGZpbGw9IiNFREVERUQiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjUgMjlhMSAxIDAgMCAxLTEtMXYtLjY4NGMwLS42ODYuNDk4LTEuNDg0IDEuMTE0LTEuNzg1bDUuNjYtMi43NjJjLjgyMS0uNCAxLjAxMi0xLjI4OC40Mi0xLjk5bC0uMzYyLS40MjljLS43MzYtLjg3Mi0xLjMzMi0yLjUtMS4zMzItMy42NFYxNWMwLTIuMjEgMS43OTUtNCA0LTQgMi4yMSAwIDQgMS43OTMgNCA0djEuNzFjMCAxLjE0LS42IDIuNzczLTEuMzMyIDMuNjQybC0uMzYxLjQyOGMtLjU5LjY5OS0uNDA2IDEuNTg4LjQxOSAxLjk5bDUuNjYgMi43NjJjLjYxNS4zIDEuMTE0IDEuMDkzIDEuMTE0IDEuNzg0VjI4YTEgMSAwIDAgMS0xIDFoLTE3eiIgZmlsbD0iIzAwMCIgZmlsbC1vcGFjaXR5PSIuOSIgb3BhY2l0eT0iLjIiLz48L2c+PGRlZnM+PGNsaXBQYXRoIGlkPSJjbGlwMF80MjIwXzI2NzQiPjxwYXRoIGZpbGw9IiNmZmYiIGQ9Ik0wIDBoNDB2NDBIMHoiLz48L2NsaXBQYXRoPjwvZGVmcz48L3N2Zz4=)

  HG0539xDC860539

  作者4月14日

  

  

  赞

  

  不确定是不是我想的那样，可以试试cc switch 来通一管理API的配置。

