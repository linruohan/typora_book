% WebFetch https: //opencode.ai
% WebFetch https: //opencode.ai/docs
% WebFetch https: //opencode.ai/docs/tools
## 1 OpenCode自带以下工具：
### 1.1 文件操作
- read －读取文件内容
- write － 创建新文件或覆写现有文件·edit－通过精确字符串替换修改文件
- patch － 应用补丁文件
### 1.2 搜索工具
- grep－使用正则表达式搜索文件内容
- glob-通过模式匹配查找文件
- list－列出自录内容
### 1.3 系统操作
- bash －执行shell命令
- lsp（实验性）－与LSP服务器交互获取代码智能
### 1.4 任务管理
- todowrite－管理待办事项列表
- todoread － 读取待办事项
### 1.5 交互工具
- question － 向用户提问
- webfetch.－.获取网页内容
- skill－加载技能文件
所有工具默认启用，可通过opencode.json 配置权限控制。
## 2 OpenCode 整合 Antigravity：免费使用顶级大模型指南
你需要安装 `opencode-antigravity-auth` 插件并配置模型定义。
### 2.1 方式一：自动安装（推荐）

直接在 OpenCode 对话中输入以下指令，让 Agent 自动执行安装和配置：

```bash
Install the opencode-antigravity-auth plugin and add the Antigravity model definitions to ~/.config/opencode/opencode.json by following: https://raw.githubusercontent.com/NoeFabris/opencode-antigravity-auth/dev/README.md
```

### 2.2 方式二：手动配置
如果你更喜欢手动控制，可以编辑配置文件：
1. 打开配置文件 `~/.config/opencode/opencode.json`。
   
2. 在 `plugins` 数组中添加插件：
    
    ```json
    {
      "plugins": ["opencode-antigravity-auth@latest"]
    }
    ```
    
    _(注：如果想要体验最新测试版功能，可使用 `@beta` 版本)_
    
3. 复制并添加完整的模型定义配置（需参考官方文档获取最新的模型配置 JSON）。
    

### 2.3 账号认证

插件安装完成后，需要登录 Google 账号进行授权。

1. **重启 OpenCode**：新开一个终端窗口打开 OpenCode。
2. **执行登录命令**：
    
    ```bash
    opencode auth login
    ```
    
    _(如果是添加第二个账号，再次运行此命令即可)_
3. **选择登录方式**：
    - 终端会提示选择登录提供商，使用方向键选择 **Google**。
4. **浏览器授权**：
    - 系统会自动打开默认浏览器。
    - 请登录**拥有 Antigravity 权限**的 Google 账号。
5. **完成登录**：
    - 登录成功后，终端会显示 “Authentication successful” 或类似的成功提示。

### 2.4 验证与使用

登录完成后，即可验证模型是否可用。

### 2.5 验证模型列表

在 OpenCode 中输入以下斜杠命令：

```bash
/models
```
在弹出的模型列表中，你应该能看到 Google Antigravity 支持的一系列模型，例如：
- `google/antigravity-claude-sonnet-4-5-thinking`
- `google/antigravity-claude-opus-4-5-thinking`
- `google/antigravity-gemini-3-pro`
- `google/antigravity-gemini-3-flash` ![https://image.wenhaofree.com/2026/01/f4e670b77c42dcaf60bea1d2125b435e.png](https://image.wenhaofree.com/2026/01/f4e670b77c42dcaf60bea1d2125b435e.png "https://image.wenhaofree.com/2026/01/f4e670b77c42dcaf60bea1d2125b435e.png")

### 2.6 快速测试
你可以使用以下命令直接调用特定模型进行测试：

```bash
opencode run "Hello, who are you?" --model=google/antigravity-claude-sonnet-4-5-thinking --variant=max
```

如果收到回复，说明配置已完全成功。现在你可以尽情使用这些强大的模型来辅助编程了！

