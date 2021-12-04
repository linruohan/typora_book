## html 锚点三种实现方法
1 通过id
```js
<a href="#m1"> 通过id获取锚点</a>
<div style="width:100%;height:1000px"></div>
<div style=" height:100px; width:100%; background: red; id="m1"> 通过id获取锚点</div>
```
2 通过 name    name只能适用于a标签
```js
<a href="#m2"> 通过name获取锚点</a>
<div style="width:100%;height:1000px"></div>
<a style=" display:block;height:200px; width:100%;background: blue; " name="m2"> 通过name获取锚点</a>
```
3 通过js

```js
<a href="#" onclick="javascript:document.getElementById('m3').scrollIntoView();"> 通过js获取锚点</a>
<div style=" height:200px; width:100%; background:green" id="m3"> 通过js获取锚点</div>
```