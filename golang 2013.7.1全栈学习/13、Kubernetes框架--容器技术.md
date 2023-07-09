# kubernetes框架

[toc]

## 什么是kubernetes

![image-20230709142630459](imgs/image-20230709142630459.png)

## 为什么要使用kubernetes

![image-20230709142838744](imgs/image-20230709142838744.png)

![image-20230709143405171](imgs/image-20230709143405171.png)

## kubernetes架构图

![image-20230709143616101](imgs/image-20230709143616101.png)

## K8S搭建安装示意图

![image-20230709143759170](imgs/image-20230709143759170.png)

## kubernetes基本术语和概念

![image-20230709143929098](imgs/image-20230709143929098.png)

![image-20230709144231644](imgs/image-20230709144231644.png)

Pod

![image-20230709144822072](imgs/image-20230709144822072.png)

![image-20230709144840514](imgs/image-20230709144840514.png)

label：类似于标签

service

![image-20230709145152014](imgs/image-20230709145152014.png)

横向扩展： Horizontal Pod Autoscaler





## kubernetes集群安装

### 安装docker

![image-20230709145439384](imgs/image-20230709145439384.png)

### docker cgroup driver修改

![image-20230709145621110](imgs/image-20230709145621110.png)

![image-20230709145715692](imgs/image-20230709145715692.png)

![image-20230709150140379](imgs/image-20230709150140379.png)

### cri-dockerd安装

https://github.com/Mirantis/cri-dockerd.git

容器运行时

![image-20230709150435404](imgs/image-20230709150435404.png)

#### 方法一  二进制直接下载

![image-20230709150504377](imgs/image-20230709150504377.png)

#### 方法二 下载源码docker构建

![image-20230709150558719](imgs/image-20230709150558719.png)

![image-20230709150626249](imgs/image-20230709150626249.png)

###  cri-dockerd服务配置和启动

![image-20230709150726400](imgs/image-20230709150726400.png)

![image-20230709151047716](imgs/image-20230709151047716.png)

![image-20230709150851251](imgs/image-20230709150851251.png)

![image-20230709151006788](imgs/image-20230709151006788.png)  实例文件

![image-20230709151125592](imgs/image-20230709151125592.png)

![image-20230709151139477](imgs/image-20230709151139477.png)

![image-20230709151222894](imgs/image-20230709151222894.png)

### cri-docer安装可能遇到的坑

1. 直接采用源码提供的service配置文件： cri-docker.service

![image-20230709151311912](imgs/image-20230709151311912.png)

2. 采用源码提供的sockert文件cri-docker.socket

   ![image-20230709151426110](imgs/image-20230709151426110.png)

3. 应用程序安装位置不明，配置文件是否有正确的引用应用程序，请检查路径和名称是否正确
4. 套接字路径是否正确，套接字名字是否一致，尤弥尔有再不经意间将cri-docker和cri-dockerd搞混了

### kubeadm工具

![image-20230709151828027](imgs/image-20230709151828027.png)

![image-20230709151951970](imgs/image-20230709151951970.png)

![image-20230709152006055](imgs/image-20230709152006055.png)

![image-20230709152131279](imgs/image-20230709152131279.png)

![image-20230709152145282](imgs/image-20230709152145282.png)

![image-20230709152239564](imgs/image-20230709152239564.png)

![image-20230709152248761](imgs/image-20230709152248761.png)

### 使用kubeadm初始化master节点

![image-20230709152506069](imgs/image-20230709152506069.png)

![image-20230709152901292](imgs/image-20230709152901292.png)

永久关闭swap

写到/etc/fstab

![image-20230709153027662](imgs/image-20230709153027662.png)

![image-20230709153043767](imgs/image-20230709153043767.png)![image-20230709153435346](imgs/image-20230709153435346.png)

```bash
sudo hostnamectl set-hostname k8s-node1
```

![image-20230709153126152](imgs/image-20230709153126152.png)

![image-20230709153217312](imgs/image-20230709153217312.png)

#### 生成默认配置文件

```bash
kubeadm config print init-defaults > init.default.yaml
```

需要修改的地方

![image-20230709154216882](imgs/image-20230709154216882.png)

![image-20230709154301889](imgs/image-20230709154301889.png)

==master配置==

![image-20230709154513639](imgs/image-20230709154513639.png)

#### 拉取相关镜像

```bash
sudo kubeadm config images pull --config=init.default.yaml
```

#### 初始化集群

```bash
# 二选一
# 通过配置文件初始化(推荐)
sudo kubeadm init --config=init.default.yaml

# 通过参数初始化
sudo kubeadm init --image-repository registry.aliyucs.com/google_containers --kubernetes-vers=1.24.1 ....
```

![image-20230709155725258](imgs/image-20230709155725258.png)

![image-20230709155631939](imgs/image-20230709155631939.png)

![image-20230709155253821](imgs/image-20230709155253821.png)

![image-20230709155511085](imgs/image-20230709155511085.png)

![image-20230709155827147](imgs/image-20230709155827147.png)
```bash
kubectl get pod --all-namespaces
```

![image-20230709155605385](imgs/image-20230709155605385.png)








#### 添加pod网络组件

![image-20230709155854391](imgs/image-20230709155854391.png)

![image-20230709155929862](imgs/image-20230709155929862.png)

![image-20230709155944785](imgs/image-20230709155944785.png)

github访问不了，修改host，然后重试

![image-20230709160032186](imgs/image-20230709160032186.png)

![image-20230709160050683](imgs/image-20230709160050683.png)

##### 开启kube-proxy的ipvs模式

![image-20230709160207852](imgs/image-20230709160207852.png)

![image-20230709160238426](imgs/image-20230709160238426.png)

![image-20230709160302084](imgs/image-20230709160302084.png)

![image-20230709160359114](imgs/image-20230709160359114.png)

### 重置节点



![image-20230709153556327](imgs/image-20230709153556327.png)

![image-20230709153934155](imgs/image-20230709153934155.png)

![image-20230709153818944](imgs/image-20230709153818944.png)

![image-20230709154133085](imgs/image-20230709154133085.png)

### node节点配置

![image-20230709160421428](imgs/image-20230709160421428.png)

![image-20230709160436317](imgs/image-20230709160436317.png)

![image-20230709160528315](imgs/image-20230709160528315.png)

137:

![image-20230709161344856](imgs/image-20230709161344856.png)

138:容器运行时

![image-20230709160757636](imgs/image-20230709160757636.png)

![image-20230709160845107](imgs/image-20230709160845107.png)

#### 删除节点

![image-20230709161237682](imgs/image-20230709161237682.png)

## 部署一个应用

### 创建一个myhello-rc.yaml:副本控制器

![image-20230709161412725](imgs/image-20230709161412725.png)

### 创建myhello-svc.yaml： 服务

![image-20230709161605687](imgs/image-20230709161605687.png)

### 创建资源+访问

![image-20230709161643879](imgs/image-20230709161643879.png)

![image-20230709161804948](imgs/image-20230709161804948.png)

![image-20230709161935688](imgs/image-20230709161935688.png)
