# VueJS简明教程(一)之基本使用方法

如果说是JQuery是手工作坊，那么Vue.js就像是一座工厂，虽然Vue.js做的任何事情JQuery都可以做，但无论是代码量还是流程规范性都是前者较优。

[toc]

在桌面建立一个 Vue.html文件, 然后引入 vue.js的CDN地址 **https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js**

### 1 基本使用

```html
<!DOCTYPE html>
<html>
<head>
    <title>Vue Demo</title>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>//引用vue.js
</head>
<body>
    <div id="firstVue">
    {{my_data}}
    </div>
</body>
<script type="text/javascript">
    var myVue = new Vue({
        el:"#firstVue",
        data:{
            my_data: "test"
        }
    })
</script>
</html>
```

`data`参数用来绑定VUE实例的数据变量，每个不同变量之间用逗号分隔，上面我们绑定了自定义变量`my_data`，并赋初值'test'

完成数据绑定工作，``标签里的`{{myData}}`数据会随着myVue实例里的`myData`数据的变动而变动，浏览器查看当前页面,会出现'test'字符串，说明数据绑定成功

### 2 属性绑定 –v-bind

这是在HTML标签内部的数据绑定，那么如果想绑定某个HTML标签的属性值，就要用到`v-bind:`属性了，比如我想绑定一个标签是否可见的属性(hidden)，那么就应该这么写:

`v-bind:`不仅可以绑定hidden属性，disabled属性，style属性, color属性，凡是标签有的属性，都可以通过这个方法进行绑定

```js
<div id="firstVue" v-bind:hidden="my_hidden">{{my_data}}</div>
//`v-bind`由于经常会用到，所以也可以缩写成冒号`:`，比如上面的``标签就完全可以这样写
<div id="firstVue" :hidden="my_hidden">{{my_data}}</div>

//`v-bind:`后面写想要绑定的属性，`my_hidden`也不需要用两个大括号括起来了，直接写就可以了，然后在VUE实例中声明这个绑定数据
<script>
var myVue = new Vue({
    el:'#firstVue',
    data:{
        my_data: "test",
        my_hidden: "hidden",//div标签的hidden属性被激活了
    }
})
</script>

```

### 3 事件绑定 –v-on

`v-bind:`是用来绑定数据的，`v-on:`则是用来绑定事件的，比如我要绑定一个``的 `click`事件就这么写

```html
<!DOCTYPE html>
<html>
<head>
    <title>Vue Demo</title>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
</head>
<body>
    <div id="firstVue">
        <button v-on:click="clickButton">Click Me</button>
        <button @click="clickButton">Click Me</button>
        <!--另外，`v-on:`语法同样有一个缩写`@`，比如`v-on:click="clickButton"`就等价于`@click="clickButton"` -->
        <p>{\{my_data\}}</p>
    </div>
    <script>
        var myVue = new Vue({
            el:'#firstVue',
            data:{
                my_data: "test",
                my_hidden: "hidden"
            },
            methods:{
                clickButton:function(){
                    this.my_data = "Wow! I'm changed!"
                    //如果不加`this`，系统会默认你想引用的是一个全局变量，可是这里我们需要引用的是这个vue实例里的局部变量
                }
            }
        })
    </script>
</body>
</html>
```

### 4 表单控件绑定  – v-model

从DOM中实时获取用户输入的数据赋值给vue实例:

