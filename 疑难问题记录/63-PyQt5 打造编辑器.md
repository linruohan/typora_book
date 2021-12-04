[![返回主页](F:\Typora_book\typora_pic\logo-1576291678027.gif)](https://www.cnblogs.com/aloe-n/)

# [PyQt5 打造编辑器](https://www.cnblogs.com/aloe-n/p/9583949.html)

## 效果如下

- 多标签
- 智能提示
- 快捷键
  ![img](F:\Typora_book\typora_pic\1176578-20180904135007320-465221616.png)

## 思路

编辑器(右侧部分)采用 monaco editor ，monaco editor是微软开源的编辑器，使用TypeScript编写，是大名鼎鼎的VSCode编辑器的内核。所以其使用习惯和VSCode完全相同。 [monaco editor](https://microsoft.github.io/monaco-editor/)

monaco editor 是需要运行在浏览器中的（supports IE 11, Edge, Chrome, Firefox, Safari and Opera.), 那么怎么能将它嵌入Qt中呢? Qwebengineview 控件可以帮我们实现.

## 1. 定义编辑器类

Editor类继承自QWebEngineView,所以才能使用load方法加载本地HTML文件

```python
import os
from PyQt5 import QtWidgets
from PyQt5.QtCore import QUrl
from PyQt5.QtWebEngineWidgets import QWebEngineView


class Editor(QWebEngineView):
    def __init__(self, par):
        super().__init__(par)
        self.editor_flag = []

        # 这里是本地html路径,需根据实际情况进行修改.
        self.editor_index = (os.path.split(os.path.realpath(__file__))[0]) + "/../utils/index.html"
        self.load(QUrl.fromLocalFile(self.editor_index))

    def get_value(self, callback):
        """设置编辑器内容"""
        self.page().runJavaScript("monaco.editor.getModels()[0].getValue()", callback)

    def set_value(self, data):
        """获取编辑器内容"""
        import base64
        data = base64.b64encode(data.encode())
        data = data.decode()
        self.page().runJavaScript("monaco.editor.getModels()[0].setValue(Base.decode('{}'))".format(data))

    def change_language(self, lan):
        """切换智能提示语言"""
        self.page().runJavaScript("monaco.editor.setModelLanguage(monaco.editor.getModels()[0],'{}')".format(lan))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    w = Editor(None)
    w.setWindowTitle('Editor')
    w.show()
    sys.exit(app.exec_())
```

index.html 其实就是monaco editor 的入口,内容如下:

**引入的monaco editor文件需要自行下载 [下载地址](https://microsoft.github.io/monaco-editor/)**

```
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <style type="text/css">
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
    </style>
</head>
<body>

<div id="container" style="width:100%;height:100%"></div>

<!-- 引入base64方法,设置编辑器内容时使用-->
<script src="./base64.js"></script>   
<!-- 根据实际路径进行修改 -->
<script src="./package/dev/vs/loader.js"></script>
<script>
    // <!-- 根据实际路径进行修改 -->
    require.config({paths: {'vs': './package/dev/vs'}});
    require(['vs/editor/editor.main'], function () {
        monaco.languages.typescript.javascriptDefaults.setDiagnosticsOptions({
        noSemanticValidation: true,
        noSyntaxValidation: true
    });
        editor = monaco.editor.create(document.getElementById('container'), {
            value: "",
            language: 'javascript',  //默认语言
            mouseWheelZoom:true,     // 鼠标滚轮缩放
            wordWrap:"on",           // 自动换行
            scrollBeyondLastLine:false,
            minimap:{
                enabled:false          // 显示右侧小地图
            }
        });
        window.onresize = function () {
            editor.layout();
        };
    });
</script>
</body>
</html>
```

启动后效果如下:

![img](F:\Typora_book\typora_pic\1176578-20181025214610227-930301139.png)

## 2. 在主界面中添加编辑器标签(多标签的实现)

- 增加标签
- 关闭标签

QTabwidget刚好可以满足多标签的需求,下面有几个问题要解决:

1. 每个标签右上角显示关闭按钮
   默认情况下,标签是不显示关闭按钮的,可以通过设置`self.tabWidget.setTabsClosable(True)`方法显示出关闭按钮.

2. 关闭按钮点击事件

   ```
   self.tabWidget.tabCloseRequested.connect(self.closeTab)
   
   def closeTab(self):
   # 获取当前处于激活状态的标签
   i = self.tabWidget.currentIndex()
   self.tabWidget.removeTab(i)
   ```

3. 增加页面

   ```
   new_tab = Editor(self)
   self.tabWidget.addTab(new_tab, tab_name)
   self.tabWidget.setCurrentWidget(new_tab)
   ```

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](F:\Typora_book\typora_pic\icon_weibo_24.png)](javascript:void(0);) [![img](F:\Typora_book\typora_pic\wechat.png)](javascript:void(0);)

