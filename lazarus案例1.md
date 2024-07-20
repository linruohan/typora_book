# Lazarus 案例
## 1 成品视图
![](imgs/lazarus案例1.png)
## 2 lazyrus安装在线包BGRAControls
![](imgs/lazarus案例1-2.png)
![](imgs/lazarus案例1-3.png)
## 3 MainForm 设置
![](imgs/lazarus案例1-1.png)
![](imgs/lazarus案例1-17.png)
### 3.1 pnlNav 设置
![](imgs/lazarus案例1-23.png)

![](imgs/lazarus案例1-4.png)
#### 3.1.1 PnlUser
![](imgs/lazarus案例1-7.png)

![](imgs/lazarus案例1-9.png)
#### 3.1.2 PnlNavButtons
![](imgs/lazarus案例1-22.png)
![](imgs/lazarus案例1-11.png)
![](imgs/lazarus案例1-16.png)
### 3.2 pnlMain 设置
![](imgs/lazarus案例1-5.png)

#### 3.2.1 nbkPages
![](imgs/lazarus案例1-20.png)
![](imgs/lazarus案例1-21.png)
![](imgs/lazarus案例1-6.png)

##### 3.2.1.1 Dashboard
![](imgs/lazarus案例1-24.png)
![](imgs/lazarus案例1-10.png)
###### 3.2.1.1.1 Dashboard. Panel 1
![](imgs/lazarus案例1-12.png)
###### 3.2.1.1.2 Dashboard. Panel 2

![](imgs/lazarus案例1-14.png)
###### 3.2.1.1.3 Dashboard. Panel 3
![](imgs/lazarus案例1-25.png)
![](imgs/lazarus案例1-15.png)
###### 3.2.1.1.4 Dashboard. Panel 4
![](imgs/lazarus案例1-13.png)

###### 3.2.1.1.5 Dashboard. Panel 5
![](imgs/lazarus案例1-18.png)

###### 3.2.1.1.6 Dashboard. Panel 6
![](imgs/lazarus案例1-26.png)

![](imgs/lazarus案例1-19.png)
##### 3.2.1.2 Video
	Index=1
	
![](imgs/lazarus案例1-28.png)
	
![](imgs/lazarus案例1-27.png)
![](imgs/lazarus案例1-29.png)



##### 3.2.1.3 Music

![](imgs/lazarus案例1-31.png)



##### 3.2.1.4 Book
![](imgs/lazarus案例1-32.png)




##### 3.2.1.5 Settings


![](imgs/lazarus案例1-34.png)




## 4 pages 切换
修改 pnlNavButtons 中每个按钮的 tag 值
根据 tag 值进行切换 pages
![](imgs/lazarus案例1-37.png)
除了 exit 其他都绑定 btnNavClick 函数
![](imgs/lazarus案例1-36.png)
exit 绑定
![](imgs/lazarus案例1-38.png)
![](imgs/lazarus案例1-40.png)
![](imgs/lazarus案例1-39.png)
![](imgs/lazarus案例1-35.png)
![](imgs/lazarus案例1-42.png)

formcreate formshow
![](imgs/lazarus案例1-41.png)


![](imgs/lazarus案例1-43.png)
##### 4.1.1.1 dashboard 鼠标事件
鼠标拖拽事件绑定，全局的
![](imgs/lazarus案例1-46.png)

![](imgs/lazarus案例1-45.png)
![](imgs/lazarus案例1-44.png)
##### 4.1.1.2 page 的鼠标拖拽
进度条事件
![](imgs/lazarus案例1-47.png)