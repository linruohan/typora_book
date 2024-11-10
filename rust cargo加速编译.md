## 1 Rust Insights
# 加快 Rust 编译时间的技巧
!加快 Rust 编译时间的技巧
**Rust 构建缓慢？**
## 1 一般提示
### 1.1 更新 Rust 编译器和工具链
确保使用最新的 Rust 版本：
```bash
rustup update
```
使 Rust 编译器更快是一个 [持续的过程](https://blog.mozilla.org/nnethercote/2020/04/24/how-to-speed-up-the-rust-compiler-in-2020/) 。 由于他们的努力，编译器速度全面提高了 [30-40% 年初至今，一些项目实现了高达 45%+ 的改进](https://www.reddit.com/r/rust/comments/cezxjn/compiler_speed_has_improved_3040_across_the_board/) 。让您的工具链保持最新是值得的。
### 1.2 使用 cargo check 而不是 cargo build
```bash
# Slow 🐢
cargo build
# Fast 🐇 (2x-3x speedup)
cargo check
```
大多数时候，您甚至根本不需要 _编译_ 您的项目;您只需 想知道你是不是搞砸了什么地方。只要有可能， **就跳过编译 完全** 。相反，您需要的是激光快速的代码 linting、type- 和 借款检查。
用 `cargo check` 而不是 `cargo build` 尽可能。 它只会检查您的代码是否有错误，但不会生成可执行的二进制文件。
考虑 `cargo check` 上 左侧和 `cargo debug` 在中间。（注意不同的 比例。
!加速因子：检查 1，调试 5，选项 20
我使用的一个妙招是在后台运行它 [`cargo watch`](https://github.com/passcod/cargo-watch)。这样，它将 `cargo check` 每当您更改文件时。
**奖励** ：使用 `cargo watch -c` 可在每次运行前清除屏幕。
### 1.3 切换到新的 Parallel Compiler 前端
**在 nightly 中** ，您现在可以启用新的并行编译器前端。 要试用它，请使用 `-Z threads=8` 选择：
```sh
RUSTFLAGS="-Z threads=8" cargo +nightly build
```
如果您发现它对您来说效果很好，您可以通过添加 `-Z threads=8` 发送到您的 `~/.cargo/config.toml` 文件：
```toml
[build]
rustflags = ["-Z", "threads=8"]
```
或者，您可以为 `cargo` 在 shell 的配置文件中（例如 `~/.bashrc` 或 `~/.zshrc`）：
```sh
alias cargo="RUSTFLAGS='-Z threads=8' cargo +nightly"
```
当前端在多线程设置中执行时，使用 `-Z threads=8`、 实际代码的基准测试表明，编译时间可能会减少 AS 远至 [50%。](https://blog.rust-lang.org/2023/11/09/parallel-rustc.html) 但是，增益会根据正在编译的代码而波动。是的 不过，当然值得一试。
以下是并行编译器前端的可视化效果：
!并行编译器的结果
在 Rust 的官方公告中了解更多信息 [博客](https://blog.rust-lang.org/2023/11/09/parallel-rustc.html) 。
### 1.4 删除未使用的依赖项
```bash
cargo install cargo-machete && cargo machete
```
依赖项有时会在重构后过时。不时 它有助于检查是否可以删除任何未使用的依赖项。
此命令将列出项目中所有未使用的依赖项。
```sh
Analyzing dependencies of crates in this directory...
cargo-machete found the following unused dependencies in <project>:
crate1 -- <project>/Cargo.toml:
        clap
crate2 -- <project>/crate2/Cargo.toml:
        anyhow
        async-once-cell
        dirs
        log
        tracing
        url
```
### 1.5 更新依赖项
1. 跑 `cargo update` 更新到最新的 [SEMVER](https://semver.org/) 兼容版本。
2. 跑 [`cargo outdated -wR`](https://github.com/kbknapp/cargo-outdated) 查找更新的、可能不兼容的依赖项。 根据需要更新这些并修复代码。
3. 跑 `cargo tree --duplicate` 来查找具有多个版本的依赖项。 旨在通过更新依赖于旧版本的依赖项来整合到单个版本。 （感谢 /u/dbdr 的 [指出这一点](https://www.reddit.com/r/rust/comments/hdb5m4/tips_for_faster_rust_compile_times/fvm1r2w/) 。
（ [Reddit 上 /u/oherrala 的说明](https://www.reddit.com/r/rust/comments/gi7v2v/is_it_wrong_of_me_to_think_that_rust_crates_have/fqe848y) 。
最重要的是，使用 [`cargo audit`](https://github.com/RustSec/cargo-audit) 自 获取有关需要解决或弃用的任何漏洞的通知 需要更换的 crate 的 crate 的 c.
### 1.6 在代码库中找到 slow crate
```sh
cargo build --timings
```
这提供了有关每个 crate 编译需要多长时间的信息。
!货物建造图 - 时间
此图中的红线显示了 当前等待编译（并被另一个 crate 阻塞）。 如果单个 crate 上有大量 crate 卡住，请将 注意改进那个 crate 以提高并行度。
颜色的含义：
- _正在等待_ （红色） – 等待 CPU 插槽打开的板条箱。
- _Inactive_ （蓝色） – 正在等待其依赖项完成的 Crate。
- _活动_ （绿色） – 当前正在编译的 Crate。
文档中提供了更多信息 [in the documentation](https://doc.rust-lang.org/cargo/reference/timings.html)。
### 1.7 Profile 编译时间
如果你喜欢深入挖掘 `cargo --timings`，Rust 编译可以使用 [`cargo rustc -- -Zself-profile`](https://blog.rust-lang.org/inside-rust/2020/02/25/intro-rustc-self-profile.html#profiling-the-compiler)。 生成的跟踪文件可以使用火焰图或 Chromium 进行可视化 分析器：
!包含所有 crate 的 Chrome 分析器的图像
另一个金色的 [`cargo-llvm-lines`](https://github.com/dtolnay/cargo-llvm-lines)，其中显示 生成的行数和每个泛型函数的副本数 final 二进制文件。这可以帮助您确定哪些函数最昂贵 进行编译。
```
$ cargo llvm-lines | head -20
  Lines        Copies         Function name
  -----        ------         -------------
  30737 (100%)   1107 (100%)  (TOTAL)
   1395 (4.5%)     83 (7.5%)  core::ptr::drop_in_place
    760 (2.5%)      2 (0.2%)  alloc::slice::merge_sort
    734 (2.4%)      2 (0.2%)  alloc::raw_vec::RawVec<T,A>::reserve_internal
    666 (2.2%)      1 (0.1%)  cargo_llvm_lines::count_lines
    490 (1.6%)      1 (0.1%)  <std::process::Command as cargo_llvm_lines::PipeTo>::pipe_to
    476 (1.5%)      6 (0.5%)  core::result::Result<T,E>::map
    440 (1.4%)      1 (0.1%)  cargo_llvm_lines::read_llvm_ir
    422 (1.4%)      2 (0.2%)  alloc::slice::merge
    399 (1.3%)      4 (0.4%)  alloc::vec::Vec<T>::extend_desugared
    388 (1.3%)      2 (0.2%)  alloc::slice::insert_head
    366 (1.2%)      5 (0.5%)  core::option::Option<T>::map
    304 (1.0%)      6 (0.5%)  alloc::alloc::box_free
    296 (1.0%)      4 (0.4%)  core::result::Result<T,E>::map_err
    295 (1.0%)      1 (0.1%)  cargo_llvm_lines::wrap_args
    291 (0.9%)      1 (0.1%)  core::char::methods::<impl char>::encode_utf8
    286 (0.9%)      1 (0.1%)  cargo_llvm_lines::run_cargo_rustc
    284 (0.9%)      4 (0.4%)  core::option::Option<T>::ok_or_else
```
### 1.8 替换繁重的依赖项
有时，货比三家寻找更轻便的替代品会有所帮助 流行的 crates。
再 `cargo tree` 是您的朋友在这里帮助您了解哪个 依赖项非常 _重_ ：它们需要许多其他 crate，因为 过多的网络 I/O 并减慢构建速度。然后搜索打火机 选择。
也 [`cargo-bloat`](https://github.com/RazrFalcon/cargo-bloat) 具有 `--time` 标志，该标志显示每个 crate 的构建时间。非常方便！
以下是一些示例：

| 板条箱                                              | 另类                                                                                                    |
| ------------------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| [serde](https://github.com/bnjbvr/cargo-machete) | [Miniserde](https://github.com/dtolnay/miniserde) ， [Nanoserde](https://github.com/not-fl3/nanoserde) |
| [要求西](https://github.com/seanmonstar/reqwest)    | [UREQ](https://github.com/algesten/ureq)                                                              |
| [拍](https://github.com/clap-rs/clap)             | [Lexopt](https://github.com/blyxxyz/lexopt)                                                           |
下面是一个示例，其中切换 crate 将编译时间从 [2：22 分钟缩短到 26 秒](https://blog.kodewerx.org/2020/06/the-rust-compiler-isnt-slow-we-are.html) 。
### 1.9 使用 WorkSpaces 将大 crate 拆分为小 crate
Cargo 有一个叫 [做 workspaces](https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html) 的简洁功能，它允许你拆分一个 大板条箱转换为多个较小的板条箱。这种代码拆分非常适合避免 重复编译，因为只有有更改的 crate 才需要重新编译。 更大的项目，如 [servo](https://github.com/servo/servo/blob/master/Cargo.toml) 和 [向量](https://github.com/timberio/vector/blob/1629f7f82e459ae87f699e931ca2b89b9080cfde/Cargo.toml#L28-L34) 大量使用 WorkSpaces 以减少编译时间。
### 1.10 禁用 Crate 依赖项的未使用功能
[`cargo-features-manager`](https://github.com/ToBinio/cargo-features-manager) 是一个相对较新的工具，可帮助您禁用依赖项中未使用的功能。
```sh
cargo install cargo-features-manager
cargo features prune
```
请不时检查依赖项的功能标志。很多 库维护者努力将他们的 crate 拆分为单独的功能 这可以根据需要关闭。也许您不需要所有默认值 功能？
例如 `tokio` 拥有 [大量的 特征](https://github.com/tokio-rs/tokio/blob/2bc6bc14a82dc4c8d447521005e044028ae199fe/tokio/Cargo.toml#L26-L91) 如果不需要，您可以禁用它。
另一个例子是 `bindgen`，它启用 `clap` 默认支持 binary usage 的 Binary 用法。库使用不需要这样做，这是常见的用例。 禁用该功能 [将 rust-rocksdb 的编译时间缩短了 ~13 秒和 ~9 秒 用于调试和发布版本 分别](https://github.com/rust-rocksdb/rust-rocksdb/pull/491) 。由于 读者 [Lilian Anatolie Moraru](https://github.com/lilianmoraru) 提及 这。
#### 1.10.1 公平警告
似乎关闭功能并不总是能改善 编译时。（参见 [TiKV 的经历 这里](https://github.com/tikv/tikv/pull/4453#issuecomment-481789292) 。 通过减少代码的攻击面来提高安全性可能仍然是一个好主意。 此外，禁用功能可以帮助精简依赖项树。
使用 `cargo add`。
如果你想查找 crate 的功能标志，它们列在 [docs.rs](https://docs.rs/) . 例如，查看 [tokio 的功能 标志](https://docs.rs/crate/tokio/latest/features) 。
删除未使用的功能后，请检查 `Cargo.lock` file 设置为 查看所有已清理的不必要的依赖项。
### 1.11 为昂贵的代码添加功能
```toml
[features]
# Basic feature for default functionality
default = []
# Optional feature for JSON support
json = ["serde_json"]
# Another optional feature for more expensive or complex code
complex_feature = ["some-expensive-crate"]
```
并非项目中的所有代码的编译成本都相同。您可以使用 Cargo 功能将您的代码拆分为更精细的更小的块 水平比板条箱。这样，您可以只编译所需的功能。
这是库的常见做法。例如 `serde` 具有 叫 `derive` 支持为序列化生成代码，并且 反序列化。它并不总是需要的，因此默认情况下处于禁用状态。 同样地 `Tokio` 和 `reqwest` 具有许多可以启用的功能，或者 禁用。
您可以在代码中执行相同的操作。在上面的示例中， `json` 特征 在 `Cargo.toml` 启用 JSON 支持，而 `complex_feature` 特征 启用另一个昂贵的代码路径。
### 1.12 使用 sccache 的缓存依赖关系
另一个简洁的项目是 [sccache](https://github.com/mozilla/sccache) by Mozilla，它缓存编译后的 crate 以避免重复编译。
我在笔记本电脑上运行了一段时间，但好处是相当 老实说，可以忽略不计。如果你在很多独立的 共享依赖项的项目（在同一版本中）。一个常见的用例是 共享生成服务器。
### 1.13 Cranelift：Rust 编译器的替代方案
您知道吗，Rust 项目正在使用替代方案 编译器与 `rustc` 对于每个 CI 构建？
[rustc_codegen_cranelift](https://github.com/bjorn3/rustc_codegen_cranelift) ， 也称为 `CG_CLIF`是 Rust 编译器的实验性后端，它 基于 [Cranelift](https://cranelift.dev/) 编译器框架。
以下是 `rustc` 和 Cranelift 用于一些流行的板条箱（蓝色 意味着更好）：
!rustc 和 cranelift 的 LLVM 编译时比较有利于 cranelift
编译器将创建完全有效的可执行二进制文件。它们不会得到优化 同样多，但它们对本地发展非常有用。
更详细的文章是关于 [Jason Williams 的 页面](https://jason-williams.co.uk/a-possible-new-backend-for-rust) 和 项目代码在 [Github 上](https://github.com/bjorn3/rustc_codegen_cranelift) 。
### 1.14 切换到更快的链接器
#### 1.14.1 什么是链接器？
[链接器](https://en.wikipedia.org/wiki/Linker_(computing)) 是一种工具 将多个目标文件合并到一个可执行文件中。  
这是编译过程的最后一步。
您可以通过运行以下命令来检查您的链接器是否是瓶颈：
```
cargo clean
cargo +nightly rustc --bin <your_binary_name> -- -Z time-passes
```
它将输出每个步骤的计时，包括链接时间：
```
...
time:   0.000   llvm_dump_timing_file
time:   0.001   serialize_work_products
time:   0.002   incr_comp_finalize_session_directory
time:   0.004   link_binary_check_files_are_writeable
time:   0.614   run_linker
time:   0.000   link_binary_remove_temps
time:   0.620   link_binary
time:   0.622   link_crate
time:   0.757   link
time:   3.836   total
    Finished dev [unoptimized + debuginfo] target(s) in 42.75s
```
如果 `link` step 很慢，你可以尝试切换到更快的替代方案：

|连接|平台|生产就绪|描述|
|---|---|---|---|
|[`lld`](https://lld.llvm.org/)|Linux/macOS|是的|系统链接器的直接替代品|
|[`mold`](https://github.com/rui314/mold)|Linux的|[是的](https://github.com/bluewhalesystems/sold)|针对 Linux 进行了优化|
|[`zld`](https://github.com/michaeleisel/zld)|macOS|否 （已弃用）|Apple 的直接替代品 `ld` 连接|
### 1.15 使用暂存盘加快构建速度
您的文件系统可能是瓶颈。考虑使用内存中文件系统 就像你的 build 目录一样。
传统的临时文件系统，如 `tmpfs` 仅限于您的 RAM 和交换空间，并且对于创建大型中间工件的构建可能会有问题。
相反，在 Linux 上，挂载 `ext4` volume 替换为以下选项：
```
-o noauto_da_alloc,data=writeback,lazytime,journal_async_commit,commit=999,nobarrier
```
如果您有足够的 RAM，这会将文件存储在页面缓存中，稍后会发生写回。将此视为临时文件系统，因为数据可能会在崩溃或断电后丢失或损坏。
致谢归 [Reddit 上的 /u/The_8472](https://www.reddit.com/r/rust/comments/1ddgatd/compile_rust_faster_some_tricks/l85gzy8/) 。
### 1.16 仅限 macOS：更快的增量调试版本
Rust 1.51 添加了一个标志，用于更快地进行增量调试构建 macOS 的。它可以使调试构建速度提高数秒（具体取决于您的用例）。 一些工程师 [报告](https://jakedeichert.com/blog/reducing-rust-incremental-compilation-times-on-macos-by-70-percent/) 说，仅此标志就可以将 macOS 上的编译时间缩短 **70%。** .
将此添加到您的 `Cargo.toml`：
```toml
[profile.dev]
split-debuginfo = "unpacked"
```
该标志可能很快就会成为 macOS 的标准。它已经是 [默认的 每晚。](https://github.com/rust-lang/cargo/pull/9298) .
### 1.17 调整 Codegen 选项和编译器标志
Rust 为代码提供了大量的 [设置 代](https://doc.rust-lang.org/rustc/codegen-options) 。它可以帮助 浏览列表并调整项目的参数。
**many** codegen 的完整列表中有许多 gem [选项](https://doc.rust-lang.org/rustc/codegen-options) 。如需灵感， 这是 [Bevy 的更快配置 编译](https://github.com/bevyengine/bevy/blob/3a2a68852c0a1298c0678a47adc59adebe259a6f/.cargo/config_fast_builds) 。
### 1.18 避免程序宏 crate
如果您在项目中大量使用过程宏（例如，如果您使用 serde）， `Cargo.toml`。
```toml
[profile.dev.build-override]
opt-level = 3
```
正如读者 [jfmontanaro](https://github.com/jfmontanaro) 在 [Github](https://github.com/mre/endler.dev/issues/53) 的：
> 我认为它有助于构建时间的原因是因为它仅适用于 构建脚本和 proc-macros。构建脚本和 proc-macro 是唯一的，因为 在正常构建期间，它们不仅会被编译，还会被执行（在 如果是 proc-macro，它们可以重复执行）。当您的项目使用 大量的 proc 宏，优化宏本身理论上可以节省很多 时间。
另一种方法是尝试回避宏对编译时间的影响 [watt](https://github.com/dtolnay/watt) ，一种卸载宏编译的工具 到 Webassembly。
来自文档：
> 通过提前将宏编译到 Wasm，我们可以保存 macro 不必自己编译宏 logic 或其依赖项。
> 
> 相反，他们编译的是一个小型的自包含 Wasm 运行时（~3 秒， 由所有宏共享）和一个小的 proc 宏填充码，用于手头的每个宏板条箱 off Wasm 字节码进入 Watt 运行时（每个 proc-macro crate 你 ~0.3 秒 取决于）。这比编译所需的 20+ 秒要短得多 复杂的过程宏及其依赖项。
请注意，这个 crate 仍处于实验阶段。
### 1.19 过程宏的条件编译
过程宏需要解析 Rust 代码，这是一个相对复杂的 任务。依赖于过程宏的 crate 将必须等待 过程宏进行编译。例如 `serde` 可以是 编译时间的瓶颈，可能会限制 CPU 利用率。
为了缩短 Rust 编译时间，请考虑一种处理 使用 Serde 进行序列化，尤其是在具有共享 crate 结构的项目中。 而不是将 Serde 直接放置在跨不同部分使用的共享 crate 中 中，你可以通过 Cargo 将 Serde 设为可选的依赖项 特征。
使用 `cfg` 或 `cfg_attr` attributes 来使用 Serde 和 `derive` 在 共享 crate 功能门控。这样，它就变成了一个可选的依赖项，即 仅在实际执行 序列化/反序列化。
这种方法可以防止整个项目等待 Serde 依赖项，如果 Serde 是非可选的直接 共享 crate 的依赖项。
让我们用一个简化的示例来说明这一点。假设您有一个 Rust 项目 替换为共享库 crate 和一些依赖于它的其他 crate。你不需要 想要在构建项目的某些部分时不必要地编译 Serde，这些 不需要它。
以下是构建项目以使用 Cargo 中的可选功能的方法：
在您的 `Cargo.toml` 对于共享的 crate，将 serde 声明为可选依赖项：
```toml
[package]
name = "shared"
version = "0.1.0"
edition = "2021"
[dependencies]
serde = { version = "1.0", optional = true }
```
在这个 crate 中，使用 conditional compilation 仅在启用该功能时包含 serde：
```rust
#[cfg(feature = "serde")]
use serde::{Serialize, Deserialize};
#[cfg_attr(feature = "serde", derive(Serialize, Deserialize))]
pub struct MySharedStruct {
    // Your struct fields
}
```
在其他 crate 中，启用 `serde` 功能：
```toml
[package]
name = "other"
version = "0.1.0"
edition = "2021"
[dependencies]
shared = { path = "../shared", features = ["serde"] }
```
您现在可以使用 `MySharedStruct` 启用 Serde 的功能 而不会使不需要它的 crate 的汇编膨胀。
### 1.20 泛型：使用内部非泛型函数
如果你有一个泛型函数，它将为你使用的每种类型进行编译 跟。如果您有很多不同的类型，这可能是一个问题。
一种常见的解决方案是使用内部非泛型函数。这样， compiler 只会编译一次内部函数。
这是 standard 库中经常使用的技巧。例如，下面是 实现 [`read_to_string`](https://github.com/rust-lang/rust/blob/ae612bedcbfc7098d1711eb35bc7ca994eb17a4c/library/std/src/fs.rs#L295-L304)：
```rust
pub fn read_to_string<P: AsRef<Path>>(path: P) -> io::Result<String> {
    fn inner(path: &Path) -> io::Result<String> {
        let mut file = File::open(path)?;
        let size = file.metadata().map(|m| m.len() as usize).ok();
        let mut string = String::with_capacity(size.unwrap_or(0));
        io::default_read_to_string(&mut file, &mut string, size)?;
        Ok(string)
    }
    inner(path.as_ref())
}
```
您可以在代码中执行相同的操作：外部函数是泛型 （generic），而 它调用内部非泛型函数，该函数执行实际工作。
### 1.21 使用 cargo-hakari 缩短工作区构建时间
您是否有一个大型 Rust 工作区，其依赖项 在多个 crate 中使用，但具有不同的功能集？
这可能会导致构建时间较长，因为 Cargo 会构建多个依赖项 具有不同功能的 times 取决于构建的 crate。这是 哪里 [`cargo-hakari`](https://docs.rs/cargo-hakari/latest/cargo_hakari/about/index.html) 进来了。 它是一个旨在自动管理 “workspace-hack” crate 的工具。
在某些情况下，这可以将连续构建时间缩短多达 50% 或更多。 要了解更多信息，请查看 [官方 cargo-hakari 文档中](https://docs.rs/cargo-hakari/latest/cargo_hakari/about/index.html) 的使用说明和基准。
### 1.22 使用 dylibs 加速增量 Rust 编译
```sh
# Install the tool
cargo install cargo-add-dynamic
# Add a dynamic library to your project
cargo add-dynamic polars --features csv-file,lazy,list,describe,rows,fmt,strings,temporal
```
这将创建一个 wrapper-crate 围绕 `polars` 编译为动态 库 （ `.so` 在 Linux 上， `.dylib` 在 macOS 上， `.dll` 在 Windows 上）。
本质上，它使用
```toml
[lib]
crate-type = ["dylib"]
```
使用此技巧，您可以节省依赖项的链接时间 当您只更改自己的代码时。依赖项本身只会是 在更改功能或版本时重新编译。 当然，这适用于任何 crate，而不仅仅是 `polars`。
在 [Robert Krahn](https://robert.kra.hn/posts/2022-09-09-speeding-up-incremental-rust-compilation-with-dylibs/) 的这篇博文中阅读更多相关信息 以及 [该工具的主页](https://github.com/rksm/cargo-add-dynamic) 。
### 1.23 投资更好的硬件
如果您达到了这一点，那么进一步缩短编译时间的最简单方法是 可能是为了花钱购买顶级硬件。
至于笔记本电脑， `M-series` 的 Apple 新 MacBook 表现非常出色 用于 Rust 编译。
![Rik Arends 的 Twitter 帐号
[benchmarks](https://www.reddit.com/r/rust/comments/qgi421/doing_m1_macbook_pro_m1_max_64gb_compile/) 配备 M1 Max 的 Macbook Pro 的基准测试绝对是 _荒谬的_ ——即使与已经很快的 M1 相比也是如此：

|项目|M1 最大|M1 空气|
|---|---|---|
|[德诺](https://github.com/denoland)|6 分 11 秒|11 分 15 秒|
|[美利搜索](https://github.com/meilisearch/MeiliSearch)|1 分 28 秒|3 分 36 秒|
|[打](https://github.com/sharkdp/bat)|43 秒|1 分 23 秒|
|[超精细](https://github.com/sharkdp/hyperfine)|23 秒|42 秒|
|[Ripgrep](https://github.com/BurntSushi/ripgrep)|16 秒|37 秒|
这是 2 倍的性能提升。
但是，如果您更喜欢坚持使用 Linux，那么人们使用像 AMD Ryzen 这样的多核 CPU 也取得了巨大的成功 [Threadripper 和 32 GB 的 RAM](https://www.reddit.com/r/rust/comments/chqu4c/building_a_computer_for_fastest_possible_rust/) 。
在便携式设备上，编译可能会耗尽电池并且速度很慢。为避免 那，我在家里使用我的机器，一台 6 核 AMD FX 6300 和 12GB RAM，作为 build 机器。我可以将其与 [Visual Studio Code Remote 结合使用 开发](https://code.visualstudio.com/docs/remote/remote-overview) 。
### 1.24 在云中编译
如果您自己没有专用计算机，则可以卸载编译 进程转移到云端。  
[Gitpod.io](https://gitpod.io/) 非常适合测试云构建，因为它们 为您提供一台强大的机器（目前为 16 核 Intel Xeon 2.80GHz，60GB RAM） 在有限的时间内免费。只需添加 `https://gitpod.io/#` 在 的 Github URL 前面。 [之一的示例](https://gitpod.io/#https://github.com/hello-rust/show/tree/master/episode/9) 这是我的 [Hello Rust](https://hello-rust.show/) 剧集
Gitpod 有一个简洁的功能，称为 [prebuilds](https://www.gitpod.io/docs/prebuilds) 。来自他们的文档：
> 每当你的代码发生变化时（例如，当新的提交被推送到你的 存储库），Gitpod 可以预构建工作区。 然后，当您在分支上创建新工作区或 Pull/Merge Request 时， 如果存在预构建，则此工作区的加载速度会快得多，因为 **所有 依赖项已经提前下载，并且您的代码 将已经编译。** .
尤其是在审查拉取请求时，这可以为您提供很好的加速。 预构建是完全可定制的;看看 [`.gitpod.yml` config 的 nushell](https://github.com/nushell/nushell/blob/d744cf8437614cc6b95a4bb22731269a17fe9c80/.gitpod.yml) 来获取 想法。
### 1.25 在本地缓存所有 crate
如果您的 Internet 连接速度较慢，则初始构建的很大一部分 进程正在从 crates.io 中获取所有这些闪亮的板条箱。为了缓解这种情况， 您可以提前下载 **所有** crate 以在本地缓存它们。 [Criner](https://github.com/the-lean-crate/criner) 就是这样做的：
```
git clone https://github.com/the-lean-crate/criner
cd criner
cargo run --release -- mine
```
存档大小出奇地合理，大约需要 **50GB 的磁盘 space** （截至今天）。
## 2 测试执行
### 2.1 使用 Cargo Nextest 而不是 `cargo test`
```sh
cargo install cargo-nextest
cargo nextest run
```
这很好 `cargo` 附带自己的 Little Test Runner，但特别是如果 您必须构建多个测试二进制文件， [`cargo nextest`](https://nexte.st/) 比 `cargo test` 得益于其并行执行 型。 以下是一些快速 [基准测试](https://nexte.st/book/benchmarks.html) ：

|项目|校订|测试计数|货物测试 （S）|NEXTEST （s）|起色|
|---|---|---|---|---|---|
|坩埚|`cb228c2b`|483|5,14|1,52|3.38×|
|格皮|`2cc51b41`|271|6,42|2,80|2.29×|
|mdBook|`0079184c`|199|3,85|1,66|2.31×|
|美利搜索|`bfb1f927`|721|57,04|28.99|1.96×|
|奥密克戎|`e7949cd1`|619|444.08|202.50|2.19×|
|半影|`4ecd94cc`|144|125.38|90,96|1.37×|
|要求西|`3459b894`|113|5,57|2,26|2.48×|
|戒指|`450ada28`|179|13,12|9.40|1.39×|
|东京|`1f50c571`|1138|24.27|11,60|2.09×|
### 2.2 将所有集成测试合并到一个二进制文件中
有任何 [集成测试](https://doc.rust-lang.org/rust-by-example/testing/integration_testing.html) 吗？（这些是 `tests` 文件夹。 您知道 Rust 编译器将为他们中的每一个创建一个二进制文件吗？ 并且每个二进制文件都必须单独链接。 这可能会占用你的大部分构建时间，因为链接很慢。🐢 原因是许多系统链接器（如 `ld`） 是 [单 螺纹](https://stackoverflow.com/questions/5142753/can-gcc-use-multiple-cores-when-linking) 。
为了使链接器的工作更轻松一些，您可以将所有测试放在一个 板条箱。（基本上创建一个 `main.rs` 在您的测试文件夹中，并将您的 test 文件设置为 `mod` 在那儿。
然后，链接器将继续并仅构建单个二进制文件。听起来不错，但是 小心：这仍然是一个权衡，因为您需要公开内部类型和 函数（即 make them `pub`）。
如果您有很多集成测试，这可能会导致 [50% 的加速](https://azriel.im/will/2019/10/08/dev-time-optimization-part-1-1.9x-speedup-65-less-disk-usage/) 。
_这个提示是由 [Luca Palmieri](https://twitter.com/algo_luca) 带给您的， [卢西奥·佛朗哥 （Lucio Franco](https://twitter.com/lucio_d_franco) ） 和 [阿兹瑞尔 （Azriel） 哼](https://twitter.com/im_azriel) 。谢谢！_
### 2.3 将慢速测试放在环境变量后面
```rust
#[test]
fn completion_works_with_real_standard_library() {
  if std::env::var("RUN_SLOW_TESTS").is_err() {
    return;
  }
  ...
}
```
如果你的测试很慢，你可以把它们放在一个环境变量后面，以 默认情况下禁用它们。这样，您可以在本地跳过它们，只运行它们 在 CI 上。
中学到了一个不错的技巧 [（我从 matklad （Alex Kladov） 的帖子](https://matklad.github.io/2021/05/31/how-to-test.html) 。
## 3 CI 构建
### 3.1 为您的依赖项使用缓存
特别是对于 GitHub 操作，您还可以使用 [Swatinem/rust-cache](https://github.com/Swatinem/rust-cache) 。
它就像在您的工作流程中添加一个步骤一样简单：
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: dtolnay/rust-toolchain@stable
      - uses: Swatinem/rust-cache@v2
      - run: cargo test --all
```
这样，您的依赖项将在构建之间缓存，您可以期待 显著的加速。
### 3.2 拆分编译和测试步骤
```yaml
- name: Compile
  run: cargo test --no-run --locked
- name: Test
  run: cargo test -- --nocapture --quiet
```
这样可以更轻松地了解在编译上花费了多少时间以及如何编译 很多关于运行测试的内容。
### 3.3 在 CI 中禁用增量编译
```yaml
env:
  CARGO_INCREMENTAL: 0
```
由于 CI 构建更类似于从头开始构建，因此增量编译会增加不必要的依赖关系跟踪和 IO 开销，从而降低缓存效率。 [以下是禁用它的方法。](https://github.com/rust-analyzer/rust-analyzer/blob/25368d24308d6a94ffe8b99f0122bcf5a2175322/.github/workflows/ci.yaml#L11)
### 3.4 关闭 Debuginfo
```toml
[profile.dev]
debug = 0
strip = "debuginfo"
```
避免链接调试信息以加快构建过程，尤其是在您很少使用实际调试器的情况下。有两种方法可以避免链接调试信息：将 `debug=0` 跳过编译，或将 `strip="debuginfo"` 跳过链接。遗憾的是，更改这些选项可能会触发 Cargo 的完全重建。
- 在 Linux 上，设置 both 以缩短构建时间。
- 在 Mac 上，使用 `debug=0` 由于 rustc 使用外部 strip 命令。
- 在 Windows 上，测试这两个设置以查看哪个设置更快。
请注意，如果没有调试信息，回溯跟踪将仅显示函数名称，而不显示行号。如果需要，请使用 `split-debuginfo="unpacked"` 以达成妥协。
作为一个不错的副作用，这也将有助于缩小 `./target`，提高缓存效率。
这是一个 [配置](https://github.com/rust-analyzer/rust-analyzer/blob/48f84a7b60bcbd7ec5fa6434d92d9e7a8eb9731b/Cargo.toml#L6-L10) 有关如何应用设置的示例
### 3.5 通过环境变量拒绝警告
避免使用 `#![deny(warnings)]` 以防止重复声明。 此外，在本地开发期间收到警告是可以的。
相反，请 [添加 `-D warnings` 自 `RUSTFLAGS`](https://github.com/rust-analyzer/rust-analyzer/blob/3dae94bf2b3e496adb049da589c7efef272a39b8/.github/workflows/ci.yaml#L15) 全局拒绝 CI 上所有 crate 中的警告。
```yaml
env:
  RUSTFLAGS: -D warnings
```
### 3.6 切换到更快的 Github Actions 运行程序
```diff
- runs-on: ubuntu-latest
+ runs-on: ubicloud
```
Ubicloud 等服务 [Ubicloud](https://www.ubicloud.com/use-cases/github-actions)、 [BuildJet](https://buildjet.com) 或 [RunsOn](https://github.com/runs-on/runs-on) 为您提供更快的 worker 您的 Github Actions 构建。特别是对于 Rust 管道，内核的数量 可能会对编译时间产生重大影响，因此可能值得一试。
这是 [Facebook Folly](https://github.com/facebook/folly) 的一个例子 项目。当然，这是一个 C++ 项目，但它显示 跑得更快的人的潜力：
!Facebook/Folly 构建时间
注册该服务后，您只需更改 runner 在 Github Actions 工作流程文件中。
## 4 更快的 Docker 构建
### 4.1 用 `cargo-chef` 加快 Docker 构建速度
从 Rust 代码构建 Docker 镜像？ 这些可能非常慢，因为 cargo 不支持只构建一个 project 的依赖项，如果你 别注意。 [`cargo-chef`](https://www.lpalmieri.com/posts/fast-rust-docker-builds/) 到 救！⚡
> `cargo-chef` 可用于充分利用 Docker 层缓存，因此 大大加快了 Rust 项目的 Docker 构建速度。在我们的商业广告中 代码库（~14K 行代码，~500 个依赖项）我们测得 **的速度提高了 5 倍** ：我们 将 Docker 构建时间从 **~10 分钟缩短到 ~2 分钟。**
这是一个例子 `Dockerfile` 如果您有兴趣：
```Dockerfile
# Step 1: Compute a recipe file
FROM rust as planner
WORKDIR app
RUN cargo install cargo-chef
COPY . .
RUN cargo chef prepare --recipe-path recipe.json
# Step 2: Cache project dependencies
FROM rust as cacher
WORKDIR app
RUN cargo install cargo-chef
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
# Step 3: Build the binary
FROM rust as builder
WORKDIR app
COPY . .
# Copy over the cached dependencies from above
COPY --from=cacher /app/target target
COPY --from=cacher /usr/local/cargo /usr/local/cargo
RUN cargo build --release --bin app
# Step 4:
# Create a tiny output image.
# It only contains our final binary.
FROM rust as runtime
WORKDIR app
COPY --from=builder /app/target/release/app /usr/local/bin
ENTRYPOINT ["/usr/local/bin/app"]
```
[`cargo-chef`](https://github.com/LukeMathWalker/cargo-chef) 可以帮助加快 您与 Github Actions 的持续集成或您到 Google 的部署过程 云。
### 4.2 考虑 Earthly 以更好地构建缓存
Earthly 是一个相对较新的构建工具，旨在替代 Makefile、Dockerfile 和其他构建工具。它提供快速、增量 用于 CI 的 Rust 构建。
> Earthly 通过有效地实现 Cargo 的 caching 和 Rust 的增量编译。这种方法显著 减少 CI 中不必要的重新构建，反映本地 Rust 的效率 建立。
> 
> 资料来源： [Earthly for Rust](https://earthly.dev/rust)
他们使用一个名为 Satellites 的系统，该系统是持续的远程构建 在本地保留缓存数据的运行器。这可以大大加快 CI 构建速度 通过消除缓存上传和下载来增加。而不是带缓存 data 到 compute 中，它们将 cache 数据和 compute 放在一起，从而消除 cache 转移。更少的 I/O 意味着更快的构建。
Earthly 还提供了一个 `lib/rust` 库，它抽象出缓存 配置。它确保 Rust 正确缓存并构建 在 CI 中递增。它可以用于您的 [`Earthfile`](https://docs.earthly.dev/docs/earthfile) 喜欢这个：
```Dockerfile
IMPORT github.com/earthly/lib/rust
```
如果你好奇，Earthly [的 Rust 指南](https://earthly.dev/rust) 详细介绍了 一个简单的 Rust 示例，具有优化的缓存和编译步骤。
## 5 特定于 IDE 的优化
如果您发现开发环境中的构建时间很慢，以下是 您可以尝试一些其他提示。
### 5.1 Visual Studio Code 中的调试会话速度缓慢
如果你在使用 Visual Studio Code 时发现 **调试会话** 很慢，那么 确保没有设置太多断点。 [每个断点都会减慢调试会话的速度](https://www.reddit.com/r/rust/comments/1ddktag/looking_for_some_help_where_it_takes_a_minute_to/) 。
### 5.2 关闭不相关的项目
如果您在 Visual Studio Code 中打开了多个项目，则每个实例都会运行其 自己的 rust-analyzer 副本。这可能会降低您的计算机速度。关闭 unrelated projects 项目，看看是否有帮助。
# 总结
在本文中，我们涵盖了很多内容。我们已经研究了如何加快速度 您的 Rust 通过使用更好的硬件、优化代码并使用 更好的工具。
我希望您能够使用其中一些技巧来加快 Rust 构建速度。 如果您找到了其他加快 Rust 构建速度的方法，或者您有任何 问题或反馈，我很乐意听取您的意见。
#### 0.1.1 
获得专业支持
如果你需要对商业 Rust 项目的支持， 我还可以帮助您解决性能问题并缩短构建时间。 联系我们。
## 1 其他资源
- [Rust Perf Book](https://nnethercote.github.io/perf-book/compile-times.html) 有一个关于编译时间的部分。
    
- 列表 [Read Rust 上有关性能的文章](https://readrust.net/performance) 。
    
- [Rust 构建时间故障排除的 8 种解决方案](https://medium.com/@jondot/8-steps-for-troubleshooting-your-rust-build-times-2ffc965fd13e) 是 Dotan Nahum 的一篇很棒的文章，我完全同意。
    
- 将更大的 Rust 项目 （lemmy） 的构建时间缩短了 [30%。](https://lemmy.ml/post/50089) .
    
- [arewefastyet](http://web.archive.org/web/20210510182416/https://arewefastyet.rs/) （offline） 测量 Rust 编译器编译常见 Rust 程序所需的时间。
    
- [加快 Rust 编辑-构建-运行周期](https://davidlattimore.github.io/posts/2024/02/04/speeding-up-the-rust-edit-build-run-cycle.html) ：一种改进 Rust 编译时间的基准驱动方法。
    
[](https://mastodonshare.com/?text=https://corrode.dev/blog/tips-for-faster-rust-compile-times/+%0A%23rust "分享到 Mastodon")
](https://mastodonshare.com/?text=https://corrode.dev/blog/tips-for-faster-rust-compile-times/+%0A%23rust "分享到 Mastodon")[](https://reddit.com/r/rust/submit?url=https://corrode.dev/blog/tips-for-faster-rust-compile-times/&title=Tips For Faster Rust Compile Times "分享到 Reddit")[](https://reddit.com/r/rust/submit?url=https://corrode.dev/blog/tips-for-faster-rust-compile-times/&title=Tips For Faster Rust Compile Times "分享到 Reddit")[](https://news.ycombinator.com/submitlink?u=https://corrode.dev/blog/tips-for-faster-rust-compile-times/&t=Tips For Faster Rust Compile Times "分享到 Hacker News")[](https://news.ycombinator.com/submitlink?u=https://corrode.dev/blog/tips-for-faster-rust-compile-times/&t=Tips For Faster Rust Compile Times "分享到 Hacker News")[
发布日期： 2024-01-12.上次修订日期：2024 年 6 月 12 日  
作者： Matthias Endler
编辑 器： [西蒙·布吕根](https://hachyderm.io/@m3t0r)
