## 解决idea——Terminal配置git-bash 中文乱码
我们配置idea 的终端为git 的bash.cmd 之后会出现中文乱码

解决方法：

==git的安装路径下etc文件下有个 bash.bashrc 文件，在这个文件末尾追加：==
```sh
export LANG="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"
```
比如我的git 安装路径就是 :C:\Program Files\Git
我修改的就是：C:\Program Files\Git\etc\bash.bashrc 文件

