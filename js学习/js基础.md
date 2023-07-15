## DOM简介
![](./imgs/image-20200731104633042.png)
![](./imgs/image-20200731104600119.png)

## 获取元素

* id获取
document.getElementById(‘’)

![](imgs/image-20200731105128181.png)

* 标签名获取 document.getElementsByTagName(‘’)

	![image-20200731105338811](./imgs/image-20200731105338811.png)

![](./imgs/image-20200731105605862.png)

![](./imgs/image-20200731105851419.png)

* html5新增的方法获取

![](./imgs/image-20200731110326623.png)

1. document.getElementsByClassName(‘类名’)
2. document.querySelector(‘选择器)   第一个(选择器需要加符号)
3. document.querySelectorAll(‘选择器)  所有的(选择器需要加符号)
4. ![image-20200731110427116](./imgs/image-20200731110427116.png)

* 特殊元素获取

![](./imgs/image-20200731110814587.png)

![](./imgs/image-20200731112512960.png)

## 事件基础

![](./imgs/image-20200731112628791.png)

![](./imgs/image-20200731112628791.png)



![](./imgs/image-20200731112727952.png)

## 操作元素

javascript的DOM曹祖哦可以改变网页内容,结构.样式.我们可以利用操作DOM元素来改变元素里面的内容属性等

### 改变元素内容

==element.innerText==: 从起始位置到终止位置的内容,去除html标签,且去掉空格和换行,不识别HTML标签

==element.innerHtml==: 从起始位置到终止位置的内容,包括html标签,也保留空格和换行,识别HTML标签 W3c标准

![](./imgs/image-20200731113715858.png)

### 修改属性

src href  id  alt  title

![](./imgs/image-20200731114430342.png)

![image-20200731114535151](./imgs/image-20200731114535151.png)

![](./imgs/image-20200731114809948.png)

### 表单元素的属性操作

type value checked selected disabled

![image-20200731115258091](./imgs/image-20200731115258091.png)

![image-20200731115817940](./imgs/image-20200731115817940.png)

![image-20200731120007543](./imgs/image-20200731120007543.png)

### 样式属性操作

元素的大小颜色位置

![](./imgs/image-20200731120250652.png)

![image-20200731120442632](./imgs/image-20200731120442632.png)

![image-20200731120903523](./imgs/image-20200731120903523.png)

![](./imgs/image-20200731121112094.png)

![image-20200731121424769](./imgs/image-20200731121424769.png)

![image-20200731121548691](./imgs/image-20200731121548691.png)

![image-20200731121934264](./imgs/image-20200731121934264.png)

![image-20200731121947113](./imgs/image-20200731121947113.png)

![image-20200731122613161](./imgs/image-20200731122613161.png)

![image-20200731122602636](./imgs/image-20200731122602636.png)

![image-20200731122724008](./imgs/image-20200731122724008.png)

## 节点操作

![image-20200731123350827](./imgs/image-20200731123350827.png)

![image-20200731123336544](./imgs/image-20200731123336544.png)

百度换肤

![image-20200731123907935](./imgs/image-20200731123907935.png)

![image-20200731123848290](./imgs/image-20200731123848290.png)

表格隔行换色:

![image-20200731123932809](./imgs/image-20200731123932809.png)

![image-20200731124205421](./imgs/image-20200731124205421.png)

![image-20200731124320628](./imgs/image-20200731124320628.png)

表单全选和取消全选

![image-20200731124741665](./imgs/image-20200731124741665.png)

![image-20200731125124446](./imgs/image-20200731125124446.png)

## 自定义属性的操作

![image-20200731125529040](./imgs/image-20200731125529040.png)

![image-20200731125431539](./imgs/image-20200731125431539.png)

![](./imgs/image-20200731125509126.png)

### tab栏切换

![image-20200731130032991](./imgs/image-20200731130032991.png)

![image-20200731130258647](./imgs/image-20200731130258647.png)

![image-20200731130402701](./imgs/image-20200731130402701.png)

![image-20200731130649678](./imgs/image-20200731130649678.png)

![image-20200731130728589](./imgs/image-20200731130728589.png)

![image-20200731130816244](./imgs/image-20200731130816244.png)