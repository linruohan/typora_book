# unity3D UI插件–NGUI

[toc]

## 1 NGUI

![image-20210509103742602](imgs/image-20210509103742602.png)

![image-20210509103807970](imgs/image-20210509103807970.png)

![image-20210509103830809](imgs/image-20210509103830809.png)

![image-20210509104000473](imgs/image-20210509104000473.png)

## 2 UI Root/UI Panel/UI Camera组件

![image-20210509104349642](imgs/image-20210509104349642.png)

单独创建Sprite控件,NGUI会自动创建UI Root/UI Panel/UI Camera三个组件

![image-20210509104554106](imgs/image-20210509104554106.png)

![image-20210509104638749](imgs/image-20210509104638749.png)

![image-20210509104656734](imgs/image-20210509104656734.png)

### 2.1 UI Root

![image-20210509104808711](imgs/image-20210509104808711.png)

#### 2.1.1 flexible灵活的

![image-20210509105130087](imgs/image-20210509105130087.png)

#### 2.1.2 constrained 约束的

![image-20210509105335731](imgs/image-20210509105335731.png)

### 2.2 UI Panel

是一个容器,只有这个子对象才可以显示

![image-20210509105629295](imgs/image-20210509105629295.png)

## 3 UI Camera

![image-20210509110449371](imgs/image-20210509110449371.png)

![image-20210509111321854](imgs/image-20210509111321854.png)

![image-20210509111713552](imgs/image-20210509111713552.png)

是否响应对应的事件

![image-20210509111735248](imgs/image-20210509111735248.png)

响应鼠标事件允许鼠标按下和抬起坐标的误差范围

![image-20210509112009033](imgs/image-20210509112009033.png)

### 3.1 UI Camera的原理

UI Camera是通过触摸/鼠标移动的位置的地方发射射线(就是Unity的Raycast)然后获取射线撞击的碰撞体(collider)信息,然后发射消息(通过Unity的SendMessage函数)给该碰撞体关联的GameObject的所有脚本

### 3.2 UI Camera中响应的事件

![image-20210509112501119](imgs/image-20210509112501119.png)

### 3.3 UI Camera常用相关变量

UICamera.currentTouchID: 用于区分鼠标按下的键位,-1是左键,-2是右键,-3为中键

UICamera.lastHit:RaycastHit类型,用于获取被触发的物体

UICamera.lastTouchPosition:用于获取鼠标和触摸的位置

## 4 Atlas Maker

NGUI区别于UGUI,NGUI在使用2D图片是采用图集的形式,因此,在使用NGUI之前,我们需要学会如何使用图集制作器制作图集

### 4.1 制作图集

![image-20210509113058754](imgs/image-20210509113058754.png)

![image-20210509113215847](imgs/image-20210509113215847.png)

### 4.2 替换图集

![image-20210509113354367](imgs/image-20210509113354367.png)

![image-20210509113445894](imgs/image-20210509113445894.png)

tooltip 提示信息

![image-20210509111554982](imgs/image-20210509111554982.png)



## 5 NGUI控件

### 5.1 Sprite 精灵(图片)

![image-20210509113919522](imgs/image-20210509113919522.png)

![image-20210509114020900](imgs/image-20210509114020900.png)

### 5.2 Label -文本

![image-20210509114847711](imgs/image-20210509114847711.png)

#### 5.2.1 Font Maker字体集创建

有Unity和NGUI字体集两种选择,unity支持中文,NGUI只支持英文

![image-20210509115235061](imgs/image-20210509115235061.png)

![image-20210509115041498](imgs/image-20210509115041498.png)

![image-20210509115127411](imgs/image-20210509115127411.png)

![image-20210509115210019](imgs/image-20210509115210019.png)

==BBCode==

![image-20210509115901642](imgs/image-20210509115901642.png)

==锚点==

![image-20210509120223781](imgs/image-20210509120223781.png)

### 5.3 Tooltip

![image-20210509111618324](imgs/image-20210509111618324.png)

#### 5.3.1 创建tooltip

1. 创建GameObject

UI Root-> new GameObject->rename Gameobject为tooltip

2. 给tooltip添加sprite背景,并选择背景图片,修改尺寸,位置置0

![image-20210509121428194](imgs/image-20210509121428194.png)

3. 创建label,调整尺寸,

![image-20210509121751200](imgs/image-20210509121751200.png)

#### 5.3.2 tooltip添加组件UI Tooltip(脚本组件),绑定各对象

![image-20210509121230817](imgs/image-20210509121230817.png)

![image-20210509121203231](imgs/image-20210509121203231.png)

#### 5.3.3 使用tooltip

选择一个控件,响应tooltip事件

给控件添加COllider碰撞体组件

![image-20210509122135501](imgs/image-20210509122135501.png)

创建一个脚本,绑定到控件上

![image-20210509122326899](imgs/image-20210509122326899.png)

![image-20210509122541620](imgs/image-20210509122541620.png)

修改tooltip的depth显示层级,让tooltip在最顶层显示![image-20210509122641622](imgs/image-20210509122641622.png)

修改pivot中心点,使tooltip在鼠标的右下角显示

