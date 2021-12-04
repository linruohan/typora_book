Win10下git的安装与配置
1. 注册。在github上注册一个账号
2. 下载git
安装完成后将安装目录\cmd\git.exe加入到系统环境变量 Path 中，打开 cmd 输入 git --version 命令查看一下是否安装成功。

配置环境变量
右击此电脑 → 属性 → 高级系统设置 → 环境变量 → 在系统变量中找到path，添加 安装目录\cmd\git.exe

安装成功 


3. 配置
    打开gitbash，设置你的名字和email,这些是在提交commit时的签名

  

  ```shell
  git config --global user.name linruohan
  
  git config --global user.email "mjt1220@126.com"
  ```

生成ssh-key

```
mkdir ~/.ssh && cd ~/.ssh && ssh-keygen -t rsa -C "mjt1220@126.com"
```

4. 连接客户端与github
这里以github为例，可以根据实际情况连接不同的服务器。
打开github
setting → SSH and GPG keys → New SSH key

title可以自定义，用文本编辑器打开id_rsa.pub将里面的内容复制到key 
，Add SSH key。

连接完毕
------------------------------------------------
版权声明：本文为CSDN博主「yoolemon」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/lemon_cookie/article/details/79058151