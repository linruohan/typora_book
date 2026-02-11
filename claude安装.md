# claude

## 1 install
```bash
npm install -g @anthropic-ai/claude-code@latest
```
## 2 初始化
添加配置文件："~\.claude\settings.json"
```cmd
setx ANTHROPIC_AUTH_TOKEN your_zhipu_api_key
setx ANTHROPIC_BASE_URL https://open.bigmodel.cn/api/anthropic
setx CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC 1
```

> claude 锁区解决

![](imgs/claude安装.png)
```cmd
powershell -Command "$f='%USERPROFILE%\.claude.json';$j=Get-Content $f|ConvertFrom-Json;$j|Add-Member -NotePropertyName 'hasCompletedOnboarding' -NotePropertyValue $true -Force;$j|ConvertTo-Json|Set-Content $f"
```
意思是在~/.claude.json 中添加`hasCompletedOnboarding：true`

继续：
![](imgs/claude安装-1.png)
![](imgs/claude安装-2.png)
## 3 配置 MCP 扩展功能
1. 命令行添加
```bash
claude mcp add -s user -t http web-search-prime https://open.bigmodel.cn/api/mcp/web_search_prime/mcp --header "Authorization: Bearer your_api_key"

```
2. 修改文件（追加到 `~/.claude.json` 的尾部）
```bash
"mcpServers": {
    "zhipu-web-search-sse": {
      "url": "https://open.bigmodel.cn/api/mcp-broker/proxy/web-search/mcp?Authorization=your_api_key"
    }
  }
```


### 3.1 联网搜索 MCP（`webSearchPrime`）
```json
{
  "mcpServers": {
    "zhipu-web-search-sse": {
      "url": "https://open.bigmodel.cn/api/mcp-broker/proxy/web-search/mcp?Authorization=Your Zhipu API Key"
    }
  } 
}
```
### 3.2 网页读取 MCP（`webReader`）
```json

##### 配置方式

**一键安装**：

```bash
claude mcp add -s user -t http web-reader https://open.bigmodel.cn/api/mcp/web_reader/mcp --header "Authorization: Bearer your_api_key"

**或手动配置**：

{
  "mcpServers": {
    "web-reader": {
      "type": "http",
      "url": "https://open.bigmodel.cn/api/mcp/web_reader/mcp",
      "headers": {
        "Authorization": "Bearer your_api_key"
      }
    }
  }
}
```

##### 3.2.1.1 典型场景

- 自动解析 API 文档并生成摘要
- 提取 GitHub 项目 README 核心信息
- 构建团队技术知识库

### 3.3 视觉理解 MCP（`image_analysis` / `video_analysis`）

> 此 MCP 为 **本地服务**，需 Node.js ≥ v18
##### 3.3.1.1 配置方式

**一键安装**：

```bash
claude mcp add -s user zai-mcp-server --env Z_AI_API_KEY=your_api_key -- npx -y "@z_ai/mcp-server"
```

> **Windows 用户注意**：若在 PowerShell 中报 `-y` 错误，请改用 **CMD** 执行。

**或手动配置**：

```json
{
  "mcpServers": {
    "zai-mcp-server": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@z_ai/mcp-server"],
      "env": {
        "Z_AI_API_KEY": "your_api_key",
        "Z_AI_MODE": "ZHIPU"
      }
    }
  }
}
```

##### 3.3.1.2 使用方法

1. 将图片（如 `demo.png`）放入当前工作目录
    
2. 在 Claude Code 中输入：
    
    ```
    What does demo.png describe?
    ```
    
    或
    
    ```
    hi describe this chart.jpg
    ```
    

> **禁止直接粘贴图片**！否则客户端会绕过 MCP 直接调用模型，无法使用视觉理解能力。



## 4 MCP 使用额度说明

|套餐|搜索 + 网页读取次数/月|视觉理解资源池|
|---|---|---|
|Lite|100 次|5 小时 prompt，超限后 5 小时恢复|
|Pro|1,000 次|同上|
|Max|4,000 次|同上|

> 搜索 MCP 与网页读取 MCP **共享额度**；视觉理解 MCP **独立计费**。
## 5 故障排查

#### 5.1.1 配置不生效

- 关闭所有 Claude Code 进程
- **新建终端窗口**再启动
- 检查 `settings.json` 是否为合法 JSON（可用 [JSONLint](https://jsonlint.com/) 验证）
- 如仍无效，删除 `~/.claude/settings.json` 后重配

#### 5.1.2 API Key 无效

- 确认密钥复制完整（无多余空格）
- 确认密钥已在平台激活
- 确认账户有足够余额

#### 5.1.3 MCP 连接失败

- 检查网络与防火墙
    
- 验证 URL 是否正确（见各 MCP 文档）
    
- 视觉 MCP 可本地测试：
    
    ```bash
    Z_AI_API_KEY=your_api_key npx -y @z_ai/mcp-server
    ```

#### 5.1.4 卸载旧 MCP（重装前必做）

```bash
claude mcp list
claude mcp remove <server-name>
```
## 6 推荐版本与升级
- **查看版本**：
    
    ```bash
    claude --version
    ```
    
- **升级到最新版**：
    
    ```bash
    claude update
    ```
    

---

