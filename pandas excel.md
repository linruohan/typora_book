# pandas excel

[toc]



## 新建文件

```python
import pandas as pd

df = pd.DataFrame({'ID':[1,2,3],'Name':['Tim','Victor','Nick']})
df = df.set_index('ID')
df.to_excel('001.xlsx')
print('done!')

```

![image-20210404215726961](imgs/image-20210404215726961.png)

### pandas写excel

![image-20210405093636045](imgs/image-20210405093636045.png)

![image-20210405093721875](imgs/image-20210405093721875.png)

指定index的name

![image-20210405093838483](imgs/image-20210405093838483.png)

### ExcelWriter写excel

![image-20210405094150179](imgs/image-20210405094150179.png)

![image-20210405094340291](imgs/image-20210405094340291.png)

## 打开文件

![image-20210404215955970](imgs/image-20210404215955970.png)

### index索引

![image-20210405094448256](imgs/image-20210405094448256.png)

![image-20210405094541248](imgs/image-20210405094541248.png)

![image-20210405094624136](imgs/image-20210405094624136.png)<img src="imgs/image-20210405094646251.png" alt="image-20210405094646251" />

![image-20210405094654960](imgs/image-20210405094654960.png)

![image-20210405094752065](imgs/image-20210405094752065.png)

![image-20210405094837901](imgs/image-20210405094837901.png)



### 获取表格基本信息

![image-20210405095312266](imgs/image-20210405095312266.png)

![image-20210404215922840](imgs/image-20210404215922840.png)

![image-20210404215933759](imgs/image-20210404215933759.png)
### 指定特定行为表头header=row_index

![image-20210404220131134](imgs/image-20210404220131134.png)

### 没有表头:header=None

```python
df=pd.read_excel('001.xlsx',header=None)
print(df.columns)
# Int64Index([0,1,2,3,4,5], dtyp'int64)
```
### 自定义表头

```python
df.columns=['ID','type','title']
df.set_index('ID',inplace=True) # 重新设置行索引
df.to_excel('001.xlsx')
```

设置为index后,该列就不会出现再columns中,两者是分开的

![image-20210404220956291](imgs/image-20210404220956291.png)

### 指定index_col

指定后,重新保存将不会默认设置index

![image-20210404221207422](imgs/image-20210404221207422.png)

### read_excel其他参数

1. index_col

![image-20210405093022242](imgs/image-20210405093022242.png)

2. 单列转换为series

![image-20210405093038430](imgs/image-20210405093038430.png)

3. 处理重复列名

![image-20210405093117602](imgs/image-20210405093117602.png)

4. 处理的行数

![image-20210405093250945](imgs/image-20210405093250945.png)

5. 千分位分隔符

![image-20210405093331011](imgs/image-20210405093331011.png)

6. 浮点

![image-20210405093436006](imgs/image-20210405093436006.png)

## 行\列\单元格

### 创建series

![image-20210404221623625](imgs/image-20210404221623625.png)

![image-20210404221629529](imgs/image-20210404221629529.png)

### series加入datafreame(按照列方式加入)

![image-20210404221857013](imgs/image-20210404221857013.png)

![image-20210404221903187](imgs/image-20210404221903187.png)

### series加入datafreame(按照行方式加入)

```python
df=pd.DataFrae([s1,s2,s3])
```

![image-20210404222403130](imgs/image-20210404222403130.png)![image-20210404222409662](imgs/image-20210404222409662.png)

### 非对齐series

![image-20210404222156361](imgs/image-20210404222156361.png)

![image-20210404222208216](imgs/image-20210404222208216.png)

## 数据区域的读取,填充文字数字

<img src="imgs/image-20210404222618107.png" alt="image-20210404222618107" style="zoom:50%;" />

```python
import pandas as pd
from datetime import date,timedelta

def add_month(d,md):
    yd=md//12
    m=d.month+md%12
    if m!=12:
        yd+=m//12
        m=m%12
    return date(d.year+yd,m,d.day)

books=pd.read_excel('001.xlsx',skiprows=3,usecols='C:F',index_col=None,dtype={'ID':str,'InStore':str,'Date':str})

start=date(2018,1,1)
for i in books.index:
    books['ID'].at[i]=i+1   
    books['InStore'].at[i]='Yes' if i%2==0 else 'No'
    books['Date'].at[i]=start+timedelta(days=1) #天数加1
	# books['Date'].at[i]=date(start.year+i,start.month,start,day) # year=1
    # books['Date'].at[i]=add_month(start,i) # month=1 
```

![image-20210404224714223](imgs/image-20210404224714223.png)

books[‘ID’].at[i]

books.at[i,’ID’]   

![image-20210404224807952](imgs/image-20210404224807952.png)

## 函数填充

给一列值加2

1. 只修改特定行的值

