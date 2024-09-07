## 1 使用 Rustup（推荐）

您似乎正在运行 Windows。要使用 Rust，请下载安装器，然后运行该程序并遵循屏幕上的指示。当看到相应提示时，您可能需要如果您不在 Windows 上，参看 [“其他安装方式”](https://forge.rust-lang.org/infra/other-installation-methods.html)。
1. 添加环境变量
```ini
RUSTUP_UPDATE_ROOT=http://mirrors.ustc.edu.cn/rust-static/rustup
RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

```
```
echo 'export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup' >> ~/.bash_profile
# for bash
echo 'export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup' >> ~/.bash_profile
echo 'export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup' >> ~/.bash_profile
# for fish
echo 'set -x RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup' >> ~/.config/fish/config.fish
echo 'set -x RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup' >> ~/.config/fish/config.fish

```
2. 安装 [Microsoft C++ 生成工具](https://visualstudio.microsoft.com/zh-hans/visual-cpp-build-tools/)。
#### 1.1.1 Microsoft Visual Studio C++ 构建工具

你需要安装 Microsoft Visual Studio C++ 构建工具。最简单的方法是安装 [Visual Studio 2022 构建工具](https://visualstudio.microsoft.com/visual-cpp-build-tools/)。在询问要安装哪些工作负载时，请确保选中“C++ 构建工具”和 Windows 10 SDK。

![Microsoft Visual Studio Installer](https://tauri.org.cn/assets/images/vs-installer-dark-03cefd64bd4335f718aacc8f4842d2bb.png#gh-dark-mode-only)

清单 1-1：使用 Visual Studio Build Tools 2022 安装程序选择“C++ 构建工具”和“Windows 10 SDK”。
#### 1.1.2 WebView2
在 Windows 10（版本 1803 及更高版本，已应用所有更新）和 Windows 11 中，WebView2 运行时作为操作系统的一部分进行分发。
Tauri 在很大程度上依赖 WebView2 在 Windows 上呈现网络内容，因此你必须安装 WebView2。最简单的方法是从 [Microsoft 网站](https://developer.microsoft.com/en-us/microsoft-edge/webview2/#download-section) 下载并运行 Evergreen Bootstrapper。

引导程序脚本将尝试确定适合你系统的正确架构和版本。不过，如果你遇到问题（尤其是 Windows on ARM），你可以选择正确的独立安装程序。
#### 1.1.3 Rust

最后，转到 [http://www.rust-lang.net.cn/tools/install](http://www.rust-lang.net.cn/tools/install) 安装 `rustup`（Rust 安装程序）。请注意，你必须重新启动终端，在某些情况下，Windows 本身才能使更改生效。

或者，你可以在 PowerShell 中使用以下命令通过 `winget` 安装 rustup
4. [下载 rustup-init.exe（64位）](https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe)
##### 1.1.3.1 查看版本
退出终端，重新打开终端：
```
Administrator@DESKTOP-I3HQO5I  ~
# cargo --version
cargo 1.81.0 (2dbb1af80 2024-08-20)
```
~/. cargo/config

```
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
# 指定镜像
replace-with = 'tuna' # 如：tuna、sjtu、ustc，或者 rustcc

# 注：以下源配置一个即可，无需全部

# 中国科学技术大学
[source.ustc]
registry = "https://mirrors.ustc.edu.cn/crates.io-index"

# 上海交通大学
[source.sjtu]
registry = "https://mirrors.sjtug.sjtu.edu.cn/git/crates.io-index/"

# 清华大学
[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"

# rustcc社区
[source.rustcc]
registry = "https://code.aliyun.com/rustcc/crates.io-index.git"

```