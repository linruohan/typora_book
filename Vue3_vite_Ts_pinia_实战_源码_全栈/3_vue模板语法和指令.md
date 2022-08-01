# 模板语法和指令

[toc]



## 模板[插值](https://so.csdn.net/so/search?q=插值&spm=1001.2101.3001.7020)语法

在script 声明一个变量可以直接在template 使用用法为{{变量名称}}

```xml
<template>
  <div>{{ message }}</div>
</template>
 
<script setup lang="ts">
const message = "我是小满"
</script>
  <style>
</style>
```

模板语法是可以编写条件运算的

```xml
<template>
  <div>{{ message == 0 ? '我是小满0' : '我不是小满other' }}</div>
</template>
 
 
<script setup lang="ts">
const message:number = 1
</script>
 
 
 
<style>
</style>
```

运算也是支持的

```xml
<template>
  <div>{{ message  + 1 }}</div>
</template>
 
 
<script setup lang="ts">
const message:number = 1
</script>
 
 
 
<style>
</style>
```

操作API 也是支持的

```xml
<template>
  <div>{{ message.split('，') }}</div>
</template>
 
 
<script setup lang="ts">
const message:string = "我，是，小，满"
</script>
 
 
 
<style>
</style>
```

## 指令

v- 开头都是vue 的指令

v-text 用来显示文本

v-html 用来展示富文本

v-if 用来控制元素的显示隐藏（切换真假DOM）

v-else-if 表示 `v-if` 的“else if 块”。可以链式调用

v-else v-if条件收尾语句

v-show 用来控制元素的显示隐藏（display none block Css切换）

v-on 简写@ 用来给元素添加事件

v-bind 简写: 用来绑定元素的属性Attr

v-model 双向绑定

v-for 用来遍历元素

v-on修饰符 冒泡案例

```xml
<template>
  <div @click="parent">
    <div @click.stop="child">child</div>
  </div>
</template>
 
 
<script setup lang="ts">
const child = () => {
  console.log('child');
 
}
const parent = () => {
  console.log('parent');
}
 
</script>
```

阻止表单提交案例

```xml
<template>
  <form action="/">
    <button @click.prevent="submit" type="submit">submit</button>
  </form>
</template>
 <script setup lang="ts">
const submit = () => {
  console.log('child');
 }
 </script>
 <style>
</style>
```

v-bind 绑定class 案例 1

```xml
<template>
  <div :class="[flag ? 'active' : 'other', 'h']">12323</div>
</template>
 <script setup lang="ts">
const flag: boolean = false;
</script>
 <style>
.active {
  color: red;
}
.other {
  color: blue;
}
.h {
  height: 300px;
  border: 1px solid #ccc;
}
</style>
```

v-bind 绑定class 案例 2

```xml
<template>
  <div :class="flag">{{flag}}</div>
</template>
 
 
<script setup lang="ts">
type Cls = {
  other: boolean,
  h: boolean
}
const flag: Cls = {
  other: false,
  h: true
};
</script>
 
 <style>
.active {
  color: red;
}
.other {
  color: blue;
}
.h {
  height: 300px;
  border: 1px solid #ccc;
}
</style>
```

v-bind 绑定style案例

```xml
<template>
  <div :style="style">2222</div>
</template>
 <script setup lang="ts">
 type Style = {
  height: string,
  color: string
}
 
const style: Style = {
  height: "300px",
  color: "blue"
}
 </script>
 <style>
</style>
```

 

v-model 案例

```xml
<template>
  <input v-model="message" type="text" />
  <div>{{ message }}</div>
</template>
 <script setup lang="ts">
import { ref } from 'vue'
const message = ref("v-model")
</script>
 <style>
.active {
  color: red;
}
.other {
  color: blue;
}
.h {
  height: 300px;
  border: 1px solid #ccc;
}
</style>
```

# 学习Vue3 第五章（Vue核心虚拟Dom和 diff 算法）

