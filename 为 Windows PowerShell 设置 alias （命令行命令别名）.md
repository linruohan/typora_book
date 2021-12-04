# 为 Windows PowerShell 设置 alias （命令行命令别名）
使用过Linux的同学一定知道在Linux可以通过设置/home/目录下的.bashrc文件来设置命令行的别名，从而使经常使用的比较长的命令通过一个简化的别名来实现，可以大大的提高生产效率。


而现在呢，我想在Windows 的PowerShell实现相似的功能

## 1.创建并修改Windows Powershell 启动执行文件
```sh
执行echo $PROFILE命令，确定新建文件的名称和位置
echo $PROFILE

所以我们需要在C:\Users\username\Documents\WindowsPowerShell文件夹下新建Microsoft.PowerShell_profile.ps1文件
```

## 2 按格式输入命令
function 别名 { 需要替代的命令 }
例如我的一个sql 的命令
![](imgs/为 Windows PowerShell 设置 alias （命令行命令别名）0.png)
3 执行设定
以管理员 身份打开Powershell 执行命令Set-ExecutionPolicy RemoteSigned

4 重启Powershell
之后重启Powershell就大功告成啦！


 
显示推荐内容

