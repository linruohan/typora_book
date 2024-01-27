# 让Everything爆改Windows！

原创 haooo丶 [程序员不高兴](javascript:void(0);) *2024-01-18 09:00* *发表于河南*

[toc]

最能向大厂打拳的欧盟，去年喜闻乐见地对着微软一顿胖揍。

其中有一条，Windows 系统搜索框被限定了搜索内容，这有违欧盟法案。

![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMOGWEn9eiagCDZDF5FyrCxN22WAlBueCAIfs3BsZlTIiaSIowE2sggXfA/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)

然后认栽的微软，安排了个欧盟特供版。

不过我想，很少有人会通过这个搜索框去百度吧，用起来肯定没有浏览器里方便。

以我自己的体验来说，更多是搜些本地文件。

当然，不是说咱们歧视系统搜索啊，一方面日常生活中用的少，再者搜索文件或文件夹的时候，它也确实不那么给力。

![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtM7t7miaG7dIqADwxic5ax5sxOhxMCC28GibVRhz4icNiaQwW7uSLkFwjojYw/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)

如果你要问搜索文件谁更直达？Everything 肯定当仁不让。

![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMeeUqU9j08asMLhyYpXqX2xlB91WuItgy3Hbr7h66KcZnggpwUJ4pEA/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)

## 有没有机会，让 Everything 取代这个系统搜索框呢？

搜了搜，两年前就关注的开源项目 Everything Toolbar 已经有了中文版本。

![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMIssgcqRFjdFu2ye21Ej6VibJdfVKjecswyIOqIDicEzPHXwHkRYwm5ibA/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)



### 功能就一个，把 Everything 无缝接入 Windows 任务栏，支持 Win10 和 Win11。



![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMeya8oF9NpS9HekTnmtrE0B9jI4eR9mranyHvHuibdMUbFx4rOiaecrQQ/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)



## Everything Toolbar

### 奉上链接——

Everything 官网：www.voidtools.com/zh-cn/

Everything Toolbar 蓝奏云：https://wwul.lanzouu.com/izW7I1le3mob

### 安装好 Everything Toolbar，它不会直接出现在你的任务栏，需要咱们右键任务栏开启。



![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMVUDNQW44WhkM0KSG7LwYjynlWeHEYIs7gPBHqMm8kSuCKbLdQE6nOQ/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)

放行后，搜索小图标会出现在右下角的托盘里，点击才会出现搜索框。

![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMqPIdpmKOJ3wQFqwkPsRWFfib8A41C4yJNictOgcFmbbapq00oxicfPLeA/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)

不对啊，这和想象中的替换大相径庭，我直接用 Everything 不是一样的效果嘛。

### 完美替换系统搜索---禁用系统搜索

并没有，`快捷键「Win+S」会唤出系统搜索`，在开始菜单直接搜索，唤出的也还是系统搜索。

这里附送大家一个单独禁用某一系统热键的小技巧——

1、快捷键「Win+R」打开运行，输入「regedit」打开注册表编辑器。

![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMBBUdXDgz6vNf1S3IViauSXpKicYkOdmEFcQ71kn2iaMbVD7MwCFM0e1yQ/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)



2、在注册表编辑器输入以下路径，按下回车。

```bash
计算机\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
```

![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMvv2ic5Gn25N7VqmgKYuOicico8e69ic06Nf3vdVMWMYxVrkOf05sLODSSg/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)

3、空白处右键新建一个字符串值，重命名为 DisabledHotkeys。



![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMXD2a1J1U4smG2LI5zPlt7enQ2losPIM2FwdXQxuh1tZ3KUTWHXSc8w/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)

4、双击打开这个新建项，你想禁用「Win+S」，数值数据那里填写「S」即可。

![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMYP8ASMg4xW9lUFFic8lDGqxicZdmRnm1MvlrWpkm2pKWHbqDlEcjoOxg/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)

拓展一下，如果你想禁用多个系统快捷键，比如「Win+H」也不想要了，那数值数据那里填写「SH」即可。

重启电脑或者重启文件管理器，这个修改就生效了。

单独禁用这个系统热键后，你在第三方软件上设置的快捷键就不会冲突了，Everything Toolbar 这里也是如此。

![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMZ2NErsZmLWOHOrJePskcI985Rgjqt1Bs14aiaVe56rUYFz0ic4lkfCvQ/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)

### 「替换开始菜单搜索」

至于开始菜单直接搜索，看到上图选项里「替换开始菜单搜索」的选项没，只要你勾选了，一个 Win 键按下去，直接用 Everything 搜就完事了。

![图片](https://mmbiz.qpic.cn/mmbiz_gif/bknH25gnEs6m8H6ffRhYbpJWCx335MtMNoNvr8hj32pNllawxSHzFppiady1b32DAVwhANRicFNicXLXhoZbOUqFA/640?wx_fmt=gif&from=appmsg&wxfrom=5&wx_lazy=1)

## 使用

对于搜索出来的结果，你可以右键快速操作。

![图片](https://mmbiz.qpic.cn/mmbiz_png/bknH25gnEs6m8H6ffRhYbpJWCx335MtMicXgIsWhhhSlKuicXTRFGGdhQVN987Kic9vlibMormiaDlHobecnLarq5jQ/640?wx_fmt=png&from=appmsg&wxfrom=5&wx_lazy=1&wx_co=1)

也可以和 QuickLook 联动，一个空格快速预览文件。

![图片](https://mmbiz.qpic.cn/mmbiz_gif/bknH25gnEs6m8H6ffRhYbpJWCx335MtM6dtslPIC05GE2ONKNBSYSo8rLYqYYekeyb3EgbKNH0b56OBqGRLyiag/640?wx_fmt=gif&from=appmsg&wxfrom=5&wx_lazy=1)

### 在搜索时，Everything 所支持的「区分大小写、全字匹配、匹配路径、正则表达式」，以及各种 Everything 的搜索语法，Everything Toolbar 也全都支持。



## 总结

总的来说，Everything Toolbar 这个工具，就是帮你多一种 Everything 融入系统后的使用姿势。

弱化了 Everything 第三方工具搜索的不适感，对我这样稍微有点强迫症的人来说，算得上最佳拍档了。

其实打开 Everything 的方式真的太多太多了，可以手动打开 Everything，可以固定到任务栏唤起，也支持全局快捷键等等。

虽然 Everything 的搜索能力无需多言，yyds 的那种存在，但我自己使用 Everything 的频率真不算高。

上一次用，是给某个软件打破解补丁的时候，发现默认目录里没东西，莫名其妙被装到了 C 盘角落。

可以不用，但绝不能没有，这也是我每次装完系统，都会老老实实把它下回来的原因。



