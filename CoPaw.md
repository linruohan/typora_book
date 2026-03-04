
## 1 简单介绍
CoPaw（Co-Paw，意为"你的搭档小爪子"）是阿里云通义团队推出的个人智能体工作台，基于 AgentScope 多智能体生态构建。它不仅仅是一个聊天机器人，更是一个能够真正帮你"干活"的 AI 助理——可以操作电脑、管理文件、处理文档、执行定时任务，就像《钢铁侠》里的贾维斯一样。

### 1.1 核心定位

- **个人智能体工作台**：协同个人智能体工作台
- **本地+云端双部署**：数据隐私与便捷性的完美平衡
- **多端全域接入**：打通钉钉、飞书、QQ、Discord、iMessage 等主流平台
- **技能灵活扩展**：通过 Skills 机制实现能力无限扩展

### 1.2 发布时间线

- **2026年2月14日**：正式发布，支持本地与云端部署
- **2026年2月**：魔搭创空间一键配置上线
- **2026年2月28日**：正式在 GitHub 开源，架构模块化重构

## 2 极简部署：三行命令即可启动

### 2.1 本地部署

```bash
# 一键安装（推荐）- 无需手动配置 Python
# macOS / Linux:
curl -fsSL https://copaw.agentscope.io/install.sh | bash

# Windows（PowerShell）:
irm https://copaw.agentscope.io/install.ps1 | iex

# 或使用 pip 安装
pip install copaw

# 初始化（快速默认配置）
copaw init --defaults

# 启动服务
copaw app
# 安装
pip install copaw

# 初始化（快速默认配置）
copaw init --defaults

# 启动服务
copaw app
```