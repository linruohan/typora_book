# 解决 wsl 环境变量 PATH 混乱的办法

需要关闭 win 与 wsl 的交互，即不互相运行对方的程序或文件
## 1 在 wsl 终端/etc/目录下新建 wsl. conf 文件
```bash
# /etc/wsl.conf
[interop]
enabled=false
appendWindowsPath=false
```
## 2 在 powershell (以管理员身份运行) 中重启 wsl
```bash
net stop LxssManager
net start LxssManager
```
