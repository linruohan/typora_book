## 1 配置 Claude Code 连接本地 Ollama

```bash
export ANTHROPIC_AUTH_TOKEN=ollama
export ANTHROPIC_BASE_URL=http://localhost:11434
# 启动 Claude Code 并指定本地模型
claude --model qwen2.5-coder:7b

# 如果想使用云端模型，命令类似
claude --model glm-4.6:cloud
```
## 2 调试秘籍：如何与 AI 高效沟通报错？

这里再说一个调试的技巧：在配置过程中，不要死磕枯燥的错误堆栈信息。一个高效的调试技巧是：**向 AI 描述你的完整环境和所做的工作，而不仅仅是报错代码。**

此前我按照文档编写代码时，一直遇到 `InternalServerError (503)` 错误。我直接把错误代码粘贴给 chatgpt ，它尝试了很多方法但始终没有解决。
于是，我换了一种思路，不是直接粘贴错误代码，而是前置一步，客观地描述了一下当前的环境。
chatgpt立刻就发现了问题，并给到我正确的执行代码。
根据这次调试过程，大模型也帮我总结一个更有效的提问模板：

```bash
1.贴出当前代码。
2.描述环境（如：Mac 系统、本地有代理）。
3.提供一个对比参照（如：JS 版本可以运行，Python 不行）。
```