为什么要学习[源码](https://so.csdn.net/so/search?q=源码&spm=1001.2101.3001.7020)

1.可以提升自己学习更优秀的[API](https://so.csdn.net/so/search?q=API&spm=1001.2101.3001.7020)设计和代码逻辑

2.面试的时候也会经常问源码相关的东西

3.更快的掌握vue和遇到问题可以定位

## 介绍虚拟DOM

虚拟DOM就是通过JS来生成一个AST节点树

![img](https://img-blog.csdnimg.cn/b3fde3141a0740568fdc42c5eb3b23c5.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)

[Vue Template Explorer](https://vue-next-template-explorer.netlify.app/#eyJzcmMiOiI8ZGl2PlxyXG4gICAgPGRpdj4gXHJcbiAgICAgICAgIDxzZWN0aW9uPnRlc3Q8L3NlY3Rpb24+XHJcbiAgICAgIDwvZGl2PiAgXHJcbjwvZGl2PiIsIm9wdGlvbnMiOnt9fQ==)

### 为什么要有虚拟DOM？

我们可以通过下面的例子

```javascript
let div = document.createElement('div')
let str = ''
for (const key in div) {
  str += key + ''
}
console.log(str)
```

发现一个dom上面的属性是非常多的

```undefined
aligntitlelangtranslatedirhiddenaccessKeydraggablespellcheckautocapitalizecontentEditableisContentEditableinputModeoffsetParentoffsetTopoffsetLeftoffsetWidthoffsetHeightstyleinnerTextouterTextonbeforexrselectonabortonbluroncanceloncanplayoncanplaythroughonchangeonclickoncloseoncontextmenuoncuechangeondblclickondragondragendondragenterondragleaveondragoverondragstartondropondurationchangeonemptiedonendedonerroronfocusonformdataoninputoninvalidonkeydownonkeypressonkeyuponloadonloadeddataonloadedmetadataonloadstartonmousedownonmouseenteronmouseleaveonmousemoveonmouseoutonmouseoveronmouseuponmousewheelonpauseonplayonplayingonprogressonratechangeonresetonresizeonscrollonsecuritypolicyviolationonseekedonseekingonselectonslotchangeonstalledonsubmitonsuspendontimeupdateontoggleonvolumechangeonwaitingonwebkitanimationendonwebkitanimationiterationonwebkitanimationstartonwebkittransitionendonwheelonauxclickongotpointercaptureonlostpointercaptureonpointerdownonpointermoveonpointeruponpointercancelonpointeroveronpointeroutonpointerenteronpointerleaveonselectstartonselectionchangeonanimationendonanimationiterationonanimationstartontransitionrunontransitionstartontransitionendontransitioncanceloncopyoncutonpastedatasetnonceautofocustabIndexattachInternalsblurclickfocusenterKeyHintvirtualKeyboardPolicyonpointerrawupdatenamespaceURIprefixlocalNametagNameidclassNameclassListslotattributesshadowRootpartassignedSlotinnerHTMLouterHTMLscrollTopscrollLeftscrollWidthscrollHeightclientTopclientLeftclientWidthclientHeightattributeStyleMaponbeforecopyonbeforecutonbeforepasteonsearchelementTimingonfullscreenchangeonfullscreenerroronwebkitfullscreenchangeonwebkitfullscreenerrorchildrenfirstElementChildlastElementChildchildElementCountpreviousElementSiblingnextElementSiblingafteranimateappendattachShadowbeforeclosestcomputedStyleMapgetAttributegetAttributeNSgetAttributeNamesgetAttributeNodegetAttributeNodeNSgetBoundingClientRectgetClientRectsgetElementsByClassNamegetElementsByTagNamegetElementsByTagNameNSgetInnerHTMLhasAttributehasAttributeNShasAttributeshasPointerCaptureinsertAdjacentElementinsertAdjacentHTMLinsertAdjacentTextmatchesprependquerySelectorquerySelectorAllreleasePointerCaptureremoveremoveAttributeremoveAttributeNSremoveAttributeNodereplaceChildrenreplaceWithrequestFullscreenrequestPointerLockscrollscrollByscrollIntoViewscrollIntoViewIfNeededscrollTosetAttributesetAttributeNSsetAttributeNodesetAttributeNodeNSsetPointerCapturetoggleAttributewebkitMatchesSelectorwebkitRequestFullScreenwebkitRequestFullscreenariaAtomicariaAutoCompleteariaBusyariaCheckedariaColCountariaColIndexariaColSpanariaCurrentariaDescriptionariaDisabledariaExpandedariaHasPopupariaHiddenariaKeyShortcutsariaLabelariaLevelariaLiveariaModalariaMultiLineariaMultiSelectableariaOrientationariaPlaceholderariaPosInSetariaPressedariaReadOnlyariaRelevantariaRequiredariaRoleDescriptionariaRowCountariaRowIndexariaRowSpanariaSelectedariaSetSizeariaSortariaValueMaxariaValueMinariaValueNowariaValueTextgetAnimationsnodeTypenodeNamebaseURIisConnectedownerDocumentparentNodeparentElementchildNodesfirstChildlastChildpreviousSiblingnextSiblingnodeValuetextContentELEMENT_NODEATTRIBUTE_NODETEXT_NODECDATA_SECTION_NODEENTITY_REFERENCE_NODEENTITY_NODEPROCESSING_INSTRUCTION_NODECOMMENT_NODEDOCUMENT_NODEDOCUMENT_TYPE_NODEDOCUMENT_FRAGMENT_NODENOTATION_NODEDOCUMENT_POSITION_DISCONNECTEDDOCUMENT_POSITION_PRECEDINGDOCUMENT_POSITION_FOLLOWINGDOCUMENT_POSITION_CONTAINSDOCUMENT_POSITION_CONTAINED_BYDOCUMENT_POSITION_IMPLEMENTATION_SPECIFICappendChildcloneNodecompareDocumentPositioncontainsgetRootNodehasChildNodesinsertBeforeisDefaultNamespaceisEqualNodeisSameNodelookupNamespaceURIlookupPrefixnormalizeremoveChildreplaceChildaddEventListenerdispatchEventremoveEventListener
```

所以直接操作DOM非常浪费性能

解决方案就是 我们可以用`JS`的计算性能来换取操作`DOM`所消耗的性能，既然我们逃不掉操作`DOM`这道坎,但是我们可以尽可能少的操作`DOM`

```
操作JS是非常快的
```

## 介绍Diff算法

Vue3 源码地址[ https://github.com/vuejs/core](https://github.com/vuejs/core)

详细解说可以观看视频讲解 [小满zs的个人空间_哔哩哔哩_Bilibili](https://space.bilibili.com/99210573?spm_id_from=333.1007.0.0)

```xml
<template>
  <div>
    <div :key="item" v-for="(item) in Arr">{{ item }}</div>
  </div>
</template>
 
<script setup lang="ts">
const Arr: Array<string> = ['A', 'B', 'C', 'D']
Arr.splice(2,0,'DDD')
</script>
<style>
</style>
```

![img](https://img-blog.csdnimg.cn/16158a3afbfb4558b094dd4203aab442.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)

splice 用法 太贴心了 ![img](https://img-blog.csdnimg.cn/cc4039e8dadd4cbc8011ea4467776a50.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA5bCP5ruhenM=,size_20,color_FFFFFF,t_70,g_se,x_16)