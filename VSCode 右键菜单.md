# 右键菜单，用 VSCode 打开文件和文件夹
## 1 重装软件（不推荐）
在装的过程中勾选上这2个选项即可
![](https://upload-images.jianshu.io/upload_images/17855471-2a1f68247e040135.png?imageMogr2/auto-orient/strip|imageView2/2/w/365/format/webp)
## 2 修改注册表
 1, `Win+R` 打开运行，输入 `regedit`，打开 `注册表`，找到
 ![](https://upload-images.jianshu.io/upload_images/17855471-8c00684b0394661c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1047/format/webp)
### 2.1 右键打开文件
```bash
计算机\HKEY_CLASSES_ROOT\*\shell   # 如果没有，“`新建`－`项`”，建立shell分支。
	VisualCode  
	  默认  数据：用 Code 打开文件
	  Command #VisualCode下
		  默认 数据：D:\software\VSCode\Code.exe %1   # %1表示要打开的文件参数
```
### 2.2 右键打开文件夹
```bash
计算机\HKEY_CLASSES_ROOT\Directory\shell
	VisualCode 
	  默认  数据：用 Code 打开文件夹
	  Command #VisualCode下
		  默认 数据：D:\software\VSCode\Code.exe %1   # %1表示要打开的文件参数
```
### 2.3 空白处打开
```bash
计算机\HKEY_CLASSES_ROOT\Directory\Background\shell\
	VisualCode 
	  默认  数据：用 Code 打开
	  Command #VisualCode下
		  默认 数据：D:\software\VSCode\Code.exe %V   # %1表示要打开的文件参数
```