![image-20210404225144402](imgs/image-20210404225144402.png)

2. 修改所有行的值
![image-20210404225054615](imgs/image-20210404225054615.png)
3. 使用函数修改值
4. ![image-20210404225338440](imgs/image-20210404225338440.png)
5. ![image-20210404225004080](imgs/image-20210404225004080.png)

![image-20210404225017360](imgs/image-20210404225017360.png)

## 排序

![image-20210404225431867](imgs/image-20210404225431867.png)

1. 逆序排列

![image-20210404225524999](imgs/image-20210404225524999.png)

![image-20210404225536355](imgs/image-20210404225536355.png)

### 多列排序

从左到右,先按照worthy从小到大顺序排,再按照price从大到小排

![image-20210404225745166](imgs/image-20210404225745166.png)

![image-20210404225752342](imgs/image-20210404225752342.png)

## 数据筛选和过滤

![image-20210404230044316](imgs/image-20210404230044316.png)

![image-20210404230050557](imgs/image-20210404230050557.png)

1. 字典

![image-20210405095555968](imgs/image-20210405095555968.png)

2. 切片

![image-20210405095810147](imgs/image-20210405095810147.png)

![image-20210405100055953](imgs/image-20210405100055953.png)

3. 点选

<img src="imgs/image-20210405100206785.png" alt="image-20210405100206785" style="zoom:50%;" />

### loc

![image-20210405100552712](imgs/image-20210405100552712.png)

![image-20210405100648516](imgs/image-20210405100648516.png)

链式调用

![image-20210405101017117](imgs/image-20210405101017117.png)

### iloc

![image-20210405101129250](imgs/image-20210405101129250.png)

![image-20210405101545112](imgs/image-20210405101545112.png)

![image-20210405101625807](imgs/image-20210405101625807.png)

### 赋值

![image-20210405101720346](imgs/image-20210405101720346.png)

### 加减乘除

![image-20210405101815913](imgs/image-20210405101815913.png)

不显示无穷大inf

![image-20210405102003676](imgs/image-20210405102003676.png)

index不对齐:

![image-20210405102421224](imgs/image-20210405102421224.png)

![image-20210405102444184](imgs/image-20210405102444184.png)

![image-20210405102706461](imgs/image-20210405102706461.png)

### mutiindex(header=[0,1])

![image-20210405102935965](imgs/image-20210405102935965.png)

![image-20210405103200605](imgs/image-20210405103200605.png)

![image-20210405103239597](imgs/image-20210405103239597.png)

### 字符串处理函数

![image-20210405103600270](imgs/image-20210405103600270.png)

<img src="imgs/image-20210405104043202.png" alt="image-20210405104043202" style="zoom:50%;" />

![image-20210405104118825](imgs/image-20210405104118825.png)

## pd.str方法

![image-20210405111408564](imgs/image-20210405111408564.png)

![image-20210405111607420](imgs/image-20210405111607420.png)

## 柱状图

### 一般柱状图

![image-20210404230605853](imgs/image-20210404230605853.png)

![image-20210404230620696](imgs/image-20210404230620696.png)

![image-20210404230655145](imgs/image-20210404230655145.png)

![image-20210404230857603](imgs/image-20210404230857603.png)

![image-20210404230913293](imgs/image-20210404230913293.png)

### 分组柱图,优化

![image-20210404231752047](imgs/image-20210404231752047.png)

![image-20210404232020339](imgs/image-20210404232020339.png)

### 叠加柱状图,水平柱状图

![image-20210404232519713](imgs/image-20210404232519713.png)

![image-20210404232534504](imgs/image-20210404232534504.png)

### 饼图

![image-20210404232659218](imgs/image-20210404232659218.png)

<img src="imgs/image-20210404233040298.png" alt="image-20210404233040298" style="zoom:50%;" />

![image-20210404233322798](imgs/image-20210404233322798.png)

## 折线趋势图,叠加区域图

![image-20210404233651809](imgs/image-20210404233651809.png)

<img src="imgs/image-20210404234155610.png" alt="image-20210404234155610" />

<img src="imgs/image-20210404234225795.png" alt="image-20210404234225795" style="zoom:50%;" />

![image-20210404234254323](imgs/image-20210404234254323.png)

![image-20210404234318217](imgs/image-20210404234318217.png)

## 散点图,直方图,密度图

![image-20210404234442160](imgs/image-20210404234442160.png)

### 散点图scatter

![image-20210404234838477](imgs/image-20210404234838477.png)

![image-20210404234857528](imgs/image-20210404234857528.png)

### 直方图hist

![image-20210404235104906](imgs/image-20210404235104906.png)

![image-20210404235121468](imgs/image-20210404235121468.png)

### 密度图kde

![image-20210404235309289](imgs/image-20210404235309289.png)

