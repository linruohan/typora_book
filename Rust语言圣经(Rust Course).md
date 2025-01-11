# Rust语言圣经(Rust Course)
[toc]

## 1 rust语言简介
一门无 GC 且无需手动内存管理、性能高、工程性强、语言级安全性以及能同时得到工程派和学院派认可的语言
### 1.1 目标
包/模块/方法、性能/安全/工程性的权衡选择信手拈来、深层性能优化易如反掌、异步编程小菜一碟，更别说 Rust 之外的操作系统、网络、算法等等相关知识。
### 1.2 效率
#### 1.2.1 学习效率
1. 实践中如何融会贯通的运用
2. 遇到了坑时（生命周期、借用错误，自引用等）如何迅速、正确的解决
3. 大量的标准库方法记忆及熟练使用，这些是保证开发效率的关键
4. 心智负担较重，特别是初中级阶段
#### 1.2.2 运行效率
1. 得益于各种零开销抽象、深入到底层的优化潜力、优质的标准库和第三方库实现，Rust 具备非常优秀的性能，和 C、C++ 是 一个级别。
2. 同时 Rust 有一个极大的优点：只要按照正确的方式使用 Rust，无需性能优化，就能有非常优秀的表现，不可谓不惊艳。
3. 现在有不少用 Rust 重写的工具、平台都超过了原来用 C、C++ 实现的版本，将老前辈拍死在沙滩上，俨然成为一种潮流～～
#### 1.2.3 开发效率
1. 先抑后扬
2. 最初上手写项目时，你的开发速度将显著慢于 Go、Java 等语言
3. 一旦开始熟悉标准库、熟悉生命周期和所有权的常用解决方法，开发效率将大幅提升，甚至当形成肌肉记忆后，开发效率将不会慢于这些语言，而且原生就能写出高质量、安全、高效的代码，可以说中高级 Rust 程序员就是高效程序员的代名词。
### 1.3 应用场景
1. UI 层开发，Rust 的 WASM 发展的如火如荼，隐隐有王者风范，在 JS 的基础设施领域，Rust 也是如鱼得水，例如 swc、 deno 等。同时 nextjs 也是押宝 Rust，可以说 Rust 在前端的成功完全是无心插柳柳成荫。
2. 基础设施层、数据库、搜索引擎、网络设施、云原生等都在出现 Rust 的身影，而且还不少。
3. 系统开发，目前 Linux 已经将 Rust 语言纳入内核，是继 C 语言后第二门支持内核开发的语言，不过刚开始将主要支持驱动开发。
4. 系统工具，现在最流行的就是用 Rust 重写之前 C、C++ 写的一票系统工具，还都获得了挺高的关注和很好的效果，例如 sd, exa, ripgrep, fd, bat 等。
5. 操作系统，正在使用 Rust 开发的操作系统有好几个，其中最有名的可能就是谷歌的 Fuchsia，Rust 在其中扮演非常重要的角色。
6. 区块链，如果 Rust 的份额说第二，应该没人敢稳说自己是第一吧？
## 2 环境准备
### 2.1 安装rust环境
#### 2.1.1 在 Windows 上安装 rustup
##### 2.1.1.1 x86_64-pc-windows-msvc
先安装 Microsoft C++ Build Tools，勾选安装 C++ 环境即可。安装时可自行修改缓存路径与安装路径，避免占用过多 C 盘空间。安装完成后，Rust 所需的 msvc 命令行程序需要手动添加到环境变量中，否则安装 Rust 时 rustup-init 会提示未安装 Microsoft C++ Build Tools，其位于：%Visual Studio 安装位置%\VC\Tools\MSVC\%version%\bin\Hostx64\x64（请自行替换其中的 %Visual Studio 安装位置%、%version% 字段）下。
如果你不想这么做，可以选择安装 Microsoft C++ Build Tools 新增的“定制”终端 Developer Command Prompt for %Visual Studio version% 或 Developer PowerShell for %Visual Studio version%，在其中运行 rustup-init.exe。
##### 2.1.1.2 x86_64-pc-windows-gnu
相比于 MSVC 版本来说，GNU 版本具有更轻量，更靠近 Linux 的优势。
根据 MSYS2 官网 配置 MSYS。
在安装 mingw-toolchain 后，请将 %MSYS 安装路径%\mingw64\bin 添加到系统变量 PATH 中。
在 MSYS 中输入下面的命令来安装 rustup
```bash
curl https://sh.rustup.rs -sSf | sh
```
#### 2.1.2 安装 C 语言编译器（可选）
1. linux
```
	gcc
clang
```
2. macos
```
xcode-select --install
```
#### 2.1.3 更新
`rustup update`
#### 2.1.4 卸载
`rustup self uninstall`
#### 2.1.5 检查安装是否成功
```bash
$ rustc -V
rustc 1.56.1 (59eed8a2a 2021-11-01)

$ cargo -V
cargo 1.57.0 (b2e52d7ca 2021-10-21)
```
请检查 Rust 或 %USERPROFILE%\.cargo\bin 是否在 %PATH% 系统变量中。
#### 2.1.6 本地文档
1. rustup doc 
让浏览器打开本地文档。
2. https://course.rs/std/search.html
遇到标准库提供的类型或函数不知道怎么用，API 文档中查找
#### 2.1.7 linux + macos
```bash
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
```
### 2.2 vscode插件
rust-analyzer
Even Better TOML，支持 .toml 文件完整特性
Error Lens, 更好的获得错误展示
One Dark Pro, 非常好看的 VSCode 主题
CodeLLDB, Debugger 程序
#### 2.2.1 电脑慢
不要在终端再运行 cargo run 等命令进行编译，不然会获得一个报错提示，大意是当前文件目录已经被锁定，等待其它使用者释放。
如果等了很久 IDE 还是没有释放（虽然我没遇到过，但是存在这个可能性），你可以关掉 IDE，并手动 kill 掉 rust-analyzer，然后重新尝试。
### 2.3 认识 Cargo --包管理工具
#### 2.3.1 rust项目分类
bin
一个可运行的项目
lib
一个依赖库项目
#### 2.3.2 创建项目
```bash
cargo new world_hello
$ tree
.
├── .git
├── .gitignore
├── Cargo.toml
└── src
	└── main.rs
```

#### 2.3.3 运行项目
1. cargo run 	首先对项目进行编译，然后再运行
2. 手动编译和运行项目
```
cargo build
./target/debug/world_hello
```
3. debug 编译速度会非常快，运行速度就慢了
4. release
```bash
cargo run --release
cargo build --release
```
#### 2.3.4 验证代码的正确性
```bash
cargo check
```
 项目大了后，cargo run 和 cargo build 不可避免的会变慢
Rust 需要做很多复杂的编译优化和语言特性解析，甚至连如何优化编译速度都成了一门学问: 优化编译速度。
#### 2.3.5 Cargo.toml 和 Cargo.lock
##### 2.3.5.1 Cargo.toml 
是 cargo 特有的项目数据描述文件。它存储了项目的所有元配置信息，
如果 Rust 开发者希望 Rust 项目能够按照期望的方式进行构建、测试和运行，那么，必须按照合理的方式构建 Cargo.toml。
##### 2.3.5.2 Cargo.lock 
文件是 cargo 工具根据同一项目的 toml 文件生成的项目依赖详细清单，
因此我们一般不用修改它，只需要对着 Cargo.toml 文件撸就行了。
##### 2.3.5.3 package 配置段落
```toml
[package]
name = "world_hello"
version = "0.1.0"
edition = "2021"
```
name 字段定义了项目名称，version 字段定义当前版本，新项目默认是 0.1.0，edition 字段定义了我们使用的 Rust 大版本
#### 2.3.6 定义项目依赖
1. 基于 Rust 官方仓库 crates.io，通过版本说明来描述
2. 基于项目源代码的 git 仓库地址，通过 URL 来描述
3. 基于本地项目的绝对路径或者相对路径，通过类 Unix 模式的路径来描述
```toml
[dependencies]
rand = "0.3"
hammer = { version = "0.5.0"}
color = { git = "https://github.com/bjz/color-rs" }
geometry = { path = "crates/geometry" }
```
### 2.4 rust初印象
1. 控制流：for 和 continue 连在一起使用，实现循环控制。
2. 方法语法：由于 Rust 没有继承，因此 Rust 不是传统意义上的面向对象语言，但是它却从 OO 语言那里偷师了方法的使用 record.trim()，record.split(',') 等。
3. 高阶函数编程：函数可以作为参数也能作为返回值，例如 .map(|field| field.trim())，这里 map 方法中使用闭包函数作为参数，也可以称呼为 匿名函数、lambda 函数。
4. 类型标注：`if let Ok(length) = fields[1].parse::<f32>()`，通过 `::<f32>` 的使用，告诉编译器 length 是一个 f32 类型的浮点数。这种类型标注不是很常用，但是在编译器无法推断出你的数据类型时，就很有用了。
5. 条件编译：if cfg!(debug_assertions)，说明紧跟其后的输出（打印）只在 debug 模式下生效。
6.  隐式返回：Rust 提供了 return 关键字用于函数返回，但是在很多时候，我们可以省略它。因为 Rust 是 基于表达式的语言
### 2.5 cargo 代理配置
#### 2.5.1 字节跳动
```bash
$HOME/.cargo/config.toml
[source.crates-io]
replace-with = 'rsproxy'

[source.rsproxy]
registry = "https://rsproxy.cn/crates.io-index"

# 稀疏索引，要求 cargo >= 1.68
[source.rsproxy-sparse]
registry = "sparse+https://rsproxy.cn/index/"

[registries.rsproxy]
index = "https://rsproxy.cn/crates.io-index"

[net]
git-fetch-with-cli = true
```
## 3 rust基础入门
### 3.1 变量绑定与解构
1. 支持声明可变的变量
2. 支持声明不可变的变量
3. 既要灵活性又要安全性
#### 3.1.1 变量命名
##### 3.1.1.1 正在使用的关键字
as - 强制类型转换，或use 和 extern crate包和模块引入语句中的重命名
break - 立刻退出循环
const - 定义常量或原生常量指针（constant raw pointer）
continue - 继续进入下一次循环迭代
crate - 链接外部包
dyn - 动态分发特征对象
else - 作为 if 和 if let 控制流结构的 fallback
enum - 定义一个枚举类型
extern - 链接一个外部包,或者一个宏变量(该变量定义在另外一个包中)
false - 布尔值 false
fn - 定义一个函数或 函数指针类型 (function pointer type)
for - 遍历一个迭代器或实现一个 trait 或者指定一个更高级的生命周期
if - 基于条件表达式的结果来执行相应的分支
impl - 为结构体或者特征实现具体功能
in - for 循环语法的一部分
let - 绑定一个变量
loop - 无条件循环
match - 模式匹配
mod - 定义一个模块
move - 使闭包获取其所捕获项的所有权
mut - 在引用、裸指针或模式绑定中使用，表明变量是可变的
pub - 表示结构体字段、impl 块或模块的公共可见性
ref - 通过引用绑定
return - 从函数中返回
Self - 实现特征类型的类型别名
self - 表示方法本身或当前模块
static - 表示全局变量或在整个程序执行期间保持其生命周期
struct - 定义一个结构体
super - 表示当前模块的父模块
trait - 定义一个特征
true - 布尔值 true
type - 定义一个类型别名或关联类型
unsafe - 表示不安全的代码、函数、特征或实现
use - 在当前代码范围内(模块或者花括号对)引入外部的包、模块等
where - 表示一个约束类型的从句
while - 基于一个表达式的结果判断是否继续循环
##### 3.1.1.2 保留做将来使用的关键字
abstract
async
await
become
box
do
final
macro
override
priv
try
typeof
unsized
virtual
yield
##### 3.1.1.3 原生标识符
1. 原生标识符（Raw identifiers）允许你使用通常不能使用的关键字，其带有 r# 前缀。
❌
```rust
fn match(needle: &str, haystack: &str) -> bool {
haystack.contains(needle)
}
```
✔
```rust
fn r#match(needle: &str, haystack: &str) -> bool {
	haystack.contains(needle)
}

fn main() {
	assert!(r#match("foo", "foobar"));
}
```
2. r# 前缀需同时用于函数名定义和 main 函数中的调用
原生标识符允许使用你选择的任何单词作为标识符，即使该单词恰好是保留关键字。 此外，原生标识符允许你使用其它 Rust 版本编写的库。比如，try 在 Rust 2015 edition 中不是关键字，却在 Rust 2018 edition 是关键字。所以如果用 2015 edition 编写的库中带有 try 函数，在 2018 edition 中调用时就需要使用原始标识符语法，在这里是 r#try。
#### 3.1.2 变量绑定
let a = "hello world" 
绑定就是把这个对象绑定给一个变量，让这个变量成为它的主人
#### 3.1.3 变量可变性
1. 默认
Rust 的变量  默认不可变
变量 a 不可变，那么一旦为它绑定值，就不能再修改 a
2. 可变
mut 关键字让变量变为可变
let mut x = 5;
只有你想让你的变量改变时，它才能改变
#### 3.1.4 使用下划线开头忽略未使用的变量
两个变量都是只有声明，没有使用，但是编译器却独独给出了 y 未被使用的警告，充分说明了 _ 变量名前缀在这里发挥的作用。
```rust
let _x = 5;
let y = 10;
```
#### 3.1.5 变量解构
1. let 表达式不仅仅用于变量的绑定，还能进行复杂变量的解构：
2. 从一个相对复杂的变量中，匹配出该变量的一部分内容：
3. let (a, mut b): (bool,bool) = (true, false);
// a = true,不可变; b = false，可变
4. 解构式赋值
Rust 1.59 版本后，我们可以在赋值语句的左式中使用元组、切片和结构体模式
```rust
struct Struct {
e: i32
}

fn main() {
let (a, b, c, d, e);

(a, b) = (1, 2);
// _ 代表匹配一个值，但是我们不关心具体的值是什么，因此没有使用一个变量名而是使用了 _
[c, .., d, _] = [1, 2, 3, 4, 5];
Struct { e, .. } = Struct { e: 5 };
```
>使用 += 的赋值语句还不支持解构式赋值
#### 3.1.6 变量和常量之间的差异
1. 常量不允许使用 mut。常量不仅仅默认不可变，而且自始至终不可变，因为常量在编译完成后，已经确定它的值。
2. 常量使用 const 关键字而不是 let 关键字来声明，并且值的类型必须标注。
const MAX_POINTS: u32 = 100_000;
3. 常量可以在任意作用域内声明，包括全局作用域，在声明的作用域内，常量在程序运行的整个过程中都有效。
 对于需要在多处代码共享一个不可变的值时非常有用，例如游戏中允许玩家赚取的最大点数或光速。
 在实际使用中，最好将程序中用到的硬编码值都声明为常量，对于代码后续的维护有莫大的帮助。如果将来需要更改硬编码的值，你也只需要在代码中更改一处即可。
#### 3.1.7 变量遮蔽(shadowing)
Rust 允许声明相同的变量名，在后面声明的变量会遮蔽掉前面声明的
```rust
 let x = 5;
// 在main函数的作用域内对之前的x进行遮蔽
let x = x + 1;
```
首先将数值 5 绑定到 x，然后通过重复使用 let x = 来遮蔽之前的 x，并取原来的值加上 1，所以 x 的值变成了 6
这和 mut 变量的使用是不同的，第二个 let 生成了完全不同的新变量，两个变量只是恰好拥有同样的名称，涉及一次内存对象的再分配 ，而 mut 声明的变量，可以修改同一个内存地址上的值，并不会发生内存对象的再分配，性能要更好。
##### 3.1.7.1 用处
在某个作用域内无需再使用之前的变量（在被遮蔽后，无法再访问到之前的同名变量），就可以重复的使用变量名字，而不用绞尽脑汁去想更多的名字。
### 3.2 基本类型
#### 3.2.1 数值类型：
有符号整数 (i8, i16, i32, i64, isize)、 无符号整数 (u8, u16, u32, u64, usize) 、浮点数 (f32, f64)、以及有理数、复数
##### 3.2.1.1 整数类型
###### 3.2.1.1.1 内置整数类型
![](imgs/Rust语言圣经(Rust%20Course).png)
类型定义的形式统一为：有无符号 + 类型大小(位数)
无符号数表示数字只能取正数和 0
有符号则表示数字可以取正数、负数还有 0
###### 3.2.1.1.2 整形字面量
![](imgs/Rust语言圣经(Rust%20Course)-1.png)
###### 3.2.1.1.3 整型溢出
一个 u8 ，它可以存放从 0 到 255 的值
当你将其修改为范围之外的值，比如 256，则会发生整型溢出。
当在 debug 模式编译时，Rust 会检查整型溢出，若存在这些问题，则使程序在编译时 panic(崩溃,Rust 使用这个术语来表明程序因错误而退出)。
--release 参数进行 release 模式构建时，Rust 不检测溢出。相反，当检测到整型溢出时，Rust 会按照补码循环溢出（two’s complement wrapping）的规则处理。简而言之，大于该类型最大值的数值会被补码转换成该类型能够支持的对应数字的最小值。比如在 u8 的情况下，256 变成 0，257 变成 1，依此类推。程序不会 panic，但是该变量的值可能不是你期望的值。依赖这种默认行为的代码都应该被认为是错误的代码。
####### 处理可能的溢出
使用 wrapping_* 方法在所有模式下都按照补码循环溢出规则处理，例如 wrapping_add
```rust
let a : u8 = 255;
let b = a.wrapping_add(20);
println!("{}", b);  // 19
```
如果使用 checked_* 方法时发生溢出，则返回 None 值
使用 overflowing_* 方法返回该值和一个指示是否存在溢出的布尔值
使用 saturating_* 方法，可以限定计算后的结果不超过目标类型的最大值或低于最小值
assert_eq!(100u8.saturating_add(1), 101);
assert_eq!(u8::MAX.saturating_add(127), u8::MAX);
##### 3.2.1.2 浮点类型
浮点类型数字 是带有小数点的数字，在 Rust 中浮点类型数字也有两种基本类型： f32 和 f64，分别为 32 位和 64 位大小。在现代的 CPU 中它的速度与 f32 几乎相同，但精度更高。
默认浮点类型是 f64，
```rust
let x = 2.0; // f64
let y: f32 = 3.0; // f32
```
浮点数根据 IEEE-754 标准实现。f32 类型是单精度浮点型，f64 为双精度。
###### 3.2.1.2.1 浮点数陷阱
浮点数由于底层格式的特殊性，导致了如果在使用浮点数时不够谨慎，就可能造成危险，有两个原因：
1.  浮点数往往是你想要数字的近似表达 浮点数类型是基于二进制实现的，但是我们想要计算的数字往往是基于十进制，例如 0.1 在二进制上并不存在精确的表达形式，但是在十进制上就存在。这种不匹配性导致一定的歧义性，更多的，虽然浮点数能代表真实的数值，但是由于底层格式问题，它往往受限于定长的浮点数精度，如果你想要表达完全精准的真实数字，只有使用无限精度的浮点数才行
2.  浮点数在某些特性上是反直觉的 例如大家都会觉得浮点数可以进行比较，对吧？是的，它们确实可以使用 >，>= 等进行比较，但是在某些场景下，这种直觉上的比较特性反而会害了你。因为 f32 ， f64 上的比较运算实现的是 std::cmp::PartialEq 特征(类似其他语言的接口)，但是并没有实现 std::cmp::Eq 特征，但是后者在其它数值类型上都有定义，
3. 断言0.1 + 0.2与0.3相等
`assert!(0.1 + 0.2 == 0.3); `
会 panic（程序崩溃，抛出异常），因为二进制精度问题，导致了 0.1 + 0.2 并不严格等于 0.3，它们可能在小数点 N 位后存在误差。
4. 非要进行比较
```rust
(0.1_f64 + 0.2 - 0.3).abs() < 0.00001 ，具体小于多少，取决于你对精度的需求
 let abc: (f32, f32, f32) = (0.1, 0.2, 0.3);
let xyz: (f64, f64, f64) = (0.1, 0.2, 0.3);

println!("abc (f32)");
println!("   0.1 + 0.2: {:x}", (abc.0 + abc.1).to_bits());
println!("		 0.3: {:x}", (abc.2).to_bits());
println!();

println!("xyz (f64)");
println!("   0.1 + 0.2: {:x}", (xyz.0 + xyz.1).to_bits());
println!("		 0.3: {:x}", (xyz.2).to_bits());
println!();

assert!(abc.0 + abc.1 == abc.2);
assert!(xyz.0 + xyz.1 == xyz.2);
```
###### 3.2.1.2.2 NaN
1. 数学上未定义的结果，例如对负数取平方根 -42.1.sqrt() ，会产生一个特殊的结果：Rust 的浮点数类型使用 NaN (not a number) 来处理这些情况
2. 所有跟 NaN 交互的操作，都会返回一个 NaN，而且 NaN 不能用来比较，
```rust
let x = (-42.0_f32).sqrt();
assert_eq!(x, x);
```
```rust
let x = (-42.0_f32).sqrt();
if x.is_nan() {
 println!("未定义的数学行为")
}
```
出于防御性编程的考虑，可以使用 is_nan() 等方法，可以用来判断一个数值是否是 NaN ：
##### 3.2.1.3 数字运算
```rust
// 加法
let sum = 5 + 10;
// 减法
let difference = 95.5 - 4.3;
// 乘法
let product = 4 * 30;
// 除法
let quotient = 56.7 / 32.2;
// 求余
let remainder = 43 % 5;
```
```rust
fn main() {
// 编译器会进行自动推导，给予twenty i32的类型
let twenty = 20;
// 类型标注
let twenty_one: i32 = 21;
// 通过类型后缀的方式进行类型标注：22是i32类型
let twenty_two = 22i32;

// 只有同样类型，才能运算
let addition = twenty + twenty_one + twenty_two;
println!("{} + {} + {} = {}", twenty, twenty_one, twenty_two, addition);

// 对于较长的数字，可以用_进行分割，提升可读性
let one_million: i64 = 1_000_000;
println!("{}", one_million.pow(2));

// 定义一个f32数组，其中42.0会自动被推导为f32类型
let forty_twos = [
42.0,
42f32,
42.0_f32,
];

// 打印数组中第一个值，并控制小数位为2位
println!("{:.2}", forty_twos[0]);
}
```
##### 3.2.1.4 位运算

```rust
// 无符号8位整数，二进制为00000010
let a: u8 = 2; // 也可以写 let a: u8 = 0b_0000_0010;
// 二进制为00000011
let b: u8 = 3;
// {:08b}：左高右低输出二进制01，不足8位则高位补0
println!("a value is		{:08b}", a);
println!("b value is		{:08b}", b);
println!("(a & b) value is  {:08b}", a & b);
println!("(a | b) value is  {:08b}", a | b);
println!("(a ^ b) value is  {:08b}", a ^ b);
println!("(!b) value is	 {:08b}", !b);
println!("(a << b) value is {:08b}", a << b);
println!("(a >> b) value is {:08b}", a >> b);
let mut a = a;
// 注意这些计算符除了!之外都可以加上=进行赋值 (因为!=要用来判断不等于)
a <<= b;
println!("(a << b) value is {:08b}", a);
```
##### 3.2.1.5 序列(Range)
1. 生成连续的数值
2. 1..5，生成从 1 到 4 的连续数字，不包含 5 
3. 1..=5，生成从 1 到 5 的连续数字，包含 5
4. 只允许用于数字或字符类型，
原因是：它们可以连续，同时编译器在编译期可以检查该序列是否为空，字符和数字值是 Rust 中仅有的可以用于判断是否为空的类型。如下是一个使用字符类型序列的例子：
##### 3.2.1.6 使用 As 完成类型转换
使用 As 来完成一个类型到另一个类型的转换，其最常用于将原始类型转换为其他原始类型，但是它也可以完成诸如将指针转换为地址、地址转换为指针以及将指针转换为其他指针等功能。你可以在这里了解更多相关的知识。
###### 3.2.1.6.1 常用的转换形式
```rust
let a = 3.1 as i8;
let b = 100_i8 as i32;
let c = 'a' as u8; // 将字符'a'转换为整数，97
```
###### 3.2.1.6.2 内存地址转换为指针
```rust
let mut values: [i32; 2] = [1, 2];
let p1: *mut i32 = values.as_mut_ptr();
let first_address = p1 as usize; // 将p1内存地址转换为一个整数
let second_address = first_address + 4; // 4 == std::mem::size_of::<i32>()，i32类型占用4个字节，因此将内存地址 + 4
let p2 = second_address as *mut i32; // 访问该地址指向的下一个整数p2
unsafe {
*p2 += 1;
}
assert_eq!(values[1], 3);
```
###### 3.2.1.6.3 强制类型转换的边角知识
转换不具有传递性 就算 e as U1 as U2 是合法的，也不能说明 e as U2 是合法的（e 不能直接转换成 U2）。
###### 3.2.1.6.4 TryInto 转换
在一些场景中，使用 as 关键字会有比较大的限制。如果你想要在类型转换上拥有完全的控制而不依赖内置的转换，例如处理转换错误，那么可以使用 TryInto ：
try_into 会尝试进行一次转换，并返回一个 Result，此时就可以对其进行相应的错误处理
	因此使用了 unwrap 方法，该方法在发现错误时，会直接调用 panic 导致程序的崩溃退出，在实际项目中，请不要这么使用，具体见panic部分。
```rust
use std::convert::TryInto;
let a: u8 = 10;
let b: u16 = 1500;
let b_: u8 = b.try_into().unwrap();
```
最主要的是 try_into 转换会捕获大类型向小类型转换时导致的溢出错误：
 ```rust
 let b: i16 = 1500;
let b_: u8 = match b.try_into() {
	Ok(b1) => b1,
	 Err(e) => {
		 println!("{:?}", e.to_string());
	 0
}};
```
##### 3.2.1.7 通用类型转换
1. 虽然 as 和 TryInto 很强大，但是只能应用在数值类型上
2. 强制类型转换
1）在某些情况下，类型是可以进行隐式强制转换的，虽然这些转换弱化了 Rust 的类型系统，但是它们的存在是为了让 Rust 在大多数场景可以工作(说白了，帮助用户省事)，而不是报各种类型上的编译错误。
2）首先，在匹配特征时，不会做任何强制转换(除了方法)。一个类型 T 可以强制转换为 U，不代表 impl T 可以强制转换为 impl U，
###### 3.2.1.7.1 点操作符
方法调用的点操作符看起来简单，实际上非常不简单，它在调用时，会发生很多魔法般的类型转换，例如：自动引用、自动解引用，强制类型转换直到类型能匹配等。
完全限定语法来进行准确的函数调用
1.		首先，编译器检查它是否可以直接调用 T::foo(value)，称之为值方法调用
2.		如果上一步调用无法完成(例如方法类型错误或者特征没有针对 Self 进行实现，上文提到过特征不能进行强制转换)，那么编译器会尝试增加自动引用，例如会尝试以下调用： <&T>::foo(value) 和 <&mut T>::foo(value)，称之为引用方法调用
3.		若上面两个方法依然不工作，编译器会试着解引用 T ，然后再进行尝试。这里使用了 Deref 特征 —— 若 T: Deref<Target = U> (T 可以被解引用为 U)，那么编译器会使用 U 类型进行尝试，称之为解引用方法调用
4.		若 T 不能被解引用，且 T 是一个定长类型(在编译期类型长度是已知的)，那么编译器也会尝试将 T 从定长类型转为不定长类型，例如将 [i32; 2] 转为 [i32]
5.		若还是不行，那...没有那了，最后编译器大喊一声：汝欺我甚，不干了！
```rust
let array: Rc<Box<[T; 3]>> = ...;
let first_entry = array[0];
```

1. array 数组的底层数据隐藏在了重重封锁之后，那么编译器如何使用 array[0] 这种数组原生访问语法通过重重封锁，准确的访问到数组中的第一个元素？
2. 首先， array[0] 只是Index特征的语法糖：编译器会将 array[0] 转换为 array.index(0) 调用，当然在调用之前，编译器会先检查 array 是否实现了 Index 特征。
3. 接着，编译器检查 Rc<Box<[T; 3]>> 是否有实现 Index 特征，结果是否，不仅如此，&Rc<Box<[T; 3]>> 与 &mut Rc<Box<[T; 3]>> 也没有实现。
4. 上面的都不能工作，编译器开始对 Rc<Box<[T; 3]>> 进行解引用，把它转变成 Box<[T; 3]>
5. 此时继续对 Box<[T; 3]> 进行上面的操作 ：Box<[T; 3]>， &Box<[T; 3]>，和 &mut Box<[T; 3]> 都没有实现 Index 特征，所以编译器开始对 Box<[T; 3]> 进行解引用，然后我们得到了 [T; 3]
6. [T; 3] 以及它的各种引用都没有实现 Index 索引(是不是很反直觉:D，在直觉中，数组都可以通过索引访问，实际上只有数组切片才可以!)，它也不能再进行解引用，因此编译器只能祭出最后的大杀器：将定长转为不定长，因此 [T; 3] 被转换成 [T]，也就是数组切片，它实现了 Index 特征，因此最终我们可以通过 index 方法访问到对应的元素。
##### 3.2.1.8 有理数和复数
Rust 的标准库相比其它语言，准入门槛较高，因此有理数和复数并未包含在标准库中：
1. 有理数和复数
2. 任意大小的整数和任意精度的浮点数
3. 固定精度的十进制小数，常用于货币相关的场景
社区的数值库 https://crates.io/crates/num
Cargo.toml 中的 [dependencies] 下添加一行 num = "0.4.0"
```rust
use num::complex::Complex;

fn main() {
let a = Complex { re: 2.1, im: -1.2 };
let b = Complex::new(11.1, 22.2);
let result = a + b;

println!("{} + {}i", result.re, result.im)
```
#### 3.2.2 字符串：
字符串字面量和字符串切片 &str
#### 3.2.3 布尔类型：true 和 false
```rust
let t = true;
let f: bool = false; // 使用类型标注,显式指定f的类型
if f {
 println!("这是段毫无意义的代码");
}
```
流程控制
#### 3.2.4 字符类型：
表示单个 Unicode 字符，存储为 4 个字节
字符类型(char)
```rust
let c = 'z';
let z = 'ℤ';
let g = '国';
let heart_eyed_cat = '😻';
```
Rust 的字符不仅仅是 ASCII，所有的 Unicode 值都可以作为 Rust 字符，包括单个的中文、日文、韩文、emoji 表情符号等等，都是合法的字符类型。Unicode 值的范围从 U+0000 ~ U+D7FF 和 U+E000 ~ U+10FFFF。不过“字符”并不是 Unicode 中的一个概念，所以人在直觉上对“字符”的理解和 Rust 的字符概念并不一致。
Unicode 都是 4 个字节编码，因此字符类型也是占用 4 个字节
#### 3.2.5 单元类型：
即 () ，其唯一的值也是 ()
1. main 函数就返回这个单元类型 ()，你不能说 main 函数无返回值，因为没有返回值的函数在 Rust 中是有单独的定义的：发散函数( diverge function )，顾名思义，无法收敛的函数。
2. println!() 的返回值也是单元类型 ()
3. () 作为 map 的值，表示我们不关注具体的值，只关注 key。 这种用法和 Go 语言的 struct{} 类似，可以作为一个值用来占位，但是完全不占用任何内存。
#### 3.2.6 类型推导与标注
Rust 是一门静态类型语言，
也就是编译器必须在编译期知道我们所有变量的类型，但这不意味着你需要为每个变量指定类型，因为 Rust 编译器很聪明，它可以根据变量的值和上下文中的使用方式来自动推导出变量的类型，同时编译器也不够聪明，在某些情况下，它无法推导出变量类型，需要手动去给予一个类型标注，关于这一点在 Rust 语言初印象 中有过展示
#### 3.2.7 语句和表达式
1. 语句会执行一些操作但是不会返回一个值
2. 表达式会在求值后返回一个值
```rust
let x = x + 1; // 语句
let y = y + 5; // 语句
x + y // 表达式
```
3. let b = (let a = 8);
由于 let 是语句，因此不能将 let 语句赋值给其它值
4. let y = 6 中，6 就是一个表达式，它在求值后返回一个值 6
5. 表达式如果不返回任何值，会隐式地返回一个 () 
```rust
fn main() {
assert_eq!(ret_unit_type(), ())
}

fn ret_unit_type() {
let x = 1;
// if 语句块也是一个表达式，因此可以用于赋值，也可以直接返回
// 类似三元运算符，在Rust里我们可以这样写
let y = if x % 2 == 1 {
"odd"
} else {
"even"
};
// 或者写成一行
let z = if x % 2 == 1 { "odd" } else { "even" };
}
```
#### 3.2.8 函数
声明函数的关键字 fn，函数名 add()，参数 i 和 j，参数类型和返回值类型都是 i32
![](imgs/Rust语言圣经(Rust%20Course)-2.png)
##### 3.2.8.1 函数要点
函数名和变量名使用蛇形命名法(snake case)，例如 fn add_two() -> {}
函数的位置可以随便放，Rust 不关心我们在哪里定义了函数，只要有定义即可
每个函数参数都需要标注类型
##### 3.2.8.2 函数参数
Rust 是静态类型语言，因此需要你为每一个函数参数都标识出它的具体类型
##### 3.2.8.3 函数返回
在 Rust 中函数就是表达式，因此我们可以把函数的返回值直接赋给调用者
```rust
fn plus_five(x:i32) -> i32 {
x + 5
}

fn main() {
let x = plus_five(5);
```
let x = plus_five(5)，说明我们用一个函数的返回值来初始化 x 变量，因此侧面说明了在 Rust 中函数也是表达式，这种写法等同于 let x = 5 + 5;
x + 5 没有分号，因为它是一条表达式，这个在上一节中我们也有详细介绍
##### 3.2.8.4 Rust 中的特殊返回类型
###### 3.2.8.4.1 无返回值()
单元类型 ()，是一个零长度的元组。它没啥作用，但是可以用来表达一个函数没有返回值
函数没有返回值，那么返回一个 ()
通过 ; 结尾的语句返回一个 ()
###### 3.2.8.4.2 显式返回（）
```rust
fn clear(text: &mut String) -> () {
*text = String::from("");
}
```
###### 3.2.8.4.3 永不返回的发散函数 !
当用 ! 作函数返回类型的时候，表示该函数永不返回( diverge function )，特别的，这种语法往往用做会导致程序崩溃的函数：
panic!("你已经到了穷途末路，崩溃吧！");
下面的函数创建了一个无限循环，该循环永不跳出，因此函数也永不返回：
```rust
fn forever() -> ! {
loop {
//...
};}
```

### 3.3 所有权和借用
#### 3.3.1 所有权
##### 3.3.1.1 不需要的时候释放这些空间，三种流派
1. 垃圾回收机制(GC)，在程序运行时不断寻找不再使用的内存，典型代表：Java、Go
2. 手动管理内存的分配和释放, 在程序中，通过函数调用的方式来申请和释放内存，典型代表：C++
3. 通过所有权来管理内存，编译器在编译时会根据一系列规则进行检查
rust
检查只发生在编译期，因此对于程序运行期，不会有任何性能上的损失
##### 3.3.1.2 栈(Stack)与堆(Heap)
栈和堆的核心目标就是为程序在运行时提供可供使用的内存空间。
###### 3.3.1.2.1 栈
1. 栈按照顺序存储值并以相反顺序取出值，这也被称作后进先出
2. 增加数据叫做进栈，移出数据则叫做出栈。
3. 栈中的所有数据都必须占用已知且固定大小的内存空间，假设数据大小是未知的，那么在取出数据时，你将无法取到你想要的数据
###### 3.3.1.2.2 堆
1. 大小未知或者可能变化的数据，我们需要将它存储在堆上
2. 当向堆上放入数据时，需要请求一定大小的内存空间。操作系统在堆的某处找到一块足够大的空位，把它标记为已使用，并返回一个表示该位置地址的指针，该过程被称为在堆上分配内存，有时简称为 “分配”(allocating)。
3. 接着，该指针会被推入栈中，因为指针的大小是已知且固定的，在后续使用过程中，你将通过栈中的指针，来获取数据在堆上的实际内存位置，进而访问该数据。
堆是一种缺乏组织的数据结构
###### 3.3.1.2.3 性能区别
1. 栈上分配内存比在堆上分配内存要快
因为入栈时操作系统无需进行函数调用（或更慢的系统调用）来分配新的空间，只需要将新数据放入栈顶即可。相比之下，在堆上分配内存则需要更多的工作，这是因为操作系统必须首先找到一块足够存放数据的内存空间，接着做一些记录为下一次分配做准备，如果当前进程分配的内存页不足时，还需要进行系统调用来申请更多内存。 因此，处理器在栈上分配数据会比在堆上分配数据更加高效。
###### 3.3.1.2.4 所有权与堆栈
当你的代码调用一个函数时，传递给函数的参数（包括可能指向堆上数据的指针和函数的局部变量）依次被压入栈中，当函数调用结束时，这些值将被从栈中按照相反的顺序依次移除。

因为堆上的数据缺乏组织，因此跟踪这些数据何时分配和释放是非常重要的，否则堆上的数据将产生内存泄漏 —— 这些数据将永远无法被回收。这就是 Rust 所有权系统为我们提供的强大保障。
##### 3.3.1.3 所有权原则
###### 3.3.1.3.1 原则
1.		Rust 中每一个值都被一个变量所拥有，该变量被称为值的所有者
2.		一个值同时只能被一个变量所拥有，或者说一个值只能拥有一个所有者
3.		当所有者（变量）离开作用域范围时，这个值将被丢弃(drop)
###### 3.3.1.3.2 变量作用域
<font color=#2485E3>作用域是一个变量在程序中有效的范围</font>
变量 s 绑定到了一个字符串字面值，该字符串字面值是硬编码到程序代码中的。s 变量从声明的点开始直到当前作用域的结束都是有效的：
###### 3.3.1.3.3 简单介绍 String 类型
1. 字符串字面值 let s = "hello"，s 是被硬编码进程序里的字符串值（类型为 &str ）。字符串字面值是很方便的，但是它并不适用于所有场景。原因有二：
1.1 字符串字面值是不可变的，因为被硬编码到程序代码中
1.2 并非所有字符串的值都能在编写代码时得知
2. 字符串是需要程序运行时，通过用户动态输入然后存储在内存中的，这种情况，字符串字面值就完全无用武之地。 为此，Rust 为我们提供动态字符串类型: String，该类型被分配到堆上，因此可以动态伸缩，也就能存储在编译时大小未知的文本。
3. 创建 String 类型
`let s = String::from("hello");`
###### 3.3.1.3.4 变量绑定背后的数据交互
####### <font color=#F36208>转移所有权</font>
```rust
let x = 5;
let y = x;
```
基本类型（存储在栈上），Rust 会自动拷贝
整数是 Rust 基本数据类型，是固定大小的简单值，因此这两个值都是通过自动拷贝的方式来赋值的，都被存在栈中，完全无需在堆上分配内存。
整个过程中的赋值都是通过值拷贝的方式完成（发生在栈中），因此并不需要所有权转移。
代码首先将 5 绑定到变量 x，接着拷贝 x 的值赋给 y，最终 x 和 y 都等于 5
```rust
let s1 = String::from("hello");
let s2 = s1;
```
String 不是基本类型，而且是存储在堆上的，因此不能自动拷贝。
String 类型是一个复杂类型，由存储在栈中的堆指针、字符串长度、字符串容量共同组成，其中堆指针是最重要的，它指向了真实存储字符串内容的堆内存，至于长度和容量，如果你有 Go 语言的经验，这里就很好理解：容量是堆内存分配空间的大小，长度是目前已经使用的大小。
<span style="background:red">2种情况</span>
1.	拷贝 String 和存储在堆上的字节数组 如果该语句是拷贝所有数据(深拷贝)，那么无论是 String 本身还是底层的堆上数据，都会被全部拷贝，这对于性能而言会造成非常大的影响
2.	只拷贝 String 本身 这样的拷贝非常快，因为在 64 位机器上就拷贝了 8字节的指针、8字节的长度、8字节的容量，总计 24 字节，但是带来了新的问题，还记得我们之前提到的所有权规则吧？其中有一条就是：一个值只允许有一个所有者，而现在这个值（堆上的真实字符串数据）有了两个所有者：s1 和 s2。
当变量离开作用域后，Rust 会自动调用 drop 函数并清理变量的堆内存。不过由于两个 String 变量指向了同一位置。这就有了一个问题：当 s1 和 s2 离开作用域，它们都会尝试释放相同的内存。这是一个叫做 二次释放（double free） 的错误，也是之前提到过的内存安全性 BUG 之一。两次释放（相同）内存会导致内存污染，它可能会导致潜在的安全漏洞。
因此，Rust 这样解决问题：<font color=#81B300>当 s1 被赋予 s2 后，Rust 认为 s1 不再有效</font>，因此也无需在 s1 离开作用域后 drop 任何东西，这就是把所有权从 s1 转移给了 s2，s1 在被赋予 s2 后就马上失效了。
####### <font color=#F36208>深拷贝和浅拷贝</font>
浅拷贝(shallow copy) 和 深拷贝(deep copy)，那么拷贝指针、长度和容量而不拷贝数据听起来就像浅拷贝，但是又因为 Rust 同时使第一个变量 s1 无效了，因此这个操作被称为 移动(move)，而不是浅拷贝。上面的例子可以解读为 s1 被移动到了 s2 中。那么具体发生了什么，用一张图简单说明：
![](imgs/Rust语言圣经(Rust%20Course)-3.png)
这样就解决了我们之前的问题，s1 不再指向任何数据，只有 s2 是有效的，当 s2 离开作用域，它就会释放内存。 相信此刻，你应该明白了，为什么 Rust 称呼 let a = b 为变量绑定了吧？
####### <font color=#F36208>克隆(深拷贝)</font>
Rust 永远也不会自动创建数据的 “深拷贝”。因此，任何自动的复制都不是深拷贝，可以被认为对运行时性能影响较小
clone
深度复制 String 中堆上的数据，而不仅仅是栈上的数据
```rust
let s1 = String::from("hello");
let s2 = s1.clone();

println!("s1 = {}, s2 = {}", s1, s2);
```
1. 简化编程
如果代码性能无关紧要，例如初始化程序时或者在某段时间只会执行寥寥数次时，你可以使用 clone 来简化编程。
2. 小心使用
但是对于执行较为频繁的代码（热点路径），使用 clone 会极大的降低程序性能，需要小心使用！
####### 拷贝(浅拷贝)
浅拷贝只发生在栈上，因此性能很高
```rust
let x = 5;
let y = x;
```
像整型这样的基本类型在编译时是已知大小的，会被存储在栈上，所以拷贝其实际的值是快速的。这意味着没有理由在创建变量 y 后使 x 无效（x、y 都仍然有效）。换句话说，这里没有深浅拷贝的区别，因此这里调用 clone 并不会与通常的浅拷贝有什么不同，我们可以不用管它（可以理解成在栈上做了深拷贝）。
1. Copy 的特征
如果一个类型拥有 Copy 特征，一个旧的变量在被赋值给其他变量后仍然可用，也就是赋值的过程即是拷贝的过程。
任何基本类型的组合可以 Copy ，不需要分配内存或某种形式资源的类型是可以 Copy 的。
2. 一些 Copy 的类型
所有整数类型，比如 u32
布尔类型，bool，它的值是 true 和 false
所有浮点数类型，比如 f64
字符类型，char
元组，当且仅当其包含的类型也都是 Copy 的时候。比如，(i32, i32) 是 Copy 的，但 (i32, String) 就不是
不可变引用 &T ，例如转移所有权中的最后一个例子，但是注意：可变引用 &mut T 是不可以 Copy的
###### 3.3.1.3.5 函数传值与返回
将值传递给函数，一样会发生 移动 或者 复制，就跟 let 语句一样
所有权很强大，避免了内存的不安全性，但是也带来了一个新麻烦： 总是把一个值传来传去来使用它。 传入一个函数，很可能还要从该函数传出去，结果就是语言表达变得非常啰嗦，幸运的是，Rust 提供了新功能解决这个问题。
#### 3.3.2 引用和借用
##### 3.3.2.1 引用与解引用
###### 3.3.2.1.1 借用(Borrowing)
1. 获取变量的引用
2. 当使用完毕后，也必须要物归原主
###### 3.3.2.1.2 引用
一个指针类型，指向了对象存储的内存地址
###### 3.3.2.1.3 解引用
```rust
let x = 5;
let y = &x;
assert_eq!(5, x);
assert_eq!(5, *y);
```
创建一个 i32 值的引用 y，然后使用解引用运算符来解出 y 所使用的值
变量 x 存放了一个 i32 值 5。y 是 x 的一个引用。可以断言 x 等于 5。然而，如果希望对 y 的值做出断言，必须使用 \*y 来解出引用所指向的值（也就是解引用）。一旦解引用了 y，就可以访问 y 所指向的整型值并可以与 5 做比较
##### 3.3.2.2 不可变引用
###### 3.3.2.2.1 只使用，不修改
```rust
fn main() {	let s1 = String::from("hello");
let len = calculate_length(&s1);
println!("The length of '{}' is {}.", s1, len);}
fn calculate_length(s: &String) -> usize {	s.len()}
```
1. s1 的引用作为参数传递给 calculate_length 函数
2. 通过 &s1 语法，我们创建了一个指向 s1 的引用，但是并不拥有它。因为并不拥有这个值，当引用离开作用域后，其指向的值也不会被丢弃
###### 3.3.2.2.2 & 符号即是引用，
它们允许你使用值，
但是不获取所有权
![](imgs/Rust语言圣经(Rust%20Course)-4.png)
##### 3.3.2.3 可变引用
使用+修改
```rust
fn main() {	let mut s = String::from("hello");
change(&mut s);}
fn change(some_string: &mut String) {	some_string.push_str(", world");}
```
声明 s 是可变类型，其次创建一个可变的引用 &mut s 和接受可变引用参数 some_string: &mut String 的函数。
#### 3.3.3 限制
##### 3.3.3.1 <span style="background:red">同一作用域，特定数据只能有一个可变引用</span>
```rust
let mut s = String::from("hello");

let r1 = &mut s;
let r2 = &mut s;
```
会报错 cannot borrow `s` as mutable more than once at a time 同一时间无法对 `s` 进行两次可变借用
好处:避免数据竞争
1. 两个或更多的指针同时访问同一数据
2. 至少有一个指针被用来写入数据
3. 没有同步数据访问的机制
##### 3.3.3.2 <span style="background:#f60909">可变引用与不可变引用不能同时存在</span>
```rust
let mut s = String::from("hello");

let r1 = &s; // 没问题
let r2 = &s; // 没问题
let r3 = &mut s; // 大问题
```
cannot borrow `s` as mutable because it is also borrowed as immutable
// 无法借用可变 `s` 因为它已经被借用了不可变
<font color=#F36208>引用的作用域 s 从创建开始，一直持续到它最后一次使用的地方，这个跟变量的作用域有所不同，变量的作用域从创建持续到某一个花括号 }</font>
##### 3.3.3.3 NLL
Non-Lexical Lifetimes(NLL)，专门用于找到某个引用在作用域(})结束前就不再被使用的代码位置
#### 3.3.4 悬垂引用(Dangling References)
悬垂引用也叫做悬垂指针，意思为<font color=#81B300>指针指向某个值后，这个值被释放掉了，而指针仍然存在，其指向的内存可能不存在任何值或已被其它变量重新使用。</font>
在 Rust 中编译器可以确保引用永远也不会变成悬垂状态：当你获取数据的引用后，编译器可以确保数据不会在引用结束前被释放，要想释放数据，必须先停止其引用的使用。
```rust
fn main() {
let reference_to_nothing = dangle();
}
fn dangle() -> &String {
let s = String::from("hello");
&s  }
this function's return type contains a borrowed value, but there is no value for it to be borrowed from.
```
该函数返回了一个借用的值，但是已经找不到它所借用值的来源
因为 s 是在 dangle 函数内创建的，当 dangle 的代码执行完毕后，s 将被释放，但是此时我们又尝试去返回它的引用。这意味着这个引用会指向一个无效的 String，这可不对！
```rust
fn no_dangle() -> String {
let s = String::from("hello");
s
}
```
#### 3.3.5 借用规则
1. 同一时刻，你只能拥有要么一个可变引用，要么任意多个不可变引用
2. 引用必须总是有效的
### 3.4 复合类型
#### 3.4.1 复合类型是由其它类型组合而成的，最典型的就是结构体 struct 和枚举 enum
#### 3.4.2 字符串和切片
##### 3.4.2.1 切片(slice)
引用集合中部分连续的元素序列，而不是引用整个集合。
###### 3.4.2.1.1 字符串切片
字符串而言，切片就是对 String 类型中某一部分的引用
```rust
let s = String::from("hello world");
let hello = &s[0..5];
let world = &s[6..11];
```
###### 3.4.2.1.2 创建切片
```bash
[开始索引..终止索引]
1. 开始索引是切片中第一个元素的索引位置
2. 终止索引是最后一个元素后面的索引位置
3. 右半开区间（或称为左闭右开区间）
4. 左端点是包含在内的，而右端点是不包含在内
5. 切片数据结构内部会保存开始的位置和切片的长度
	长度是通过 终止索引 - 开始索引 的方式计算得来的
```
![](imgs/Rust语言圣经(Rust%20Course)-5.png)
从索引 0 开始
```rust
let slice = &s[0..2];
let slice = &s[..2];
```
包含 String 的最后一个字节
```rust
let len = s.len();
let slice = &s[4..len];
let slice = &s[4..];
```
完整的 String 切片
```rust
let len = s.len();
let slice = &s[0..len];
let slice = &s[..];
```
<span style="background:#0779e4">切片的索引必须落在字符之间的边界位置，也就是 UTF-8 字符的边界</span>
* 中文在 UTF-8 中占用三个字节，下面的代码就会崩溃：
```rust
let s = "中国人";
let a = &s[0..2];
println!("{}",a);
```
*  只取 s 字符串的前两个字节，但是本例中每个汉字占用三个字节，因此没有落在边界处，也就是连 中 字都取不完整，此时程序会直接崩溃退出，如果改成 &s[0..3]，则可以正常通过编译
###### 3.4.2.1.3 其它切片
切片是对集合的部分引用，因此不仅仅字符串有切片，其它集合类型也有
####### 3.4.2.1.4 3.4.2.2.1 数组切片
```rust
let a = [1, 2, 3, 4, 5];
let slice = &a[1..3];
assert_eq!(slice, &[2, 3]);
```
切片的类型是 &[i32]，数组切片和字符串切片的工作方式是一样的，例如持有一个引用指向原始数组的某个元素和长度
###### 3.4.2.1.4 字符串字面量是切片
```rust
let s: &str = "Hello, world!";
```
该切片指向了程序可执行文件中的某个点，这也是为什么字符串字面量是不可变的，因为 &str 是一个不可变引用。
##### 3.4.2.2 什么是字符串?
1. Rust 中的字符是 Unicode 类型，因此每个字符占据 4 个字节内存空间，但是在字符串中不一样，字符串是 UTF-8 编码，也就是字符串中的字符所占的字节数是变化的(1 - 4)，这样有助于大幅降低字符串所占用的内存空间
2. Rust 在语言级别，只有一种字符串类型： str，它通常是以引用类型出现 &str，也就是上文提到的字符串切片。
str 类型是硬编码进可执行文件，也无法被修改
3. 在标准库里，还有多种不同用途的字符串类型，其中使用最广的即是 String 类型。
String 则是一个可增长、可改变且具有所有权的 UTF-8 编码字符串
4. 当 Rust 用户提到字符串时，往往指的就是 String 类型和 &str 字符串切片类型，这两个类型都是 UTF-8 编码。
5. OsString， OsStr， CsString 和 CsStr 分别对应的是具有所有权和被借用的变量
##### 3.4.2.3 String 与 &str 的转换
###### 3.4.2.3.1 &str ==> String 
```rust
String::from("hello,world")
"hello,world".to_string()
```
###### 3.4.2.3.2 String  ==> &str
取引用
```rust
let s = String::from("hello,world!");
say_hello(&s);
say_hello(&s[..]);
say_hello(s.as_str());
```
>实际上这种灵活用法是因为 deref 特征隐式强制转换

##### 3.4.2.4 字符串索引
在其它语言中，使用索引的方式访问字符串的某个字符或者子串是很正常的行为，但是在 Rust 中就会报错：`String` cannot be indexed by `{integer}`
```rust
let s1 = String::from("hello");
let h = s1[0];
```
###### 3.4.2.4.1 深入字符串内部
字符串的底层的数据存储格式实际上是[ u8 ]，一个字节数组。
`let hello = String::from("Hola"); `
Hola 的长度是 4 个字节，因为 "Hola" 中的每个字母在 UTF-8 编码中仅占用 1 个字节，
`let hello = String::from("中国人");`
是9 个字节的长度，因为大部分常用汉字在 UTF-8 中的长度是 3 个字节，因此这种情况下对 hello 进行索引，访问 &hello[0] 没有任何意义，因为你取不到 中 这个字符，而是取到了这个字符三个字节中的第一个字节，这是一个非常奇怪而且难以理解的返回值。
###### 3.4.2.4.2 Rust 不允许去索引字符串
字符串的不同表现形式
梵文写的字符串 “नमस्ते”
底层的字节数组如下形式：
```
[224, 164, 168, 224, 164, 174, 224, 164, 184, 224, 165, 141, 224, 164, 164,
224, 165, 135]
```
长度是 18 个字节
字符的形式去看，则是：
```
['न', 'म', 'स', '्', 'त', 'े']
```
这种形式下，第四和六两个字母根本就不存在，没有任何意义
字母串的形式去看：
```
["न", "म", "स्", "ते"]
```
因为索引操作，我们总是期望它的性能表现是 O(1)，然而对于 String 类型来说，无法保证这一点，因为 Rust 可能需要从 0 开始去遍历字符串来定位合法的字符。
##### 3.4.2.5 字符串切片
字符串切片是非常危险的操作，因为切片的索引是通过字节来进行，但是字符串又是 UTF-8 编码，因此你无法保证索引的字节刚好落在字符的边界上
```rust
let hello = "中国人";
let s = &hello[0..3];  中
```
##### 3.4.2.6 操作字符串
###### 3.4.2.6.1 追加 (Push)
```rust
let mut s = String::from("Hello ");
s.push_str("rust");
println!("追加字符串 push_str() -> {}", s);
s.push('!');
println!("追加字符 push() -> {}", s);
```
###### 3.4.2.6.2 插入 (Insert)
```rust
let mut s = String::from("Hello rust!");
s.insert(5, ',');
println!("插入字符 insert() -> {}", s);
s.insert_str(6, " I like");
println!("插入字符串 insert_str() -> {}", s);
```
需要传入两个参数，第一个参数是字符（串）插入位置的索引，第二个参数是要插入的字符（串），索引从 0 开始计数，如果越界则会发生错误。由于字符串插入操作要修改原来的字符串，则该字符串必须是可变的，即字符串变量必须由 mut 关键字修饰。
###### 3.4.2.6.3 替换 (Replace)
1. replace
```rust
let string_replace = String::from("I like rust. Learning rust is my favorite!");
let new_string_replace = string_replace.replace("rust", "RUST");
dbg!(new_string_replace);
```
<font color=#81B300>适用于 String 和 &str 类型</font>
第一个参数是要被替换的字符串，第二个参数是新的字符串。该方法会替换所有匹配到的字符串。该方法是返回一个新的字符串，而不是操作原来的字符串。
2. replacen
<font color=#81B300>适用于 String 和 &str 类型</font>
前两个参数与 replace() 方法一样，第三个参数则表示替换的个数。该方法是返回一个新的字符串，而不是操作原来的字符串。
```rust
let string_replace = "I like rust. Learning rust is my favorite!";
let new_string_replacen = string_replace.replacen("rust", "RUST", 1);
dbg!(new_string_replacen);
```
3. replace_range
<font color=#81B300>仅适用于 String 类型</font>
第一个参数是要替换字符串的范围（Range），第二个参数是新的字符串。该方法是直接操作原来的字符串，不会返回新的字符串。该方法需要使用 mut 关键字修饰。
```rust
let mut string_replace_range = String::from("I like rust!");
string_replace_range.replace_range(7..8, "R");
dbg!(string_replace_range);
```
###### 3.4.2.6.4 删除 (Delete)
1. pop —— 删除并返回字符串的最后一个字符
```rust
let mut string_pop = String::from("rust pop 中文!");
let p1 = string_pop.pop();
let p2 = string_pop.pop();
dbg!(p1);
dbg!(p2);
dbg!(string_pop);
p1 = Some(   '!',)
p2 = Some(   '文',)
string_pop = "rust pop 中"
```
<font color=#81B300>直接操作原来的字符串</font>。但是存在返回值，其返回值是一个 Option 类型，如果字符串为空，则返回 None
2. remove —— 删除并返回字符串中指定位置的字符
<font color=#81B300>直接操作原来的字符串</font>。但是存在返回值，其返回值是删除位置的字符串，只接收一个参数，表示该字符起始索引位置。remove() 方法是按照字节来处理字符串的，如果参数所给的位置不是合法的字符边界，则会发生错误。
```rust
let mut string_remove = String::from("测试remove方法");
println!(
"string_remove 占 {} 个字节",
std::mem::size_of_val(string_remove.as_str())
);
// 删除第一个汉字
string_remove.remove(0);
// 下面代码会发生错误
// string_remove.remove(1);
// 直接删除第二个汉字
// string_remove.remove(3);
dbg!(string_remove);
string_remove 占 18 个字节
string_remove = "试remove方法"
```
3. truncate —— 删除字符串中从指定位置开始到结尾的全部字符
<font color=#81B300>直接操作原来的字符串</font>。无返回值。该方法 truncate() 方法是按照字节来处理字符串的，如果参数所给的位置不是合法的字符边界，则会发生错误
```rust
let mut string_truncate = String::from("测试truncate");
string_truncate.truncate(3);
dbg!(string_truncate);  # "测"
```
4. clear —— 清空字符串
该方法是直接操作原来的字符串。调用后，删除字符串中的所有字符，相当于 truncate() 方法参数为 0 的时候。
```rust
let mut string_clear = String::from("string clear");
string_clear.clear();
dbg!(string_clear);  //string_clear = ""
```
###### 3.4.2.6.5 连接 (Concatenate)
1. 使用 + 或者 += 连接字符串
<font color=#F36208>要求右边的参数必须为字符串的切片引用（Slice）类型</font>
其实当调用 + 的操作符时，相当于调用了 std::string 标准库中的 add() 方法，这里 add() 方法的第二个参数是一个引用的类型。因此我们在使用 + 时， 必须传递切片引用类型。不能直接传递 String 类型。+ 是返回一个新的字符串，所以变量声明可以不需要 mut 关键字修饰。
```rust
let string_append = String::from("hello ");
let string_rust = String::from("rust");
// &string_rust会自动解引用为&str
let result = string_append + &string_rust;
let mut result = result + "!"; // `result + "!"` 中的 `result` 是不可变的
result += "!!!";

println!("连接字符串 + -> {}", result);  //连接字符串 + -> hello rust!!!!
```
String + &str返回一个 String，然后再继续跟一个 &str 进行 + 操作，返回一个 String 类型，不断循环，最终生成一个 s，也是 String 类型
2. 使用 format! 连接字符串
format! 这种方式适用于 String 和 &str 。format! 的用法与 print! 的用法类似，详见格式化输出。
```rust
let s1 = "hello";
let s2 = String::from("rust");
let s = format!("{} {}!", s1, s2);
```
##### 3.4.2.7 字符串转义
###### 3.4.2.7.1 通过转义的方式 \ 输出 ASCII 和 Unicode 字符
```rust
// 通过 \ + 字符的十六进制表示，转义输出一个字符
let byte_escape = "I'm writing \x52\x75\x73\x74!";
println!("What are you doing\x3F (\\x3F means ?) {}", byte_escape);

// \u 可以输出一个 unicode 字符
let unicode_codepoint = "\u{211D}";
let character_name = "\"DOUBLE-STRUCK CAPITAL R\"";

println!(
"Unicode character {} (U+211D) is called {}",
unicode_codepoint, character_name
);

// 换行了也会保持之前的字符串格式
// 使用\忽略换行符
let long_string = "String literals
can span multiple lines.
The linebreak and indentation here ->\
<- can be escaped too!";
println!("{}", long_string);
```
###### 3.4.2.7.2 保持字符串的原样，不要转义
```rust
println!("{}", "hello \\x52\\x75\\x73\\x74");
let raw_str = r"Escapes don't work here: \x3F \u{211D}";
println!("{}", raw_str);

// 如果字符串包含双引号，可以在开头和结尾加 #
let quotes = r#"And then I said: "There is no escape!""#;
println!("{}", quotes);

// 如果字符串中包含 # 号，可以在开头和结尾加多个 # 号，最多加255个，只需保证与字符串中连续 # 号的个数不超过开头和结尾的 # 号的个数即可
let longer_delimiter = r###"A string with "# in it. And even "##!"###;
println!("{}", longer_delimiter);
```
##### 3.4.2.8 操作 UTF-8 字符串
###### 3.4.2.8.1 字符
以 Unicode 字符的方式遍历字符串
```rust
for c in "中国人".chars() {
println!("{}", c);
}
//
中
国
人
```
###### 3.4.2.8.2 字节
返回字符串的底层字节数组表现形式
```rust
for b in "中国人".bytes() {
println!("{}", b);
}
```
###### 3.4.2.8.3 获取子串
准确的从 UTF-8 字符串中获取子串是较为复杂的事情，例如想要从 holla中国人नमस्ते 这种变长的字符串中取出某一个子串，使用标准库你是做不到的。 你需要在 crates.io 上搜索 utf8 来寻找想要的功能。
https://crates.io/crates/utf8_slice
##### 3.4.2.9 字符串深度剖析
<font color=#F36208>String 可变，而字符串字面值 str 却不可以</font>
###### 3.4.2.9.1 字符串字面值
编译时就知道其内容，最终字面值文本被直接硬编码进可执行文件中，这使得字符串字面值快速且高效
###### 3.4.2.9.2 String 类型
支持一个可变、可增长的文本片段，需要在堆上分配一块在编译时未知大小的内存来存放内容，这些都是在程序运行时完成的
1. 首先向操作系统请求内存来存放 String 对象
第一部分由 String::from 完成，它创建了一个全新的 String。
2. 在使用完成后，将内存释放，归还给操作系统
rust中变量在离开作用域后，就自动释放其占用的内存
>Rust 也提供了一个释放内存的函数drop，但是不同的是，其它语言要手动调用 free 来释放每一个变量占用的内存，而 Rust 则在变量离开作用域时，自动调用 drop 函数：上面代码中，Rust 在结尾的 } 处自动调用 drop。
#### 3.4.3 元组
多种类型组合到一起形成的，因此它是复合类型，元组的长度是固定的，元组中元素的顺序也是固定的
##### 3.4.3.1 创建一个元组
```rust
let tup: (i32, f64, u8) = (500, 6.4, 1);
```
变量 tup 被绑定了一个元组值 (500, 6.4, 1)，该元组的类型是 (i32, f64, u8)
##### 3.4.3.2 访问元组
###### 3.4.3.2.1 用模式匹配解构元组
模式匹配可以让我们一次性把元组中的值全部或者部分获取出来
```rust
 let tup = (500, 6.4, 1);
let (x, y, z) = tup;
println!("The value of y is: {}", y);
```
###### 3.4.3.2.2 用 . 来访问元组
只想要访问某个特定元素
```rust
let x: (i32, f64, u8) = (500, 6.4, 1);
let five_hundred = x.0;
let six_point_four = x.1;
let one = x.2;
```
###### 3.4.3.2.3 使用示例
使用元组返回多个值
```rust
fn main() {
let s1 = String::from("hello");
let (s2, len) = calculate_length(s1);
println!("The length of '{}' is {}.", s2, len);
}
fn calculate_length(s: String) -> (String, usize) {
let length = s.len(); // len() 返回字符串的长度
(s, length)
}
```
#### 3.4.4 结构体
由多种类型组合而成。但是与元组不同的是，结构体可以为内部的每个字段起一个富有含义的名称。因此结构体更加灵活更加强大，你无需依赖这些字段的顺序来访问和解析它们。
##### 3.4.4.1 结构体语法
###### 3.4.4.1.1 定义结构体
```rust
struct User {
active: bool,
username: String,
email: String,
sign_in_count: u64,
}
```
###### 3.4.4.1.2 结构体组成
1. 通过关键字 struct 定义
2. 一个清晰明确的结构体 名称
3. 几个有名字的结构体 字段
###### 3.4.4.1.3 创建结构体实例
```rust
let user1 = User {
email: String::from("someone@example.com"),
 username: String::from("someusername123"),
active: true,
 sign_in_count: 1,
};
```
<span style="background:#f60909">初始化实例时，每个字段都需要进行初始化</span>
<span style="background:#f60909">初始化时的字段顺序不需要和结构体定义时的顺序一致</span>
###### 3.4.4.1.4 访问结构体字段
通过 . 操作符即可访问结构体实例内部的字段值，也可以修改它们
```rust
let mut user1 = User {
 email: String::from("someone@example.com"),
 username: String::from("someusername123"),
 active: true,
 sign_in_count: 1,
};
user1.email = String::from("anotheremail@example.com");
```
<font color=#F36208>必须要将结构体实例声明为可变的，才能修改其中的字段</font>，Rust 不支持将某个结构体某个字段标记为可变。
###### 3.4.4.1.5 简化结构体创建
下面的函数类似一个构建函数，返回了 User 结构体的实例：
```rust
fn build_user(email: String, username: String) -> User {
User {
email: email,
 username: username,
active: true,
 sign_in_count: 1,
}}
```
当函数参数和<font color=#F36208>结构体字段同名时，可以直接使用缩略的方式进行初始化</font>，跟 TypeScript 中一模一样。
###### 3.4.4.1.6 结构体更新语法
根据已有的结构体实例，创建新的结构体实例
```rust
let user2 = User {
 active: user1.active,
 username: user1.username,
 email: String::from("another@example.com"),
 sign_in_count: user1.sign_in_count,
};
let user2 = User {
 email: String::from("another@example.com"),
..user1
};
```
因为 user2 仅仅在 email 上与 user1 不同，因此我们只需要对 email 进行赋值，剩下的通过结构体更新语法 ..user1 即可完成。
`.. 语法`表明凡是我们没有显式声明的字段，全部从 user1 中自动获取。需要注意的是 ..user1 必须在结构体的尾部使用。
1. 结构体更新语法跟赋值语句 = 非常相像，因此在上面代码中，user1 的部分字段所有权被转移到 user2 中：username 字段发生了所有权转移，作为结果，user1 无法再被使用。
2. 聪明的读者肯定要发问了：明明有三个字段进行了自动赋值，为何只有 username 发生了所有权转移？
3. 仔细回想一下所有权那一节的内容，我们提到了 Copy 特征：实现了 Copy 特征的类型无需所有权转移，可以直接在赋值时进行 数据拷贝，其中 bool 和 u64 类型就实现了 Copy 特征，因此 active 和 sign_in_count 字段在赋值给 user2 时，仅仅发生了拷贝，而不是所有权转移。
4. 值得注意的是：username 所有权被转移给了 user2，导致了 user1 无法再被使用，但是并不代表 user1 内部的其它字段不能被继续使用，例如：
```rust
let user1 = User {
email: String::from("someone@example.com"),
username: String::from("someusername123"),
active: true,
sign_in_count: 1,
};
let user2 = User {
active: user1.active,
username: user1.username,
email: String::from("another@example.com"),
sign_in_count: user1.sign_in_count,
};
println!("{}", user1.active);
// 下面这行会报错
println!("{:?}", user1);
```
##### 3.4.4.2 结构体的内存排列
![](imgs/Rust语言圣经(Rust%20Course)-6.png)
```rust
#[derive(Debug)]
struct File {
name: String,
data: Vec<u8>,
}

fn main() {
let f1 = File {
name: String::from("f1.txt"),
data: Vec::new(),
};

let f1_name = &f1.name;
let f1_length = &f1.data.len();

println!("{:?}", f1);
println!("{} is {} bytes long", f1_name, f1_length);
}
```
1. File 结构体两个字段 name 和 data 分别拥有底层两个 [u8] 数组的所有权（String 类型的底层也是 [u8] 数组），通过 ptr 指针指向底层数组的内存地址，这里你可以把 ptr 指针理解为 Rust 中的引用类型。
2. 把结构体中具有所有权的字段转移出去后，将无法再访问该字段，但是可以正常访问其它的字段
##### 3.4.4.3 元组结构体(Tuple Struct)
结构体必须要有名称，但是<font color=#F36208>结构体的字段可以没有名称</font>，这种结构体长得很像元组，因此被称为元组结构体，例如：
```rust
struct Color(i32, i32, i32);
struct Point(i32, i32, i32);

let black = Color(0, 0, 0);
let origin = Point(0, 0, 0);
```
元组结构体在你希望有一个整体名称，但是又不关心里面字段的名称时将非常有用
##### 3.4.4.4 单元结构体(Unit-like Struct)
如果你定义一个类型，但是不关心该类型的内容，<font color=#2485E3>只关心它的行为时</font>，就可以使用 单元结构体：
```rust
struct AlwaysEqual;
let subject = AlwaysEqual;
```
// 我们不关心 AlwaysEqual 的字段数据，只关心它的行为，因此将它声明为单元结构体，然后再为它实现某个特征
```rust
impl SomeTrait for AlwaysEqual {
}
```
##### 3.4.4.5 结构体数据的所有权
1. 在之前的 User 结构体的定义中，有一处细节：我们使用了自身拥有所有权的 String 类型而不是基于引用的 &str 字符串切片类型。这是一个有意而为之的选择：因为我们想要这个结构体拥有它所有的数据，而不是从其它地方借用数据。
2. 你也可以让 User 结构体从其它对象借用数据，不过这么做，就需要引入生命周期(lifetimes)这个新概念（也是一个复杂的概念），简而言之，生命周期能确保结构体的作用范围要比它所借用的数据的作用范围要小。
3. 总之，如果你想在结构体中使用一个引用，就必须加上生命周期，否则就会报错：
```rust
struct User {
username: &str,
email: &str,
sign_in_count: u64,
active: bool,
}

fn main() {
let user1 = User {
 email: "someone@example.com",
username: "someusername123",
 active: true,
 sign_in_count: 1,
};
}编译器会抱怨它需要生命周期标识符：
```

###### 3.4.4.5.1 打印结构体的信息
1. 结构体默认不实现 Display 特征
原因在于结构体较为复杂，例如考虑以下问题：你想要逗号对字段进行分割吗？需要括号吗？加在什么地方？所有的字段都应该显示？类似的还有很多，由于这种复杂性，Rust 不希望猜测我们想要的是什么，而是把选择权交给我们自己来实现：如果要用 {} 的方式打印结构体，那就自己实现 Display 特征。
2. 使用 #[derive(Debug)] 来标记结构体
<span style="background:darkblue">使用{} 来格式化输出</span>
对应的类型就必须实现 Display 特征，以前学习的基本类型，都默认实现了该特征:  
```rust
println!("{}, {}", v, b);
```
<span style="background:#0779e4">使用{:?} 来格式化输出</span>
```rust
 println!("{:?}", s); 
rect1 is Rectangle { width: 30, height: 50 }
```
Rust 自动为我们提供的实现，看上基本就跟结构体的定义形式一样
<span style="background:#0779e4">{:#?} 来替代 {:?}</span> 希望能够有更好的输出表现
```rust
rect1 is Rectangle {
width: 30,
height: 50,
}
```
输出跟我们创建时候的代码几乎一模一样了
3. 结构体默认不实现 Debug特征
手动实现
使用 derive 派生实现
4. 使用 dbg! 宏
会拿走表达式的所有权，然后打印出相应的文件名、行号等 debug 信息，当然还有我们需要的表达式的求值结果。除此之外，它最终还会把表达式值的所有权返回！
dbg! 输出到标准错误输出 stderr，而 println! 输出到标准输出 stdout。
```rust
#[derive(Debug)]
struct Rectangle {
width: u32,
height: u32,
}

fn main() {
let scale = 2;
let rect1 = Rectangle {
 width: dbg!(30 * scale),
 height: 50,
};

dbg!(&rect1);
}
$ cargo run
[src/main.rs:10] 30 * scale = 60
[src/main.rs:14] &rect1 = Rectangle {
width: 60,
height: 50,
}
```
#### 3.4.5 枚举
枚举(enum 或 enumeration)允许你通过列举可能的成员来定义一个枚举类型
```rust
enum PokerSuit {
Clubs,
Spades,
Diamonds,
Hearts,
}
```
##### 3.4.5.1 枚举值
```rust
let heart = PokerSuit::Hearts;
let diamond = PokerSuit::Diamonds;
```
通过 :: 操作符来访问 PokerSuit 下的具体成员
给每张牌赋予一个值：A(1)-K(13)，这样再加上花色，就是一张真实的扑克牌
```rust
enum PokerSuit {
Clubs,
Spades,
Diamonds,
Hearts,
}

struct PokerCard {
suit: PokerSuit,
value: u8
}

fn main() {
let c1 = PokerCard {
suit: PokerSuit::Clubs,
value: 1,
};
let c2 = PokerCard {
suit: PokerSuit::Diamonds,
value: 12,
};
}
```
结构体 PokerCard 来代表一张牌，结构体的 suit 字段表示牌的花色，类型是 PokerSuit 枚举类型，value 字段代表扑克牌的数值。
简洁的方式实现
```rust
enum PokerCard {
Clubs(u8),
Spades(u8),
Diamonds(u8),
Hearts(u8),
}

fn main() {
let c1 = PokerCard::Spades(5);
let c2 = PokerCard::Diamonds(13);
}
```
直接将数据信息关联到枚举成员上，省去近一半的代码，这种实现是不是更优雅？
同一个枚举类型下的不同成员还能持有不同的数据类型，例如让某些花色打印 1-13 的字样，另外的花色打印上 A-K 的字样
```rust
enum PokerCard {
Clubs(u8),
Spades(u8),
Diamonds(char),
Hearts(char),
}

fn main() {
let c1 = PokerCard::Spades(5);
let c2 = PokerCard::Diamonds('A');
}
```
任何类型的数据都可以放入枚举成员中：例如字符串、数值、结构体甚至另一个枚举
##### 3.4.5.2 更多示例
```rust
enum Message {
Quit,
Move { x: i32, y: i32 },
Write(String),
ChangeColor(i32, i32, i32),
}

fn main() {
let m1 = Message::Quit;
let m2 = Message::Move{x:1,y:1};
let m3 = Message::ChangeColor(255,255,0);
}
```
Quit 没有任何关联数据
Move 包含一个匿名结构体
Write 包含一个 String 字符串
ChangeColor 包含三个 i32
当然，我们也可以用结构体的方式来定义这些消息：
```rust
struct QuitMessage; // 单元结构体
struct MoveMessage {
x: i32,
y: i32,
}
struct WriteMessage(String); // 元组结构体
struct ChangeColorMessage(i32, i32, i32); // 元组结构体
```
由于每个结构体都有自己的类型，因此我们无法在需要同一类型的地方进行使用，例如某个函数它的功能是接受消息并进行发送，那么用枚举的方式，就可以接收不同的消息，但是用结构体，该函数无法接受 4 个不同的结构体作为参数。

而且从代码规范角度来看，枚举的实现更简洁，代码内聚性更强，不像结构体的实现，分散在各个地方。
##### 3.4.5.3 同一化类型
一个实际项目中的简化片段
例如我们有一个 WEB 服务，需要接受用户的长连接，假设连接有两种：TcpStream 和 TlsStream，但是我们希望对这两个连接的处理流程相同，也就是用同一个函数来处理这两个连接
```rust
fn new (stream: TcpStream) {
let mut s = stream;
if tls {
s = negotiate_tls(stream)
}

// websocket是一个WebSocket<TcpStream>或者
//   WebSocket<native_tls::TlsStream<TcpStream>>类型
websocket = WebSocket::from_raw_socket(
s, ......)
}
enum Websocket {
Tcp(Websocket<TcpStream>),
Tls(Websocket<native_tls::TlsStream<TcpStream>>),
}
```
##### 3.4.5.4 Option 枚举用于处理空值
###### 3.4.5.4.1 null 关键字
关键字用于表明一个变量当前的值为空（不是零值，例如整型的零值是 0），也就是不存在值。当你对这些 null 进行操作时，例如调用一个方法，就会直接抛出 null 异常，导致程序的崩溃，因此我们在编程时需要格外的小心去处理这些 null 空值。
Tony Hoare， null 的发明者，曾经说过一段非常有名的话：
我称之为我十亿美元的错误。当时，我在使用一个面向对象语言设计第一个综合性的面向引用的类型系统。我的目标是通过编译器的自动检查来保证所有引用的使用都应该是绝对安全的。不过在设计过程中，我未能抵抗住诱惑，引入了空引用的概念，因为它非常容易实现。就是因为这个决策，引发了无数错误、漏洞和系统崩溃，在之后的四十多年中造成了数十亿美元的苦痛和伤害。
尽管如此，空值的表达依然非常有意义，因为空值表示当前时刻变量的值是缺失的
###### 3.4.5.4.2 Rust 吸取了众多教训，决定抛弃 null，而改为使用 Option 枚举变量来表述这种结果。
1. `Option<T> `为什么就比空值要好呢
```rust
// 因为 Option<T> 和 T（这里 T 可以是任何类型）是不同的类型，例如，这段代码不能编译，因为它尝试将 Option<i8>(Option<T>) 与 i8(T) 相加：

let x: i8 = 5;
let y: Option<i8> = Some(5);

let sum = x + y;
let sum = x + y;
|				 ^ no implementation for `i8 + std::option::Option<i8>`
错误信息意味着 Rust 不知道该如何将 Option<i8> 与 i8 相加，因为它们的类型不同。当在 Rust 中拥有一个像 i8 这样类型的值时，编译器确保它总是有一个有效的值，我们可以放心使用而无需做空值检查。只有当使用 Option<i8>（或者任何用到的类型）的时候才需要担心可能没有值，而编译器会确保我们在使用值之前处理了为空的情况。
换句话说，在对 Option<T> 进行 T 的运算之前必须将其转换为 T。通常这能帮助我们捕获到空值最常见的问题之一：期望某值不为空但实际上为空的情况
不再担心会错误的使用一个空值，会让你对代码更加有信心。为了拥有一个可能为空的值，你必须要显式的将其放入对应类型的 Option<T> 中。接着，当使用这个值时，必须明确的处理值为空的情况。只要一个值不是 Option<T> 类型，你就 可以 安全的认定它的值不为空。这是 Rust 的一个经过深思熟虑的设计决策，来限制空值的泛滥以增加 Rust 代码的安全性。
```
###### 3.4.5.4.3 那么当有一个 `Option<T> `的值时，如何从 Some 成员中取出 T 的值来使用它呢
`Option<T> `枚举拥有大量用于各种情况的方法：你可以查看它的文档。熟悉 `Option<T> `的方法将对你的 Rust 之旅非常有用。
总的来说，为了使用` Option<T> `值，需要编写处理每个成员的代码。你想要一些代码只当拥有 Some(T) 值时运行，允许这些代码使用其中的 T。也希望一些代码在值为 None 时运行，这些代码并没有一个可用的 T 值。match 表达式就是这么一个处理枚举的控制流结构：它会根据枚举的成员运行不同的代码，这些代码可以使用匹配到的值中的数据。
```rust
fn plus_one(x: Option<i32>) -> Option<i32> {
match x {
### 3.5 None => None,
### 3.6 Some(i) => Some(i + 1),
}
}

let five = Some(5);
let six = plus_one(five);
let none = plus_one(None);
```
plus_one 通过 match 来处理不同 Option 的情况。
###### 3.4.5.4.4 Option 枚举包含两个成员，一个成员表示含有值：Some(T), 另一个表示没有值：None，定义如下：
```rust
enum Option<T> {
Some(T),
None,
}
```
其中 T 是泛型参数，Some(T)表示该枚举成员的数据类型是 T，换句话说，Some 可以包含任何类型的数据。
`Option<T> `枚举是如此有用以至于它被包含在了 prelude（prelude 属于 Rust 标准库，Rust 会将最常用的类型、函数等提前引入其中，省得我们再手动引入）之中，你不需要将其显式引入作用域。另外，它的成员 Some 和 None 也是如此，无需使用 Option:: 前缀就可直接使用 Some 和 None。总之，不能因为 Some(T) 和 None 中没有 Option:: 的身影，就否认它们是 Option 下的卧龙凤雏。
```rust
let some_number = Some(5);
let some_string = Some("a string");

let absent_number: Option<i32> = None;
```
如果使用 None 而不是 Some，需要告诉 Rust `Option<T> `是什么类型的，因为编译器只通过 None 值无法推断出 Some 成员保存的值的类型。
当有一个 Some 值时，我们就知道存在一个值，而这个值保存在 Some 中。当有个 None 值时，在某种意义上，它跟空值具有相同的意义：并没有一个有效的值。
#### 3.4.6 数组
##### 3.4.6.1 我们称 array 为数组，Vector 为动态数组。
1. 元素类型大小固定，且长度也是固定，因此数组 array 是存储在栈上，性能也会非常优秀。
2. 动态数组 Vector 是存储在堆上，因此长度可以动态改变。当你不确定是使用数组还是动态数组时，那就应该使用后者，具体见动态数组 Vector。
将多个类型相同的元素依次组合在一起，就是一个数组
Rust 的基本类型，是<font color=#F36208>固定长度</font>的
##### 3.4.6.2 数组的三要素
1. 长度固定
2. 元素必须有相同的类型
3. 依次线性排列
##### 3.4.6.3 创建数组
```rust
let a = [1, 2, 3, 4, 5];
let months = ["January", "February", "March", "April", "May", "June", "July",  "August", "September", "October", "November", "December"];
let a: [i32; 5] = [1, 2, 3, 4, 5];
```
为数组声明类型，i32 是元素类型，分号后面的数字 5 是数组长度
```rust
let a = [3; 5];
```
初始化一个某个值重复出现 N 次的数组，包含 5 个元素，这些元素的初始化值为 3
##### 3.4.6.4 访问数组元素
数组是连续存放元素的，因此可以通过索引的方式来访问存放其中的元素
```rust
let a = [9, 8, 7, 6, 5];
let first = a[0]; // 获取a数组第一个元素
let second = a[1]; // 获取第二个元素
```
###### 3.4.6.4.1 越界访问
使用超出数组范围的索引访问数组元素
```rust
// 接收用户的控制台输入，然后将其作为索引访问数组元素
use std::io;
fn main() {
let a = [1, 2, 3, 4, 5];

println!("Please enter an array index.");

let mut index = String::new();
// 读取控制台的输出
io::stdin()
.read_line(&mut index)
.expect("Failed to read line");

let index: usize = index
.trim()
.parse()
.expect("Index entered was not a number");

let element = a[index];

println!(
"The value of the element at index {} is: {}",
### 3.5 index, element
);
}
//  因为数组只有 5 个元素，如果我们试图输入 5 去访问第 6 个元素，则会访问到不存在的数组元素，最终程序会崩溃退出
```
当你尝试使用索引访问元素时，Rust 将检查你指定的索引是否小于数组长度。如果索引大于或等于数组长度，Rust 会出现 panic。这种检查只能在运行时进行，比如在上面这种情况下，编译器无法在编译期知道用户运行代码时将输入什么值。

这种就是 Rust 的安全特性之一。在很多系统编程语言中，并不会检查数组越界问题，你会访问到无效的内存地址获取到一个风马牛不相及的值，最终导致在程序逻辑上出现大问题，而且这种问题会非常难以检查。
###### 3.4.6.4.2 数组元素为非基础类型
```rust
let array = [String::from("rust is good!"); 8];

println!("{:#?}", array);
// 会报错：the trait bound `String: std::marker::Copy` is not satisfied
let array=[3;5]底层就是不断的Copy出来的，但很可惜复杂类型都没有深拷贝，只能一个个创建。
let array = [String::from("rust is good!"),String::from("rust is good!"),String::from("rust is good!")];

println!("{:#?}", array);
	正确的简化幽雅写法 
		let array: [String; 8] = std::array::from_fn(|_i| String::from("rust is good!"));

println!("{:#?}", array);
```
##### 3.4.6.5 数组切片
数组切片允许我们引用数组的一部分
```rust
let a: [i32; 5] = [1, 2, 3, 4, 5];

let slice: &[i32] = &a[1..3];

assert_eq!(slice, &[2, 3]);
```
数组切片 slice 的类型是&[i32]，与之对比，数组的类型是[i32;5]
###### 3.4.6.5.1 切片的特点
1. 切片的长度可以与数组不同，并不是固定的，而是取决于你使用时指定的起始和结束位置
2. 创建切片的代价非常小，因为切片只是针对底层数组的一个引用
3. 切片类型 [T] 拥有不固定的大小，而切片引用类型 &[T] 则具有固定的大小，因为 Rust 很多时候都需要固定大小数据类型，因此 &[T] 更有用，&str 字符串切片也同理
###### 3.4.6.5.2 综合性使用数组的例子
```rust
fn main() {
// 编译器自动推导出one的类型
let one			 = [1, 2, 3];
// 显式类型标注
let two: [u8; 3]	= [1, 2, 3];
let blank1		  = [0; 3];
let blank2: [u8; 3] = [0; 3];

// arrays是一个二维数组，其中每一个元素都是一个数组，元素类型是[u8; 3]
let arrays: [[u8; 3]; 4]  = [one, two, blank1, blank2];

// 借用arrays的元素用作循环中
for a in &arrays {
print!("{:?}: ", a);
// 将a变成一个迭代器，用于循环
// 你也可以直接用for n in a {}来进行循环
for n in a.iter() {
print!("\t{} + 10 = {}", n, n+10);
}

let mut sum = 0;
// 0..a.len,是一个 Rust 的语法糖，其实就等于一个数组，元素是从0,1,2一直增加到到a.len-1
for i in 0..a.len() {
sum += a[i];
}
println!("\t({:?} = {})", a, sum);
}
}
```
###### 3.4.6.5.3 总结
1. 数组类型容易跟数组切片混淆，[T;n] 描述了一个数组的类型，而 [T] 描述了切片的类型， 因为切片是运行期的数据结构，它的长度无法在编译期得知，因此不能用 [T;n] 的形式去描述
2. [u8; 3]和[u8; 4]是不同的类型，数组的长度也是类型的一部分
在实际开发中，使用最多的是数组切片[T]，我们往往通过引用的方式去使用&[T]，因为后者有固定的类型大小
### 3.5 流程控制
#### 3.5.1 使用 if 来做分支控制
```rust
if condition == true {
// A...
} else {
// B...
}
```
if 语句块是表达式，这里我们使用 if 表达式的返回值来给 number 进行赋值：number 的值是 5
用 if 来赋值时，要保证每个分支返回的类型一样（事实上，这种说法不完全准确，见这里），此处返回的 5 和 6 就是同一个类型，如果返回类型不一致就会报错
#### 3.5.2 使用 else if 来处理多重条件
可以将 else if 与 if、else 组合在一起实现更复杂的条件分支判断：
```rust
let n = 6;

if n % 4 == 0 {
 println!("number is divisible by 4");
} else if n % 3 == 0 {
 println!("number is divisible by 3");
} else if n % 2 == 0 {
 println!("number is divisible by 2");
} else {
 println!("number is not divisible by 4, 3, or 2");
}
```
就算有多个分支能匹配，也只有第一个匹配的分支会被执行！
#### 3.5.3 循环控制
for 循环
```rust
for i in 1..=5 {
 println!("{}", i);
}
```
```
for 元素 in 集合 {
// 使用元素干一些你懂我不懂的事情
}
```
```
for item in &container {
// ...
}
```
使用 for 时我们往往使用集合的引用形式，除非你不想在后面的代码中继续使用该集合（比如我们这里使用了 container 的引用）。如果不使用引用的话，所有权会被转移（move）到 for 语句块中，后面就无法再使用这个集合了)：
对于实现了 copy 特征的数组（例如 [i32; 10]）而言， for item in arr 并不会把 arr 的所有权转移，而是直接对其进行了拷贝，因此循环之后仍然可以使用 arr 。
1. 想在循环中，修改该元素，可以使用 mut 关键字
```
for item in &mut collection {
// ...
}
```
![](imgs/Rust语言圣经(Rust%20Course)-7.png)
2. 想在循环中获取元素的索引
```rust
let a = [4, 3, 2, 1];
// `.iter()` 方法把 `a` 数组变成一个迭代器
for (i, v) in a.iter().enumerate() {
 println!("第{}个元素是{}", i + 1, v);
}
```
3. 想用 for 循环控制某个过程执行 10 次，但是又不想单独声明一个变量来控制这个流程
```rust
for _ in 0..10 {
// ...
}
_ 来替代 i 用于 for 循环中，在 Rust 中 _ 的含义是忽略该值或者类型的意思，如果不使用 _，那么编译器会给你一个 变量未使用的 的警告
```

3. 两种循环方式优劣对比
```rust
// 第一种
let collection = [1, 2, 3, 4, 5];
for i in 0..collection.len() {
let item = collection[i];
// ...
}

// 第二种
for item in collection {

}
```
第一种方式是循环索引，然后通过索引下标去访问集合，第二种方式是直接循环集合中的元素，优劣如下：
1. 性能：第一种使用方式中 collection[index] 的索引访问，会因为边界检查(Bounds Checking)导致运行时的性能损耗 —— Rust 会检查并确认 index 是否落在集合内，但是第二种直接迭代的方式就不会触发这种检查，因为编译器会在编译时就完成分析并证明这种访问是合法的
2. 安全：第一种方式里对 collection 的索引访问是非连续的，存在一定可能性在两次访问之间，collection 发生了变化，导致脏数据产生。而第二种直接迭代的方式是连续访问，因此不存在这种风险( 由于所有权限制，在访问过程中，数据并不会发生变化)。
3. 由于 for 循环无需任何条件限制，也不需要通过索引来访问，因此是最安全也是最常用的，通过与下面的 while 的对比，我们能看到为什么 for 会更加安全。
#### 3.5.4 continue
跳过当前当次的循环
```rust
for i in 1..4 {
if i == 2 {
continue;
}
println!("{}", i);
}
```
#### 3.5.5 break
break 可以直接跳出当前整个循环
```rust
for i in 1..4 {
if i == 2 {
break;
}
println!("{}", i);
}
```
#### 3.5.6 while 循环
需要一个条件来循环，当该条件为 true 时，继续循环，条件为 false，跳出循环
```rust
let mut n = 0;

while n <= 5  {
 println!("{}!", n);

n = n + 1;
}

println!("我出来了！");
// 另一种loop实现方式
fn main() {
let mut n = 0;

loop {
 if n > 5 {
 break
}
 println!("{}", n);
 n+=1;
}

println!("我出来了！");
}
```
##### 3.5.6.1 while vs for
```rust
let a = [10, 20, 30, 40, 50];
let mut index = 0;

while index < 5 {
 println!("the value is: {}", a[index]);

 index = index + 1;
}
```
但这个过程很容易出错；如果索引长度不正确会导致程序 panic。这也使程序更慢，因为编译器增加了运行时代码来对每次循环的每个元素进行条件检查。
```rust
fn main() {
let a = [10, 20, 30, 40, 50];

for element in a.iter() {
 println!("the value is: {}", element);
}
}
```
for 并不会使用索引去访问数组，因此更安全也更简洁，同时避免 运行时的边界检查，性能更高
#### 3.5.7 loop 循环
loop 循环毋庸置疑，是适用面最高的，它可以适用于所有循环场景（虽然能用，但是在很多场景下， for 和 while 才是最优选择），因为 loop 就是一个简单的无限循环，你可以在内部实现逻辑通过 break 关键字来控制循环何时结束。
```rust
loop {
 println!("again!");
}
```
该循环会不停的在终端打印输出，直到你使用 Ctrl-C 结束程序
因此，当使用 loop 时，必不可少的伙伴是 break 关键字，它能让循环在满足某个条件时跳出：
```rust
fn main() {
let mut counter = 0;

let result = loop {
counter += 1;

 if counter == 10 {
 break counter * 2;
}
};

println!("The result is {}", result);
}
```
break 可以单独使用，也可以带一个返回值，有些类似 return
loop 是一个表达式，因此可以返回一个值
### 3.6 模式匹配
#### 3.6.1 match和if let
##### 3.6.1.1 match 匹配
###### 3.6.1.1.1 match通用形式
```rust
match target {
    模式1 => 表达式1,
    模式2 => {
        语句1;
        语句2;
        表达式2
    },
    _ => 表达式3
}
```
>注意
	1. match 的匹配必须要穷举出所有可能，因此这里用 _ 来代表未列出的所有可能性
	2. match 的每一个分支都必须是一个表达式，且所有分支的表达式最终返回值的类型必须相同
	3. X | Y，类似逻辑运算符 或，代表该分支可以匹配 X 也可以匹配 Y，只要满足一个即可

其实 match 跟其他语言中的 switch 非常像，_ 类似于 switch 中的 default。
match 允许我们将一个值与一系列的模式相比较，并根据相匹配的模式执行对应的代码
```rust
enum Direction {
East,
West,
North,
South,
}

fn main() {
let dire = Direction::South;
match dire {
	Direction::East => println!("East"),
	Direction::North | Direction::South => {
		println!("South or North");
		},
	_ => println!("West"),
};
}
```
```rust
enum Coin {
Penny,
Nickel,
Dime,
Quarter,
}

fn value_in_cents(coin: Coin) -> u8 {
match coin {
 Coin::Penny =>  {
 println!("Lucky penny!");
 1
},
 Coin::Nickel => 5,
 Coin::Dime => 10,
 Coin::Quarter => 25,
}
}
```
###### 3.6.1.1.2 match表达式
match 后的表达式返回值可以是任意类型，只要能跟后面的分支中的模式匹配起来即可
match 表达式执行时，它将目标值 coin 按顺序依次与每一个分支的模式相比较，如果模式匹配了这个值，那么模式之后的代码将被执行。如果模式并不匹配这个值，将继续执行下一个分支。

每个分支相关联的代码是一个表达式，而表达式的结果值将作为整个 match 表达式的返回值。如果分支有多行代码，那么需要用 {} 包裹，同时最后一行代码需要是一个表达式。
###### 3.6.1.1.3 match分支
一个分支有两个部分：一个模式和针对该模式的处理代码。第一个分支的模式是 Coin::Penny，其后的 => 运算符将模式和将要运行的代码分开。这里的代码就仅仅是表达式 1，不同分支之间使用逗号分隔。
###### 3.6.1.1.4 使用 match 表达式赋值
match 本身也是一个表达式，因此可以用它来赋值
```rust
enum IpAddr {
Ipv4,
Ipv6
}

fn main() {
let ip1 = IpAddr::Ipv6;
let ip_str = match ip1 {
### 3.7 IpAddr::Ipv4 => "127.0.0.1",
### 3.8 _ => "::1",
};

println!("{}", ip_str);
}
```
因为这里匹配到 _ 分支，所以将 "::1" 赋值给了 ip_str。
###### 3.6.1.1.5 模式绑定
模式匹配的另外一个重要功能是从模式中取出绑定的值，例如：
```rust
#[derive(Debug)]
enum UsState {
Alabama,
Alaska,
// --snip--
}

enum Coin {
Penny,
Nickel,
Dime,
Quarter(UsState), // 25美分硬币
}
```
其中 Coin::Quarter 成员还存放了一个值：美国的某个州（因为在 1999 年到 2008 年间，美国在 25 美分(Quarter)硬币的背后为 50 个州印刷了不同的标记，其它硬币都没有这样的设计）。

接下来，我们希望在模式匹配中，获取到 25 美分硬币上刻印的州的名称：
```rust
fn value_in_cents(coin: Coin) -> u8 {
match coin {
 Coin::Penny => 1,
Coin::Nickel => 5,
 Coin::Dime => 10,
 Coin::Quarter(state) => {
 println!("State quarter from {:?}!", state);
 25
},
}
}
```
在匹配 Coin::Quarter(state) 模式时，我们把它内部存储的值绑定到了 state 变量上，因此 state 变量就是对应的 UsState 枚举类型。

例如有一个印了阿拉斯加州标记的 25 分硬币：Coin::Quarter(UsState::Alaska)，它在匹配时，state 变量将被绑定 UsState::Alaska 的枚举值。
```rust
enum Action {
Say(String),
MoveTo(i32, i32),
ChangeColorRGB(u16, u16, u16),
}

fn main() {
let actions = [
 Action::Say("Hello Rust".to_string()),
 Action::MoveTo(1,2),
 Action::ChangeColorRGB(255,255,0),
];
for action in actions {
 match action {
 Action::Say(s) => {
println!("{}", s);
},
Action::MoveTo(x, y) => {
println!("point from (0, 0) move to ({}, {})", x, y);
},
 Action::ChangeColorRGB(r, g, _) => {
println!("change color into '(r:{}, g:{}, b:0)', 'b' has been ignored",
r, g,
);
}
}
}
}
```
###### 3.6.1.1.6 穷尽匹配
1. match 的匹配必须穷尽所有情况
2. 我们没有处理 Direction::West 的情况，因此会报错：
3. Rust 编译器清晰地知道 match 中有哪些分支没有被覆盖，这种行为能强制我们处理所有的可能性，有效避免传说中价值十亿美金的 null 陷阱。
###### 3.6.1.1.7 _ 通配符
当我们不想在匹配时列出所有值的时候，可以使用 Rust 提供的一个特殊模式，例如，u8 可以拥有 0 到 255 的有效的值，但是我们只关心 1、3、5 和 7 这几个值，不想列出其它的 0、2、4、6、8、9 一直到 255 的值。那么, 我们不必一个一个列出所有值, 因为可以使用特殊的模式 _ 替代：
```rust
let some_u8_value = 0u8;
match some_u8_value {
1 => println!("one"),
3 => println!("three"),
5 => println!("five"),
7 => println!("seven"),
_ => (),
}
```
通过将 _ 其放置于其他分支后，_ 将会匹配所有遗漏的值。() 表示返回单元类型与所有分支返回值的类型相同，所以当匹配到 _ 后，什么也不会发生。
通过将 _ 其放置于其他分支后，_ 将会匹配所有遗漏的值。() 表示返回单元类型与所有分支返回值的类型相同，所以当匹配到 _ 后，什么也不会发生。

<font color=#F36208>除了_通配符，用一个变量来承载其他情况也是可以的。</font>
```rust
#[derive(Debug)]
enum Direction {
East,
West,
North,
South,
}

fn main() {
let dire = Direction::South;
match dire {
	Direction::East => println!("East"),
	other => println!("other direction: {:?}", other),
};
}
```
##### 3.6.1.2 if let匹配
有时会遇到只有一个模式的值需要被处理，其它值直接忽略的场景
```rust
let v = Some(3u8);
match v {
 Some(3) => println!("three"),
 _ => (),
}
```
只想要对 Some(3) 模式进行匹配, 不想处理任何其他` Some<u8>` 值或 None 值。但是为了满足 match 表达式（穷尽性）的要求，写代码时必须在处理完这唯一的成员后加上 _ => ()，这样会增加不少无用的代码。
```rust
if let Some(3) = v {
println!("three");
}
```
当你只要匹配一个条件，且忽略其他条件时就用 if let ，否则都用 match
##### 3.6.1.3 matches!宏
它可以将一个表达式跟模式进行匹配，然后返回匹配的结果 true or false
```rust
enum MyEnum {
Foo,
Bar
}

fn main() {
let v = vec![MyEnum::Foo,MyEnum::Bar,MyEnum::Foo];
}
```
现在如果<span style="background:red">想对 v 进行过滤，只保留类型是 MyEnum::Foo 的元素</span>，你可能想这么写：
```rust
v.iter().filter(|x| x == MyEnum::Foo);
```
实际上这行代码会报错，因为你无法将 x 直接跟一个枚举成员进行比较。
可以使用 match 来完成，但是会导致代码更为啰嗦，是否有更简洁的方式
```rust
v.iter().filter(|x| matches!(x, MyEnum::Foo));
```
```rust
let foo = 'f';
assert!(matches!(foo, 'A'..='Z' | 'a'..='z'));

let bar = Some(4);
assert!(matches!(bar, Some(x) if x > 2));
```
##### 3.6.1.4 变量遮蔽
无论是 match 还是 if let，这里都是一个新的代码块，而且这里的绑定相当于新变量，如果你使用同名变量，会发生变量遮蔽：
```rust
let age = Some(30);
println!("在匹配前，age是{:?}",age);
if let Some(age) = age {
println!("匹配出来的age是{}",age);
}

println!("在匹配后，age是{:?}",age);
```
在匹配前，age是Some(30)
匹配出来的age是30
在匹配后，age是Some(30)
if let 中，= 右边 Some(i32) 类型的 age 被左边 i32 类型的新 age 遮蔽了，该遮蔽一直持续到 if let 语句块的结束。因此第三个 println! 输出的 age 依然是 Some(i32) 类型。
```rust
let age = Some(30);
println!("在匹配前，age是{:?}",age);
match age {
Some(age) =>  println!("匹配出来的age是{}",age),
_ => ()
}
println!("在匹配后，age是{:?}",age);
```
match 中的变量遮蔽其实不是那么的容易看出，因此要小心！其实这里最好不要使用同名，避免难以理解
#### 3.6.2 解构Option
Option 枚举，它用来解决 Rust 中变量是否有值的问题
一个变量要么有值：Some(T), 要么为空：None
如何去使用这个 Option 枚举类型
##### 3.6.2.1 匹配 `Option<T>`
使用 `Option<T>`，是为了从 Some 中取出其内部的 T 值以及处理没有值的情况，
```rust
fn plus_one(x: Option<i32>) -> Option<i32> {
match x {
 None => None,
 Some(i) => Some(i + 1),
}
}

let five = Some(5);
let six = plus_one(five);
let none = plus_one(None);
```
plus_one 接受一个 `Option<i32>` 类型的参数，同时返回一个 `Option<i32>` 类型的值（这种形式的函数在标准库内随处所见），在该函数的内部处理中，如果传入的是一个 None ，则返回一个 None 且不做任何处理；如果传入的是一个 Some(i32)，则通过模式绑定，把其中的值绑定到变量 i 上，然后返回 i+1 的值，同时用 Some 进行包裹。
#### 3.6.3 模式适用场景
##### 3.6.3.1 模式
模式是 Rust 中的特殊语法，它用来匹配类型中的结构和数据，它往往和 match 表达式联用，以实现强大的模式匹配能力。模式一般由以下内容组合而成：
1. 字面值
2. 解构的数组、枚举、结构体或者元组
3. 变量
4. 通配符
5. 占位符
##### 3.6.3.2 所有可能用到模式的地方
###### 3.6.3.2.1 match 分支
```rust
match VALUE {
PATTERN => EXPRESSION,
PATTERN => EXPRESSION,
_ => EXPRESSION,
}
```
match 的每个分支就是一个模式，因为 match 匹配是穷尽式的，因此我们往往需要一个特殊的模式 \_，来匹配剩余的所有情况
###### 3.6.3.2.2 if let 分支
if let 往往用于匹配一个模式，而忽略剩下的所有模式的场景：
```rust
if let PATTERN = SOME_VALUE {

}
```
###### 3.6.3.2.3 while let 条件循环
一个与 if let 类似的结构是 while let 条件循环，它允许只要模式匹配就一直进行 while 循环。
```rust
// Vec是动态数组
let mut stack = Vec::new();

// 向数组尾部插入元素
stack.push(1);
stack.push(2);
stack.push(3);

// stack.pop从数组尾部弹出元素
while let Some(top) = stack.pop() {
println!("{}", top);
}
```
这个例子会打印出 3、2 接着是 1。pop 方法取出动态数组的最后一个元素并返回 Some(value)，如果动态数组是空的，将返回 None，对于 while 来说，只要 pop 返回 Some 就会一直不停的循环。一旦其返回 None，while 循环停止。我们可以使用 while let 来弹出栈中的每一个元素。

你也可以用 loop + if let 或者 match 来实现这个功能，但是会更加啰嗦。
###### 3.6.3.2.4 for 循环
```rust
let v = vec!['a', 'b', 'c'];

for (index, value) in v.iter().enumerate() {
println!("{} is at index {}", value, index);
}
```
这里使用 enumerate 方法产生一个迭代器，该迭代器每次迭代会返回一个 (索引，值) 形式的元组，然后用 (index,value) 来匹配。
###### 3.6.3.2.5 let 语句
```rust
let PATTERN = EXPRESSION;
let x = 5;
```
这其中，x 也是一种模式绑定，代表将匹配的值绑定到变量 x 上。因此，在 Rust 中，变量名也是一种模式，只不过它比较朴素很不起眼罢了。
`let (x, y, z) = (1, 2, 3);`
上面将一个元组与模式进行匹配（模式和值的类型必需相同！），然后把 1, 2, 3 分别绑定到 x, y, z 上。
模式匹配要求两边的类型必须相同
`let (x, y) = (1, 2, 3);`
对于元组来说，元素个数也是类型的一部分！
###### 3.6.3.2.6 函数参数
```rust
fn foo(x: i32) {
// 代码
}
```
其中 x 就是一个模式，你还可以在参数中匹配元组：
```rust
fn print_coordinates(&(x, y): &(i32, i32)) {
println!("Current location: ({}, {})", x, y);
}

fn main() {
let point = (3, 5);
print_coordinates(&point);
}
```
&(3, 5) 会匹配模式 &(x, y)，因此 x 得到了 3，y 得到了 5。
###### 3.6.3.2.7 let 和 if let
```rust
let Some(x) = some_option_value;
```
因为右边的值可能不为 Some，而是 None，这种时候就不能进行匹配，也就是上面的代码遗漏了 None 的匹配。
类似 let , for和match 都必须要求完全覆盖匹配，才能通过编译( 不可驳模式匹配 )。
<span style="background:#f60909">if let，就可以这样使用</span>
因为 if let 允许匹配一种模式，而忽略其余的模式( 可驳模式匹配 )。
```rust
if let Some(x) = some_option_value {
println!("{}", x);
}
```
###### 3.6.3.2.8 let-else(Rust 1.65 新增)
使用 let-else 匹配，即可使 let 变为可驳模式。它可以使用 else 分支来处理模式不匹配的情况，但是 else 分支中必须用发散的代码块处理（例如：break、return、panic）。请看下面的代码：
```rust
use std::str::FromStr;

fn get_count_item(s: &str) -> (u64, &str) {
let mut it = s.split(' ');
let (Some(count_str), Some(item)) = (it.next(), it.next()) else {
 panic!("Can't segment count item pair: '{s}'");
};
let Ok(count) = u64::from_str(count_str) else {
 panic!("Can't parse integer: '{count_str}'");
};
// error: `else` clause of `let...else` does not diverge
// let Ok(count) = u64::from_str(count_str) else { 0 };
(count, item)
}

fn main() {
assert_eq!(get_count_item("3 chairs"), (3, "chairs"));
}
```
与 match 和 if let 相比，let-else 的一个显著特点在于其解包成功时所创建的变量具有更广的作用域。在 let-else 语句中，<font color=#F36208>成功匹配后的变量不再仅限于特定分支内使用</font>：
```rust
// if let
if let Some(x) = some_option_value {
println!("{}", x);
}

// let-else
let Some(x) = some_option_value else { return; }
println!("{}", x);
```
在上面的例子中，if let 写法里的 x 只能在 if 分支内使用，而 let-else 写法里的 x 则可以在 let 之外使用。
#### 3.6.4 全模式列表
##### 3.6.4.1 匹配字面值
如果希望代码获得特定的具体值，那么这种语法很有用
```rust
let x = 1;

match x {
    1 => println!("one"),
    2 => println!("two"),
    3 => println!("three"),
    _ => println!("anything"),
}
```
##### 3.6.4.2 匹配命名变量
变量遮蔽的问题，这个在**匹配命名变量**时会遇到
```rust
fn main() {
    let x = Some(5);
    let y = 10;

    match x {
        Some(50) => println!("Got 50"),
        Some(y) => println!("Matched, y = {:?}", y),
        _ => println!("Default case, x = {:?}", x),
    }

    println!("at the end: x = {:?}, y = {:?}", x, y);
}
```
第一个匹配分支的模式并不匹配 `x` 中定义的值，所以代码继续执行。
第二个匹配分支中的模式引入了一个新变量 `y`，它会匹配任何 `Some` 中的值。因为这里的 `y` 在 `match` 表达式的作用域中，而不是之前 `main` 作用域中，所以这是一个新变量，不是开头声明为值 10 的那个 `y`。这个新的 `y` 绑定会匹配任何 `Some` 中的值，在这里是 `x` 中的值。因此这个 `y` 绑定了 `x` 中 `Some` 内部的值。这个值是 5，所以这个分支的表达式将会执行并打印出 `Matched，y = 5`。

如果 `x` 的值是 `None` 而不是 `Some(5)`，头两个分支的模式不会匹配，所以会匹配模式 `_`。这个分支的模式中没有引入变量 `x`，所以此时表达式中的 `x` 会是外部没有被遮蔽的 `x`，也就是 `None`。

一旦 `match` 表达式执行完毕，其作用域也就结束了，同理内部 `y` 的作用域也结束了。最后的 `println!` 会打印 `at the end: x = Some(5), y = 10`。

如果你不想引入变量遮蔽，可以使用另一个变量名而非 `y`，或者使用匹配守卫(match guard)的方式，稍后在[匹配守卫提供的额外条件](https://course.rs/basic/match-pattern/all-patterns.html#%E5%8C%B9%E9%85%8D%E5%AE%88%E5%8D%AB%E6%8F%90%E4%BE%9B%E7%9A%84%E9%A2%9D%E5%A4%96%E6%9D%A1%E4%BB%B6)中会讲解。
##### 3.6.4.3 单分支多模式
在 `match` 表达式中，可以使用 `|` 语法匹配多个模式，它代表 **或**的意思。例如，如下代码将 `x` 的值与匹配分支相比较，第一个分支有 **或** 选项，意味着如果 `x` 的值匹配此分支的任何一个模式，它就会运行：

```rust
let x = 1;

match x {
    1 | 2 => println!("one or two"),
    3 => println!("three"),
    _ => println!("anything"),
}
```
上面的代码会打印 `one or two`。
##### 3.6.4.4 通过序列 ..= 匹配值的范围
在[数值类型](https://course.rs/basic/base-type/numbers.html#%E5%BA%8F%E5%88%97range)中我们有讲到一个序列语法，该语法不仅可以用于循环中，还能用于匹配模式。
`..=` 语法允许你匹配一个闭区间序列内的值。在如下代码中，当模式匹配任何在此序列内的值时，该分支会执行：
```rust
let x = 5;

match x {
    1..=5 => println!("one through five"),
    _ => println!("something else"),
}
```
如果 `x` 是 1、2、3、4 或 5，第一个分支就会匹配。这相比使用 `|` 运算符表达相同的意思更为方便；相比 `1..=5`，使用 `|` 则不得不指定 `1 | 2 | 3 | 4 | 5` 这五个值，而使用 `..=` 指定序列就简短的多，比如希望匹配比如从 1 到 1000 的数字的时候！
序列只允许用于数字或字符类型，原因是：它们可以连续，同时编译器在编译期可以检查该序列是否为空，字符和数字值是 Rust 中仅有的可以用于判断是否为空的类型。
如下是一个使用字符类型序列的例子：
```rust
let x = 'c';
match x {
    'a'..='j' => println!("early ASCII letter"),
    'k'..='z' => println!("late ASCII letter"),
    _ => println!("something else"),
}
```
Rust 知道 `'c'` 位于第一个模式的序列内，所以会打印出 `early ASCII letter`。
##### 3.6.4.5 解构并分解值
使用模式来解构结构体、枚举、元组、数组和引用
1. 解构结构体
```rust
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    let p = Point { x: 0, y: 7 };

    let Point { x: a, y: b } = p;
    assert_eq!(0, a);
    assert_eq!(7, b);
}
```
这段代码创建了变量 `a` 和 `b` 来匹配结构体 `p` 中的 `x` 和 `y` 字段，这个例子展示了**模式中的变量名不必与结构体中的字段名一致**。不过通常希望变量名与字段名一致以便于理解变量来自于哪些字段。
因为变量名匹配字段名是常见的，同时因为 `let Point { x: x, y: y } = p;` 中 `x` 和 `y` 重复了，所以对于匹配结构体字段的模式存在简写：只需列出结构体字段的名称，则模式创建的变量会有相同的名称。下例与上例有着相同行为的代码，不过 `let` 模式创建的变量为 `x` 和 `y` 而不是 `a` 和 `b`：
```rust
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    let p = Point { x: 0, y: 7 };

    let Point { x, y } = p;
    assert_eq!(0, x);
    assert_eq!(7, y);
}
```
这段代码创建了变量 `x` 和 `y`，与结构体 `p` 中的 `x` 和 `y` 字段相匹配。其结果是变量 `x` 和 `y` 包含结构体 `p` 中的值。
也可以使用字面值作为结构体模式的一部分进行解构，而不是为所有的字段创建变量。这允许我们测试一些字段为特定值的同时创建其他字段的变量。
下文展示了<span style="background:#f60909">固定某个字段的匹配方式</span>：
```rust
fn main() {
    let p = Point { x: 0, y: 7 };

    match p {
        Point { x, y: 0 } => println!("On the x axis at {}", x),
        Point { x: 0, y } => println!("On the y axis at {}", y),
        Point { x, y } => println!("On neither axis: ({}, {})", x, y),
    }
}
```
首先是 `match` 第一个分支，指定匹配 `y` 为 `0` 的 `Point`； 然后第二个分支在第一个分支之后，匹配 `y` 不为 `0`，`x` 为 `0` 的 `Point`; 最后一个分支匹配 `x` 不为 `0`，`y` 也不为 `0` 的 `Point`。
在这个例子中，值 `p` 因为其 `x` 包含 0 而匹配第二个分支，因此会打印出 `On the y axis at 7`。
2. 解构枚举： `match` 使用模式解构每一个内部值
```rust
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

fn main() {
    let msg = Message::ChangeColor(0, 160, 255);

    match msg {
        Message::Quit => {
            println!("The Quit variant has no data to destructure.")
        }
        Message::Move { x, y } => {
            println!(
                "Move in the x direction {} and in the y direction {}",
                x,
                y
            );
        }
        Message::Write(text) => println!("Text message: {}", text),
        Message::ChangeColor(r, g, b) => {
            println!(
                "Change the color to red {}, green {}, and blue {}",
                r,
                g,
                b
            )
        }
    }
}
```
这里老生常谈一句话，模式匹配一样要类型相同，因此匹配 `Message::Move{1,2}` 这样的枚举值，就必须要用 `Message::Move{x,y}` 这样的同类型模式才行。
这段代码会打印出 `Change the color to red 0, green 160, and blue 255`。尝试改变 `msg` 的值来观察其他分支代码的运行。
对于像 `Message::Quit` 这样没有任何数据的枚举成员，不能进一步解构其值。只能匹配其字面值 `Message::Quit`，因此模式中没有任何变量。
对于另外两个枚举成员，就用相同类型的模式去匹配出对应的值即可。
3. 解构嵌套的结构体和枚举
 `match` 也可以匹配嵌套的项！
例如使用下面的代码来同时支持 RGB 和 HSV 色彩模式：
```rust
enum Color {
   Rgb(i32, i32, i32),
   Hsv(i32, i32, i32),
}

enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(Color),
}

fn main() {
    let msg = Message::ChangeColor(Color::Hsv(0, 160, 255));

    match msg {
        Message::ChangeColor(Color::Rgb(r, g, b)) => {
            println!(
                "Change the color to red {}, green {}, and blue {}",
                r,
                g,
                b
            )
        }
        Message::ChangeColor(Color::Hsv(h, s, v)) => {
            println!(
                "Change the color to hue {}, saturation {}, and value {}",
                h,
                s,
                v
            )
        }
        _ => ()
    }
}
```
`match` 第一个分支的模式匹配一个 `Message::ChangeColor` 枚举成员，该枚举成员又包含了一个 `Color::Rgb` 的枚举成员，最终绑定了 3 个内部的 `i32` 值。第二个，就交给亲爱的读者来思考完成
3. 解构结构体和元组
可以用复杂的方式来混合、匹配和嵌套解构模式。如下是一个复杂结构体的例子，其中结构体和元组嵌套在元组中，并将所有的原始类型解构出来：
```rust
struct Point {
     x: i32,
     y: i32,
 }

let ((feet, inches), Point {x, y}) = ((3, 10), Point { x: 3, y: -10 });
```
这种将复杂类型分解匹配的方式，可以让我们单独得到感兴趣的某个值。
4. 解构数组
<span style="background:#0779e4">定长数组</span>
```rust
let arr: [u16; 2] = [114, 514];
let [x, y] = arr;

assert_eq!(x, 114);
assert_eq!(y, 514);
```
<span style="background:#0779e4">不定长数组</span>
```rust
let arr: &[u16] = &[114, 514];
if let [x, ..] = arr {
    assert_eq!(x, &114);
}
if let &[.., y] = arr {
    assert_eq!(y, 514);
}
let arr: &[u16] = &[];
assert!(matches!(arr, [..]));
assert!(!matches!(arr, [x, ..]));
```
##### 3.6.4.6 忽略模式中的值
有时忽略模式中的一些值是很有用的，比如在 `match` 中的最后一个分支使用 `_` 模式匹配所有剩余的值。 你也可以在另一个模式中使用 `_` 模式，使用一个以下划线开始的名称，或者使用 `..` 忽略所剩部分的值。
###### 3.6.4.6.1 使用 _ 忽略整个值
虽然 `_` 模式作为 `match` 表达式最后的分支特别有用，但是它的作用还不限于此。例如可以将其用于函数参数中：
```rust
fn foo(_: i32, y: i32) {
    println!("This code only uses the y parameter: {}", y);
}

fn main() {
    foo(3, 4);
}
```
会完全忽略作为第一个参数传递的值 `3`，并会打印出 `This code only uses the y parameter: 4`。
大部分情况当你不再需要特定函数参数时，最好修改签名不再包含无用的参数。在一些情况下忽略函数参数会变得特别有用，比如实现特征时，当你需要特定类型签名但是函数实现并不需要某个参数时。此时编译器就**不会警告说存在未使用的函数参数**，就跟使用命名参数一样。
###### 3.6.4.6.2 使用嵌套的 _ 忽略部分值
在一个模式内部使用 `_` 忽略部分值
```rust
let mut setting_value = Some(5);
let new_setting_value = Some(10);
match (setting_value, new_setting_value) {
    (Some(_), Some(_)) => {
        println!("Can't overwrite an existing customized value");
    }
    _ => {
        setting_value = new_setting_value;
    }
}
println!("setting is {:?}", setting_value);
```
这段代码会打印出 `Can't overwrite an existing customized value` 接着是 `setting is Some(5)`。
第一个匹配分支，我们不关心里面的值，只关心元组中两个元素的类型，因此对于 `Some` 中的值，直接进行忽略。 剩下的形如 `(Some(_),None)`，`(None, Some(_))`, `(None,None)` 形式，都由第二个分支 `_` 进行分配。
还可以在一个模式中的多处使用下划线来忽略特定值，如下所示，这里忽略了一个五元元组中的第二和第四个值：
```rust
let numbers = (2, 4, 8, 16, 32);

match numbers {
    (first, _, third, _, fifth) => {
        println!("Some numbers: {}, {}, {}", first, third, fifth)
    },
}
```
老生常谈：模式匹配一定要类型相同，因此匹配 `numbers` 元组的模式，也必须有五个值（元组中元素的数量也属于元组类型的一部分）。
这会打印出 `Some numbers: 2, 8, 32`, 值 4 和 16 会被忽略。
###### 3.6.4.6.3 使用下划线开头忽略未使用的变量
创建了一个变量却不在任何地方使用它，Rust 通常会给你一个警告，因为这可能会是个 BUG。但是有时创建一个不会被使用的变量是有用的，比如你正在设计原型或刚刚开始一个项目。这时你希望告诉 Rust <span style="background:#0779e4">不要警告未使用的变量</span>，为此可以用下划线作为变量名的开头：
```rust
fn main() {
    let _x = 5;
    let y = 10;
}
```
这里得到了警告说未使用变量 `y`，至于 `x` 则没有警告。
注意, 只使用 `_` 和使用<span style="background:#f500a3">以下划线开头的名称</span>有些微妙的不同：比如 **`_x` 仍会将值绑定到变量，而 `_` 则完全不会绑定**。
```rust
let s = Some(String::from("Hello!"));
if let Some(_s) = s {
    println!("found a string");}
println!("{:?}", s);
```
`s` 是一个拥有所有权的动态字符串，在上面代码中，我们会得到一个错误，因为 `s` 的值会被转移给 `_s`，在 `println!` 中再次使用 `s` 会报错：
```console
error[E0382]: borrow of partially moved value: `s`
 --> src/main.rs:8:22
4 |     if let Some(_s) = s {
  |                 -- value partially moved here
8 |     println!("{:?}", s);
  |                      ^ value borrowed here after partial move
```
<span style="background:#f500a3">只使用下划线本身，则并不会绑定值，因为 `s` 没有被移动进 `_`</span>：
```rust
let s = Some(String::from("Hello!"));
if let Some(_) = s {
    println!("found a string");
}
println!("{:?}", s);
```
###### 3.6.4.6.4 用 .. 忽略剩余值
对于有多个部分的值，可以使用 `..` 语法来只使用部分值而忽略其它值，这样也不用再为每一个被忽略的值都单独列出下划线。`..` 模式会<span style="background:#0779e4">忽略模式中剩余的任何没有显式匹配的值部分</span>。
```rust
struct Point {
    x: i32,
    y: i32,
    z: i32,
}
let origin = Point { x: 0, y: 0, z: 0 };
match origin {
    Point { x, .. } => println!("x is {}", x),
}
```
这里列出了 `x` 值，接着使用了 `..` 模式来忽略其它字段，这样的写法要比一一列出其它字段，然后用 `_` 忽略简洁的多。
<span style="background:#0779e4">还可以用 `..` 来忽略元组中间的某些值</span>：
```rust
fn main() {
    let numbers = (2, 4, 8, 16, 32);

    match numbers {
        (first, .., last) => {
            println!("Some numbers: {}, {}", first, last);
        },
    }
}
```
这里用 `first` 和 `last` 来匹配第一个和最后一个值。`..` 将匹配并忽略中间的所有值。
然而<span style="background:#0779e4">使用 `..` 必须是无歧义的</span>。如果期望匹配和忽略的值是不明确的，Rust 会报错。下面代码展示了一个带有歧义的 `..` 例子，因此不能编译：❌
```rust
fn main() {
    let numbers = (2, 4, 8, 16, 32);
    match numbers {
        (.., second, ..) => {
            println!("Some numbers: {}", second)
        },    }}
```
Rust 无法判断，`second` 应该匹配 `numbers` 中的第几个元素，因此这里使用两个 `..` 模式，是有很大歧义的！
##### 3.6.4.7 匹配守卫提供的额外条件
**匹配守卫**（_match guard_）是一个位于 `match` 分支模式之后的额外 `if` 条件，它能为分支模式<font color=#2485E3>提供更进一步的匹配条件。</font>
这个条件<span style="background:#f500a3">可以使用模式中创建的变量</span>：
```rust
let num = Some(4);

match num {
    Some(x) if x < 5 => println!("less than five: {}", x),
    Some(x) => println!("{}", x),
    None => (),
}
```
这个例子会打印出 `less than five: 4`。当 `num` 与模式中第一个分支匹配时，`Some(4)` 可以与 `Some(x)` 匹配，接着匹配守卫检查 `x` 值是否小于 5，因为 4 小于 5，所以第一个分支被选择。
相反如果 `num` 为 `Some(10)`，因为 10 不小于 5 ，所以第一个分支的匹配守卫为假。接着 Rust 会前往第二个分支，因为这里没有匹配守卫所以会匹配任何 `Some` 成员。
模式中无法提供类如 `if x < 5` 的表达能力，我们可以通过匹配守卫的方式来实现。
在之前，我们提到可以使用匹配守卫来解决模式中变量覆盖的问题，那里 `match` 表达式的模式中新建了一个变量而不是使用 `match` 之外的同名变量。内部变量覆盖了外部变量，意味着此时不能够使用外部变量的值，下面代码展示了如何使用匹配守卫修复这个问题。
```rust
fn main() {
    let x = Some(5);
    let y = 10;

    match x {
        Some(50) => println!("Got 50"),
        Some(n) if n == y => println!("Matched, n = {}", n),
        _ => println!("Default case, x = {:?}", x),
    }

    println!("at the end: x = {:?}, y = {}", x, y);
}
```

现在这会打印出 `Default case, x = Some(5)`。现在第二个匹配分支中的模式不会引入一个覆盖外部 `y` 的新变量 `y`，这意味着可以在匹配守卫中使用外部的 `y`。相比指定会覆盖外部 `y` 的模式 `Some(y)`，这里指定为 `Some(n)`。此新建的变量 `n` 并没有覆盖任何值，因为 `match` 外部没有变量 `n`。
匹配守卫 `if n == y` 并不是一个模式所以没有引入新变量。这个 `y` **正是** 外部的 `y` 而不是新的覆盖变量 `y`，这样就可以通过比较 `n` 和 `y` 来表达寻找一个与外部 `y` 相同的值的概念了。
也可以在匹配守卫中使用 **或** 运算符 `|` 来指定多个模式，**同时匹配守卫的条件会作用于所有的模式**。下面代码展示了匹配守卫与 `|` 的优先级。这个例子中看起来好像 `if y` 只作用于 `6`，但实际上匹配守卫 `if y` 作用于 `4`、`5` **和** `6` ，在满足 `x` 属于 `4 | 5 | 6` 后才会判断 `y` 是否为 `true`：
```rust
let x = 4;
let y = false;
match x {
    4 | 5 | 6 if y => println!("yes"),   //只匹配 `x` 值为 `4`、`5` 或 `6` **同时** `y` 为 `true` 的情况
    _ => println!("no"),
}
```
虽然在第一个分支中，`x` 匹配了模式 `4` ，但是对于匹配守卫 `if y` 来说，因为 `y` 是 `false`，因此该守卫条件的值永远是 `false`，也意味着第一个分支永远无法被匹配。
**匹配守卫作用于多个模式时的优先级规则**，
1. 第一张是正确的：✔  (4 | 5 | 6) if y => ...
2. 第二张图是错误的❌  4 | 5 | (6 if y) => ...
可以通过运行代码时的情况看出这一点：如果匹配守卫只作用于由 `|` 运算符指定的值列表的最后一个值，这个分支就会匹配且程序会打印出 `yes`。
##### 3.6.4.8 @绑定
`@`（读作 at）运算符<span style="background:#f500a3">允许为一个字段绑定另外一个变量</span>。
下面例子中，我们希望测试 `Message::Hello` 的 `id` 字段是否位于 `3..=7` 范围内，同时也希望能将其值绑定到 `id_variable` 变量中以便此分支中相关的代码可以使用它。我们可以将 `id_variable` 命名为 `id`，与字段同名，不过出于示例的目的这里选择了不同的名称。
```rust
enum Message { Hello { id: i32 },}
let msg = Message::Hello { id: 5 };
match msg {
    Message::Hello { id: id_variable @ 3..=7 } => {  // 通过在 `3..=7` 之前指定 `id_variable @` 捕获了任何匹配此范围 3..=7 的值并同时将该值绑定到变量 `id_variable` 上。
        println!("Found an id in range: {}", id_variable)  //  ✔  
    },
    Message::Hello { id: 10..=12 } => { // 只在模式中指定了一个范围，`id` 字段的值可以是 `10、11 或 12`，不过这个模式的代码并不知情也不能使用 `id` 字段中的值，因为没有将 `id` 值保存进一个变量。
        println!("Found an id in another range")
    },
    Message::Hello { id } => { //指定了一个没有范围的变量，此时确实拥有可以用于分支代码的变量 `id`，因为这里使用了结构体字段简写语法。不过此分支中没有像头两个分支那样对 `id` 字段的值进行测试：任何值都会匹配此分支。
        println!("Found some other id: {}", id)
    },}
```
当你既想要限定分支范围，又想要使用分支的变量时，就可以用 `@` 来绑定到一个新的变量上，实现想要的功能。
###### 3.6.4.8.1 @前绑定后解构(Rust 1.56 新增)
使用 `@` 还可以在绑定新变量的同时，对目标进行解构：
```rust
#[derive(Debug)]
struct Point {
    x: i32,
    y: i32,
}

fn main() {
    // 绑定新变量 `p`，同时对 `Point` 进行解构
    let p @ Point {x: px, y: py } = Point {x: 10, y: 23};
    println!("x: {}, y: {}", px, py);
    println!("{:?}", p);

    let point = Point {x: 10, y: 5};
    if let p @ Point {x: 10, y} = point {
        println!("x is 10 and y is {} in {:?}", y, p);
    } else {
        println!("x was not 10 :(");
    }}
```
###### 3.6.4.8.2 @新特性(Rust 1.53 新增)
```rust
fn main() {
    match 1 {
        num @ 1 | 2 => { //编译不通过，是因为 `num` 没有绑定到所有的模式上，只绑定了模式 `1`； 可以修改为下面的
	        // num @ (1 | 2)     // Rust 1.53 之前会报错，因为编译器不支持，Rust1.53之后会成功
            println!("{}", num);
        }
        _ => {}
    }}
```
### 3.7 方法 Method
Rust 中，方法的概念也大差不差，往往和对象成对出现 object.method()
#### 3.7.1 定义方法： Rust 使用 `impl` 来定义方法
其它语言中所有定义都在 `class` 中，但是 Rust 的对象定义和方法定义是分离的，这种数据和使用分离的方式，会给予使用者极高的灵活度
```rust
struct Circle {
    x: f64,
    y: f64,
    radius: f64,
}
impl Circle {
    // new是Circle的关联函数，因为它的第一个参数不是self，且new并不是关键字
    // 这种方法往往用于初始化当前结构体的实例
    fn new(x: f64, y: f64, radius: f64) -> Circle {
        Circle {
            x: x,
            y: y,
            radius: radius,
        }
    }
    // Circle的方法，&self表示借用当前的Circle结构体
    fn area(&self) -> f64 {
        std::f64::consts::PI * (self.radius * self.radius)
    }}
```
将 Rust 方法定义与其它语言的方法定义做了对比：
![](imgs/Rust语言圣经(Rust%20Course)-8.png)
```rust
#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,}
impl Rectangle {
    fn area(&self) -> u32 {        self.width * self.height    }}
fn main() {
    let rect1 = Rectangle { width: 30, height: 50 };
    println!(
        "The area of the rectangle is {} square pixels.",
        rect1.area()    );}
```
`impl Rectangle {}` 表示为 `Rectangle` 实现方法（`impl` 是实现 _implementation_ 的缩写），这样的写法表明 `impl` 语句块中的一切都是跟 `Rectangle` 相关联的。
##### 3.7.1.1 self、&self 和 &mut self
在一个 `impl` 块内:
1. `Self` 指代被实现方法的结构体类型，
2. `self` 指代此类型的实例，`self` 指代的是 `Rectangle` 结构体实例，
<span style="background:#f500a3">`self` 依然有所有权的概念</span>：
- `self` 表示 `Rectangle` 的所有权转移到该方法中，这种形式用的较少,往往用于把当前的对象转成另外一个对象时使用，转换完后，就不再关注之前的对象，且可以防止对之前对象的误调用。
- `&self` 表示不可变借用,替代 `rectangle: &Rectangle`，`&self` 其实是 `self: &Self` 的简写（注意大小写）。只是希望能够读取结构体中的数据
- `&mut self` 表示可变借用,想要在方法中去改变当前的结构体
<span style="background:#f500a3">使用方法代替函数有以下好处</span>：
- 不用在函数签名中重复书写 `self` 对应的类型
- 代码的组织性和内聚性更强，对于代码维护和阅读来说，好处巨大
##### 3.7.1.2 方法名跟结构体字段名相同
允许方法名跟结构体的字段名相同：
```rust
impl Rectangle {
    fn width(&self) -> bool {
        self.width > 0    }}
fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,    };
    // 使用 `rect1.width()` 时，Rust 知道我们调用的是它的方法，如果使用 `rect1.width`，则是访问它的字段
    if rect1.width() {
        println!("The rectangle has a nonzero width; it is {}", rect1.width);    }}
```
一般来说，方法跟字段同名，往往适用于实现 `getter` 访问器
```rust
mod my {
    pub struct Rectangle {  width: u32,  pub height: u32, }
    impl Rectangle {
        pub fn new(width: u32, height: u32) -> Self {  Rectangle { width, height }}
        pub fn width(&self) -> u32 {            return self.width;        }
        pub fn height(&self) -> u32 {            return self.height;        }    }}
fn main() {
    let rect1 = my::Rectangle::new(30, 50);
    println!("{}", rect1.width()); // OK
    println!("{}", rect1.height()); // OK
    // println!("{}", rect1.width); // 因为 `width` 字段是私有的
    println!("{}", rect1.height); // OK}
```
当<font color=red>从模块外部访问结构体时，结构体的字段默认是私有的</font>，其目的是隐藏信息（封装）。
想从模块外部获取 `Rectangle` 的字段，只需把它的 `new`， `width` 和 `height` 方法<font color=#F36208>设置为公开可见</font>，那么用户就可以创建一个矩形，同时通过访问器 `rect1.width()` 和 `rect1.height()` 方法来<span style="background:#f500a3">获取矩形的宽度和高度</span>。
特别的是，这种默认的可见性（私有的）<span style="background:#0779e4">可以通过 `pub` 进行覆盖</span>，这样对于模块外部来说，就可以直接访问使用 `pub` 修饰的字段而无需通过访问器。这种可见性仅当从定义结构的模块外部访问时才重要，并且具有隐藏信息（封装）的目的。
#### 3.7.2 -> 运算符到哪去了？
在 C/C++ 语言中，有两个不同的运算符来调用方法：. 直接在对象上调用方法，而 -> 在一个对象的指针上调用方法，这时需要先解引用指针。换句话说，如果 object 是一个指针，那么 object->something() 和 (\*object).something() 是一样的。
Rust 并没有一个与 -> 等效的运算符；相反，Rust 有一个叫 自动引用和解引用的功能。方法调用是 Rust 中少数几个拥有这种行为的地方。
他是这样工作的：当使用 object.something() 调用方法时，Rust 会自动为 object 添加 &、&mut 或 * 以便使 object 与方法签名匹配。也就是说，这些代码是等价的：
p1.distance(&p2);
(&p1).distance(&p2);
第一行看起来简洁的多。这种自动引用的行为之所以有效，是因为方法有一个明确的接收者———— self 的类型。在给出接收者和方法名的前提下，Rust 可以明确地计算出方法是仅仅读取（&self），做出修改（&mut self）或者是获取所有权（self）。事实上，Rust 对方法接收者的隐式借用让所有权在实践中更友好。
#### 3.7.3 带有多个参数的方法
方法和函数一样，可以使用多个参数：
```rust
impl Rectangle {
    fn area(&self) -> u32 {        self.width * self.height    }
    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }}
fn main() {
    let rect1 = Rectangle { width: 30, height: 50 };
    let rect2 = Rectangle { width: 10, height: 40 };
    let rect3 = Rectangle { width: 60, height: 45 };
    println!("Can rect1 hold rect2? {}", rect1.can_hold(&rect2));
    println!("Can rect1 hold rect3? {}", rect1.can_hold(&rect3));}
```
#### 3.7.4 关联函数
如何为一个结构体定义一个构造器方法:接受几个参数，然后构造并返回该结构体的实例。
参数中不包含 `self` 即可
**关联函数**: 这种定义在 `impl` 中且没有 `self` 的函数被称之为**关联函数**： 因为它没有 `self`，不能用 `f.read()` 的形式调用，因此它是<span style="background:#f60909">一个函数</span>而不是方法，它又在 `impl` 中，与结构体紧密关联，因此称为关联函数。
 `String::from`，用于创建一个动态字符串。
```rust
impl Rectangle {
    fn new(w: u32, h: u32) -> Rectangle {
        Rectangle { width: w, height: h }
    }}
```
> Rust 中有一个约定俗成的规则，使用 `new` 来作为构造器的名称，出于设计上的考虑，Rust 特地没有用 `new` 作为关键字。

因为是函数，所以不能用 `.` 的方式来调用，我们需要用 `::` 来调用，例如 `let sq = Rectangle::new(3, 3);`。这个方法位于结构体的命名空间中：`::` 语法用于关联函数和模块创建的命名空间。
#### 3.7.5 多个 impl 定义
Rust 允许我们为一个结构体定义多个 `impl` 块，目的是提供更多的灵活性和代码组织性，例如当方法多了后，可以把相关的方法组织在同一个 `impl` 块中，那么就可以形成多个 `impl` 块，各自完成一块儿目标：
```rust
impl Rectangle {
    fn area(&self) -> u32 {        self.width * self.height    }}
impl Rectangle {
    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height   }}
```
当然，就这个例子而言，我们没必要使用两个 `impl` 块，这里只是为了演示方便。
#### 3.7.6 为枚举实现方法
枚举类型之所以强大，不仅仅在于它好用、可以[同一化类型](https://course.rs/basic/compound-type/enum.html#%E5%90%8C%E4%B8%80%E5%8C%96%E7%B1%BB%E5%9E%8B)，还在于，我们可以像结构体一样，为枚举实现方法：
```rust
#![allow(unused)]
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),}
impl Message {
    fn call(&self) {
        // 在这里定义方法体
    }}
fn main() {
    let m = Message::Write(String::from("hello"));
    m.call();
}
```
除了结构体和枚举，我们还能为特征(trait)实现方法，这将在下一章进行讲解，在此之前，先来看看泛型。
### 3.8 泛型和特征
#### 3.8.1 泛型 Generics
用同一功能的函数处理不同类型的数据，例如两个数的加法，无论是整数还是浮点数，甚至是自定义类型，都能进行支持。在不支持泛型的编程语言中，通常需要为每一种类型编写一个函数：
```rust
fn add_i8(a:i8, b:i8) -> i8 {    a + b}
fn add_i32(a:i32, b:i32) -> i32 {    a + b}
fn add_f64(a:f64, b:f64) -> f64 {    a + b}
fn main() {
    println!("add i8: {}", add_i8(2i8, 3i8));
    println!("add i32: {}", add_i32(20, 30));
    println!("add f64: {}", add_f64(1.23, 1.23));}
```
上述代码可以<font color=yellow>正常运行，但是很啰嗦，如果你要支持更多的类型，那么会更繁琐</font>
泛型就是一种多态。泛型主要目的是为程序员提供编程的便利，减少代码的臃肿，同时可以极大地丰富语言本身的表达能力，为程序员提供了一个合适的炮管。想想，一个函数，可以代替几十个，甚至数百个函数，是一件多么让人兴奋的事情：
```rust
fn add<T>(a:T, b:T) -> T {    a + b} //❌不是所有 `T` 类型都能进行相加操作，因此我们需要用 `std::ops::Add<Output = T>` 对 `T` 进行限制
fn add<T: std::ops::Add<Output = T>>(a:T, b:T) -> T {    a + b } // ✔ 修改后，就可以正常运行
fn main() {
    println!("add i8: {}", add(2i8, 3i8));
    println!("add i32: {}", add(20, 30));
    println!("add f64: {}", add(1.23, 1.23));}
```
将之前的代码改成上面这样，就是 Rust 泛型的初印象，这段代码虽然很简洁，但是并不能编译通过，我们会在后面进行详细讲解，现在只要对泛型有个大概的印象即可。
##### 3.8.1.1 泛型详解
在 Rust 中，泛型参数的名称你可以任意起，但是出于惯例，我们都用 `T` （`T` 是 `type` 的首字母）来作为首选，这个名称越短越好，除非需要表达含义，否则一个字母是最完美的。
使用泛型参数，有一个先决条件，<span style="background:#f60909">必需在使用前对其进行声明</span>：
```rust
fn largest<T>(list: &[T]) -> T {
```
该泛型函数的作用是从列表中找出最大的值，其中列表中的元素类型为 T。首先 `largest<T>` 对泛型参数 `T` 进行了声明，然后才在函数参数中进行使用该泛型参数 `list: &[T]` （还记得 `&[T]` 类型吧？这是[数组切片](https://course.rs/basic/compound-type/array.html#%E6%95%B0%E7%BB%84%E5%88%87%E7%89%87)）。
总之，我们可以这样理解这个函数定义：函数 `largest` 有泛型类型 `T`，它有个参数 `list`，其类型是元素为 `T` 的数组切片，最后，该函数返回值的类型也是 `T`。
下面是一个错误的泛型函数的实现：
```rust
fn largest<T: std::cmp::PartialOrd>(list: &[T]) -> T { //✅ 
fn largest<T>(list: &[T]) -> T {  //❌
    let mut largest = list[0];
    for &item in list.iter() {
        if item > largest { //  `>`操作符不能用于类型`T` ,`T` 可以是任何类型，但不是所有的类型都能进行比较,可以使用 `std::cmp::PartialOrd` 特征（Trait）对 `T` 进行限制，
            largest = item;
        }    }
    largest
}
fn main() {
    let number_list = vec![34, 50, 25, 100, 65];
    let result = largest(&number_list);
    println!("The largest number is {}", result);
    let char_list = vec!['y', 'm', 'a', 'q'];
    let result = largest(&char_list);
    println!("The largest char is {}", result);}
```
###### 3.8.1.1.1 显式地指定泛型的类型参数
有时候，编译器无法推断你想要的泛型参数
```rust
use std::fmt::Display;
fn create_and_print<T>() where T: From<i32> + Display {
    let a: T = 100.into(); // 创建了类型为 T 的变量 a，它的初始值由 100 转换而来
    println!("a is: {}", a);}
fn main() {
    create_and_print();}  // create_and_print::<i64>();
```
##### 3.8.1.2 结构体中使用泛型
```rust
struct Point<T> {
    x: T,
    y: T,
}

fn main() {
    let integer = Point { x: 5, y: 10 };
    let float = Point { x: 1.0, y: 4.0 };
}
```
- **提前声明**，在使用泛型参数之前必需要进行声明 `Point<T>`，就可以在结构体的字段类型中使用 `T` 来替代具体的类型
- **x 和 y 是相同的类型**
###### 3.8.1.2.1 想让 `x` 和 `y` 既能类型相同，又能类型不同，就需要使用不同的泛型参数：
```rust
struct Point<T,U> {    x: T,    y: U,}
fn main() {
    let p = Point{x: 1, y :1.1};}
```
切记，所有的泛型参数都要提前声明：`Point<T,U>` ! 但是如果你的结构体变成这鬼样：`struct Woo<T,U,V,W,X>`，那么你需要考虑拆分这个结构体，减少泛型参数的个数和代码复杂度。
##### 3.8.1.3 枚举中使用泛型
```rust
enum Option<T> {
    Some(T),
    None,
}
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```
`Option<T>` 是一个拥有泛型 `T` 的枚举类型，它第一个成员是 `Some(T)`，存放了一个类型为 `T` 的值。得益于泛型的引入，我们可以在任何一个需要返回值的函数中，去使用 `Option<T>` 枚举类型来做为返回值，用于返回一个任意类型的值 `Some(T)`，或者没有值 `None`。
`Result`和 `Option` 一样，主要用于函数返回值，与 `Option` 用于值的存在与否不同，`Result` 关注的主要是<span style="background:#f500a3">值的正确性。</span>
如果函数正常运行，则最后返回一个 `Ok(T)`，`T` 是函数具体的返回值类型，如果成功打开文件，则返回 `Ok(std::fs::File)`，因此 `T` 对应的是 `std::fs::File` 类型；
如果函数异常运行，则返回一个 `Err(E)`，`E` 是错误类型。而当打开文件时出现问题时，返回 `Err(std::io::Error)`，`E` 对应的就是 `std::io::Error` 类型。
##### 3.8.1.4 方法中使用泛型
```rust
struct Point<T> {    x: T,    y: T,}
impl<T> Point<T> {
    fn x(&self) -> &T {        &self.x    }
}
fn main() {
    let p = Point { x: 5, y: 10 };
    println!("p.x = {}", p.x());}
```
使用泛型参数前，依然需要提前声明：`impl<T>`，只有提前声明了，我们才能在`Point<T>`中使用它，这样 Rust 就知道 `Point` 的尖括号中的类型是泛型而不是具体类型。需要注意的是，这里的 `Point<T>` 不再是泛型声明，而是一个完整的结构体类型，因为我们定义的结构体就是 `Point<T>` 而不再是 `Point`。
除了结构体中的泛型参数，我们还能在该结构体的方法中定义额外的泛型参数，就跟泛型函数一样：
```rust
struct Point<T, U> {
    x: T,
    y: U,
}
impl<T, U> Point<T, U> {
    fn mixup<V, W>(self, other: Point<V, W>) -> Point<T, W> {
        Point {
            x: self.x,
            y: other.y,
        }
    }
}

fn main() {
    let p1 = Point { x: 5, y: 10.4 };
    let p2 = Point { x: "Hello", y: 'c'};

    let p3 = p1.mixup(p2);

    println!("p3.x = {}, p3.y = {}", p3.x, p3.y);
}
```
这个例子中，`T,U` 是定义在结构体 `Point` 上的泛型参数，`V,W` 是单独定义在方法 `mixup` 上的泛型参数，它们并不冲突，说白了，你可以理解为，一个是结构体泛型，一个是函数泛型。
###### 3.8.1.4.1 为具体的泛型类型实现方法
对于 `Point<T>` 类型，你不仅能定义基于 `T` 的方法，还能针对特定的具体类型，进行方法定义：
```rust
impl Point<f32> {
    fn distance_from_origin(&self) -> f32 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }}
```
这段代码意味着 `Point<f32>` 类型会有一个方法 `distance_from_origin`，而其他 `T` 不是 `f32` 类型的 `Point<T>` 实例则没有定义此方法。这个方法计算点实例与坐标`(0.0, 0.0)` 之间的距离，并使用了只能用于浮点型的数学运算符。
这样我们就能<span style="background:#f500a3">针对特定的泛型类型实现某个特定的方法，对于其它泛型类型则没有定义该方法</span>。
##### 3.8.1.5 const 泛型（Rust 1.51 版本引入的重要特性）
针对类型实现的泛型，所有的泛型都是为了抽象不同的类型，那有没有针对值的泛型？
```rust
fn display_array(arr: &[i32]) { // 使用数组切片，然后传入 `arr` 的不可变引用即可
fn display_array<T: std::fmt::Debug>(arr: &[T]) { // 将 `i32` 改成所有类型的数组： 该限制表明 `T` 可以用在 `println!("{:?}", arr)` 中，因为 `{:?}` 形式的格式化输出需要 `arr` 实现该特征。
    println!("{:?}", arr);
}
fn main() {
    let arr: [i32; 3] = [1, 2, 3];
    display_array(&arr);

    let arr: [i32; 2] = [1, 2];
    display_array(&arr);
}
```
通过引用，我们可以很轻松的解决处理<span style="background:#0779e4">任何类型数组</span>的问题，
但是如果在某些场景下引用不适宜用或者干脆不能用呢？你们知道为什么以前 Rust 的一些数组库，在使用的时候都限定长度不超过 32 吗？因为它们会为每个长度都单独实现一个函数，简直。。。毫无人性。难道没有什么办法可以解决这个问题吗？
好在，现在咱们有了 const 泛型，也就是针对值的泛型，正好可以用于处理数组长度的问题：
```rust
fn display_array<T: std::fmt::Debug, const N: usize>(arr: [T; N]) {
    println!("{:?}", arr);
}
fn main() {
    let arr: [i32; 3] = [1, 2, 3];
    display_array(arr);

    let arr: [i32; 2] = [1, 2];
    display_array(arr);
}
```
定义了一个类型为 `[T; N]` 的数组，其中 `T` 是一个基于类型的泛型参数，这个和之前讲的泛型没有区别，而重点在于 `N` 这个泛型参数，它是一个基于值的泛型参数！因为它用来替代的是数组的长度。
`N` 就是 const 泛型，定义的语法是 `const N: usize`，表示 const 泛型 `N` ，它基于的值类型是 `usize`。
在泛型参数之前，Rust 完全不适合复杂矩阵的运算，自从有了 const 泛型，一切即将改变。
###### 3.8.1.5.1 const 泛型表达式
假设我们某段代码需要在内存很小的平台上工作，因此需要<span style="background:gray">限制函数参数占用的内存大小</span>，此时就可以使用 const 泛型表达式来实现：
```rust
// 目前只能在nightly版本下使用
#![allow(incomplete_features)]
#![feature(generic_const_exprs)]

fn something<T>(val: T)
where
    Assert<{ core::mem::size_of::<T>() < 768 }>: IsTrue,
    //       ^-----------------------------^ 这里是一个 const 表达式，换成其它的 const 表达式也可以
{
    //
}

fn main() {
    something([0u8; 0]); // ok
    something([0u8; 512]); // ok
    something([0u8; 1024]); // 编译错误，数组长度是1024字节，超过了768字节的参数长度限制
}

// ---

pub enum Assert<const CHECK: bool> {
    //
}

pub trait IsTrue {
    //
}

impl IsTrue for Assert<true> {
    //
}
```
###### 3.8.1.5.2 const fn 常量函数
允许我们在编译期对函数进行求值，从而实现更高效、更灵活的代码设计
1. 为什么需要 const fn
通常情况下，函数是在<span style="background:red">运行时</span>被调用和执行的。然而，在某些场景下，我们希望在编译期就计算出一些值，以提高运行时的性能或满足某些编译期的约束条件。例如，定义数组的长度、计算常量值等。
有了 `const fn`，我们可以在<span style="background:#f60909">编译期</span>执行这些函数，从而将计算结果直接嵌入到生成的代码中。这不仅以高了运行时的性能，还使代码更加简洁和安全。
2. const fn 的基本用法
定义一个常量函数，只需要在函数声明前加上 `const` 关键字。例如：
```rust
const fn add(a: usize, b: usize) -> usize {
    a + b }
const RESULT: usize = add(5, 10);
fn main() {
    println!("The result is: {}", RESULT);
}
```
###### 3.8.1.5.3 const fn 的限制
由于其在编译期执行，以确保函数能在编译期被安全地求值，因此有一些限制，例如，不可将随机数生成器写成 `const fn`。
无论在编译时还是运行时调用 `const fn`，它们的结果总是相同，即使多次调用也是如此。唯一的例外是，如果你在极端情况下进行复杂的浮点操作，你可能会得到（非常轻微的）不同结果。因此，不建议使 `数组长度 (arr.len())` 和 `Enum判别式` 依赖于浮点计算。
###### 3.8.1.5.4 结合 const fn 与 const 泛型
将 `const fn` 与 `const 泛型` 结合，可以实现更加灵活和高效的代码设计。例如，创建一个固定大小的缓冲区结构，其中缓冲区大小由编译期计算确定：
```rust
struct Buffer<const N: usize> {
    data: [u8; N],}
const fn compute_buffer_size(factor: usize) -> usize {
    factor * 1024}

fn main() {
    const SIZE: usize = compute_buffer_size(4);
    let buffer = Buffer::<SIZE> {        data: [0; SIZE],    };
    println!("Buffer size: {} bytes", buffer.data.len());}
```
在这个例子中，`compute_buffer_size` 是一个常量函数，它根据传入的 `factor` 计算缓冲区的大小。在 `main` 函数中，我们使用 `compute_buffer_size(4)` 来计算缓冲区大小为 4096 字节，并将其作为泛型参数传递给 `Buffer` 结构体。这样，缓冲区的大小在编译期就被确定下来，避免了运行时的计算开销。
###### 3.8.1.5.5 泛型的性能
在 Rust 中泛型是<span style="background:#0779e4">零成本的抽象</span>，意味着你在使用泛型时，完全<font color=#2485E3>不用担心性能上的问题</font>。
但是任何选择都是权衡得失的，既然我们获得了性能上的巨大优势，那么又失去了什么呢？Rust 是在编译期为泛型对应的多个类型，生成各自的代码，因此<span style="background:red">损失了编译速度和增大了最终生成文件的大小</span>。
具体来说：
Rust 通过在编译时进行泛型代码的 **单态化**(_monomorphization_)来保证效率。单态化是一个通过填充编译时使用的具体类型，将通用代码转换为特定代码的过程。
编译器所做的工作正好与我们创建泛型函数的步骤相反，编译器寻找所有泛型代码被调用的位置并针对具体类型生成代码。
让我们看看一个使用标准库中 `Option` 枚举的例子：

```rust
let integer = Some(5);
let float = Some(5.0);
```
当 Rust 编译这些代码的时候，它会进行单态化。编译器会读取传递给 `Option<T>` 的值并发现有两种 `Option<T>`：一种对应 `i32` 另一种对应 `f64`。为此，它会将泛型定义 `Option<T>` 展开为 `Option_i32` 和 `Option_f64`，接着将泛型定义替换为这两个具体的定义。
编译器生成的单态化版本的代码看起来像这样：
```rust
enum Option_i32 {    Some(i32),    None,}
enum Option_f64 {    Some(f64),    None,}
fn main() {
    let integer = Option_i32::Some(5);
    let float = Option_f64::Some(5.0);}
```
我们可以使用泛型来编写不重复的代码，而 Rust 将会为每一个实例编译其特定类型的代码。这意味着在使用泛型时没有运行时开销；当代码运行，它的执行效率就跟好像手写每个具体定义的重复代码一样。这个单态化过程正是 Rust 泛型在运行时极其高效的原因。
#### 3.8.2 特征 Trait
把每一种不同的行为抽象出来，就要使用 Rust 中的特征 `trait` 概念。 `#[derive(Debug)]`，它在我们定义的类型(`struct`)上自动派生 `Debug` 特征，接着可以使用 `println!("{:?}", x)` 打印这个类型；再例如：
```rust
fn add<T: std::ops::Add<Output = T>>(a:T, b:T) -> T {     a + b}
```
通过 `std::ops::Add` 特征来限制 `T`，只有 `T` 实现了 `std::ops::Add` 才能进行合法的加法操作，毕竟不是所有的类型都能进行相加。
特征：定义了**一组可以被共享的行为，只要实现了特征，你就能使用这组行为**。
##### 3.8.2.1 定义特征
如果不同的类型具有相同的行为，那么我们就可以定义一个特征，然后为这些类型实现该特征。
**定义特征**是把一些方法组合在一起，目的是定义一个实现某些目标所必需的行为的集合。
例如，我们现在有文章 `Post` 和微博 `Weibo` 两种内容载体，而我们想对相应的内容进行总结，也就是无论是文章内容，还是微博内容，都可以在某个时间点进行总结，那么总结这个行为就是共享的，因此可以用特征来定义：
```rust
pub trait Summary {
    fn summarize(&self) -> String;
}
```
1. 使用 `trait` 关键字来声明一个特征，`Summary` 是特征名。在大括号中定义了该特征的所有方法
2. 只定义特征方法的签名，而不进行实现：特征只定义行为看起来是什么样的，而不定义行为具体是怎么样的。因此，方法签名结尾是 `;`，而不是一个 `{}`。
3. 每一个实现这个特征的类型都需要具体实现该特征的相应方法，编译器也会确保任何实现 `Summary` 特征的类型都拥有与这个签名的定义完全一致的 `summarize` 方法。
##### 3.8.2.2 为类型实现特征
因为特征只定义行为看起来是什么样的，因此我们需要为类型实现具体的特征，定义行为具体是怎么样的。
```rust
pub trait Summary {
    fn summarize(&self) -> String;
}
pub struct Post {    pub title: String, // 标题     pub author: String, // 作者     pub content: String, // 内容}
impl Summary for Post { //实现特征的具体行为
    fn summarize(&self) -> String {
        format!("文章{}, 作者是{}", self.title, self.author)
    }}
pub struct Weibo {    pub username: String,    pub content: String}
impl Summary for Weibo {
    fn summarize(&self) -> String {
        format!("{}发表了微博{}", self.username, self.content)
	    }}
// 实现特征的语法与为结构体、枚举实现方法很像：impl Summary for Post，读作“为 Post 类型实现 Summary 特征”，然后在 impl 的花括号中实现该特征的具体方法。
// 接下来就可以在这个类型上调用特征的方法：
fn main() {
    let post = Post{title: "Rust语言简介".to_string(),author: "Sunface".to_string(), content: "Rust棒极了!".to_string()};
    let weibo = Weibo{username: "sunface".to_string(),content: "好像微博没Tweet好用".to_string()};

    println!("{}",post.summarize());
    println!("{}",weibo.summarize());
}
//运行输出：
//文章 Rust 语言简介, 作者是Sunface
//sunface发表了微博好像微博没Tweet好用
```
###### 3.8.2.2.1 特征定义与实现的位置(孤儿规则)
上面我们将 `Summary` 定义成了 `pub` 公开的。这样，如果他人想要使用我们的 `Summary` 特征，则可以引入到他们的包中，然后再进行实现。
关于特征实现与定义的位置，有一条非常重要的原则：**如果你想要为类型** `A` **实现特征** `T`**，那么** `A` **或者** `T` **至少有一个是在当前作用域中定义的！** 例如我们可以为上面的 `Post` 类型实现标准库中的 `Display` 特征，这是因为 `Post` 类型定义在当前的作用域中。同时，我们也可以在当前包中为 `String` 类型实现 `Summary` 特征，因为 `Summary` 定义在当前作用域中。
但是你无法在当前作用域中，为 `String` 类型实现 `Display` 特征，因为它们俩都定义在标准库中，其定义所在的位置都不在当前作用域，跟你半毛钱关系都没有，看看就行了。
该规则被称为**孤儿规则**，可以确保其它人编写的代码不会破坏你的代码，也确保了你不会莫名其妙就破坏了风马牛不相及的代码。
###### 3.8.2.2.2 默认实现
特征中可以定义具有**默认实现**的方法，这样其它类型无需再实现该方法，或者也可以选择重载该方法：
```rust
pub trait Summary {
    fn summarize(&self) -> String {
        String::from("(Read more...)")
    }
}
impl Summary for Post {}
impl Summary for Weibo {
    fn summarize(&self) -> String {
        format!("{}发表了微博{}", self.username, self.content)
    }
}
//可以看到，`Post` 选择了默认实现，而 `Weibo` 重载了该方法，调用和输出如下：
    println!("{}",post.summarize());
    println!("{}",weibo.summarize());
(Read more...)
sunface发表了微博好像微博没Tweet好用
```
<font color=#F36208>默认实现允许调用相同特征中的其他方法，哪怕这些方法没有默认实现</font>。
如此，<font color=#81B300>特征可以提供很多有用的功能而只需要实现指定的一小部分内容</font>。
```rust
pub trait Summary {
    fn summarize_author(&self) -> String;

    fn summarize(&self) -> String {
    // 例如，我们可以定义 `Summary` 特征，使其具有一个需要实现的 `summarize_author` 方法，然后定义一个 `summarize` 方法，此方法的默认实现调用 `summarize_author` 方法：
        format!("(Read more from {}...)", self.summarize_author())
    }
}
// 为了使用 `Summary`，只需要实现 `summarize_author` 方法即可：
impl Summary for Weibo {
    fn summarize_author(&self) -> String {
        format!("@{}", self.username)
    }
}
println!("1 new weibo: {}", weibo.summarize());

// `weibo.summarize()` 会先调用 `Summary` 特征默认实现的 `summarize` 方法，通过该方法进而调用 `Weibo` 为 `Summary` 实现的 `summarize_author` 方法，最终输出：`1 new weibo: (Read more from @horse_ebooks...)`。
```
##### 3.8.2.3 使用特征作为函数参数
```rust
pub fn notify(item: &impl Summary) { // `impl Summary`，实现了`Summary`特征 的 `item` 参数。 可以使用任何实现了 `Summary` 特征的类型作为该函数的参数，同时在函数体内，还可以调用该特征的方法，例如 `summarize` 方法。具体的说，可以传递 `Post` 或 `Weibo` 的实例来作为参数，而其它类如 `String` 或者 `i32` 的类型则不能用做该函数的参数，因为它们没有实现 `Summary` 特征。
    println!("Breaking news! {}", item.summarize());
}
```
##### 3.8.2.4 特征约束(trait bound)
虽然 `impl Trait` 这种语法非常好理解，但是实际上它只是一个语法糖：
```rust
pub fn notify<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}
```
真正的完整书写形式如上所述，形如 `T: Summary` 被称为**特征约束**。
在简单的场景下 `impl Trait` 这种语法糖就足够使用，但是对于复杂的场景，特征约束可以让我们拥有更大的灵活性和语法表现能力，
1. 一个函数接受两个 `impl Summary` 的参数：两个参数是不同的类型
```rust
pub fn notify(item1: &impl Summary1, item2: &impl Summary2) {}
```
2. 函数的两个参数是同一类型, 只能使特征约束来实现：
```rust
pub fn notify<T: Summary>(item1: &T, item2: &T) {}
```
泛型类型 `T` 说明了 `item1` 和 `item2` 必须拥有同样的类型，同时 `T: Summary` 说明了 `T` 必须实现 `Summary` 特征。
###### 3.8.2.4.1 多重约束
指定多个约束条件
1. 语法糖形式:
```rust
pub fn notify(item: &(impl Summary + Display)) {} //除了让参数实现 `Summary` 特征外，还可以让参数实现 `Display` 特征以控制它的格式化输出：
```
2. 特征约束形式：
```rust
pub fn notify<T: Summary + Display>(item: &T) {}
```
通过这两个特征，就可以使用 `item.summarize` 方法，以及通过 `println!("{}", item)` 来格式化输出 `item`。
###### 3.8.2.4.2 where-约束
<span style="background:#0779e4">当特征约束变得很多时，函数的签名将变得很复杂</span>：
```rust
fn some_function<T: Display + Clone, U: Clone + Debug>(t: &T, u: &U) -> i32 {}
```
对其做一些形式上的改进，通过 `where`：
```rust
fn some_function<T, U>(t: &T, u: &U) -> i32
    where T: Display + Clone,
          U: Clone + Debug
{}```
###### 3.8.2.4.3 使用特征约束有条件地实现方法或特征
特征约束，可以让我们在<span style="background:#0779e4">指定类型 + 指定特征</span>的条件下去实现方法，例如：
```rust
use std::fmt::Display;
struct Pair<T> {
    x: T,
    y: T,
}
impl<T> Pair<T> {
    fn new(x: T, y: T) -> Self {
        Self {
            x,
            y,
        }
    }
}
impl<T: Display + PartialOrd> Pair<T> { // `cmp_display` 方法，并不是所有的 `Pair<T>` 结构体对象都可以拥有，只有 `T` 同时实现了 `Display + PartialOrd` 的 `Pair<T>` 才可以拥有此方法。 该函数可读性会更好，因为泛型参数、参数、返回值都在一起，可以快速的阅读，同时每个泛型参数的特征也在新的代码行中通过**特征约束**进行了约束。
    fn cmp_display(&self) {
        if self.x >= self.y {
            println!("The largest member is x = {}", self.x);
        } else {
            println!("The largest member is y = {}", self.y);
        }
    }
}
```
**也可以有条件地实现特征**，例如，标准库为任何实现了 `Display` 特征的类型实现了 `ToString` 特征：
```rust
impl<T: Display> ToString for T {
    // --snip--
}
// 我们可以对任何实现了 `Display` 特征的类型调用由 `ToString` 定义的 `to_string` 方法。例如，可以将整型转换为对应的 `String` 值，因为整型实现了 `Display`：
let s = 3.to_string();
```
##### 3.8.2.5 函数返回中的 impl Trait
可以通过 `impl Trait` 来说明一个函数返回了一个类型，该类型实现了某个特征：
```rust
fn returns_summarizable() -> impl Summary {
    Weibo {
        username: String::from("sunface"),
        content: String::from(
            "m1 max太厉害了，电脑再也不会卡",
        )
    }
}
```
因为 `Weibo` 实现了 `Summary`，因此这里可以用它来作为返回值。要注意的是，虽然我们知道这里是一个 `Weibo` 类型，但是对于 `returns_summarizable` 的调用者而言，他只知道返回了一个实现了 `Summary` 特征的对象，但是并不知道返回了一个 `Weibo` 类型。

这种 `impl Trait` 形式的返回值，在一种场景下非常非常有用，那就是返回的真实类型非常复杂，你不知道该怎么声明时（毕竟 Rust 要求你必须标出所有的类型），此时就可以用 `impl Trait` 的方式简单返回。你可以用 `impl Iterator` 来告诉调用者，返回了一个迭代器，因为所有迭代器都会实现 `Iterator` 特征。
但是这种返回值方式有一个很大的限制：<span style="background:#f60909">只能有一个具体的类型</span>，例如：
```rust
fn returns_summarizable(switch: bool) -> impl Summary {
    if switch {
        Post {
            title: String::from(
                "Penguins win the Stanley Cup Championship!",
            ),
            author: String::from("Iceburgh"),
            content: String::from(
                "The Pittsburgh Penguins once again are the best \
                 hockey team in the NHL.",
            ),
        }
    } else {
        Weibo {
            username: String::from("horse_ebooks"),
            content: String::from(
                "of course, as you probably already know, people",
            ),
        }
    }
}
```
以上的代码就无法通过编译，因为它返回了两个不同的类型 `Post` 和 `Weibo`。
```console
`if` and `else` have incompatible types
expected struct `Post`, found struct `Weibo`
```
报错提示我们 `if` 和 `else` 返回了不同的类型。如果想要实现返回不同的类型，<span style="background:#f500a3">需要使用下一章节中的[特征对象](https://course.rs/basic/trait/trait-object.html)。</span>
##### 3.8.2.6 修复上一节中的 largest 函数
在 `largest` 函数体中我们想要使用大于运算符（`>`）比较两个 `T` 类型的值。这个运算符是标准库中特征 `std::cmp::PartialOrd` 的一个默认方法。所以需要在 `T` 的特征约束中指定 `PartialOrd`，这样 `largest` 函数可以用于内部元素类型可比较大小的数组切片。
由于 `PartialOrd` 位于 `prelude` 中所以并不需要通过 `std::cmp` 手动将其引入作用域。所以可以将 `largest` 的签名修改为如下： 
修改后还是报错，错误的核心是 `cannot move out of type [T], a non-copy slice`，原因是 `T` 没有[实现 `Copy` 特性](https://course.rs/basic/ownership/ownership.html#%E6%8B%B7%E8%B4%9D%E6%B5%85%E6%8B%B7%E8%B4%9D)，
```rust
fn largest<T: PartialOrd + Copy>(list: &[T]) -> T {
    let mut largest = list[0];

    for &item in list.iter() {
        if item > largest {
            largest = item;
        }
    }

    largest
}

fn main() {
    let number_list = vec![34, 50, 25, 100, 65];

    let result = largest(&number_list);
    println!("The largest number is {}", result);

    let char_list = vec!['y', 'm', 'a', 'q'];

    let result = largest(&char_list);
    println!("The largest char is {}", result);
}
```
如果并不希望限制 `largest` 函数只能用于实现了 `Copy` 特征的类型，我们可以在 `T` 的特征约束中指定 [`Clone` 特征](https://course.rs/basic/ownership/ownership.html#%E5%85%8B%E9%9A%86%E6%B7%B1%E6%8B%B7%E8%B4%9D) 而不是 `Copy` 特征。并克隆 `list` 中的每一个值使得 `largest` 函数拥有其所有权。使用 `clone` 函数意味着对于类似 `String` 这样拥有堆上数据的类型，会潜在地分配更多堆上空间，而堆分配在涉及大量数据时可能会相当缓慢。
另一种 `largest` 的实现方式是返回在 `list` 中 `T` 值的引用。如果我们将函数返回值从 `T` 改为 `&T` 并改变函数体使其能够返回一个引用，我们将不需要任何 `Clone` 或 `Copy` 的特征约束而且也不会有任何的堆分配。尝试自己实现这种替代解决方式吧！
##### 3.8.2.7 通过 derive 派生特征
在本书中，形如 `#[derive(Debug)]` 的代码已经出现了很多次，这种是一种特征派生语法，被 `derive` 标记的对象会自动实现对应的默认特征代码，继承相应的功能。
例如 `Debug` 特征，它有一套自动实现的默认代码，当你给一个结构体标记后，就可以使用 `println!("{:?}", s)` 的形式打印该结构体的对象。
再如 `Copy` 特征，它也有一套自动实现的默认代码，当标记到一个类型上时，可以让这个类型自动实现 `Copy` 特征，进而可以调用 `copy` 方法，进行自我复制。
总之，`derive` 派生出来的是 Rust 默认给我们提供的特征，在开发过程中极大的简化了自己手动实现相应特征的需求，当然，如果你有特殊的需求，还可以自己手动重载该实现。
详细的 `derive` 列表参见[附录-派生特征](https://course.rs/appendix/derive.html)。
##### 3.8.2.8 调用方法需要引入特征
在一些场景中，使用 `as` 关键字做<font color=#F36208>类型转换</font>会有比较大的限制，因为你想要在类型转换上拥有完全的控制，例如处理转换错误，那么你将需要 `TryInto`：
```rust
use std::convert::TryInto;
fn main() {
  let a: i32 = 10;
  let b: u16 = 100;
  let b_ = b.try_into()
            .unwrap();
  if a < b_ {
    println!("Ten is less than one hundred.");
  }}
```
上面代码中引入了 `std::convert::TryInto` 特征，但是却没有使用它，可能有些同学会为此困惑，主要原因在于**如果你要使用一个特征的方法，那么你需要将该特征引入当前的作用域中**，我们在上面用到了 `try_into` 方法，因此需要引入对应的特征。
但是 Rust 又提供了一个非常便利的办法，即把最常用的标准库中的特征通过 [`std::prelude`](https://course.rs/appendix/prelude.html) 模块提前引入到当前作用域中，其中包括了 `std::convert::TryInto`，你可以尝试删除第一行的代码 `use ...`，看看是否会报错。
##### 3.8.2.9 几个综合例子
###### 3.8.2.9.1 为自定义类型实现 + 操作
```rust
// Rust 中除了数值类型的加法，`String` 也可以做加法，因为 Rust 为该类型实现了 `std::ops::Add` 特征，同理，如果我们为自定义类型实现了该特征，那就可以自己实现 `Point1 + Point2` 的操作:
use std::ops::Add;

// 为Point结构体派生Debug特征，用于格式化输出
#[derive(Debug)]
struct Point<T: Add<T, Output = T>> { //限制类型T必须实现了Add特征，否则无法进行+操作。
    x: T,
    y: T,
}

impl<T: Add<T, Output = T>> Add for Point<T> {
    type Output = Point<T>;

    fn add(self, p: Point<T>) -> Point<T> {
        Point{
            x: self.x + p.x,
            y: self.y + p.y,
        }
    }
}

fn add<T: Add<T, Output=T>>(a:T, b:T) -> T {
    a + b
}

fn main() {
    let p1 = Point{x: 1.1f32, y: 1.1f32};
    let p2 = Point{x: 2.1f32, y: 2.1f32};
    println!("{:?}", add(p1, p2));

    let p3 = Point{x: 1i32, y: 1i32};
    let p4 = Point{x: 2i32, y: 2i32};
    println!("{:?}", add(p3, p4));
}
```
###### 3.8.2.9.2 自定义类型的打印输出
在开发过程中，往往只要使用 `#[derive(Debug)]` 对我们的自定义类型进行标注，即可实现打印输出的功能：
```rust
#[derive(Debug)]
struct Point{
    x: i32,
    y: i32
}
fn main() {
    let p = Point{x:3,y:3};
    println!("{:?}",p);
}
```
但是在实际项目中，往往需要对我们的自定义类型进行<font color=#2485E3>自定义的格式化输出</font>，以让用户更好的阅读理解我们的类型，此时就要为自定义类型实现 `std::fmt::Display` 特征：
```rust
#![allow(dead_code)]
use std::fmt;
use std::fmt::{Display};

#[derive(Debug,PartialEq)]
enum FileState {
  Open,
  Closed,
}
#[derive(Debug)]
struct File {
  name: String,
  data: Vec<u8>,
  state: FileState,
}

impl Display for FileState {
   fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
     match *self {
         FileState::Open => write!(f, "OPEN"),
         FileState::Closed => write!(f, "CLOSED"),
     }
   }
}
impl Display for File {
   fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
      write!(f, "<{} ({})>",
             self.name, self.state)
   }
}
impl File {
  fn new(name: &str) -> File {
    File {
        name: String::from(name),
        data: Vec::new(),
        state: FileState::Closed,
    }
  }
}

fn main() {
  let f6 = File::new("f6.txt");
  //...
  println!("{:?}", f6);
  println!("{}", f6);
}
```
以上两个例子较为复杂，目的是为读者展示下真实的使用场景长什么样，
#### 3.8.3 特征对象
```rust
// 在上一节中有一段代码无法通过编译：
fn returns_summarizable(switch: bool) -> impl Summary {
    if switch {
        Post {
           // ...
        }
    } else {
        Weibo {
            // ...
        }
    }
}
```
现在在做一款游戏，需要将多个对象渲染在屏幕上，这些对象属于不同的类型，存储在列表中，渲染的时候，需要循环该列表并顺序渲染每个对象，在 Rust 中该怎么实现？聪明的同学可能已经能想到一个办法，利用枚举：
```rust
#[derive(Debug)]
enum UiObject {
    Button,
    SelectBox,
}

fn main() {
    let objects = [
        UiObject::Button,
        UiObject::SelectBox
    ];

    for o in objects {
        draw(o)
    }
}

fn draw(o: UiObject) {
    println!("{:?}",o);
}
```
Bingo，这个确实是一个办法，但是问题来了，如果<font color=#F36208>你的对象集合并不能事先明确地知道</font>呢？或者别人想要实现一个 UI 组件呢？此时枚举中的类型是有些缺少的，是不是还要修改你的代码增加一个枚举成员？
总之，在编写这个 UI 库时，我们无法知道所有的 UI 对象类型，只知道的是：
- UI 对象的类型不同
- 需要一个统一的类型来处理这些对象，无论是作为函数参数还是作为列表中的一员
- 需要对每一个对象调用 `draw` 方法
在拥有继承的语言中，可以定义一个名为 `Component` 的类，该类上有一个 `draw` 方法。其他的类比如 `Button`、`Image` 和 `SelectBox` 会从 `Component` 派生并因此继承 `draw` 方法。它们各自都可以覆盖 `draw` 方法来定义自己的行为，但是框架会把所有这些类型当作是 `Component` 的实例，并在其上调用 `draw`。不过 Rust 并没有继承，我们得另寻出路。
##### 3.8.3.1 特征对象定义
在介绍特征对象之前，先来为之前的 UI 组件定义一个特征：pub trait Draw {    fn draw(&self);}
只要组件实现了 `Draw` 特征，就可以调用 `draw` 方法来进行渲染。假设有一个 `Button` 和 `SelectBox` 组件实现了 `Draw` 特征：
```rust
pub struct Button {
    pub width: u32,
    pub height: u32,
    pub label: String,
}

impl Draw for Button {
    fn draw(&self) {
        // 绘制按钮的代码
    }
}

struct SelectBox {
    width: u32,
    height: u32,
    options: Vec<String>,
}

impl Draw for SelectBox {
    fn draw(&self) {
        // 绘制SelectBox的代码
    }
}
//此时，还需要一个动态数组来存储这些 UI 对象：
pub struct Screen {
    pub components: Vec<?>,
}
```
注意到上面代码中的 `?` 吗？它的意思是：我们应该填入什么类型，
**特征对象**指向实现了 `Draw` 特征的类型的实例，也就是指向了 `Button` 或者 `SelectBox` 的实例，这种映射关系是存储在一张表中，可以在运行时通过特征对象找到具体调用的类型方法。
可以通过 `&` 引用或者 `Box<T>` 智能指针的方式来创建特征对象。
> `Box<T>` 在后面章节会[详细讲解](https://course.rs/advance/smart-pointer/box.html)，大家现在把它当成一个引用即可，只不过它包裹的值会被强制分配在堆上。
```rust
trait Draw {
    fn draw(&self) -> String;
}

impl Draw for u8 {
    fn draw(&self) -> String {
        format!("u8: {}", *self)
    }
}

impl Draw for f64 {
    fn draw(&self) -> String {
        format!("f64: {}", *self)
    }
}

// 若 T 实现了 Draw 特征， 则调用该函数时传入的 Box<T> 可以被隐式转换成函数参数签名中的 Box<dyn Draw>
fn draw1(x: Box<dyn Draw>) {
    // 由于实现了 Deref 特征，Box 智能指针会自动解引用为它所包裹的值，然后调用该值对应的类型上定义的 `draw` 方法
    x.draw();
}

fn draw2(x: &dyn Draw) {
    x.draw();
}

fn main() {
    let x = 1.1f64;
    // do_something(&x);
    let y = 8u8;

    // x 和 y 的类型 T 都实现了 `Draw` 特征，因为 Box<T> 可以在函数调用时隐式地被转换为特征对象 Box<dyn Draw> 
    // 基于 x 的值创建一个 Box<f64> 类型的智能指针，指针指向的数据被放置在了堆上
    draw1(Box::new(x));
    // 基于 y 的值创建一个 Box<u8> 类型的智能指针
    draw1(Box::new(y));
    draw2(&x);
    draw2(&y);
}
```
上面代码，有几个非常重要的点：
- `draw1` 函数的参数是 `Box<dyn Draw>` 形式的特征对象，该特征对象是通过 `Box::new(x)` 的方式创建的
- `draw2` 函数的参数是 `&dyn Draw` 形式的特征对象，该特征对象是通过 `&x` 的方式创建的
- `dyn` 关键字只用在特征对象的类型声明上，在创建时无需使用 `dyn`
因此，可以使用特征对象来代表泛型或具体的类型。
继续来完善之前的 UI 组件代码，首先来实现 `Screen`：
```rust
pub struct Screen {
    pub components: Vec<Box<dyn Draw>>,
}
```
其中存储了一个动态数组，里面元素的类型是 `Draw` 特征对象：`Box<dyn Draw>`，任何实现了 `Draw` 特征的类型，都可以存放其中。
再来为 `Screen` 定义 `run` 方法，用于将列表中的 UI 组件渲染在屏幕上：
```rust
impl Screen {
    pub fn run(&self) {
        for component in self.components.iter() {
            component.draw();
        }    }}
```
至此，我们就完成了之前的目标：在列表中存储多种不同类型的实例，然后将它们使用同一个方法逐一渲染在屏幕上！
再来看看，如果通过泛型实现，会如何：
```rust
pub struct Screen<T: Draw> {
    pub components: Vec<T>,}
impl<T> Screen<T>
    where T: Draw {
    pub fn run(&self) {
        for component in self.components.iter() {
            component.draw();
        }    }}
```
上面的 `Screen` 的列表中，存储了类型为 `T` 的元素，然后在 `Screen` 中使用特征约束让 `T` 实现了 `Draw` 特征，进而可以调用 `draw` 方法。
但是这种写法限制了 `Screen` 实例的 `Vec<T>` 中的每个元素必须是 `Button` 类型或者全是 `SelectBox` 类型。如果只需要同质（相同类型）集合，更倾向于采用泛型+特征约束这种写法，因其实现更清晰，且性能更好(特征对象，需要在运行时从 `vtable` 动态查找需要调用的方法)。
现在来运行渲染下咱们精心设计的 UI 组件列表：
```rust
fn main() {
    let screen = Screen {
        components: vec![
            Box::new(SelectBox {
                width: 75,
                height: 10,
                options: vec![
                    String::from("Yes"),
                    String::from("Maybe"),
                    String::from("No")
                ],
            }),
            Box::new(Button {
                width: 50,
                height: 10,
                label: String::from("OK"),
            }),        ],    };
    screen.run();}
```
上面使用 `Box::new(T)` 的方式来创建了两个 `Box<dyn Draw>` 特征对象，如果以后还需要增加一个 UI 组件，那么让该组件实现 `Draw` 特征，则可以很轻松的将其渲染在屏幕上，甚至用户可以引入我们的库作为三方库，然后在自己的库中为自己的类型实现 `Draw` 特征，然后进行渲染。
在动态类型语言中，有一个很重要的概念：**鸭子类型**(_duck typing_)，简单来说，就是只关心值长啥样，而不关心它实际是什么。当一个东西走起来像鸭子，叫起来像鸭子，那么它就是一只鸭子，就算它实际上是一个奥特曼，也不重要，我们就当它是鸭子。
在上例中，`Screen` 在 `run` 的时候，我们并不需要知道各个组件的具体类型是什么。它也不检查组件到底是 `Button` 还是 `SelectBox` 的实例，只要它实现了 `Draw` 特征，就能通过 `Box::new` 包装成 `Box<dyn Draw>` 特征对象，然后被渲染在屏幕上。
使用特征对象和 Rust 类型系统来进行类似鸭子类型操作的优势是，<font color=#F36208>无需在运行时检查一个值是否实现了特定方法或者担心在调用时因为值没有实现方法而产生错误</font>。如果值没有实现特征对象所需的特征， 那么 Rust 根本就不会编译这些代码：
```rust
fn main() {
    let screen = Screen {
        components: vec![
            Box::new(String::from("Hi")),
        ],
    };
    screen.run();
}
```
因为 `String` 类型没有实现 `Draw` 特征，编译器直接就会报错，不会让上述代码运行。如果想要 `String` 类型被渲染在屏幕上，那么只需要为其实现 `Draw` 特征即可，非常容易。
注意 `dyn` 不能单独作为特征对象的定义，例如下面的代码编译器会报错，原因是<span style="background:#0779e4">特征对象可以是任意实现了某个特征的类型，编译器在编译期不知道该类型的大小，不同的类型大小是不同的。</span>
而 `&dyn` 和 `Box<dyn>` 在编译期都是已知大小，所以可以用作特征对象的定义。
```rust
fn draw2(x: dyn Draw) {
    x.draw();
}
10 | fn draw2(x: dyn Draw) {
   |          ^ doesn't have a size known at compile-time
   |
   = help: the trait `Sized` is not implemented for `(dyn Draw + 'static)`
help: function arguments must have a statically known size, borrowed types always have a known size
```
##### 3.8.3.2 特征对象的动态分发
1. 静态分发： 泛型是在编译期完成处理的：编译器会为每一个泛型参数对应的具体类型生成一份代码，这种方式是**静态分发(static dispatch)**，因为是在编译期完成的，对于运行期性能完全没有任何影响。
2. 动态分发：与静态分发相对应的是**动态分发(dynamic dispatch)**，在这种情况下，直到运行时，才能确定需要调用什么方法。之前代码中的关键字 `dyn` 正是在强调这一“动态”的特点。
当使用<span style="background:#f500a3">特征对象时，Rust 必须使用动态分发</span>。编译器无法知晓所有可能用于特征对象代码的类型，所以它也不知道应该调用哪个类型的哪个方法实现。为此，Rust 在运行时使用特征对象中的指针来知晓需要调用哪个方法。动态分发也阻止编译器有选择的内联方法代码，这会相应的禁用一些优化。
下面这张图很好的解释了静态分发 `Box<T>` 和动态分发 `Box<dyn Trait>` 的区别：
![](imgs/Rust语言圣经(Rust%20Course)-9.png)
- **特征对象大小不固定**：这是因为，对于特征 `Draw`，类型 `Button` 可以实现特征 `Draw`，类型 `SelectBox` 也可以实现特征 `Draw`，因此特征没有固定大小
- **几乎总是使用特征对象的引用方式**，如 `&dyn Draw`、`Box<dyn Draw>`
    - 虽然特征对象没有固定大小，但它的引用类型的大小是固定的，它由两个指针组成（`ptr` 和 `vptr`），因此占用两个指针大小
    - 一个指针 `ptr` 指向实现了特征 `Draw` 的具体类型的实例，也就是当作特征 `Draw` 来用的类型的实例，比如类型 `Button` 的实例、类型 `SelectBox` 的实例
    - 另一个指针 `vptr` 指向一个虚表 `vtable`，`vtable` 中保存了类型 `Button` 或类型 `SelectBox` 的实例对于可以调用的实现于特征 `Draw` 的方法。当调用方法时，直接从 `vtable` 中找到方法并调用。之所以要使用一个 `vtable` 来保存各实例的方法，是因为实现了特征 `Draw` 的类型有多种，这些类型拥有的方法各不相同，当将这些类型的实例都当作特征 `Draw` 来使用时(此时，它们全都看作是特征 `Draw` 类型的实例)，有必要区分这些实例各自有哪些方法可调用
简而言之，当类型 `Button` 实现了特征 `Draw` 时，类型 `Button` 的实例对象 `btn` 可以当作特征 `Draw` 的特征对象类型来使用，`btn` 中保存了作为特征对象的数据指针（指向类型 `Button` 的实例数据）和行为指针（指向 `vtable`）。
一定要注意，此时的 `btn` 是 `Draw` 的特征对象的实例，而不再是具体类型 `Button` 的实例，而且 `btn` 的 `vtable` 只包含了实现自特征 `Draw` 的那些方法（比如 `draw`），因此 `btn` 只能调用实现于特征 `Draw` 的 `draw` 方法，而不能调用类型 `Button` 本身实现的方法和类型 `Button` 实现于其他特征的方法。**也就是说，`btn` 是哪个特征对象的实例，它的 `vtable` 中就包含了该特征的方法。**
##### 3.8.3.3 Self 与 self
有两个`self`，一个指代当前的实例对象，一个指代特征或者方法类型的别名：
```rust
trait Draw {
    fn draw(&self) -> Self;
}

#[derive(Clone)]
struct Button;
impl Draw for Button {
    fn draw(&self) -> Self {
        return self.clone()
    }
}

fn main() {
    let button = Button;
    let newb = button.draw();
}
```
上述代码中，`self`指代的就是当前的实例对象，也就是 `button.draw()` 中的 `button` 实例，`Self` 则指代的是 `Button` 类型。
当理解了 `self` 与 `Self` 的区别后，我们再来看看何为对象安全。
##### 3.8.3.4 特征对象的限制
不是所有特征都能拥有特征对象，<span style="background:#f500a3">只有对象安全的特征才行</span>。当一个特征的所有方法都有如下属性时，它的对象才是安全的：
- 方法的返回类型不能是 `Self`
- 方法没有任何泛型参数
对象安全对于特征对象是必须的，因为一旦有了特征对象，就不再需要知道实现该特征的具体类型是什么了。如果特征方法返回了具体的 `Self` 类型，但是特征对象忘记了其真正的类型，那这个 `Self` 就非常尴尬，因为没人知道它是谁了。但是对于泛型类型参数来说，当使用特征时其会放入具体的类型参数：此具体类型变成了实现该特征的类型的一部分。而当使用特征对象时其具体类型被抹去了，故而无从得知放入泛型参数类型到底是什么。
标准库中的 `Clone` 特征就不符合对象安全的要求：
```rust
pub trait Clone {
    fn clone(&self) -> Self;
}
```
因为它的其中一个方法，返回了 `Self` 类型，因此它是对象不安全的。
`String` 类型实现了 `Clone` 特征， `String` 实例上调用 `clone` 方法时会得到一个 `String` 实例。类似的，当调用 `Vec<T>` 实例的 `clone` 方法会得到一个 `Vec<T>` 实例。`clone` 的签名需要知道什么类型会代替 `Self`，因为这是它的返回值。
如果违反了对象安全的规则，编译器会提示你。例如，如果尝试使用之前的 `Screen` 结构体来存放实现了 `Clone` 特征的类型：
```rust
pub struct Screen {
    pub components: Vec<Box<dyn Clone>>,
}
```
将会得到如下错误：
```text
error[E0038]: the trait `std::clone::Clone` cannot be made into an object
 --> src/lib.rs:2:5
  |
2 |     pub components: Vec<Box<dyn Clone>>,
  |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ the trait `std::clone::Clone`
  cannot be made into an object
  |
  = note: the trait cannot require that `Self : Sized`
```
这意味着不能以这种方式使用此特征作为特征对象。
#### 3.8.4 深入了解特征
##### 3.8.4.1 关联类型
在方法一章中，我们讲到了[关联函数](https://course.rs/basic/method#%E5%85%B3%E8%81%94%E5%87%BD%E6%95%B0)，但是实际上关联类型和关联函数并没有任何交集，虽然它们的名字有一半的交集。
**关联类型**是在特征定义的语句块中，申明一个自定义类型，这样就可以在特征的方法签名中使用该类型：
```rust
pub trait Iterator {
    type Item;
    fn next(&mut self) -> Option<Self::Item>;
}
以上是标准库中的迭代器特征 `Iterator`，它有一个 `Item` 关联类型，用于替代遍历的值的类型。
同时，`next` 方法也返回了一个 `Item` 类型，不过使用 `Option` 枚举进行了包裹，假如迭代器中的值是 `i32` 类型，那么调用 `next` 方法就将获取一个 `Option<i32>` 的值。
```
还记得 `Self` 吧？在之前的章节[提到过](https://course.rs/basic/trait/trait-object#self-%E4%B8%8E-self)， **`Self` 用来指代当前调用者的具体类型，那么 `Self::Item` 就用来指代该类型实现中定义的 `Item` 类型**：
```rust
impl Iterator for Counter {
    type Item = u32;
    fn next(&mut self) -> Option<Self::Item> {
        // --snip--
    }
}

fn main() {
    let c = Counter{..}
    c.next()
}
```
在上述代码中，我们为 `Counter` 类型实现了 `Iterator` 特征，变量 `c` 是特征 `Iterator` 的实例，也是 `next` 方法的调用者。 结合之前的黑体内容可以得出：对于 `next` 方法而言，`Self` 是调用者 `c` 的具体类型： `Counter`，而 `Self::Item` 是 `Counter` 中定义的 `Item` 类型: `u32`。
聪明的读者之所以聪明，是因为你们喜欢联想和举一反三，同时你们也喜欢提问：为何不用泛型，例如如下代码：
```rust
pub trait Iterator<Item> {
    fn next(&mut self) -> Option<Item>;
}
```
答案其实很简单，为了代码的可读性，当你使用了泛型后，你需要在所有地方都写 `Iterator<Item>`，而使用了关联类型，你只需要写 `Iterator`，当类型定义复杂时，这种写法可以极大的增加可读性：

```rust
pub trait CacheableItem: Clone + Default + fmt::Debug + Decodable + Encodable {
  type Address: AsRef<[u8]> + Clone + fmt::Debug + Eq + Hash;
  fn is_null(&self) -> bool;
}
```
例如上面的代码，`Address` 的写法自然远比 `AsRef<[u8]> + Clone + fmt::Debug + Eq + Hash` 要简单的多，而且含义清晰。
1. 使用泛型，导致函数头部也必须增加泛型的声明，你将得到以下的代码：
```rust
trait Container<A,B> {
    fn contains(&self,a: A,b: B) -> bool;
}
fn difference<A,B,C>(container: &C) -> i32
  where
    C : Container<A,B> {...}
```
2. 使用关联类型，将得到可读性好得多的代码：
```rust
trait Container{
    type A;
    type B;
    fn contains(&self, a: &Self::A, b: &Self::B) -> bool;
}

fn difference<C: Container>(container: &C) {}
```
##### 3.8.4.2 默认泛型类型参数
当使用泛型类型参数时，可以为其指定一个默认的具体类型，例如标准库中的 `std::ops::Add` 特征：
```rust
trait Add<RHS=Self> {
    type Output;
    fn add(self, rhs: RHS) -> Self::Output;
}
```
它有一个泛型参数 `RHS`，但是与我们以往的用法不同，这里它给 `RHS` 一个默认值，也就是当用户不指定 `RHS` 时，默认使用两个同样类型的值进行相加，然后返回一个关联类型 `Output`。
可能上面那段不太好理解，下面我们用代码来举例：
```rust
use std::ops::Add;

#[derive(Debug, PartialEq)]
struct Point {
    x: i32,
    y: i32,
}

impl Add for Point {
    type Output = Point;
    fn add(self, other: Point) -> Point {
        Point {
            x: self.x + other.x,
            y: self.y + other.y,
        }
    }
}

fn main() {
    assert_eq!(Point { x: 1, y: 0 } + Point { x: 2, y: 3 },
               Point { x: 3, y: 3 });
}
```
上面的代码主要干了一件事，就是为 `Point` 结构体提供 `+` 的能力，这就是**运算符重载**，不过 Rust 并不支持创建自定义运算符，你也无法为所有运算符进行重载，目前来说，只有定义在 `std::ops` 中的运算符才能进行重载。
跟 `+` 对应的特征是 `std::ops::Add`，我们在之前也看过它的定义 `trait Add<RHS=Self>`，但是上面的例子中并没有为 `Point` 实现 `Add<RHS>` 特征，而是实现了 `Add` 特征（没有默认泛型类型参数），这意味着我们使用了 `RHS` 的默认类型，也就是 `Self`。换句话说，我们这里定义的是两个相同的 `Point` 类型相加，因此无需指定 `RHS`。
与上面的例子相反，下面的例子，我们来创建两个不同类型的相加：
```rust
use std::ops::Add;

struct Millimeters(u32);
struct Meters(u32);

impl Add<Meters> for Millimeters {
    type Output = Millimeters;

    fn add(self, other: Meters) -> Millimeters {
        Millimeters(self.0 + (other.0 * 1000))
    }
}
```
这里，是进行 `Millimeters + Meters` 两种数据类型的 `+` 操作，因此此时不能再使用默认的 `RHS`，否则就会变成 `Millimeters + Millimeters` 的形式。使用 `Add<Meters>` 可以将 `RHS` 指定为 `Meters`，那么 `fn add(self, rhs: RHS)` 自然而言的变成了 `Millimeters` 和 `Meters` 的相加。
默认类型参数主要用于两个方面：
1. 减少实现的样板代码
2. 扩展类型但是无需大幅修改现有的代码
之前的例子就是第一点，虽然效果也就那样。在 `+` 左右两边都是同样类型时，只需要 `impl Add` 即可，否则你需要 `impl Add<SOME_TYPE>`，嗯，会多写几个字:)
对于第二点，也很好理解，如果你在一个复杂类型的基础上，新引入一个泛型参数，可能需要修改很多地方，但是如果新引入的泛型参数有了默认类型，情况就会好很多，添加泛型参数后，使用这个类型的代码需要逐个在类型提示部分添加泛型参数，就很麻烦；但是有了默认参数（且默认参数取之前的实现里假设的值的情况下）之后，原有的使用这个类型的代码就不需要做改动了。
归根到底，默认泛型参数，是有用的，但是大多数情况下，咱们确实用不到，当需要用到时，大家再回头来查阅本章即可，**手上有剑，心中不慌**。
##### 3.8.4.3 调用同名的方法
不同特征拥有同名的方法是很正常的事情，你没有任何办法阻止这一点；甚至除了特征上的同名方法外，在你的类型上，也有同名方法：
```rust
trait Pilot {
    fn fly(&self);
}

trait Wizard {
    fn fly(&self);
}

struct Human;

impl Pilot for Human {
    fn fly(&self) {
        println!("This is your captain speaking.");
    }
}

impl Wizard for Human {
    fn fly(&self) {
        println!("Up!");
    }
}

impl Human {
    fn fly(&self) {
        println!("*waving arms furiously*");
    }
}
```
这里，不仅仅两个特征 `Pilot` 和 `Wizard` 有 `fly` 方法，就连实现那两个特征的 `Human` 单元结构体，也拥有一个同名方法 `fly` (这世界怎么了，非要这么卷吗？程序员何苦难为程序员，哎)。
既然代码已经不可更改，那下面我们来讲讲该如何调用这些 `fly` 方法。
###### 3.8.4.3.1 优先调用类型上的方法
当调用 `Human` 实例的 `fly` 时，编译器默认调用该类型中定义的方法：
```rust
fn main() {
    let person = Human;
    person.fly();
}
```
这段代码会打印 `*waving arms furiously*`，说明直接调用了类型上定义的方法。
###### 3.8.4.3.2 调用特征上的方法
为了能够调用两个特征的方法，需要使用显式调用的语法：
```rust
fn main() {
    let person = Human;
    Pilot::fly(&person); // 调用Pilot特征上的方法
    Wizard::fly(&person); // 调用Wizard特征上的方法
    person.fly(); // 调用Human类型自身的方法
}
运行后依次输出：
This is your captain speaking.
Up!
*waving arms furiously*
```
因为 `fly` 方法的参数是 `self`，当显式调用时，编译器就可以根据调用的类型( `self` 的类型)决定具体调用哪个方法。
这个时候问题又来了，如果方法没有 `self` 参数呢？稍等，估计有读者会问：还有方法没有 `self` 参数？关联函数
```rust
trait Animal {
    fn baby_name() -> String;
}

struct Dog;

impl Dog {
    fn baby_name() -> String {
        String::from("Spot")
    }
}

impl Animal for Dog {
    fn baby_name() -> String {
        String::from("puppy")
    }
}

fn main() {
    println!("A baby dog is called a {}", Dog::baby_name());
}
```
就像人类妈妈会给自己的宝宝起爱称一样，狗妈妈也会。狗妈妈称呼自己的宝宝为**Spot**，其它动物称呼狗宝宝为**puppy**，这个时候假如有动物不知道该如何称呼狗宝宝，它需要查询一下。
`Dog::baby_name()` 的调用方式显然不行，因为这只是狗妈妈对宝宝的爱称，可能你会想到通过下面的方式查询其他动物对狗狗的称呼：
```rust
fn main() {
    println!("A baby dog is called a {}", Animal::baby_name());
}
铛铛，无情报错了：
error[E0283]: type annotations needed // 需要类型注释
  --> src/main.rs:20:43
20 |     println!("A baby dog is called a {}", Animal::baby_name());
   |                                           ^^^^^^^^^^^^^^^^^ cannot infer type // 无法推断类型
   = note: cannot satisfy `_: Animal`
```
因为单纯从 `Animal::baby_name()` 上，编译器无法得到任何有效的信息：实现 `Animal` 特征的类型可能有很多，你究竟是想获取哪个动物宝宝的名称？狗宝宝？猪宝宝？还是熊宝宝？
此时，就需要使用**完全限定语法**。
##### 3.8.4.4 完全限定语法
完全限定语法是调用函数最为明确的方式：
```rust
fn main() {
    println!("A baby dog is called a {}", <Dog as Animal>::baby_name()); //在尖括号中，通过 `as` 关键字，我们向 Rust 编译器提供了类型注解，也就是 `Animal` 就是 `Dog`，而不是其他动物，因此最终会调用 `impl Animal for Dog` 中的方法，获取到其它动物对狗宝宝的称呼：**puppy**。
}
```
1. 完全限定语法定义为：
```rust
<Type as Trait>::function(receiver_if_method, next_arg, ...);
```
上面定义中，第一个参数是方法接收器 `receiver` （三种 `self`），只有方法才拥有，例如关联函数就没有 `receiver`。
完全限定语法可以用于<font color=#F36208>任何函数或方法调用</font>，
我们为何很少用到这个语法？原因是 
1. Rust 编译器能根据上下文自动推导出调用的路径，因此大多数时候，我们都无需使用完全限定语法。
2. 只有当存在多个同名函数或方法，且 Rust 无法区分出你想调用的目标函数时，该用法才能真正有用武之地。
##### 3.8.4.5 特征定义中的特征约束
有时，我们会需要让某个特征 A 能使用另一个特征 B 的功能(另一种形式的特征约束)，这种情况下，不仅仅要为类型实现特征 A，还要为类型实现特征 B 才行，这就是基特征( super trait )。
例如有一个特征 `OutlinePrint`，它有一个方法，能够对当前的实现类型进行格式化输出：
```rust
use std::fmt::Display;

trait OutlinePrint: Display {
    fn outline_print(&self) {
        let output = self.to_string();
        let len = output.len();
        println!("{}", "*".repeat(len + 4));
        println!("*{}*", " ".repeat(len + 2));
        println!("* {} *", output);
        println!("*{}*", " ".repeat(len + 2));
        println!("{}", "*".repeat(len + 4));
    }
}
```
等等，这里有一个眼熟的语法: `OutlinePrint: Display`，感觉很像之前讲过的**特征约束**，只不过用在了特征定义中而不是函数的参数中，是的，在某种意义上来说，这和特征约束非常类似，都用来说明一个特征需要实现另一个特征，这里就是：如果你想要实现 `OutlinePrint` 特征，首先你需要实现 `Display` 特征。
想象一下，假如没有这个特征约束，那么 `self.to_string` 还能够调用吗（ `to_string` 方法会为实现 `Display` 特征的类型自动实现）？编译器肯定是不愿意的，会报错说当前作用域中找不到用于 `&Self` 类型的方法 `to_string` ：
```rust
struct Point {
    x: i32,
    y: i32,
}
impl OutlinePrint for Point {}
```
因为 `Point` 没有实现 `Display` 特征，会得到下面的报错：
```console
error[E0277]: the trait bound `Point: std::fmt::Display` is not satisfied
  --> src/main.rs:20:6
   |
20 | impl OutlinePrint for Point {}
   |      ^^^^^^^^^^^^ `Point` cannot be formatted with the default formatter;
try using `:?` instead if you are using a format string
   |
   = help: the trait `std::fmt::Display` is not implemented for `Point`
```
既然我们有求于编译器，那只能选择满足它咯：
```rust
use std::fmt;

impl fmt::Display for Point {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "({}, {})", self.x, self.y)
    }
}
```
上面代码为 `Point` 实现了 `Display` 特征，那么 `to_string` 方法也将自动实现：最终获得字符串是通过这里的 `fmt` 方法获得的。
##### 3.8.4.6 在外部类型上实现外部特征(newtype)
在[特征](https://course.rs/basic/trait/trait#%E7%89%B9%E5%BE%81%E5%AE%9A%E4%B9%89%E4%B8%8E%E5%AE%9E%E7%8E%B0%E7%9A%84%E4%BD%8D%E7%BD%AE%E5%AD%A4%E5%84%BF%E8%A7%84%E5%88%99)章节中，有提到孤儿规则，简单来说，就是特征或者类型必需至少有一个是本地的，才能在此类型上定义特征。
这里提供一个办法来绕过孤儿规则，那就是使用**newtype 模式**，简而言之：就是为一个[元组结构体](https://course.rs/basic/compound-type/struct#%E5%85%83%E7%BB%84%E7%BB%93%E6%9E%84%E4%BD%93tuple-struct)创建新类型。该元组结构体封装有一个字段，该字段就是希望实现特征的具体类型。
该封装类型是本地的，因此我们可以为此类型实现外部的特征。
`newtype` 不仅仅能实现以上的功能，而且它在运行时没有任何性能损耗，因为在编译期，该类型会被自动忽略。
下面来看一个例子，我们有一个动态数组类型： `Vec<T>`，它定义在标准库中，还有一个特征 `Display`，它也定义在标准库中，如果没有 `newtype`，我们是无法为 `Vec<T>` 实现 `Display` 的：
```console
error[E0117]: only traits defined in the current crate can be implemented for arbitrary types
--> src/main.rs:5:1
5 | impl<T> std::fmt::Display for Vec<T> {
| ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^------
| |                             Vec is not defined in the current crate
| impl doesn't use only types from inside the current crate
|
= note: define and implement a trait or new type instead
```
编译器给了我们提示： `define and implement a trait or new type instead`，重新定义一个特征，或者使用 `new type`，前者当然不可行，那么来试试后者：
```rust
use std::fmt;
struct Wrapper(Vec<String>);
impl fmt::Display for Wrapper {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "[{}]", self.0.join(", "))
    }}
fn main() {
    let w = Wrapper(vec![String::from("hello"), String::from("world")]);
    println!("w = {}", w);
}
```
其中，`struct Wrapper(Vec<String>)` 就是一个元组结构体，它定义了一个新类型 `Wrapper`
`new type` 坏处
1. 怎么访问里面的数组吗？`self.0.join(", ")`，是的，很啰嗦，因为需要先从 `Wrapper` 中取出数组: `self.0`，然后才能执行 `join` 方法。
类似的，任何数组上的方法，你都无法直接调用，需要先用 `self.0` 取出数组，然后再进行调用。

当然，解决办法还是有的，要不怎么说 Rust 是极其强大灵活的编程语言！Rust 提供了一个特征叫 [`Deref`](https://course.rs/advance/smart-pointer/deref.html)，实现该特征后，可以自动做一层类似类型转换的操作，可以将 `Wrapper` 变成 `Vec<String>` 来使用。这样就会像直接使用数组那样去使用 `Wrapper`，而无需为每一个操作都添加上 `self.0`。
同时，如果不想 `Wrapper` 暴露底层数组的所有方法，我们还可以为 `Wrapper` 去重载这些方法，实现隐藏的目的。

### 3.9 集合类型
集合在 Rust 中是一类比较特殊的类型，因为 Rust 中大多数数据类型都只能代表一个特定的值，但是集合却可以代表一大堆值。而且与语言级别的数组、字符串类型不同，标准库里的这些家伙是分配在堆上，因此都可以进行动态的增加和减少。
`Vector` 类型，允许你创建一个动态数组，类型一致，它里面的元素是一个紧挨着另一个排列的。
`HashMap` 类型，该类型允许你在里面存储 `KV` 对，每一个 `K` 都有唯一的 `V` 与之配对。
`String` 集合，
#### 3.9.1 动态数组 Vector
1. 动态数组类型用 `Vec<T>` 表示，
2. 动态数组允许你存储多个值，
3. 这些值在内存中一个紧挨着另一个排列，因此访问其中某个元素的成本非常低。
4. 动态数组只能存储相同类型的元素，
如果你想存储不同类型的元素，可以使用之前讲过的枚举类型或者特征对象。
总之，当我们想拥有一个列表，里面都是相同类型的数据时，动态数组将会非常有用。
##### 3.9.1.1 创建动态数组
在 Rust 中，有多种方式可以创建动态数组。
###### 3.9.1.1.1 Vec::new
使用 `Vec::new` 创建动态数组是最 rusty 的方式，它调用了 `Vec` 中的 `new` 关联函数：
```rust
let v: Vec<i32> = Vec::new(); // `v` 被显式地声明了类型 `Vec<i32>`，这是因为 Rust 编译器无法从 `Vec::new()` 中得到任何关于类型的暗示信息，因此也无法推导出 `v` 的具体类型
// 当你向里面增加一个元素后，一切又不同了：此时，`v` 就无需手动声明类型，因为编译器通过 `v.push(1)`，推测出 `v` 中的元素类型是 `i32`，因此推导出 `v` 的类型是 `Vec<i32>`。
let mut v = Vec::new();
v.push(1);
```
>> 如果预先知道要存储的元素个数，可以使用 `Vec::with_capacity(capacity)` 创建动态数组，这样可以避免因为插入大量新数据导致频繁的内存分配和拷贝，提升性能

###### 3.9.1.1.2 vec![]
还可以使用宏 `vec!` 来创建数组，在创建同时给予初始化值：
```rust
let v = vec![1, 2, 3]; //同样，此处的 `v` 也无需标注类型，编译器只需检查它内部的元素即可自动推导出 `v` 的类型是 `Vec<i32>` 
```
##### 3.9.1.2 更新 Vector
向数组尾部添加元素，可以使用 `push` 方法：
```rust
let mut v = Vec::new();
v.push(1);
与其它类型一样，必须将 `v` 声明为 `mut` 后，才能进行修改。
```
###### 3.9.1.2.1 Vector 与其元素共存亡
跟结构体一样，`Vector` 类型在超出作用域范围后，会被自动删除：
```rust
{
    let v = vec![1, 2, 3];
    // ...
} // <- v超出作用域并在此处被删除
```
当 `Vector` 被删除后，它内部存储的所有内容也会随之被删除。目前来看，这种解决方案简单直白，但是当 `Vector` 中的元素被引用后，事情可能会没那么简单。
##### 3.9.1.3 从 Vector 中读取元素
读取指定位置的元素有两种方式可选：
- 通过下标索引访问。
- 使用 `get` 方法。
```rust
let v = vec![1, 2, 3, 4, 5];
let third: &i32 = &v[2];
println!("第三个元素是 {}", third);
match v.get(2) {
    Some(third) => println!("第三个元素是 {third}"),
    None => println!("去你的第三个元素，根本没有！"),
}
```
和其它语言一样，集合类型的索引下标都是从 `0` 开始，`&v[2]` 表示借用 `v` 中的第三个元素，最终会获得该元素的引用。而 `v.get(2)` 也是访问第三个元素，但是有所不同的是，它返回了 `Option<&T>`，因此还需要额外的 `match` 来匹配解构出具体的值。
> 细心的同学会注意到这里使用了两种格式化输出的方式，其中第一种我们在之前已经见过，而第二种是后续新版本中引入的写法，也是更推荐的用法，具体介绍请参见[格式化输出章节](https://course.rs/basic/formatted-output.html)。

<span style="background:#f60909">下标索引与 `.get` 的区别</span>
1. 这两种方式都能成功的读取到指定的数组元素
```rust
let v = vec![1, 2, 3, 4, 5];
let does_not_exist = &v[100];
let does_not_exist = v.get(100);
```
2. `&v[100]` 的访问方式会导致程序无情报错退出，因为发生了数组越界访问。 但是 `v.get` 就不会，它在内部做了处理，有值的时候返回 `Some(T)`，无值的时候返回 `None`，因此 `v.get` 的使用方式非常安全。
3. 统一使用 `v.get` 的形式？因为实在是有些啰嗦，简洁即正义，何况性能上也会有轻微的损耗。
当你确保索引不会越界的时候，就用索引访问，否则用 `.get`。
例如，访问第几个数组元素并不取决于我们，而是取决于用户的输入时，用 `.get` 会非常适合，天知道那些可爱的用户会输入一个什么样的数字进来！
##### 3.9.1.4 同时借用多个数组元素
既然涉及到借用数组元素，那么很可能会遇到同时借用多个数组元素的情况，还记得在[所有权和借用](https://course.rs/basic/ownership/borrowing.html#%E5%80%9F%E7%94%A8%E8%A7%84%E5%88%99%E6%80%BB%E7%BB%93)章节咱们讲过的借用规则嘛？如果记得，就来看看下面的代码 :)
```rust
let mut v = vec![1, 2, 3, 4, 5];
let first = &v[0];
v.push(6);
println!("The first element is: {first}");
```
先不运行，来推断下结果，首先 `first = &v[0]` 进行了不可变借用，`v.push` 进行了可变借用，如果 `first` 在 `v.push` 之后不再使用，那么该段代码可以成功编译（原因见[引用的作用域](https://course.rs/basic/ownership/borrowing.html#%E5%8F%AF%E5%8F%98%E5%BC%95%E7%94%A8%E4%B8%8E%E4%B8%8D%E5%8F%AF%E5%8F%98%E5%BC%95%E7%94%A8%E4%B8%8D%E8%83%BD%E5%90%8C%E6%97%B6%E5%AD%98%E5%9C%A8)）。
可是上面的代码中，`first` 这个不可变借用在可变借用 `v.push` 后被使用了，那么妥妥的，编译器就会报错：
```console
$ cargo run
Compiling collections v0.1.0 (file:///projects/collections)
error[E0502]: cannot borrow `v` as mutable because it is also borrowed as immutable 无法对v进行可变借用，因此之前已经进行了不可变借用
--> src/main.rs:6:5
4 |     let first = &v[0];
|                  - immutable borrow occurs here // 不可变借用发生在此处
6 |     v.push(6);
|     ^^^^^^^^^ mutable borrow occurs here // 可变借用发生在此处
8 |     println!("The first element is: {}", first);
|                                          ----- immutable borrow later used here // 不可变借用在这里被使用
For more information about this error, try `rustc --explain E0502`.
error: could not compile `collections` due to previous error
```
其实，按理来说，这两个引用不应该互相影响的：一个是查询元素，一个是在数组尾部插入元素，完全不相干的操作，为何编译器要这么严格呢？
原因在于：<span style="background:#f500a3">数组的大小是可变的，当旧数组的大小不够用时，Rust 会重新分配一块更大的内存空间，然后把旧数组拷贝过来。这种情况下，之前的引用显然会指向一块无效的内存</span>，这非常 rusty —— 对用户进行严格的教育。
> 若读者想要更深入的了解 `Vec<T>`，可以看看[Rustonomicon](https://nomicon.purewhite.io/vec/vec.html)，其中从零手撸一个动态数组，非常适合深入学习。
##### 3.9.1.5 迭代遍历 Vector 中的元素
如果想要依次访问数组中的元素，可以使用迭代的方式去遍历数组，这种方式比用下标的方式去遍历数组更安全也更高效（每次下标访问都会触发数组边界检查）：
```rust
let v = vec![1, 2, 3];
for i in &v {
    println!("{i}");
}
```
也可以在迭代过程中，修改 `Vector` 中的元素：
```rust
let mut v = vec![1, 2, 3];
for i in &mut v {
    *i += 10
}
```
##### 3.9.1.6 存储不同类型的元素
那就是通过使用枚举类型和特征对象来实现不同类型元素的存储。
###### 3.9.1.6.1 通过枚举如何实现：
```rust
#[derive(Debug)]
enum IpAddr {
    V4(String),
    V6(String)
}
fn main() {
    let v = vec![
        IpAddr::V4("127.0.0.1".to_string()),
        IpAddr::V6("::1".to_string())
    ];

    for ip in v {
        show_addr(ip)
    }
}

fn show_addr(ip: IpAddr) {
    println!("{:?}",ip);
}
```
数组 `v` 中存储了两种不同的 `ip` 地址，但是这两种都属于 `IpAddr` 枚举类型的成员，因此可以存储在数组中。
###### 3.9.1.6.2 特征对象的实现：
```rust
trait IpAddr {
    fn display(&self);
}

struct V4(String);
impl IpAddr for V4 {
    fn display(&self) {
        println!("ipv4: {:?}",self.0)
    }
}
struct V6(String);
impl IpAddr for V6 {
    fn display(&self) {
        println!("ipv6: {:?}",self.0)
    }
}

fn main() {
    let v: Vec<Box<dyn IpAddr>> = vec![
        Box::new(V4("127.0.0.1".to_string())),
        Box::new(V6("::1".to_string())),
    ];

    for ip in v {
        ip.display();
    }
}
```

比枚举实现要稍微复杂一些，我们为 `V4` 和 `V6` 都实现了特征 `IpAddr`，然后将它俩的实例用 `Box::new` 包裹后，存在了数组 `v` 中，需要注意的是，这里必须手动地指定类型：`Vec<Box<dyn IpAddr>>`，表示数组 `v` 存储的是特征 `IpAddr` 的对象，这样就实现了在数组中存储不同的类型。
在实际使用场景中，**特征对象数组要比枚举数组常见很多**，主要原因在于[特征对象](https://course.rs/basic/trait/trait-object.html)非常灵活，而编译器对枚举的限制较多，且无法动态增加类型。
##### 3.9.1.7 Vector 常用方法
初始化 vec 的更多方式：
```rust
fn main() {
    let v = vec![0; 3];   // 默认值为 0，初始长度为 3
    let v_from = Vec::from([0, 0, 0]);
    assert_eq!(v, v_from);
}
```
动态数组意味着我们增加元素时，如果**容量不足就会导致 vector 扩容**（目前的策略是重新申请一块 2 倍大小的内存，再将所有元素拷贝到新的内存位置，同时更新指针数据），显然，当频繁扩容或者当元素数量较多且需要扩容时，大量的内存拷贝会降低程序的性能。
可以考虑在<span style="background:#f500a3">初始化时就指定一个实际的预估容量，尽量减少可能的内存拷贝</span>：
```rust
fn main() {
    let mut v = Vec::with_capacity(10);
    v.extend([1, 2, 3]);    // 附加数据到 v
    println!("Vector 长度是: {}, 容量是: {}", v.len(), v.capacity());

    v.reserve(100);        // 调整 v 的容量，至少要有 100 的容量
    println!("Vector（reserve） 长度是: {}, 容量是: {}", v.len(), v.capacity());

    v.shrink_to_fit();     // 释放剩余的容量，一般情况下，不会主动去释放容量
    println!("Vector（shrink_to_fit） 长度是: {}, 容量是: {}", v.len(), v.capacity());
}
```
Vector 常见的一些方法示例：
```rust
let mut v =  vec![1, 2];
assert!(!v.is_empty());         // 检查 v 是否为空

v.insert(2, 3);                 // 在指定索引插入数据，索引值不能大于 v 的长度， v: [1, 2, 3] 
assert_eq!(v.remove(1), 2);     // 移除指定位置的元素并返回, v: [1, 3]
assert_eq!(v.pop(), Some(3));   // 删除并返回 v 尾部的元素，v: [1]
assert_eq!(v.pop(), Some(1));   // v: []
assert_eq!(v.pop(), None);      // 记得 pop 方法返回的是 Option 枚举值
v.clear();                      // 清空 v, v: []

let mut v1 = [11, 22].to_vec(); // append 操作会导致 v1 清空数据，增加可变声明
v.append(&mut v1);              // 将 v1 中的所有元素附加到 v 中, v1: []
v.truncate(1);                  // 截断到指定长度，多余的元素被删除, v: [11]
v.retain(|x| *x > 10);          // 保留满足条件的元素，即删除不满足条件的元素

let mut v = vec![11, 22, 33, 44, 55];
// 删除指定范围的元素，同时获取被删除元素的迭代器, v: [11, 55], m: [22, 33, 44]
let mut m: Vec<_> = v.drain(1..=3).collect();    

let v2 = m.split_off(1);        // 指定索引处切分成两个 vec, m: [22], v2: [33, 44]
```
当然也可以像[数组切片](https://course.rs/basic/compound-type/array.html#%E6%95%B0%E7%BB%84%E5%88%87%E7%89%87)的方式获取 vec 的部分元素：
```rust
fn main() {
    let v = vec![11, 22, 33, 44, 55];
    let slice = &v[1..=3];
    assert_eq!(slice, &[22, 33, 44]);
}
```
更多细节，阅读 Vector 的[标准库文档](https://doc.rust-lang.org/std/vec/struct.Vec.html#)。
##### 3.9.1.8 Vector 的排序
在 rust 里，实现了两种排序算法，
1. 稳定的排序 `sort` 和 `sort_by`，
2. 非稳定排序 `sort_unstable` 和 `sort_unstable_by`。
当然，这个所谓的 `非稳定` 并不是指排序算法本身不稳定，而是指在排序过程中<span style="background:#0779e4">对相等元素的处理方式</span>。在 `稳定` 排序算法里，对相等的元素，不会对其进行重新排序。而在 `不稳定` 的算法里则不保证这点。
总体而言，`非稳定` 排序的算法的速度会优于 `稳定` 排序算法，同时，`稳定` 排序还会额外分配原数组一半的空间。
###### 3.9.1.8.1 整数数组的排序
```rust
fn main() {
    let mut vec = vec![1, 5, 10, 2, 15];    
    vec.sort_unstable();    
    assert_eq!(vec, vec![1, 2, 5, 10, 15]);
}
```
###### 3.9.1.8.2 浮点数数组的排序
```rust
// 原来，在浮点数当中，存在一个 `NAN` 的值，这个值无法与其他的浮点数进行对比，因此，浮点数类型并没有实现全数值可比较 `Ord` 的特性，而是实现了部分可比较的特性 `PartialOrd`。

 let mut vec = vec![1.0, 5.6, 10.3, 2.0, 15f32];    
    vec.sort_unstable();    
    assert_eq!(vec, vec![1.0, 2.0, 5.6, 10.3, 15f32]);
// 如此，如果我们确定在我们的浮点数数组当中，不包含 `NAN` 值，那么我们可以使用 `partial_cmp` 来作为大小判断的依据。
fn main() {
    let mut vec = vec![1.0, 5.6, 10.3, 2.0, 15f32];    
    vec.sort_unstable_by(|a, b| a.partial_cmp(b).unwrap());    
    assert_eq!(vec, vec![1.0, 2.0, 5.6, 10.3, 15f32]);
}
```
###### 3.9.1.8.3 对结构体数组进行排序
结构体是否也可以使用这种自定义对比函数的方式来进行呢？马上来试一下：
```rust
#[derive(Debug)]
struct Person {
    name: String,
    age: u32,
}

impl Person {
    fn new(name: String, age: u32) -> Person {
        Person { name, age }
    }
}

fn main() {
    let mut people = vec![
        Person::new("Zoe".to_string(), 25),
        Person::new("Al".to_string(), 60),
        Person::new("John".to_string(), 1),
    ];
    // 定义一个按照年龄倒序排序的对比函数
    people.sort_unstable_by(|a, b| b.age.cmp(&a.age));

    println!("{:?}", people);
}
```
执行后输出：结果正确。
```
[Person { name: "Al", age: 60 }, Person { name: "Zoe", age: 25 }, Person { name: "John", age: 1 }]
```
从上面我们学习过程当中，排序需要我们实现 `Ord` 特性，那么如果我们把我们的结构体实现了该特性，是否就不需要我们自定义对比函数了呢？
是，但不完全是，实现 `Ord` 需要我们实现 `Ord`、`Eq`、`PartialEq`、`PartialOrd` 这些属性。好消息是，你可以 `derive` 这些属性：
```rust
#[derive(Debug, Ord, Eq, PartialEq, PartialOrd)]
struct Person {
    name: String,
    age: u32,
}

impl Person {
    fn new(name: String, age: u32) -> Person {
        Person { name, age }
    }
}

fn main() {
    let mut people = vec![
        Person::new("Zoe".to_string(), 25),
        Person::new("Al".to_string(), 60),
        Person::new("Al".to_string(), 30),
        Person::new("John".to_string(), 1),
        Person::new("John".to_string(), 25),
    ];

    people.sort_unstable();

    println!("{:?}", people);
}
```
执行输出
```
[Person { name: "Al", age: 30 }, Person { name: "Al", age: 60 }, Person { name: "John", age: 1 }, Person { name: "John", age: 25 }, Person { name: "Zoe", age: 25 }]
```
需要 `derive` `Ord` 相关特性，需要确保你的结构体中所有的属性均实现了 `Ord` 相关特性，否则会发生编译错误。`derive` 的默认实现会依据属性的顺序依次进行比较，如上述例子中，当 `Person` 的 `name` 值相同，则会使用 `age` 进行比较。
#### 3.9.2 KV 存储 HashMap
和动态数组一样，`HashMap` 也是 Rust 标准库中提供的集合类型，但是又与动态数组不同，`HashMap` 中存储的是一一映射的 `KV` 键值对，并提供了平均复杂度为 `O(1)` 的查询方法，当我们希望通过一个 `Key` 去查询值时，该类型非常有用，
Rust 中哈希类型（哈希映射）为 `HashMap<K,V>`，在其它语言中，也有类似的数据结构，例如 `hash map`，`map`，`object`，`hash table`，`字典` 等等
##### 3.9.2.1 创建 HashMap
跟创建动态数组 `Vec` 的方法类似，可以使用 `new` 方法来创建 `HashMap`，然后通过 `insert` 方法插入键值对。
###### 3.9.2.1.1 使用 new 方法创建
```rust
use std::collections::HashMap;
// 创建一个HashMap，用于存储宝石种类和对应的数量
let mut my_gems = HashMap::new();  // `HashMap<&str,i32>`。
// 将宝石类型和对应的数量写入表中
my_gems.insert("红宝石", 1);
my_gems.insert("蓝宝石", 2);
my_gems.insert("河边捡的误以为是宝石的破石头", 18);
```
1. 使用 `HashMap` 需要手动通过 `use ...` 从标准库中引入到我们当前的作用域中来，仔细回忆下，之前使用另外两个集合类型 `String` 和 `Vec` 时，我们是否有手动引用过？答案是 **No**，因为 `HashMap` 并没有包含在 Rust 的 [`prelude`](https://course.rs/appendix/prelude.html) 中（Rust 为了简化用户使用，提前将最常用的类型自动引入到作用域中）。

所有的集合类型都是动态的，意味着它们没有固定的内存大小，因此它们底层的数据都存储在内存堆上，然后通过一个存储在栈中的引用类型来访问。同时，跟其它集合类型一致，`HashMap` 也是内聚性的，即所有的 `K` 必须拥有同样的类型，`V` 也是如此。
> 跟 `Vec` 一样，如果预先知道要存储的 `KV` 对个数，可以使用 `HashMap::with_capacity(capacity)` 创建指定大小的 `HashMap`，避免频繁的内存分配和拷贝，提升性能。
###### 3.9.2.1.2 使用迭代器和 collect 方法创建
在实际使用中，不是所有的场景都能 `new` 一个哈希表后，然后悠哉悠哉的依次插入对应的键值对，而是可能会从另外一个数据结构中，获取到对应的数据，最终生成 `HashMap`。
例如考虑一个场景，有一张表格中记录了足球联赛中各队伍名称和积分的信息，这张表如果被导入到 Rust 项目中，一个合理的数据结构是 `Vec<(String, u32)>` 类型，该数组中的元素是一个个元组，该数据结构跟表格数据非常契合：表格中的数据都是逐行存储，每一个行都存有一个 `(队伍名称, 积分)` 的信息。
但是在很多时候，又需要通过队伍名称来查询对应的积分，此时动态数组就不适用了，因此可以用 `HashMap` 来保存相关的**队伍名称 -> 积分**映射关系。 理想很丰满，现实很骨感，如何将 `Vec<(String, u32)>` 中的数据快速写入到 `HashMap<String, u32>` 中？
1. 笨方法如下：
```rust
fn main() {
    use std::collections::HashMap;

    let teams_list = vec![
        ("中国队".to_string(), 100),
        ("美国队".to_string(), 10),
        ("日本队".to_string(), 50),
    ];

    let mut teams_map = HashMap::new();
    for team in &teams_list {
        teams_map.insert(&team.0, team.1);
    }

    println!("{:?}",teams_map)
}
// 遍历列表，将每一个元组作为一对 `KV` 插入到 `HashMap` 中，很简单，但是……也不太聪明的样子，换个词说就是 —— 不够 rusty。
```
2. 好在，Rust 为我们提供了一个非常精妙的解决办法：先将 `Vec` 转为迭代器，接着通过 `collect` 方法，将迭代器中的元素收集后，转成 `HashMap`：
```rust
fn main() {
    use std::collections::HashMap;

    let teams_list = vec![
        ("中国队".to_string(), 100),
        ("美国队".to_string(), 10),
        ("日本队".to_string(), 50),
    ];

    let teams_map: HashMap<_,_> = teams_list.into_iter().collect();
    
    println!("{:?}",teams_map)
}
```
`into_iter` 方法将列表转为迭代器，接着通过 `collect` 进行收集，不过需要注意的是，`collect` 方法在内部实际上支持生成多种类型的目标集合，因此我们需要通过类型标注 `HashMap<_,_>` 来告诉编译器：请帮我们收集为 `HashMap` 集合类型，具体的 `KV` 类型，麻烦编译器您老人家帮我们推导。
##### 3.9.2.2 所有权转移
`HashMap` 的所有权规则与其它 Rust 类型没有区别：
- 若类型实现 `Copy` 特征，该类型会被复制进 `HashMap`，因此无所谓所有权
- 若没实现 `Copy` 特征，所有权将被转移给 `HashMap` 中
```rust
fn main() {
    use std::collections::HashMap;
    let name = String::from("Sunface");
    let age = 18;
    let mut handsome_boys = HashMap::new();
    handsome_boys.insert(name, age);
    println!("因为过于无耻，{}已经被从帅气男孩名单中除名", name);
    println!("还有，他的真实年龄远远不止{}岁", age);
}
error[E0382]: borrow of moved value: `name` //`ame` 是 `String` 类型，因此它受到所有权的限制，在 `insert` 时，它的所有权被转移给 `handsome_boys`，所以最后在使用时，会遇到这个无情但是意料之中的报错。
  --> src/main.rs:10:32
```
**如果你使用引用类型放入 HashMap 中**，请确保该引用的生命周期至少跟 `HashMap` 活得一样久：
```rust
fn main() {
    use std::collections::HashMap;

    let name = String::from("Sunface");
    let age = 18;

    let mut handsome_boys = HashMap::new();
    handsome_boys.insert(&name, age);

    std::mem::drop(name);
    println!("因为过于无耻，{:?}已经被除名", handsome_boys);
    println!("还有，他的真实年龄远远不止{}岁", age);
}
```
上面代码，我们借用 `name` 获取了它的引用，然后插入到 `handsome_boys` 中，至此一切都很完美。但是紧接着，就通过 `drop` 函数手动将 `name` 字符串从内存中移除，再然后就报错了：
```console
 handsome_boys.insert(&name, age);
   |                          ----- borrow of `name` occurs here // name借用发生在此处
9  |
10 |     std::mem::drop(name);
   |                    ^^^^ move out of `name` occurs here // name的所有权被转移走
11 |     println!("因为过于无耻，{:?}已经被除名", handsome_boys);
   |                                              ------------- borrow later used here // 所有权转移后，还试图使用name
```
最终，某人因为过于无耻，真正的被除名了 :)
##### 3.9.2.3 查询 HashMap
通过 `get` 方法可以获取元素：
```rust
use std::collections::HashMap;
let mut scores = HashMap::new();
scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);

let team_name = String::from("Blue");
let score: Option<&i32> = scores.get(&team_name);
```
上面有几点需要注意：
- `get` 方法返回一个 `Option<&i32>` 类型：当查询不到时，会返回一个 `None`，查询到时返回 `Some(&i32)`
- `&i32` 是对 `HashMap` 中值的借用，如果不使用借用，可能会发生所有权的转移
还可以继续拓展下，上面的代码中，如果我们想直接获得值类型的 `score` 该怎么办，答案简约但不简单：
```rust
let score: i32 = scores.get(&team_name).copied().unwrap_or(0);
```
这里留给大家一个小作业：去官方文档中查询下 `Option` 的 `copied` 方法和 `unwrap_or` 方法的含义及该如何使用。
还可以通过循环的方式依次遍历 `KV` 对：
```rust
use std::collections::HashMap;

let mut scores = HashMap::new();

scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);

for (key, value) in &scores {
    println!("{}: {}", key, value);
}
最终输出：
Yellow: 50
Blue: 10
```
##### 3.9.2.4 更新 HashMap 中的值
更新值的时候，涉及多种情况，咱们在代码中一一进行说明：
```rust
fn main() {
    use std::collections::HashMap;
    let mut scores = HashMap::new();
    scores.insert("Blue", 10);
    // 覆盖已有的值
    let old = scores.insert("Blue", 20);
    assert_eq!(old, Some(10));
    // 查询新插入的值
    let new = scores.get("Blue");
    assert_eq!(new, Some(&20));
    // 查询Yellow对应的值，若不存在则插入新值
    let v = scores.entry("Yellow").or_insert(5);
    assert_eq!(*v, 5); // 不存在，插入5

    // 查询Yellow对应的值，若不存在则插入新值
    let v = scores.entry("Yellow").or_insert(50);
    assert_eq!(*v, 5); // 已经存在，因此50没有插入
}
```
具体的解释在代码注释中已有，这里不再进行赘述。
###### 3.9.2.4.1 在已有值的基础上更新
另一个常用场景如下：查询某个 `key` 对应的值，若不存在则插入新值，若存在则对已有的值进行更新，例如在文本中统计词语出现的次数：
```rust
use std::collections::HashMap;
let text = "hello world wonderful world";
let mut map = HashMap::new();
// 根据空格来切分字符串(英文单词都是通过空格切分)
for word in text.split_whitespace() {
    let count = map.entry(word).or_insert(0);
    *count += 1;
}
println!("{:?}", map);
```
上面代码中，新建一个 `map` 用于保存词语出现的次数，插入一个词语时会进行判断：若之前没有插入过，则使用该词语作 `Key`，插入次数 0 作为 `Value`，若之前插入过则取出之前统计的该词语出现的次数，对其加一。
有两点值得注意：
- `or_insert` 返回了 `&mut v` 引用，因此可以通过该可变引用直接修改 `map` 中对应的值
- 使用 `count` 引用时，需要先进行解引用 `*count`，否则会出现类型不匹配
##### 3.9.2.5 哈希函数
先来设想下，如果要实现 `Key` 与 `Value` 的一一对应，是不是意味着我们要能比较两个 `Key` 的相等性？例如 "a" 和 "b"，1 和 2，当这些类型做 `Key` 且能比较时，可以很容易知道 `1` 对应的值不会错误的映射到 `2` 上，因为 `1` 不等于 `2`。因此，一个类型能否作为 `Key` 的关键就是是否能进行相等比较，或者说该类型是否实现了 `std::cmp::Eq` 特征。
> f32 和 f64 浮点数，没有实现 `std::cmp::Eq` 特征，因此不可以用作 `HashMap` 的 `Key`。

好了，理解完这个，再来设想一点，若一个复杂点的类型作为 `Key`，那怎么在底层对它进行存储，怎么使用它进行查询和比较？ 是不是很棘手？好在我们有哈希函数：通过它把 `Key` 计算后映射为哈希值，然后使用该哈希值来进行存储、查询、比较等操作。
但是问题又来了，如何保证不同 `Key` 通过哈希后的两个值不会相同？如果相同，那意味着我们使用不同的 `Key`，却查到了同一个结果，这种明显是错误的行为。 此时，就涉及到安全性跟性能的取舍了。
若要追求安全，尽可能减少冲突，同时防止拒绝服务（Denial of Service, DoS）攻击，就要使用密码学安全的哈希函数，`HashMap` 就是使用了这样的哈希函数。反之若要追求性能，就需要使用没有那么安全的算法。
###### 3.9.2.5.1 高性能三方库
因此若性能测试显示当前标准库默认的哈希函数不能满足你的性能需求，就需要去 [`crates.io`](https://crates.io) 上寻找其它的哈希函数实现，使用方法很简单：
```rust
use std::hash::BuildHasherDefault;
use std::collections::HashMap;
// 引入第三方的哈希函数
use twox_hash::XxHash64;
// 指定HashMap使用第三方的哈希函数XxHash64
let mut hash: HashMap<_, _, BuildHasherDefault<XxHash64>> = Default::default();
hash.insert(42, "the answer");
assert_eq!(hash.get(&42), Some(&"the answer"));
```

> 目前，`HashMap` 使用的哈希函数是 `SipHash`，它的性能不是很高，但是安全性很高。`SipHash` 在中等大小的 `Key` 上，性能相当不错，但是对于小型的 `Key` （例如整数）或者大型 `Key` （例如字符串）来说，性能还是不够好。若你需要极致性能，例如实现算法，可以考虑这个库：[ahash](https://github.com/tkaitchuck/ahash)。
最后，如果你想要了解 `HashMap` 更多的用法，请参见本书的标准库解析章节：[HashMap 常用方法](https://course.rs/std/hashmap.html)
### 3.10 认识生命周期
生命周期，简而言之就是<span style="background:#f500a3">引用的有效作用域</span>。
在大多数时候，我们无需手动的声明生命周期，因为编译器可以自动进行推导，用类型来类比下：
- 就像编译器大部分时候可以自动推导类型 <-> 一样，编译器大多数时候也可以自动推导生命周期
- 在多种类型存在时，编译器往往要求我们手动标明类型 <-> 当多个生命周期存在，且编译器无法推导出某个引用的生命周期时，就需要我们手动标明生命周期
#### 3.10.1 悬垂指针和生命周期
生命周期的主要作用是避免悬垂引用，它会导致程序引用了本不该引用的数据：
```rust
{
    let r;
    {
        let x = 5;
        r = &x;
    }
    println!("r: {}", r);
}
```
这段代码有几点值得注意:
- `let r;` 的声明方式貌似存在使用 `null` 的风险，实际上，当我们不初始化它就使用时，编译器会给予报错
- `r` 引用了内部花括号中的 `x` 变量，但是 `x` 会在内部花括号 `}` 处被释放，因此回到外部花括号后，`r` 会引用一个无效的 `x`
此处 `r` 就是一个悬垂指针，它引用了提前被释放的变量 `x`，可以预料到，这段代码会报错：
```console
error[E0597]: `x` does not live long enough // `x` 活得不够久
  --> src/main.rs:7:17
   |
7  |             r = &x;
   |                 ^^ borrowed value does not live long enough // 被借用的 `x` 活得不够久
8  |         }
   |         - `x` dropped here while still borrowed // `x` 在这里被丢弃，但是它依然还在被借用
9  |
10 |         println!("r: {}", r);
   |                           - borrow later used here // 对 `x` 的借用在此处被使用
```
在这里 `r` 拥有更大的作用域，或者说**活得更久**。如果 Rust 不阻止该悬垂引用的发生，那么当 `x` 被释放后，`r` 所引用的值就不再是合法的，会导致我们程序发生异常行为，且该异常行为有时候会很难被发现。
#### 3.10.2 借用检查
为了保证 Rust 的所有权和借用的正确性，Rust 使用了一个借用检查器(Borrow checker)，来检查我们程序的借用正确性：
```rust
{
    let r;                // ---------+-- 'a
    {                     //          |
        let x = 5;        // -+-- 'b  |
        r = &x;           //  |       |
    }                     // -+       |
    println!("r: {}", r); //          |
}                         // ---------+
```
这段代码和之前的一模一样，唯一的区别在于增加了对变量生命周期的注释。这里，`r` 变量被赋予了生命周期 `'a`，`x` 被赋予了生命周期 `'b`，从图示上可以明显看出生命周期 `'b` 比 `'a` 小很多。
在编译期，Rust 会比较两个变量的生命周期，结果发现 `r` 明明拥有生命周期 `'a`，但是却引用了一个小得多的生命周期 `'b`，在这种情况下，编译器会认为我们的程序存在风险，因此拒绝运行。
如果想要编译通过，也很简单，只要 `'b` 比 `'a` 大就好。总之，`x` 变量只要比 `r` 活得久，那么 `r` 就能随意引用 `x` 且不会存在危险：
```rust
{
    let x = 5;            // ----------+-- 'b
                          //           |
    let r = &x;           // --+-- 'a  |
                          //   |       |
    println!("r: {}", r); //   |       |
                          // --+       |
}                         // ----------+
```
根据之前的结论，我们重新实现了代码，现在 `x` 的生命周期 `'b` 大于 `r` 的生命周期 `'a`，因此 `r` 对 `x` 的引用是安全的。
通过之前的内容，我们了解了何为生命周期，也了解了 Rust 如何利用生命周期来确保引用是合法的，下面来看看函数中的生命周期。
##### 3.10.2.1 函数中的生命周期
先来考虑一个例子 - 返回两个字符串切片中较长的那个，该函数的参数是两个字符串切片，返回值也是字符串切片：
```rust
fn main() {
    let string1 = String::from("abcd");
    let string2 = "xyz";

    let result = longest(string1.as_str(), string2);
    println!("The longest string is {}", result);
}

fn longest(x: &str, y: &str) -> &str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
这段 `longest` 实现，非常标准优美，就连多余的 `return` 和分号都没有，可是现实总是给我们重重一击：
```console
error[E0106]: missing lifetime specifier
 --> src/main.rs:9:33
  |
9 | fn longest(x: &str, y: &str) -> &str {
  |               ----     ----     ^ expected named lifetime parameter // 参数需要一个生命周期
  |
  = help: this function's return type contains a borrowed value, but the signature does not say whether it is
  borrowed from `x` or `y`
  = 帮助： 该函数的返回值是一个引用类型，但是函数签名无法说明，该引用是借用自 `x` 还是 `y`
help: consider introducing a named lifetime parameter // 考虑引入一个生命周期
  |
9 | fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
  |           ^^^^    ^^^^^^^     ^^^^^^^     ^^^
```
主要是编译器无法知道该函数的返回值到底引用 `x` 还是 `y` ，**因为编译器需要知道这些，来确保函数调用后的引用生命周期分析**。
不过说来尴尬，就这个函数而言，我们也不知道返回值到底引用哪个，因为一个分支返回 `x`，另一个分支返回 `y`...这可咋办？先来分析下。
我们在定义该函数时，首先无法知道传递给函数的具体值，因此到底是 `if` 还是 `else` 被执行，无从得知。其次，传入引用的具体生命周期也无法知道，因此也不能像之前的例子那样通过分析生命周期来确定引用是否有效。同时，编译器的借用检查也无法推导出返回值的生命周期，因为它不知道 `x` 和 `y` 的生命周期跟返回值的生命周期之间的关系是怎样的（说实话，人都搞不清，何况编译器这个大聪明）。
因此，这时就回到了文章开头说的内容：<span style="background:#0779e4">在存在多个引用时，编译器有时会无法自动推导生命周期</span>，此时就需要我们手动去标注，通过为参数标注合适的生命周期来帮助编译器进行借用检查的分析。
#### 3.10.3 生命周期标注语法
**标记的生命周期只是为了取悦编译器，让编译器不要难为我们**
例如一个变量，只能活一个花括号，那么就算你给它标注一个活全局的生命周期，它还是会在前面的花括号结束处被释放掉，并不会真的全局存活。
生命周期的语法也颇为与众不同，以 `'` 开头，名称往往是一个单独的小写字母，大多数人都用 `'a` 来作为生命周期的名称。 如果是引用类型的参数，那么生命周期会位于引用符号 `&` 之后，并用一个空格来将生命周期和引用参数分隔开:
```rust
&i32        // 一个引用
&'a i32     // 具有显式生命周期的引用
&'a mut i32 // 具有显式生命周期的可变引用
```
一个生命周期标注，它自身并不具有什么意义，因为生命周期的作用就是告诉编译器多个引用之间的关系。例如，有一个函数，它的第一个参数 `first` 是一个指向 `i32` 类型的引用，具有生命周期 `'a`，该函数还有另一个参数 `second`，它也是指向 `i32` 类型的引用，并且同样具有生命周期 `'a`。此处生命周期标注仅仅说明，**这两个参数 `first` 和 `second` 至少活得和'a 一样久，至于到底活多久或者哪个活得更久，抱歉我们都无法得知**：
```rust
fn useless<'a>(first: &'a i32, second: &'a i32) {}
```
##### 3.10.3.1 函数签名中的生命周期标注
继续之前的 `longest` 函数，从两个字符串切片中返回较长的那个：
```rust
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
需要注意的点如下：
- 和泛型一样，使用生命周期参数，需要先声明 `<'a>`
- `x`、`y` 和返回值至少活得和 `'a` 一样久（因为返回值要么是 `x`，要么是 `y`）

该函数签名表明对于某些生命周期 `'a`，函数的两个参数都至少跟 `'a` 活得一样久，同时函数的返回引用也至少跟 `'a` 活得一样久。实际上，这意味着返回值的生命周期与参数生命周期中的较小值一致：虽然两个参数的生命周期都是标注了 `'a`，但是实际上这两个参数的真实生命周期可能是不一样的（生命周期 `'a` 不代表生命周期等于 `'a`，而是大于等于 `'a`）。
**在通过函数签名指定生命周期参数时，我们并没有改变传入引用或者返回引用的真实生命周期，而是告诉编译器当不满足此约束条件时，就拒绝编译通过**。
因此 `longest` 函数并不知道 `x` 和 `y` 具体会活多久，只要知道它们的作用域至少能持续 `'a` 这么长就行。
当把具体的引用传给 `longest` 时，那生命周期 `'a` 的大小就是 `x` 和 `y` 的作用域的重合部分，换句话说，`'a` 的大小将等于 `x` 和 `y` 中较小的那个。由于返回值的生命周期也被标记为 `'a`，因此返回值的生命周期也是 `x` 和 `y` 中作用域较小的那个。
说实话，这段文字我写的都快崩溃了，不知道你们读起来如何，实在***太绕了。。那就干脆用一个例子来解释吧：
```rust
fn main() {
    let string1 = String::from("long string is long");
    {
        let string2 = String::from("xyz");
        let result = longest(string1.as_str(), string2.as_str());
        println!("The longest string is {}", result);
    }
}
```
在上例中，`string1` 的作用域直到 `main` 函数的结束，而 `string2` 的作用域到内部花括号的结束 `}`，那么根据之前的理论，`'a` 是两者中作用域较小的那个，也就是 `'a` 的生命周期等于 `string2` 的生命周期，同理，由于函数返回的生命周期也是 '`a`，可以得出函数返回的生命周期也等于 `string2` 的生命周期。

现在来验证下上面的结论：`result` 的生命周期等于参数中生命周期最小的，因此要等于 `string2` 的生命周期，也就是说，`result` 要活得和 `string2` 一样久，观察下代码的实现，可以发现这个结论是正确的！
因此，在这种情况下，通过生命周期标注，编译器得出了和我们肉眼观察一样的结论，而不再是一个蒙圈的大聪明。
再来看一个例子，该例子证明了 `result` 的生命周期必须等于两个参数中生命周期较小的那个:
```rust
fn main() {
    let string1 = String::from("long string is long");
    let result;
    {
        let string2 = String::from("xyz");
        result = longest(string1.as_str(), string2.as_str());
    }
    println!("The longest string is {}", result);
}
```
Bang，错误冒头了：
```console
error[E0597]: `string2` does not live long enough
 --> src/main.rs:6:44
  |
6 |         result = longest(string1.as_str(), string2.as_str());
  |                                            ^^^^^^^ borrowed value does not live long enough
7 |     }
  |     - `string2` dropped here while still borrowed
8 |     println!("The longest string is {}", result);
  |                                          ------ borrow later used here
```
在上述代码中，`result` 必须要活到 `println!`处，因为 `result` 的生命周期是 `'a`，因此 `'a` 必须持续到 `println!`。
在 `longest` 函数中，`string2` 的生命周期也是 `'a`，由此说明 `string2` 也必须活到 `println!` 处，可是 `string2` 在代码中实际上只能活到内部语句块的花括号处 `}`，小于它应该具备的生命周期 `'a`，因此编译出错。
作为人类，我们可以很清晰的看出 `result` 实际上引用了 `string1`，因为 `string1` 的长度明显要比 `string2` 长，既然如此，编译器不该如此矫情才对，它应该能认识到 `result` 没有引用 `string2`，让我们这段代码通过。只能说，作为尊贵的人类，编译器的发明者，你高估了这个工具的能力，它真的做不到！而且 Rust 编译器在调教上是非常保守的：当可能出错也可能不出错时，它会选择前者，抛出编译错误。
总之，显式的使用生命周期，可以让编译器正确的认识到多个引用之间的关系，最终帮我们提前规避可能存在的代码风险。
小练习：尝试着去更改 `longest` 函数，例如修改参数、生命周期或者返回值，然后推测结果如何，最后再跟编译器的输出进行印证。
##### 3.10.3.2 深入思考生命周期标注
使用生命周期的方式往往取决于函数的功能，例如之前的 `longest` 函数，如果它永远只返回第一个参数 `x`，生命周期的标注该如何修改（该例子就是上面的小练习结果之一）?
```rust
fn longest<'a>(x: &'a str, y: &str) -> &'a str {
    x
}
```
在此例中，`y` 完全没有被使用，因此 `y` 的生命周期与 `x` 和返回值的生命周期没有任何关系，意味着我们也不必再为 `y` 标注生命周期，只需要标注 `x` 参数和返回值即可。
**函数的返回值如果是一个引用类型，那么它的生命周期只会来源于**：
- 函数参数的生命周期
- 函数体中某个新建引用的生命周期
若是后者情况，就是典型的悬垂引用场景：
```rust
fn longest<'a>(x: &str, y: &str) -> &'a str {
    let result = String::from("really long string");
    result.as_str()
}
```
上面的函数的返回值就和参数 `x`，`y` 没有任何关系，而是引用了函数体内创建的字符串，那么很显然，该函数会报错：
```console
error[E0515]: cannot return value referencing local variable `result` // 返回值result引用了本地的变量
  --> src/main.rs:11:5
   |
11 |     result.as_str()
   |     ------^^^^^^^^^
   |     |
   |     returns a value referencing data owned by the current function
   |     `result` is borrowed here
```
主要问题就在于，`result` 在函数结束后就被释放，但是在函数结束后，对 `result` 的引用依然在继续。在这种情况下，没有办法指定合适的生命周期来让编译通过，因此我们也就在 Rust 中避免了悬垂引用。
那遇到这种情况该怎么办？最好的办法就是返回内部字符串的所有权，然后把字符串的所有权转移给调用者：
```rust
fn longest<'a>(_x: &str, _y: &str) -> String {
    String::from("really long string")
}

fn main() {
   let s = longest("not", "important");
}
```
至此，可以对生命周期进行下总结：生命周期语法用来将函数的多个引用参数和返回值的作用域关联到一起，一旦关联到一起后，Rust 就拥有充分的信息来确保我们的操作是内存安全的。
#### 3.10.4 结构体中的生命周期
不仅仅函数具有生命周期，结构体其实也有这个概念，只不过我们之前对结构体的使用都停留在非引用类型字段上。细心的同学应该能回想起来，之前为什么不在结构体中使用字符串字面量或者字符串切片，而是统一使用 `String` 类型？原因很简单，后者在结构体初始化时，只要转移所有权即可，而前者，抱歉，它们是引用，它们不能为所欲为。
既然之前已经理解了生命周期，那么意味着在结构体中使用引用也变得可能：只要为结构体中的**每一个引用标注上生命周期**即可：

```rust
struct ImportantExcerpt<'a> {
    part: &'a str,
}

fn main() {
    let novel = String::from("Call me Ishmael. Some years ago...");
    let first_sentence = novel.split('.').next().expect("Could not find a '.'");
    let i = ImportantExcerpt {
        part: first_sentence,
    };
}
```
`ImportantExcerpt` 结构体中有一个引用类型的字段 `part`，因此需要为它标注上生命周期。结构体的生命周期标注语法跟泛型参数语法很像，需要对生命周期参数进行声明 `<'a>`。该生命周期标注说明，**结构体 `ImportantExcerpt` 所引用的字符串 `str` 生命周期需要大于等于该结构体的生命周期**。

从 `main` 函数实现来看，`ImportantExcerpt` 的生命周期从第 4 行开始，到 `main` 函数末尾结束，而该结构体引用的字符串从第一行开始，也是到 `main` 函数末尾结束，可以得出结论**结构体引用的字符串生命周期大于等于结构体**，这符合了编译器对生命周期的要求，因此编译通过。
与之相反，下面的代码就无法通过编译：
```rust
#[derive(Debug)]
struct ImportantExcerpt<'a> {
    part: &'a str,
}

fn main() {
    let i;
    {
        let novel = String::from("Call me Ishmael. Some years ago...");
        let first_sentence = novel.split('.').next().expect("Could not find a '.'");
        i = ImportantExcerpt {
            part: first_sentence,
        };
    }
    println!("{:?}",i);
}
```
观察代码，**可以看出结构体比它引用的字符串活得更久**，引用字符串在内部语句块末尾 `}` 被释放后，`println!` 依然在外面使用了该结构体，因此会导致无效的引用，不出所料，编译报错：
```console
error[E0597]: `novel` does not live long enough
  --> src/main.rs:10:30
   |
10 |         let first_sentence = novel.split('.').next().expect("Could not find a '.'");
   |                              ^^^^^^^^^^^^^^^^ borrowed value does not live long enough
...
14 |     }
   |     - `novel` dropped here while still borrowed
15 |     println!("{:?}",i);
   |                     - borrow later used here
```
#### 3.10.5 生命周期消除
实际上，对于编译器来说，每一个引用类型都有一个生命周期，那么为什么我们在使用过程中，很多时候无需标注生命周期？例如：
```rust
fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }

    &s[..]
}
```
该函数的参数和返回值都是引用类型，尽管我们没有显式的为其标注生命周期，编译依然可以通过。其实原因不复杂，**编译器为了简化用户的使用，运用了生命周期消除大法**。
对于 `first_word` 函数，它的返回值是一个引用类型，那么该引用只有两种情况：
- 从参数获取
- 从函数体内部新创建的变量获取
如果是后者，就会出现悬垂引用，最终被编译器拒绝，因此只剩一种情况：返回值的引用是获取自参数，这就意味着参数和返回值的生命周期是一样的。道理很简单，我们能看出来，编译器自然也能看出来，因此，就算我们不标注生命周期，也不会产生歧义。
实际上，在 Rust 1.0 版本之前，这种代码果断不给通过，因为 Rust 要求必须显式的为所有引用标注生命周期：
```rust
fn first_word<'a>(s: &'a str) -> &'a str {
```
在写了大量的类似代码后，Rust 社区抱怨声四起，包括开发者自己都忍不了了，最终揭锅而起，这才有了我们今日的幸福。
生命周期消除的规则不是一蹴而就，而是伴随着 `总结-改善` 流程的周而复始，一步一步走到今天，这也意味着，该规则以后可能也会进一步增加，我们需要手动标注生命周期的时候也会越来越少，hooray!
在开始之前有几点需要注意：
- 消除规则不是万能的，若编译器不能确定某件事是正确时，会直接判为不正确，那么你还是需要手动标注生命周期
- **函数或者方法中，参数的生命周期被称为 `输入生命周期`，返回值的生命周期被称为 `输出生命周期`**
##### 3.10.5.1 <span style="background:#f60909">三条消除规则</span>
编译器使用三条消除规则来确定哪些场景不需要显式地去标注生命周期。其中第一条规则应用在输入生命周期上，第二、三条应用在输出生命周期上。若编译器发现三条规则都不适用时，就会报错，提示你需要手动标注生命周期。
1. **每一个引用参数都会获得独自的生命周期**
    例如一个引用参数的函数就有一个生命周期标注: `fn foo<'a>(x: &'a i32)`，两个引用参数的有两个生命周期标注:`fn foo<'a, 'b>(x: &'a i32, y: &'b i32)`, 依此类推。
2. **若只有一个输入生命周期（函数参数中只有一个引用类型），那么该生命周期会被赋给所有的输出生命周期**，也就是所有返回值的生命周期都等于该输入生命周期
    例如函数 `fn foo(x: &i32) -> &i32`，`x` 参数的生命周期会被自动赋给返回值 `&i32`，因此该函数等同于 `fn foo<'a>(x: &'a i32) -> &'a i32`
3. **若存在多个输入生命周期，且其中一个是 `&self` 或 `&mut self`，则 `&self` 的生命周期被赋给所有的输出生命周期**
    拥有 `&self` 形式的参数，说明该函数是一个 `方法`，该规则让方法的使用便利度大幅提升。
规则其实很好理解，但是，爱思考的读者肯定要发问了，例如第三条规则，若一个方法，它的返回值的生命周期就是跟参数 `&self` 的不一样怎么办？总不能强迫我返回的值总是和 `&self` 活得一样久吧？! 问得好，答案很简单：手动标注生命周期，因为这些规则只是编译器发现你没有标注生命周期时默认去使用的，当你标注生命周期后，编译器自然会乖乖听你的话。
让我们假装自己是编译器，然后看下以下的函数该如何应用这些规则：
**例子 1**
```rust
fn first_word(s: &str) -> &str { // 实际项目中的手写代码
```
首先，我们手写的代码如上所示时，编译器会先应用第一条规则，为每个参数标注一个生命周期：
```rust
fn first_word<'a>(s: &'a str) -> &str { // 编译器自动为参数添加生命周期
```
此时，第二条规则就可以进行应用，因为函数只有一个输入生命周期，因此该生命周期会被赋予所有的输出生命周期：
```rust
fn first_word<'a>(s: &'a str) -> &'a str { // 编译器自动为返回值添加生命周期
```
此时，编译器为函数签名中的所有引用都自动添加了具体的生命周期，因此编译通过，且用户无需手动去标注生命周期，只要按照 `fn first_word(s: &str) -> &str {` 的形式写代码即可。
**例子 2** 再来看一个例子：
```rust
fn longest(x: &str, y: &str) -> &str { // 实际项目中的手写代码
```
首先，编译器会应用第一条规则，为每个参数都标注生命周期：
```rust
fn longest<'a, 'b>(x: &'a str, y: &'b str) -> &str {
```
但是此时，第二条规则却无法被使用，因为输入生命周期有两个，第三条规则也不符合，因为它是函数，不是方法，因此没有 `&self` 参数。在套用所有规则后，编译器依然无法为返回值标注合适的生命周期，因此，编译器就会报错，提示我们需要手动标注生命周期：
```console
error[E0106]: missing lifetime specifier
 --> src/main.rs:1:47
  |
1 | fn longest<'a, 'b>(x: &'a str, y: &'b str) -> &str {
  |                       -------     -------     ^ expected named lifetime parameter
  |
  = help: this function's return type contains a borrowed value, but the signature does not say whether it is borrowed from `x` or `y`
note: these named lifetimes are available to use
 --> src/main.rs:1:12
  |
1 | fn longest<'a, 'b>(x: &'a str, y: &'b str) -> &str {
  |            ^^  ^^
help: consider using one of the available lifetimes here
  |
1 | fn longest<'a, 'b>(x: &'a str, y: &'b str) -> &'lifetime str {
  |                                                +++++++++
```
不得不说，Rust 编译器真的很强大，还贴心的给我们提示了该如何修改，虽然……好像……。它的提示貌似不太准确。这里我们更希望参数和返回值都是 `'a` 生命周期。
#### 3.10.6 方法中的生命周期
先来回忆下泛型的语法：
```rust
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn x(&self) -> &T {
        &self.x
    }
}
```
实际上，为具有生命周期的结构体实现方法时，我们使用的语法跟泛型参数语法很相似：
```rust
struct ImportantExcerpt<'a> {
    part: &'a str,
}

impl<'a> ImportantExcerpt<'a> {
    fn level(&self) -> i32 {
        3
    }
}
```
其中有几点需要注意的：
- `impl` 中必须使用结构体的完整名称，包括 `<'a>`，因为_生命周期标注也是结构体类型的一部分_！
- 方法签名中，往往不需要标注生命周期，得益于生命周期消除的第一和第三规则
下面的例子展示了第三规则应用的场景：
```rust
impl<'a> ImportantExcerpt<'a> {
    fn announce_and_return_part(&self, announcement: &str) -> &str {
        println!("Attention please: {}", announcement);
        self.part
    }
}
```
首先，编译器应用第一规则，给予每个输入参数一个生命周期:
```rust
impl<'a> ImportantExcerpt<'a> {
    fn announce_and_return_part<'b>(&'a self, announcement: &'b str) -> &str {
        println!("Attention please: {}", announcement);
        self.part
    }
}
```
需要注意的是，编译器不知道 `announcement` 的生命周期到底多长，因此它无法简单的给予它生命周期 `'a`，而是重新声明了一个全新的生命周期 `'b`。
接着，编译器应用第三规则，将 `&self` 的生命周期赋给返回值 `&str`：
```rust
impl<'a> ImportantExcerpt<'a> {
    fn announce_and_return_part<'b>(&'a self, announcement: &'b str) -> &'a str {
        println!("Attention please: {}", announcement);
        self.part
    }
}
```
Bingo，最开始的代码，尽管我们没有给方法标注生命周期，但是在第一和第三规则的配合下，编译器依然完美的为我们亮起了绿灯。
在结束这块儿内容之前，再来做一个有趣的修改，将方法返回的生命周期改为`'b`：

```rust
impl<'a> ImportantExcerpt<'a> {
    fn announce_and_return_part<'b>(&'a self, announcement: &'b str) -> &'b str {
        println!("Attention please: {}", announcement);
        self.part
    }
}
```
此时，编译器会报错，因为编译器无法知道 `'a` 和 `'b` 的关系。 `&self` 生命周期是 `'a`，那么 `self.part` 的生命周期也是 `'a`，但是好巧不巧的是，我们手动为返回值 `self.part` 标注了生命周期 `'b`，因此编译器需要知道 `'a` 和 `'b` 的关系。
有一点很容易推理出来：由于 `&'a self` 是被引用的一方，因此引用它的 `&'b str` 必须要活得比它短，否则会出现悬垂引用。因此说明生命周期 `'b` 必须要比 `'a` 小，只要满足了这一点，编译器就不会再报错：
```rust
impl<'a: 'b, 'b> ImportantExcerpt<'a> {
    fn announce_and_return_part(&'a self, announcement: &'b str) -> &'b str {
        println!("Attention please: {}", announcement);
        self.part
    }
}
```
Bang，一个复杂的玩意儿被甩到了你面前，就问怕不怕？
就关键点稍微解释下：
- `'a: 'b`，<span style="background:#f60909">是生命周期约束语法</span>，跟泛型约束非常相似，用于说明 `'a` 必须比 `'b` 活得久
- 可以把 `'a` 和 `'b` 都在同一个地方声明（如上），或者分开声明但通过 `where 'a: 'b` 约束生命周期关系，如下：
```rust
impl<'a> ImportantExcerpt<'a> {
    fn announce_and_return_part<'b>(&'a self, announcement: &'b str) -> &'b str
    where
        'a: 'b,
    {
        println!("Attention please: {}", announcement);
        self.part
    }
}
```
总之，实现方法比想象中简单：加一个约束，就能暗示编译器，尽管引用吧，反正我想引用的内容比我活得久，爱咋咋地，我怎么都不会引用到无效的内容！
#### 3.10.7 静态生命周期
在 Rust 中有一个非常特殊的生命周期，那就是 `'static`，拥有该生命周期的引用可以和整个程序活得一样久。
在之前我们学过字符串字面量，提到过它是被硬编码进 Rust 的二进制文件中，因此这些字符串变量全部具有 `'static` 的生命周期：
```rust
let s: &'static str = "我没啥优点，就是活得久，嘿嘿";
```
但是问题来了：本来该引用没有活那么久，但是你非要说它活那么久，万一引入了潜在的 BUG 怎么办？
遇到因为生命周期导致的编译不通过问题，首先想的应该是：是否是我们试图创建一个悬垂引用，或者是试图匹配不一致的生命周期，而不是简单粗暴的用 `'static` 来解决问题。
但是，话说回来，存在即合理，有时候，`'static` 确实可以帮助我们解决非常复杂的生命周期问题甚至是无法被手动解决的生命周期问题，那么此时就应该放心大胆的用，只要你确定：**你的所有引用的生命周期都是正确的，只是编译器太笨不懂罢了**。
- 生命周期 `'static` 意味着能和程序活得一样久，例如字符串字面量和特征对象
- 实在遇到解决不了的生命周期标注问题，可以尝试 `T: 'static`，有时候它会给你奇迹
> 事实上，关于 `'static`, 有两种用法: `&'static` 和 `T: 'static`，详细内容请参见[此处](https://course.rs/advance/lifetime/static.html)。
#### 3.10.8 一个复杂例子: 泛型、特征约束
```rust
use std::fmt::Display;

fn longest_with_an_announcement<'a, T>(
    x: &'a str,
    y: &'a str,
    ann: T,
) -> &'a str
where
    T: Display,
{
    println!("Announcement! {}", ann);
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
依然是熟悉的配方 `longest`，但是多了一段废话： `ann`，因为要用格式化 `{}` 来输出 `ann`，因此需要它实现 `Display` 特征。

### 3.11 返回值和错误处理
错误对于软件来说是不可避免的，因此一门优秀的编程语言必须有其完整的错误处理哲学。在很多情况下，Rust 需要你承认自己的代码可能会出错，并提前采取行动，来处理这些错误。
Rust 中的错误主要分为两类：
- **可恢复错误**，通常用于从系统全局角度来看可以接受的错误，例如处理用户的访问、操作等错误，这些错误只会影响某个用户自身的操作进程，而不会对系统的全局稳定性产生影响
- **不可恢复错误**，刚好相反，该错误通常是全局性或者系统性的错误，例如数组越界访问，系统启动时发生了影响启动流程的错误等等，这些错误的影响往往对于系统来说是致命的
很多编程语言，并不会区分这些错误，而是直接采用异常的方式去处理。Rust 没有异常，但是 Rust 也有自己的卧龙凤雏：`Result<T, E>` 用于可恢复错误，`panic!` 用于不可恢复错误。
#### 3.11.1 panic 深入剖析
##### 3.11.1.1 panic! 与不可恢复错误
上面的问题在真实场景会经常遇到，其实处理起来挺复杂的，让我们先做一个假设：文件读取操作发生在系统启动阶段。那么可以轻易得出一个结论，一旦文件读取失败，那么系统启动也将失败，这意味着该失败是不可恢复的错误，无论是因为文件不存在还是操作系统硬盘的问题，这些只是错误的原因不同，但是归根到底都是不可恢复的错误（梳理清楚当前场景的错误类型非常重要）。
对于这些严重到影响程序运行的错误，触发 `panic` 是很好的解决方式。在 Rust 中触发 `panic` 有两种方式：被动触发和主动调用，下面依次来看看。
###### 3.11.1.1.1 被动触发
```rust
fn main() {
    let v = vec![1, 2, 3];

    v[99]; //严重的错误 —— 数组访问越界
}
```
###### 3.11.1.1.2 主动调用
某些特殊场景中，开发者想要主动抛出一个异常，例如开头提到的在系统启动阶段读取文件失败。
对此，Rust 为我们提供了 `panic!` 宏，当调用执行该宏时，**程序会打印出一个错误信息，展开报错点往前的函数调用堆栈，最后退出程序**。
> 切记，一定是不可恢复的错误，才调用 `panic!` 处理，你总不想系统仅仅因为用户随便传入一个非法参数就崩溃吧？所以，**只有当你不知道该如何处理时，再去调用 panic!**.

首先，来调用一下 `panic!`，这里使用了最简单的代码实现，实际上你在程序的任何地方都可以这样调用：
```rust
fn main() {
    panic!("crash and burn");
}
运行后输出:
thread 'main' panicked at 'crash and burn', src/main.rs:2:5
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
以上信息包含了两条重要信息：
- `main` 函数所在的线程崩溃了，发生的代码位置是 `src/main.rs` 中的第 2 行第 5 个字符（包含该行前面的空字符）
- 在使用时加上一个环境变量可以获取更详细的栈展开信息：
    - Linux/macOS 等 UNIX 系统： `RUST_BACKTRACE=1 cargo run`
    - Windows 系统（PowerShell）： `$env:RUST_BACKTRACE=1 ; cargo run`
##### 3.11.1.2 backtrace 栈展开
在真实场景中，错误往往涉及到很长的调用链甚至会深入第三方库，如果没有栈展开技术，错误将难以跟踪处理，下面我们来看一个真实的崩溃例子：
```rust
fn main() {
    let v = vec![1, 2, 3];
    v[99];
}
```
上面的代码很简单，数组只有 `3` 个元素，我们却尝试去访问它的第 `100` 号元素（数组索引从 `0` 开始），那自然会崩溃。
```console
thread 'main' panicked at 'index out of bounds: the len is 3 but the index is 99', src/main.rs:4:5
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
好的，现在成功知道问题发生的位置，但是如果我们想知道该问题之前经过了哪些调用环节，该怎么办？那就按照提示使用 `RUST_BACKTRACE=1 cargo run` 或 `$env:RUST_BACKTRACE=1 ; cargo run` 来再一次运行程序：
```console
thread 'main' panicked at 'index out of bounds: the len is 3 but the index is 99', src/main.rs:4:5
stack backtrace:
   0: rust_begin_unwind
             at /rustc/59eed8a2aac0230a8b53e89d4e99d55912ba6b35/library/std/src/panicking.rs:517:5
   1: core::panicking::panic_fmt
             at /rustc/59eed8a2aac0230a8b53e89d4e99d55912ba6b35/library/core/src/panicking.rs:101:14
   2: core::panicking::panic_bounds_check
             at /rustc/59eed8a2aac0230a8b53e89d4e99d55912ba6b35/library/core/src/panicking.rs:77:5
   3: <usize as core::slice::index::SliceIndex<[T]>>::index
             at /rustc/59eed8a2aac0230a8b53e89d4e99d55912ba6b35/library/core/src/slice/index.rs:184:10
   4: core::slice::index::<impl core::ops::index::Index<I> for [T]>::index
             at /rustc/59eed8a2aac0230a8b53e89d4e99d55912ba6b35/library/core/src/slice/index.rs:15:9
   5: <alloc::vec::Vec<T,A> as core::ops::index::Index<I>>::index
             at /rustc/59eed8a2aac0230a8b53e89d4e99d55912ba6b35/library/alloc/src/vec/mod.rs:2465:9
   6: world_hello::main
             at ./src/main.rs:4:5
   7: core::ops::function::FnOnce::call_once
             at /rustc/59eed8a2aac0230a8b53e89d4e99d55912ba6b35/library/core/src/ops/function.rs:227:5
note: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.
```
上面的代码就是一次栈展开（也称栈回溯），它包含了函数调用的顺序，当然按照逆序排列：最近调用的函数排在列表的最上方。因为咱们的 `main` 函数基本是最先调用的函数了，所以排在了倒数第二位，还有一个关注点，排在最顶部最后一个调用的函数是 `rust_begin_unwind`，该函数的目的就是进行栈展开，呈现这些列表信息给我们。
要获取到栈回溯信息，你还需要开启 `debug` 标志，该标志在使用 `cargo run` 或者 `cargo build` 时自动开启（这两个操作默认是 `Debug` 运行方式）。同时，栈展开信息在不同操作系统或者 Rust 版本上也有所不同。
##### 3.11.1.3 panic 时的两种终止方式
当出现 `panic!` 时，程序提供了两种方式来处理终止流程：**栈展开**和**直接终止**。
其中，默认的方式就是 `栈展开`，这意味着 Rust 会回溯栈上数据和函数调用，因此也意味着更多的善后工作，好处是可以给出充分的报错信息和栈调用信息，便于事后的问题复盘。`直接终止`，顾名思义，不清理数据就直接退出程序，善后工作交与操作系统来负责。
对于绝大多数用户，使用默认选择是最好的，但是当你关心最终编译出的二进制可执行文件大小时，那么可以尝试去使用直接终止的方式，例如下面的配置修改 `Cargo.toml` 文件，实现在 [`release`](https://course.rs/first-try/cargo.html#%E6%89%8B%E5%8A%A8%E7%BC%96%E8%AF%91%E5%92%8C%E8%BF%90%E8%A1%8C%E9%A1%B9%E7%9B%AE) 模式下遇到 `panic` 直接终止：
```rust
[profile.release]
panic = 'abort'
```
##### 3.11.1.4 线程 panic 后，程序是否会终止？
长话短说，如果是 `main` 线程，则程序会终止，如果是其它子线程，该线程会终止，但是不会影响 `main` 线程。因此，尽量不要在 `main` 线程中做太多任务，将这些任务交由子线程去做，就算子线程 `panic` 也不会导致整个程序的结束。
##### 3.11.1.5 何时该使用 panic!
下面让我们大概罗列下何时适合使用 `panic`，也许经过之前的学习，你已经能够对 `panic` 的使用有了自己的看法，但是我们还是会罗列一些常见的用法来加深你的理解。
先来一点背景知识，在前面章节我们粗略讲过 `Result<T, E>` 这个枚举类型，它是用来表示函数的返回结果：
```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```
当没有错误发生时，函数返回一个用 `Result` 类型包裹的值 `Ok(T)`，当错误时，返回一个 `Err(E)`。对于 `Result` 返回我们有很多处理方法，最简单粗暴的就是 `unwrap` 和 `expect`，这两个函数非常类似，我们以 `unwrap` 举例：
```rust
use std::net::IpAddr;
let home: IpAddr = "127.0.0.1".parse().unwrap();
```
上面的 `parse` 方法试图将字符串 `"127.0.0.1"` 解析为一个 IP 地址类型 `IpAddr`，它返回一个 `Result<IpAddr, E>` 类型，如果解析成功，则把 `Ok(IpAddr)` 中的值赋给 `home`，如果失败，则不处理 `Err(E)`，而是直接 `panic`。
因此 `unwrap` 简而言之：成功则返回值，失败则 `panic`，总之不进行任何错误处理。
###### 3.11.1.5.1 示例、原型、测试
这几个场景下，需要快速地搭建代码，错误处理会拖慢编码的速度，也不是特别有必要，因此通过 `unwrap`、`expect` 等方法来处理是最快的。
同时，当我们回头准备做错误处理时，可以全局搜索这些方法，不遗漏地进行替换。
###### 3.11.1.5.2 你确切的知道你的程序是正确时，可以使用 panic
因为 `panic` 的触发方式比错误处理要简单，因此可以让代码更清晰，可读性也更加好，当我们的代码注定是正确时，你可以用 `unwrap` 等方法直接进行处理，反正也不可能 `panic` ：
```rust
use std::net::IpAddr;
let home: IpAddr = "127.0.0.1".parse().unwrap();
```
例如上面的例子，`"127.0.0.1"` 就是 `ip` 地址，因此我们知道 `parse` 方法一定会成功，那么就可以直接用 `unwrap` 方法进行处理。
当然，如果该字符串是来自于用户输入，那在实际项目中，就必须用错误处理的方式，而不是 `unwrap`，否则你的程序一天要崩溃几十万次吧！
###### 3.11.1.5.3 可能导致全局有害状态时
有害状态大概分为几类：
- 非预期的错误
- 后续代码的运行会受到显著影响
- 内存安全的问题
当错误预期会出现时，返回一个错误较为合适，例如解析器接收到格式错误的数据，HTTP 请求接收到错误的参数甚至该请求内的任何错误（不会导致整个程序有问题，只影响该次请求）。**因为错误是可预期的，因此也是可以处理的**。
当启动时某个流程发生了错误，对后续代码的运行造成了影响，那么就应该使用 `panic`，而不是处理错误后继续运行，当然你可以通过重试的方式来继续。
上面提到过，数组访问越界，就要 `panic` 的原因，这个就是属于内存安全的范畴，一旦内存访问不安全，那么我们就无法保证自己的程序会怎么运行下去，也无法保证逻辑和数据的正确性。
##### 3.11.1.6 panic 原理剖析
当调用 `panic!` 宏时，它会
1. 格式化 `panic` 信息，然后使用该信息作为参数，调用 `std::panic::panic_any()` 函数
2. `panic_any` 会检查应用是否使用了 [`panic hook`](https://doc.rust-lang.org/std/panic/fn.set_hook.html)，如果使用了，该 `hook` 函数就会被调用（`hook` 是一个钩子函数，是外部代码设置的，用于在 `panic` 触发时，执行外部代码所需的功能）
3. 当 `hook` 函数返回后，当前的线程就开始进行栈展开：从 `panic_any` 开始，如果寄存器或者栈因为某些原因信息错乱了，那很可能该展开会发生异常，最终线程会直接停止，展开也无法继续进行
4. 展开的过程是一帧一帧的去回溯整个栈，每个帧的数据都会随之被丢弃，但是在展开过程中，你可能会遇到被用户标记为 `catching` 的帧（通过 `std::panic::catch_unwind()` 函数标记），此时用户提供的 `catch` 函数会被调用，展开也随之停止：当然，如果 `catch` 选择在内部调用 `std::panic::resume_unwind()` 函数，则展开还会继续。
还有一种情况，在展开过程中，如果展开本身 `panic` 了，那展开线程会终止，展开也随之停止。
一旦线程展开被终止或者完成，最终的输出结果是取决于哪个线程 `panic`：对于 `main` 线程，操作系统提供的终止功能 `core::intrinsics::abort()` 会被调用，最终结束当前的 `panic` 进程；如果是其它子线程，那么子线程就会简单的终止，同时信息会在稍后通过 `std::thread::join()` 进行收集。
#### 3.11.2 返回result 和?
##### 3.11.2.1 可恢复的错误 Result
假设，我们有一台消息服务器，每个用户都通过 websocket 连接到该服务器来接收和发送消息，该过程就涉及到 socket 文件的读写，那么此时，如果一个用户的读写发生了错误，显然不能直接 `panic`，否则服务器会直接崩溃，所有用户都会断开连接，因此我们需要一种更温和的错误处理方式：`Result<T, E>`。
之前章节有提到过，`Result<T, E>` 是一个枚举类型，定义如下：
```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```
泛型参数 `T` 代表成功时存入的正确值的类型，存放方式是 `Ok(T)`，`E` 代表错误时存入的错误值，存放方式是 `Err(E)`，枯燥的讲解永远不及代码生动准确，因此先来看下打开文件的例子：
```rust
use std::fs::File;
fn main() {
    let f = File::open("hello.txt");
}
```
以上 `File::open` 返回一个 `Result` 类型，那么问题来了：

如何获知变量类型或者函数的返回类型:> 有几种常用的方式，此处更推荐第二种方法：

 - 第一种是查询标准库或者三方库文档，搜索 `File`，然后找到它的 `open` 方法
 - 在 [Rust IDE](https://course.rs/first-try/editor.html) 章节，我们推荐了 `VSCode` IDE 和 `rust-analyzer` 插件，如果你成功安装的话，那么就可以在 `VSCode` 中很方便的通过代码跳转的方式查看代码，同时 `rust-analyzer` 插件还会对代码中的类型进行标注，非常方便好用！
 - 你还可以尝试故意标记一个错误的类型，然后让编译器告诉你：
```rust
let f: u32 = File::open("hello.txt");
error[E0308]: mismatched types
 --> src/main.rs:4:18
  |
4 |     let f: u32 = File::open("hello.txt");
  |                  ^^^^^^^^^^^^^^^^^^^^^^^ expected u32, found enum
`std::result::Result`
  |
  = note: expected type `u32`
             found type `std::result::Result<std::fs::File, std::io::Error>`
```
上面代码，故意将 `f` 类型标记成整形，编译器立刻不乐意了，你是在忽悠我吗？打开文件操作返回一个整形？来，大哥来告诉你返回什么：`std::result::Result<std::fs::File, std::io::Error>`，我的天呐，怎么这么长的类型！
别慌，其实很简单，首先 `Result` 本身是定义在 `std::result` 中的，但是因为 `Result` 很常用，所以就被包含在了 [`prelude`](https://course.rs/appendix/prelude.html) 中（将常用的东东提前引入到当前作用域内），因此无需手动引入 `std::result::Result`，那么返回类型可以简化为 `Result<std::fs::File,std::io::Error>`，你看看是不是很像标准的 `Result<T, E>` 枚举定义？只不过 `T` 被替换成了具体的类型 `std::fs::File`，是一个文件句柄类型，`E` 被替换成 `std::io::Error`，是一个 IO 错误类型。
这个返回值类型说明 `File::open` 调用如果成功则返回一个可以进行读写的文件句柄，如果失败，则返回一个 IO 错误：文件不存在或者没有访问文件的权限等。总之 `File::open` 需要一个方式告知调用者是成功还是失败，并同时返回具体的文件句柄（成功）或错误信息（失败），万幸的是，这些信息可以通过 `Result` 枚举提供：
```rust
use std::fs::File;

fn main() {
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => {
            panic!("Problem opening the file: {:?}", error)
        },
    };
}
```
代码很清晰，对打开文件后的 `Result<T, E>` 类型进行匹配取值，如果是成功，则将 `Ok(file)` 中存放的的文件句柄 `file` 赋值给 `f`，如果失败，则将 `Err(error)` 中存放的错误信息 `error` 使用 `panic` 抛出来，进而结束程序，这非常符合上文提到过的 `panic` 使用场景。
##### 3.11.2.2 对返回的错误进行处理
直接 `panic` 还是过于粗暴，因为实际上 IO 的错误有很多种，我们需要对部分错误进行特殊处理，而不是所有错误都直接崩溃：
```rust
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("hello.txt") {
                Ok(fc) => fc,
                Err(e) => panic!("Problem creating the file: {:?}", e),
            },
            other_error => panic!("Problem opening the file: {:?}", other_error),
        },
    };
}
```
上面代码在匹配出 `error` 后，又对 `error` 进行了详细的匹配解析，最终结果：
- 如果是文件不存在错误 `ErrorKind::NotFound`，就创建文件，这里创建文件`File::create` 也是返回 `Result`，因此继续用 `match` 对其结果进行处理：创建成功，将新的文件句柄赋值给 `f`，如果失败，则 `panic`
- 剩下的错误，一律 `panic`
虽然很清晰，但是代码还是有些啰嗦，我们会在[简化错误处理](https://course.rs/advance/errors.html)一章重点讲述如何写出更优雅的错误。
##### 3.11.2.3 失败就 panic: unwrap 和 expect
不想使用 `match` 去匹配 `Result<T, E>` 以获取其中的 `T` 值，因为 `match` 的穷尽匹配特性，你总要去处理下 `Err` 分支。那么有没有办法简化这个过程？有，答案就是<span style="background:red"> `unwrap` 和 `expect`。</span>
###### 3.11.2.3.1 unwrap
如果返回成功，就将 `Ok(T)` 中的值取出来，如果失败，就直接 `panic`
```rust
use std::fs::File;
fn main() {
    let f = File::open("hello.txt").unwrap();
}
```
如果调用这段代码时 _hello.txt_ 文件不存在，那么 `unwrap` 就将直接 `panic`：
```console
thread 'main' panicked at 'called `Result::unwrap()` on an `Err` value: Os { code: 2, kind: NotFound, message: "No such file or directory" }', src/main.rs:4:37
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
###### 3.11.2.3.2 expect
`expect` 跟 `unwrap` 很像，也是遇到错误直接 `panic`, 但是会带上自定义的错误提示信息，相当于重载了错误打印的函数：
```rust
use std::fs::File;
fn main() {
    let f = File::open("hello.txt").expect("Failed to open hello.txt");
}
```
报错如下：
```console
thread 'main' panicked at 'Failed to open hello.txt: Os { code: 2, kind: NotFound, message: "No such file or directory" }', src/main.rs:4:37
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
可以看出<font color=#C32E94>，`expect` 相比 `unwrap` 能提供更精确的错误信息</font>，在有些场景也会更加实用。
##### 3.11.2.4 传播错误
咱们的程序几乎不太可能只有 `A->B` 形式的函数调用，一个设计良好的程序，一个功能涉及十几层的函数调用都有可能。而错误处理也往往不是哪里调用出错，就在哪里处理，实际应用中，大概率会把错误层层上传然后交给调用链的上游函数进行处理，错误传播将极为常见。
例如以下函数从文件中读取用户名，然后将结果进行返回：
```rust
use std::fs::File;
use std::io::{self, Read};
fn read_username_from_file() -> Result<String, io::Error> {
    // 打开文件，f是`Result<文件句柄,io::Error>`
    let f = File::open("hello.txt");
    let mut f = match f {
        // 打开文件成功，将file句柄赋值给f
        Ok(file) => file,
        // 打开文件失败，将错误返回(向上传播)
        Err(e) => return Err(e),
    };
    // 创建动态字符串s
    let mut s = String::new();
    // 从f文件句柄读取数据并写入s中
    match f.read_to_string(&mut s) {
        // 读取成功，返回Ok封装的字符串
        Ok(_) => Ok(s),
        // 将错误向上传播
        Err(e) => Err(e),
    }
}
```
- 该函数返回一个 `Result<String, io::Error>` 类型，当读取用户名成功时，返回 `Ok(String)`，失败时，返回 `Err(io:Error)`
- `File::open` 和 `f.read_to_string` 返回的 `Result<T, E>` 中的 `E` 就是 `io::Error`
由此可见，该函数将 `io::Error` 的错误往上进行传播，该函数的调用者最终会对 `Result<String,io::Error>` 进行再处理，至于怎么处理就是调用者的事，如果是错误，它可以选择继续向上传播错误，也可以直接 `panic`，亦或将具体的错误原因包装后写入 socket 中呈现给终端用户。
但是上面的代码也有自己的问题，那就是太长了（优秀的程序员身上的优点极多，其中最大的优点就是_懒_），我自认为也有那么一点点优秀，因此见不得这么啰嗦的代码，下面咱们来讲讲如何简化它。
###### 3.11.2.4.1 传播界的大明星: ?
```rust
use std::fs::File;
use std::io;
use std::io::Read;

fn read_username_from_file() -> Result<String, io::Error> {
    let mut f = File::open("hello.txt")?;
    let mut s = String::new();
    f.read_to_string(&mut s)?;
    Ok(s)
}
```
相比前面的 `match` 处理错误的函数，代码直接减少了一半不止，但是，一山更比一山难，看不懂啊！
其实 `?` 就是一个宏，它的作用跟上面的 `match` 几乎一模一样：
```rust
let mut f = match f {
    // 打开文件成功，将file句柄赋值给f
    Ok(file) => file,
    // 打开文件失败，将错误返回(向上传播)
    Err(e) => return Err(e),
};
```
如果结果是 `Ok(T)`，则把 `T` 赋值给 `f`，如果结果是 `Err(E)`，则返回该错误，所以 `?` 特别适合用来传播错误
<span style="background:#f60909">虽然 `?` 和 `match` 功能一致，但是事实上 `?` 会更胜一筹</span>
想象一下，一个设计良好的系统中，肯定有自定义的错误特征，错误之间很可能会存在上下级关系，例如标准库中的 `std::io::Error` 和 `std::error::Error`，前者是 IO 相关的错误结构体，后者是一个最最通用的标准错误特征，同时前者实现了后者，因此 `std::io::Error` 可以转换为 `std:error::Error`。
1. 可以<font color=#F36208>自动进行类型提升（转换）</font>：
```rust
fn open_file() -> Result<File, Box<dyn std::error::Error>> {
    let mut f = File::open("hello.txt")?;
    Ok(f)
}
```
上面代码中 `File::open` 报错时返回的错误是 `std::io::Error` 类型，但是 `open_file` 函数返回的错误类型是 `std::error::Error` 的特征对象，可以看到一个错误类型通过 `?` 返回后，变成了另一个错误类型，这就是 `?` 的神奇之处。
根本原因是在于标准库中定义的 `From` 特征，该特征有一个方法 `from`，用于把一个类型转成另外一个类型，
2. `?` 可以自动调用`From`方法，然后进行隐式类型转换。因此只要函数返回的错误 `ReturnError` 实现了 `From<OtherError>` 特征，那么 `?` 就会自动把 `OtherError` 转换为 `ReturnError`。
这种转换非常好用，意味着你可以用一个大而全的 `ReturnError` 来覆盖所有错误类型，只需要为各种子错误类型实现这种转换即可。
强中自有强中手，一码更比一码短：
```rust
use std::fs::File;
use std::io;
use std::io::Read;

fn read_username_from_file() -> Result<String, io::Error> {
    let mut s = String::new();
    File::open("hello.txt")?.read_to_string(&mut s)?;
    Ok(s)   }
```
3. `?` 还能实现链式调用，`File::open` 遇到错误就返回，没有错误就将 `Ok` 中的值取出来用于下一个方法调用，简直太精妙了
```rust
use std::fs;
use std::io;

fn read_username_from_file() -> Result<String, io::Error> {
    // read_to_string是定义在std::io中的方法，因此需要在上面进行引用
    fs::read_to_string("hello.txt")
}
```
从文件读取数据到字符串中，是比较常见的操作，因此 Rust 标准库为我们提供了 `fs::read_to_string` 函数，该函数内部会打开一个文件、创建 `String`、读取文件内容最后写入字符串并返回，因为该函数其实与本章讲的内容关系不大，因此放在最后来讲，其实只是我想震你们一下 :)
###### 3.11.2.4.2 ? 用于 Option 的返回
`?` 用于 `Option` 的传播
`Result` 通过 `?` 返回错误，那么 `Option` 就通过 `?` 返回 `None`：
```rust
fn first(arr: &[i32]) -> Option<&i32> {
   let v = arr.get(0)?;
   Some(v)   }
```
上面的函数中，`arr.get` 返回一个 `Option<&i32>` 类型，因为 `?` 的使用，如果 `get` 的结果是 `None`，则直接返回 `None`，如果是 `Some(&i32)`，则把里面的值赋给 `v`。
其实这个函数有些画蛇添足，我们完全可以写出更简单的版本：
```rust
fn first(arr: &[i32]) -> Option<&i32> {
   arr.get(0)
}
```
```rust
fn last_char_of_first_line(text: &str) -> Option<char> {
    text.lines().next()?.chars().last()  // 在链式调用中使用 `?` 提前返回 `None` 的用法， `.next` 方法返回的是 `Option` 类型：如果返回 `Some(&str)`，那么继续调用 `chars` 方法，如果返回 `None`，则直接从整个函数中返回 `None`，不再继续进行链式调用。
}
```
###### 3.11.2.4.3 新手用 ? 常会犯的错误
在了解了 `?` 的使用限制后，这段代码你很容易看出它无法编译：
```rust
use std::fs::File;
fn main() {
    let f = File::open("hello.txt")?;  // 因为 `?` 要求 `Result<T, E>` 形式的返回值，而 `main` 函数的返回是 `()`，因此无法满足，那是不是就无解了呢？
}
```
实际上 Rust 还支持另外一种形式的 `main` 函数：
```rust
use std::error::Error;
use std::fs::File;

fn main() -> Result<(), Box<dyn Error>> {
    let f = File::open("hello.txt")?;
    Ok(())
}
```
这样就能使用 `?` 提前返回了，同时我们又一次看到了`Box<dyn Error>` 特征对象，因为 `std::error:Error` 是 Rust 中抽象层次最高的错误，其它标准库中的错误都实现了该特征，因此我们可以用该特征对象代表一切错误，就算 `main` 函数中调用任何标准库函数发生错误，都可以通过 `Box<dyn Error>` 这个特征对象进行返回。
至于 `main` 函数可以有多种返回值，那是因为实现了 [std::process::Termination](https://doc.rust-lang.org/std/process/trait.Termination.html) 特征，目前为止该特征还没进入稳定版 Rust 中，也许未来你可以为自己的类型实现该特征！
###### 3.11.2.4.4 try!
在 `?` 横空出世之前( Rust 1.13 )，Rust 开发者还可以使用 `try!` 来处理错误，该宏的大致定义如下：
```rust
macro_rules! try {
    ($e:expr) => (match $e {
        Ok(val) => val,
        Err(err) => return Err(::std::convert::From::from(err)),
    });
}
```
<font color=#C32E94>简单看一下与 `?` 的对比:</font>
```rust
//  `?`
let x = function_with_error()?; // 若返回 Err, 则立刻返回；若返回 Ok(255)，则将 x 的值设置为 255
// `try!()`
let x = try!(function_with_error());
```
可以看出 `?` 的优势非常明显，何况 `?` 还能做链式调用。
总之，`try!` 作为前浪已经死在了沙滩上，**在当前版本中，我们要尽量避免使用 try!**。
### 3.12 包和模块
将大的代码文件拆分成包和模块，还允许我们实现代码抽象和复用：将你的代码封装好后提供给用户，那么用户只需要调用公共接口即可，无需知道内部该如何实现。
#### 3.12.1 包 crate
##### 3.12.1.1 包和 Package
- **项目(Package)**：可以用来构建、测试和分享包
- **工作空间(WorkSpace)**：对于大型项目，可以进一步将多个包联合在一起，组织成工作空间
- **包(Crate)**：一个由多个模块组成的树形结构，可以作为三方库进行分发，也可以生成可执行文件进行运行
- **模块(Module)**：可以一个文件多个模块，也可以一个文件一个模块，模块可以被认为是真实项目中的代码组织单元
###### 3.12.1.1.1 定义
- 包 Crate: 
	- 包是一个独立的可编译单元，它编译后会生成一个可执行文件或者一个库。
	- 一个包会将相关联的功能打包在一起，使得该功能可以很方便的在多个项目中分享。
	- 同一个包中不能有同名的类型，但是在不同包中就可以。
- 项目 Package
	- 项目，你也可以理解为工程、软件包
	- `Package` 就是一个项目，因此它包含有独立的 `Cargo.toml` 文件，以及因为功能性被组织在一起的一个或多个包。一个 `Package` 只能包含**一个**库(library)类型的包，但是可以包含**多个**二进制可执行类型的包。<span style="background:#0779e4">  库类型的 `Package` 只能作为三方库被其它项目引用，而不能独立运行，只有之前的二进制 `Package` 才可以运行</span>
	1. 二进制 Package:  cargo new my-project
	2. 库 Package:   cargo new my-lib --lib
##### 3.12.1.2 典型的 Package 结构
上面创建的 `Package` 中仅包含 `src/main.rs` 文件，意味着它仅包含一个二进制同名包 `my-project`。如果一个 `Package` 同时拥有 `src/main.rs` 和 `src/lib.rs`，那就意味着它包含两个包：库包和二进制包，这两个包名也都是 `my-project` —— 都与 `Package` 同名。
一个真实项目中典型的 `Package`，会包含多个二进制包，这些包文件被放在 `src/bin` 目录下，每一个文件都是独立的二进制包，同时也会包含一个库包，该包只能存在一个 `src/lib.rs`：
```css
.
├── Cargo.toml
├── Cargo.lock
├── src
│   ├── main.rs
│   ├── lib.rs
│   └── bin
│       └── main1.rs
│       └── main2.rs
├── tests
│   └── some_integration_tests.rs
├── benches
│   └── simple_bench.rs
└── examples
    └── simple_example.rs
```

- 唯一库包：`src/lib.rs`
- 默认二进制包：`src/main.rs`，编译后生成的可执行文件与 `Package` 同名
- 其余二进制包：`src/bin/main1.rs` 和 `src/bin/main2.rs`，它们会分别生成一个文件同名的二进制可执行文件
- 集成测试文件：`tests` 目录下
- 基准性能测试 `benchmark` 文件：`benches` 目录下
- 项目示例：`examples` 目录下
这种目录结构基本上是 Rust 的标准目录结构
#### 3.12.2 模块 Module
Rust 的代码构成单元：模块。使用模块可以将包中的代码按照功能性进行重组，最终实现更好的可读性及易用性。同时，我们还能非常灵活地去控制代码的可见性，进一步强化 Rust 的安全性。
##### 3.12.2.1 创建嵌套模块
`cargo new --lib restaurant` 创建一个小餐馆，注意，这里创建的是一个库类型的 `Package`，然后将以下代码放入 `src/lib.rs` 中：
```rust
// 餐厅前厅，用于吃饭
mod front_of_house {
    mod hosting {
        fn add_to_waitlist() {}

        fn seat_at_table() {}
    }

    mod serving {
        fn take_order() {}

        fn serve_order() {}

        fn take_payment() {}
    }
}
```
以上的代码创建了三个模块，有几点需要注意的：
- 使用 `mod` 关键字来创建新模块，后面紧跟着模块名称
- 模块可以嵌套，这里嵌套的原因是招待客人和服务都发生在前厅，因此我们的代码模拟了真实场景
- 模块中可以定义各种 Rust 类型，例如函数、结构体、枚举、特征等
- 所有模块均定义在同一个文件中
类似上述代码中所做的，使用模块，我们就能将功能相关的代码组织到一起，然后通过一个模块名称来说明这些代码为何被组织在一起。这样其它程序员在使用你的模块时，就可以更快地理解和上手。
##### 3.12.2.2 模块树
`src/main.rs` 和 `src/lib.rs` 被称为包根(crate root)，这个奇葩名称的来源（我不想承认是自己翻译水平太烂-,-）是由于这两个文件的内容形成了一个模块 `crate`，该模块位于包的树形结构（由模块组成的树形结构）的根部：
```console
crate
 └── front_of_house
     ├── hosting
     │   ├── add_to_waitlist
     │   └── seat_at_table
     └── serving
         ├── take_order
         ├── serve_order
         └── take_payment
```
这颗树展示了模块之间**彼此的嵌套**关系，因此被称为**模块树**。其中 `crate` 包根是 `src/lib.rs` 文件，包根文件中的三个模块分别形成了模块树的剩余部分。
###### 3.12.2.2.1 父子模块
如果模块 `A` 包含模块 `B`，那么 `A` 是 `B` 的父模块，`B` 是 `A` 的子模块。在上例中，`front_of_house` 是 `hosting` 和 `serving` 的父模块，反之，后两者是前者的子模块。
##### 3.12.2.3 用路径引用模块
想要调用一个函数，就需要知道它的路径，在 Rust 中，这种路径有两种形式：
- **绝对路径**，从包根开始，路径名以包名或者 `crate` 作为开头
- **相对路径**，从当前模块开始，以 `self`，`super` 或当前模块的标识符作为开头
```rust
mod front_of_house {
    mod hosting {
        fn add_to_waitlist() {}
    }
}
pub fn eat_at_restaurant() {
    // 绝对路径
    crate::front_of_house::hosting::add_to_waitlist();
    // 相对路径
    front_of_house::hosting::add_to_waitlist();
}
```
###### 3.12.2.3.1 绝对路径引用
因为 `eat_at_restaurant` 和 `add_to_waitlist` 都定义在一个包中，因此在绝对路径引用时，可以直接以 `crate` 开头，然后逐层引用，每一层之间使用 `::` 分隔：
```rust
crate::front_of_house::hosting::add_to_waitlist();
crate
 └── eat_at_restaurant
 └── front_of_house
     ├── hosting
     │   ├── add_to_waitlist
     │   └── seat_at_table
     └── serving
         ├── take_order
         ├── serve_order
         └── take_payment
```
可以看出，绝对路径的调用，完全符合了模块树的层级递进，非常符合直觉，如果类比文件系统，就跟使用绝对路径调用可执行程序差不多：`/front_of_house/hosting/add_to_waitlist`，使用 `crate` 作为开始就和使用 `/` 作为开始一样。
###### 3.12.2.3.2 相对路径引用
再回到模块树中，因为 `eat_at_restaurant` 和 `front_of_house` 都处于包根 `crate` 中，因此相对路径可以使用 `front_of_house` 作为开头：
```rust
front_of_house::hosting::add_to_waitlist();
```
如果类比文件系统，那么它类似于调用同一个目录下的程序，你可以这么做：`front_of_house/hosting/add_to_waitlist`，嗯也很符合直觉。
###### 3.12.2.3.3 绝对还是相对？
如果只是为了引用到指定模块中的对象，那么两种都可以，
但是在实际使用时，需要遵循一个原则：**当代码被挪动位置时，尽量减少引用路径的修改**，
回到之前的例子，如果我们把 `front_of_house` 模块和 `eat_at_restaurant` 移动到一个模块中 `customer_experience`，那么绝对路径的引用方式就必须进行修改：`crate::customer_experience::front_of_house ...`，但是假设我们使用的相对路径，那么该路径就无需修改，因为它们两个的相对位置其实没有变：
```console
crate
 └── customer_experience
    └── eat_at_restaurant
    └── front_of_house
        ├── hosting
        │   ├── add_to_waitlist
        │   └── seat_at_table
```
从新的模块树中可以很清晰的看出这一点。
再比如，其它的都不动，把 `eat_at_restaurant` 移动到模块 `dining` 中，如果使用相对路径，你需要修改该路径，但如果使用的是绝对路径，就无需修改：
```console
crate
 └── dining
     └── eat_at_restaurant
 └── front_of_house
     ├── hosting
     │   ├── add_to_waitlist
```
不过，如果不确定哪个好，你可以考虑<span style="background:#f60909">优先使用绝对路径</span>，因为调用的地方和定义的地方往往是分离的，而定义的地方较少会变动。
##### 3.12.2.4 代码可见性
Rust 出于安全的考虑，默认情况下，所有的类型都是<span style="background:#f60909">私有化</span>的，包括函数、方法、结构体、枚举、常量，是的，就连模块本身也是私有化的。
但是在 Rust 中，**父模块完全无法访问子模块中的私有项，但是子模块却可以访问父模块、父父..模块的私有项**。
###### 3.12.2.4.1 pub 关键字
Rust 提供了 `pub` 关键字，通过它你可以控制模块和模块中指定项的可见性。
模块可见性不代表模块内部项的可见性，模块的可见性仅仅是允许其它模块去引用它，但是想要引用它内部的项，还得继续将对应的项标记为 `pub`。
##### 3.12.2.5 使用 super 引用模块
在[用路径引用模块](https://course.rs/basic/crate-module/module.html#%E7%94%A8%E8%B7%AF%E5%BE%84%E5%BC%95%E7%94%A8%E6%A8%A1%E5%9D%97)中，我们提到了相对路径有三种方式开始：`self`、`super`和 `crate` 或者模块名，其中第三种在前面已经讲到过，现在来看看通过 `super` 的方式引用模块项。
`super` 代表的是父模块为开始的引用方式，非常类似于文件系统中的 `..` 语法：`../a/b` 文件名：src/lib.rs
```rust
fn serve_order() {}

// 厨房模块
mod back_of_house {
    fn fix_incorrect_order() {
        cook_order();
        super::serve_order();
    }

    fn cook_order() {}
}
```
在厨房模块中，使用 `super::serve_order` 语法，调用了父模块（包根）中的 `serve_order` 函数。
那么你可能会问，为何不使用 `crate::serve_order` 的方式？额，其实也可以，不过如果你确定未来这种层级关系不会改变，那么 `super::serve_order` 的方式会更稳定，未来就算它们都不在包根了，依然无需修改引用路径。所以路径的选用，往往还是取决于场景，以及未来代码的可能走向。
##### 3.12.2.6 使用 self 引用模块
`self` 其实就是引用自身模块中的项，也就是说和我们之前章节的代码类似，都调用同一模块中的内容，区别在于之前章节中直接通过名称调用即可，而 `self`，你得多此一举：
```rust
fn serve_order() {
    self::back_of_house::cook_order()
}

mod back_of_house {
    fn fix_incorrect_order() {
        cook_order();
        crate::serve_order();
    }

    pub fn cook_order() {}
}
```
##### 3.12.2.7 结构体和枚举的可见性
为何要把结构体和枚举的可见性单独拎出来讲呢？因为这两个家伙的成员字段拥有完全不同的可见性：
- 将结构体设置为 `pub`，但它的所有字段依然是私有的
- 将枚举设置为 `pub`，它的所有字段也将对外可见
原因在于，枚举和结构体的使用方式不一样。如果枚举的成员对外不可见，那该枚举将一点用都没有，因此枚举成员的可见性自动跟枚举可见性保持一致，这样可以简化用户的使用。
而结构体的应用场景比较复杂，其中的字段也往往部分在 A 处被使用，部分在 B 处被使用，因此无法确定成员的可见性，那索性就设置为全部不可见，将选择权交给程序员。
##### 3.12.2.8 模块与文件分离
在之前的例子中，我们所有的模块都定义在 `src/lib.rs` 中，但是当模块变多或者变大时，需要将模块放入一个单独的文件中，让代码更好维护。
现在，把 `front_of_house` 前厅分离出来，放入一个单独的文件中 `src/front_of_house.rs`：
```rust
pub mod hosting {
    pub fn add_to_waitlist() {}
}
```
然后，将以下代码留在 `src/lib.rs` 中：
```rust
mod front_of_house;

pub use crate::front_of_house::hosting;

pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
}
```
so easy！其实跟之前在同一个文件中也没有太大的不同，但是有几点值得注意：
- `mod front_of_house;` 告诉 Rust 从另一个和模块 `front_of_house` 同名的文件中加载该模块的内容
- 使用绝对路径的方式来引用 `hosting` 模块：`crate::front_of_house::hosting;`
需要注意的是，和之前代码中 `mod front_of_house{..}` 的完整模块不同，现在的代码中，模块的声明和实现是分离的，实现是在单独的 `front_of_house.rs` 文件中，然后通过 `mod front_of_house;` 这条声明语句从该文件中把模块内容加载进来。因此我们可以认为，模块 `front_of_house` 的定义还是在 `src/lib.rs` 中，只不过模块的具体内容被移动到了 `src/front_of_house.rs` 文件中。

在这里出现了一个新的关键字 `use`，联想到其它章节我们见过的标准库引入 `use std::fmt;`，可以大致猜测，该关键字用来将外部模块中的项引入到当前作用域中来，这样无需冗长的父模块前缀即可调用：`hosting::add_to_waitlist();`，在下节中，我们将对 `use` 进行详细的讲解。
<span style="background:#0779e4">当一个模块有许多子模块时，我们也可以通过文件夹的方式来组织这些子模块</span>。
在上述例子中，我们可以创建一个目录 `front_of_house`，然后在文件夹里创建一个 `hosting.rs` 文件，`hosting.rs` 文件现在就剩下：
```rust
pub fn add_to_waitlist() {}
 // 现在，我们尝试编译程序，很遗憾，编译器报错：
error[E0583]: file not found for module `front_of_house`
 --> src/lib.rs:3:1
1 | mod front_of_house;
  | ^^^^^^^^^^^^^^^^^^
  = help: to create the module `front_of_house`, create file "src/front_of_house.rs" or "src/front_of_house/mod.rs"
```
是的，如果需要将文件夹作为一个模块，我们需要进行显示指定暴露哪些子模块。按照上述的报错信息，我们有两种方法：
- 在 `front_of_house` 目录里创建一个 `mod.rs`，如果你使用的 `rustc` 版本 `1.30` 之前，这是唯一的方法。
- 在 `front_of_house` **同级**目录里创建一个与模块（目录）**同名**的 rs 文件 `front_of_house.rs`，在新版本里，更建议使用这样的命名方式来避免项目中存在大量同名的 `mod.rs` 文件（ Python 点了个 `踩`）。
如果使用第二种方式，文件结构将如下所示：
```shell
src
├── front_of_house
│   └── hosting.rs
├── front_of_house.rs
└── lib.rs
```
而无论是上述哪个方式创建的文件，其内容都是一样的，你需要在定义你(`mod.rs` 或 `front_of_house.rs`)的子模块（子模块名与文件名相同）：
```rust
pub mod hosting;
// pub mod serving;
```
#### 3.12.3 使用 use 及受限可见性
如果代码中，通篇都是 `crate::front_of_house::hosting::add_to_waitlist` 需要简化，在 Rust 中，可以使用 use 关键字把路径提前引入到当前作用域中，随后的调用就可以省略该路径，极大地简化了代码。
##### 3.12.3.1 基本引入方式
使用绝对路径的引入方式
```rust
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}
use crate::front_of_house::hosting;
pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
}
```
使用 `use` 和绝对路径的方式，将  模块引入到当前作用域中，然后只需通过 `模块::函数` 的方式，即可调用目标模块中的函数
##### 3.12.3.2 相对路径引入模块中的函数
直接引入该模块中的函数：
```rust
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}
use front_of_house::hosting::add_to_waitlist;
pub fn eat_at_restaurant() {
    add_to_waitlist();
    add_to_waitlist();
    add_to_waitlist();
}
```
##### 3.12.3.3 引入模块还是函数
从使用简洁性来说，引入函数自然是更甚一筹，但是在某些时候，引入模块会更好：
- 需要引入同一个模块的多个函数
- 作用域中存在同名函数
例如，如果想使用 `HashMap`，那么直接引入该结构体是比引入模块更好的选择，因为在 `collections` 模块中，我们只需要使用一个 `HashMap` 结构体：
```rust
use std::collections::HashMap;
fn main() {
    let mut map = HashMap::new();
    map.insert(1, 2);
}
```
建议：**优先使用最细粒度（引入函数、结构体等）的引用方式，如果引起了某种麻烦（例如前面两种情况），再使用引入模块的方式**。
##### 3.12.3.4 避免同名引用
我们只要保证同一个模块中不存在同名项就行，模块之间、包之间的同名，谁管得着谁啊，话虽如此，一起看看，如果遇到同名的情况该如何处理。
###### 3.12.3.4.1 模块::函数
```rust
use std::fmt;
use std::io;
fn function1() -> fmt::Result {    // --snip--}
fn function2() -> io::Result<()> {    // --snip--}
```
使用模块引入的方式，具体的 `Result` 通过 `模块::Result` 的方式进行调用。
避免同名冲突的关键，就是使用**父模块的方式来调用**
###### 3.12.3.4.2 as 别名引用
使用 `as` 关键字来解决，它可以赋予引入项一个全新的名称：
```rust
use std::fmt::Result;
use std::io::Result as IoResult;

fn function1() -> Result {    // --snip--}
fn function2() -> IoResult<()> {    // --snip--}
```
如上所示，首先通过 `use std::io::Result` 将 `Result` 引入到作用域，然后使用 `as` 给予它一个全新的名称 `IoResult`，这样就不会再产生冲突：
- `Result` 代表 `std::fmt::Result`
- `IoResult` 代表 `std:io::Result`
##### 3.12.3.5 引入项再导出
当外部的模块项 `A` 被引入到当前模块中时，它的可见性自动被设置为私有的，如果你希望允许其它外部代码引用我们的模块项 `A`，那么可以对它进行再导出：
```rust
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}
pub use crate::front_of_house::hosting;

pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
}
```
如上，使用 `pub use` 即可实现。这里 `use` 代表引入 `hosting` 模块到当前作用域，`pub` 表示将该引入的内容再度设置为可见。
当你希望将内部的实现细节隐藏起来或者按照某个目的组织代码时，可以使用 `pub use` 再导出，例如统一使用一个模块来提供对外的 API，那该模块就可以引入其它模块中的 API，然后进行再导出，最终对于用户来说，所有的 API 都是由一个模块统一提供的。
##### 3.12.3.6 使用第三方包 use
引入下第三方包中的模块步骤：
1. 修改 `Cargo.toml` 文件，在 `[dependencies]` 区域添加一行：`rand = "0.8.3"`
2. 此时，如果你用的是 `VSCode` 和 `rust-analyzer` 插件，该插件会自动拉取该库，你可能需要等它完成后，再进行下一步（VSCode 左下角有提示）
好了，此时，`rand` 包已经被我们添加到依赖中，下一步就是在代码中使用：
```rust
use rand::Rng;
fn main() {
    let secret_number = rand::thread_rng().gen_range(1..101);
}
```
这里使用 `use` 引入了第三方包 `rand` 中的 `Rng` 特征，因为我们需要调用的 `gen_range` 方法定义在该特征中。
###### 3.12.3.6.1 crates.io，lib.rs
Rust 社区已经为我们贡献了大量高质量的第三方包，你可以在 `crates.io` 或者 `lib.rs` 中检索和使用，从目前来说查找包更推荐 `lib.rs`，搜索功能更强大，内容展示也更加合理，但是下载依赖包还是得用`crates.io`。
在网上找到想要的包，然后将你想要的包和版本信息写入到 `Cargo.toml` 中。
##### 3.12.3.7 使用 {} 简化引入方式
1. 同一个crate的不同函数
```rust
use std::collections::HashMap;
use std::collections::BTreeMap;
use std::collections::HashSet;
use std::cmp::Ordering;
use std::io;
//              ========================
use std::collections::{HashMap,BTreeMap,HashSet};
use std::{cmp::Ordering, io};
```
2. 自身和函数：
```rust
use std::io;
use std::io::Write;
//              ========================
use std::io::{self, Write};
```
###### 3.12.3.7.1 self
上面使用到了模块章节提到的 `self` 关键字，用来替代模块自身，结合上一节中的 `self`，可以得出它在模块中的两个用途：
- `use self::xxx`，表示加载当前模块中的 `xxx`。此时 `self` 可省略
- `use xxx::{self, yyy}`，表示，加载当前路径下模块 `xxx` 本身，以及模块 `xxx` 下的 `yyy`
##### 3.12.3.8 使用 * 引入模块下的所有项
```rust
use std::collections::*; // 以上这种方式来引入 `std::collections` 模块下的所有公共项，这些公共项自然包含了 `HashMap`，`HashSet` 等想手动引入的集合类型。
```
当使用 `*` 来
1. 和你自己程序中的<span style="background:#0779e4">名称相冲突</span>：
```rust
use std::collections::*;

struct HashMap;
fn main() {
   let mut v =  HashMap::new();
   v.insert("a", 1);
}
```
2. <span style="background:#0779e4">本地同名类型的优先级更高</span>。
3. 在实际项目中，<span style="background:#0779e4">用于快速写测试代码</span>，它可以把所有东西一次性引入到 `tests` 模块中。
##### 3.12.3.9 受限的可见性
想控制哪些人能看，这就是 Rust 提供的受限可见性。
例如，在 Rust 中，包是一个模块树，我们可以通过 `pub(crate) item;` 这种方式来实现：`item` 虽然是对外可见的，但是只在当前包内可见，外部包无法引用到该 `item`。
想要让某一项可以在整个包中都可以被使用，那么有两种办法：
- 在包根中定义一个非 `pub` 类型的 `X`(父模块的项对子模块都是可见的，因此包根中的项对模块树上的所有模块都可见)
- 在子模块中定义一个 `pub` 类型的 `Y`，同时通过 `use` 将其引入到包根

```rust
mod a {
    pub mod b {
        pub fn c() {
            println!("{:?}",crate::X);
        }

        #[derive(Debug)]
        pub struct Y;
    }
}

#[derive(Debug)]
struct X;
use a::b::Y;
fn d() {
    println!("{:?}",Y);
}
```
以上代码充分说明了之前两种办法的使用方式，但是有时我们会遇到这两种方法都不太好用的时候。例如希望对于某些特定的模块可见，但是对于其他模块又不可见：
```rust
// 目标：`a` 导出 `I`、`bar` and `foo`，其他的不导出
pub mod a {
    pub const I: i32 = 3;

    fn semisecret(x: i32) -> i32 {
        use self::b::c::J;
        x + J
    }

    pub fn bar(z: i32) -> i32 {
        semisecret(I) * z
    }
    pub fn foo(y: i32) -> i32 {
        semisecret(I) + y
    }

    mod b {
        mod c {
            const J: i32 = 4;
        }
    }
}
```
这段代码会报错，因为与父模块中的项对子模块可见相反，子模块中的项对父模块是不可见的。这里 `semisecret` 方法中，`a` -> `b` -> `c` 形成了父子模块链，那 `c` 中的 `J` 自然对 `a` 模块不可见。
如果使用之前的可见性方式，那么想保持 `J` 私有，同时让 `a` 继续使用 `semisecret` 函数的办法是将该函数移动到 `c` 模块中，然后用 `pub use` 将 `semisecret` 函数进行再导出：
```rust
pub mod a {
    pub const I: i32 = 3;

    use self::b::semisecret;

    pub fn bar(z: i32) -> i32 {
        semisecret(I) * z
    }
    pub fn foo(y: i32) -> i32 {
        semisecret(I) + y
    }

    mod b {
        pub use self::c::semisecret;
        mod c {
            const J: i32 = 4;
            pub fn semisecret(x: i32) -> i32 {
                x + J
            }
        }
    }
}
```
这段代码说实话问题不大，但是有些破坏了我们之前的逻辑，如果想保持代码逻辑，同时又只让 `J` 在 `a` 内可见该怎么办？
```rust
pub mod a {
    pub const I: i32 = 3;

    fn semisecret(x: i32) -> i32 {
        use self::b::c::J;
        x + J
    }

    pub fn bar(z: i32) -> i32 {
        semisecret(I) * z
    }
    pub fn foo(y: i32) -> i32 {
        semisecret(I) + y
    }

    mod b {
        pub(in crate::a) mod c {
            pub(in crate::a) const J: i32 = 4;
        }
    }
}
```
通过 `pub(in crate::a)` 的方式，我们指定了模块 `c` 和常量 `J` 的可见范围都只是 `a` 模块中，`a` 之外的模块是完全访问不到它们的。
###### 3.12.3.9.1 限制可见性语法
`pub(crate)` 或 `pub(in crate::a)` 就是限制可见性语法，前者是限制在整个包内可见，后者是通过绝对路径，限制在包内的某个模块内可见，总结一下：

- `pub` 意味着可见性无任何限制
- `pub(crate)` 表示在当前包可见
- `pub(self)` 在当前模块可见
- `pub(super)` 在父模块可见
- `pub(in <path>)` 表示在某个路径代表的模块中可见，其中 `path` 必须是父模块或者祖先模块

```rust
// 一个名为 `my_mod` 的模块
mod my_mod {
    // 模块中的项默认具有私有的可见性
    fn private_function() {
        println!("called `my_mod::private_function()`");
    }

    // 使用 `pub` 修饰语来改变默认可见性。
    pub fn function() {
        println!("called `my_mod::function()`");
    }

    // 在同一模块中，项可以访问其它项，即使它是私有的。
    pub fn indirect_access() {
        print!("called `my_mod::indirect_access()`, that\n> ");
        private_function();
    }

    // 模块也可以嵌套
    pub mod nested {
        pub fn function() {
            println!("called `my_mod::nested::function()`");
        }

        #[allow(dead_code)]
        fn private_function() {
            println!("called `my_mod::nested::private_function()`");
        }

        // 使用 `pub(in path)` 语法定义的函数只在给定的路径中可见。
        // `path` 必须是父模块（parent module）或祖先模块（ancestor module）
        pub(in crate::my_mod) fn public_function_in_my_mod() {
            print!("called `my_mod::nested::public_function_in_my_mod()`, that\n > ");
            public_function_in_nested()
        }

        // 使用 `pub(self)` 语法定义的函数则只在当前模块中可见。
        pub(self) fn public_function_in_nested() {
            println!("called `my_mod::nested::public_function_in_nested");
        }

        // 使用 `pub(super)` 语法定义的函数只在父模块中可见。
        pub(super) fn public_function_in_super_mod() {
            println!("called my_mod::nested::public_function_in_super_mod");
        }
    }

    pub fn call_public_function_in_my_mod() {
        print!("called `my_mod::call_public_funcion_in_my_mod()`, that\n> ");
        nested::public_function_in_my_mod();
        print!("> ");
        nested::public_function_in_super_mod();
    }

    // `pub(crate)` 使得函数只在当前包中可见
    pub(crate) fn public_function_in_crate() {
        println!("called `my_mod::public_function_in_crate()");
    }

    // 嵌套模块的可见性遵循相同的规则
    mod private_nested {
        #[allow(dead_code)]
        pub fn function() {
            println!("called `my_mod::private_nested::function()`");
        }
    }
}

fn function() {
    println!("called `function()`");
}

fn main() {
    // 模块机制消除了相同名字的项之间的歧义。
    function();
    my_mod::function();

    // 公有项，包括嵌套模块内的，都可以在父模块外部访问。
    my_mod::indirect_access();
    my_mod::nested::function();
    my_mod::call_public_function_in_my_mod();

    // pub(crate) 项可以在同一个 crate 中的任何地方访问
    my_mod::public_function_in_crate();

    // pub(in path) 项只能在指定的模块中访问
    // 报错！函数 `public_function_in_my_mod` 是私有的
    //my_mod::nested::public_function_in_my_mod();
    // 试一试 ^ 取消该行的注释

    // 模块的私有项不能直接访问，即便它是嵌套在公有模块内部的

    // 报错！`private_function` 是私有的
    //my_mod::private_function();
    // 试一试 ^ 取消此行注释

    // 报错！`private_function` 是私有的
    //my_mod::nested::private_function();
    // 试一试 ^ 取消此行的注释

    // 报错！ `private_nested` 是私有的
    //my_mod::private_nested::function();
    // 试一试 ^ 取消此行的注释
}
```

### 3.13 注释和文档

#### 3.13.1 注释的种类
在 Rust 中，注释分为三类：
- 代码注释，用于说明某一块代码的功能，读者往往是同一个项目的协作开发者
- 文档注释，支持 `Markdown`，对项目描述、公共 API 等用户关心的功能进行介绍，同时还能提供示例代码，目标读者往往是想要了解你项目的人
- 包和模块注释，严格来说这也是文档注释中的一种，它主要用于说明当前包和模块的功能，方便用户迅速了解一个项目
通过这些注释，实现了 Rust 极其优秀的文档化支持，甚至你还能在文档注释中写测试用例，省去了单独写测试用例的环节，我直呼好家伙！
#### 3.13.2 代码注释
**围绕目标，言简意赅**
```rust
fn main() {
    // 我是Sun...
    // face
    let name = "sunface";
    let age = 18; // 今年好像是18岁

//行注释可以放在某一行代码的上方，也可以放在当前代码行的后方。如果超出一行的长度，需要在新行的开头也加上 `//`。
    /*
        我
        是
        S
        u
        n
        ... 哎，好长!
    */
    let name = "sunface";
    let age = "???"; // 今年其实。。。挺大了
}
```
#### 3.13.3 文档注释
当查看一个 `crates.io` 上的包时，往往需要通过它提供的文档来浏览相关的功能特性、使用方式，这种文档就是通过文档注释实现的。
Rust 提供了 `cargo doc` 的命令，可以用于把这些文档注释转换成 `HTML` 网页文件，最终展示给用户浏览，这样用户就知道这个包是做什么的以及该如何使用。
##### 3.13.3.1 文档行注释` ///`
```rust
/// `add_one` 将指定值加1
///
/// # Examples
///
/// ```
/// let arg = 5;
/// let answer = my_crate::add_one(arg);
///
/// assert_eq!(6, answer);
/// ```
pub fn add_one(x: i32) -> i32 {
    x + 1
}
```
- 文档注释需要位于 `lib` 类型的包中，例如 `src/lib.rs` 中
- 文档注释可以使用 `markdown`语法！例如 `# Examples` 的标题，以及代码块高亮
- 被注释的对象需要使用 `pub` 对外可见，记住：文档注释是给用户看的，**内部实现细节不应该被暴露出去**
##### 3.13.3.2 文档块注释` /** ... */`
与代码注释一样，文档也有块注释，当注释内容多时，使用块注释可以减少 `///` 的使用：
````rust
/** `add_two` 将指定值加2


```
let arg = 5;
let answer = my_crate::add_two(arg);

assert_eq!(7, answer);
```
*/
pub fn add_two(x: i32) -> i32 {
    x + 2
}
````
##### 3.13.3.3 查看文档 cargo doc
很简单，运行 `cargo doc` 可以直接生成 `HTML` 文件，放入_target/doc_目录下。
当然，为了方便，我们使用 `cargo doc --open` 命令，可以在生成文档后，自动在浏览器中打开网页，最终效果如图所示：
![](https://pic2.zhimg.com/80/v2-926c91d429e2933a6a3ae3233fc56b1c_1440w.png)
##### 3.13.3.4 常用文档标题
这些标题更多的是一种惯例，最好在团队中保持同样的风格
1. Panics：函数可能会出现的异常状况，这样调用函数的人就可以提前规避
2. Errors：描述可能出现的错误及什么情况会导致错误，有助于调用者针对不同的错误采取不同的处理方式
3. Safety：如果函数使用 unsafe 代码，那么调用者就需要注意一些使用条件，以确保 unsafe 代码块的正常工作
#### 3.13.4 包和模块级别的注释
除了函数、结构体等 Rust 项的注释，你还可以给包和模块添加注释，需要注意的是，**这些注释要添加到包、模块的最上方**！
与之前的任何注释一样，包级别的注释也分为两种：行注释 `//!` 和块注释 `/*! ... */`。
现在，为我们的包增加注释，在 `src/lib.rs` 包根的最上方，添加：
```rust
/*! lib包是world_hello二进制包的依赖包，
 里面包含了compute等有用模块 */

pub mod compute;
```
然后再为该包根的子模块 `src/compute.rs` 添加注释：
```rust
//! 计算一些你口算算不出来的复杂算术题

/// `add_one`将指定值加1
///
```
运行 `cargo doc --open` 查看下效果：
![](https://pic3.zhimg.com/80/v2-38dbea938884c159e74f777c6f49e3af_1440w.png)
包模块注释，可以让用户从<span style="background:#0779e4">整体的角度理解包的用途</span>，对于用户来说是非常友好的，就和一篇文章的开头一样，总是要对文章的内容进行大致的介绍，让用户在看的时候心中有数。
#### 3.13.5 文档测试(Doc Test)
Rust 允许我们在文档注释中写单元测试用例
```rust
/// `add_one` 将指定值加1
///
/// # Examples11
///
/// ```
/// let arg = 5;
/// let answer = world_hello::compute::add_one(arg);
///
/// assert_eq!(6, answer);
/// ```
pub fn add_one(x: i32) -> i32 {
    x + 1
}
```
以上的注释不仅仅是文档，还可以作为单元测试的用例运行，使用 `cargo test` 运行测试：
```console
Doc-tests world_hello

running 2 tests
test src/compute.rs - compute::add_one (line 8) ... ok
test src/compute.rs - compute::add_two (line 22) ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 1.00s
```
可以看到，文档中的测试用例被完美运行，而且输出中也明确提示了 `Doc-tests world_hello`，意味着这些测试的名字叫 `Doc test` 文档测试。
> 需要注意的是，你可能需要使用类如 `world_hello::compute::add_one(arg)` 的完整路径来调用函数，因为测试是在另外一个独立的线程中运行的
##### 3.13.5.1 造成 panic 的文档测试
文档测试中的用例还可以造成 `panic`：
```rust
/// # Panics
///
/// The function panics if the second argument is zero.
///
/// ```rust
/// // panics on division by zero
/// world_hello::compute::div(10, 0);
/// ```
pub fn div(a: i32, b: i32) -> i32 {
    if b == 0 {
        panic!("Divide-by-zero error");
    }

    a / b
}
```
以上测试运行后会 `panic`：
```console
---- src/compute.rs - compute::div (line 38) stdout ----
Test executable failed (exit code 101).

stderr:
thread 'main' panicked at 'Divide-by-zero error', src/compute.rs:44:9
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
如果想要通过这种测试，可以添加 `should_panic`：
```rust
/// # Panics
///
/// The function panics if the second argument is zero.
///
/// ```rust,should_panic
/// // panics on division by zero
/// world_hello::compute::div(10, 0);
/// ```
```
通过 `should_panic`，告诉 Rust 我们这个用例会导致 `panic`，这样测试用例就能顺利通过。
##### 3.13.5.2 保留测试，隐藏文档
在某些时候，我们希望保留文档测试的功能，但是又要将某些测试用例的内容从文档中隐藏起来：
```rust
/// ```
/// # // 使用#开头的行会在文档中被隐藏起来，但是依然会在文档测试中运行
/// # fn try_main() -> Result<(), String> {
/// let res = world_hello::compute::try_div(10, 0)?;
/// # Ok(()) // returning from try_main
/// # }
/// # fn main() {
/// #    try_main().unwrap();
/// #
/// # }
/// ```
pub fn try_div(a: i32, b: i32) -> Result<i32, String> {
    if b == 0 {
        Err(String::from("Divide-by-zero"))
    } else {
        Ok(a / b)
    }
}
```
以上文档注释中，我们使用 `#` 将不想让用户看到的内容隐藏起来，但是又不影响测试用例的运行，最终用户将只能看到那行没有隐藏的 `let res = world_hello::compute::try_div(10, 0)?;`：
![](https://pic1.zhimg.com/80/v2-d1b98f5e70b7f8c8fb9aecce325dba0e_1440w.png)
#### 3.13.6 文档注释中的代码跳转
Rust 在文档注释中还提供了一个非常强大的功能，那就是可以实现对外部项的链接：
##### 3.13.6.1 跳转到标准库
```rust
/// `add_one` 返回一个[`Option`]类型
pub fn add_one(x: i32) -> Option<i32> {
    Some(x + 1)
}
```
此处的 **[`Option`]** 就是一个链接，指向了标准库中的 `Option` 枚举类型，有两种方式可以进行跳转:
- 在 IDE 中，使用 `Command + 鼠标左键`(macOS)，`CTRL + 鼠标左键`(Windows)
- 在文档中直接点击链接
再比如，还可以使用路径的方式跳转：
```rust
use std::sync::mpsc::Receiver;
/// [`Receiver<T>`]   [`std::future`].
///
///  [`std::future::Future`] [`Self::recv()`].
pub struct AsyncReceiver<T> {
    sender: Receiver<T>,
}

impl<T> AsyncReceiver<T> {
    pub async fn recv() -> T {
        unimplemented!()
    }
}
```
##### 3.13.6.2 使用完整路径跳转到指定项
除了跳转到标准库，你还可以通过指定具体的路径跳转到自己代码或者其它库的指定项，例如在 `lib.rs` 中添加以下代码：
```rust
pub mod a {
    /// `add_one` 返回一个[`Option`]类型
    /// 跳转到[`crate::MySpecialFormatter`]
    pub fn add_one(x: i32) -> Option<i32> {
        Some(x + 1)
    }
}

pub struct MySpecialFormatter;
```
使用 `crate::MySpecialFormatter` 这种路径就可以实现跳转到 `lib.rs` 中定义的结构体上。
##### 3.13.6.3 同名项的跳转
如果遇到同名项，可以使用标示类型的方式进行跳转：
```rust
/// 跳转到结构体  [`Foo`](struct@Foo)
pub struct Bar;

/// 跳转到同名函数 [`Foo`](fn@Foo)
pub struct Foo {}

/// 跳转到同名宏 [`foo!`]
pub fn Foo() {}

#[macro_export]
macro_rules! foo {
  () => {}
}
```
#### 3.13.7 文档搜索别名
Rust 文档支持搜索功能，我们可以为自己的类型定义几个别名，以实现更好的搜索展现，当别名命中时，搜索结果会被放在第一位：
```rust
#[doc(alias = "x")]
#[doc(alias = "big")]
pub struct BigX;

#[doc(alias("y", "big"))]
pub struct BigY;
```
结果如下图所示：![](imgs/Rust语言圣经(Rust%20Course)-10.png)
#### 3.13.8 一个综合例子
这个例子我们将重点应用几个知识点：
- 文档注释
- 一个项目可以包含两个包：二进制可执行包和 `lib` 包（库包），它们的包根分别是 `src/main.rs` 和 `src/lib.rs`
- 在二进制包中引用 `lib` 包
- 使用 `pub use` 再导出 API，并观察文档
首先，使用 `cargo new art` 创建一个 Package `art`：
```console
Created binary (application) `art` package
```
系统提示我们创建了一个二进制 `Package`，根据[之前章节](https://course.rs/basic/crate-module/crate.html)学过的内容，可以知道该 `Package` 包含一个同名的二进制包：包名为 `art`，包根为 `src/main.rs`，该包可以编译成二进制然后运行。
现在，在 `src` 目录下创建一个 `lib.rs` 文件，同样，根据之前学习的知识，创建该文件等于又创建了一个库类型的包，包名也是 `art`，包根为 `src/lib.rs`，该包是是库类型的，因此往往作为依赖库被引入。
将以下内容添加到 `src/lib.rs` 中：
```rust
//! # Art
//!
//!  未来的艺术建模库，现在的调色库

pub use self::kinds::PrimaryColor;
pub use self::kinds::SecondaryColor;
pub use self::utils::mix;

pub mod kinds {
    //! 定义颜色的类型

    /// 主色
    pub enum PrimaryColor {
        Red,
        Yellow,
        Blue,
    }

    /// 副色
    #[derive(Debug,PartialEq)]
    pub enum SecondaryColor {
        Orange,
        Green,
        Purple,
    }
}

pub mod utils {
    //! 实用工具，目前只实现了调色板
    use crate::kinds::*;

    /// 将两种主色调成副色
    /// ```rust
    /// use art::utils::mix;
    /// use art::kinds::{PrimaryColor,SecondaryColor};
    /// assert!(matches!(mix(PrimaryColor::Yellow, PrimaryColor::Blue), SecondaryColor::Green));
    /// ```
    pub fn mix(c1: PrimaryColor, c2: PrimaryColor) -> SecondaryColor {
        SecondaryColor::Green
    }
}
```
在库包的包根 `src/lib.rs` 下，我们又定义了几个子模块，同时将子模块中的三个项通过 `pub use` 进行了再导出。
接着，将下面内容添加到 `src/main.rs` 中：
```rust
use art::kinds::PrimaryColor;
use art::utils::mix;

fn main() {
    let blue = PrimaryColor::Blue;
    let yellow = PrimaryColor::Yellow;
    println!("{:?}",mix(blue, yellow));
}
```
在二进制可执行包的包根 `src/main.rs` 下，我们引入了库包 `art` 中的模块项，同时使用 `main` 函数作为程序的入口，该二进制包可以使用 `cargo run` 运行：

```console
Green
```
至此，库包完美提供了用于调色的 API，二进制包引入这些 API 完美的实现了调色并打印输出。
最后，再来看看文档长啥样：

![](https://pic1.zhimg.com/80/v2-e9ef7351458fd01020b35990c3daf222_1440w.png)
#### 3.13.9 总结
在 Rust 中，注释分为三个主要类型：代码注释、文档注释、包和模块注释，每个注释类型都拥有两种形式：行注释和块注释，
### 3.14 格式化输出
#### 3.14.1 3.14.初印象
```rust
println!("Hello");                 // => "Hello"
println!("Hello, {}!", "world");   // => "Hello, world!"
println!("The number is {}", 1);   // => "The number is 1"
println!("{:?}", (3, 4));          // => "(3, 4)"
println!("{value}", value=4);      // => "4"
println!("{} {}", 1, 2);           // => "1 2"
println!("{:04}", 42);             // => "0042" with leading zeros
```
可以看到 `println!` 宏接受的是可变参数，第一个参数是一个字符串常量，它表示最终输出字符串的格式，包含其中形如 `{}` 的符号是**占位符**，会被 `println!` 后面的参数依次替换。
##### 3.14.1.1 print!，println!，format!
们是 Rust 中用来格式化输出的三大金刚，用途如下：
- `print!` 将格式化文本输出到标准输出，不带换行符
- `println!` 同上，但是在行的末尾添加换行符
- `format!` 将格式化文本输出到 `String` 字符串
在实际项目中，最常用的是 `println!` 及 `format!`，前者常用来调试输出，后者常用来生成格式化的字符串：
```rust
fn main() {
    let s = "hello";
    println!("{}, world", s);
    let s1 = format!("{}, world", s);
    print!("{}", s1);
    print!("{}\n", "!");
}
```
##### 3.14.1.2 eprint!，eprintln!
输出到标准错误输出： 它们仅应该被用于输出<span style="background:red">错误信息和进度信息</span>，其它场景都应该使用 `print!` 系列。
```rust
eprintln!("Error: Could not complete task")
```
#### 3.14.2 {} 与
与其它语言常用的 `%d`，`%s` 不同，Rust 特立独行地选择了 `{}` 作为格式化占位符，事实证明，这种选择非常正确，它帮助用户减少了很多使用成本，你无需再为特定的类型选择特定的占位符，统一用 `{}` 来替代即可，剩下的类型推导等细节只要交给 Rust 去做。
与 `{}` 类似，`{:?}` 也是占位符：
- `{}` 适用于实现了 `std::fmt::Display` 特征的类型，用来以更优雅、更友好的方式格式化文本，例如展示给用户
- `{:?}` 适用于实现了 `std::fmt::Debug` 特征的类型，用于调试场景
其实两者的选择很简单，当你在写代码需要调试时，使用 `{:?}`，剩下的场景，选择 `{}`。
##### 3.14.2.1 Debug 特征
为了方便我们调试，大多数 Rust 类型都实现了 `Debug` 特征或者支持派生该特征：
```rust
#[derive(Debug)]
struct Person {
    name: String,
    age: u8
}

fn main() {
    let i = 3.1415926;
    let s = String::from("hello");
    let v = vec![1, 2, 3];
    let p = Person{name: "sunface".to_string(), age: 18};
    println!("{:?}, {:?}, {:?}, {:?}", i, s, v, p);
}
```
对于数值、字符串、数组，可以直接使用 `{:?}` 进行输出，但是对于结构体，需要[派生`Debug`](https://course.rs/appendix/derive.html)特征后，才能进行输出，总之很简单。
##### 3.14.2.2 Display 特征
实现了 `Display` 特征的 Rust 类型并没有那么多，往往需要我们自定义想要的格式化方式：
```rust
let i = 3.1415926;
let s = String::from("hello");
let v = vec![1, 2, 3];
let p = Person {
    name: "sunface".to_string(),
    age: 18,
};
println!("{}, {}, {}, {}", i, s, v, p);
```
运行后可以看到 `v` 和 `p` 都无法通过编译，因为没有实现 `Display` 特征，但是你又不能像派生 `Debug` 一般派生 `Display`，只能另寻他法：
- 使用 `{:?}` 或 `{:#?}`
- 为自定义类型实现 `Display` 特征
- 使用 `newtype` 为外部类型实现 `Display` 特征
`{:#?}` 与 `{:?}` 几乎一样，唯一的区别在于它能更优美地输出内容：
```console
// {:?}
[1, 2, 3], Person { name: "sunface", age: 18 }

// {:#?}
[
    1,
    2,
    3,
], Person {
    name: "sunface",
}
```
因此对于 `Display` 不支持的类型，可以考虑使用 `{:#?}` 进行格式化，虽然理论上它更适合进行调试输出。
##### 3.14.2.3 为自定义类型实现 Display 特征
如果你的类型是定义在当前作用域中的，那么可以为其实现 `Display` 特征，即可用于格式化输出：
```rust
struct Person {
    name: String,
    age: u8,
}

use std::fmt;
impl fmt::Display for Person {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(
            f,
            "大佬在上，请受我一拜，小弟姓名{}，年芳{}，家里无田又无车，生活苦哈哈",
            self.name, self.age
        )
    }
}
fn main() {
    let p = Person {
        name: "sunface".to_string(),
        age: 18,
    };
    println!("{}", p);
}
```
如上所示，只要实现 `Display` 特征中的 `fmt` 方法，即可为自定义结构体 `Person` 添加自定义输出：
##### 3.14.2.4 为外部类型实现 Display 特征
在 Rust 中，无法直接为外部类型实现外部特征，但是可以使用[`newtype`](https://course.rs/advance/into-types/custom-type.html#newtype)解决此问题：
```rust
struct Array(Vec<i32>);

use std::fmt;
impl fmt::Display for Array {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "数组是：{:?}", self.0)
    }
}
fn main() {
    let arr = Array(vec![1, 2, 3]);
    println!("{}", arr);
}
```
`Array` 就是我们的 `newtype`，它将想要格式化输出的 `Vec` 包裹在内，最后只要为 `Array` 实现 `Display` 特征，即可进行格式化输出：
```console
数组是：[1, 2, 3]
```
至此，关于 `{}` 与 `{:?}` 的内容已介绍完毕，下面让我们正式开始格式化输出的旅程。
#### 3.14.3 位置参数
除了按照依次顺序使用值去替换占位符之外，还能让指定位置的参数去替换某个占位符，例如 `{1}`，表示用第二个参数替换该占位符（索引从 0 开始）：
```rust
fn main() {
    println!("{}{}", 1, 2); // =>"12"
    println!("{1}{0}", 1, 2); // =>"21"
    // => Alice, this is Bob. Bob, this is Alice
    println!("{0}, this is {1}. {1}, this is {0}", "Alice", "Bob");
    println!("{1}{}{0}{}", 1, 2); // => 2112
}
```
#### 3.14.4 具名参数
为参数指定名称：
```rust
fn main() {
    println!("{argument}", argument = "test"); // => "test"
    println!("{name} {}", 1, name = 2); // => "2 1"
    println!("{a} {c} {b}", a = "a", b = 'b', c = 3); // => "a 3 b"
}
```
需要注意的是：**带名称的参数必须放在不带名称参数的后面**，例如下面代码将报错：
```rust
println!("{abc} {1}", abc = "def", 2);
error: positional arguments cannot follow named arguments
 --> src/main.rs:4:36
 4 | println!("{abc} {1}", abc = "def", 2);
   |                             -----  ^ positional arguments must be before named arguments
   |                             named argument
```
#### 3.14.5 格式化参数
格式化输出，意味着对输出格式会有更多的要求，例如只输出浮点数的小数点后两位：
```rust
fn main() {
    let v = 3.1415926;
    // Display => 3.14
    println!("{:.2}", v);
    // Debug => 3.14
    println!("{:.2?}", v);
}
```
上面代码只输出小数点后两位。同时我们还展示了 `{}` 和 `{:?}` 的用法，后面如无特殊区别，就只针对 `{}` 提供格式化参数说明。
##### 3.14.5.1 宽度
宽度用来指示输出目标的长度，如果长度不够，则进行填充和对齐：
##### 3.14.5.2 字符串填充
字符串格式化默认使用空格进行填充，并且进行左对齐。
```rust
fn main() {
    //-----------------------------------
    // 以下全部输出 "Hello x    !"
    // 为"x"后面填充空格，补齐宽度5
    println!("Hello {:5}!", "x");
    // 使用参数5来指定宽度
    println!("Hello {:1$}!", "x", 5);
    // 使用x作为占位符输出内容，同时使用5作为宽度
    println!("Hello {1:0$}!", 5, "x");
    // 使用有名称的参数作为宽度
    println!("Hello {:width$}!", "x", width = 5);
    //-----------------------------------

    // 使用参数5为参数x指定宽度，同时在结尾输出参数5 => Hello x    !5
    println!("Hello {:1$}!{}", "x", 5);
}
```
##### 3.14.5.3 数字填充:符号和 0
数字格式化默认也是使用空格进行填充，但与字符串左对齐不同的是，数字是右对齐。
```rust
fn main() {
    // 宽度是5 => Hello     5!
    println!("Hello {:5}!", 5);
    // 显式的输出正号 => Hello +5!
    println!("Hello {:+}!", 5);
    // 宽度5，使用0进行填充 => Hello 00005!
    println!("Hello {:05}!", 5);
    // 负号也要占用一位宽度 => Hello -0005!
    println!("Hello {:05}!", -5);
}
```
#### 3.14.6 对齐
```rust
fn main() {
    // 以下全部都会补齐5个字符的长度
    // 左对齐 => Hello x    !
    println!("Hello {:<5}!", "x");
    // 右对齐 => Hello     x!
    println!("Hello {:>5}!", "x");
    // 居中对齐 => Hello   x  !
    println!("Hello {:^5}!", "x");

    // 对齐并使用指定符号填充 => Hello x&&&&!
    // 指定符号填充的前提条件是必须有对齐字符
    println!("Hello {:&<5}!", "x");
}
```
#### 3.14.7 精度
精度可以用于控制浮点数的精度或者字符串的长度
```rust
fn main() {
    let v = 3.1415926;
    // 保留小数点后两位 => 3.14
    println!("{:.2}", v);
    // 带符号保留小数点后两位 => +3.14
    println!("{:+.2}", v);
    // 不带小数 => 3
    println!("{:.0}", v);
    // 通过参数来设定精度 => 3.1416，相当于{:.4}
    println!("{:.1$}", v, 4);

    let s = "hi我是Sunface孙飞";
    // 保留字符串前三个字符 => hi我
    println!("{:.3}", s);
    // {:.*}接收两个参数，第一个是精度，第二个是被格式化的值 => Hello abc!
    println!("Hello {:.*}!", 3, "abcdefg");
}
```
#### 3.14.8 进制
可以使用 `#` 号来控制数字的进制输出：
- `#b`, 二进制
- `#o`, 八进制
- `#x`, 小写十六进制
- `#X`, 大写十六进制
- `x`, 不带前缀的小写十六进制
```rust
fn main() {
    // 二进制 => 0b11011!
    println!("{:#b}!", 27);
    // 八进制 => 0o33!
    println!("{:#o}!", 27);
    // 十进制 => 27!
    println!("{}!", 27);
    // 小写十六进制 => 0x1b!
    println!("{:#x}!", 27);
    // 大写十六进制 => 0x1B!
    println!("{:#X}!", 27);

    // 不带前缀的十六进制 => 1b!
    println!("{:x}!", 27);

    // 使用0填充二进制，宽度为10 => 0b00011011!
    println!("{:#010b}!", 27);
}
```
#### 3.14.9 指数
```rust
fn main() {
    println!("{:2e}", 1000000000); // => 1e9
    println!("{:2E}", 1000000000); // => 1E9
}
```
#### 3.14.10 指针地址
```rust
let v= vec![1, 2, 3];
println!("{:p}", v.as_ptr()) // => 0x600002324050
```

#### 3.14.11 转义
有时需要输出 `{`和`}`，但这两个字符是特殊字符，需要进行转义：
```rust
fn main() {
    // "{{" 转义为 '{'   "}}" 转义为 '}'   "\"" 转义为 '"'
    // => Hello "{World}" 
    println!(" Hello \"{{World}}\" ");

    // 下面代码会报错，因为占位符{}只有一个右括号}，左括号被转义成字符串的内容
    // println!(" {{ Hello } ");
    // 也不可使用 '\' 来转义 "{}"
    // println!(" \{ Hello \} ")
}
```
#### 3.14.12 在格式化字符串时捕获环境中的值（Rust 1.58 新增）
在以前，想要输出一个函数的返回值，你需要这么做：
```rust
fn get_person() -> String {
    String::from("sunface")
}
fn main() {
    let p = get_person();
    println!("Hello, {}!", p);                // implicit position
    println!("Hello, {0}!", p);               // explicit index
    println!("Hello, {person}!", person = p);
}
```
问题倒也不大，但是一旦格式化字符串长了后，就会非常冗余，而在 1.58 后，我们可以这么写：
```rust
fn get_person() -> String {
    String::from("sunface")
}
fn main() {
    let person = get_person();
    println!("Hello, {person}!");
}
```
是不是清晰、简洁了很多？甚至还可以将环境中的值用于格式化参数:
```rust
let (width, precision) = get_format();
for (name, score) in get_scores() {
  println!("{name}: {score:width$.precision$}");
}
```
但也有局限，它只能捕获普通的变量，对于更复杂的类型（例如表达式），可以先将它赋值给一个变量或使用以前的 `name = expression` 形式的格式化参数。 目前除了 `panic!` 外，其它接收格式化参数的宏，都可以使用新的特性。对于 `panic!` 而言，如果还在使用 `2015版本` 或 `2018版本`，那 `panic!("{ident}")` 依然会被当成 正常的字符串来处理，同时编译器会给予 `warn` 提示。而对于 `2021版本` ，则可以正常使用:

```rust
fn get_person() -> String {
    String::from("sunface")
}
fn main() {
    let person = get_person();
    panic!("Hello, {person}!");
}
```
输出:
```console
thread 'main' panicked at 'Hello, sunface!', src/main.rs:6:5
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```

## 4 简单项目示例
```rust
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    dbg!(args);
}
```
最后，代码中使用 `dbg!` 宏来输出读取到的数组内容，来看看长啥样：
```shell
$ cargo run
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished dev [unoptimized + debuginfo] target(s) in 0.61s
     Running `target/debug/minigrep`
[src/main.rs:5] args = [
    "target/debug/minigrep",
]
```
```shell
$ cargo run -- needle haystack
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished dev [unoptimized + debuginfo] target(s) in 1.57s
     Running `target/debug/minigrep needle haystack`
[src/main.rs:5] args = [
    "target/debug/minigrep",
    "needle",
    "haystack",
]
```
### 4.1 存储读取到的参数
```rust
let args: Vec<String> = env::args().collect();
    let query = &args[1];
    let file_path= &args[2];
    println!("Searching for {}", query);
    println!("In file {}", file_path);
```
### 4.2 分离 main 函数
关于如何处理庞大的 `main` 函数，Rust 社区给出了统一的指导方案:
- 将程序分割为 `main.rs` 和 `lib.rs`，并将程序的逻辑代码移动到后者内
- 命令行解析属于非常基础的功能，严格来说不算是逻辑代码的一部分，因此还可以放在 `main.rs` 中
按照这个方案，将我们的代码重新梳理后，可以得出 `main` 函数应该包含的功能:
- 解析命令行参数
- 初始化其它配置
- 调用 `lib.rs` 中的 `run` 函数，以启动逻辑代码的运行
- 如果 `run` 返回一个错误，需要对该错误进行处理
这个方案有一个很优雅的名字: 关注点分离(Separation of Concerns)。简而言之，`main.rs` 负责启动程序，`lib.rs` 负责逻辑代码的运行。从测试的角度而言，这种分离也非常合理： `lib.rs` 中的主体逻辑代码可以得到简单且充分的测试，至于 `main.rs` ？确实没办法针对其编写额外的测试代码，但是它的代码也很少啊，很容易就能保证它的正确性。
### 4.3 `clone` 的得与失
 在上面的代码中，除了使用 `clone` ，还有其它办法来达成同样的目的，但 `clone` 无疑是最简单的方法：直接完整的复制目标数据，无需被所有权、借用等问题所困扰，但是它也有其缺点，那就是有一定的性能损耗。
  因此是否使用 `clone` 更多是一种性能上的权衡，对于上面的使用而言，由于是配置的初始化，因此整个程序只需要执行一次，性能损耗几乎是可以忽略不计的。
总之，判断是否使用 `clone`:
- 是否严肃的项目，玩具项目直接用 `clone` 就行，简单不好吗？
- 要看所在的代码路径是否是热点路径(hot path)，例如执行次数较多的显然就是热点路径，热点路径就值得去使用性能更好的实现方式
通过构造函数来初始化一个 `Config` 实例，而不是直接通过函数返回实例，典型的，标准库中的 `String::new` 函数就是一个范例。
```rust
fn main() {
    let args: Vec<String> = env::args().collect();

    let config = Config::new(&args);

    // --snip--
}
// --snip--

impl Config {
    fn new(args: &[String]) -> Config {
        let query = args[1].clone();
        let file_path = args[2].clone();

        Config { query, file_path }
    }
}
```
修改后，类似 `String::new` 的调用，我们可以通过 `Config::new` 来创建一个实例，看起来代码是不是更有那味儿了 ：）
### 4.4 错误处理
回顾一下，如果用户不输入任何命令行参数，我们的程序会怎么样？
```shell
$ cargo run
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished dev [unoptimized + debuginfo] target(s) in 0.0s
     Running `target/debug/minigrep`
thread 'main' panicked at 'index out of bounds: the len is 1 but the index is 1', src/main.rs:27:21
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
结果喜闻乐见，由于 `args` 数组没有任何元素，因此通过索引访问时，会直接报出数组访问越界的 `panic`。
##### 4.4.1.1 改进报错信息
还记得在错误处理章节，我们提到过 `panic` 的两种用法: 被动触发和主动调用嘛？上面代码的出现方式很明显是被动触发，这种报错信息是不可控的，下面我们先改成主动调用的方式:
```rust
// in main.rs
 // --snip--
    fn new(args: &[String]) -> Config {
        if args.len() < 3 {
            panic!("not enough arguments");
        }
        // --snip--
```
目的很明确，一旦传入的参数数组长度小于 3，则报错并让程序崩溃推出，这样后续的数组访问就不会再越界了。
```shell
$ cargo run
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished dev [unoptimized + debuginfo] target(s) in 0.0s
     Running `target/debug/minigrep`
thread 'main' panicked at 'not enough arguments', src/main.rs:26:13
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
不错，用户看到了更为明确的提示，但是还是有一大堆 `debug` 输出，这些我们其实是不想让用户看到的。这么看来，想要输出对用户友好的信息, `panic` 是不太适合的，它更适合告知开发者，哪里出现了问题。
##### 4.4.1.2 返回 Result 来替代直接 panic
```rust
impl Config {
    fn build(args: &[String]) -> Result<Config, &'static str> {
        if args.len() < 3 {
            return Err("not enough arguments");
        }

        let query = args[1].clone();
        let file_path = args[2].clone();

        Ok(Config { query, file_path })
    }
}
```

这里的 `Result` 可能包含一个 `Config` 实例，也可能包含一条错误信息 `&static str`，不熟悉这种字符串类型的同学可以回头看看字符串章节，代码中的字符串字面量都是该类型，且拥有 `'static` 生命周期。
##### 4.4.1.3 处理返回的 Result
接下来就是在调用 `build` 函数时，对返回的 `Result` 进行处理了，目的就是给出准确且友好的报错提示, 为了让大家更好的回顾我们修改过的内容，这里给出整体代码:

```rust
use std::env;
use std::fs;
use std::process;

fn main() {
    let args: Vec<String> = env::args().collect();

    // 对 build 返回的 `Result` 进行处理
    let config = Config::build(&args).unwrap_or_else(|err| {
        println!("Problem parsing arguments: {err}");
        process::exit(1);
    });


    println!("Searching for {}", config.query);
    println!("In file {}", config.file_path);

    let contents = fs::read_to_string(config.file_path)
        .expect("Should have been able to read the file");

    println!("With text:\n{contents}");
}

struct Config {
    query: String,
    file_path: String,
}

impl Config {
    fn build(args: &[String]) -> Result<Config, &'static str> {
        if args.len() < 3 {
            return Err("not enough arguments");
        }

        let query = args[1].clone();
        let file_path = args[2].clone();

        Ok(Config { query, file_path })
    }
}
```

上面代码有几点值得注意:

- 当 `Result` 包含错误时，我们不再调用 `panic` 让程序崩溃，而是通过 `process::exit(1)` 来终结进程，其中 `1` 是一个信号值(事实上非 0 值都可以)，通知调用我们程序的进程，程序是因为错误而退出的。
- `unwrap_or_else` 是定义在 `Result<T,E>` 上的常用方法，如果 `Result` 是 `Ok`，那该方法就类似 `unwrap`：返回 `Ok` 内部的值；如果是 `Err`，就调用[闭包](https://course.rs/advance/functional-programing/closure.html)中的自定义代码对错误进行进一步处理

综上可知，`config` 变量的值是一个 `Config` 实例，而 `unwrap_or_else` 闭包中的 `err` 参数，它的类型是 `'static str`，值是 "not enough arguments" 那个字符串字面量。

运行后，可以看到以下输出：

```shell
$ cargo run
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished dev [unoptimized + debuginfo] target(s) in 0.48s
     Running `target/debug/minigrep`
Problem parsing arguments: not enough arguments
```

终于，我们得到了自己想要的输出：既告知了用户为何报错，又消除了多余的 debug 信息，非常棒。可能有用户疑惑，`cargo run` 底下还有一大堆 `debug` 信息呢，实际上，这是 `cargo run` 自带的，大家可以试试编译成二进制可执行文件后再调用，会是什么效果。
##### 4.4.1.4 分离主体逻辑
接下来可以继续精简 `main` 函数，那就是将主体逻辑( 例如业务逻辑 )从 `main` 中分离出去，这样 `main` 函数就保留主流程调用，非常简洁。
```rust
// in main.rs
fn main() {
    let args: Vec<String> = env::args().collect();

    let config = Config::build(&args).unwrap_or_else(|err| {
        println!("Problem parsing arguments: {err}");
        process::exit(1);
    });

    println!("Searching for {}", config.query);
    println!("In file {}", config.file_path);

    run(config);
}

fn run(config: Config) {
    let contents = fs::read_to_string(config.file_path)
        .expect("Should have been able to read the file");

    println!("With text:\n{contents}");
}

// --snip--
```

如上所示，`main` 函数仅保留主流程各个环节的调用，一眼看过去非常简洁清晰。

继续之前，先请大家仔细看看 `run` 函数，你们觉得还缺少什么？提示：参考 `build` 函数的改进过程。
##### 4.4.1.5 使用 ? 和特征对象来返回错误
答案就是 `run` 函数没有错误处理，因为在文章开头我们提到过，错误处理最好统一在一个地方完成，这样极其有利于后续的代码维护。
```rust
//in main.rs
use std::error::Error;

// --snip--

fn run(config: Config) -> Result<(), Box<dyn Error>> {
    let contents = fs::read_to_string(config.file_path)?;

    println!("With text:\n{contents}");

    Ok(())
}
```
值得注意的是这里的 `Result<(), Box<dyn Error>>` 返回类型，首先我们的程序无需返回任何值，但是为了满足 `Result<T,E>` 的要求，因此使用了 `Ok(())` 返回一个单元类型 `()`。
最重要的是 `Box<dyn Error>`， 如果按照顺序学到这里，大家应该知道这是一个`Error` 的特征对象(为了使用 `Error`，我们通过 `use std::error::Error;` 进行了引入)，它表示函数返回一个类型，该类型实现了 `Error` 特征，这样我们就无需指定具体的错误类型，否则你还需要查看 `fs::read_to_string` 返回的错误类型，然后复制到我们的 `run` 函数返回中，这么做一个是麻烦，最主要的是，一旦这么做，意味着我们无法在上层调用时统一处理错误，但是 `Box<dyn Error>` 不同，其它函数也可以返回这个特征对象，然后调用者就可以使用统一的方式来处理不同函数返回的 `Box<dyn Error>`。
明白了 `Box<dyn Error>` 的重要战略地位，接下来大家分析下，`fs::read_to_string` 返回的具体错误类型是怎么被转化为 `Box<dyn Error>` 的？其实原因在之前章节都有讲过，这里就不直接给出答案了，参见 [?-传播界的大明星](https://course.rs/basic/result-error/result.html#%E4%BC%A0%E6%92%AD%E7%95%8C%E7%9A%84%E5%A4%A7%E6%98%8E%E6%98%9F-)。
运行代码看看效果：

```shell
$ cargo run the poem.txt
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
warning: unused `Result` that must be used
  --> src/main.rs:19:5
   |
19 |     run(config);
   |     ^^^^^^^^^^^^
   |
   = note: `#[warn(unused_must_use)]` on by default
   = note: this `Result` may be an `Err` variant, which should be handled

warning: `minigrep` (bin "minigrep") generated 1 warning
    Finished dev [unoptimized + debuginfo] target(s) in 0.71s
     Running `target/debug/minigrep the poem.txt`
Searching for the
In file poem.txt
With text:
I'm nobody! Who are you?
Are you nobody, too?
Then there's a pair of us - don't tell!
They'd banish us, you know.

How dreary to be somebody!
How public, like a frog
To tell your name the livelong day
To an admiring bog!
```

没任何问题，不过 Rust 编译器也给出了善意的提示，那就是 `Result` 并没有被使用，这可能意味着存在错误的潜在可能性。
```rust

    println!("Searching for {}", config.query);
    println!("In file {}", config.file_path);

    if let Err(e) = run(config) {
        println!("Application error: {e}");
        process::exit(1);
    }
```
#### 4.4.2 分离逻辑代码到库包中
> 对于 Rust 的代码组织( 包和模块 )还不熟悉的同学，强烈建议回头温习下[这一章](https://course.rs/basic/crate-module/intro.html)。
首先，创建一个 `src/lib.rs` 文件，然后将所有的非 `main` 函数都移动到其中。代码大概类似：
```rust
use std::error::Error;
use std::fs;

pub struct Config {
    pub query: String,
    pub file_path: String,
}

impl Config {
    pub fn build(args: &[String]) -> Result<Config, &'static str> {
        // --snip--
    }
}

pub fn run(config: Config) -> Result<(), Box<dyn Error>> {
    // --snip--
}
```

为了内容的简洁性，这里忽略了具体的实现，下一步就是在 `main.rs` 中引入 `lib.rs` 中定义的 `Config` 类型。

```rust
use std::env;
use std::process;

use minigrep::Config;

fn main() {
    // --snip--
    let args: Vec<String> = env::args().collect();

    let config = Config::build(&args).unwrap_or_else(|err| {
        println!("Problem parsing arguments: {err}");
        process::exit(1);
    });

    println!("Searching for {}", config.query);
    println!("In file {}", config.file_path);

    if let Err(e) = minigrep::run(config) {
        // --snip--
        println!("Application error: {e}");
        process::exit(1);
    }
}
```

很明显，这里的 `mingrep::run` 的调用，以及 `Config` 的引入，跟使用其它第三方包已经没有任何区别，也意味着我们成功的将逻辑代码放置到一个独立的库包中，其它包只要引入和调用就行。
呼，一顿书写猛如虎，回头一看。。。这么长的篇幅就写了这么点简单的代码？？只能说，我也希望像很多国内的大学教材一样，只要列出定理和解题方法，然后留下足够的习题，就万事大吉了，但是咱们不行。
接下来，到了最喜(令)闻(人)乐(讨)见(厌)的环节：写测试代码，一起来开心吧。
### 4.5 测试驱动开发
先编写一些测试代码，也是最近颇为流行的测试驱动开发模式(TDD, Test Driven Development)：
1. 编写一个注定失败的测试，并且失败的原因和你指定的一样
2. 编写一个成功的测试
3. 编写你的逻辑代码，直到通过测试
这三个步骤将在我们的开发过程中不断循环，直到所有的代码都开发完成并成功通过所有测试。
#### 4.5.1 注定失败的测试用例
在 `lib.rs` 文件中，添加 `tests` 模块和 `test` 函数:
```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn one_result() {
        let query = "duct";
        let contents = "\
Rust:
safe, fast, productive.
Pick three.";

        assert_eq!(vec!["safe, fast, productive."], search(query, contents));
    }
}
```
但目前为止，还无法运行该测试用例，更何况还想幸灾乐祸的看其失败，原因是 `search` 函数还没有实现！毕竟是测试驱动、测试先行。
```rust
// in lib.rs
pub fn search<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
    vec![]
}
```
先添加一个简单的 `search` 函数实现，非常简单粗暴的返回一个空的数组，显而易见测试用例将成功通过，真是一个居心叵测的测试用例！
注意这里生命周期 `'a` 的使用，之前的章节有[详细介绍](https://course.rs/basic/lifetime.html#%E5%87%BD%E6%95%B0%E7%AD%BE%E5%90%8D%E4%B8%AD%E7%9A%84%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F%E6%A0%87%E6%B3%A8)，不太明白的同学可以回头看看。
```shell
$ cargo test
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished test [unoptimized + debuginfo] target(s) in 0.97s
     Running unittests src/lib.rs (target/debug/deps/minigrep-9cd200e5fac0fc94)

running 1 test
test tests::one_result ... FAILED

failures:

---- tests::one_result stdout ----
thread 'main' panicked at 'assertion failed: `(left == right)`
  left: `["safe, fast, productive."]`,
 right: `[]`', src/lib.rs:44:9
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace


failures:
    tests::one_result

test result: FAILED. 0 passed; 1 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

error: test failed, to rerun pass `--lib`
```
太棒了！它失败了...
#### 4.5.2 务必成功的测试用例
接着就是测试驱动的第二步：编写注定成功的测试。当然，前提条件是实现我们的 `search` 函数。它包含以下步骤：
- 遍历迭代 `contents` 的每一行
- 检查该行内容是否包含我们的目标字符串
- 若包含，则放入返回值列表中，否则忽略
- 返回匹配到的返回值列表
这里的 `lines` 返回一个[迭代器](https://course.rs/advance/functional-programing/iterator.html)，关于迭代器在后续章节会详细讲解，现在只要知道 `for` 可以遍历取出迭代器中的值即可。
#### 4.5.3 [在每一行中查询目标字符串](https://course.rs/basic-practice/tests.html#在每一行中查询目标字符串)

```rust
// in lib.rs
pub fn search<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
    for line in contents.lines() {
        if line.contains(query) {
            // do something with line
        }
    }
}
```
与之前的 `lines` 函数类似，Rust 的字符串还提供了 `contains` 方法，用于检查 `line` 是否包含待查询的 `query`。
接下来，只要返回合适的值，就可以完成 `search` 函数的编写。
#### 4.5.4 [存储匹配到的结果](https://course.rs/basic-practice/tests.html#存储匹配到的结果)
简单，创建一个 `Vec` 动态数组，然后将查询到的每一个 `line` 推进数组中即可：
```rust
// in lib.rs
pub fn search<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
    let mut results = Vec::new();

    for line in contents.lines() {
        if line.contains(query) {
            results.push(line);
        }
    }

    results
}
```
至此，`search` 函数已经完成了既定目标，为了检查功能是否正确，运行下我们之前编写的测试用例:
```shell
$ cargo test
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished test [unoptimized + debuginfo] target(s) in 1.22s
     Running unittests src/lib.rs (target/debug/deps/minigrep-9cd200e5fac0fc94)

running 1 test
test tests::one_result ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/minigrep-9cd200e5fac0fc94)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests minigrep

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```
测试通过，意味着我们的代码也完美运行，接下来就是在 `run` 函数中大显身手了。
#### 4.5.5 [在 run 函数中调用 search 函数](https://course.rs/basic-practice/tests.html#在-run-函数中调用-search-函数)
```rust
// in src/lib.rs
pub fn run(config: Config) -> Result<(), Box<dyn Error>> {
    let contents = fs::read_to_string(config.file_path)?;

    for line in search(&config.query, &contents) {
        println!("{line}");
    }

    Ok(())
}
```
好，再运行下看看结果，看起来我们距离成功从未如此之近！
```shell
$ cargo run -- frog poem.txt
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished dev [unoptimized + debuginfo] target(s) in 0.38s
     Running `target/debug/minigrep frog poem.txt`
How public, like a frog
```
酷！成功查询到包含 `frog` 的行，再来试试 `body` :
```shell
$ cargo run -- body poem.txt
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished dev [unoptimized + debuginfo] target(s) in 0.0s
     Running `target/debug/minigrep body poem.txt`
I'm nobody! Who are you?
Are you nobody, too?
How dreary to be somebody!
```
完美，三行，一行不少，为了确保万无一失，再来试试查询一个不存在的单词:
```shell
cargo run -- monomorphization poem.txt
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished dev [unoptimized + debuginfo] target(s) in 0.0s
     Running `target/debug/minigrep monomorphization poem.txt`
```
至此，章节开头的目标已经全部完成，接下来思考一个小问题：如果要为程序加上大小写不敏感的控制命令，由用户进行输入，该怎么实现比较好呢？毕竟在实际搜索查询中，同时支持大小写敏感和不敏感还是很重要的。
### 4.6 使用环境变量
使用环境变量来增强程序
该如何实现用户控制的大小写敏感，其实答案很简单，你在其它程序中肯定也遇到过不少，例如如何控制 `panic` 后的栈展开？ Rust 提供的解决方案是通过命令行参数来控制:

```shell
RUST_BACKTRACE=1 cargo run
```

与之类似，我们也可以使用环境变量来控制大小写敏感，例如:

```shell
IGNORE_CASE=1 cargo run -- to poem.txt
```

既然有了目标，那么一起来看看该如何实现吧。
### 4.7 [编写大小写不敏感的测试用例](https://course.rs/basic-practice/envs.html#编写大小写不敏感的测试用例)

还是遵循之前的规则：测试驱动，这次是对一个新的大小写不敏感函数进行测试 `search_case_insensitive`。

还记得 TDD 的测试步骤嘛？首先编写一个注定失败的用例:

```rust
// in src/lib.rs
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn case_sensitive() {
        let query = "duct";
        let contents = "\
Rust:
safe, fast, productive.
Pick three.
Duct tape.";

        assert_eq!(vec!["safe, fast, productive."], search(query, contents));
    }

    #[test]
    fn case_insensitive() {
        let query = "rUsT";
        let contents = "\
Rust:
safe, fast, productive.
Pick three.
Trust me.";

        assert_eq!(
            vec!["Rust:", "Trust me."],
            search_case_insensitive(query, contents)
        );
    }
}
```

可以看到，这里新增了一个 `case_insensitive` 测试用例，并对 `search_case_insensitive` 进行了测试，结果显而易见，函数都没有实现，自然会失败。

接着来实现这个大小写不敏感的搜索函数:

```rust
pub fn search_case_insensitive<'a>(
    query: &str,
    contents: &'a str,
) -> Vec<&'a str> {
    let query = query.to_lowercase();
    let mut results = Vec::new();

    for line in contents.lines() {
        if line.to_lowercase().contains(&query) {
            results.push(line);
        }
    }

    results
}
```

跟之前一样，但是引入了一个新的方法 `to_lowercase`，它会将 `line` 转换成全小写的字符串，类似的方法在其它语言中也差不多，就不再赘述。

还要注意的是 `query` 现在是 `String` 类型，而不是之前的 `&str`，因为 `to_lowercase` 返回的是 `String`。

修改后，再来跑一次测试，看能否通过。

```shell
$ cargo test
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished test [unoptimized + debuginfo] target(s) in 1.33s
     Running unittests src/lib.rs (target/debug/deps/minigrep-9cd200e5fac0fc94)

running 2 tests
test tests::case_insensitive ... ok
test tests::case_sensitive ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

     Running unittests src/main.rs (target/debug/deps/minigrep-9cd200e5fac0fc94)

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s

   Doc-tests minigrep

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 0.00s
```

Ok，TDD的第二步也完成了，测试通过，接下来就是最后一步，在 `run` 中调用新的搜索函数。但是在此之前，要新增一个配置项，用于控制是否开启大小写敏感。

```rust
// in lib.rs
pub struct Config {
    pub query: String,
    pub file_path: String,
    pub ignore_case: bool,
}
```

接下来就是检查该字段，来判断是否启动大小写敏感：

```rust
pub fn run(config: Config) -> Result<(), Box<dyn Error>> {
    let contents = fs::read_to_string(config.file_path)?;

    let results = if config.ignore_case {
        search_case_insensitive(&config.query, &contents)
    } else {
        search(&config.query, &contents)
    };

    for line in results {
        println!("{line}");
    }

    Ok(())
}
```

现在的问题来了，该如何控制这个配置项呢。这个就要借助于章节开头提到的环境变量，好在 Rust 的 `env` 包提供了相应的方法。

```rust
use std::env;
// --snip--

impl Config {
    pub fn build(args: &[String]) -> Result<Config, &'static str> {
        if args.len() < 3 {
            return Err("not enough arguments");
        }

        let query = args[1].clone();
        let file_path = args[2].clone();

        let ignore_case = env::var("IGNORE_CASE").is_ok();

        Ok(Config {
            query,
            file_path,
            ignore_case,
        })
    }
}
```

`env::var` 没啥好说的，倒是 `is_ok` 值得说道下。该方法是 `Result` 提供的，用于检查是否有值，有就返回 `true`，没有则返回 `false`，刚好完美符合我们的使用场景，因为我们并不关心 `Ok<T>` 中具体的值。

运行下试试：

```shell
$ cargo run -- to poem.txt
   Compiling minigrep v0.1.0 (file:///projects/minigrep)
    Finished dev [unoptimized + debuginfo] target(s) in 0.0s
     Running `target/debug/minigrep to poem.txt`
Are you nobody, too?
How dreary to be somebody!
```
看起来没有问题，接下来测试下大小写不敏感:
```shell
$ IGNORE_CASE=1 cargo run -- to poem.txt
```

```shell
Are you nobody, too?
How dreary to be somebody!
To tell your name the livelong day
To an admiring bog!
```
大小写不敏感后，查询到的内容明显多了很多，也很符合我们的预期。
### 4.8 重定向错误信息的输出
迄今为止，所有的输出信息，无论 debug 还是 error 类型，都是通过 `println!` 宏输出到终端的标准输出( `stdout` )，但是对于程序来说，错误信息更适合输出到标准错误输出(stderr)。
这样修改后，用户就可以选择将普通的日志类信息输出到日志文件 1，然后将错误信息输出到日志文件 2，甚至还可以输出到终端命令行。
#### 4.8.1 [目前的错误输出位置](https://course.rs/basic-practice/stderr.html#目前的错误输出位置)
我们先来观察下，目前的输出信息包括错误，是否是如上面所说，都写到标准错误输出。
测试方式很简单，将标准错误输出的内容重定向到文件中，看看是否包含故意生成的错误信息即可。
```shell
$ cargo run > output.txt
```
首先，这里的运行没有带任何参数，因此会报出类如文件不存在的错误，其次，通过 `>` 操作符，标准输出上的内容被重定向到文件 `output.txt` 中，不再打印到控制上。
大家先观察下控制台，然后再看看 `output.txt`，是否发现如下的错误信息已经如期被写入到文件中？
```shell
Problem parsing arguments: not enough arguments
```
所以，可以得出一个结论，如果错误信息输出到标准输出，那么它们将跟普通的日志信息混在一起，难以分辨，因此我们需要将错误信息进行单独输出。
#### 4.8.2 [标准错误输出 stderr](https://course.rs/basic-practice/stderr.html#标准错误输出-stderr)
将错误信息重定向到 `stderr` 很简单，只需在打印错误的地方，将 `println!` 宏替换为 `eprintln!`即可。
```rust
fn main() {
    let args: Vec<String> = env::args().collect();

    let config = Config::build(&args).unwrap_or_else(|err| {
        eprintln!("Problem parsing arguments: {err}");
        process::exit(1);
    });

    if let Err(e) = minigrep::run(config) {
        eprintln!("Application error: {e}");
        process::exit(1);
    }
}
```
接下来，还是同样的运行命令：
```shell
$ cargo run > output.txt
Problem parsing arguments: not enough arguments
```
可以看到，日志信息成功的重定向到 `output.txt` 文件中，而错误信息由于 `eprintln!` 的使用，被写入到标准错误输出中，默认还是输出在控制台中。
再来试试没有错误的情况:
```shell
$ cargo run -- to poem.txt > output.txt
```
这次运行参数很正确，因此也没有任何错误信息产生，同时由于我们重定向了标准输出，因此相应的输出日志会写入到 `output.txt` 中，打开可以看到如下内容：
```shell
Are you nobody, too?
How dreary to be somebody!
```
### 4.9 使用迭代器来改进我们的程序
之前的 `minigrep` 中，功能虽然已经 ok，但是一些细节上还值得打磨下，下面一起看看如何使用迭代器来改进 `Config::build` 和 `search` 的实现。
#### 4.9.1 [移除 `clone` 的使用](https://course.rs/basic-practice/iterators.html#移除-clone-的使用)
虽然之前有讲过为什么这里可以使用 `clone`，但是也许总有同学心有芥蒂，毕竟程序员嘛，都希望代码处处完美，而不是丑陋的处处妥协。
```rust
impl Config {
    pub fn build(args: &[String]) -> Result<Config, &'static str> {
        if args.len() < 3 {
            return Err("not enough arguments");
        }

        let query = args[1].clone();
        let file_path = args[2].clone();

        let ignore_case = env::var("IGNORE_CASE").is_ok();

        Ok(Config {
            query,
            file_path,
            ignore_case,
        })
    }
}
```

之前的代码大致长这样，两行 `clone` 着实有点啰嗦，好在，在学习完迭代器后，我们知道了 `build` 函数实际上可以**直接拿走迭代器的所有权**，而不是去借用一个数组切片 `&[String]`。
这里先不给出代码，下面统一给出。
#### 4.9.2 [直接使用返回的迭代器](https://course.rs/basic-practice/iterators.html#直接使用返回的迭代器)
在之前的实现中，我们的 `args` 是一个动态数组:
```rust
fn main() {
    let args: Vec<String> = env::args().collect();

    let config = Config::build(&args).unwrap_or_else(|err| {
        eprintln!("Problem parsing arguments: {err}");
        process::exit(1);
    });

    // --snip--
}
```
当时还提到了 `collect` 方法的使用，相信大家学完迭代器后，对这个方法会有更加深入的认识。
现在呢，无需数组了，直接传入迭代器即可：
```rust
fn main() {
    let config = Config::build(env::args()).unwrap_or_else(|err| {
        eprintln!("Problem parsing arguments: {err}");
        process::exit(1);
    });

    // --snip--
}
```
如上所示，我们甚至省去了一行代码，原因是 `env::args` 可以直接返回一个迭代器，再作为 `Config::build` 的参数传入，下面再来改写 `build` 方法。
```rust
impl Config {
    pub fn build(
        mut args: impl Iterator<Item = String>,
    ) -> Result<Config, &'static str> {
        // --snip--
```
为了可读性和更好的通用性，这里的 `args` 类型并没有使用本身的 `std::env::Args` ，而是使用了特征约束的方式来描述 `impl Iterator<Item = String>`，这样意味着 `arg` 可以是任何实现了 `String` 迭代器的类型。
还有一点值得注意，由于迭代器的所有权已经转移到 `build` 内，因此可以直接对其进行修改，这里加上了 `mut` 关键字。
#### 4.9.3 [移除数组索引的使用](https://course.rs/basic-practice/iterators.html#移除数组索引的使用)
数组索引会越界，为了安全性和简洁性，使用 `Iterator` 特征自带的 `next` 方法是一个更好的选择:
```rust
impl Config {
    pub fn build(
        mut args: impl Iterator<Item = String>,
    ) -> Result<Config, &'static str> {
        // 第一个参数是程序名，由于无需使用，因此这里直接空调用一次
        args.next();

        let query = match args.next() {
            Some(arg) => arg,
            None => return Err("Didn't get a query string"),
        };

        let file_path = match args.next() {
            Some(arg) => arg,
            None => return Err("Didn't get a file path"),
        };

        let ignore_case = env::var("IGNORE_CASE").is_ok();

        Ok(Config {
            query,
            file_path,
            ignore_case,
        })
    }
}
```
喔，上面使用了迭代器和模式匹配的代码，看上去是不是很 Rust？我想我们已经走在了正确的道路上。
#### 4.9.4 [使用迭代器适配器让代码更简洁](https://course.rs/basic-practice/iterators.html#使用迭代器适配器让代码更简洁)
为了帮大家更好的回忆和对比，之前的 `search` 长这样：
```rust
// in lib.rs
pub fn search<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
    let mut results = Vec::new();

    for line in contents.lines() {
        if line.contains(query) {
            results.push(line);
        }
    }

    results
}
```
引入了迭代器后，就连古板的 `search` 函数也可以变得更 rusty 些:
```rust
pub fn search<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
    contents
        .lines()
        .filter(|line| line.contains(query))
        .collect()
}
```
Rock，让我们的函数编程 Style rock 起来，这种一行到底的写法有时真的让人沉迷。
### 4.10 rust高级进阶
#### 4.10.1 生命周期




####### 123
