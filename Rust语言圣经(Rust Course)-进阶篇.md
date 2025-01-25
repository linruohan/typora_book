# Rust语言圣经(Rust Course)-进阶篇
## 1 Rust高级进阶
### 1.1 生命周期
#### 1.1.1 深入生命周期
##### 1.1.1.1 不太聪明的生命周期检查
看看一些本以为可以编译，但是却因为生命周期系统不够聪明导致编译失败的代码。
1. 例子1
```rust
#[derive(Debug)]
struct Foo;
impl Foo {
    fn mutate_and_share(&mut self) -> &Self {
        &*self
    }
    fn share(&self) {}
}
fn main() {
    let mut foo = Foo;
    let loan = foo.mutate_and_share();
    foo.share();
    println!("{:?}", loan);
}
```
上面的代码中，`foo.mutate_and_share()` 虽然借用了 `&mut self`，但是它最终返回的是一个 `&self`，然后赋值给 `loan`，因此理论上来说它最终是进行了不可变借用，同时 `foo.share` 也进行了不可变借用，那么根据 Rust 的借用规则：多个不可变借用可以同时存在，因此该代码应该编译通过。
事实上，运行代码后，你将看到一个错误：
```console
error[E0502]: cannot borrow `foo` as immutable because it is also borrowed as mutable
  --> src/main.rs:12:5
11 |     let loan = foo.mutate_and_share();
   |                ---------------------- mutable borrow occurs here
12 |     foo.share();
   |     ^^^^^^^^^^^ immutable borrow occurs here
13 |     println!("{:?}", loan);
   |                      ---- mutable borrow later used here
```
编译器的提示在这里其实有些难以理解，因为可变借用仅在 `mutate_and_share` 方法内部有效，出了该方法后，就只有返回的不可变借用，因此，按理来说可变借用不应该在 `main` 的作用范围内存在。
对于这个反直觉的事情，让我们用生命周期来解释下，可能你就很好理解了：
```rust
struct Foo;
impl Foo {
    fn mutate_and_share<'a>(&'a mut self) -> &'a Self {
        &'a *self
    }
    fn share<'a>(&'a self) {}
}
fn main() {
    'b: {
        let mut foo: Foo = Foo;
        'c: {
            let loan: &'c Foo = Foo::mutate_and_share::<'c>(&'c mut foo);
            'd: {
                Foo::share::<'d>(&'d foo);
            }
            println!("{:?}", loan);
        }    }}
```
以上是模拟了编译器的生命周期标注后的代码，可以注意到 `&mut foo` 和 `loan` 的生命周期都是 `'c`。
还记得<font color=#81B300>生命周期消除规则中的第三条</font>吗？因为该规则，导致了 `mutate_and_share` 方法中，参数 `&mut self` 和返回值 `&self` 的生命周期是相同的，因此，若返回值的生命周期在 `main` 函数有效，那 `&mut self` 的借用也是在 `main` 函数有效。
<span style="background:#f60909">这就解释了可变借用为啥会在 `main` 函数作用域内有效，最终导致 `foo.share()` 无法再进行不可变借用。</span>
<span style="background:#f500a3">总结</span>下：`&mut self` 借用的生命周期和 `loan` 的生命周期相同，将持续到 `println` 结束。而在此期间 `foo.share()` 又进行了一次不可变 `&foo` 借用，违背了<font color=#81B300>可变借用与不可变借用不能同时存在</font>的规则，最终导致了编译错误。
上述代码实际上完全是正确的，但是因为生命周期系统的“粗糙实现”，导致了编译错误，目前来说，遇到这种生命周期系统不够聪明导致的编译错误，我们也没有太好的办法，只能修改代码去满足它的需求，并期待以后它会更聪明。
2. 例子2
```rust
#![allow(unused)]
fn main() {
    use std::collections::HashMap;
    use std::hash::Hash;
    fn get_default<'m, K, V>(map: &'m mut HashMap<K, V>, key: K) -> &'m mut V
    where
        K: Clone + Eq + Hash,
        V: Default,
    {
        match map.get_mut(&key) {
            Some(value) => value,
            None => {
                map.insert(key.clone(), V::default());
                map.get_mut(&key).unwrap()
            }        }    }}
```
这段代码不能通过编译的原因是<span style="background:#f60909">编译器未能精确地判断出某个可变借用不再需要，反而谨慎的给该借用安排了一个很大的作用域，结果导致后续的借用失败：</span>
```console
error[E0499]: cannot borrow `*map` as mutable more than once at a time
  --> src/main.rs:13:17
5  |       fn get_default<'m, K, V>(map: &'m mut HashMap<K, V>, key: K) -> &'m mut V
   |                      -- lifetime `'m` defined here
