# pyqt5-QWidget-窗口状态(最大化最小化等)

### 0.1 设置窗口状态

```python
self.setWindowState(state)     #设置窗口状态
self.setWindowState(Qt.WindowMaximized)
```
1. Qt.WindowNoState 无状态-正常状态
2. Qt.WindowMinimized   最小化
3. Qt.WindowMaximized   最大化
4. Qt.WindowFullScreen  全屏
5. Qt.WindowActive   活动窗口

### 0.2 获取窗口状态

```python
self.windowState()  `  #返回窗口状态
self.showMaximized() 
```

1. 
   showFullScreen()   全屏显示  不包含窗口框架

2. showMaximized()   最大化    包括窗口框架

3. showMinimized()   最小化

4. showNormal()    正常

5. isMinimized()   是否是最小化窗口

6. isMaximized()   是否是最大化窗口

7. isFullScreen()   是否全屏


### 0.3 close()  控件关闭函数

self.close()

### 0.4 隐藏放大缩小和关闭按钮

```
​```python
# 标题栏如何隐藏放大缩小按钮
self.window.setWindowFlags(QtCore.Qt.WindowTitleHint|QtCore.Qt.WindowCloseButtonHint)
# 固定窗口大小
self.window.setFixedSize(100,200)
```