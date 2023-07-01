# 学习Vue3 第二十五章（TSX）

[toc]

我们之前呢是使用Template去写我们模板。现在可以扩展另一种风格TSX风格

vue2 的时候就已经支持jsx写法，只不过不是很友好，随着vue3对[typescript](https://so.csdn.net/so/search?q=typescript&spm=1001.2101.3001.7020)的支持度，tsx写法越来越被接受

## 1 1.安装插件

npm install @vitejs/plugin-vue-jsx -D

vite.config.ts 配置

![img](https://img-blog.csdnimg.cn/35486eb0bd1a4dabac0035384f877cbe.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)

```javascript
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueJsx from '@vitejs/plugin-vue-jsx';
// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(),vueJsx()]
})
```

## 2 2.修改tsconfig.json 配置文件

```json
    "jsx": "preserve",
    "jsxFactory": "h",
    "jsxFragmentFactory": "Fragment",
```

![img](https://img-blog.csdnimg.cn/e6d0ae1a4c254f13bde802f408fed4b3.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)

配置完成就可以使用啦

在目录新建一个xxxxxx.tsx文件

## 3 3.使用TSX

TIPS tsx不会自动解包使用ref加.vlaue ! ! !

### 3.1 tsx支持 v-[model](https://so.csdn.net/so/search?q=model&spm=1001.2101.3001.7020) 的使用

```typescript
 
import { ref } from 'vue'
 
let v = ref<string>('')
 
const renderDom = () => {
    return (
        <>
           <input v-model={v.value} type="text" />
           <div>
               {v.value}
           </div>
        </>
    )
}
 
export default renderDom
```

### 3.2 v-show

```javascript
 
import { ref } from 'vue'
 
let flag = ref(false)
 
const renderDom = () => {
    return (
        <>
           <div v-show={flag.value}>景天</div>
           <div v-show={!flag.value}>雪见</div>
        </>
    )
}
 
export default renderDom
```

### 3.3 ==v-if是不支持的==

所以需要改变风格

```javascript
import { ref } from 'vue'
 
let flag = ref(false)
 
const renderDom = () => {
    return (
        <>
            {
                flag.value ? <div>景天</div> : <div>雪见</div>
            }
        </>
    )
}
 
export default renderDom
```

### 3.4 ==v-for也是不支持的==

需要使用Map

```javascript
import { ref } from 'vue'
 
let arr = [1,2,3,4,5]
 
const renderDom = () => {
    return (
        <>
            {
              arr.map(v=>{
                  return <div>${v}</div>
              })
            }
        </>
    )
}
 
export default renderDom
```

### 3.5 v-bind使用

直接赋值就可以

```javascript
import { ref } from 'vue'
 
let arr = [1, 2, 3, 4, 5]
 
const renderDom = () => {
    return (
        <>
            <div data-arr={arr}>1</div>
        </>
    )
}
 
export default renderDom
```

### 3.6 v-on绑定事件 所有的事件都按照react风格来

- 所有事件有on开头
- 所有事件名称首字母大写

```javascript
 
const renderDom = () => {
    return (
        <>
            <button onClick={clickTap}>点击</button>
        </>
    )
}
 
const clickTap = () => {
    console.log('click');
}
 
export default renderDom
```

### 3.7 Props 接受值

```typescript
 import { ref } from 'vue'
 
type Props = {
    title:string
}
const renderDom = (props:Props) => {
    return (
        <>
            <div>{props.title}</div>
            <button onClick={clickTap}>点击</button>
        </>
    )
}
const clickTap = () => {
    console.log('click');
}
export default renderDom
```

### 3.8 Emit派发

```typescript
type Props = {
    title: string
}
const renderDom = (props: Props,content:any) => {
    return (
        <>
            <div>{props.title}</div>
            <button onClick={clickTap.bind(this,content)}>点击</button>
        </>
    )}
const clickTap = (ctx:any) => {
    ctx.emit('on-click',1)
}
```