10 |           match map.get_mut(&key) {
   |           -     ----------------- first mutable borrow occurs here
   |  _________|
11 | |             Some(value) => value,
12 | |             None => {
13 | |                 map.insert(key.clone(), V::default());
   | |                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ second mutable borrow occurs here
14 | |                 map.get_mut(&key).unwrap()
   | |_________- returning this value requires that `*map` is borrowed for `'m`
```
分析代码可知在 `match map.get_mut(&key)` 方法调用完成后，对 `map` 的可变借用就可以结束了。但从报错看来，编译器不太聪明，它认为该借用会持续到整个 `match` 语句块的结束(第 16 行处)，这便造成了后续借用的失败。
类似的例子还有很多，由于篇幅有限，就不在这里一一列举，如果大家想要阅读更多的类似代码，可以看看[《Rust 代码鉴赏》](https://github.com/sunface/rust-codes)一书。
##### 1.1.1.2 无界生命周期
- 不安全代码(`unsafe`)经常会凭空产生引用或生命周期，这些生命周期被称为是 **无界(unbound)** 的。
无界生命周期往往是在解引用一个裸指针(裸指针 raw pointer)时产生的，换句话说，它是凭空产生的，因为输入参数根本就没有这个生命周期：
```rust
fn f<'a, T>(x: *const T) -> &'a T {
    unsafe {
        &*x
    }}
```
上述代码中，参数 `x` 是一个裸指针，它并没有任何生命周期，然后通过 `unsafe` 操作后，它被进行了解引用，变成了一个 Rust 的标准引用类型，该类型必须要有生命周期，也就是 `'a`。
可以看出 `'a` 是凭空产生的，因此它是无界生命周期。这种生命周期由于没有受到任何约束，因此它想要多大就多大，这实际上比 `'static` 要强大。例如 `&'static &'a T` 是无效类型，但是无界生命周期 `&'unbounded &'a T` 会被视为 `&'a &'a T` 从而通过编译检查，因为它可大可小\
我们在实际应用中，要尽量避免这种无界生命周期。
最简单的避免无界生命周期的方式就是<span style="background:green">在函数声明中运用生命周期消除规则</span>。
**若一个输出生命周期被消除了，那么必定因为有一个输入生命周期与之对应**。
##### 1.1.1.3 生命周期约束 HRTB
生命周期约束跟特征约束类似，都是通过形如 `'a: 'b` 的语法，来说明两个生命周期的长短关系。
###### 1.1.1.3.1 'a: 'b
假设有两个引用 `&'a i32` 和 `&'b i32`，它们的生命周期分别是 `'a` 和 `'b`，若 `'a` >= `'b`，则可以定义 `'a:'b`，表示 `'a` 至少要活得跟 `'b` 一样久。
```rust
struct DoubleRef<'a,'b:'a, T> {
    r: &'a T,
    s: &'b T  }
```
例如上述代码定义一个结构体，它拥有两个引用字段，类型都是泛型 `T`，每个引用都拥有自己的生命周期，由于我们使用了生命周期约束 `'b: 'a`，因此 `'b` 必须活得比 `'a` 久，也就是结构体中的 `s` 字段引用的值必须要比 `r` 字段引用的值活得要久。
###### 1.1.1.3.2 T: 'a
表示类型 `T` 必须比 `'a` 活得要久：
```rust
struct Ref<'a, T: 'a> {
    r: &'a T
}
```
因为结构体字段 `r` 引用了 `T`，因此 `r` 的生命周期 `'a` 必须要比 `T` 的生命周期更短(**被引用者的生命周期必须要比引用长**)。
在 Rust 1.30 版本之前，该写法是必须的，但是从 <span style="background:#0779e4">1.31 版本开始</span>，编译器可以自动推导 `T: 'a` 类型的约束，因此我们只需这样写即可：
```rust
struct Ref<'a, T> {
    r: &'a T
}
```
来看一个使用了生命周期约束的综合例子：
```rust
struct ImportantExcerpt<'a> {
    part: &'a str,
}
impl<'a: 'b, 'b> ImportantExcerpt<'a> {
    fn announce_and_return_part(&'a self, announcement: &'b str) -> &'b str {
        println!("Attention please: {}", announcement);
        self.part
    }
}
```
上面的例子中必须添加约束 `'a: 'b` 后，才能成功编译，因为 `self.part` 的生命周期与 `self`的生命周期一致，将 `&'a` 类型的生命周期强行转换为 `&'b` 类型，会报错，只有在 `'a` >= `'b` 的情况下，`'a` 才能转换成 `'b`。
##### 1.1.1.4 闭包函数的消除规则
先来看一段简单的代码：
```rust
fn fn_elision(x: &i32) -> &i32 { x }
let closure_slision = |x: &i32| -> &i32 { x };
// error: lifetime may not live long enough
  --> src/main.rs:39:39
39 |     let closure = |x: &i32| -> &i32 { x }; // fails
   |                       -        -      ^ returning this value requires that `'1` must outlive `'2`
   |                       |        |
   |                       |        let's call the lifetime of this reference `'2`
   |                       let's call the lifetime of this reference `'1`
```
咦？竟然报错了，明明两个一模一样功能的函数，一个正常编译，一个却报错，错误原因是编译器无法推测返回的引用和传入的引用谁活得更久！
真的是非常奇怪的错误，学过上一节的读者应该都记得这样一条生命周期消除规则：**如果函数参数中只有一个引用类型，那该引用的生命周期会被自动分配给所有的返回引用**。我们当前的情况完美符合， `function` 函数的顺利编译通过，就充分说明了问题。
先给出一个结论：**这个问题，可能很难被解决，建议大家遇到后，还是老老实实用正常的函数，不要秀闭包了**。
对于函数的生命周期而言，它的消除规则之所以能生效是因为它的生命周期完全体现在签名的引用类型上，在函数体中无需任何体现：
```rust
fn fn_elision(x: &i32) -> &i32 {..}
```
因此编译器可以做各种编译优化，也很容易根据参数和返回值进行生命周期的分析，最终得出消除规则。
可是闭包，并没有函数那么简单，它的生命周期分散在参数和闭包函数体中(主要是它没有确切的返回值签名)：
```rust
let closure_slision = |x: &i32| -> &i32 { x };
```
编译器就必须深入到闭包函数体中，去分析和推测生命周期，复杂度因此急剧提升：试想一下，编译器该如何从复杂的上下文中分析出参数引用的生命周期和闭包体中生命周期的关系？
由于上述原因(当然，实际情况复杂的多)，Rust 语言开发者目前其实是有意针对函数和闭包实现了两种不同的生命周期消除规则。
> **用 `Fn` 特征解决闭包生命周期**
> 之前我们提到了很难解决，但是并没有完全堵死(论文字的艺术- , -) 这不 @Ykong1337 同学就带了一个解决方法，为他点赞!
 ```rust
 fn main() {
    let closure_slision = fun(|x: &i32| -> &i32 { x });
    assert_eq!(*closure_slision(&45), 45);
    // Passed !
 }
 fn fun<T, F: Fn(&T) -> &T>(f: F) -> F {
    f    }
 ```
##### 1.1.1.5 NLL (Non-Lexical Lifetime)
之前我们在[引用与借用](https://course.rs/basic/ownership/borrowing.html#NLL)那一章其实有讲到过这个概念，简单来说就是：**引用的生命周期正常来说应该从借用开始一直持续到作用域结束**，但是这种规则会让多引用共存的情况变得更复杂：
```rust
fn main() {
   let mut s = String::from("hello");
    let r1 = &s;
    let r2 = &s;
    println!("{} and {}", r1, r2);
    // 新编译器中，r1,r2作用域在这里结束
    let r3 = &mut s;
    println!("{}", r3);
}
```
按照上述规则，这段代码将会报错，因为 `r1` 和 `r2` 的不可变引用将持续到 `main` 函数结束，而在此范围内，我们又借用了 `r3` 的可变引用，这违反了借用的规则：要么多个不可变借用，要么一个可变借用。
好在，该规则从 1.31 版本引入 `NLL` 后，就变成了：**引用的生命周期从借用处开始，一直持续到最后一次使用的地方**。
按照最新的规则，我们再来分析一下上面的代码。`r1` 和 `r2` 不可变借用在 `println!` 后就不再使用，因此生命周期也随之结束，那么 `r3` 的借用就不再违反借用的规则，皆大欢喜。
再来看一段关于 `NLL` 的代码解释：
```rust
let mut u = 0i32;
let mut v = 1i32;
let mut w = 2i32;

// lifetime of `a` = α ∪ β ∪ γ
let mut a = &mut u;     // --+ α. lifetime of `&mut u`  --+ lexical "lifetime" of `&mut u`,`&mut u`, `&mut w` and `a`
use(a);                 //   |                            |
*a = 3; // <-----------------+                            |
...                     //                                |
a = &mut v;             // --+ β. lifetime of `&mut v`    |
use(a);                 //   |                            |
*a = 4; // <-----------------+                            |
...                     //                                |
a = &mut w;             // --+ γ. lifetime of `&mut w`    |
use(a);                 //   |                            |
*a = 5; // <-----------------+ <--------------------------+
```
这段代码一目了然，`a` 有三段生命周期：`α`，`β`，`γ`，每一段生命周期都随着当前值的最后一次使用而结束。
在实际项目中，`NLL` 规则可以大幅减少引用冲突的情况，极大的便利了用户，因此广受欢迎，最终该规则甚至演化成一个独立的项目，未来可能会进一步简化我们的使用，`Polonius`：
- [项目地址](https://github.com/rust-lang/polonius)
- [具体介绍](http://smallcultfollowing.com/babysteps/blog/2018/04/27/an-alias-based-formulation-of-the-borrow-checker/)
##### 1.1.1.6 Reborrow 再借用
学完 `NLL` 后，我们就有了一定的基础，可以继续学习关于借用和生命周期的一个高级内容：**再借用**。
```rust
#[derive(Debug)]
struct Point {
    x: i32,
    y: i32,
}
impl Point {
    fn move_to(&mut self, x: i32, y: i32) {
        self.x = x;
        self.y = y;
    }
}
fn main() {
    let mut p = Point { x: 0, y: 0 };
    let r = &mut p;
    let rr: &Point = &*r;
    println!("{:?}", rr);
    r.move_to(10, 10);
    println!("{:?}", r);
}
```
以上代码，大家可能会觉得可变引用 `r` 和不可变引用 `rr` 同时存在会报错吧？但是事实上并不会，原因在于 `rr` 是对 `r` 的再借用。
对于再借用而言，`rr` 再借用时不会破坏借用规则，但是你不能在它的生命周期内再使用原来的借用 `r`，来看看对上段代码的分析：
```rust
fn main() {
    let mut p = Point { x: 0, y: 0 };
    let r = &mut p;
    // reborrow! 此时对`r`的再借用不会导致跟上面的借用冲突
    let rr: &Point = &*r;

    // 再借用`rr`最后一次使用发生在这里，在它的生命周期中，我们并没有使用原来的借用`r`，因此不会报错
    println!("{:?}", rr);

    // 再借用结束后，才去使用原来的借用`r`
    r.move_to(10, 10);
    println!("{:?}", r);
}
```
再来看一个例子：
```rust
use std::vec::Vec;
fn read_length(strings: &mut Vec<String>) -> usize {
   strings.len()
}
```
如上所示，函数体内对参数的二次借用也是典型的 `Reborrow` 场景。
那么下面让我们来做件坏事，破坏这条规则，使其报错：
```rust
fn main() {
    let mut p = Point { x: 0, y: 0 };
    let r = &mut p;
    let rr: &Point = &*r;
    r.move_to(10, 10);
    println!("{:?}", rr);
    println!("{:?}", r);
}
```
果然，破坏永远比重建简单 :) 只需要在 `rr` 再借用的生命周期内使用一次原来的借用 `r` 即可！
##### 1.1.1.7 生命周期消除规则补充
在上一节中，我们介绍了三大基础生命周期消除规则，实际上，随着 Rust 的版本进化，该规则也在不断演进，
这里再介绍几个常见的消除规则：
###### 1.1.1.7.1 impl 块消除
```rust
impl<'a> Reader for BufReader<'a> {
    // methods go here
    // impl内部实际上没有用到'a
}
```
如果你以前写的`impl`块长上面这样，同时在 `impl` 内部的方法中，根本就没有用到 `'a`，那就可以写成下面的代码形式。
```rust
impl Reader for BufReader<'_> {
    // methods go here
}
```
`'_` 称为匿名生命周期（anonymous lifetime），在这里表示 `BufReader` 有一个不使用的生命周期，我们可以忽略它，无需为它创建一个名称。
歪个楼，有读者估计会发问：既然用不到 `'a`，为何还要写出来？如果你仔细回忆下上一节的内容，里面有一句专门用粗体标注的文字：**生命周期参数也是类型的一部分**，因此 `BufReader<'a>` 是一个完整的类型，在实现它的时候，你不能把 `'a` 给丢了！
###### 1.1.1.7.2 生命周期约束消除
```rust
// Rust 2015
struct Ref<'a, T: 'a> {
    field: &'a T
}

// Rust 2018
struct Ref<'a, T> {
    field: &'a T
}
```
在本节的生命周期约束中，也提到过，新版本 Rust 中，上面情况中的 `T: 'a` 可以被消除掉，当然，你也可以显式的声明，但是会影响代码可读性。关于类似的场景，Rust 团队计划在未来提供更多的消除规则，但是，你懂的，计划未来就等于未知。
##### 1.1.1.8 一个复杂的例子
下面是一个关于生命周期声明过大的例子，会较为复杂，希望大家能细细阅读，它能帮你对生命周期的理解更加深入。
```rust
struct Interface<'a> {
    manager: &'a mut Manager<'a>
}
impl<'a> Interface<'a> {
    pub fn noop(self) {
        println!("interface consumed");
    }
}
struct Manager<'a> {
    text: &'a str
}
struct List<'a> {
    manager: Manager<'a>,
}
impl<'a> List<'a> {
    pub fn get_interface(&'a mut self) -> Interface {
        Interface {
            manager: &mut self.manager
        }
    }
}
fn main() {
    let mut list = List {
        manager: Manager {
            text: "hello"
        }
    };
    list.get_interface().noop();
    println!("Interface should be dropped here and the borrow released");
    // 下面的调用会失败，因为同时有不可变/可变借用
    // 但是Interface在之前调用完成后就应该被释放了
    use_list(&list);
}

fn use_list(list: &List) {
    println!("{}", list.manager.text);
}
```
运行后报错：
```console
error[E0502]: cannot borrow `list` as immutable because it is also borrowed as mutable // `list`无法被借用，因为已经被可变借用
  --> src/main.rs:40:14
   |
34 |     list.get_interface().noop();
   |     ---- mutable borrow occurs here // 可变借用发生在这里
40 |     use_list(&list);
   |              ^^^^^
   |              immutable borrow occurs here // 新的不可变借用发生在这
   |              mutable borrow later used here // 可变借用在这里结束
```
这段代码看上去并不复杂，实际上难度挺高的，首先在直觉上，`list.get_interface()` 借用的可变引用，按理来说应该在这行代码结束后，就归还了，但是为什么还能持续到 `use_list(&list)` 后面呢？
这是因为我们在 `get_interface` 方法中声明的 `lifetime` 有问题，该方法的参数的生命周期是 `'a`，而 `List` 的生命周期也是 `'a`，说明该方法至少活得跟 `List` 一样久，再回到 `main` 函数中，`list` 可以活到 `main` 函数的结束，因此 `list.get_interface()` 借用的可变引用也会活到 `main` 函数的结束，在此期间，自然无法再进行借用了。
要解决这个问题，我们需要为 `get_interface` 方法的参数给予一个不同于 `List<'a>` 的生命周期 `'b`，最终代码如下：
```rust
struct Interface<'b, 'a: 'b> {
    manager: &'b mut Manager<'a>
}
impl<'b, 'a: 'b> Interface<'b, 'a> {
    pub fn noop(self) {
        println!("interface consumed");
    }
}
struct Manager<'a> {
    text: &'a str
}
struct List<'a> {
    manager: Manager<'a>,
}
impl<'a> List<'a> {
    pub fn get_interface<'b>(&'b mut self) -> Interface<'b, 'a>
    where 'a: 'b {
        Interface {
            manager: &mut self.manager
        }    }}
fn main() {
    let mut list = List {
        manager: Manager {
            text: "hello"
        }
    };
    list.get_interface().noop();
    println!("Interface should be dropped here and the borrow released");
    // 下面的调用可以通过，因为Interface的生命周期不需要跟list一样长
    use_list(&list);
}
fn use_list(list: &List) {
    println!("{}", list.manager.text);
}
```
至此，生命周期终于完结，两章超级长的内容，可以满足几乎所有对生命周期的学习目标。学完生命周期，意味着你正式入门了 Rust，只要再掌握几个常用概念，就可以上手写项目了。
`Self`表示实现了该方法的类型
`&Self`表示该类型的引用；  
`self`表示传入实例方法的参数名
`&self`是`self: &Self`的缩写语法糖；  
（`self`单独作参数时，是`self: Self`的缩写语法糖）  
`&*self`在例子中是对参数`self: &mut Self`的不可变再借用。
&self 等价与 self: &Self  
&mut self 等价与 self：&mut Self
#### 1.1.2 &'static 和 T: 'static
1. 字符串字面值就具有 `'static` 生命周期:
```rust
fn main() {
  let mark_twain: &str = "Samuel Clemens";
  print_author(mark_twain);
}
fn print_author(author: &'static str) {
  println!("{}", author);
}
```
2. 特征对象的生命周期：
```rust
use std::fmt::Display;
fn main() {
    let mark_twain = "Samuel Clemens";
    print(&mark_twain);
// 生命周期约束
fn print<T: Display + 'static>(message: &T) {
    println!("{}", message);
}
```
##### 1.1.2.1 &'static
<font color=#F36208>一个引用必须要活得跟剩下的程序一样久，才能被标注为 &'static</font>
对于字符串字面量来说，它直接被打包到二进制文件中，永远不会被 `drop`，因此它能跟程序活得一样久，自然它的生命周期是 `'static`。
但是，**`&'static` 生命周期针对的仅仅是引用，而不是持有该引用的变量，对于变量来说，还是要遵循相应的作用域规则** :
```rust
use std::{slice::from_raw_parts, str::from_utf8_unchecked};
fn get_memory_location() -> (usize, usize) {
  // “Hello World” 是字符串字面量，因此它的生命周期是 `'static`.
  // 但持有它的变量 `string` 的生命周期就不一样了，它完全取决于变量作用域，对于该例子来说，也就是当前的函数范围
  let string = "Hello World!";
  let pointer = string.as_ptr() as usize;
  let length = string.len();
  (pointer, length)
  // `string` 在这里被 drop 释放
  // 虽然变量被释放，无法再被访问，但是数据依然还会继续存活
}

fn get_str_at_location(pointer: usize, length: usize) -> &'static str {
  // 使用裸指针需要 `unsafe{}` 语句块
  unsafe { from_utf8_unchecked(from_raw_parts(pointer as *const u8, length)) }
}

fn main() {
  let (pointer, length) = get_memory_location();
  let message = get_str_at_location(pointer, length);
  println!(
    "The {} bytes at 0x{:X} stored: {}",
    length, pointer, message
  );
  // 如果大家想知道为何处理裸指针需要 `unsafe`，可以试着反注释以下代码
  // let message = get_str_at_location(1000, 10);
}
```
- `&'static` 的引用确实可以和程序活得一样久，因为我们通过 `get_str_at_location` 函数直接取到了对应的字符串
- 持有 `&'static` 引用的变量，它的生命周期受到作用域的限制，大家务必不要搞混了
##### 1.1.2.2 T: 'static
首先，在以下两种情况下，`T: 'static` 与 `&'static` 有相同的约束：`T` 必须活得和程序一样久。
```rust
use std::fmt::Debug;
fn print_it<T: Debug + 'static>( input: T) { //`&i` 的生命周期无法满足 `'static` 的约束，如果大家将 `i` 修改为常量，那自然一切 OK
fn print_it<T: Debug + 'static>( input: &T) { // 这段代码竟然不报错了！原因在于我们约束的是 `T`，但是使用的却是它的引用 `&T`，换而言之，我们根本没有直接使用 `T`，因此编译器就没有去检查 `T` 的生命周期约束！它只要确保 `&T` 的生命周期符合规则即可，在上面代码中，它自然是符合的。
    println!( "'static value passed in is: {:?}", input );
}
fn print_it1( input: impl Debug + 'static ) {
    println!( "'static value passed in is: {:?}", input );
}
fn main() {
    let i = 5;
    print_it(&i);
    print_it1(&i);
}
```
```rust
use std::fmt::Display;
fn main() {
  let r1;
  let r2;
  {
    static STATIC_EXAMPLE: i32 = 42;
    r1 = &STATIC_EXAMPLE;
    let x = "&'static str";
    r2 = x;
    // r1 和 r2 持有的数据都是 'static 的，因此在花括号结束后，并不会被释放
  }

  println!("&'static i32: {}", r1); // -> 42
  println!("&'static str: {}", r2); // -> &'static str

  let r3: &str;

  {
    let s1 = "String".to_string();

    // s1 虽然没有 'static 生命周期，但是它依然可以满足 T: 'static 的约束
    // 充分说明这个约束是多么的弱。。
    static_bound(&s1);

    // s1 是 String 类型，没有 'static 的生命周期，因此下面代码会报错
    r3 = &s1;

    // s1 在这里被 drop
  }
  println!("{}", r3);
}

fn static_bound<T: Display + 'static>(t: &T) {
  println!("{}", t);
}
```
##### 1.1.2.3 static 到底针对谁？
到底是 `&'static` 这个引用还是该引用指向的数据活得跟程序一样久呢？
**答案是引用指向的数据**，而引用本身是要遵循其作用域范围的
```rust
fn main() {
    {
        let static_string = "I'm in read-only memory";
        println!("static_string: {}", static_string);
        // 当 `static_string` 超出作用域时，该引用不能再被使用，但是数据依然会存在于 binary 所占用的内存中
    }
    println!("static_string reference remains alive: {}", static_string); ❌
}
```
以上代码不出所料会报错，原因在于虽然字符串字面量 "I'm in read-only memory" 的生命周期是 `'static`，但是持有它的引用并不是，它的作用域在内部花括号 `}` 处就结束了。
##### 1.1.2.4 总结
总之， &'static 和 T: 'static 大体上相似，相比起来，后者的使用形式会更加复杂一些。
至此，相信大家对于 'static 和 T: 'static 也有了清晰的理解，那么我们应该如何使用它们呢？
作为经验之谈，可以这么来:
1. 如果你需要添加 &'static 来让代码工作，那很可能是设计上出问题了
2. 如果你希望满足和取悦编译器，那就使用 T: 'static，很多时候它都能解决问题
&'static表示的是任意一种从头活到尾的类型比如string，实际用途更偏向于指针，表示指向一种生命周期为'static的数据类型，T:'static更偏向于泛型，用于定义一种类型
&'static 声明变量指向的内存，是具有static lifetime的。但是这个变量本身还会在超出block时被释放。  
T：‘static 声明的是T这个类型的lifetime是被static约束的，当然也就比static长。  
注意，T可能是&类型。
###### 1.1.2.4.1 str，&str和String有什么区别

