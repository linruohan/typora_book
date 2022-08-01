# 解决npm WARN config global `--global`, `--local` are deprecated. Use `--location=global` instead.

## 一.问题

导入项目到[vscode](https://so.csdn.net/so/search?q=vscode&spm=1001.2101.3001.7020),然后npm install你会遇到下面这个错误问题
npm WARN config global `--global`, `--local` are deprecated. Use `--location=global` instead.

**node.js安装后，执行npm报错npm WARN config global `--global`, `--local` are deprecated. Use `--location=global` instead.**

## 二、解决方法

打开nodejs安装的本地电脑路径
![在这里插入图片描述](https://img-blog.csdnimg.cn/b4468d2bb5cb43cbb45bd9bea616f3d0.png)
打开编辑
![在这里插入图片描述](https://img-blog.csdnimg.cn/9ace26f42ecb44329356892094116785.png)

需要进行修改
![在这里插入图片描述](https://img-blog.csdnimg.cn/a04bb9751f9c452b9bfbcaaf168e175a.png)

进入编辑，修改下面这个命令
![在这里插入图片描述](https://img-blog.csdnimg.cn/cc30ff069dbb413eb673557d0b0af2a1.png)
重新打开cmd,输入npm -v
![在这里插入图片描述](https://img-blog.csdnimg.cn/e5eb553511d54d0cb0ce06adcfd4ca1e.png)