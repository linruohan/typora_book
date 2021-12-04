![image-20200512212304432](D:\Typora_pic\image-20200512212304432.png)

## v-bind:   绑定vue的变量

![image-20200512212656084](D:\Typora_pic\image-20200512212656084.png)

## v-once:  只初始化一次

![image-20200512212831732](D:\Typora_pic\image-20200512212831732.png)

## 转义和不转义

![image-20200512213029635](D:\Typora_pic\image-20200512213029635.png)

![image-20200512213212532](D:\Typora_pic\image-20200512213212532.png)

## v-on:    监听事件

![image-20200512213514785](D:\Typora_pic\image-20200512213514785.png)

![image-20200512213904456](D:\Typora_pic\image-20200512213904456.png)

![image-20200512214149883](D:\Typora_pic\image-20200512214149883.png)

## 事件冒泡

![image-20200512214157658](D:\Typora_pic\image-20200512214157658.png)

![image-20200512214308498](D:\Typora_pic\image-20200512214308498.png)

```html
// 阻止冒泡
<a href="http://www.baidu.com" v-on:mousemove.stop=""></a>
// 阻止默认行为
<a href="http://www.baidu.com" v-on:click.prevent=""></a>

// 既阻止冒泡也阻止默认行为
<a href="http://www.baidu.com" v-on:mousemove.stop.prevent=""></a>
```

## 按键休止符

![image-20200512214744779](D:\Typora_pic\image-20200512214744779.png)

```
v-on:keyup.enter
v-on:keyup.space.
v-on:keyup.space.enter
v-on:keyup.space.13    #13代表回车键
```

## html模板

![image-20200512215247459](D:\Typora_pic\image-20200512215247459.png)

## 数据双向绑定

![image-20200512215613081](D:\Typora_pic\image-20200512215613081.png)

双向绑定

![image-20200512215644289](D:\Typora_pic\image-20200512215644289.png)

## 监听数据:

![image-20200512220139477](D:\Typora_pic\image-20200512220139477.png)

![image-20200512220422386](D:\Typora_pic\image-20200512220422386.png)

## 简写

```
v-on:click="increase"   @click="increase"
v-bind:title			:title
```

# Vue修改页面样式

<img src="D:\Typora_pic\image-20200512221317873.png" alt="image-20200512221317873" />

![image-20200512221700990](D:\Typora_pic\image-20200512221700990.png)

修改类class

![image-20200512221839513](D:\Typora_pic\image-20200512221839513.png)

修改样式

![image-20200512222047877](D:\Typora_pic\image-20200512222047877.png)

# 条件渲染 v-if

![image-20200512222419815](D:\Typora_pic\image-20200512222419815.png)

![image-20200512222718974](D:\Typora_pic\image-20200512222718974.png)

## 列表

![image-20200512222957343](D:\Typora_pic\image-20200512222957343.png)

![image-20200512223039939](D:\Typora_pic\image-20200512223039939.png)

## 对象

![image-20200512223156856](D:\Typora_pic\image-20200512223156856.png)

![image-20200512223230567](D:\Typora_pic\image-20200512223230567.png)

tempelete 模板容器,不会显示

![image-20200512223258658](D:\Typora_pic\image-20200512223258658.png)

![image-20200512223649605](D:\Typora_pic\image-20200512223649605.png)

![image-20200512223753544](D:\Typora_pic\image-20200512223753544.png)

![image-20200512223835589](D:\Typora_pic\image-20200512223835589.png)

![image-20200512224009909](D:\Typora_pic\image-20200512224009909.png)

# cli使用

## 组件

全局组件

![image-20200512225556963](D:\Typora_pic\image-20200512225556963.png)

![image-20200512225628313](D:\Typora_pic\image-20200512225628313.png)

局部组件

![image-20200512225753471](D:\Typora_pic\image-20200512225753471.png)

![image-20200512225858895](D:\Typora_pic\image-20200512225858895.png)

![image-20200512231719583](D:\Typora_pic\image-20200512231719583.png)

![image-20200512231738162](D:\Typora_pic\image-20200512231738162.png)

![image-20200512231743995](D:\Typora_pic\image-20200512231743995.png)

![image-20200512231858705](D:\Typora_pic\image-20200512231858705.png)

## 组件之间传值

![image-20200512232646241](D:\Typora_pic\image-20200512232646241.png)![image-20200512232915227](D:\Typora_pic\image-20200512232915227.png)