Vue.js提供[语法糖](https://baike.baidu.com/item/语法糖/5247005?fr=aladdin) `v-model` ,从DOM传送给vue实例数据。

```html
<!DOCTYPE html>
<html>
<head>
    <title>Vue Demo</title>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
</head>
<body>
    <div id="firstVue">
        <input type="text" v-model="my_data" />
        <button v-on:click="clickButton">Click Me</button>
        <p>{{my_data}}</p>
    </div>
</body>
<script type="text/javascript">
    var myVue = new Vue({
        el:'#firstVue',
        data:{
            my_data: "test",
            my_hidden: "hidden"
        },
        methods:{
            clickButton:function(){
                this.my_data = "Wow! I'm changed!"
            }
        }
    })
</script>
</html>
```

可以发现，我们增加了一个`input`标签，并且用v-model语法绑定了之前定义的变量my_data

这个时候，当我们在``输入框输入值的时候，v-model会实时将最新值(value)赋值给vue实例的`my_data`变量，而`my_data`变量又将实时展现在``标签中

这样我们看起来实现了这么一个数据流:

**DOM1(input标签)——>VUE——>DOM2(p标签)**

先从用户输入的DOM1获取输入保存在VUE实例，用从VUE实例里拿到数据输出到DOM2

运行这个页面，发现``标签中的内容会随着``标签实时的变化，说明我们利用v-model语法变相实现了数据的双向传递

# 总结

看看我们学到了什么

- 用 `new Vue({})`新建vue实例
- 使用 `v-bind:`和`{{}}`双大括号语法在html中绑定变量
- 使用 `v-on:` 和 `@` 语法绑定函数到标签的事件
- 使用 `v-model:` 语法使用户的页面输入反向传递回vue实例变量

现在简单完善一下上面的代码，做成一个计数器程序，用户可以在输入框输入任意数字，点击按钮进行总数

```html
<!DOCTYPE html>
<html>
<head>
    <title>Vue Demo</title>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
</head>
<body>
    <div id="firstVue">
        <input type="number" v-model.number="my_step" />
        <!-- `.number`的意思是说在返回`my_step`值的时候自动转换成integer类型，因为默认是string类型，所以要多这么一句。-->
        <button v-on:click="clickButton">Add</button>
        <p>{{my_total}}</p>
    </div>
</body>
<script type="text/javascript">
    var myVue = new Vue({
        el:'#firstVue',
        data:{
            my_step: 1,
            my_total: 0
        },
        methods:{
            clickButton:function(){
                this.my_total = this.my_total + this.my_step
            }
        }
    })
</script>
</html>
```

##  组件Component

> 组件(Component)是Vue最强大的功能之一。组件可以扩展HTML元素，封装可重用的代码。在较高层面上，组件是自定义元素，Vue的编译器为它添加特殊功能。
>  在有些情况下，组件也可以表现为用is特性进行了扩展的原生HTML元素。
>  所有的Vue组件同时也都是Vue的实例，所以可以接受相同的选项对象（除了一些根级特有的选项）并提供相同的生命周期钩子。

### 1注册组件

```js
Vue.component('button-demo',{
    template:'<button>Hello here!</button>'
})
//通过Vue注册一个叫做'button-demo'的组件，这个自定义组件是由<button>Hello here!</button>组成的。	
//可以这么理解，注册了'button-demo'以后，</button-demo>就等价于<button>Hello here!</button>
==============================================================================
//通过Vue注册的组件只能在Vue的注册范围内用，就像演示里面一样，必须要<div id="app"></div>里面用
==============================================================================
```

VUE组件当然不可能就只能组合组合html标签，每一个VUE组件对相当于一个VUE实例，在组件内可以==定义方法，数据，甚至可以引用其他组件==

```js
//定义button-counter组件
Vue.component('button-counter',{
    //定义数据  一个组件的 data 选项必须是一个函数，这样每个实例可以维护一份被返回对象的独立的拷贝
    data:function(){
        return {
            count: 0
        }
    },
    data:()=>({count:0}),
    //定义方法
    methods:{
        clickAdd: function(){
            this.count++
        }
    },
    template:'<button @click="clickAdd">You clicked me {{count}} times</button>'
})
```

### 2 全局注册与局部注册

上面我们注册的是==全局组件==，也就是在整个VUE根实例中注册的，也可以理解为调用了VUE的静态方法注册的，这样注册的组件是可以在==任何VUE实例中==使用的。

不过这样也会带来作用域冲突的麻烦，比如我分别注册了一个前端`HOME`组件和一个后端`ADMIN`组件，又想注册两个`HEAD`组件分别用在`HOME`和`ADMIN`组件里面，代表前台后台不同的页头，这时候如果是全局注册为了区分不同的`HEAD`组件，我可能就需要为他们起两个名字，分别叫`HOME_HEAD`和`ADMIN_HEAD`。

但是局部组件注册就允许用户把自定义组件的作用域限制在父级VUE实例中：

```js
//component-a是一个全局组件
Vue.component('component-a',{
    //可以看到，我们把在`component-a`组件里使用了关键字`components`注册了一个局部组件`component-b`并且嵌入了`component-a`的模板语法中。
    template:'<div><p>这里是全局组件</p><component-b></component-b></div>',
    //使用components在父组件中注册局部组件
    components:{
        'component-b': {
            template:'<button>这是一个局部组件</button>'
        },
    }
})
```

### 3 注意问题------------单个根元素

注意上面局部组件的那个例子，全局组件`component-a`的模板字符串是被一个`div`标签完全包裹起来的，是因为VUE规定==**每个组件必须只有一个根元素**==，所以不管你的组件由多少子元素组成，最外层都只有有且只有一个元素。

### 4 合理组织代码结构

同样是局部组件的那个例子，如果向下面这样写会不会更清楚明白一些：

```js
/将每个组件的代码赋值给了不同的变量，这样如果某个组件有变化，只用修改相应的变量，而不需要修改所有引用此变量的方法，实现了松耦合的编程思想。

//定义component-b组件变量
component-b = {
    template: '<button>这是组件B</button>'
}
//定义component-a组间变量，并引用component-a变量
component-a = {
    template : '<div><p>这是组件A</p><component-b></component-b></div>'
    components: {
        'component-b':component-b
    }
}
//在Vue实例中注册component-a局部组件
//虽然component-a实在Vue实例中注册，但是如果此Vue实例
//是整个程序的跟实例，那也component-a也相当于进行了全局注册
new Vue({
     el: '#components-demo',
     components: {
         'component-b': component-a
     }
})
```

### 5 特殊元素特殊对待

```js
//有些 HTML 元素，诸如 <ul>、<ol>、<table> 和 <select>，对于哪些元素可以出现在其内部是有严格限制的。而有些元素，诸如 <li>、<tr> 和 <option>，只能出现在其它某些特定的元素内部。
```

这会导致我们使用这些有约束条件的元素时遇到一些问题。例如：

```js
<table>
  <blog-post-row></blog-post-row>
  <!--table元素中只允许包含<th>,<tr>等元素-->
</table>
//这个自定义组件 `<blog-post-row>` 会被作为无效的内容提升到外部，并导致最终渲染结果出错。幸好这个特殊的 is 特性给了我们一个变通的办法：
```

```html
<table>
  <tr is="blog-post-row"></tr>
</table>
//这样``这个自定义组件就会正常渲染。
```

==如果你使用单文件组件的话(就是`.vue`后缀的文件)，这一条可以忽略==

1. Node.js与NPM，现代前端开发必需品
2. Webpack， 前端代码打包工具
3. vue-router，单文件前端程序必需品

