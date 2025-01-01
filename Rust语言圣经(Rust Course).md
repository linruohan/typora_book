# Rust语言圣经(Rust Course)
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
### 3.7 方法 Method
### 3.8 泛型和特征
### 3.9 集合类型
### 3.10 认识生命周期
### 3.11 返回值和错误处理
### 3.12 包和模块
### 3.13 注释和文档

