# Rust 精简入门

# **一、基础**

## **1、基本类型**

- 整数类型：**`i8`**, **`i16`**, **`i32`**, **`i64`**, **`i128`** , **`isize`**, **`u8`**, **`u16`**, **`u32`**, **`u64`**, **`u128`**, **`usize`**
- 浮点类型：**`f32`**, **`f64`**
- 布尔类型：**`bool`**（**`true`**/**`false`**）
- 字符类型：**`char`**（Unicode 字符）
- 单元类型：**`()`**

## **2、变量**

- 默认不可变：**`let x = 5;`**
- 可变变量：**`let mut x = 5;`**
- 变量隐藏：**`let x = 5; let x = x + 1;`**
- 常量：**`const MAX_POINTS: u32 = 100_000;`**

## **3、复杂类型**

- 元组：**`let tup: (i32, f64, u8) = (500, 6.4, 1);`**
- 数组：**`let a: [i32; 5] = [1, 2, 3, 4, 5];`**
- 切片：**`&[i32]`**, **`&str`**
- 字符串：**`String`**, **`&str`**
- 结构体：**`struct User { username: String, ... }`**
- 枚举：**`enum IpAddrKind { V4, V6 }`**

## **4、流程控制**

- **`if`**/**`else`**：**`if condition { ... } else { ... }`**
- **`loop`**：无限循环，使用**`break`**退出
- **`while`**：**`while condition { ... }`**
- **`for`**：**`for element in collection { ... }`**
- **`match`**：模式匹配

## **5、所有权**

- 规则：每个值有唯一所有者；所有者离开作用域，值被丢弃
- 移动：**`let s2 = s1;`** （s1 不再有效）
- 克隆：**`let s2 = s1.clone();`**

## **6、引用和生命周期**

- 不可变引用：**`&T`**
- 可变引用：**`&mut T`**
- 借用规则：同时只能有一个可变引用或多个不可变引用
- 生命周期：**`'a`**，确保引用有效

案例：

```rust
use std::collections::HashMap;

fn main() {
    let query = String::from("name=Venus&age=24&hobby=coding");
    let qp = QueryParser::from_string(query.clone());
    println!("params: {:#?}", qp);
    
    let qp2 = EnhancedQueryParser::from_string(&query);
    println!("params: {:#?}", qp2);
    let name = qp2.params.get("name").unwrap();
    println!("name: {}", name);
}

#[derive(Debug)]
struct QueryParser {
    query: String,
    params: HashMap<String, String>
}

impl QueryParser {
    fn from_string(query: String) -> Self {
        // name=value&name=value
        let params: HashMap<String, String> = query.split("&")
            .map(|item| {
                let mut parts = item.split("=");
                let key = String::from(parts.next().expect("no key"));
                let value = String::from(parts.next().unwrap());
                (key, value)
            })
            .collect();

        Self {
            query,
            params,
        }
    }
}

#[derive(Debug)]
struct EnhancedQueryParser<'a> {
    query: &'a str,
    params: HashMap<&'a str, &'a str>
}

impl<'a> EnhancedQueryParser<'a> {
    fn from_string(query: &'a str) -> Self {
        let params: HashMap<&'a str, &'a str>  = query.split("&")
            .map(|kv| {
                let mut parts = kv.split("=");
                (
                    parts.next().unwrap(),
                    parts.next().unwrap()
                )
            })
            .collect();
        
        Self {
            query,
            params
        }
    }
}
```

## 7、特征 Trait

- 定义共享行为的接口：

  ```rust
  trait Summary {
      fn summarize(&self) -> String;
      fn default_behavior(&self) -> String {
          String::from("默认实现")
      }
  }
  ```

- 为类型实现特征：

  ```rust
  impl Summary for NewsArticle {
      fn summarize(&self) -> String {
          format!("{}, by {}", self.headline, self.author)
      }
  }
  ```

- 特征约束：**`fn notify<T: Summary>(item: &T) { ... }`**

- 多重约束：**`fn notify<T: Summary + Display>(item: &T) { ... }`**

- where 子句：

  ```rust
  fn some_function<T, U>(t: &T, u: &U) -> i32
      where T: Display + Clone,
            U: Clone + Debug
  { ... }
  ```

