# 1.python获取windows软件安装列表

[![img](D:\Typora_pic\noavatar_middle.gif)](https://blog.51cto.com/11072687)

[youjiabest](https://blog.51cto.com/11072687)关注1人评论[8726人阅读](javascript:;)[2016-03-18 10:48:47](javascript:;)

  windows系统会在两个地方记录软件列表：

64位：HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall

32位：HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall



这两个注册表存储的软件会重复，所以我们还要去重



  我们使用python的标准库_winreg来获取软件安装列表，并输出到文件中，代码如下：

```python
#!/usr/bin/python

import os
import socket
import _winreg

#将软件安装列表输出到网盘上
os.system(r'net use p: \\10.0.0.6\public password /user:Lc\tanjun')

#使用主机名命名软件安装列表
hostname = socket.gethostname()
file = open(r'P:\todo\temp\%s.txt' % hostname, 'a')

#需要遍历的两个注册表
sub_key = [r'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall', r'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall']

software_name = []

for i in sub_key:
    key = _winreg.OpenKey(_winreg.HKEY_LOCAL_MACHINE, i, 0, _winreg.KEY_ALL_ACCESS)
    for j in range(0, _winreg.QueryInfoKey(key)[0]-1):
        try:
            key_name = _winreg.EnumKey(key, j)
            key_path = i + '\\' + key_name
            each_key = _winreg.OpenKey(_winreg.HKEY_LOCAL_MACHINE, key_path, 0, _winreg.KEY_ALL_ACCESS)
            DisplayName, REG_SZ = _winreg.QueryValueEx(each_key, 'DisplayName')
            DisplayName = DisplayName.encode('utf-8')
            software_name.append(DisplayName)
        except WindowsError:
            pass

#去重排序
software_name = list(set(software_name))
software_name = sorted(software_name)

for result in software_name:
    file.write(result + '\n')
```



结果如下：

```bash
[root@netserver temp]# cat op-tanjun3.txt | egrep -v "Microsoft|NVIDIA|Intel"
360安全卫士
64 Bit HP CIO Components Installer
Adobe AIR
Adobe Flash Player 21 NPAPI
Adobe Flash Player 21 PPAPI
Adobe Reader XI (11.0.15) - Chinese Simplified
Java 7 Update 79
Java 7 Update 79 (64-bit)
Java Auto Updater
KeyPass
Pidgin
PyQt GPL v4.10.2 for Python v2.7 (x64)
Python 2.7.3 (64-bit)
Realtek High Definition Audio Driver
Remote Desktop Organizer
Shotgun Integration
Sublime Text 2.0.2
Synology Assistant (remove only)
TeamViewer 11
VMware Workstation
VMware vSphere Client 6.0
WinRAR 5.30 (64-位)
Xshell 5
bl
hppLaserJetService
ph
tools-freebsd
tools-linux
tools-netware
tools-solaris
tools-winPre2k
tools-windows
搜狗拼音输入法 7.9正式版
腾讯QQ
英特尔? 芯片组设备软件
```