[Aloe_n](https://home.cnblogs.com/u/aloe-n/)
[关注 - 0](https://home.cnblogs.com/u/aloe-n/followees/)
[粉丝 - 4](https://home.cnblogs.com/u/aloe-n/followers/)

[+加关注](javascript:void(0);)

1

0

[« ](https://www.cnblogs.com/aloe-n/p/9583909.html)上一篇： [python RSA 相关方法](https://www.cnblogs.com/aloe-n/p/9583909.html) 
[» ](https://www.cnblogs.com/aloe-n/p/9774744.html)下一篇： [windows平台下mysql 8.0 免安装版配置步骤](https://www.cnblogs.com/aloe-n/p/9774744.html)

posted @ 2018-09-04 13:50 [Aloe_n](https://www.cnblogs.com/aloe-n/) 阅读(1104) 评论(3) [编辑 ](https://i.cnblogs.com/EditPosts.aspx?postid=9583949)[收藏](javascript:void(0))





评论列表

 

[#1楼](https://www.cnblogs.com/aloe-n/p/9583949.html#4176799) 2019-02-09 22:52 [fenger2508](https://home.cnblogs.com/u/1599928/)

大神，你好，向你请教一个问题，“启动后效果如下:” 要怎么做才能出现那个效果呢，我是新手，还请耐心解答一下，谢谢。qq: 1831722663

[支持(0) ](javascript:void(0);)[反对(0)](javascript:void(0);)

 

[#2楼](https://www.cnblogs.com/aloe-n/p/9583949.html#4329988) 2019-08-18 19:27 [無駄、無馱](https://www.cnblogs.com/ffqk/)

大神在么,这个<script src="./base64.js"></script> 引入的base64.js是什么文件,我的弄好了,但是编辑器无法输入中文,只能输入英文

[支持(0) ](javascript:void(0);)[反对(0)](javascript:void(0);)

 

[#3楼](https://www.cnblogs.com/aloe-n/p/9583949.html#4330330) [楼主] 2019-08-19 10:18 [Aloe_n](https://www.cnblogs.com/aloe-n/)

[@](https://www.cnblogs.com/aloe-n/p/9583949.html#4329988) 無駄、無馱
应该是编辑器IME的问题,试试搜狗输入法可以不.

[支持(0) ](javascript:void(0);)[反对(0)](javascript:void(0);)



[刷新评论](javascript:void(0);)[刷新页面](https://www.cnblogs.com/aloe-n/p/9583949.html#)[返回顶部](https://www.cnblogs.com/aloe-n/p/9583949.html#top)

注册用户登录后才能发表评论，请 [登录](javascript:void(0);) 或 [注册](javascript:void(0);)， [访问](https://www.cnblogs.com/) 网站首页。

[【推荐】超50万行VC++源码: 大型组态工控、电力仿真CAD与GIS源码库](http://www.ucancode.com/index.htm)
[【推荐】腾讯云热门云产品限时秒杀，爆款1核2G云服务器99元/年！](https://cloud.tencent.com/act/seckill?fromSource=gwzcw.3168381.3168381.3168381&utm_medium=cpc&utm_id=gwzcw.3168381.3168381.3168381)
[【推荐】阿里云双11返场来袭，热门产品低至一折等你来抢！](http://click.aliyun.com/m/1000081987/)
[【推荐】物理看板和电子看板该如何选择？](https://bbs.huaweicloud.com/forum/thread-24443-1-1.html)
[【活动】京东云服务器_云主机低于1折，低价高性能产品备战双11](https://www.jdcloud.com/cn/activity/year-end?utm_source=DMT_cnblogs&utm_medium=CH&utm_campaign=q4vm&utm_term=Virtual-Machines)
[【活动】ECUG For Future 技术者的年度盛会（杭州，1月4-5日）](http://hdxu.cn/JH9N4)

<iframe id="google_ads_iframe_/1090369/C1_0" title="3rd party ad content" name="google_ads_iframe_/1090369/C1_0" width="300" height="250" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" srcdoc="" data-google-container-id="1" data-load-complete="true" style="margin: 0px; padding: 0px; border: 0px; vertical-align: bottom;"></iframe>
<iframe id="google_ads_iframe_/1090369/C2_0" title="3rd party ad content" name="google_ads_iframe_/1090369/C2_0" width="468" height="60" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" srcdoc="" data-google-container-id="2" data-load-complete="true" style="margin: 0px; padding: 0px; border: 0px; vertical-align: bottom;"></iframe>
**最新 IT 新闻**: 
· [突发！村田关闭中国2家工厂！](https://news.cnblogs.com/n/651918/) 
· [世界多个人脸识别系统被“欺骗”，美国 AI 公司称用 3D 面具即可破解](https://news.cnblogs.com/n/651917/) 
· [华为荣获国内首家5G核心网电信设备进网许可证](https://news.cnblogs.com/n/651916/) 
· [了不起的 AirPods](https://news.cnblogs.com/n/651915/) 
· [新发现：热传递的第四种方式](https://news.cnblogs.com/n/651914/) 
» [更多新闻...](https://news.cnblogs.com/)

**历史上的今天：** 
2018-09-04 [python RSA 相关方法](https://www.cnblogs.com/aloe-n/p/9583909.html) 

Copyright © 2019 Aloe_n 
Powered by .NET Core 3.1.0 on Linux