# Sublime Text 3|4：添加右键用Sublime Text 打开文件和文件夹

## Win + R，输入regedit,打开注册表

## 文件

```bash
计算机\HKEY_CLASSESS_ROOT\*\Shell
新建项  用Sublime Text 4打开
在"用Sublime Text 4打开"上新建 字符串值，命名为 Icon  C:\software\SublimeText\sublime_text.exe,0
在"用Sublime Text 4打开"上新建 项，		命名为 Command C:\software\SublimeText\sublime_text.exe %1
```

## 文件夹

```bash
计算机\HKEY_CLASSES_ROOT\Directory\shell
新建项  用Sublime Text 4打开文件夹
在"用Sublime Text 4打开"上新建 字符串值，命名为 Icon  C:\software\SublimeText\sublime_text.exe,0
在"用Sublime Text 4打开"上新建 项，		命名为 Command C:\software\SublimeText\sublime_text.exe %1
```
