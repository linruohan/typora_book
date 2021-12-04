## 总流程

![image-20200711071216416](D:\Typora_pic\image-20200711071216416.png)

### 索引

![image-20200711071244016](D:\Typora_pic\image-20200711071244016.png)

### 上下拼接多个表格

<img src="D:\Typora_pic\image-20200711071412589.png" alt="image-20200711071412589" />

![image-20200711071618257](D:\Typora_pic\image-20200711071618257.png)

### 左右拼接

<img src="D:\Typora_pic\image-20200711071527385.png" alt="image-20200711071527385" style="zoom:50%;" />

<img src="D:\Typora_pic\image-20200711071542559.png" alt="image-20200711071542559" style="zoom:50%;" />

### 上下和左右拼接多个表格

![image-20200711071700454](D:\Typora_pic\image-20200711071700454.png)

### 合并某些列相同的元素

![image-20200711071759731](D:\Typora_pic\image-20200711071759731.png)

![image-20200711071818681](D:\Typora_pic\image-20200711071818681.png)

![image-20200711071832988](D:\Typora_pic\image-20200711071832988.png)

### excel透视表操作

![image-20200711071912433](D:\Typora_pic\image-20200711071912433.png)

![image-20200711072334149](D:\Typora_pic\image-20200711072334149.png)

### 窗口操作

![image-20200711073427978](D:\Typora_pic\image-20200711073427978.png)

<img src="D:\Typora_pic\image-20200711073539160.png" alt="image-20200711073539160" style="zoom:33%;" />

扩展窗口操作,每次步长为1,3=3 3+6=9 3+6+5=14

<img src="D:\Typora_pic\image-20200711073628704.png" alt="image-20200711073628704" style="zoom:33%;" />![image-20200711073726112](D:\Typora_pic\image-20200711073726112.png)

<img src="D:\Typora_pic\image-20200711073628704.png" alt="image-20200711073628704" style="zoom:33%;" />![image-20200711073726112](D:\Typora_pic\image-20200711073726112.png)![image-20200711073748180](D:\Typora_pic\image-20200711073748180.png)

<img src="D:\Typora_pic\image-20200711073628704.png" alt="image-20200711073628704" style="zoom:33%;" />![image-20200711073726112](D:\Typora_pic\image-20200711073726112.png)![image-20200711073748180](D:\Typora_pic\image-20200711073748180.png)

### pandas 在实际工作中的应用

<img src="D:\Typora_pic\image-20200711074032770.png" alt="image-20200711074032770" style="zoom:33%;" />

## pandas 简介

![image-20200711074751162](D:\Typora_pic\image-20200711074751162.png)

![image-20200711074842616](D:\Typora_pic\image-20200711074842616.png)

数据显示较为人性化,内存存储在连续的地址空间中

![image-20200711074914851](D:\Typora_pic\image-20200711074914851.png)

![image-20200711074935425](D:\Typora_pic\image-20200711074935425.png)

<img src="D:\Typora_pic\image-20200711075040033.png" alt="image-20200711075040033" style="zoom:33%;" />

![image-20200711075117316](D:\Typora_pic\image-20200711075117316.png)

![image-20200711075155409](D:\Typora_pic\image-20200711075155409.png)

### 搭建pycahrm和anaconda 环境

![image-20200711075957058](D:\Typora_pic\image-20200711075957058.png)

### 数据结构Series and DataFrame

![image-20200711080120071](D:\Typora_pic\image-20200711080120071.png)

![image-20200711080140780](D:\Typora_pic\image-20200711080140780.png)

### 创建Series

![image-20200711080727481](D:\Typora_pic\image-20200711080727481.png)

![image-20200711080815754](D:\Typora_pic\image-20200711080815754.png)

### 创建DataFrame

<img src="D:\Typora_pic\image-20200711080907496.png" alt="image-20200711080907496" style="zoom:33%;" />

![image-20200711081057309](D:\Typora_pic\image-20200711081057309.png)

![image-20200711081149259](D:\Typora_pic\image-20200711081149259.png)

![image-20200711081306551](D:\Typora_pic\image-20200711081306551.png)

![image-20200711081405870](D:\Typora_pic\image-20200711081405870.png)

## 读取excel

![image-20200711081507643](D:\Typora_pic\image-20200711081507643.png)

#### sheet_name

![image-20200711081614047](D:\Typora_pic\image-20200711081614047.png)

<img src="D:\Typora_pic\image-20200711081636814.png" alt="image-20200711081636814" style="zoom:33%;" />

![image-20200711081815992](D:\Typora_pic\image-20200711081815992.png)

![image-20200711081832507](D:\Typora_pic\image-20200711081832507.png)

#### header index_col

![image-20200711082013137](D:\Typora_pic\image-20200711082013137.png)

![image-20200711082246757](D:\Typora_pic\image-20200711082246757.png)

#### usercols

![image-20200711082650091](D:\Typora_pic\image-20200711082650091.png)

![image-20200711082458185](D:\Typora_pic\image-20200711082458185.png)

<img src="D:\Typora_pic\image-20200711082516075.png" alt="image-20200711082516075" style="zoom:33%;" />

![image-20200711082539922](D:\Typora_pic\image-20200711082539922.png)

只有当列名=="CCC"的列被选中

![image-20200711082604115](D:\Typora_pic\image-20200711082604115.png)

