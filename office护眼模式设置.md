# office软件设置成护眼模式

[toc]

## `regedit`打开注册表

## 第一步：修改第一个[注册表]

```
HKEY_CURRENT_USER\Control Panel\colors
```

![img](https://pic1.zhimg.com/80/v2-f712489363e1471785cb9bfef60542a4_1440w.jpg)

4. 双击点开，可以看到系统默认[数值](https://www.zhihu.com/search?q=数值&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A395219681})为255 255 255；
5. 此时，我们把数值修改成202 234 206并点击确定；

## **第二步：修改第二个注册表**

```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\DefaultColors\Standard
```

双击点开，系统默认数值为ffffff=\=> caeace  ==(选择[十六进制])==

![img](https://pic1.zhimg.com/80/v2-246d375a1ed679d3ef353cc42427da48_1440w.jpg)

## 设置word护眼模式

### 新建一个word空白文档；

![img](https://pic1.zhimg.com/80/v2-3b0d78091172aaa4c5bc143eb8deef5c_1440w.jpg)

### 依次点开“设计-页面颜色”，选择自己想要的背景色。

一般豆沙绿的参数是：红：202，绿：234，蓝：202。  `202 234 202`

![img](https://pic1.zhimg.com/80/v2-4b670e10e705e4e43105ecd7dd290770_1440w.jpg)

### 打开此为office的默认模板存放位置,替换模板文件

```
%AppData%\Microsoft\Templates
```

找到原默认模板Normal.dotm，可以重命名之（Normal.dotm源文件）或直接改个后缀使之暂时不可用。然后把刚刚新建的模板文件复制到本文件夹中，注意新建的模板一定要重命名为Normal.dotm；

![img](https://pic2.zhimg.com/80/v2-fee5d0ed0d76a1a6234136696b0abfa9_1440w.jpg)

### ==问题：并不是所有word文档会变成浅绿色，只有从桌面的右击新建出来的文档才是浅绿色==

## 重启或注销电脑