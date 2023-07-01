# computed用法

计算属性就是当依赖的属性的值发生变化的时候，才会触发他的更改，如果依赖的值，不发生变化的时候，使用的是缓存中的属性值。

## 1 函数形式

```typescript

import { computed, reactive, ref } from 'vue'
let price = ref(0)//$0
 
let m = computed<string>(()=>{
   return `$` + price.value
})
 
price.value = 500
```

## 2 对象形式

```xml
<template>
   <div>{{ mul }}</div>
   <div @click="mul = 100">click</div>
</template>
 
<script setup lang="ts">
import { computed, ref } from 'vue'
let price = ref<number | string>(1)//$0
let mul = computed({
   get: () => {
      return price.value
   },
   set: (value) => {
      price.value = 'set' + value
   }
})
</script>
 
<style>
</style>
```

## 3 computed购物车案例

```xml
<template>
   <div>
      <table style="width:800px" border>
         <thead>
            <tr>
               <th>名称</th>
               <th>数量</th>
               <th>价格</th>
               <th>操作</th>
            </tr>
         </thead>
         <tbody>
            <tr :key="index" v-for="(item, index) in data">
               <td align="center">{{ item.name }}</td>
               <td align="center">
                  <button @click="AddAnbSub(item, false)">-</button>
                  {{ item.num }}
                  <button @click="AddAnbSub(item, true)">+</button>
               </td>
               <td align="center">{{ item.num * item.price }}</td>
               <td align="center">
                  <button @click="del(index)">删除</button>
               </td>
            </tr>
         </tbody>
         <tfoot>
            <tr>
               <td></td>
               <td></td>
               <td></td>
               <td align="center">总价:{{ $total }}</td>
            </tr>
         </tfoot>
      </table>
   </div>
</template>
 
<script setup lang="ts">
import { computed, reactive, ref } from 'vue'
type Shop = {
   name: string,
   num: number,
   price: number
}
let $total = ref<number>(0)
const data = reactive<Shop[]>([
   {
      name: "小满的袜子",
      num: 1,
      price: 100
   },
   {
      name: "小满的裤子",
      num: 1,
      price: 200
   },
   {
      name: "小满的衣服",
      num: 1,
      price: 300
   },
   {
      name: "小满的毛巾",
      num: 1,
      price: 400
   }
])
 
const AddAnbSub = (item: Shop, type: boolean = false): void => {
   if (item.num > 1 && !type) {
      item.num--
   }
   if (item.num <= 99 && type) {
      item.num++
   }
}
const del = (index: number) => {
   data.splice(index, 1)
}

$total = computed<number>(() => {
   return data.reduce((prev, next) => {
      return prev + (next.num * next.price)
   }, 0)
})
 
 
 
</script>
 
<style>
</style>
```

# 学习Vue3 第十章（认识watch侦听器）

## 1 `watch` 需要侦听特定的数据源，并在单独的回调函数中执行副作用

watch第一个参数[监听](https://so.csdn.net/so/search?q=监听&spm=1001.2101.3001.7020)源

watch第二个参数回调函数cb（newVal,oldVal）

watch第三个参数一个options配置项是一个对象{

immediate:true //是否立即调用一次

deep:true //是否开启[深度](https://so.csdn.net/so/search?q=深度&spm=1001.2101.3001.7020)监听

}

### 1.1 监听Ref 案例

```javascript
import { ref, watch } from 'vue'
 
let message = ref({
    nav:{
        bar:{
            name:""
        }
    }
})
 
 
watch(message, (newVal, oldVal) => {
    console.log('新的值----', newVal);
    console.log('旧的值----', oldVal);
},{
    immediate:true,
    deep:true
})
```

### 1.2 监听多个ref 注意变成数组啦

```javascript
import { ref, watch ,reactive} from 'vue'
 
let message = ref('')
let message2 = ref('')
 
watch([message,message2], (newVal, oldVal) => {
    console.log('新的值----', newVal);
    console.log('旧的值----', oldVal);
})
```

### 1.3 监听Reactive

使用reactive监听深层对象开启和不开启deep 效果一样

```javascript
import { ref, watch ,reactive} from 'vue'
 
let message = reactive({
    nav:{
        bar:{
            name:""
        }
    }
}) 
watch(message, (newVal, oldVal) => {
    console.log('新的值----', newVal);
    console.log('旧的值----', oldVal);
})
```

#### 1.3.1 案例2 监听reactive 单一值

```javascript
import { ref, watch ,reactive} from 'vue'
 
let message = reactive({
    name:"",
    name2:""
})
watch(()=>message.name, (newVal, oldVal) => {
    console.log('新的值----', newVal);
    console.log('旧的值----', oldVal);
})
```

# 学习Vue3 第十一章（认识watchEffect高级侦听器）

## 1 **watchEffect**

立即执行传入的一个函数，同时响应式追踪其依赖，并在其依赖变更时重新运行该函数。

如果用到message 就只会[监听](https://so.csdn.net/so/search?q=监听&spm=1001.2101.3001.7020)message 就是用到几个监听几个 而且是非惰性 会默认调用一次

```csharp
let message = ref<string>('')
let message2 = ref<string>('')
 watchEffect(() => {
    //console.log('message', message.value);
    console.log('message2', message2.value);
})
```

### 1.1 清除副作用

就是在触发监听之前会调用一个函数可以处理你的逻辑例如防抖

```typescript
import { watchEffect, ref } from 'vue'
let message = ref<string>('')
let message2 = ref<string>('')
 watchEffect((oninvalidate) => {
    //console.log('message', message.value);
    oninvalidate(()=>{ //在触发之前，执行该函数，类似于before
        
    })
    console.log('message2', message2.value);
})
```

### 1.2 **停止跟踪 watchEffect 返回一个函数 调用之后将停止更新**

```js
const stop =  watchEffect((oninvalidate) => {
    //console.log('message', message.value);
    oninvalidate(()=>{
 
    })
    console.log('message2', message2.value);
},{
    flush:"post",
    onTrigger () { //执行时触发的函数
 		debugger  //进入调试
    }
})
stop()
```

 

## 2 **更多的配置项**

### 2.1 副作用刷新时机 flush 一般使用post

|          | pre                | sync                 | post               |
| :------- | :----------------- | :------------------- | :----------------- |
| 更新时机 | 组件**更新前**执行 | 强制效果始终同步触发 | 组件**更新后**执行 |

### 2.2 **onTrigger 可以帮助我们调试 watchEffect**

```typescript
import { watchEffect, ref } from 'vue'
let message = ref<string>('')
let message2 = ref<string>('')
 watchEffect((oninvalidate) => {
    //console.log('message', message.value);
    oninvalidate(()=>{
 
    })
    console.log('message2', message2.value);
},{
    flush:"post",
    onTrigger () {
        
    }
})
```