### 数据相关性corr

![image-20210404235439346](imgs/image-20210404235439346.png)

## 多表联合

![image-20210404235659534](imgs/image-20210404235659534.png)

![image-20210404235638839](imgs/image-20210404235638839.png)

##3 join

![image-20210404235815038](imgs/image-20210404235815038.png)

## 数据校验

![image-20210405000002218](imgs/image-20210405000002218.png)

1. assert普通校验

![image-20210405000316666](imgs/image-20210405000316666.png)

![image-20210405000410701](imgs/image-20210405000410701.png)

![image-20210405000329314](imgs/image-20210405000329314.png)

## 把一列数据分成两列

![image-20210405000822263](imgs/image-20210405000822263.png)

![image-20210405000722667](imgs/image-20210405000722667.png)

![image-20210405000545062](imgs/image-20210405000545062.png)

![image-20210405000845756](imgs/image-20210405000845756.png)

## 求和,求平均,统计导引

![image-20210405001420254](imgs/image-20210405001420254.png)

![image-20210405001431208](imgs/image-20210405001431208.png)

![image-20210405001520842](imgs/image-20210405001520842.png)

## 清楚重复数据

![image-20210405001559362](imgs/image-20210405001559362.png)

1. 删除重复列

![image-20210405001736536](imgs/image-20210405001736536.png)

2. 打印重复列

![image-20210405002029921](imgs/image-20210405002029921.png)

## 行列互相转换

![image-20210405002138769](imgs/image-20210405002138769.png)![image-20210405002212446](imgs/image-20210405002212446.png)

![image-20210405002331044](imgs/image-20210405002331044.png)

![image-20210405002338725](imgs/image-20210405002338725.png)

## 读取csv/tsv/txt文件数据

![image-20210405002626805](imgs/image-20210405002626805.png)

<img src="imgs/image-20210405002428299.png" alt="image-20210405002428299" style="zoom:50%;" /><img src="imgs/image-20210405002517265.png" alt="image-20210405002517265" style="zoom:50%;" /><img src="imgs/image-20210405002606851.png" alt="image-20210405002606851" style="zoom:50%;" />

![image-20210405002818178](imgs/image-20210405002818178.png)

## 透视表,分组,聚合

### 透视表

![image-20210405003115999](imgs/image-20210405003115999.png)

![image-20210405003045538](imgs/image-20210405003045538.png)

![image-20210405003057870](imgs/image-20210405003057870.png)

![image-20210405003405171](imgs/image-20210405003405171.png)

![image-20210405003411043](imgs/image-20210405003411043.png)

计算各个配件的每年的销售额和销售数量

![image-20210405003553067](imgs/image-20210405003553067.png)

![image-20210405003730658](imgs/image-20210405003730658.png)

## 线性回归,数据预测

![image-20210405004414606](imgs/image-20210405004414606.png)

![image-20210405004515851](imgs/image-20210405004515851.png)

![image-20210405004549721](imgs/image-20210405004549721.png)

## 条件格式jupyter

![image-20210405004800283](imgs/image-20210405004800283.png)

![image-20210405005156576](imgs/image-20210405005156576.png)

![image-20210405005309543](imgs/image-20210405005309543.png)

1. 颜色深浅
2. ![image-20210405005503872](imgs/image-20210405005503872.png)

![image-20210405005237034](imgs/image-20210405005237034.png)

2. 进度条

![image-20210405005337068](imgs/image-20210405005337068.png)

![image-20210405005528393](imgs/image-20210405005528393.png)

## 行操作

![image-20210405010150181](imgs/image-20210405010150181.png)

从中间插入一行

![image-20210405010323552](imgs/image-20210405010323552.png)

删除一行

![image-20210405010450006](imgs/image-20210405010450006.png)

![image-20210405010458899](imgs/image-20210405010458899.png)

按条件删除行

![image-20210405010630531](imgs/image-20210405010630531.png)

## 列操作

![image-20210405010837222](imgs/image-20210405010837222.png)

![image-20210405010852729](imgs/image-20210405010852729.png)

![image-20210405011408375](imgs/image-20210405011408375.png)

## 读取数据库

![image-20210405012044970](imgs/image-20210405012044970.png)

## 复杂方程

![image-20210405012408736](imgs/image-20210405012408736.png)

![image-20210405012314248](imgs/image-20210405012314248.png)

## 数据处理转换converters

![image-20210405092355135](imgs/image-20210405092355135.png)

## true false valuses(只对字符串有效)

<img src="imgs/image-20210405092720136.png" alt="image-20210405092720136" style="zoom:67%;" />![image-20210405092826905](imgs/image-20210405092826905.png)

## dtype转换

![image-20210405111959569](imgs/image-20210405111959569.png)

![image-20210405112048127](imgs/image-20210405112048127.png)