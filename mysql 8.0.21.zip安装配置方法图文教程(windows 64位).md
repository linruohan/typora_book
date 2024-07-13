# mysql 8.0.21.zip安装配置方法图文教程(windows 64位)

[toc]

## 先去[**官网**](https://dev.mysql.com/downloads/mysql/)**下载点击的MySQL的下载(借用网络图片，8.0.21)**

<img src="https://img.jbzj.com/file_images/article/201910/2019103084641336.jpg" alt="img" style="zoom: 50%;" />

```bash
# mysql国内镜像下载网址
http://mirrors.sohu.com/mysql/
http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/
http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-8.0/
```

![](imgs/image-20211214220413176.png)

## 下载完以后解压,新建data文件夹，复制粘贴my.ini文件

![image-20220621213507815](img/image-20220621213507815.png)

配置初始化的my.ini文件的文件:写入基本配置：

```
[mysqld] 
character-set-client-handshake = FALSE 
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci 
init_connect='SET NAMES utf8mb4'
sql_mode="STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION"
default_storage_engine=innodb
innodb_buffer_pool_size=1000M
innodb_log_file_size=50M
innodb_file_per_table=true
max_allowed_packet=500M
# 设置mysql的安装目录
basedir=D:\\software\\MySQL
# 设置mysql数据库的数据的存放目录
datadir=D:\\software\\MySQL\\data
# 允许最大连接数
max_connections=200
 
[mysql]
default-character-set = utf8mb4
 
[client]
default-character-set = utf8mb4
```

## 初始化MySQL

在安装时，避免出错我们尽量全部使用管理员身份运行CMD，否则在安装时会报错，会导致安装失败的情况

打开后进入mysql的bin目录

在MySQL目录下的bin目录下执行命令：

```bash
d:
cd D:\software\MySQL\bin
# mysql初始化
mysqld --initialize --console
# 删除mysql服务
sc delete mysql 
# 安装mysql服务 
mysqld --install
# 启动mysql服务
net start mysql
# 连接并修改密码
mysql -u root -p"初始化生成的密码字符串"
ALTER USER 'root'@'localhost' IDENTIFIED BY '新密码';
```

![](imgs/image-20211214221116172.png)

## mysql备份和恢复
### window下
1.导出整个数据库
```bash
mysqldump -u 用户名 -p 数据库名 > 导出的文件名
mysqldump -u dbuser -p dbname > dbname.sql
```
2.导出一个表
```bash
mysqldump -u 用户名 -p 数据库名 表名> 导出的文件名
mysqldump -u dbuser -p dbname users> dbname_users.sql
```
3.导出一个数据库结构
```bash
mysqldump -u dbuser -p -d --add-drop-table dbname >d:/dbname_db.sql
-d 没有数据 --add-drop-table 在每个create语句之前增加一个drop table
```
4.导入数据库，常用source 命令

```bash
进入mysql数据库控制台，如 mysql -u root -p
mysql>use 数据库;
然后使用source命令，后面参数为脚本文件(如这里用到的.sql)
mysql>source d:/dbname.sql;
mysql>exit
1. 导入数据到数据库
mysql -uroot -D数据库名 
1. 导入数据到数据库中得某个表
mysql -uroot -D数据库名  表名
> mysqldump -u root -p  erp lightinthebox_tags > lightinthebox.sql
```

### **linux下**

 一、导出数据库用mysqldump命令（注意mysql的安装路径，即此命令的路径）：

1、导出数据和表结构：

```bash
mysqldump -u用户名 -p密码 数据库名 > 数据库名.sql
#/usr/local/mysql/bin/  mysqldump -uroot -p abc > abc.sql
敲回车后会提示输入密码
```

2、只导出表结构

```bash
mysqldump -u用户名 -p密码 -d 数据库名 > 数据库名.sql
#/usr/local/mysql/bin/  mysqldump -uroot -p -d abc > abc.sql
注：/usr/local/mysql/bin/ ---> mysql的data目录
```

 二、导入数据库
1、首先建空数据库
2、导入数据库

```bash
mysql>create database abc;
方法一：
（1）选择数据库
mysql>use abc;
（2）设置数据库编码
mysql>set names utf8;
（3）导入数据（注意sql文件的路径）
mysql>source /home/abc/abc.sql;
方法二：
mysql -u用户名 -p密码 数据库名 < 数据库名.sql
\#mysql -uabc_f -p abc < abc.sql
```