#### code show

![image-20200711082840619](D:\Typora_pic\image-20200711082840619.png)

<img src="D:\Typora_pic\image-20200711082948999.png" alt="image-20200711082948999" />

==推荐使用str_list的方式进行读取==

![image-20200711083054755](D:\Typora_pic\image-20200711083054755.png)

![image-20200711083318351](D:\Typora_pic\image-20200711083318351.png)

#### skiprows

<img src="D:\Typora_pic\image-20200711083344723.png" alt="image-20200711083344723" style="zoom:33%;" />

![image-20200711083433049](D:\Typora_pic\image-20200711083433049.png)

![image-20200711083457126](D:\Typora_pic\image-20200711083457126.png)

#### name

![image-20200711083621214](D:\Typora_pic\image-20200711083621214.png)

![image-20200711083730890](D:\Typora_pic\image-20200711083730890.png)

#### dtype

![image-20200711083833680](D:\Typora_pic\image-20200711083833680.png)

默认的类型

![image-20200711084009728](D:\Typora_pic\image-20200711084009728.png)

![image-20200711084150145](D:\Typora_pic\image-20200711084150145.png)

![image-20200711084510601](D:\Typora_pic\image-20200711084510601.png)

![image-20200711084704022](D:\Typora_pic\image-20200711084704022.png)

给出明确的数据类型,保证数据的正确性

#### 解析日期格式parse_date

<img src="D:\Typora_pic\image-20200711084906183.png" alt="image-20200711084906183" />

![image-20200711085821067](D:\Typora_pic\image-20200711085821067.png)

* parse_dates=True: 解析index

![image-20200711085052533](D:\Typora_pic\image-20200711085052533.png)

* [0,1]或['a','b']: 尝试解析指定列作为一个单独的日期列

![image-20200711085357063](D:\Typora_pic\image-20200711085357063.png)

* [[0,1,2]]: 结合多列解析为单个日期列

![image-20200711085637816](D:\Typora_pic\image-20200711085637816.png)

![image-20200711085802527](D:\Typora_pic\image-20200711085802527.png)

#### date_parser

date_parser=lambda x: pd.to_datetime(x,format="%Y年%m月%d日")

<img src="D:\Typora_pic\image-20200711085847191.png" alt="image-20200711085847191" style="zoom:33%;" />

![image-20200711090049399](D:\Typora_pic\image-20200711090049399.png)

#### na_values 缺失值NaN not a number(float)

![image-20200711090306733](D:\Typora_pic\image-20200711090306733.png)

![image-20200711090325399](D:\Typora_pic\image-20200711090325399.png)

<img src="D:\Typora_pic\image-20200711090356575.png" alt="image-20200711090356575" style="zoom:33%;" />空格不会被解析为NaN

<img src="D:\Typora_pic\image-20200711090436505.png" alt="image-20200711090436505" style="zoom:33%;" />

传入字符串

![image-20200711090638064](D:\Typora_pic\image-20200711090638064.png)

传入列表

![image-20200711090726031](D:\Typora_pic\image-20200711090726031.png)

传入字典(只替换列)

![image-20200711090806591](D:\Typora_pic\image-20200711090806591.png)

#### converters 值转换函数

<img src="D:\Typora_pic\image-20200711091005866.png" alt="image-20200711091005866" style="zoom:33%;" />

![image-20200711091156888](D:\Typora_pic\image-20200711091156888.png)

![image-20200711091219039](D:\Typora_pic\image-20200711091219039.png)

#### true_values

![image-20200711091331087](D:\Typora_pic\image-20200711091331087.png)

只有列中全部字段都转换为true或false时,该列的dtype才会转换为bool

![image-20200711091552455](D:\Typora_pic\image-20200711091552455.png)

![image-20200711091738713](D:\Typora_pic\image-20200711091738713.png)

#### 其他参数

![image-20200711091906414](D:\Typora_pic\image-20200711091906414.png)

![image-20200711091944083](D:\Typora_pic\image-20200711091944083.png)

![image-20200711092012697](D:\Typora_pic\image-20200711092012697.png)

nrows 需要解析的行数,不包括表头哪一行

![image-20200711092049608](D:\Typora_pic\image-20200711092049608.png)

![image-20200711092222843](D:\Typora_pic\image-20200711092222843.png)

![image-20200711092311083](D:\Typora_pic\image-20200711092311083.png)

## Tips :excel复制的字符串快速转换list(使用Jupyter)

![image-20200711083223842](D:\Typora_pic\image-20200711083223842.png)

## pandas写excel: to_excel()

![image-20200711092509120](D:\Typora_pic\image-20200711092509120.png)

### index

![image-20200711092645428](D:\Typora_pic\image-20200711092645428.png)

![image-20200711092930672](D:\Typora_pic\image-20200711092930672.png)

![image-20200711092936294](D:\Typora_pic\image-20200711092936294.png)

![image-20200711093111237](D:\Typora_pic\image-20200711093111237.png)

### ExcelWriter 写excel

![image-20200711093215262](D:\Typora_pic\image-20200711093215262.png)

![image-20200711093257699](D:\Typora_pic\image-20200711093257699.png)

![image-20200711093636071](D:\Typora_pic\image-20200711093636071.png)

![image-20200711093646559](D:\Typora_pic\image-20200711093646559.png)