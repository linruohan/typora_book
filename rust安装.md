# Rust认识安装

## 1 Rust官网

Rust 官网:https://www.rust-lang.org/
Rust中文官网:https://www.rust-lang.org/zh-CN/
## 2 Windows msvc安装
只安装**Visual Studio Build Tools**，它包含了全部命令行编译工具
1. 下载 [Visual Studio Build Tools](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022) 安装程序。
用于 Visual Studio 的工具==> Visual Studio 2026 生成工具==> 下载
https://download.visualstudio.microsoft.com/download/pr/fe4fb3e6-ea32-4ae3-b154-72821a274f0d/352ac5776d592a4870c15756f9e140507b9ee64de62b401152e5929f7c0c52a6/vs_BuildTools.exe
2. 在安装程序中，切换到“单个组件”（Individual components）选项卡。
3. 搜索并勾选以下**两个核心组件**[](https://github.com/rust-lang/rustup/issues/4699#1)[](https://zed.rust-lang.net.cn/docs/development/windows#backend-dependencies#1)：
    - **MSVC v143 - VS 2022 C++ x64/x86 build tools (Latest)**：这是 C++ 编译器和链接器的核心。
    - **Windows 11 SDK** 或 **Windows 10 SDK**：根据你的系统版本选择，它提供系统库[](https://github.com/ankitects/anki/blob/57e67f84/docs/windows.md?plain=1#L10-L48#1)[](https://github.com/rust-lang/rustup/issues/4699#1)。

> **特别提醒**：根据社区反馈，如果只安装上面两个最小化组件，`rustup-init.exe` 可能无法自动检测到 MSVC 环境[](https://github.com/rust-lang/rustup/issues/4699#1)。但**这不影响使用**。安装后，只需通过“开始”菜单找到并运行 **“开发者命令提示符”** （Developer Command Prompt for VS 2022）[](https://learn.microsoft.com/zh-cn/cpp/build/building-on-the-command-line?view=msvc-170#1#1)，**在这个专门的终端里**运行 `rustup-init.exe` 或执行后续的 Rust 编译，环境变量就是正确的，`rustc` 和 `cargo` 就能正常工作。
## 3 windows gnu安装

### 3.1 前置条件：安装C++环境

#### 3.1.1 👉 下载

rust底层是依赖C环境的，所以先安装C/C++编译环境
https://github.com/niXman/mingw-builds-binaries/releases
地址： https://github.com/niXman/mingw-builds-binaries/releases/download/16.2.0-rt_v14-rev1/x86_64-16.2.0-release-posix-seh-ucrt-rt_v14-rev1.7z

#### 3.1.2 👉 配置环境变量

下载解压到任意盘根目录，然后把文件夹的bin目录路径配置到系统环境变量path
```javascript
// 我本地环境地址如下
D:\anzhuang\mingw64\bin
环境变量地址
此电脑=>属性=>高级系统设置=>环境变量=>系统变量=>Path
```
#### 3.1.3 👉检测是否成功

```javascript
gcc -v
// 如果是安装成功以后会出现以下提示 ‘
gcc version 13.2.0 (x86_64-posix-seh-rev0, Built by MinGW-Builds project)
```

## 4 安装Rust
### 4.1 👉 下载
地址 rustup-init.exe https://win.rustup.rs/x86_64
Window：下载并运行 
下载过程会给我们提示以下信息

```javascript
Rust Visual C++ prerequisites
Rust requires a linker and Windows API libraries but they don't seem to be
available.
These components can be acquired through a Visual Studio installer.
1) Quick install via the Visual Studio Community installer
(free for individuals, academic uses, and open source).
﻿
2) Manually install the prerequisites
(for enterprise and advanced users).
﻿
3) Don't install the prerequisites
(if you're targeting the GNU ABI).
```
如果我们直接是安装过C/C++的环境的，我们直接安装Rust的时候选择3即可（也建议这样子做）

#### 4.1.1 👉 检测是否成功

```javascript
rustc -V
rustup -V
cargo -V
rustup show 
```

### 4.2 卸载Rust

👉命令卸载

如果我们是通过 rustup（Rust 的官方安装工具）安装 Rust 的，可以使用 rustup 自带的卸载命令来移除 Rust

```javascript
rustup self uninstall

//检测是否卸载成功
rustc --version

//查看环境变量是否卸载干净
在 Windows 上，通过 "系统属性" > "高级系统设置" > "环境变量" 来删除 Rust 的路径
```

## 5 linux 安装

#### 5.1.1 方式一

```javascript
打开这个网站
https://rustup.rs/

复制一下安装命令
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
#### 5.1.2 方式二
安装方式是用brew来安装，几乎都能成功
```javascript
brew install rust

```

#### 5.1.3 验证是否安装成功

```javascript
rustc --version
```

### 5.2 查看文档

```javascript
rustup doc
```

#### 5.2.1 工具安装

使用 VSCode，安装 Rust 插件即可  
![](https://fileserver.developer.huaweicloud.com/FileServer/getFile/community/934/673/869/0001726196934673869.20251216140930.63704164598229106281780288322706:20260905031551:2415:98A33E0F8320B77FA2234551D57D05559414E5868362D1B22E82719226B43AF6.png)

## 6 Rust - Hello World

### 6.1 1、创建你的第一个 Rust 项目

Rust 的文件以 .rs 结尾，我们可以通过 `cargo` 来创建和管理 Rust 项目。`cargo` 是 Rust 的构建系统和包管理工具。

打开终端，运行以下命令来创建一个新的 Rust 项目：

```javascript
cargo new rust-learn

cd rust-learn

查看项目文件结构：
bash
hello_world
├── Cargo.toml      // 配置文件
└── src
    └── main.rs     // 默认的源代码文件
Cargo.toml 是项目的配置文件，管理依赖关系。
src/main.rs 是你将编写 Rust 代码的地方

在 src/main.rs 文件中，你会看到 Rust 自动生成的代码：
fn main() {
    println!("Hello World");
}
代码释义：
● fn 用来定义一个函数，等同于 Javascript 中的 function
● main 函数，Rust 可执行文件的入口
● println!，是一个 Rust macro(宏) 用来输出字符串

```

### 6.2 2、编译运行程序

```bash

cargo run

```

```javascript
报错

sudo xcodebuild -license
错误是因为在 macOS 上，Rust 需要使用 Xcode 提供的工具链来进行编译和链接，而你的系统尚未同意 Xcode 的许可证协议。为了解决这个问题，你需要同意 Xcode 的许可证协议。按照以下步骤操作：

同意 Xcode 的许可证
打开终端并运行以下命令：

bash
sudo xcodebuild -license
xcode安装部分：
/Applications/Xcode.app/Contents/Developer

设置
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer

再次  
cargo run 已经成功解决
```

### 6.3 3、运行代码

```bash
# windows
.\main.exe

# Linux/mac
./main
Cargo 命令
cargo build: 编译程序，生成可执行文件。默认会在 target/debug 目录中生成可执行文件。
cargo run: 编译并运行程序，相当于执行 cargo build 后立即运行可执行文件。
cargo clean: 清理编译过程中生成的文件。
cargo test: 运行项目中的测试。
cargo doc: 生成项目的文档。
```

## 7 rust认识

### 7.1 rust 语言能做什么

Rust 是一种现代的系统编程语言，它被设计为安全、高效且并发友好。由于它的特点，Rust 可以用于很多不同的领域，下面是一些主要应用场景：

### 7.2 **系统编程**

Rust 主要被用于系统级编程，即开发操作系统、驱动程序、嵌入式系统等底层软件。Rust 的优势在于其内存安全性和无垃圾回收机制，这使得它非常适合资源受限的环境。

- **操作系统**：你可以用 Rust 编写自己的操作系统或操作系统的一部分（例如 **Redox OS**，一个完全用 Rust 编写的操作系统）。
- **设备驱动程序**：Rust 允许低级别的硬件交互，同时保持内存安全。
- **嵌入式开发**：Rust 支持嵌入式编程，它适用于开发需要与硬件直接交互的应用程序。

### 7.3 **Web 后端开发**

Rust 的高性能特性使得它适合用于构建 Web 服务器和后端服务。Rust 生态系统提供了许多优秀的框架和库，支持高并发的 Web 服务。

- **Web 框架**：例如，`Rocket` 和 `Actix` 是 Rust 中非常流行的 Web 开发框架，提供了高效的请求处理和路由功能。
- **API 开发**：Rust 可以用于开发 RESTful API 和 GraphQL API，特别适合对性能要求较高的服务。

### 7.4 **并发和多线程编程**

Rust 以其并发性和多线程支持而闻名。它的所有权和借用系统能够避免许多并发编程中的常见错误，例如数据竞态和内存泄漏。因此，Rust 是处理多线程、异步编程等任务的理想选择。

- **并发应用**：Rust 的 `async` 和 `await` 语法，以及 `tokio` 和 `async-std` 等异步库，可以帮助你构建高效的并发应用程序。
- **多线程应用**：Rust 提供了高效且安全的多线程支持，确保在线程间共享数据时不会发生内存问题。

### 7.5 **游戏开发**

虽然 C++ 是游戏开发的传统选择，Rust 由于其高性能和内存安全的优势，也越来越多地被用于游戏开发。Rust 可以用于开发游戏引擎、游戏客户端和服务器。

- **游戏引擎**：Rust 中有一些游戏引擎库，比如 `Amethyst` 和 `Bevy`，这些引擎库适用于 2D 和 3D 游戏开发。
- **性能**：Rust 高效的内存管理和零成本抽象使得它特别适合性能要求高的游戏开发。

### 7.6 **区块链开发**

由于 Rust 的高性能和安全性，它已经成为区块链开发领域的一个重要语言。许多区块链平台（例如 **Polkadot** 和 **Solana**）的核心部分都使用 Rust 编写。

- **智能合约**：Rust 可以用于开发区块链的智能合约，确保代码的安全性和效率。
- **区块链平台**：Rust 的并发和内存管理特性非常适合大规模分布式系统的构建。

### 7.7 **命令行工具和脚本**

Rust 适用于开发高效的命令行工具和实用程序。由于 Rust 的快速执行和简洁的语法，许多开发者选择它来编写高效且功能强大的命令行应用。

- **CLI 工具**：Rust 提供了如 `clap` 和 `structopt` 等库，用于构建易用且功能强大的命令行工具。
- **系统工具**：Rust 常用于开发系统管理工具，例如文件管理、日志分析、网络监控等。

### 7.8 **网络编程**

Rust 在网络编程中也有广泛的应用，特别是在高性能网络应用和网络协议的实现方面。

- **网络协议实现**：由于 Rust 的内存管理和性能优势，许多网络协议实现（例如 HTTP/2 和 HTTP/3）都使用 Rust 编写。
- **高性能网络服务**：Rust 可以用于构建高效、低延迟的网络服务和应用，尤其是在需要处理大量并发连接时。

### 7.9 **数据处理和科学计算**

Rust 的高性能和并发支持也使得它在数据处理和科学计算中越来越受欢迎。

- **数据处理**：Rust 可以用于处理大量数据集，尤其是在需要高性能的情况下，常用于大数据分析和实时数据处理。
- **科学计算**：Rust 可以与 C 和 Fortran 库互操作，适用于数值计算和科学计算领域。

### 7.10 **跨平台开发**

Rust 提供了良好的跨平台支持，允许你将应用程序同时运行在多个操作系统（Windows、Linux、macOS）上。Rust 的工具链和库支持多平台构建，使得跨平台开发变得更加方便。

- **桌面应用**：Rust 可以与如 `druid` 或 `gtk-rs` 等库结合使用，来构建桌面图形用户界面应用。
- **WebAssembly (WASM)**：Rust 也非常适合编译为 WebAssembly，从而使得其代码能够在 Web 浏览器中运行。

### 7.11 **安全性和漏洞检测**

Rust 被设计为一种“安全”的编程语言，它具有严格的内存管理机制，可以在编译时防止很多常见的漏洞（如缓冲区溢出、数据竞态等）。因此，Rust 也非常适合用于开发安全性要求极高的应用。

- **网络安全**：Rust 的内存安全特性可以用来构建网络安全工具和防护系统。
- **漏洞检测**：Rust 的类型系统和所有权系统可以帮助减少一些常见的编程错误，进而减少潜在的漏洞。

### 7.12 总结

Rust 的核心优势在于它结合了 **高性能** 和 **内存安全**，并且避免了垃圾回收机制，适合用于开发需要高效、可靠和安全的应用程序。无论是在系统级编程、Web 开发、并发编程，还是区块链和游戏开发等领域，Rust 都展示了它的强大潜力和应用场景。

Rust 是一门多用途的语言，适合从 **底层开发** 到 **高层应用** 的各类开发任务。