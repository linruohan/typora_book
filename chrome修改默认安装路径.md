## 1 自定义谷歌浏览器Chrome安装路径的方法
安装完毕，先关闭自动启动的Google Chrome。
```
剪切安装目录：C:\Program Files (x86)\Google\Chrome\Application
移动并重命名：D:\software\Chrome
			新建 D:\software\Chrome\UserData
```
1. 剪切“Application”目录），再粘贴到新位置 `D:\software\`（并重命名为 Chrome），可能会有提示：文件夹访问被拒绝，你需要提供管理员权限才能复制此文件夹。点击“继续”，开始剪切：
2. 在 `D:\software\Chrome` 新建 UserData 目录
3. 在 `D:\software\Chrome\chrome.exe` 右键新建快捷方式，快捷方式右键属性，
```bash
target 修改为   D:\software\Chrome\chrome.exe –user-data-dir=UserData
```
4. 将原来用户数据移到`D:\software\Chrome\UserData`
```bash
C:\Users\xiaohan\AppData\Local\Google\Chrome\User Data
```
5. 将快捷方式移动道桌面，并删除其他的 chrome 快捷方式