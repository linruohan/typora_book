# sync包中互斥锁的使用

[toc]

![image-20220717113526172](img/image-20220717113526172.png)

## 资源竞争

如果分配的内存没有被其他的goroutine访问，只在该goroutine中被使用，就不存在资源竞争的问题

但如果同一块内存被多个goroutine同时访问，就会产生不知道谁先访问，也无法预料最后的结果

## 互斥锁sync.Mutex

同一时刻只有一个协程执行某段代码，其他协程都要等待该协程执行完毕后才能继续执行

```go
var (
	sum int
    mutex sync.Mutex
)
func add(i int){
    mutex.Lock()
    sum+=i
    mutex.Unlock()
}
// 读取sum
func readSum()int{
    mutex.Lock()
    defer mutex.Unlock()
    return sum
}
```

临界区：一个访问共享资源的程序片断，而这些共享资源又无法同时被多个协程访问的特性

### 互斥锁的性能问题

1. 写的同时不能读

2. 读的同时不能写

3. 读的同时可以读

```go
var mutex sync.RWMutex //读写锁
// 读取sum
func readSum()int{
    //只获取读锁
    mutex.RLock()
    defer mutex.RUnlock()
    return sum
}
```

### 等待协程执行完毕 sync.WaitGroup

适合协调多个协程共同做一件事情的场景

加入使用10个协程下载文件，每个协程下载1/10大小，只有10个协程都下载完了，文件才算下载成功

```go
func main(){
    run()
}
func run(){
    var wg sync.WaitGroup
    wg.Add(110) //因为要监控110个协程，设置计时器为110
    for i:=0;i<100;i++{
        go func(){
            //计数器值减1
            defer wg.Done()
            add(10)  
        }()
        
    }
    for i:=0;i<10;i++{
        go func(){
            defer wg.Done()
            fmt.Pringln("和为：",readSum()）
         }()
    }
    wg.Wait() //一直等待，只要计数器值为0
}
```

## sync.Once

让代码只执行一次，哪怕是在高并发的情况下，比如创建一个单例

```go
func main(){
    doOnce()
}
func doOnce(){
    var once sync.Once
    onceBody:=func(){
        fmt.Println("only once")
    }
    //用于等待协程执行完毕
    done:=make(chan bool)
    //启动10个协程执行once.Do(onceBody)
    for i:=0,i<10;i++{
        go func(){
            //把要执行的函数作为参数传给once.DO()
            once,Do(onceBody)
            done<-true
        }()
    }
    for i:=0;i<10;i++{
        <-done
    }
}
```

## sync.Cond

在协程开始的时候等待

具有阻塞和唤醒协程的功能，可以在满足一定条件的情况下唤醒协程

```go
//10人赛跑，一个裁判发号施令
func race(){
    cond:=sync.NewCond(&sync.Mutex{})
    var wg sync.WaitGroup
    wg.Add(11)
    for i:=0;i<10;i++{
        go func(num int){
            defer wg.Done()
            fmt.Println(num,"号已就位")
            cond.L.Lock()
            cond.Wait()//等待发令枪响
            fmt.Println(num,"号开始跑...")
            cond.L.Unlock()
        }(i)
    }
    //等待所有goroutine都进入wait状态
    time.Sleep(2*time.Second)
    go func(){
        defer wg.Done()
        fmt.Println("裁判已就位，开始跑")
        cond.Broadcast()//发令枪响
    }()
    //防止函数提前返回退出
    wg.Wait()
}
```

### sync.Cond三个方法

```go
Wait 阻塞当前协程
Signal 唤醒一个等待时间最长的协程
Broadcast 唤醒所有等待的协程
```

## sync.Map

Store:存储一对key-value值

Load：根据key获取对应的value值，并且key判断key是否存在

LoadOrStore：如果key对应的value存在，则返回该value，如果不存在，存储相应的value

Delete：删除一个key-value键值对

Range:循环迭代sync.Map，效果与for range一样