1. str是字面值，在程序运行过程中不会改变的（但是在定义时，是长度可变的）
2. 由于str在定义时长度可变，编译器无法提前预知str类型的长度，所以有了&str类型。  
    &str类型本质上就是一个指针，长度固定
3. String则是为了解决str在程序运行过程中无法改变的痛点，同时满足动态定义和动态改变
###### 1.1.2.4.2 &'static解析
首先明确一点，生命周期概念是针对 “引用” 设立的。对于非引用类型（比如普通的i32，u32，String等）都无效了
再看 “&'static” 长的这个鸟样，是不是和上面提到的&str很像。由此可得，'static要求的是str，要求的是被引的对象。
表达得不好，看下面这段示例代码，就可以理解了：
```rust
use std::fmt::Display;
fn mian() {
    static A_STATIC: i32 = 1;
    let a = 2;
    {
     let b = 3;
        static_bound(b);        // 正确，不为引用类型
        //static_bound(&b);     // 错误，引用类型，且生命周期不为static
    }
    static_bound(a);            // 正确，不为引用类型
    //static_bound(&a);         // 错误，引用类型，且生命周期不为static
    static_bound(A_STATIC);     // 正确，不为引用类型
    static_bound(&A_STATIC);    // 正确，引用类型，且生命周期为static
}
fn static_bound<T: Display + 'static>(t: T) {
    println!("{t}");
}
```
###### 1.1.2.4.3 T: 'static解析
对于 **"T: 'static"** ，需要分类讨论：
1. 当T是普通类型（非引用）时，则直接通过要求，不检查static
2. 当T时引用类型时，检查被引用的对象是否为static。static通过，非static打回去
当一个类型内部持有引用这种情况下，即便这个类型传进去的时候不是个引用，并且它持有的那个引用在函数执行的过程中是安全的，只要它持有的引用的生命周期不是'static，就无法通过编译检查。
```rust
use std::fmt::Debug;

fn print_it<T: 'static + Debug>(x: T) {
    println!("{:?}", x);
}

#[derive(Debug)]
struct MaybeStatic<'a> {
    msg: &'a str,
}

fn main() {
    let has_static = MaybeStatic { msg: "It is static" };
    
    let str = String::from("Is not static");
    let not_static = MaybeStatic { msg: &str };

    print_it(has_static);
    // print_it(not_static);
}
```
### 1.2 函数式编程
函数式语言的优秀特性
- 使用函数作为参数进行传递
- 使用函数作为函数返回值
- 将函数赋值给变量
<span style="background:red">函数式特性</span>：
- 闭包 Closure
- 迭代器 Iterator
- 模式匹配
- 枚举
#### 1.2.1 闭包 Closure
闭包是**一种匿名函数，它可以赋值给变量也可以作为参数传递给其它函数，不同于函数的是，它允许捕获调用者作用域中的值**，例如：
```rust
fn main() {
   let x = 1;
   let sum = |y| x + y;  //可以赋值给变量，允许捕获调用者作用域中的值
    assert_eq!(3, sum(2));
}
```
非常简单的闭包 `sum`，它拥有一个入参 `y`，同时捕获了作用域中的 `x` 的值，因此调用 `sum(2)` 意味着将 2（参数 `y`）跟 1（`x`）进行相加，最终返回它们的和：`3`。
#### 1.2.2 使用闭包来简化代码
##### 1.2.2.1 传统函数实现
在健身时我们根据想要的强度来调整具体的动作，然后调用 `muuuuu` 函数来开始健身。这个程序本身很简单，没啥好说的，但是假如未来不用 `muuuuu` 函数了，是不是得把所有 `muuuuu` 都替换成，比如说 `woooo` ？如果 `muuuuu` 出现了几十次，那意味着我们要修改几十处地方。
```rust
use std::thread;
use std::time::Duration;

// 开始健身，好累，我得发出声音：muuuu...
fn muuuuu(intensity: u32) -> u32 {
    println!("muuuu.....");
    thread::sleep(Duration::from_secs(2));
    intensity
}
fn workout(intensity: u32, random_number: u32) {
    if intensity < 25 {
        println!(
            "今天活力满满，先做 {} 个俯卧撑!",
            muuuuu(intensity)
        );
        println!(
            "旁边有妹子在看，俯卧撑太low，再来 {} 组卧推!",
            muuuuu(intensity)
        );
    } else if random_number == 3 {
        println!("昨天练过度了，今天还是休息下吧！");
    } else {
        println!(
            "昨天练过度了，今天干干有氧，跑步 {} 分钟!",
            muuuuu(intensity)
        );
    }
}

fn main() {
    // 强度
    let intensity = 10;
    // 随机值用来决定某个选择
    let random_number = 7;

    // 开始健身
    workout(intensity, random_number);
}
```
##### 1.2.2.2 函数变量实现
把函数赋值给一个变量，然后通过变量调用
经过修改后，所有的调用都通过 `action` 来完成，若未来声(动)音(作)变了，只要修改为 `let action = woooo` 即可。
但是问题又来了，若 `intensity` 也变了怎么办？例如变成 `action(intensity + 1)`，那你又得哐哐哐修改几十处调用。
```rust
use std::thread;
use std::time::Duration;

// 开始健身，好累，我得发出声音：muuuu...
fn muuuuu(intensity: u32) -> u32 {
    println!("muuuu.....");
    thread::sleep(Duration::from_secs(2));
    intensity
}

fn workout(intensity: u32, random_number: u32) {
    let action = muuuuu;
    if intensity < 25 {
        println!(
            "今天活力满满, 先做 {} 个俯卧撑!",
            action(intensity)
        );
        println!(
            "旁边有妹子在看，俯卧撑太low, 再来 {} 组卧推!",
            action(intensity)
        );
    } else if random_number == 3 {
        println!("昨天练过度了，今天还是休息下吧！");
    } else {
        println!(
            "昨天练过度了，今天干干有氧, 跑步 {} 分钟!",
            action(intensity)
        );
    }
}

fn main() {
    // 强度
    let intensity = 10;
    // 随机值用来决定某个选择
    let random_number = 7;

    // 开始健身
    workout(intensity, random_number);
}
```
##### 1.2.2.3 闭包实现
无论你要修改什么，只要修改闭包 `action` 的实现即可，其它地方只负责调用，完美解决了我们的问题！
```rust
use std::thread;
use std::time::Duration;

fn workout(intensity: u32, random_number: u32) {
    let action = || {
        println!("muuuu.....");
        thread::sleep(Duration::from_secs(2));
        intensity
    };

    if intensity < 25 {
        println!(
            "今天活力满满，先做 {} 个俯卧撑!",
            action()
        );
        println!(
            "旁边有妹子在看，俯卧撑太low，再来 {} 组卧推!",
            action()
        );
    } else if random_number == 3 {
        println!("昨天练过度了，今天还是休息下吧！");
    } else {
        println!(
            "昨天练过度了，今天干干有氧，跑步 {} 分钟!",
            action()
        );
    }
}

fn main() {
    // 动作次数
    let intensity = 10;
    // 随机值用来决定某个选择
    let random_number = 7;

    // 开始健身
    workout(intensity, random_number);
}
```
###### 1.2.2.3.1 闭包
Rust 闭包在形式上借鉴了 `Smalltalk` 和 `Ruby` 语言，与函数最大的不同就是它的参数是通过 `|parm1|` 的形式进行声明，如果是多个参数就 `|param1, param2,...|`， 下面给出闭包的形式定义：
```rust
|param1, param2,...| {
    语句1;
    语句2;
    返回表达式
}
```
如果只有一个返回表达式的话，定义可以简化为：
```rust
|param1| 返回表达式
```
- **闭包中最后一行表达式返回的值，就是闭包执行后的返回值**，因此 `action()` 调用返回了 `intensity` 的值 `10`
- `let action = ||...` 只是把闭包赋值给变量 `action`，并不是把闭包执行后的结果赋值给 `action`，因此这里 `action` 就相当于闭包函数，可以跟函数一样进行调用：`action()`
#### 1.2.3 闭包的类型推导
与函数相反，闭包并不会作为 API 对外提供，因此它可以享受编译器的类型推导能力，无需标注参数和返回值的类型。
为了增加代码可读性，有时候我们会显式地给类型进行标注，出于同样的目的，也可以给闭包标注类型：
```rust
let sum = |x: i32, y: i32| -> i32 {
    x + y
}
//不标注类型的闭包声明会更简洁些：
let sum  = |x, y| x + y;
// 如果你只进行了声明，但是没有使用，编译器会提示你为 `x, y` 添加类型标注，因为它缺乏必要的上下文：
let v = sum(1, 2);
```
###### 1.2.3.1.1 同一个功能的函数和闭包实现形式
```rust
fn  add_one_v1   (x: u32) -> u32 { x + 1 }
let add_one_v2 = |x: u32| -> u32 { x + 1 };
let add_one_v3 = |x|             { x + 1 };  // 省略参数
let add_one_v4 = |x|               x + 1  ; // 返回值类型 花括号对
```
虽然类型推导很好用，但是它不是泛型，**当编译器推导出一种类型后，它就会一直使用该类型**：
```rust
let example_closure = |x| x;

let s = example_closure(String::from("hello"));  // 编译器为 `x` 推导出类型 `String`
let n = example_closure(5);  // 跟编译器之前推导的 `String` 类型不符 ❌
```
#### 1.2.4 结构体中的闭包
实现一个简易缓存，功能是获取一个值，然后将其缓存起来，
- 一个闭包用于获取值
- 一个变量，用于存储该值
```rust
struct Cacher<T>
where
    T: Fn(u32) -> u32,
{
    query: T,
    value: Option<u32>,
}
```
`Fn(u32) -> u32` 是 `T` 的特征约束， 是一个特征，用来表示 `T` 是一个闭包类型
那为什么不用具体的类型来标注 `query` 呢？原因很简单，每一个闭包实例都有独属于自己的类型，即使于两个签名一模一样的闭包，它们的类型也是不同的，因此你无法用一个统一的类型来标注 `query` 闭包。
而标准库提供的 `Fn` 系列特征，再结合特征约束，就能很好的解决了这个问题. `T: Fn(u32) -> u32` 意味着 `query` 的类型是 `T`，该类型必须实现了相应的闭包特征 `Fn(u32) -> u32`。从特征的角度来看它长得非常反直觉，但是如果从闭包的角度来看又极其符合直觉，不得不佩服 Rust 团队的鬼才设计。。。
特征 `Fn(u32) -> u32` 从表面来看，就对闭包形式进行了显而易见的限制：**该闭包拥有一个`u32`类型的参数，同时返回一个`u32`类型的值**。