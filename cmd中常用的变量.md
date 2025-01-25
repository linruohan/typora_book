# 1 Windows使用cmd命令行中查看、修改、删除与添加环境变量
您可以在cmd中使用SET,显示或设置环境变量。
## 1 查看环境变量
### 1.1 查看当前所有可用的环境变量
输入 set 即可查看。
[![image](https://img2020.cnblogs.com/blog/24244/202004/24244-20200401091834275-1832507858.png "image")](https://img2020.cnblogs.com/blog/24244/202004/24244-20200401091833830-179372823.png)
### 1.2 查看某个环境变量
输入 “set 变量名”即可。比如想查看path变量的值，即输入 set path
[![image](https://img2020.cnblogs.com/blog/24244/202004/24244-20200401091834938-495275966.png "image")](https://img2020.cnblogs.com/blog/24244/202004/24244-20200401091834618-38337214.png)
## 2 修改环境变量（临时）
注意：所有的在cmd命令行下对环境变量的修改<font color=#81B300>只对当前窗口有效，不是永久性的修改</font>。也就是说当关闭此cmd命令行窗口后，将不再起作用。
<span style="background:red">永久性修改</span>环境变量的方法有两种：
1. 一种是直接修改注册表，
2. 另一种是通过我的电脑-〉属性-〉高级，来设置系统的环境变量（查看详细）。
### 2.1 修改环境变量(覆盖写)
```bash
# set 变量名=变量内容    指用现在的内容去覆盖以前的内容
set path="d:\nmake.exe"
```
### 2.2 设置为空：
```bash
set 变量名=
```
### 2.3 3、给变量追加内容
```bash
set 变量名=%变量名%;变量内容
set path=%path%;c:
```
## 3 一些常用的环境变量
```bash
%AllUsersProfile% : C:\ProgramData
%AppData% : C:\Users\Administrator\AppData\Roaming
%Cd% : C:\Users\Administrator
%CmdCmdLine% : "C:\WINDOWS\system32\cmd.exe"
%CmdExtVersion% : 2
%CommonProgramFiles% : C:\Program Files\Common Files
%ComputerName% : DESKTOP-I3HQO5I
%ComSpec% : C:\WINDOWS\system32\cmd.exe
%Date% : 2025/01/24 周五
%ErrorLevel% : 0
%HomeDrive% : C:
%HomePath% : \Users\Administrator
%HomeShare% : %HomeShare%
%LogonSever% : %LogonSever%
%Number_Of_Processors% : 16
%Os% : Windows_NT
%Path% : C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\WINDOWS\system32;C:\.....
%PathExt% : .COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
%Processor_Architecture% : AMD64
%Processor_Identfier% : %Processor_Identfier%
%Processor_Level% : 6
%Processor_Revision% : 9702
%ProgramFiles% : C:\Program Files
%Prompt% : $P$G
%Random% : 6399
%SystemDrive% : C:
%SystemRoot% : C:\WINDOWS
%Temp% : C:\Users\ADMINI~1\AppData\Local\Temp
%Time% : 20:41:50.69
%UserDomain% : DESKTOP-I3HQO5I
%UserName% : Administrator
%UserProfile% : C:\Users\Administrator
%WinDir% : C:\WINDOWS
```

