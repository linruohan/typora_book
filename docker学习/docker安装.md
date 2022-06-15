# 在Kali 安装Dockerr CE社区版 和 Docker Compose

## 安装依赖包

在安装Docker（Docker CE社区版）之前，需要安装所有依赖包，运行如下命令：通过确保已安装docker用作依赖项的所有软件包来开始安装。
```bash
sudo apt updatesudo apt -y install curl gnupg2 apt-transport-https software-properties-common ca-certificates 
```

## 导入Docker GPG密钥导入用于签署Docker软件包的Docker GPG密钥：

```bash
curl -fsSL https://download.docker.com/linux/debian/gpg 
sudo apt-key add gpg
```
## 将Docker储存库添加到Kali Linux系统中添加包含Docker CE最新稳定版本的Docker存储库：

```bash
echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" | sudo tee  /etc/apt/sources.list.d/docker.list
```
此命令会将存储库URL添加到/etc/apt/sources.list.d/docker.list。 

## 在Kali Linux上安装Docker更新apt包索引：

$ `sudo apt update`

![在Kali Linux版本中安装Docker（Docker CE社区版）和Docker Compose](https://ywnz.com/uploads/allimg/20/1-20021415531R49.JPG)

要在Kali Linux上安装Docker CE，请运行以下命令：
```bash
sudo apt install docker-ce docker-ce-cli containerd.io
```
按y键开始在Kali Linux上安装Docker：

![在Kali Linux版本中安装Docker（Docker CE社区版）和Docker Compose](https://ywnz.com/uploads/allimg/20/1-200214155331T3.JPG)


```bash
# 此安装会将docker组添加到系统中，而无需任何用户，
# 将用户帐户添加到组中，以非特权用户身份运行docker命令：
sudo usermod -aG docker $USER
newgrp docker
# 检查安装的Docker版本：$
docker version
```
![在Kali Linux版本中安装Docker（Docker CE社区版）和Docker Compose](https://ywnz.com/uploads/allimg/20/1-200214155342D4.JPG) 

## 在Kali Linux上安装Docker Compose

使用以下指南在Kali Linux上安装最新的Docker Compose：[在Linux系统上安装最新的Docker Compose](https://ywnz.com/linux/5729.html)。

下载最新的Compose二进制文件：

```bash
下载最新的Compose二进制文件：
curl -s https://api.github.com/repos/docker/compose/releases/latest \
| grep browser_download_url \
 | grep docker-compose-Linux-x86_64 \
 | cut -d '"' -f 4 \	
 | wget -qi -
使二进制文件可执行：
chmod +x docker-compose-Linux-x86_64
将文件移动到PATH：
sudo mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
确认版本：
$ docker-compose version
docker-compose version 1.24.1, build 4667896b
docker-py version: 3.7.3
CPython version: 3.6.8
OpenSSL version: OpenSSL 1.1.0j  20 Nov 2018
```





安装后，通过检查版本确认安装是否成功：$  `docker-compose version`

![在Kali Linux版本中安装Docker（Docker CE社区版）和Docker Compose](https://ywnz.com/uploads/allimg/20/1-200214155351Y6.JPG) 

## **六、测试Docker安装**

运行测试Docker容器：$ `docker run --rm -it  hello-world`
![在Kali Linux版本中安装Docker（Docker CE社区版）和Docker Compose](https://ywnz.com/uploads/allimg/20/1-200214155401A6.JPG) 

## **七、测试Docker Compose安装**

```bash
# 创建一个测试Docker Compose文件：
$ vim docker-compose.yml
# 将以下数据添加到文件中：
version: '3'  services:web:image: nginx:latestports:- "8080:80"links:- phpphp:image: php:7-fpm

# 启动服务容器：
$ docker-compose up -d
```
![在Kali Linux版本中安装Docker（Docker CE社区版）和Docker Compose](https://ywnz.com/uploads/allimg/20/1-200214155411118.JPG)
显示正在运行的容器：`$ docker-compose ps`
![在Kali Linux版本中安装Docker（Docker CE社区版）和Docker Compose](https://ywnz.com/uploads/allimg/20/1-200214155421314.JPG)
停止容器的命令：
`$ docker-compose stop`
`$ docker-compose rm`
![在Kali Linux版本中安装Docker（Docker CE社区版）和Docker Compose](https://ywnz.com/uploads/allimg/20/1-200214155430X2.JPG) 

**相关主题**[在Linux系统下使用Docker Compose管理Docker容器](https://ywnz.com/linuxjc/6232.html)