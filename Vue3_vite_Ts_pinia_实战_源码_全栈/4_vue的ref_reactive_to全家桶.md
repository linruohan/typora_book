# 学习Vue3 第六章（认识Ref全家桶）

[toc]



## ref

接受一个内部值并返回一个响应式且可变的 ref 对象。ref 对象仅有一个 `.value` property，指向该内部值。

我们这样操作是无法改变message 的值 应为message 不是响应式的无法被vue 跟踪要改成ref

```xml
<template>
  <div>
    <button @click="changeMsg">change</button>
    <div>{{ message }}</div>
  </div>
</template>
<script setup lang="ts">
let message: string = "我是message"
 
const changeMsg = () => {
   message = "change msg"
}
</script>
<style>
</style>
```

改为ref: Ref TS对应的接口

```r
interface Ref<T> {
  value: T
}
```

> <font color=red>注意被ref包装之后需要.value 来进行赋值</font>

```vue
<template>
  <div>
    <button @click="changeMsg">change</button>
    <div>{{ message }}</div>
  </div>
</template>
<script setup lang="ts">
import {ref,Ref} from 'vue'
let message:Ref<string> = ref("我是message")
// let message = ref<string | number>("我是message")
const changeMsg = () => {
   message.value = "change msg"
}
</script>
<style>
</style>
```

## `isRef`

```
import { ref, Ref,isRef } from 'vue'
let message: Ref<string | number> = ref("我是message")
let notRef:number = 123
const changeMsg = () => {
  message.value = "change msg"
  console.log(isRef(message)); //true
  console.log(isRef(notRef)); //false
}
```

## `shallowRef`

创建一个跟踪自身 `.value` 变化的 ref，但不会使其值也变成响应式的

修改其属性是非响应式的这样是不会改变的

```vue
<template>
  <div>
    <button @click="changeMsg">change</button>
    <div>{{ message }}</div>
  </div>
</template>
<script setup lang="ts">
import { Ref, shallowRef } from 'vue'
type Obj = {
  name: string
}
let message: Ref<Obj> = shallowRef({
  name: "小满"
})
 
const changeMsg = () => {
  message.value.name = '大满'
  message.value={name:"打满"}   //这样是可以被监听到的修改value
}
</script>
 
 
<style>
</style>
```

## triggerRef

强制更新页面DOM:这样也是可以改变值的

```vue
<template>
  <div>
    <button @click="changeMsg">change</button>
    <div>{{ message }}</div>
  </div>
</template>
 <script setup lang="ts">
import { Ref, shallowRef,triggerRef } from 'vue'
type Obj = {
  name: string
}
let message: Ref<Obj> = shallowRef({
  name: "小满"
})
 
const changeMsg = () => {
  message.value.name = '大满'
 triggerRef(message)
}
</script> 
 
 
<style>
</style>
```

## customRef

自定义ref :customRef 是个工厂函数要求我们返回一个对象 并且实现 get 和 set

```vue
<script setup lang="ts">
import { Ref, shallowRef, triggerRef, customRef } from 'vue'
 
function MyRef<T>(value: T) {
  return customRef((track, trigger) => {
    return {
      get() {
        track() //收集依赖
        return value
      },
      set(newVal: T) {
        console.log('set');
        value = newVal
        trigger() // 更新触发器
      }
    }
  })
}
 
let message = MyRef('小满')
const changeMsg = () => {
  message.value = '大满'
  // triggerRef(message)
}
</script> 
```

# 学习Vue3 第七章（认识Reactive全家桶）

## `reactive`

```
用来绑定复杂的数据类型 例如 对象 数组
```

reactive [源码](https://so.csdn.net/so/search?q=源码&spm=1001.2101.3001.7020)约束了我们的类型

![img](https://img-blog.csdnimg.cn/4bea460f515a479d82e650c29ee00a99.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)

### `他是不可以绑定普通的数据类型`这样是不允许 会给我们报错

```javascript
import { reactive} from 'vue'
let person = reactive('sad')
```

![img](https://img-blog.csdnimg.cn/c6b228aafa654e9c893614116cac764c.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)

绑定普通的数据类型 我们可以 使用昨天讲到ref

你如果用ref去绑定对象 或者 [数组](https://so.csdn.net/so/search?q=数组&spm=1001.2101.3001.7020) 等复杂的数据类型 我们看源码里面其实也是 去调用reactive

> 使用reactive 去修改值无须.value

## reactive 基础用法

```javascript
import { reactive } from 'vue'
let person = reactive({
   name:"小满"
})
person.name = "大满"
```

数组异步赋值问题

这样赋值页面是不会变化的因为会脱离响应式

```typescript
let person = reactive<number[]>([])
setTimeout(() => {
  person = [1, 2, 3]
  console.log(person);
  
},1000)
```

### 解决方案1：使用push

```typescript
import { reactive } from 'vue'
let person = reactive<number[]>([])
setTimeout(() => {
  const arr = [1, 2, 3]
  person.push(...arr)
  console.log(person);
  
},1000)
```

### 方案2： 包裹一层对象

```typescript
type Person = {
  list?:Array<number>
}
let person = reactive<Person>({
   list:[]
})
setTimeout(() => {
  const arr = [1, 2, 3]
  person.list = arr;
  console.log(person);
  
},1000)
```

## readonly

拷贝一份proxy对象将其设置为只读

```objectivec
import { reactive ,readonly} from 'vue'
const person = reactive({count:1})
const copy = readonly(person)
 
 //person.count++
 
 copy.count++
```

## shallowReactive

只能对浅层的数据 如果是深层的数据只会改变值 不会改变视图

案例

```vue
<template>
  <div>
    <div>{{ state }}</div>
    <button @click="change1">test1</button>
    <button @click="change2">test2</button>
  </div>
</template>
<script setup lang="ts">
import { shallowReactive } from 'vue'
const obj = {
  a: 1,
  first: {
    b: 2,
    second: {
      c: 3
    }
  }
}
const state = shallowReactive(obj)
 
function change1() {
  state.a = 7
}
function change2() {
  state.first.b = 8
  state.first.second.c = 9
  console.log(state);
}
</script> 
<style>
</style>
```

# 学习Vue3 第八章（认识to系列全家桶）

## toRef

如果原始对象是非响应式的就不会更新视图 数据是会变的

```xml
<template>
   <div>
      <button @click="change">按钮</button>
      {{state}}
   </div>
</template>
 
<script setup lang="ts">
import { reactive, toRef } from 'vue'
 
const obj = {
   foo: 1,
   bar: 1
}
 
 
const state = toRef(obj, 'bar')
// bar 转化为响应式对象
 
const change = () => {
   state.value++
   console.log(obj, state);
 
}
</script>
```

如果原始对象是响应式的是会更新视图并且改变数据的

## toRefs

可以帮我们批量创建ref对象主要是方便我们解构使用

```vue
import { reactive, toRefs } from 'vue'
const obj = reactive({
   foo: 1,
   bar: 1
})
 
let { foo, bar } = toRefs(obj)
 
foo.value++
console.log(foo, bar);
```

## toRaw

将响应式对象转化为普通对象

```vue
import { reactive, toRaw } from 'vue'
 
const obj = reactive({
   foo: 1,
   bar: 1
})
 
 
const state = toRaw(obj)
// 响应式对象转化为普通对象
 
const change = () => {
 
   console.log(obj, state);
 
}
```
