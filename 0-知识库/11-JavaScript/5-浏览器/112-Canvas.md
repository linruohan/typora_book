#### Canvas

阅读: 2314426

------

Canvas是HTML5新增的组件，它就像一块幕布，可以用JavaScript在上面绘制各种图表、动画等。

没有Canvas的年代，绘图只能借助Flash插件实现，页面不得不用JavaScript和Flash进行交互。有了Canvas，我们就再也不需要Flash了，直接使用JavaScript完成绘制。

一个Canvas定义了一个指定尺寸的矩形框，在这个范围内我们可以随意绘制：

```
<canvas id="test-canvas" width="300" height="200"></canvas>
```

由于浏览器对HTML5标准支持不一致，所以，通常在``内部添加一些说明性HTML代码，如果浏览器支持Canvas，它将忽略``内部的HTML，如果浏览器不支持Canvas，它将显示``内部的HTML：

```
<canvas id="test-stock" width="300" height="200">
    <p>Current Price: 25.51</p>
</canvas>
```

在使用Canvas前，用`canvas.getContext`来测试浏览器是否支持Canvas：

```
<!-- HTML代码 -->
<canvas id="test-canvas" width="200" heigth="100">
    <p>你的浏览器不支持Canvas</p>
</canvas>
```

`'use strict'; ` Run

`getContext('2d')`方法让我们拿到一个`CanvasRenderingContext2D`对象，所有的绘图操作都需要通过这个对象完成。

```
var ctx = canvas.getContext('2d');
```

如果需要绘制3D怎么办？HTML5还有一个WebGL规范，允许在Canvas中绘制3D图形：

```
gl = canvas.getContext("webgl");
```

本节我们只专注于绘制2D图形。

### 绘制形状

我们可以在Canvas上绘制各种形状。在绘制前，我们需要先了解一下Canvas的坐标系统：

![canvas-xy](D:\Typora_pic\l-1586007959225.png)

Canvas的坐标以左上角为原点，水平向右为X轴，垂直向下为Y轴，以像素为单位，所以每个点都是非负整数。

`CanvasRenderingContext2D`对象有若干方法来绘制图形：

`'use strict'; var    canvas = document.getElementById('test-shape-canvas'),    ctx = canvas.getContext('2d'); ` Run

### 绘制文本

绘制文本就是在指定的位置输出文本，可以设置文本的字体、样式、阴影等，与CSS完全一致：

`'use strict'; var    canvas = document.getElementById('test-text-canvas'),    ctx = canvas.getContext('2d'); ` Run

Canvas除了能绘制基本的形状和文本，还可以实现动画、缩放、各种滤镜和像素转换等高级操作。如果要实现非常复杂的操作，考虑以下优化方案：

- 通过创建一个不可见的Canvas来绘图，然后将最终绘制结果复制到页面的可见Canvas中；
- 尽量使用整数坐标而不是浮点数；
- 可以创建多个重叠的Canvas绘制不同的层，而不是在一个Canvas中绘制非常复杂的图；
- 背景图片如果不变可以直接用``标签并放到最底层。

### 练习

请根据从163获取的JSON数据绘制最近30个交易日的K线图，数据已处理为包含一组对象的数组：

`'use strict'; window.loadStockData = function (r) {    var        NUMS = 30,        data = r.data;    if (data.length > NUMS) {        data = data.slice(data.length - NUMS);    }    data = data.map(function (x) {        return {            date: x[0],            open: x[1],            close: x[2],            high: x[3],            low: x[4],            vol: x[5],            change: x[6]        };    });    window.drawStock(data); } window.drawStock = function (data) { ``}; // 加载最近30个交易日的K线图数据: var js = document.createElement('script'); js.src = 'http://img1.money.126.net/data/hs/kline/day/history/2015/0000001.json?callback=loadStockData&t=' + Date.now(); document.getElementsByTagName('head')[0].appendChild(js); ` Run



[下载为图片](https://www.liaoxuefeng.com/wiki/1022910821149312/1023022423592576#0)