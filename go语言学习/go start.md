# 从零开始搭建Go语言开发环境

[toc]





# 安装Go语言及搭建Go语言开发环境

## golang安装

Go官网下载地址：https://golang.org/dl/

Go官方镜像站（推荐）：https://golang.google.cn/dl/

### Linux下安装

写好的go代码只需要跨平台编译（详见文章末尾的跨平台编译）好之后就可以拷贝到Linux服务器上运行了，这也是go程序跨平台易部署的优势。

我们在版本选择页面选择并下载好`go1.14.1.linux-amd64.tar.gz`文件：

```bash
wget https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz
```

将下载好的文件解压到`/usr/local`目录下：

```bash
tar -zxvf go1.14.1.linux-amd64.tar.gz -C /usr/local  # 解压
```

如果提示没有权限，加上`sudo`以root用户的身份再运行。执行完就可以在`/usr/local/`下看到`go`目录了。

#### 配置环境变量： Linux下有两个文件可以配置环境变量，其中`/etc/profile`是对所有用户生效的；`$HOME/.profile`是对当前用户生效的，根据自己的情况自行选择一个文件打开，添加如下两行代码，保存退出。

```bash
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
```

修改`/etc/profile`后要<font color=red >==重启生效==</font>，修改`$HOME/.profile`后使用source命令加载`$HOME/.profile`文件即可生效。 检查：

```bash
[linux@xsadf ~] go version
go version go1.14.1 linux/amd64
```

### Mac下安装

下载可执行文件版，直接点击**下一步**安装即可，默认会将go安装到`/usr/local/go`目录下。

<img src="https://www.liwenzhou.com/images/Go/install_go_dev/mac_install_go.png" alt="Mac安装Go" style="zoom: 50%;" />

### win10安装：设置环境变量后，<font color=red>必须重启电脑后生效</font>

```bash
GOPATH	D:\software\go\gocode
GOPROXY		https://goproxy.cn,direct
GOROOT		D:\software\go
path		D:\software\go\bin
```

### 检查