![image-20210509123246711](imgs/image-20210509123246711.png)

![image-20210509123341140](imgs/image-20210509123341140.png)

左上角显示

![image-20210509123502841](imgs/image-20210509123502841.png)

![image-20210509123422742](imgs/image-20210509123422742.png)

### 5.4 Texture 纹理

![image-20210509123618891](imgs/image-20210509123618891.png)

![image-20210509123912764](imgs/image-20210509123912764.png)

### 5.5 Input Field 输入框

![image-20210509124033411](imgs/image-20210509124033411.png)

#### 5.5.1 创建Input Field组件

1. GameObject + label

2. GameObj 添加sprite作为背景:设置图集

![image-20210509124300330](imgs/image-20210509124300330.png)

![image-20210509124803571](imgs/image-20210509124803571.png)

3. GameObj添加Input Field组件:

挂载input label

![image-20210509125205914](imgs/image-20210509125205914.png)

4. GameObj添加Collider组件:
5. 挂载自定义脚本(测试Saved As)

![image-20210509130351169](imgs/image-20210509130351169.png)

![image-20210509125725506](imgs/image-20210509125725506.png)

![image-20210509130048375](imgs/image-20210509130048375.png)

On Change绑定InputField

![image-20210509130250356](imgs/image-20210509130250356.png)

### 5.6 Button 按钮

![image-20210509130513291](imgs/image-20210509130513291.png)

![image-20210509130529997](imgs/image-20210509130529997.png)

![image-20210509130724633](imgs/image-20210509130724633-1620536846957.png)

添加label,显示文字,添加自定义脚本

![image-20210509131004143](imgs/image-20210509131004143.png)

![image-20210509131044830](imgs/image-20210509131044830.png)

onclick绑定函数

![image-20210509131131748](imgs/image-20210509131131748.png)

![image-20210509131235357](imgs/image-20210509131235357.png)

添加按钮点击声音

![image-20210509131318190](imgs/image-20210509131318190.png)

![image-20210509131341581](imgs/image-20210509131341581-1620537223674.png)

### 5.7 Check Box(Toggle)

![image-20210509131415826](imgs/image-20210509131415826.png)

1. 添加invisible widget

![image-20210509131650975](imgs/image-20210509131650975.png)

![image-20210509131717145](imgs/image-20210509131717145.png)

2. 添加Toggle 并attach Collider

![image-20210509131758100](imgs/image-20210509131758100.png)

![image-20210509131939348](imgs/image-20210509131939348.png)可以设置为none

group同一组中只能选中一个

3. onvaluechange添加脚本

![image-20210509132119027](imgs/image-20210509132119027.png)

### 5.8 Popup List 弹出框/下拉列表

![image-20210509132249891](imgs/image-20210509132249891.png)

1. GameObj添加组件: UI Sprite背景,设置图片,type切片方式,

2. GameObj添加组件: UI Popup List:核心组件

![image-20210509133014144](imgs/image-20210509133014144.png)

绑定onvaluechange

![image-20210509133108909](imgs/image-20210509133108909.png)

![image-20210509133121891](imgs/image-20210509133121891.png)

![image-20210509133254524](imgs/image-20210509133254524.png)

使用脚本初始化option

![image-20210509133518172](imgs/image-20210509133518172.png)

![image-20210509133738077](imgs/image-20210509133738077.png)

3. add添加label
4. attach Collider碰撞体检测

### 5.9 Slider 滑杆

![](imgs/image-20210509133815565.png)

#### 5.9.1 创建Slider

1. GameObject==Slider
   1. NGUI Slider,调整depth

![image-20210509134227273](imgs/image-20210509134227273.png)

​		2. attach collider

1. sprite==Foreground_sprite
2. sprite==Background_sprite
3. sprite==Thumb

4. 自定义脚本

![image-20210509134509915](imgs/image-20210509134509915.png)

![image-20210509134554219](imgs/image-20210509134554219.png)

5. 绑定到on valuechange

![image-20210509134718206](imgs/image-20210509134718206.png)

### 5.10 Scroll Bar 滚动条

![image-20210509134832779](imgs/image-20210509134832779.png)

#### 5.10.1 创建ScrollBar

1. GameObject==Scrollbar
   1. NGUI ScrollBar
   
      ![image-20210509135211818](imgs/image-20210509135211818-1620539533909.png)
   
      
   
2. sprite==Foreground_sprite

![image-20210509135705228](imgs/image-20210509135705228.png)

1. sprite==Background_sprite
2. sprite==Thumb(显示进度百分比)
   1. label(10%)
3. 自定义脚本

![image-20210509140250618](imgs/image-20210509140250618.png)

![image-20210509140301999](imgs/image-20210509140301999.png)

### 5.11 Scroll View 滚动视图

![image-20210509141538778](imgs/image-20210509141538778.png)

![image-20210509140553698](imgs/image-20210509140553698.png)

![image-20210509141026107](imgs/image-20210509141026107.png)

![image-20210509141124515](imgs/image-20210509141124515.png)

设置grid:行和列

![image-20210509141205325](imgs/image-20210509141205325.png)

添加拖拽视图

![image-20210509141309004](imgs/image-20210509141309004.png)

