# 学习Vue3 第一章

[toc]

## 1.介绍vue

Vue (读音 /vjuː/，类似于 **view**) 是一套用于构建用户界面的**渐进式框架**。与其它大型[框架](https://so.csdn.net/so/search?q=框架&spm=1001.2101.3001.7020)不同的是，Vue 被设计为可以自底向上逐层应用。Vue 的核心库只关注视图层，不仅易于上手，还便于与第三方库或既有项目整合。另一方面，当与[现代化的工具链](https://cn.vuejs.org/v2/guide/single-file-components.html)以及各种[支持类库](https://github.com/vuejs/awesome-vue#libraries--plugins)结合使用时，Vue 也完全能够为复杂的单页应用提供驱动。

MVVM（Model-View-ViewModel）架构

1. 『View』：视图层（UI 用户界面）
2. 『ViewModel』：业务逻辑层（一切 js 可视为业务逻辑）
3. 『Model』：数据层（存储数据及对数据的处理如增删改查）

![img](https://img-blog.csdnimg.cn/a5c02dc81b9547a6bebfd9dbc3502687.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)



官方文档地址  [介绍 — Vue.js](https://cn.vuejs.org/v2/guide/#Vue-js-是什么)

[新版地址文档快速开始 | Vue.js](https://staging-cn.vuejs.org/guide/quick-start.html)

## 2.回顾vue2 对比 vue3

1. 发现传统的vue2: ==逻辑比较分散 可读性差 可维护性差==

2. 对比vue3 ==逻辑分明 可维护性 高==

![img](https://img-blog.csdnimg.cn/img_convert/e8ad905d83aaec45451797517ef453aa.png)

### 3.Vue3 新特性介绍

![img](https://img-blog.csdnimg.cn/f2c9d2e9576d46cf8a9a3e8abc5b31b2.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)

### 重写双向绑定

```javascript
vue2
基于Object.defineProperty()实现
 
vue3 基于Proxy
proxy与Object.defineProperty(obj, prop, desc)方式相比有以下优势：
 
//丢掉麻烦的备份数据
//省去for in 循环
//可以监听数组变化
//代码更简化
//可以监听动态新增的属性；
//可以监听删除的属性 ；
//可以监听数组的索引和 length 属性；
 
    let proxyObj = new Proxy(obj,{
        get : function (target,prop) {
            return prop in target ? target[prop] : 0
        },
        set : function (target,prop,value) {
            target[prop] = 888;
        }
    })
```

### Vue3 优化Vdom

**在Vue2中,每次更新diff,都是全量对比,Vue3则只对比带有标记的,这样大大减少了非动态内容的对比消耗**

[Vue Template Explorer](https://vue-next-template-explorer.netlify.app/) 我们可以通过这个网站看到静态标记

![img](https://img-blog.csdnimg.cn/0b5650888b95431c8682836a68e2ca98.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)

### patch flag 优化静态树

```css
<span>Hello world!</span>
<span>Hello world!</span>
<span>Hello world!</span>
<span>Hello world!</span>
<span>{{msg}}/span>
<span>Hello world!</span>
<span>Hello world! </span>
```

`Vue3` 编译后的 `Vdom` 是这个样子的

```php
export function render(_ctx，_cache，$props，$setup，$data，$options){return (_openBlock(),_createBlock(_Fragment,null，[
_createvNode( "span", null,"Hello world ! "),
_createvNode( "span",null，"Hello world! "),
_createvNode( "span"，null，"Hello world! "),
_createvNode( "span", null，"Hello world! "),
_createVNode("span", null，_toDisplaystring(_ctx.msg)，1/* TEXT */)，
_createvNode( "span", null，"Hello world! "),
_createvNode( "span", null，"Hello world! ")]，64/*STABLE_FRAGMENT */))
```

新增了 patch flag 标记

```crystal
TEXT = 1 // 动态文本节点
CLASS=1<<1,1 // 2//动态class
STYLE=1<<2，// 4 //动态style
PROPS=1<<3,// 8 //动态属性，但不包含类名和样式
FULLPR0PS=1<<4,// 16 //具有动态key属性，当key改变时，需要进行完整的diff比较。
HYDRATE_ EVENTS = 1 << 5，// 32 //带有监听事件的节点
STABLE FRAGMENT = 1 << 6, // 64 //一个不会改变子节点顺序的fragment
KEYED_ FRAGMENT = 1 << 7, // 128 //带有key属性的fragment 或部分子字节有key
UNKEYED FRAGMENT = 1<< 8, // 256 //子节点没有key 的fragment
NEED PATCH = 1 << 9, // 512 //一个节点只会进行非props比较
DYNAMIC_SLOTS = 1 << 10 // 1024 // 动态slot
HOISTED = -1 // 静态节点
BALL = -2
```

我们发现创建动态 dom 元素的时候，Vdom 除了模拟出来了它的基本信息之外，还给它加了一个标记： 1 /* TEXT */

这个标记就叫做 patch flag（补丁标记）

patch flag 的强大之处在于，当你的 diff 算法走到 _createBlock 函数的时候，会忽略所有的静态节点，只对有标记的动态节点进行对比，而且在多层的嵌套下依然有效。

尽管 JavaScript 做 Vdom 的对比已经非常的快，但是 patch flag 的出现还是让 Vue3 的 Vdom 的性能得到了很大的提升，尤其是在针对大组件的时候。

## Vue3 Fragment

vue3 允许我们支持多个根节点

```xml
<template>
  <div>12</div>
  <div>23</div>
</template>
```

同时支持render JSX 写法

```javascript
render() {
        return (
            <>
                {this.visable ? (
                    <div>{this.obj.name}</div>
                ) : (
                    <div>{this.obj.price}</div>
                )}
                <input v-model={this.val}></input>
                {[1, 2, 3].map((v) => {
                   return <div>{v}-----</div>;
                })}
            </>
        );
    },
```

同时新增了Suspense 和 多 v-model 用法



## Vue3 Tree shaking

简单来讲，就是在保持代码运行结果不变的前提下，去除无用的代码

在Vue2中，无论我们使用什么功能，它们最终都会出现在生产代码中。主要原因是Vue实例在项目中是单例的，捆绑程序无法检测到该对象的哪些属性在代码中被使用到

而Vue3源码引入tree shaking特性，将全局 API 进行分块。如果你不使用其某些功能，它们将不会包含在你的基础包中

就是比如你要用watch 就是import {watch} from 'vue' 其他的computed 没用到就不会给你打包减少体积


## Vue 3 Composition Api

Setup 函数式编程 也叫vue Hook

例如 ref reactive watch computed toRefs toRaws 我们会在下几个章节详解
