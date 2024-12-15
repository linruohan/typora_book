

# 1 Cargo Package 离线编译策略

[爱国的张浩予](https://rustcc.cn/blog_with_author?author_id=dc9fba7d-3d31-4359-9064-adf55db351e0) 发表于 2022-05-25 08:09

Tags：offline,compile,cache,vendor,fetch,cargo

# `Cargo Package`离线编译策略

简单地讲，`cargo`为`Package`提供了两套【离线编译】解决方案：

- 方案一：`cargo fetch` + `cargo build --offline`
- 方案二：`cargo vendor` + 修改`.cargo/config.toml`文件 + `cargo build`

## 1 两套方案的共同点

- `cargo fetch`与`cargo vendor`命令
    - 【执行-位置】都需要在`Cargo Package`工程根目录被执行。
    - 【执行-时间】都需要在工程构建程序（无论是`build.rs`还是`shell`脚本）被启动前，被预先执行。
- 无论依赖项的来源是`crates.io`还是`github`，它们都可被预拉取和缓存至本地。

## 2 两套方案的差别

- 依赖项`crate`源码的**储存位置**
    - `cargo fetch`缓存依赖项源码于`$CARGO_HOME`目录下。更具体地进，
        - `crate.io`依赖项 -> `$CARGO_HOME/registry/src`
        - `github`依赖项 -> `$CARGO_HOME/git/checkouts`
    - `cargo vendor`缓存依赖项源码于`Cargo Package`工程根目录下的`vendor`子文件夹里。
- 依赖项`crate`的**共享范围**
    - 由`cargo fetch`缓存的依赖项源码可被同一台机器上的所有`Cargo Package`工程所共享。
    - 由`cargo vendor`缓存的依赖项源码仅服务于当前`Cargo Package`工程。
        - `vendor`文件夹馁馁地就是`rust`版的`node_modules`。
        - 若将`vendor`依赖目录在多个`Cargo Package`工程之间共享，需要额外地配置`.cargo/config.toml`文件和对多个工程的文件系统位置做一些约定。这要比`npm - node_modules`麻烦不少 — 回头单独写篇文章分享之。
- 与`CI`系统**集成方式**（比如，`Jenkins`）
    - `cargo fetch`方案·集成步骤：
        
        - 首先，`cargo fetch`命令需要由 **@`CI`管理员**，在**`Jenkins`机器**上，在启动打包`jobs`以前，**连网**执行一次。
        - 然后，在打包过程中，`cargo build --offline`命令才能在`$CARGO_HOME`目录下找到预缓存的依赖项源码。其中，命令行参数`--offline`会“短路”一切网络请求，包括：
            - 确认`Cargo.lock`是否已经反映了每个依赖项的最新语义兼容版本。
            - 下载依赖项`crate`源码
        
        > 对程序员来说，这可能不那么爽。毕竟，每次依赖升级，咱们都不得不走流程，编故事，写报告，请 @`CI`管理员 给执行一下`cargo fetch`命令。
        
    - `cargo vendor`方案·集成步骤：
        
        - 首先，`cargo vendor`命令需要由 **@程序员**，在**个人电脑**上，在**代码提交前**，执行一次。于是，`vendor`文件夹出现。
            
        - 然后，将·`cargo vendor`命令打印至【标准输出】的配置代码（如下）·复制到`.cargo/config.toml`配置文件内。
            
            ```
            [source.crates-io]
            replace-with = "vendored-sources"
            [source."https://github.com/shadowsocks/crypto"]
            git = "https://github.com/shadowsocks/crypto"
            branch = "master"
            replace-with = "vendored-sources"
            [source.vendored-sources]
            directory = "vendor"
            ```
            
            > 若你的`Cargo Package`工程曾经配置过【[源码替换](https://doc.rust-lang.org/cargo/reference/source-replacement.html)】规则（真高级），那么请合并（而不仅是追加）`[source.***]`配置代码。
            
        - 接着，将工程根目录下的`vendor`文件夹和`.cargo/config.toml`配置文件，随业务程序，一起提交至`git`仓库。
            
        - 在打包编译过程中，
            
            - `Jenkins`会`git clone`到上述所有文件，包括：
                
                - 业务代码
                - 依赖源码
                - `Cargo.toml`
                - `.cargo/config.toml`
            - `cargo build`命令也**不需要`--offline`命令行参数**了，因为【[目录·源码替换](https://doc.rust-lang.org/cargo/reference/source-replacement.html#directory-sources)】配置规则会生效和告诉`cargo`从本地硬盘的何处寻找依赖项`crate`源码。
                
                > 题外话，没有想到吧！在这影响依赖项“寻址”指向的机制不是【[依赖重载](https://doc.rust-lang.org/cargo/reference/overriding-dependencies.html)`[patch.***]`】，而是【[源码替换](https://doc.rust-lang.org/cargo/reference/source-replacement.html)`[source.***]`】。我也挺意外的。
                

## 3 `cargo vendor`性能最佳·参数组合

`cargo vendor --no-delete --versioned-dirs --respect-source-config`

- `--no-delete`不删除上一次执行`cargo vendor`时留下的`vendor`文件夹。这样下载过的`crate`源码就不会再重新下载了。
- `--versioned-dirs`给每个依赖项目录名追加以`-`开头的版本号后缀（例如，`base64-0.5.2`）。这样，不用刻意地浏览每个依赖项的`Cargo.toml`文件，便可知晓它们的版本信息。
- `--respect-source-config`若你的工程早先就已经配置过【源码替换】`[source.***]`配置块，`cargo`将对旧配置做兼容处理。否则，旧配置就会被无视了。

## 4 番外篇

虽然上面讲了那么多，但其实仅只绕过了【依赖项源码下载】的耗时环节。但是，`cargo`打包编译慢，又何止于网络慢，编译本身也是“重灾区”。所以，若你的`CI`打包策略是：

1. 抹除整个工程目录 — 毛都不剩
2. `git`捡出业务代码 — 内网应该很快
3. 下载依赖项 — 走`cargo fetch / vendor`的缓存，应该也很快
4. 编译依赖项 — 我若说“不慢”，你敢信？

的话，那么上述的长篇大论仅只节省了`#3`的延时。而我要在此推荐的【究级】“补刀”配置却能够缩短`#4`的耽搁。即，给`.cargo/config.toml`文件添加（或合并）一段配置（如下）

```
[build]
target-dir = "../<工程名>-target"
```

将整个编译输出目录“请”出工程文件夹。于是，

- 【编译输出文件夹】将和【`Cargo Package`工程】处于平级目录且名曰“<工程名>-target”
- `Jenkins`不会再删除【编译输出目录】及其缓存的编译中间文件，因为它们都不在【工程目录】中。
- 下次再对该`Cargo Package`工程编译，将启用【增量编译】处理流程。这馁馁地要比【全量编译】快速得多！

最后，`cargo`打包编译的最后两步都有了缓存做支撑，工程的编译速度进一步被提高。完美！！！

## 5 结束语

这次就分享这些。总的来说，我对`rust`编程的实践机会还是非常有限的。所以，文章中总结的内容有疏漏之处，还请路过的神仙哥哥与神仙妹妹指正，和多发评论呀！

### 5.1 评论区

这个是相当于把全局缓存改成放在项目本体里了？ 这个对Chromium和FF这些项目来说确实方便。

