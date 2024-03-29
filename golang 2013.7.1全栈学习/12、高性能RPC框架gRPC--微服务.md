# 高性能RPC框架gRPC 如何用于微服务

[toc]

## 微服务需要考虑哪些因素

1. 鉴权问题
2. grpc数据传递，类似http header
3. 拦截器，
4. 分布式部署的副㪘，客户端负载均衡（如果服务已经部署为负载均衡，就无须）
5. 服务的健康检查
6. 数据传输的方式： 一元请求或流式请求
7. 服务之间的认证问题
8. 服务限流的问题，服务接口限流
9. 服务的熔断，通过判断发生的错误次数，对服务做降级
10. 日志追踪

## protobuf服务定义

1. 编译器
2. 安装编译器插件
3. 生成代码



### 优势

1. 传输会更快，以二进制方式传输

![image-20230709132610091](imgs/image-20230709132610091.png)

http://protobuf.dev   支持的语言

![image-20230709132653882](imgs/image-20230709132653882.png)

![image-20230709133538483](imgs/image-20230709133538483.png)

![image-20230709133631024](imgs/image-20230709133631024.png)

![image-20230709133856572](imgs/image-20230709133856572.png)

## gRPC 4中消息传递方式

![image-20230709134140432](imgs/image-20230709134140432.png)

protoc编译器工具下载

github搜索  下载后会有protoc命令

需要配置环境变量

![image-20230709134357023](imgs/image-20230709134357023.png)



安装插件

![image-20230709134424706](imgs/image-20230709134424706.png)

![image-20230709134513250](imgs/image-20230709134513250.png)

### 生成代码

![image-20230709134606722](imgs/image-20230709134606722.png)

![image-20230709134916355](imgs/image-20230709134916355.png)

### 一元请求

#### server

![image-20230709135221131](imgs/image-20230709135221131.png)

![image-20230709135427572](imgs/image-20230709135427572.png)

#### client

![image-20230709135741576](imgs/image-20230709135741576.png)

![image-20230709135918574](imgs/image-20230709135918574.png)

启动server： 接受请求

![image-20230709140001462](imgs/image-20230709140001462.png)

启动client： 发送请求

![image-20230709140017371](imgs/image-20230709140017371.png)

### 流式请求

#### 进行改造封装

==client.go==

![image-20230709140225062](imgs/image-20230709140225062.png)

​	

![image-20230709140333569](imgs/image-20230709140333569.png)

![image-20230709140357418](imgs/image-20230709140357418.png)

![image-20230709140441167](imgs/image-20230709140441167.png)

#### 流式调用

##### client发送请求

![image-20230709140726782](imgs/image-20230709140726782.png)

![image-20230709140950341](imgs/image-20230709140950341.png)

##### server端接受请求

![image-20230709141110462](imgs/image-20230709141110462.png)

##### run执行日志

![image-20230709141151018](imgs/image-20230709141151018.png)

![image-20230709141126548](imgs/image-20230709141126548.png)

### 双向流

#### 客户端

![image-20230709141621077](imgs/image-20230709141621077.png)

![image-20230709141629835](imgs/image-20230709141629835.png)

![image-20230709142033570](imgs/image-20230709142033570.png)

#### 服务端

![image-20230709141944172](imgs/image-20230709141944172.png)

![image-20230709142103364](imgs/image-20230709142103364.png)

![image-20230709142134742](imgs/image-20230709142134742.png)