- 特征对象：**`Box<dyn Summary>`**

- 关联类型：

  ```rust
  trait Iterator {
      type Item;
      fn next(&mut self) -> Option<Self::Item>;
  }
  ```

- 默认类型参数：**`trait Add<RHS=Self> { ... }`**

- 完全限定语法：**`<Type as Trait>::function()`**

- 超特征：**`trait OutlinePrint: Display { ... }`**

- 孤儿规则：只能为当前 crate 中的类型实现当前 crate 中的特征

- 对象安全

  对象安全的 trait 可以是 [trait对象](https://rustwiki.org/zh-CN/reference/types/trait-object.html)的底层 trait。如果 trait 符合以下限定条件（在 [RFC 255](https://github.com/rust-lang/rfcs/blob/master/text/0255-object-safety.md) 中定义），则认为它是*对象安全的(object safe)*：

  - 所有的超类trait [supertraits](https://rustwiki.org/zh-CN/reference/items/traits.html#supertraits) 也必须也是对象安全的。
  - 超类trait 中不能有 `Sized`。也就是说不能有 `Self: Sized`约束。
  - 它必须没有任何关联常量。
  - 所有关联函数必须可以从 trait对象调度分派，或者是显式不可调度分派：
    - 可调度分派函数要求：
      - 不能有类型参数（尽管生存期参数可以有）
      - 作为方法时，`Self` 只能出现在[方法](https://rustwiki.org/zh-CN/reference/items/associated-items.html#methods)的接受者(receiver)的类型里，其它地方不能使用 `Self`。
      - 方法的接受者的类型必须是以下类型之一：
        - `&Self` (例如：`&self`)
        - `&mut Self` (例如：`&mut self`)
        - [`Box`](https://rustwiki.org/zh-CN/reference/special-types-and-traits.html#boxt)
        - [`Rc`](https://rustwiki.org/zh-CN/reference/special-types-and-traits.html#rct)
        - [`Arc`](https://rustwiki.org/zh-CN/reference/special-types-and-traits.html#arct)
        - [`Pin`](https://rustwiki.org/zh-CN/reference/special-types-and-traits.html#pinp) 当 `P` 是上面类型中的一种
      - 没有 `where Self: Sized`约束（即接受者的类型 `Self`(例如：`self`) 不能有 `Sized`约束）。
    - 显式不可调度分派函数要求：
      - 有 `where Self: Sized`约束（即接受者的类型 `Self`(例如：`self`) 有 `Sized`约束）。

## 8、练习1：简单计算器

```rust
use std::io::Write;
use std::io;

fn main() {
    let mut typer = UserTyper::new(CommandLineComputer);

    loop {
        typer.type_expr();
        println!("Result: {}", typer.compute());
    }
}

trait Computer {
    fn compute(&self, expr: &str) -> i32;
}

struct CommandLineComputer;

impl Computer for CommandLineComputer {
    fn compute(&self, expr: &str) -> i32 {
        let mut num1 = String::new();
        let mut num2 = String::new();
        let mut op: Option<char> = None;
        for chr in expr.trim().chars() {
            if chr.is_digit(10) {
                if op.is_none() {
                    num1.push(chr);
                } else {
                    num2.push(chr);
                }

                continue;
            }

            match chr {
                '+' | '-' | '*' | '/' if op.is_none() => op = Some(chr),
                _ if chr.is_whitespace() => continue,
                _ => panic!("Invalid character: {}", chr)
            }
        }

        if num1.is_empty() || num2.is_empty() || op.is_none() {
            panic!("Invalid expression: {}", expr);
        }

        let num1 = num1.parse::<i32>().unwrap();
        let num2 = num2.parse::<i32>().unwrap();
        let op = op.unwrap();
        match op {
            '+' => num1 + num2,
            '-' => num1 - num2,
            '*' => num1 * num2,
            '/' => num1 / num2,
            _ => unreachable!()
        }
    }
}

struct UserTyper<T: Computer> {
    computer: T,
    expr: String
}

impl<T: Computer> UserTyper<T> {
    fn new(computer: T) -> Self {
        Self {
            computer,
            expr: String::new()
        }
    }

    fn type_expr(&mut self) {
        self.expr.clear();
        print!("Please type an expression: ");
        io::stdout().flush().expect("Failed to flush stdout");
        io::stdin().read_line(&mut self.expr).expect("Failed to read line");
    }

    fn compute(&mut self) -> i32 {
        self.computer.compute(&self.expr)
    }
}
```

## 9、智能指针和内部可变性

- Box
- Deref
- Cell
- RefCell
- Rc

# **二、高阶**

## **1、泛型**

- 函数：**`fn largest<T>(list: &[T]) -> &T { ... }`**
- 结构体：**`struct Point<T> { x: T, y: T }`**
- 枚举：**`enum Option<T> { Some(T), None }`**
- 方法：**`impl<T> Point<T> { ... }`**

```rust
use std::ops::Add;

fn main() {
    let result = add(1, 2);
    println!("result is {}", result);

    let result = add(1u8, 2u8);
    println!("result is {}", result);

    let result = add(1.0f32, 2.0f32);
    println!("result is {}", result);

    let result = add(1.0f64, 2.0f64);
    println!("result is {}", result);

    let point_a = Point { x: 1, y: 2 };
    let point_b = Point { x: 3, y: 4 };
    let result = add(point_a, point_b);
    println!("{:?} + {:?} = {:#?}", point_a, point_b, result);

    let h_point_a = HeavyPoint { x: 2, y: 3 };
    let h_point_b = HeavyPoint { x: 4, y: 5 };
    let result = add2(&h_point_a, &h_point_b);
    println!("{:?} + {:?} = {:#?}", h_point_a, h_point_b, result);
}

fn add<T: Add<Output = T>>(a: T, b: T) -> T {
    a + b
}

fn add2<T>(a: &T, b: &T) -> T
where
    for<'a> &'a T: Add<Output = T>
{
    // T = HeavyPoint
    a + b
}

#[derive(Debug, Copy, Clone)]
struct Point<T = i32> {
    x: T,
    y: T
}

impl Add for Point {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        Point { x: self.x + rhs.x, y: self.y + rhs.y }
    }
}

#[derive(Debug)]
struct HeavyPoint<T = i32> {
    x: T,
    y: T
}

impl Add for &HeavyPoint {
    type Output = HeavyPoint;

    fn add(self, rhs: Self) -> Self::Output {
        HeavyPoint { x: self.x + rhs.x, y: self.y + rhs.y }
    }
}
```

## **2、闭包**

- 语法：**`let add_one = |x| x + 1;`**
- 捕获环境：借用、可变借用、获取所有权
- 特征：**`Fn`**, **`FnMut`**, **`FnOnce`**

```rust
fn main() {
    let name = String::from("Venus");

    // struct MyFn {
    //     name: String
    // }
    //
    // impl MyFn {
    //     fn new(name: String) -> Self {
    //         Self { name }
    //     }
    //     fn call(self) {
    //         say_hello(self.name)
    //     }
    // }

    // let say = MyFn::new(name);
    // say.call();
    // say.call();

    // let mut count = 0;
    //
    // let inc = || count += 1;

    // struct MyFn {
    //     count: i32
    // }
    // impl MyFn {
    //     fn new(count: i32) -> Self {
    //         Self { count }
    //     }
    //     fn call(&mut self) {
    //         self.count += 1;
    //     }
    // }

    // let mut inc = MyFn::new(1);
    // inc.call();
    // inc.call();
    // inc.call();

    let say = || say_hello(name);

    delegate(say);

    (0..10).for_each(|i| println!("{}", i))
}

fn say_hello(name: String) {
    println!("Hello, {}!", name);
}

fn delegate<F: FnOnce()>(f: F) {
    f();
}
```

## **3、错误处理**

- **`panic!`**：不可恢复错误
- **`Result<T, E>`**：可恢复错误
- 处理方法：**`match`**, **`unwrap()`**, **`expect()`**, **`?`**运算符

```rust
use std::io;
use std::io::Error;

fn main() -> Result<(), MyError> {
    let age = 20;
    let result = do_something(age).map_err(|err| format!("{err}"))?;
    println!("result: {}", result);
    Ok(())
    // if err != nil { return nil }
}

fn do_something(age: u8) -> Result<String, i32> {
    if age > 20 {
        Ok(String::from("ok"))
    } else {
        Err(1)
    }
}

#[derive(Debug)]
struct MyError(String);

impl From<i32> for MyError {
    fn from(code: i32) -> Self {
        match code {
            1 => MyError("Biz error".to_string()),
            1000 => MyError("too young error".to_string()),
            _ => MyError("Unknown error".to_string()),
        }
    }
}

impl From<String> for MyError {
    fn from(message: String) -> Self {
        Self(message)
    }
}

type MyResult<T> = Result<T, MyError>;

enum AppError {
    DatabaseError(String),
    JwtError(String),
    Unauthorized,
    BadRequest(i32),
    IoError(String),
}

impl From<io::Error> for AppError {
    fn from(value: Error) -> Self {
        Self::IoError(format!("io error: {}", value))
    }
}
```

## 4、模块和库

- **`mod`**
- **`crate`**

```rust
// utils.rs
use serde::{Deserialize, Serialize};
use crate::error::AppResult;

pub fn to_json<T: Serialize>(value: &T) -> AppResult<String> {
    let json = serde_json::to_string(value)?;
    println!("转换 JSON 成功: {json}");

    Ok(json)
}

pub fn from_json<'a, T: Deserialize<'a>>(json: &'a str) -> AppResult<T> {
    let value = serde_json::from_str(json)?;
    
    Ok(value)
}

// error.rs
use thiserror::Error;

pub type AppResult<T> = Result<T, AppError>;

#[derive(Debug, Error)]
pub enum AppError {
    #[error("JSON错误: {0}")]
    JsonError(#[from] serde_json::Error)
}

// main.rs
mod utils;
mod error;

use serde::{Deserialize, Serialize};
use crate::error::AppResult;
use crate::utils::to_json;

fn main() -> AppResult<()> {
    let person = Person {
        name: "Venus",
        desc: "这是一个描述",
        age: 21
    };

    let json = to_json(&person)?;
    println!("得到JSON: {}", json);

    let new_person: Person = serde_json::from_str(json.as_str())?;
    println!("得到对象: {:?}", new_person);

    Ok(())
}

#[derive(Debug, Serialize, Deserialize)]
struct Person<'a> {
    name: &'a str,
    desc: &'a str,
    age: u8
}
```

- 测试

```rust
use std::f64::consts::PI;

pub trait Shape {
    fn name(&self) -> &str;
    fn area(&self) -> f64;
}

pub struct Rectangle {
    width: f64,
    height: f64,
}

impl Rectangle {
    pub fn new(width: f64, height: f64) -> Self {
        Self { width, height }
    }
}

impl Shape for Rectangle {
    fn name(&self) -> &str {
        "Rectangle"
    }

    fn area(&self) -> f64 {
        self.width * self.height
    }
}

pub struct Circle {
    radius: f64,
}

impl Circle {
    pub fn new(radius: f64) -> Self {
        Self { radius }
    }
}

impl Shape for Circle {
    fn name(&self) -> &str {
        "Circle"
    }

    fn area(&self) -> f64 {
        PI * self.radius * self.radius
    }
}

pub fn calculate_all_shape_area(shapes: &[&dyn Shape]) -> f64 {
    shapes.iter().map(|shape| shape.area()).sum()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_rectangle_area() {
        let rect = Rectangle::new(10.0, 20.0);
        assert_eq!(rect.area(), 200.0);
    }

    #[test]
    fn test_circle_area() {
        let circle = Circle::new(10.0);
        assert_eq!(circle.area(), PI * 100.0);
    }
    
    #[test]
    fn test_calculate_all_shape_area() {
        let rect = Rectangle::new(10.0, 20.0);
        let circle = Circle::new(10.0);
        let shapes: Vec<&dyn Shape> = vec![&rect, &circle];
        assert_eq!(calculate_all_shape_area(&shapes), 200.0 + PI * 100.0);
    }
}
```

## **5、多线程**

- 创建线程：**`thread::spawn(|| { ... })`**
- 消息传递：**`mpsc::channel()`**
- 共享状态：**`Mutex<T>`**, **`Arc<T>`**
- 线程安全：**`Arc<Mutex<T>>`**, **`RwLock<T>`**

```rust
use std::{any, thread};
use std::sync::{mpsc, Arc, Mutex};
use std::time::Instant;

const TOTAL: u64 = 1000000000;

fn main() {
    count_time(serialized_calculate);
    count_time(parallel_calculate);
    count_time(scoped_calculate);
    count_time(channel_calculate);
}

fn count_time<F: FnOnce()>(f: F) {
    let name = any::type_name::<F>();
    let start = Instant::now();
    f();
    println!("[{name}] 总耗时: {} ms", start.elapsed().as_millis());
}

fn serialized_calculate() {
    let mut sum = 0;
    for i in 0..TOTAL {
        sum += i;
    }
    println!("sum: {}", sum);
}

fn parallel_calculate() {
    let chunk_size = TOTAL / 16;
    let sum = Arc::new(Mutex::new(0));
    let mut handles = vec![];

    for i in 0..16 {
        let start = i * chunk_size;
        let end = if i == 15 {
            TOTAL
        } else {
            (i + 1) * chunk_size
        };
        let sum_clone = Arc::clone(&sum);

        let handle = thread::spawn(move || {
            let mut local_sum = 0;
            for i in start..end {
                local_sum += i;
            }

            let mut sum = sum_clone.lock().unwrap();
            *sum += local_sum;
        });

        handles.push(handle);
    }

    for handle in handles {
        handle.join().unwrap();
    }

    println!("sum: {}", sum.lock().unwrap());
}

fn scoped_calculate() {
    let chunk_size = TOTAL / 16;
    let sum = Mutex::new(0);

    thread::scope(|scope| {
        for i in 0..16 {
            let start = i * chunk_size;
            let end = if i == 15 {
                TOTAL
            } else {
                (i + 1) * chunk_size
            };
            let sum_ref = &sum;

            scope.spawn(move || {
                let mut local_sum = 0;
                for i in start..end {
                    local_sum += i;
                }

                let mut sum = sum_ref.lock().unwrap();
                *sum += local_sum;
            });
        }
    });

    println!("sum: {}", sum.lock().unwrap());
}

fn channel_calculate() {
    let chunk_size = TOTAL / 16;
    let (tx, rx) = mpsc::channel();

    for i in 0..16 {
        let start = i * chunk_size;
        let end = if i == 15 {
            TOTAL
        } else {
            (i + 1) * chunk_size
        };
        let tx = tx.clone();

        thread::spawn(move || {
            let mut local_sum = 0;
            for i in start..end {
                local_sum += i;
            }

            tx.send(local_sum).unwrap();
        });
    }

    drop(tx);

    let mut sum = 0;
    while let Ok(local_sum) = rx.recv() {
        sum += local_sum;
    }

    println!("sum: {}", sum);
}
```

## **6、异步编程**

- **`async`**/**`await`**：异步函数和等待点
- **`Future`** 特征：表示异步计算
- 异步运行时：**`tokio`**, **`async-std`**
- 异步函数：**`async fn read_file() -> Result<String> { ... }`**
- 等待 Future：**`let content = read_file().await?;`**
- 并发执行：**`join!`**, **`select!`**
- 异步流：**`Stream`** 特征，类似于同步的 **`Iterator`**
- 异步互斥锁：**`tokio::sync::Mutex`**

```rust
#[tokio::main]
async fn main() {
    //  Future Promise pending resolved rejected
    let result = tokio::fs::read_to_string("demo.txt").await;
    match result {
        Ok(content) => println!("File content: {}", content),
        Err(error) => println!("Error reading file: {}", error),
    }

    // Promise.all()
    // tokio::join!(
    //     say_hello(),
    //     say_goodbye()
    // );

    tokio::select! {
        result = say_hello() => {
            println!("{result}");
        },
        _ = tokio::time::sleep(tokio::time::Duration::from_millis(1500)) => {
            println!("超时了");
        }
    }
}

async fn say_hello() -> &'static str {
    tokio::time::sleep(std::time::Duration::from_secs(1)).await;
    "Hello Venus"
}

async fn say_goodbye() {
    tokio::time::sleep(std::time::Duration::from_secs(1)).await;
    println!("Goodbye, Venus");
}
```

## 7、宏

- 声明宏：**`macro_rules!`**
- 过程宏：
  - 派生宏：**`#[derive(Debug)]`**
  - 属性宏：**`#[get("/users")]`**
  - 函数宏：**`sql!(SELECT \* FROM posts)`**

```rust
macro_rules! say_hello {
    () => {
        println!("Hello, Venus");
    };
    ($name:expr) => {
        println!("Hello, {}!", $name);
    };
}

macro_rules! nameof {
    ($name:ident) => {
        stringify!($name)
    };
}

struct Person;

macro_rules! create_fn {
    ($name:ident, $body:expr) => {
        fn $name() -> i32 {
            $body
        }
    };
}

macro_rules! create_struct {
    ($name:ident, $($field_name:ident: $field_type:ty),*) => {
        #[derive(Debug)]
        struct $name {
            $($field_name: $field_type),*
        }

        impl $name {
            fn new($($field_name: $field_type),*) -> Self {
                Self {
                    $($field_name),*
                }
            }
        }
    };
}

macro_rules! hashmap {
    ($($key:expr => $value:expr),* $(,)?) => {
        {
            use std::collections::HashMap;
            let mut map = HashMap::new();
            $(map.insert($key, $value);)*

            map
        }
    };
}

fn main() {
    say_hello!();
    say_hello!("Rust");
    println!("struct name is {}", nameof!(Person));

    create_fn!(get_one, 1);
    create_fn!(get_ten, 10);

    println!("get_one: {}", get_one());
    println!("get_ten: {}", get_ten());

    create_struct!(Student, name: String, age: u8);

    let student = Student::new(String::from("Venus"), 18);
    println!("student: {:#?}", student);

    let map = hashmap!(
        "name" => "Venus",
        "age" => "18",
        "gender" => "female"
    );
    println!("map: {:#?}", map);
}
```

## 8、不安全的 Rust

- 不安全代码块：**`unsafe { ... }`**
- 裸指针：**`\*const T`**、**`\*mut T`**

```rust
use std::collections::HashMap;
use std::marker::PhantomPinned;
use std::mem::MaybeUninit;
use std::pin::Pin;
use std::{mem, ptr};
use std::rc::Rc;
use ouroboros::self_referencing;

fn main() {
    let map = HashMap::from([
        (String::from("male"), String::from("Handsome boy")),
        (String::from("female"), String::from("Pretty girl")),
    ]);

    let my_ref_self_engine = MySelfRefEngine::new(map.clone());
    println!("Translate result: {}", my_ref_self_engine.translate("male"));

    let my_ref_self_engine2 = MySelfRefEngine2::new(map.clone());
    println!("Translate result: {}", my_ref_self_engine2.translate("male"));

    let ob_self_ref_engine = ObSelfRefEngine::create(map.clone());
    println!("Translate result: {}", ob_self_ref_engine.translate("female"));

    let rc_engine = RcEngine::new(map.clone());
    println!("Translate result: {}", rc_engine.translate("female"));
    
    let ref_engine = RefEngine::new(&map);
    println!("Translate result: {}", ref_engine.translate("female"));
}

const DEFAULT_VALUE: &str = "";

struct MySelfRefEngine {
    map: HashMap<String, String>,
    translator: PtrTranslator,
    _marker: PhantomPinned
}

impl MySelfRefEngine {
    fn new(map: HashMap<String, String>) -> Pin<Box<Self>> {
        let mut engine = Box::pin(Self {
            map,
            translator: PtrTranslator {
                map: ptr::null()
            },
            _marker: PhantomPinned
        });

        let map_ptr: *const HashMap<String, String> = &engine.map;
        unsafe {
            let reference = engine.as_mut().get_unchecked_mut();
            reference.translator.map = map_ptr;
        }

        engine
    }

    fn translate(&self, text: &str) -> &str {
        println!("Translation map size: {}", self.map.len());
        println!("Translating: {}", text);
        self.translator.translate(text).unwrap_or(DEFAULT_VALUE)
    }
}

struct PtrTranslator {
    map: *const HashMap<String, String>,
}

impl PtrTranslator {
    fn translate(&self, text: &str) -> Option<&str> {
        unsafe { &*self.map }.get(text).map(|s| s.as_str())
    }
}

struct RefTranslator<'a> {
    map: &'a HashMap<String, String>,
}

impl<'a> RefTranslator<'a> {
    fn translate(&self, text: &str) -> Option<&str> {
        self.map.get(text).map(|s| s.as_str())
    }
}

struct RcTranslator {
    map: Rc<HashMap<String, String>>
}

impl RcTranslator {
    fn translate(&self, text: &str) -> Option<&str> {
        self.map.get(text).map(|s| s.as_str())
    }
}

struct MySelfRefEngine2 {
    map: HashMap<String, String>,
    translator: RefTranslator<'static>,
    _marker: PhantomPinned
}

impl MySelfRefEngine2 {
    fn new(map: HashMap<String, String>) -> Pin<Box<Self>> {
        let mut engine = Box::pin(Self {
            map,
            translator: RefTranslator {
                map: unsafe { MaybeUninit::uninit().assume_init() }
            },
            _marker: PhantomPinned
        });

        // let map_ptr: *const HashMap<String, String> = &engine.map;
        // unsafe {
        //     let reference = engine.as_mut().get_unchecked_mut();
        //     reference.translator.map = &*map_ptr;
        // }
        let map_ptr= unsafe {
            mem::transmute(&engine.map)
        };
        unsafe {
            let reference = engine.as_mut().get_unchecked_mut();
            reference.translator.map = map_ptr;
        }
        engine
    }

    fn translate(&self, text: &str) -> &str {
        println!("Translation map size: {}", self.map.len());
        println!("Translating: {}", text);
        self.translator.translate(text).unwrap_or(DEFAULT_VALUE)
    }
}

/// func fn(A)
/// B extends A
/// fn(B)
/// func fn2(arg func(A))
/// A extends Z
/// fn2(func(Z))

#[self_referencing]
struct ObSelfRefEngine {
    map: HashMap<String, String>,
    #[borrows(map)]
    #[covariant]
    translator: RefTranslator<'this>,
}

impl ObSelfRefEngine {
    fn create(map: HashMap<String, String>) -> Self {
        ObSelfRefEngineBuilder {
            map,
            translator_builder: |map| {
                RefTranslator {
                    map,
                }
            }
        }.build()
    }

    fn translate(&self, text: &str) -> &str {
        println!("Translation map size: {}", self.borrow_map().len());
        println!("Translating: {}", text);
        self.borrow_translator().translate(text).unwrap_or(DEFAULT_VALUE)
    }
}

struct RcEngine {
    map: Rc<HashMap<String, String>>,
    translator: RcTranslator,
}

impl RcEngine {
    fn new(map: HashMap<String, String>) -> RcEngine {
        let map = Rc::new(map);
        RcEngine {
            map: Rc::clone(&map),
            translator: RcTranslator {
                map
            }
        }
    }

    fn translate(&self, text: &str) -> &str {
        println!("Translation map size: {}", self.map.len());
        println!("Translating: {}", text);
        self.translator.translate(text).unwrap_or(DEFAULT_VALUE)
    }
}

struct RefEngine<'a> {
    map: &'a HashMap<String, String>,
    translator: RefTranslator<'a>,
}

impl<'a> RefEngine<'a> {
    fn new(map: &'a HashMap<String, String>) -> RefEngine<'a> {
        RefEngine {
            map,
            translator: RefTranslator {
                map
            }
        }
    }
    
    fn translate(&self, text: &str) -> &str {
        println!("Translation map size: {}", self.map.len());
        println!("Translating: {}", text);
        self.translator.translate(text).unwrap_or(DEFAULT_VALUE)
    }
}
```

## 9、练习2：复杂计算器

- 计算表达式分词
- 构造 AST（抽象语法树）
- 根据 AST 评估计算结果

项目源码：

[calculator.zip](attachment:0db3482c-98ff-4272-b864-4a56fda51d35:calculator.zip)

## 10、练习3：手撸JSON解析器

JSON 解析，通过 nom 库加速我们的分词过程；其中用到的 nom 分词解析器有： 1、multispace0 解析 0 或多个空格 2、tag 解析一个固定的字符串（如关键字） 3、delimited 解析通过前后（解析器）包围的内容（解析器），这是一个组合其他解析器的高阶解析器 4、alt 这是一个可选匹配解析器，组合一堆解析器，挨个解析，只要有一个解析成功就成功 5、recognize_float 识别一个浮点数解析器 6、char 一个固定的字符解析器 7、many0 零到多次重复解析的高阶解析器，解析结果为一个 Vec<O> 8、separated_list0 匹配零到多次由分隔符（解析器）分割的内容（解析器），这是一个高阶解析器 9、separated_pair 匹配一对由分隔符（解析器）分割的内容（解析器），这也是一个高阶解析器 10、opt 这是一个可选解析的高阶解析器，表示被组合的解析器能否解析到内容是可选的

```rust
use nom::{
    IResult, Parser,
    branch::alt,
    bytes::complete::tag,
    character::complete::{char as char_parser, multispace0, none_of},
    combinator::{map, opt, value},
    multi::{many0, separated_list0},
    number::complete::recognize_float,
    sequence::{delimited, separated_pair},
};
use serde_json::Value;

fn main() {
    let input = r#"
    {
        "name": "John",
        "age": 30,
        "city": "New York",
        "is_active": true,
        "balance": 1000.50,
        "orders": [
            {
                "id": 1,
                "amount": 100,
                "status": "completed"
            },
            {
                "id": 2,
                "amount": 200,
                "status": "pending"
            }
        ],
        "created_at": "2021-01-01T00:00:00Z"
    }
    "#;

    let result = parse_primary(input);
    assert!(result.is_ok());
    let (_, value) = result.unwrap();
    println!("Parsed JSON: {:#?}", value);
}

fn parse_null(input: &str) -> IResult<&str, Value> {
    value(
        Value::Null,
        delimited(multispace0, tag("null"), multispace0),
    )
    .parse(input)
}

fn parse_bool(input: &str) -> IResult<&str, Value> {
    delimited(
        multispace0,
        alt((
            value(Value::Bool(true), tag("true")),
            value(Value::Bool(false), tag("false")),
        )),
        multispace0,
    )
    .parse(input)
}

fn parse_number(input: &str) -> IResult<&str, Value> {
    let (input, number) = delimited(multispace0, recognize_float, multispace0).parse(input)?;

    Ok((input, Value::Number(number.parse().unwrap())))
}

fn parse_string(input: &str) -> IResult<&str, Value> {
    map(
        delimited(multispace0, recognize_string, multispace0),
        |string| Value::String(string),
    )
    .parse(input)
}

fn recognize_string(input: &str) -> IResult<&str, String> {
    map(
        delimited(char_parser('"'), many0(none_of("\\"")), char_parser('"')),
        |chars| chars.into_iter().collect(),
    )
    .parse(input)
}

fn parse_array(input: &str) -> IResult<&str, Value> {
    delimited(
        multispace0,
        delimited(
            (char_parser('['), opt(multispace0)),
            map(
                separated_list0(
                    delimited(multispace0, char_parser(','), multispace0),
                    parse_primary,
                ),
                |values| Value::Array(values),
            ),
            (char_parser(']'), opt(multispace0)),
        ),
        multispace0,
    )
    .parse(input)
}

fn parse_object(input: &str) -> IResult<&str, Value> {
    delimited(
        multispace0,
        delimited(
            (char_parser('{'), opt(multispace0)),
            map(
                separated_list0(
                    delimited(multispace0, char_parser(','), multispace0),
                    separated_pair(
                        recognize_string,
                        delimited(multispace0, char_parser(':'), multispace0),
                        parse_primary,
                    ),
                ),
                |entries| Value::Object(entries.into_iter().collect()),
            ),
            (char_parser('}'), opt(multispace0)),
        ),
        multispace0,
    )
    .parse(input)
}

fn parse_primary(input: &str) -> IResult<&str, Value> {
    alt((
        parse_null,
        parse_bool,
        parse_number,
        parse_string,
        parse_array,
        parse_object,
    ))
    .parse(input)
}
```

## 11、练习4：进军Web开发1

- 上手 Axum 框架