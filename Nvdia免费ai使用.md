## 1 一、前言

最近 **英伟达（NVIDIA）** 在 Build 平台开放了多个开源大模型的 API 接口，开发者可以免费申请使用。
### 1.1 🎁-免费政策亮点

- ✅ 无总调用次数限制（官方未标明总额度）
- ✅ 仅限制速率：**每分钟 40 次请求**
- ✅ 支持邮箱注册
- ✅ 支持 +86 手机号验证（实测可用）
- ✅ API 兼容 OpenAI 接口格式
- ✅ 支持在线 Playground 测试
- ✅ 支持通过 API Key 接入第三方客户端

如果你想找一个稳定、免费的模型 API 进行测试、学习或日常使用，这个平台非常值得体验。

# 二、注册与获取-API-Key

## 1 1️⃣-注册账号

访问官网：https://build.nvidia.com/
使用邮箱注册账号即可。
## 2 2️⃣-手机号验证

为了防止滥用，平台需要进行手机号验证。
📌 实测说明：
- 支持 +86 中国大陆手机号
- 验证过程较快
- 没有额外门槛

验证成功后即可进入控制台。

## 3 3️⃣-生成-API-Key 

登录成功后：
1. 进入控制台（Dashboard）
2. 找到 API Keys 相关页面
3. 点击 **Generate API Key**
4. 复制并保存密钥

⚠️ 注意：
- API Key 只显示一次
- 请务必妥善保存
- 不要公开泄露

# 三、支持的模型与使用方式

英伟达开放了多个开源模型 API，包括：
机器学习与人工智能
- **Kimi-K2.5**
- **GLM-4.7**
- Llama 系列
- Qwen 系列
- DeepSeek 系列
- Mistral 系列
- 以及部分高参数模型版本

其中，**Kimi-K2.5 和 GLM-4.7 是当前讨论度和使用频率较高的两款模型**，非常值得优先体验。

这些模型支持：

- 在线 Playground 测试
- 通过 API 调用
- 兼容 OpenAI Chat Completion 接口格式

API 基础地址：

|   |
|---|
|https://integrate.api.nvidia.com/v1|
调用方式与 OpenAI API 基本一致，因此很多第三方客户端都可以直接接入。
下面做一个简单对比，方便快速选择：

|模型|中文能力|推理能力|代码能力|长文本|稳定性|推荐场景|
|---|---|---|---|---|---|---|
|Kimi-K2.5|⭐⭐⭐⭐⭐|⭐⭐⭐⭐☆|⭐⭐⭐⭐☆|⭐⭐⭐⭐☆|⭐⭐⭐⭐☆|日常对话、创作、综合使用|
|GLM-4.7|⭐⭐⭐⭐⭐|⭐⭐⭐⭐☆|⭐⭐⭐⭐|⭐⭐⭐⭐|⭐⭐⭐⭐⭐|总结、学习、结构化输出|
|Qwen 系列|⭐⭐⭐⭐☆|⭐⭐⭐⭐|⭐⭐⭐⭐☆|⭐⭐⭐⭐|⭐⭐⭐⭐|中文 + 代码平衡型|
|DeepSeek|⭐⭐⭐⭐|⭐⭐⭐⭐⭐|⭐⭐⭐⭐|⭐⭐⭐|⭐⭐⭐⭐|复杂推理、数学|
|Llama|⭐⭐⭐|⭐⭐⭐⭐|⭐⭐⭐⭐|⭐⭐⭐|⭐⭐⭐⭐|英文任务、通用问答|
|Mistral|⭐⭐⭐|⭐⭐⭐|⭐⭐⭐|⭐⭐|⭐⭐⭐⭐|轻量场景、快速响应|

```bash
abacusai/dracarys-llama-3.1-70b-instruct
google/gemma-3n-e2b-it
google/gemma-3n-e4b-it
meta/llama-3.1-70b-instruct
meta/llama-3.1-8b-instruct
meta/llama-3.2-11b-vision-instruct
meta/llama-3.3-70b-instruct
meta/llama-4-maverick-17b-128e-instruct
minimaxai/minimax-m2.5
mistralai/magistral-small-2506
mistralai/ministral-14b-instruct-2512
mistralai/mistral-nemotron
mistralai/mistral-small-4-119b-2603
mistralai/mixtral-8x22b-instruct-v0.1
mistralai/mixtral-8x7b-instruct-v0.1
moonshotai/kimi-k2-instruct
moonshotai/kimi-k2-thinking
moonshotai/kimi-k2.6
nvidia/ising-calibration-1-35b-a3b
nvidia/llama-3.1-nemotron-nano-vl-8b-v1
nvidia/llama-3.1-nemotron-safety-guard-8b-v3
nvidia/llama-3.3-nemotron-super-49b-v1
nvidia/llama-3.3-nemotron-super-49b-v1.5
nvidia/nemotron-3-content-safety
nvidia/nemotron-3-nano-30b-a3b
nvidia/nemotron-3-nano-omni-30b-a3b-reasoning
nvidia/nemotron-3-super-120b-a12b
nvidia/nemotron-content-safety-reasoning-4b
nvidia/nemotron-nano-12b-v2-vl
nvidia/nvidia-nemotron-nano-9b-v2
nvidia/riva-translate-4b-instruct-v1.1
openai/gpt-oss-120b
openai/gpt-oss-20b
qwen/qwen3-coder-480b-a35b-instruct
qwen/qwen3-next-80b-a3b-instruct
qwen/qwen3-next-80b-a3b-thinking
qwen/qwen3.5-122b-a10b
stepfun-ai/step-3.5-flash
stockmark/stockmark-2-100b-instruct
```

plugin install
```bash
# claude-mem 
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem
  
  
# superpowers  
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```