上一步安装过程执行完毕后，可以打开终端窗口，输入`go version`命令，查看安装的Go版本。![install06](https://www.liwenzhou.com/images/Go/install_go_dev/install06.png)

### GOPROXY 非常重要

```bash
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
```

## Go开发编辑器:Visual Studio Code +go插件

Go采用的是==UTF-8==编码的文本文件存放源代码，理论上使用任何一款文本编辑器都可以做Go语言开发，这里推荐使用`VS Code`和`Goland`。 `VS Code`是微软开源的编辑器，而`Goland`是jetbrains出品的付费IDE。

我们这里使用`VS Code` 加插件做为go语言的开发工具。

## 开始

### `go mod init 项目名` 对项目进行初始化

使用go module模式新建项目时，该命令会在项目根目录下生成`go.mod`文件

```bash
mkdir 目录名
cd 目录名
go mod init 目录名
```

### 编写代码

接下来在该目录中创建一个`main.go`文件：

```go
package main  // 声明 main 包，表明当前是一个可执行程序

import "fmt"  // 导入内置 fmt 包

func main(){  // main函数，是程序执行的入口
	fmt.Println("Hello World!")  // 在终端打印 Hello World!
}
```

==非常重要！！！** 如果此时VS Code右下角弹出提示让你安装插件，务必点 **install all** 进行安装。==

### ==编译==

`go build`命令表示将源代码编译成可执行文件。

在hello目录下执行：

```bash
go build
```

或者在其他目录执行以下命令：

```bash
go build hello
```

go编译器会去 `GOPATH`的src目录下查找你要编译的`hello`项目

编译得到的可执行文件会保存在执行编译命令的当前目录下，如果是windows平台会在当前目录下找到`hello.exe`可执行文件。

可在终端直接执行该`hello.exe`文件：

```bash
c:\desktop\hello>hello.exe
Hello World!
```

我们还可以使用`-o`参数来指定编译后得到的可执行文件的名字。

```bash
go build -o heiheihei.exe
```

### Windows下VSCode切换cmd.exe作为默认终端

如果你打开VS Code的终端界面出现如下图场景（注意观察红框圈中部分），那么你的`VS Code`此时正使用`powershell`作为默认终端：<img src="https://www.liwenzhou.com/images/Go/install_go_dev/vscode_shell1.png" alt="vscode shell配置1" style="zoom:50%;" />十分推荐你按照下面的步骤，选择`cmd.exe`作为默认的终端工具：<img src="https://www.liwenzhou.com/images/Go/install_go_dev/vscode_shell2.png" alt="vscode shell配置2" style="zoom:33%;" />此时，VS Code正上方中间位置会弹出如下界面，参照下图挪动鼠标使光标选中后缀为`cmd.exe`的那一个，然后点击鼠标左键。

最后**重启VS Code中已经打开的终端**或者**直接重启VS Code**就可以了。如果没有出现下拉三角，也没有关系，按下`Ctrl+Shift+P`，VS Code正上方会出现一个框，你按照下图输入`shell`，然后点击指定选项即可出现上面的界面了。<img src="https://www.liwenzhou.com/images/Go/install_go_dev/vscode_shell4.png" alt="vscode shell配置4" style="zoom:50%;" />

### go run

`go run main.go`也可以执行程序，该命令本质上也是先编译再执行。

### go install

`go install`表示安装的意思，它先编译源代码得到可执行文件，然后将可执行文件移动到`GOPATH`的bin目录下。因为我们的环境变量中配置了`GOPATH`下的bin目录，所以我们就可以在任意地方直接执行可执行文件了。

### 跨平台编译

默认我们`go build`的可执行文件都是当前操作系统可执行的文件，Go语言支持跨平台编译——在当前平台（例如Windows）下编译其他平台（例如Linux）的可执行文件。

### Windows编译Linux可执行文件

如果我想在Windows下编译一个Linux下可执行文件，那需要怎么做呢？只需要在编译时指定目标操作系统的平台和处理器架构即可。

> 注意：无论你在Windows电脑上使用VsCode编辑器还是Goland编辑器，都要注意你使用的终端类型，因为不同的终端下命令不一样！！！目前的Windows通常默认使用的是`PowerShell`终端。

#### 如果你的`Windows`使用的是`cmd`，那么按如下方式指定环境变量。

```bash
SET CGO_ENABLED=0  // 禁用CGO
SET GOOS=linux  // 目标平台是linux
SET GOARCH=amd64  // 目标处理器架构是amd64
```

#### 如果你的`Windows`使用的是`PowerShell`终端，那么设置环境变量的语法为

```bash
$ENV:CGO_ENABLED=0
$ENV:GOOS="linux"
$ENV:GOARCH="amd64"
```

在你的`Windows`终端下执行完上述命令后，再执行下面的命令，得到的就是能够在Linux平台运行的可执行文件了。

```bash
go build
```

#### Windows编译Mac可执行文件

Windows下编译Mac平台64位可执行程序：

cmd终端下执行：

```bash
SET CGO_ENABLED=0
SET GOOS=darwin
SET GOARCH=amd64
go build
```

PowerShell终端下执行：

```bash
$ENV:CGO_ENABLED=0
$ENV:GOOS="darwin"
$ENV:GOARCH="amd64"
go build
```

### Mac编译Linux可执行文件

Mac电脑编译得到Linux平台64位可执行程序：

```bash
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build
```

#### Mac编译Windows可执行文件

Mac电脑编译得到Windows平台64位可执行程序：

```bash
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build
```

### Linux编译Mac可执行文件

Linux平台下编译Mac平台64位可执行程序：

```bash
CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build
```

#### Linux编译Windows可执行文件

Linux平台下编译Windows平台64位可执行程序：

```bash
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build
```

现在，开启你的Go语言学习之旅吧。人生苦短，let’s Go.