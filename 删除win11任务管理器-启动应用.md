# 删除win11任务管理器“启动应用”
## 注册表中删除
win+r,输入regedit
```bash
计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run 

计算机\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run

计算机\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run
```

## 启动中删除
 C:\Users\用户名\AppData\Roaming\Microsoft\Windows\开始菜单\程序\启动
