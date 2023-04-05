# Golang 交叉编译各平台的可执行二进制程序
Golang是一种静态强类型并且具有垃圾回收机制天生支持高并发的编程语言。相比于Python、PHP等动态脚本语言，Golang的天生优势是可以不需要解释器直接编译成目标平台的可执行程序，可以不需要依赖外部容器比如Nginx等，Golang内置的http包可以快速构建出一个支持高并发的web服务。  
## 1 快速构建
> 一个简单的Golang的Web服务只需要几行代码
新建文件 server. go  
```go
package main  
import "net/http"  
func indexHandler(w http.ResponseWriter, r *http.Request) {  
	_, _ = w.Write(byte("Hello,World!"))  
}  
func main() {  
	http.HandleFunc("/",indexHandler)  
	_ = http.ListenAndServe(":9999", nil)  
}  
```
`http.HandleFunc()`用来绑定URL和处理对应URL请求的Handler方法  
`http.ListenAndServe()`指定监听的端口，开启一个http服务。

> Golang的`http`包提供了协程，天生支持高并发。相比于Python和Node.js等也是几行代码可以搞定一个web服务，Golang的另一个优势是真正的跨平台，可以快速编译成目标平台的可执行文件，甚至可以把这个http服务编译成Android平台的arm linux架构的可执行程序，直接在手机上启动web服务。可以用Golang来写各种工具和轮子实现为所欲为的骚操作。

## 2 go run
> Golang可以使用`go run`解释执行
go run server.go  
打开浏览器访问 [http://localhost:9999/](http://localhost:9999/), 可以看到浏览器输出了`Hello，World！`

## 3 go build
> Golang可以使用`go build`编译成当前平台的可执行程序
go build server.go  
执行完毕后会在当前目录生成一个可执行程序`server`，双击可执行程序或者在命令行下执行`./server`。  
打开浏览器访问 [http://localhost:9999/](http://localhost:9999/), 可以看到浏览器输出了`Hello，World！`

## 4 交叉编译
> Golang可以在任意平台编译成其他目标平台的二进制可执行程序，只需要在`go build`前指定目标平台的系统类型和CPU指令集架构即可。
### 4.1 mac   上编译 linux 和 windows 二进制  
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build server.go  
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build server.go  
### 4.2 linux 上  编译 mac 和 windows 二进制  
CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build server.go  
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build server.go  
### 4.3 windows  上编译 mac 和 linux 二进制  
SET CGO_ENABLED=0 SET GOOS=darwin SET GOARCH=amd64 go build server.go  
SET CGO_ENABLED=0 SET GOOS=linux SET GOARCH=amd64 go build server.go  
### 4.4 android 平台（arm linux）的可执行程序
CGO_ENABLED=0 GOARCH=arm GOOS=linux go build server.go  
编译完成后通过adb等工具将可执行程序push到手机的指定目录下，然后授予可执行权限即可在手机本机上运行web服务。so easy！
## 5 编译参数说明
`CGO_ENABLED` 设置为0表示不启用CGO进行编译，代码中如果有用到C语言相关的库,编译时就需要开启`CGO_ENABLED=1`  
`GOOS` 指定了目标的操作系统类型  
`GOARCH` 指定了目标的CPU架构类型