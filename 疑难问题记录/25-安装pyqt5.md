# [PyQt\]在Windows系统中安装PyQt5](https://www.cnblogs.com/syh6324/p/9484208.html)

##### 1. 安装PyQt5
`pip install PyQt5`
`pip install PyQt5 -i https://pypi.douban.com/simple`
`pip install PyQt5-tools`
`pip install PyQt5-tools -i https://pypi.douban.com/simple`

##### 3. 将PyQt5-tools的安装目录添加到系统环境变量Path中。

- 在桌面上右键单击“我的电脑”，在弹出的快捷菜单中选择“属性”->“高级系统设置”->“高级”，单击环境变量按钮，在系统变量Path中添加pyqt5-tools目录的绝对路径。
- 在Windows命令行输入Path命令。如果一切正常，则会在返回的Path路径中看到刚才配置的路径。

##### 4. 编写测试文件测试是否安装成功。代码如下：

```
import sys
from PyQt5.QtWidgets import QWidget, QApplication

app = QApplication(sys.argv)
widget = QWidget()
widget.resize(640, 480)
widget.setWindowTitle("Hello, PyQt5!")
widget.show()
sys.exit(app.exec())
```