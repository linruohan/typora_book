https://github.com/ankitkpandey1/ccplan
**你的AI代理可以运行的日程本。** 编写明文计划——或者让代理代为编写——ccplan会将其转化为原生操作系统 通知、状态追踪和时间触发命令。没有守护进程，没有账号，没有云。

[![MT](https://github.com/ankitkpandey1/ccplan/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/ankitkpandey1/ccplan/actions/workflows/ci.yml) [![发行](https://camo.githubusercontent.com/7fc7d2f46f152cdc01fd346dc5969ea8c1714cc33b29488d0c1a6a5f443dcd05/68747470733a2f2f696d672e736869656c64732e696f2f6769746875622f762f72656c656173652f616e6b69746b70616e646579312f6363706c616e3f736f72743d73656d766572)](https://github.com/ankitkpandey1/ccplan/releases/latest) [![许可](https://camo.githubusercontent.com/96c81fd578956b529ae58f7d9757d1382b3b261201a0d870c725a6271a7a75bf/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c6963656e73652d4d49542532304f522532304170616368652d2d322e302d626c7565)](https://github.com/ankitkpandey1/ccplan#license)

---

# schtasks
### 0.1 方案一：使用原生 `schtasks` 命令（最轻量、零依赖）
这是 Windows 自带的计划任务命令行工具，无需安装任何软件，非常适合集成到脚本中[](https://zetcode.cn/command-prompt/scheduling-tasks/)[](https://blog.csdn.net/weixin_29232507/article/details/158438213)。
其核心思路是：先创建一个用于**显示提醒**的脚本（比如弹窗），然后用 `schtasks` 命令让它在指定时间自动运行。
#### 0.1.1 第一步：创建提醒脚本
在记事本中粘贴以下代码，保存为 `reminder.vbs`。VBS 脚本的好处是可以弹出一个简单的 Windows 消息框。
```vbscript
MsgBox "该休息一下啦！", vbInformation, "定时提醒"
```
- **自定义提醒内容**：直接替换引号内的中文即可。如果提醒内容是中文，保存文件时，记得在记事本的“另存为”对话框中，将编码选为 **UTF-16LE**，否则弹窗可能显示乱码。
#### 0.1.2 第二步：使用 `schtasks` 创建定时任务
打开命令提示符（CMD），使用以下命令创建一个任务。例如，下面的命令会创建一个名为 "MyReminder" 的任务，在每天下午 14:00 运行我们刚才的 VBS 脚本[](https://zetcode.cn/command-prompt/scheduling-tasks/)。
```shell
schtasks /create /tn "MyReminder" /tr "C:\path\to\your\reminder.vbs" /sc daily /st 14:00 /f
```
**关键参数解释**[](https://zetcode.cn/command-prompt/scheduling-tasks/)[](https://cloud.tencent.com.cn/developer/ask/sof/112176101?from=16139):

- `/tn`：指定任务的名称。
- `/tr`：指定要运行的程序或脚本的完整路径。
- `/sc`：设置计划频率，如 `daily`（每天）、`weekly`（每周）、`minute`（每分钟）等。
- `/st`：指定开始时间。
- `/f`：如果任务已存在，则强制创建并覆盖，可以避免交互确认[](https://cloud.tencent.com.cn/developer/ask/sof/112176101?from=16139)。
#### 0.1.3 第三步：管理你的任务

任务创建后，你也可以通过命令来管理它[](https://zetcode.cn/command-prompt/scheduling-tasks/)[](https://learn.microsoft.com/en-us/answers/questions/2437649/scheduled-tasks-message-pop-up-when-windows-starts)。
- **立即运行测试**：`schtasks /run /tn "MyReminder"`
- **查看所有任务**：`schtasks /query /fo list`
- **删除任务**：`schtasks /delete /tn "MyReminder" /f`
# ccplan
## 1 与你的AI代理建立
CCPLAN设计时由代理驾驶。 **复制下面的模块，粘贴到Claude代码（或任何代码） 编码代理）。** 它安装了ccplan，加载了技能，开始规划你的一天——你什么都不运行 你自己。

```
Install and use ccplan (an agent-driven CLI day planner) for me, then plan my day.

1. Install the binary.
   macOS/Linux:  curl --proto '=https' --tlsv1.2 -LsSf https://github.com/ankitkpandey1/ccplan/releases/latest/download/ccplan-installer.sh | sh
   Windows:      powershell -c "irm https://github.com/ankitkpandey1/ccplan/releases/latest/download/ccplan-installer.ps1 | iex"

2. Install the ccplan agent skill so you know exactly how to use it.
   mkdir -p ~/.claude/skills/ccplan
   curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/ankitkpandey1/ccplan/main/skills/ccplan/SKILL.md -o ~/.claude/skills/ccplan/SKILL.md

3. Confirm it works: run `ccplan --version` and `ccplan doctor`.

4. Read ~/.claude/skills/ccplan/SKILL.md, then ask me about my day and author it with ccplan.
```

就是这样——代理安装二进制， [放入技能](https://github.com/ankitkpandey1/ccplan/blob/main/skills/ccplan/SKILL.md) ，然后 遵循其流程（创作、退出代码、JSON 合同）。更喜欢自己开？继续阅读。

## 2 是什么

CCPLAN将你的一天规划成一个时间 **块** 列表。每个区块都可以 **通过桌面提醒你** 通知，标记 **为完成或跳过** ，并且可选 **地在** 命令开始时执行——踢出 关闭同步，打开文档，开始构建。计划是一个纯文本 [的TOML](https://github.com/ankitkpandey1/ccplan#the-plan-file) 文件，你可以 可以手工编辑，或者让代理人作者从头到尾完成。

||代理人可以填补|桌面提醒|标记完成|一次运行一个命令|跨平台|
|---|:-:|:-:|:-:|:-:|:-:|
|谷歌任务|✗|部分|✓|✗|✓|
|日历 / CalDAV|~|✓|~|✗|~|
|任务战士|✓|通过胶水|✓|✗（编辑时发射 _edit_，但不同时 _time_）|✓|
|cron / systemd / launchd|✓|——|——|✓|按操作系统|
|**CCPLAN**|**✓**|**✓**|**✓**|**✓**|**✓**|

CCPLAN 是唯一一个可以由代理操作、时间触发、既能 **通知又能执行** 的工具， 运行于 Linux/macOS/Windows 上，并以人类可读的纯文本图纸作为真实数据。

---

## 3 安装

```shell
# macOS / Linux
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/ankitkpandey1/ccplan/releases/latest/download/ccplan-installer.sh | sh

# Windows (PowerShell)
powershell -c "irm https://github.com/ankitkpandey1/ccplan/releases/latest/download/ccplan-installer.ps1 | iex"
```

每个版本都附带 Linux（x64/ARM64）和 macOS（Intel/Apple Silicon）的签名校验和归档， 还有一台Windows `.zip` 以及 `.msi` —— 直接从中下载任何 [最新发布](https://github.com/ankitkpandey1/ccplan/releases/latest) ，或 [从源头构建](https://github.com/ankitkpandey1/ccplan#build-from-source) 。

## 4 快速入门


```shell
ccplan add --title "Focus time"      --start 11:00 --end 11:30
ccplan add --title "Agentic sync-up" --start 11:30 --duration 30m --notify 2m
ccplan add --title "Standup"         --start 16:25 --duration 5m

ccplan show              # the day so far
ccplan apply             # hand the schedule to the OS — alerts now fire on their own

ccplan now               # what's active right now
ccplan next              # what's coming up
ccplan done focus-time   # mark a block complete (id is auto-slugged from the title)

ccplan remind "Stretch" --in 25m   # one-shot: alert 25 minutes from now, applied immediately
```

11：00时会收到“Focus时间”通知，11：30时会触发同步警报，依此类推——即使 `ccplan` 它本身没有运行。

---

## 5 计划文件

每天在操作系统数据目录下写一个 [TOML](https://toml.io) 文件 （ `~/.local/share/ccplan/plans/YYYY-MM-DD.toml` 在 Linux 上）。可以手动编辑，或者让代理人写; `ccplan apply` 在排期前重新验证。

```toml
date     = "2026-06-08"
timezone = "Asia/Kolkata"          # frozen at author time; all times resolve against this

[[block]]
id     = "focus-1"                 # stable, unique within the day
title  = "Focus time"
start  = "11:00"                   # local wall-clock
end    = "11:30"                   # OR  duration = "30m"  (exactly one)
notify = "5m"                      # lead-time notification before start
tags   = ["deep-work"]
status = "pending"                 # pending | active | done | skipped | missed | expired

[[block]]
id       = "sync-1"
title    = "Agentic sync-up"
start    = "11:30"
duration = "30m"
notify   = "2m"
run      = ["/home/me/bin/sync.sh", "--fast"]   # argv vector (no shell) — must be allow-listed
status   = "pending"
```

代理人通过输入TOML来一次性完成整天的创作 `ccplan set --from -`，则 `ccplan apply`。往返读取为 JSON （ `ccplan show --json`）。

> **为什么是TOML，而不是YAML？** TOML 可以明确手动编辑（没有显著的空白，没有 “ `no` →假“惊喜”）并干净利落地映射到一个块列表。其Rust实现为 维护和审计，与存档/带有警示的YAML箱子不同——对代理和 用于供应链卫生。

---

## 6 CLI参考

| 指挥                                                                                   | 目的                                                          |
| ------------------------------------------------------------------------------------ | ----------------------------------------------------------- |
| `ccplan set --from <file\|-> [--override-history]`                                   | 换掉整天的。终端模块（已完成/跳过/错过/过期）总是被保留;改变他们的需求 `--override-history`。 |
| `ccplan add --title T --start 11:00 [--end\|--duration] [--notify] [--run …] [--id]` | 添加或更新一个方块。                                                  |
| `ccplan remind "T" --in 30m [--id]`                                                  | 一次性提醒：现在+持续时间添加零铅块块，并一步应用。                                  |
| `ccplan edit <id> [--start …] [--title …] …`                                         | 给非终端模块打个补丁。                                                 |
| `ccplan rm <id>`                                                                     | 移除待处理的阻挡。                                                   |
| `ccplan done <id>` / `ccplan skip <id>`                                              | 标记一个区块已完成/跳过。                                               |
| `ccplan snooze <id> --by 10m`                                                        | 之后推一个非终端模块并重新申请（如果超过午夜就拒绝）。                                 |
| `ccplan template save\|apply <name> [--date]` / `ccplan template list`               | 捕捉一次日型，然后盖在任意日期上（状态重置，然后应用）。                                |
| `ccplan clear --yes`                                                                 | 存档这一天并移除其触发因素 （ `--purge` 删除）。                              |

**阅读** ——所有支持 `--json`

|指挥|回归|
|---|---|
|`ccplan show`|整天。|
|`ccplan now`|现在有一组方块正在激活。|
|`ccplan next`|下一个即将推出的区块数组。|
|`ccplan agenda`|剩余的区块带有倒计时。|
|`ccplan log [--date <d>] [--since <rfc3339>]`|火灾账本——调度器实际做了什么（通知/激活/未完成/关闭）。|

`ccplan watch [--every <dur>]` 是一个实时自动刷新的议程视图，显示留置在 终端（仅限人类，不 `--json`;默认刷新 `30s`;按Ctrl-C或Enter退出）。

**系统**

|指挥|目的|
|---|---|
|`ccplan apply [--dry-run]`|协调操作系统触发器以匹配计划（幂等元）。|
|`ccplan status`|调度器健康状况：跟踪与实时操作系统触发器。|
|`ccplan doctor`|检查原生调度器+通知器是否可用;打印修复。|
|`ccplan completions <shell>`|打印 shell 补全（bash/zsh/fish/powershell）。|

`ccplan fire …` 存在但属于内部——这是操作系统在触发块时调用的。

**出口代码：** `0` 好的 · `2` 使用/验证 · `3` 未找到 · `4` 调度器故障 · `5` 自动化被拒绝 · `6` 历史冲突（需求） `--override-history`）。没有任何命令是真正的 互动;破坏性标记需要明确的标志（ `--yes`， `--override-history`）。

---

## 7 MCP服务器

`ccplan mcp` 启动同步 [模型上下文协议](https://modelcontextprotocol.io) server over stdio （JSON-RPC 2.0， newline-delimited）.将它连接到任何MCP主机：
```json
{
  "mcpServers": {
    "ccplan": {
      "command": "ccplan",
      "args": ["mcp"]
    }
  }
}
```

**暴露工具** （共16件）：

|工具|它的作用|
|---|---|
|`ccplan_plan_day`|用 JSON 块数组替换整天的数据|
|`ccplan_apply`|协调操作系统触发器以匹配当前计划|
|`ccplan_show_plan`|返回完整计划为JSON|
|`ccplan_list_now`|目前有活跃的方块 （ `[]` 如果没有）|
|`ccplan_list_next`|下一个即将推出的时段 （ `[]` 如果没有）|
|`ccplan_show_agenda`|剩余的倒计时区块|
|`ccplan_add_block`|添加或更新一个方块|
|`ccplan_add_reminder`|一次性相关提醒（加+应用）|
|`ccplan_mark_block`|标记已完成或跳过的区块|
|`ccplan_edit_block`|在非终端块上设置标题、时间、通知或运行|
|`ccplan_remove_block`|移除待处理的封锁|
|`ccplan_snooze_block`|稍后推一个非终端块一段时间后重新应用|
|`ccplan_save_template`|将计划保存为一个命名的可重复使用日模板|
|`ccplan_list_templates`|列表保存模板名称|
|`ccplan_apply_template`|将模板实例化到某个日期（状态重置）并应用|
|`ccplan_fire_log`|阅读火灾账簿——你不在时发生了什么火灾 （ `[]` 如果没有）|

**闭环。** `ccplan_fire_log` 是代理循环的读端：调度器触发 在操作系统实时时间上进行封锁，代理调用 `ccplan_fire_log` （可选） `since` 上次 查看）以了解实际发生了什么——什么被通知了，什么 `run:` 激活，错过了什么—— 从那里重新规划。每个条目为 `{ ts, date, id, event, outcome, detail }`。它是只读的：它 观察历史，从不开火。

`fire`， `mcp`， `completions` 从 **未** 被暴露为MCP工具。没有工具能修改 `automation.enabled` 或者允许清单。当 `run:` 命令被存储，但不会执行 （自动化被禁用或执行文件未被允许列表），工具结果包括 `WARNING` 排队。

---

## 8 配置
`~/.config/ccplan/config.toml` （显示Linux路径）：

```toml
grace = "90s"                      # how late a trigger may fire before it counts as missed

[automation]
enabled = false                    # per-block `run:` is OFF by default
timeout = "5m"                     # max runtime per `run:` command
allowed_executables = [            # `run:`'s argv[0] must be an absolute path on this list
  "/home/me/bin/sync.sh",
]

[notify]
default_lead = "5m"                # lead applied to a block that omits its own `notify`
```

---

## 9 工作原理

```
 you / an agent          ccplan apply              native OS scheduler         ccplan fire
 ───────────────▶  plan.toml  ───────────▶  systemd / launchd / Task Sched ──────▶  notify + run
   (CLI or edit)   (source of truth)        (one one-shot trigger per event)        + lifecycle
```

1. **存储** ——每日TOML计划是唯一的真实来源。
2. **编译** —— `apply` 将计划整合为本地一次性操作系统触发器，每个事件触发一个 （ `notify` / `start` / `end`）。每个都嵌入一个日程 **`rev`** （块时序的哈希），因此 重新规划或删除的触发器会变得无效。
3. **发射** ——当触发触发时，操作系统运行 `ccplan fire …`，检查数据是否仍在运行，且 按时（耐用账本保证最多执行 **一次** ），然后通知，执行命令 任何，并提升了该区块的地位。

没有后 **台守护进程** ——ccplan依赖于每个操作系统的调度器，所以即使当 CCPLAN没有运行。

---

## 10 安全模型

`run:` 让一个块执行命令，因此plan文件是 **信任边界** 。CCPLAN对此进行了辩护：

- **自动化默认关闭** ;你通过配置选择加入。
- 命令的可执行文件必须是 **允许列表中的绝对路径** ——其他程序都不能运行。
- 命令作为 **无壳（无）的 argv 矢量** (no `sh -c`）——没有弹壳注入面。
- 计划文件必须 **归你所有，不能写世界** ，否则ccplan拒绝运行命令。
- 每次火灾都会 **被记录** ， **最多运行一次** ，并且有 **时间限制** 。

参见 [`SECURITY.md`](https://github.com/ankitkpandey1/ccplan/blob/main/SECURITY.md) 关于威胁模型以及如何报告问题。

---

## 11 平台支持

||Linux|macOS|窗户|
|---|:-:|:-:|:-:|
|排程|系统 `--user` 计时器|启动了LaunchAgents|任务调度器|
|通知|libnotify / D-Bus|NSUser通知|WinRT 吐司|

通知需要图形登录会话（常见的桌面情况）。无头使用依然存在 排程和运行自动化; `ccplan doctor` 告诉你有哪些可用的。

## 12 源代码构建

需要一个近期稳定的 Rust 工具链（2024 版;参见 `rust-toolchain.toml`）。

```shell
git clone https://github.com/ankitkpandey1/ccplan
cd ccplan
cargo build --release
./target/release/ccplan --help
```

设计笔记和不变量存在于 [`DESIGN.md`](https://github.com/ankitkpandey1/ccplan/blob/main/DESIGN.md)。
