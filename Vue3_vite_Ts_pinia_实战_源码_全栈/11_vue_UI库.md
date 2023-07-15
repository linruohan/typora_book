# 学习Vue3 第三十一章（了解UI库ElementUI，AntDesigin等）

[toc]



**vue**作为一款深受广大群众以及尤大崇拜者的喜欢，特此列出在[github](https://so.csdn.net/so/search?q=github&spm=1001.2101.3001.7020)上开源的vue优秀的UI组件库供大家参考

这两套框架主要用于后台管理系统的制作，方便开发者快速开发

## element-plus安装方法

```ruby
# NPM
$ npm install element-plus --save
 
# Yarn
$ yarn add element-plus
 
# pnpm
$ pnpm install element-plus
```

### main ts引入

```javascript
import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import App from './App.vue'
 
const app = createApp(App)
 
app.use(ElementPlus)
app.mount('#app')
```

###  volar插件支持

```json
{
  "compilerOptions": {
    // ...
    "types": ["element-plus/global"]
  }
}
```

## **Element UI Plus**

[一个 Vue 3 UI 框架 | Element Plus](https://element-plus.gitee.io/zh-CN/)

![img](https://img-blog.csdnimg.cn/467a8bb4606b4ab69a0b76385b167616.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)

## Ant Design Vue

### 安装

```ruby
$ npm install ant-design-vue@next --save
$ yarn add ant-design-vue@next
```

### 使用

```javascript
import { createApp } from 'vue';
import Antd from 'ant-design-vue';
import App from './App';
import 'ant-design-vue/dist/antd.css';
 
const app = createApp(App);
 
app.use(Antd).mount('#app');
```

![img](https://img-blog.csdnimg.cn/008d5f5946aa45e28eac035c2a8f6781.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)

 https://next.antdv.com/docs/vue/introduce-cn