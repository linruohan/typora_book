

# 0.1 【AI编程】Trae配置rules与配置和使用一些目前比较好用的MCP


[与Cursor结对编程的四个月，我大彻大悟了！](https://mp.weixin.qq.com/s?__biz=MjM5ODYwMjI2MA==&mid=2649795087&idx=1&sn=2b36718af933bbf34abd8640c0662f23&scene=21&poc_token=HHmXomijUa7zHCU3BE2sswM1l7U5hdSTHJq1A903)

## 1 学到了什么

- 无论是熟悉新项目，还是日常查代码、自动生成文档，它都为我节省了大量时间【这可能是AI的三个应用场景】
- 用 rules 建立协作共识：让 AI 懂你的 “做事规矩”：rules就是给AI定下的行为准则和沟通规范，用具体可执行的约束替代模糊的预期，让 AI 的输出能够精准贴合实际开发需求。
- _**mcp-feedback-enhanced**_ ，闭环沟通是减少浪费的关键 —— 把多轮交互压缩在单次请求里，本质是用工具固化 “提出需求→获取反馈→迭代优化” 的循环；
- _**mcp_better_tapd_server**_，使用这个MCP插件，总结自己的开发工作，印证了无缝衔接的智慧，让协作过程自动转化为任务记录，消除了 “开发” 与 “记录” 之间的割裂感。

## 2 具体使用：

### 2.1 配置项目rules

```
## 通用礼节 (General Etiquette)
- 优先保证代码简洁易懂。
- 别搞过度设计，简单实用就好。
- 写代码时，要注意圈复杂度，函数尽量小，尽量可以复用，尽量不写重复代码。
- 写代码时，注意模块设计，尽量使用设计模式。
- 给我解释代码的时候，说人话，别拽专业术语。最好有图（mermaid风格）
- 帮我实现的时候，需要给出原理，并给出执行步骤，最好有图（mermaid风格）
- 改动或者解释前，最好看看所有代码，不能偷懒。
- 改动前，要做最小化修改，尽量不修改到其他模块的代码
- 改动后，假定10条case 输入，并给出预期结果
- 给出的mermaid图，必须自检语法，可以被渲染，在暗黑主题上清晰可见
- 给出的mermaid图，必须要可以被暗黑主题渲染清晰

# 实验性规则 (Experimental Rule)
当你被要求修复一个 Bug 时，请遵循以下步骤：
1.  **理解问题 (Understand):** 仔细阅读 Bug 描述和相关代码，复述你对问题的理解。
2.  **分析原因 (Analyze):** 提出至少两种可能的根本原因。
3.  **制定计划 (Plan):** 描述你打算如何验证这些原因，并给出修复方案。
4.  **请求确认 (Confirm):** 在动手修改前，向我确认你的计划。
5.  **执行修复 (Execute):** 实施修复。
6.  **审查 (Review):** 查看自己的修改有没有问题。
7.  **解释说明 (Explain):** 解释你做了哪些修改以及为什么。

# MCP Interactive Feedback 规则
1. 在任何流程、任务、对话进行时，无论是询问、回复、或完成阶段性任务，皆必须调用 MCP mcp-feedback-enhanced。
2. 每当收到用户反馈，若反馈内容非空，必须再次调用 MCP mcp-feedback-enhanced，并根据反馈内容调整行为。
3. 仅当用户明确表示「结束」或「不再需要交互」时，才可停止调用 MCP mcp-feedback-enhanced，流程才算结束。
4. 除非收到结束指令，否则所有步骤都必须重复调用 MCP mcp-feedback-enhanced。
5. 完成任务前，必须使用 MCP mcp-feedback-enhanced 工具向用户询问反馈。

Always respond in 中文
```

### 2.2 提示词工程

在用了几个月AI后，我发现_**有提示词和没提示词出来的结果差距很大**_。所以我开始_**维护自己的提示词列表，当然目前还是很混乱还没形成一套体系，但是目前我的工作流程越来越偏向先整理提示词，然后再用提示词进行设置，之后再使用AI完成一些工作。**_

大家可以自己_**建立自己的提示词库**_，这里给大家一个_**生成提示词的提示词**_，先把下面那一段丢给AI，然后说你打算干嘛，接下来他会给你一段提示词，然后根据输出自己多交流几轮，然后把提示词备份下来后续使用。

#### 2.2.1 配置提示词的提示词

```
你是一个「提示词生成器」，为不同角色与任务产出简洁、高效、可复用的提示词。
使用方式：
先询问用户需要的角色/用途；若信息不足，最多追问3条关键点。
生成一条“可直接使用”的提示词，包含四部分：
角色与目标：1–2句，清楚定义身份与目的
调用步骤：2–4条，说明如何开始与执行
检查/行动清单：5–7点，明确关注要点
输出结构：规定回答格式与最终交付物
风格准则（自包含）：
只用短句与项目符号；避免背景铺陈与比喻
动词开头，措辞具体、可执行、可验收
不给实现细节或大段解释；不含样例代码（除非用户要求）
全文≤180字；不引用任何外部风格或模板
结尾要求：生成的提示词必须以清晰的“最终交付物”收束（如：修订文档、优先级清单、确认稿）。
```
## 3 MCP
```json
{
  "mcpServers": {
    "context7": {
      "timeout": 60,
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    },
    "sequential-thinking": {
      "disabled": false,
      "timeout": 60,
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "mcp-feedback-enhanced": {
      "autoApprove": ["interactive_feedback"],
      "disabled": false,
      "timeout": 600,
      "type": "stdio",
      "command": "uvx",
      "args": ["mcp-feedback-enhanced@latest"],
      "env": {
        "MCP_DESKTOP_MODE": "true",
        "MCP_WEB_PORT": "8765",
        "MCP_DEBUG": "false"
      }
    }
  }
}
```
- 无论是熟悉新项目，还是日常查代码、自动生成文档，它都为我节省了大量时间【这可能是AI的三个应用场景】
- 用 rules 建立协作共识：让 AI 懂你的 “做事规矩”：rules就是给AI定下的行为准则和沟通规范，用具体可执行的约束替代模糊的预期，让 AI 的输出能够精准贴合实际开发需求。
- _**mcp-feedback-enhanced**_ ，闭环沟通是减少浪费的关键 —— 把多轮交互压缩在单次请求里，本质是用工具固化 “提出需求→获取反馈→迭代优化” 的循环；
- _**mcp_better_tapd_server**_，使用这个MCP插件，总结自己的开发工作，印证了无缝衔接的智慧，让协作过程自动转化为任务记录，消除了 “开发” 与 “记录” 之间的割裂感。
### 3.1 _**mcp-feedback-enhanced - 智能反馈优化器**_

- 实时分析代码运行结果和用户反馈
- 自动调整代码风格和实现策略
- 构建个人化的最佳实践知识库
### 3.2 _**sequential-thinking - 逻辑推理引擎**_

- 将复杂开发任务拆解为可执行步骤
- 支持链式思考：需求分析 → 技术选型 → 代码实现 → 测试验证
- 可视化展示推理过程，每一步都清晰可控
### 3.3 context7 - 你的专属项目大脑

- 自动记录项目架构、依赖关系、命名规范
- 跨会话保持上下文，AI 永远记得你项目的 “个性”
- 基于 Upstash 云存储，毫秒级访问项目历史
## 4 使用
安装uv

```
pip install uv
```
出现进度条代表正常安装，安装成功后，验证一下版本  
![img](https://i-blog.csdnimg.cn/img_convert/44dc818758814da11bb08485235bb40e.png)
第三步：MCP配置
```
{
    "mcp-feedback-enhanced": {
      "autoApprove": ["interactive_feedback"],
      "disabled": false,
      "timeout": 600,
      "type": "stdio",
      "command": "uvx",
      "args": ["mcp-feedback-enhanced@latest"],
      "env": {
        "MCP_DESKTOP_MODE": "true",
        "MCP_WEB_PORT": "8765",
        "MCP_DEBUG": "false"
      }
    }
  }
}
```

第四步：编辑器会自动更新MCP配置
绿色点点，表明配置成功了
![img](https://i-blog.csdnimg.cn/img_convert/3b63230519ca5755a166de8786a9b47a.png)
测试一下是否成功

```
uvx mcp-feedback-enhanced@latest test
```

测试成功

![img](https://i-blog.csdnimg.cn/img_convert/488efabc8b1ed9794fc0e21b3b15bae7.png)
### 4.1 参考资料
1. https://www.cnblogs.com/asahi-front/p/18937936
2. https://github.com/orgs/modelcontextprotocol/discussions/20
3. https://github.com/Minidoracat/mcp-feedback-enhanced
4. https://mp.weixin.qq.com/s/skTTPItRab7ZGda5WSm5wA