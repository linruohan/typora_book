## doT.js详细使用介绍

插件描述：doT模板方便快捷的组织页面DOM
压缩版仅4K大小，最近使用点的时候整理出这个dot.js教程api文档，是对dot.js的介绍和实例，希望能帮助到一部分需要的人。

doT.js详细使用介绍
```javascript
{{= }} for interpolation
{{ }} for evaluation
{{~ }} for array iteration
{{? }} for conditionals
{{! }} for interpolation with encoding
{{# }} for compile-time evaluation/includes and partials
{{## #}} for compile-time defines
//调用方式：
var tmpText = doT.template(模板);
tmpText(数据源);
```
### 例子一：1，用于插值赋值
```js
//格式：
{{= }}
//数据源：
{"name":"Jake","age":31}
//区域：
<div id="interpolation"></div>
//模板：
<script id="interpolationtmpl" type="text/x-dot-template">
    <div>Hi {{=it.name}}!</div>
    <div>{{=it.age || ''}}</div>
</script>
//调用方式：
var dataInter = {"name":"Jake","age":31};
var interText = doT.template($("#interpolationtmpl").text());
$("#interpolation").html(interText(dataInter));
```
### 例子二：2，用于循环中的评估
```js
//格式：
{{ for var key in data { }} 
{{= key }} 
{{ } }}
//数据源：
{"name":"Jake","age":31,"interests":["basketball","hockey","photography"],"contact":{"email":"jake@xyz.com","phone":"999999999"}}
//区域：
<div id="evaluation"></div>
//模板：
<script id="evaluationtmpl" type="text/x-dot-template">
    {{ for(var prop in it) { }}
        <div>KEY:{{= prop }}---VALUE:{{= it[prop] }}</div>
    {{ } }}
</script>
//调用方式：
var dataEval = {"name":"Jake","age":31,"interests":["basketball","hockey","photography"],"contact":{"email":"jake@xyz.com","phone":"999999999"}};
var evalText = doT.template($("#evaluationtmpl").text());
$("#evaluation").html(evalText(dataEval));
```
### 例子三：3，用于数组迭代
```js
//格式：
{{~data.array :value:index }}
    ...
{{~}}
//数据源：
{"array":["banana","apple","orange"]}
//区域：
<div id="arrays"></div>
//模板：
<script id="arraystmpl" type="text/x-dot-template">
    {{~it.array:value:index}}
        <div>{{= index+1 }}{{= value }}!</div>
    {{~}}
</script>
//调用方式：
var dataArr = {"array":["banana","apple","orange"]};
var arrText = doT.template($("#arraystmpl").text());
$("#arrays").html(arrText(dataArr));
```
### 例子四：4，{{？}}用于条件
```js
//格式：
{{? }} if
{{?? }} else if
{{??}} else
//数据源：
{"name":"Jake","age":31}
//区域：
<div id="condition"></div>
//模板：
<script id="conditionstmpl" type="text/x-dot-template">
    {{? !it.name }}
    <div>Oh, I love your name, {{=it.name}}!</div>
    {{?? !it.age === 0}}
    <div>Guess nobody named you yet!</div>
    {{??}}
    You are {{=it.age}} and still dont have a name?
    {{?}}
</script>
//调用方式：
var dataEncode = {"uri":"http://jq22.com/?keywords=Yoga","html":"<div style='background: #f00; height: 30px; line-height: 30px;'>html元素</div>"};
var EncodeText = doT.template($("#encodetmpl").text());
$("#encode").html(EncodeText(dataEncode));
```
### 例子五：5，内插编码
```js
//数据源：
{"uri":"http://jq22.com/?keywords=Yoga"}
//格式：
{{!it.uri}}
//区域：
<div id="encode"></div>
//模板：
<script id="encodetmpl" type="text/x-dot-template">
    Visit {{!it.uri}} {{!it.html}}
</script>
//调用方式：
var dataEncode = {"uri":"http://jq22.com/?keywords=Yoga","html":"<div style='background: #f00; height: 30px; line-height: 30px;'>html元素</div>"};
var EncodeText = doT.template($("#encodetmpl").text());
$("#encode").html(EncodeText(dataEncode));
```
### 例子六：6，{{##}}用于编译时评估/包含和部分
```js
//用于编译时定义
{{##＃}}
//数据源：
{"name":"Jake","age":31}
//区域：
<div id="part"></div>
//模板：
<script id="parttmpl" type="text/x-dot-template">
    {{##def.snippet:
    <div>{{=it.name}}</div>{{#def.joke}}
    #}}
    {{#def.snippet}}
    {{=it.html}}
</script>
//调用方式：
var dataPart = {"name":"Jake","age":31,"html":"<div style='background: #f00; height: 30px; line-height: 30px;'>html元素</div>"};
var defPart = {"joke":"<div>{{=it.name}} who?</div>"};
var partText = doT.template($("#parttmpl").text(), undefined, defPart);
$("#part").html(partText(dataPart));
```
