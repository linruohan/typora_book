
## 1 优化方案
 `nightly-x86_64-pc-windows-gnu` 工具链

|方案|提速阶段|复杂度|推荐指数|
|---|---|---|---|
|**更换 LLD/Mold 链接器**|链接阶段 (Linking)|低|⭐⭐⭐⭐⭐|
|**开启增量编译**|代码生成|极低 (默认)|⭐⭐⭐⭐⭐|
|**使用 sccache**|依赖编译|中|⭐⭐⭐⭐|
|**拆分庞大的 Crate**|全阶段|高|⭐⭐⭐|
|**增加内存/升级 CPU**|全阶段|钱|⭐⭐⭐⭐⭐|

导出到 Google 表格
### 1.1 配置 `.cargo/config.toml` 优化

- 添加 LLD 链接器（GNU 工具链支持）
- 优化编译标志
- 启用增量编译和并行编译
```bash

[target.x86_64-pc-windows-gnu]
linker = "x86_64-w64-mingw32-gcc"
rustflags = [
    "-C", "link-args=-Wl,--stack,8000000",
    # 使用 LLD 链接器加速链接（如果可用）
    "-C", "link-arg=-fuse-ld=lld",
    # 优化代码生成
    "-C", "codegen-units=256",
    # 减少调试信息
    "-C", "debuginfo=0",
    # 启用增量编译
    "-C", "incremental=true",
]

[build]
# 启用并行编译 10为系统cpu核数
jobs = 10
```
- ✅ 添加了 LLD 链接器 (`-C link-arg=-fuse-ld=lld`) 来加速链接阶段 https://github.com/llvm/llvm-project/releases
	- https://github.com/llvm/llvm-project/releases/download/llvmorg-22.1.0-rc3/LLVM-22.1.0-rc3-win64.exe
- ✅ 设置了 `codegen-units=256` 以加快增量编译
- ✅ 减少了调试信息 (`-C debuginfo=0`)
- ✅ 启用了增量编译 (`-C incremental=true`)
- ✅ 启用了并行编译 (`jobs = num_cpus`)
#### 1.1.1 换用更快的链接器（Linker）—— **最高效**
Rust 编译过程中，很大一部分时间花在了最后的“链接”阶段。默认的链接器（尤其是 Linux/Windows 上）速度较慢。
- **Mold (Linux) / Sold (macOS)**: 目前最快的链接器。
- **LLD (Windows/macOS/Linux)**: LLVM 自带的链接器，比默认的快很多。

**设置方法**：在项目根目录（或全局 `~/.cargo/config.toml`）添加以下配置：
Ini, TOML
```
# .cargo/config.toml
[target.x86_64-unknown-linux-gnu]
rustflags = ["-C", "link-arg=-fuse-ld=mold"]

# 或者在 Windows (需安装 lld)
[target.x86_64-pc-windows-msvc]
rustflags = ["-C", "link-arg=-fuse-ld=lld"]
```
### 1.2 使用 Cranelift 进行开发构建

**Cranelift** 是一个新的后端，旨在牺牲一部分运行性能来换取极快的代码生成速度。它非常适合 `debug` 模式。
- **要求**：使用 Rust Nightly 版本。
- **方法**：安装 `rustc-codegen-cranelift` 组件并在编译时启用。这在大型项目中能减少约 30%-50% 的编译时间。
```bash
rustup default nightly
rustup update nightly
# 安装 Cranelift 组件
rustup component add rustc-codegen-cranelift-preview

```
在 `Cargo.toml` 或 `.cargo/config.toml` 中指定：
```
[profile.dev]
codegen-backend = "cranelift"
```

启用不稳定功能（在 `.cargo/config.toml`）：

```
[unstable]
codegen-backend = true
```

运行时使用 `-Z codegen-backend` 标志：

```
cargo build -Z codegen-backend
```
### 1.3 优化 `Cargo.toml`

- 增加 dev profile 的 codegen-units
- 对所有依赖使用 opt-level = 3
- 优化 tokio 的 features
```bash

[profile.dev]
codegen-units = 256
debug = 0 # 减少调试信息（如果你不需要断点调试） 
incremental = true # 确保开启增量编译（默认已开启）

[profile.dev.package]
# 对所有依赖使用最高优化级别以加速编译
"*" = { opt-level = 3 }
# 针对所有依赖项开启优化（依赖项不常变动，提前优化可加速后续编译） 
[profile.dev.package."*"] 
opt-level = 3
```

### 1.4 优化 部分crate 的 features，从 `full` 改为只包含需要的 features。

```bash
# tokio = { version = "1.49.0", features = ["full"] }
tokio = { version = "1.49.0", features = ["rt-multi-thread", "macros", "fs", "io-util", "time", "sync"] }
```
### 1.5 使用 sccache 缓存 Crate

`sccache` 是 Mozilla 开发的工具，它可以跨项目缓存已编译的依赖项。如果你经常切换分支或清理 `target` 目录，它能节省大量重复编译时间。
- **安装**：`cargo install sccache`
- **配置**：在环境变量中设置 `RUSTC_WRAPPER=sccache`。
    ```
    cargo install sccache
    set RUSTC_WRAPPER=sccache
    ```
```toml
[build]
rustc-wrapper = "/path/to/sccache"
```
Note that you need to use cargo 1.40 or newer for this to work.
Alternatively you can use the environment variable `RUSTC_WRAPPER`:
```bash
export RUSTC_WRAPPER=/path/to/sccache
cargo build
```
### 1.6 减少泛型代码膨胀
Rust 的泛型会在每个调用的地方进行**单态化（Monomorphization）**，这会产生大量机器码并增加编译负担。
- **技巧**：尽量使用 `&dyn Trait`（动态分发）代替 `impl Trait` 或 `T: Trait`（静态分发），如果该部分代码不是性能核心。
- **提取非泛型辅助函数**：将泛型函数中与类型无关的部分抽离成普通函数。
### 1.7 查看构建耗时
你可以先运行 `cargo build --timings`。这会生成一份 HTML 报告，直观地告诉你到底是哪个 Crate 或者哪个编译阶段最慢。
## 2 清理并重新编译
应用这些更改后，建议执行一次清理编译：
```cmd
cargo clean
cargo build
```

这些优化应该能显著提升你的编译和构建速度，特别是在开发过程中的增量编译。LLD 链接器和增加的 codegen-units 应该会带来最明显的性能提升。