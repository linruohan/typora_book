![image-20200424234503449](D:\Typora_pic\image-20200424234503449.png)

```shell
pip install pymysql
pip install SQLAlchemy
```

![image-20200424234632035](D:\Typora_pic\image-20200424234632035.png)

![image-20200424235503954](D:\Typora_pic\image-20200424235503954.png)

![image-20200425072220278](D:\Typora_pic\image-20200425072220278.png)

### ORM 对象关系映射 Object relationship mapping

![image-20200425072642700](D:\Typora_pic\image-20200425072642700.png)

![image-20200425072802929](D:\Typora_pic\image-20200425072802929.png)

### ORM 绑定到数据库

![image-20200425073601703](D:\Typora_pic\image-20200425073601703.png)

![image-20200425073747635](D:\Typora_pic\image-20200425073747635.png)

![image-20200425073914769](D:\Typora_pic\image-20200425073914769.png)

![image-20200425073959623](D:\Typora_pic\image-20200425073959623.png)

### SQLAlchemy类型

![image-20200425074212924](D:\Typora_pic\image-20200425074212924.png)

![image-20200425074219491](D:\Typora_pic\image-20200425074219491.png)

![image-20200425074854120](D:\Typora_pic\image-20200425074854120.png)

==decimal:总长度10,小数位4==  存储金额的时候专门使用的,为精度专门定义的一种类型

![image-20200425075016818](D:\Typora_pic\image-20200425075016818.png)

![image-20200425075415494](D:\Typora_pic\image-20200425075415494.png)

![image-20200425075546546](D:\Typora_pic\image-20200425075546546.png)

![image-20200425075713911](D:\Typora_pic\image-20200425075713911.png)

![image-20200425075702210](D:\Typora_pic\image-20200425075702210.png)

![image-20200425075816885](D:\Typora_pic\image-20200425075816885.png)

![image-20200425075912181](D:\Typora_pic\image-20200425075912181.png)

![image-20200425075919954](D:\Typora_pic\image-20200425075919954.png)

![image-20200425075956450](D:\Typora_pic\image-20200425075956450.png)

### column 常用参数

![image-20200425080812418](D:\Typora_pic\image-20200425080812418.png)

![image-20200425080627928](D:\Typora_pic\image-20200425080627928.png)

### query

![image-20200425080838085](D:\Typora_pic\image-20200425080838085.png)

![image-20200425092702513](D:\Typora_pic\image-20200425092702513.png)

### filter

![image-20200425092746640](D:\Typora_pic\image-20200425092746640.png)

![image-20200425092807765](D:\Typora_pic\image-20200425092807765.png)

![image-20200425093526564](D:\Typora_pic\image-20200425093526564.png)

### 外键和四种约束

![image-20200425093653681](D:\Typora_pic\image-20200425093653681.png)

​	![image-20200425094313150](D:\Typora_pic\image-20200425094313150.png)

![image-20200425095224878](D:\Typora_pic\image-20200425095224878.png)

## 一对多关系

![image-20200425095441426](D:\Typora_pic\image-20200425095441426.png)

### 父子模型中分别定义关联

![image-20200425095817598](D:\Typora_pic\image-20200425095817598.png)

![image-20200425095640863](D:\Typora_pic\image-20200425095640863.png)

![image-20200425095830116](D:\Typora_pic\image-20200425095830116.png)

### 只在子模型中定义关联

![image-20200425100004709](D:\Typora_pic\image-20200425100004709.png)

## 一对一关系

==提交父表,添加子表==

![image-20200425100335621](D:\Typora_pic\image-20200425100335621.png)

==提交子表,添加父表==

![image-20200425100432809](D:\Typora_pic\image-20200425100432809.png)

### 一对一

![image-20200425101127893](D:\Typora_pic\image-20200425101127893.png)

![image-20200425101237558](D:\Typora_pic\image-20200425101237558.png)

![image-20200425101321895](D:\Typora_pic\image-20200425101321895.png)

==只在子表中添加一对一关联==

![image-20200425101355215](D:\Typora_pic\image-20200425101355215.png)

## 多对多关系

![image-20200425102327782](D:\Typora_pic\image-20200425102327782.png)

![image-20200425102403604](D:\Typora_pic\image-20200425102403604.png)

![image-20200425102642626](D:\Typora_pic\image-20200425102642626.png)

## cascade

![image-20200425103334061](D:\Typora_pic\image-20200425103334061.png)

![image-20200425103453448](D:\Typora_pic\image-20200425103453448.png)

![image-20200425103829410](D:\Typora_pic\image-20200425103829410.png)

![image-20200425104118933](D:\Typora_pic\image-20200425104118933.png)

![image-20200425104204782](D:\Typora_pic\image-20200425104204782.png)

![image-20200425104643862](D:\Typora_pic\image-20200425104643862.png)

![image-20200425105214102](D:\Typora_pic\image-20200425105214102.png)

## 排序

![image-20200425105344917](D:\Typora_pic\image-20200425105344917.png)

![image-20200425105518324](D:\Typora_pic\image-20200425105518324.png)

## 切片

![image-20200425110027314](D:\Typora_pic\image-20200425110027314.png)

![image-20200425105956064](D:\Typora_pic\image-20200425105956064.png)

limit :找多少条

![image-20200425110104922](D:\Typora_pic\image-20200425110104922.png)

offset 偏移

![image-20200425110214899](D:\Typora_pic\image-20200425110214899.png)

slice  倒数10个

![image-20200425110325313](D:\Typora_pic\image-20200425110325313.png)

![image-20200425110348718](D:\Typora_pic\image-20200425110348718.png)

## 数据查询懒加载

![image-20200425111050027](D:\Typora_pic\image-20200425111050027.png)

![image-20200425111235974](D:\Typora_pic\image-20200425111235974.png)

![image-20200425111133354](D:\Typora_pic\image-20200425111133354.png)

![image-20200425111430528](D:\Typora_pic\image-20200425111430528.png)

## 高级查询

![image-20200425111537174](D:\Typora_pic\image-20200425111537174.png)

![image-20200425111912028](D:\Typora_pic\image-20200425111912028.png)

![image-20200425111929525](D:\Typora_pic\image-20200425111929525.png)

![image-20200425111943351](D:\Typora_pic\image-20200425111943351.png)

![image-20200425112252545](D:\Typora_pic\image-20200425112252545.png)

![image-20200425112529699](D:\Typora_pic\image-20200425112529699.png)

### 联合查询

![image-20200425112924642](D:\Typora_pic\image-20200425112924642.png)