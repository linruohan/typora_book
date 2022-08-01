# 小满Vue3第三十八章（函数式编程，h函数）

[toc]

之前跟大家介绍了两种vue编写风格分别是template模板方式，和JSX方式感觉JSX被大家吐槽的很厉害，其实用习惯还挺好用的今天介绍第三种[函数式编程](https://so.csdn.net/so/search?q=函数式编程&spm=1001.2101.3001.7020)

主要会用到h函数

`h` 接收三个参数

- type 元素的类型
- propsOrChildren 数据对象, 这里主要表示(props, attrs, dom props, class 和 style)
- children 子节点

## h函数拥有多种组合方式

```kotlin
// 除类型之外的所有参数都是可选的
h('div')
h('div', { id: 'foo' })
 
//属性和属性都可以在道具中使用
//Vue会自动选择正确的分配方式
h('div', { class: 'bar', innerHTML: 'hello' })
 
// props modifiers such as .prop and .attr can be added
// with '.' and `^' prefixes respectively
h('div', { '.name': 'some-name', '^width': '100' })
 
// class 和 style 可以是对象或者数组
h('div', { class: [foo, { bar }], style: { color: 'red' } })
 
// 定义事件需要加on 如 onXxx
h('div', { onClick: () => {} })
 
// 子集可以字符串
h('div', { id: 'foo' }, 'hello')
 
//如果没有props是可以省略props 的
h('div', 'hello')
h('div', [h('span', 'hello')])
 
// 子数组可以包含混合的VNode和字符串
h('div', ['hello', h('span', 'hello')])
```

### 使用props传递参数

```xml
<template>
    <Btn text="按钮"></Btn>
</template>
  
<script setup lang='ts'>
import { h, } from 'vue';
type Props = {
    text: string
}
const Btn = (props: Props, ctx: any) => {
    return h('div', {
        class: 'p-2.5 text-white bg-green-500 rounded shadow-lg w-20 text-center inline m-1',
 
    }, props.text)
}
</script>
```

### 接受emit

```xml
<template>
    <Btn @on-click="getNum" text="按钮"></Btn>
</template>
  
<script setup lang='ts'>
import { h, } from 'vue';
type Props = {
    text: string
}
const Btn = (props: Props, ctx: any) => {
    return h('div', {
        class: 'p-2.5 text-white bg-green-500 rounded shadow-lg w-20 text-center inline m-1',
        onClick: () => {
            ctx.emit('on-click', 123)
        }
    }, props.text)
}
 
const getNum = (num: number) => {
    console.log(num);
}
</script>
```

### 定义[插槽](https://so.csdn.net/so/search?q=插槽&spm=1001.2101.3001.7020)

```xml
<template>
    <Btn @on-click="getNum">
        <template #default>
            按钮slots
        </template>
    </Btn>
</template>
  
<script setup lang='ts'>
import { h, } from 'vue';
type Props = {
    text?: string
}
const Btn = (props: Props, ctx: any) => {
    return h('div', {
        class: 'p-2.5 text-white bg-green-500 rounded shadow-lg w-20 text-center inline m-1',
        onClick: () => {
            ctx.emit('on-click', 123)
        }
    }, ctx.slots.default())
}
 
const getNum = (num: number) => {
    console.log(num);
}
</script>
```