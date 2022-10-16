# [PyQt5 打造编辑器](https://www.cnblogs.com/aloe-n/p/9583949.html)

## 效果如下

- 多标签
- 智能提示
- 快捷键
  ![img](https://img2018.cnblogs.com/blog/1176578/201809/1176578-20180904135007320-465221616.png)

## 思路

编辑器(右侧部分)采用 monaco editor ，monaco editor是微软开源的编辑器，使用TypeScript编写，是大名鼎鼎的VSCode编辑器的内核。所以其使用习惯和VSCode完全相同。 [monaco editor](https://microsoft.github.io/monaco-editor/)

monaco editor 是需要运行在浏览器中的（supports IE 11, Edge, Chrome, Firefox, Safari and Opera.), 那么怎么能将它嵌入Qt中呢? Qwebengineview 控件可以帮我们实现.

## 1. 定义编辑器类

Editor类继承自QWebEngineView,所以才能使用load方法加载本地HTML文件

```Python
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

```html
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

![img](https://img2018.cnblogs.com/blog/1176578/201810/1176578-20181025214610227-930301139.png)

## 2. 在主界面中添加编辑器标签(多标签的实现)

- 增加标签
- 关闭标签

QTabwidget刚好可以满足多标签的需求,下面有几个问题要解决:

1. 每个标签右上角显示关闭按钮
   默认情况下,标签是不显示关闭按钮的,可以通过设置`self.tabWidget.setTabsClosable(True)`方法显示出关闭按钮.

2. 关闭按钮点击事件

   ```Python
   self.tabWidget.tabCloseRequested.connect(self.closeTab)
   
   def closeTab(self):
   # 获取当前处于激活状态的标签
   i = self.tabWidget.currentIndex()
   self.tabWidget.removeTab(i)
   ```

3. 增加页面

   ```Python
   new_tab = Editor(self)
   self.tabWidget.addTab(new_tab, tab_name)
   self.tabWidget.setCurrentWidget(new_tab)
   ```