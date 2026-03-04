## 1 安装ZeroClaw

安装Rust 环境后，克隆仓库后直接 cargo build：

```bash
git clone https://github.com/zeroclaw-labs/zeroclaw.git
cd zeroclaw
cargo build --release
cargo install --path .
```

编译时遇到了一个小 bug：`src/main.rs` 里 `ModelCommands` 枚举被定义了两次，导致编译报 `E0428` 重复定义错误，需要删掉重复的那份。
## 2 初始化
### 2.1 ZeroClaw 提供了 onboard 命令做初始化，支持交互式和快速模式：

```bash
zeroclaw onboard --provider openai --api-key "YOUR_KEY" --memory sqlite
```

这会在 `~/.zeroclaw/` 下生成完整的工作空间结构，包括配置文件、sessions、memory、skills 目录，以及一系列 Agent 人格文件（IDENTITY.md、SOUL.md 等）。
### 2.2 interactive 交互式配置
```bash
 zeroclaw onboard --interactive  # 配置模型
 zeroclaw onboard  --channels-only  # 配置聊天软件
```
Next steps:
    1. Chat:     zeroclaw agent -m "Hello!"
    2. Gateway:  zeroclaw gateway
    3. Status:   zeroclaw status
## 3 启动
```bash
zeroclaw gateway
```
