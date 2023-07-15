# 学习Vue3 第二十三章（依赖注入Provide / Inject）

[toc]

## Provide / Inject

通常，当我们需要从父组件向子组件传递数据时，我们使用 [props](https://v3.cn.vuejs.org/guide/component-props.html)。想象一下这样的结构：有一些[深度](https://so.csdn.net/so/search?q=深度&spm=1001.2101.3001.7020)嵌套的组件，而深层的子组件只需要父组件的部分内容。在这种情况下，如果仍然将 prop 沿着组件链逐级传递下去，可能会很麻烦。

官网的解释很让人疑惑，那我翻译下这几句话：

provide 可以在祖先组件中指定我们想要**提供**给后代组件的数据或方法，而在任何后代组件中，我们都可以使用 inject 来接收 provide **提供**的数据或方法。 

![img](https://img-blog.csdnimg.cn/img_convert/5f4ea9e16eda6e37ab336075a788ae15.png)

 看一个例子

### 父组件传递数据

```xml
<template>
    <div class="App">
        <button>我是App</button>
        <A></A>
    </div>
</template>
    
<script setup lang='ts'>
import { provide, ref } from 'vue'
import A from './components/A.vue'
let flag = ref<number>(1)
provide('flag', flag)
</script>
    
<style>
.App {
    background: blue;
    color: #fff;
}
</style>
```

### 子组件接受

```xml
<template>
    <div style="background-color: green;">
        我是B
        <button @click="change">change falg</button>
        <div>{{ flag }}</div>
    </div>
</template>
    
<script setup lang='ts'>
import { inject, Ref, ref } from 'vue'
 
const flag = inject<Ref<number>>('flag', ref(1))
 
const change = () => {
    flag.value = 2
}
</script>
    
<style>
</style>
```

 TIPS 你如果传递普通的值 是不具有响应式的 需要通过ref reactive 添加响应式

### 使用场景

当父组件有很多数据需要分发给其子代组件的时候， 就可以使用provide和inject。

# 学习Vue3 第二十四章（兄弟组件传参和Bus）

## 1.借助父组件传参

例如父组件为App 子组件为A 和 B他两个是同级的

```xml
<template>
    <div>
        <A @on-click="getFalg"></A>
        <B :flag="Flag"></B>
    </div>
</template>
    
<script setup lang='ts'>
import A from './components/A.vue'
import B from './components/B.vue'
import { ref } from 'vue'
let Flag = ref<boolean>(false)
const getFalg = (flag: boolean) => {
   Flag.value = flag;
}
</script>
    
<style>
</style>
```

A 组件派发事件通过App.vue 接受A组件派发的事件然后在Props 传给B组件 也是可以实现的

缺点就是比较麻烦 ，无法直接通信，只能充当桥梁

## 2.Event Bus

我们在Vue2 可以使用$emit 传递 $on监听 emit传递过来的事件

这个原理其实是运用了JS设计模式之发布订阅模式

我写了一个简易版

```typescript
 
type BusClass<T> = {
    emit: (name: T) => void
    on: (name: T, callback: Function) => void
}
type BusParams = string | number | symbol 
type List = {
    [key: BusParams]: Array<Function>
}
class Bus<T extends BusParams> implements BusClass<T> {
    list: List
    constructor() {
        this.list = {}
    }
    emit(name: T, ...args: Array<any>) {
        let eventName: Array<Function> = this.list[name]
        eventName.forEach(ev => {
            ev.apply(this, args)
        })
    }
    on(name: T, callback: Function) {
        let fn: Array<Function> = this.list[name] || [];
        fn.push(callback)
        this.list[name] = fn
    }
}
 
export default new Bus<number>()
```

然后挂载到Vue config 全局就可以使用啦

# 小满Vue3（Mitt）

在vue3中$on，$off 和 $once 实例方法已被移除，组件实例不再实现事件触发接口，因此大家熟悉的[EventBus](https://so.csdn.net/so/search?q=EventBus&spm=1001.2101.3001.7020)便无法使用了。然而我们习惯了使用EventBus，对于这种情况我们可以使用Mitt库（其实就是我们视频中讲的发布订阅模式的设计）

## 1.安装

```coffeescript
npm install mitt -S
```

## 2.main.ts 初始化

全局总线，vue 入口文件 main.js 中[挂载](https://so.csdn.net/so/search?q=挂载&spm=1001.2101.3001.7020)全局属性

```typescript
import { createApp } from 'vue'
import App from './App.vue'
import mitt from 'mitt'
 
const Mit = mitt()
 
//TypeScript注册
// 由于必须要拓展ComponentCustomProperties类型才能获得类型提示
declare module "vue" {
    export interface ComponentCustomProperties {
        $Bus: typeof Mit
    }
}
 
const app = createApp(App)
 
//Vue3挂载全局API
app.config.globalProperties.$Bus = Mit
 
app.mount('#app')
```



## 使用方法

## 通过emit派发， on 方法添加事件，off 方法移除，clear 清空所有

### A组件派发（emit）

```xml
<template>
    <div>
        <h1>我是A</h1>
        <button @click="emit1">emit1</button>
        <button @click="emit2">emit2</button>
    </div>
</template>
 
<script setup lang='ts'>
import { getCurrentInstance } from 'vue'
const instance = getCurrentInstance();
const emit1 = () => {
    instance?.proxy?.$Bus.emit('on-num', 100)
}
const emit2 = () => {
    instance?.proxy?.$Bus.emit('*****', 500)
}
</script>
 
<style>
</style>
```

### B组件[监听](https://so.csdn.net/so/search?q=监听&spm=1001.2101.3001.7020)（on）

```xml
<template>
    <div>
        <h1>我是B</h1>
    </div>
</template>
 
<script setup lang='ts'>
import { getCurrentInstance } from 'vue'
const instance = getCurrentInstance()
instance?.proxy?.$Bus.on('on-num', (num) => {
    console.log(num,'===========>B')
})
</script>
 
<style>
</style>
```

### 监听所有事件（ on("*") ）

```typescript
instance?.proxy?.$Bus.on('*',(type,num)=>{
    console.log(type,num,'===========>B')
})
```

### 移除监听事件（off）

```typescript
const Fn = (num: any) => {
    console.log(num, '===========>B')
}
instance?.proxy?.$Bus.on('on-num',Fn)//listen
instance?.proxy?.$Bus.off('on-num',Fn)//unListen
```

### 清空所有监听（clear）

```haskell
instance?.proxy?.$Bus.all.clear() 
```