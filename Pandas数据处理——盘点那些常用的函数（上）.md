# Pandas数据处理——盘点那些常用的函数（上）

[![易执](https://pic3.zhimg.com/v2-24bad255e3601df6932f7dd263c0b4e0_xs.jpg)](https://www.zhihu.com/people/weng-hai-yi-90)

[易执](https://www.zhihu.com/people/weng-hai-yi-90)

53 人赞同了该文章

发布于 2020-02-13，编辑于 2020-05-21

在之前的文章中，以图文的方式详细讲解了Pandas中`groupby`，`merge`以及`map`、`apply`、`applymap`的原理，掌握好这些原理，再在这个基础上进行一些拓展，基本就可以解决绝大部分比较复杂的数据处理操作了。几篇文章如下，想回看的小伙伴可以再重温一下：

1. [Pandas数据处理三板斧——map、apply、applymap详解](https://zhuanlan.zhihu.com/p/100064394)
2. [Pandas数据分析——超好用的Groupby详解](https://zhuanlan.zhihu.com/p/101284491)
3. [Pandas数据分析——Merge数据拼接图文详解](https://zhuanlan.zhihu.com/p/102274476)
4. [提速百倍的Pandas性能优化方法，让你的Pandas飞起来！](https://zhuanlan.zhihu.com/p/97012199)

这篇文章为大家整理一下实际使用中比较高频的一些用法，当然还会有一篇关于时间序列处理的文章。在这里需要强调一点就是，**不建议初学者上来就把Pandas中所有的方法都啃一遍，这样效率太低而且很多方法平时基本用不到，啃下来也容易忘。正确的方式是先把常用的方法先吃透，然后找个项目直接上手，遇到现有方法处理不了的再查看官方文档。**

通过”人工智能“的方式，我从官方文档中筛选出一些比较常用的方法，有二十多个，初学者可以先试着把这些吃透了。为了避免过多看不下去，这篇文章就先介绍10个。

用于演示的数据如下：

```python
In [15]: data
Out[15]:
  company  salary  age
0     NaN      43   21
1       A       8   41
2       A      28   26
3       C      42   28
4       A      33   26
5       C      20   18
6       A      48   43
7       B      25   23
8       B      39   18
```

**.head()**

作用对象：`Series`和`DataFrame`

主要用途：返回`DataFrame`的前N行。当数据量较大时，使用`.head()`可以快速对数据有个大致了解。

用法：

```python
#默认返回前5行，N可以自行设定
In [16]: data.head()
Out[16]:
  company  salary  age
0     NaN      43   21
1       A       8   41
2       A      28   26
3       C      42   28
4       A      33   26
```

## **.info()**

作用对象：`Series`和`DataFrame`

主要用途：打印所用数据的一些基本信息，包括索引和列的数据类型和占用的内存大小。

用法：

```python
In [17]: data.info()
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 9 entries, 0 to 8
Data columns (total 3 columns):
company    8 non-null object
salary     9 non-null int32
age        9 non-null int32
dtypes: int32(2), object(1)
memory usage: 224.0+ bytes
```

## **.describe()**

作用对象：`Series`和`DataFrame`

主要用途：生成描述性统计汇总，包括数据的计数和百分位数，有助于了解大致的数据分布

用法：

```python
# 默认生成数值列的描述性统计
# 使用 include = 'all'生成所有列
In [18]: data.describe()
Out[18]:
          salary        age
count   9.000000   9.000000
mean   31.777778  27.111111
std    12.804079   9.143911
min     8.000000  18.000000
25%    25.000000  21.000000
50%    33.000000  26.000000
75%    42.000000  28.000000
max    48.000000  43.000000
```

## **.value_counts()**

作用对象：`Series`

主要用途：统计分类变量中每个类的数量，比如`company`中各个公司都有多少人

主要参数：

- normalize （*boolean, default False*）
  返回各类的占比
- sort （*boolean, default True*）
  是否对统计结果进行排序
- ascending （*boolean, default False*）
  是否升序排列

用法：

```python
In [19]: data['company'].value_counts()
Out[19]:
A    4
B    2
C    2
Name: company, dtype: int64
        
# 返回占比情况
In [20]: data['company'].value_counts(normalize=True)
Out[20]:
A    0.50
B    0.25
C    0.25
Name: company, dtype: float64

# 升序排列
In [21]: data['company'].value_counts(ascending=True)
Out[21]:
C    2
B    2
A    4
Name: company, dtype: int64
```

## **.isna()**

作用对象：`Series`和`DataFrame`

主要用途：判断数据是否为缺失值，是的话返回`True`，否的话返回`False`

用法：

```python
In [22]: data.isna()
Out[22]:
   company  salary    age
0     True   False  False
1    False   False  False
2    False   False  False
3    False   False  False
4    False   False  False
5    False   False  False
6    False   False  False
7    False   False  False
8    False   False  False
```

## **.any()**

作用对象：`Series`和`DataFrame`

主要用途：大多数情况下数据量较大，不可能直接`isna()`后一个一个看是否是缺失值。`any()`和`isna()`结合使用可以判断某一列是否有缺失值。

用法：

```python
In [23]: data.isna().any()
Out[23]:
company     True
salary     False
age        False
dtype: bool
```

## **.dropna()**

作用对象：`Series`和`DataFrame`

主要用途：删掉含有缺失值的数据

用法：

```python
In [24]: data.dropna()
Out[24]:
  company  salary  age
1       A       8   41
2       A      28   26
3       C      42   28
4       A      33   26
5       C      20   18
6       A      48   43
7       B      25   23
8       B      39   18
```

## **.fillna()**

作用对象：`Series`和`DataFrame`

主要用途：填充缺失数据

主要参数：

- value （*scalar, dict, Series, or DataFrame*）
  用于填充缺失值的值
- method （*{‘backfill’, ‘bfill’, ‘pad’, ‘ffill’, None}, default None*）
  缺失值的填充方式，常用的是`bfill`后面的值进行填充，`ffill`用前面的值进行填充
- inplace （*boolean, default False*）
  是否作用于原对象

用法：

```python
In [26]: data.fillna('B')
Out[26]:
  company  salary  age
0       B      43   21
1       A       8   41
2       A      28   26
3       C      42   28
4       A      33   26
5       C      20   18
6       A      48   43
7       B      25   23
8       B      39   18

# 用缺失值后面的值来填充（这里NaN后面是'A'）
In [25]: data.fillna(method='bfill')
Out[25]:
  company  salary  age
0       A      43   21
1       A       8   41
2       A      28   26
3       C      42   28
4       A      33   26
5       C      20   18
6       A      48   43
7       B      25   23
8       B      39   18
```

## **.sort_index()**

作用对象：`Series`和`DataFrame`

主要用途：对数据按照索引进行排序

主要参数：

- ascending （*boolean, default True*）
  是否升序排列
- inplace （*boolean, default False*）
  是否作用于原对象

用法：

```python
# 按索引降序排列
In [27]: data.sort_index(ascending=False)
Out[27]:
  company  salary  age
8       B      39   18
7       B      25   23
6       A      48   43
5       C      20   18
4       A      33   26
3       C      42   28
2       A      28   26
1       A       8   41
0     NaN      43   21
```

## **.sort_values()**

作用对象：`Series`和`DataFrame`

主要用途：对`DataFrame`而言，按照某列进行排序（用`by`参数控制），对`Series`按数据列进行排序。

主要参数：

- by （*str or list of str*）
  作用于`DataFrame`时需要指定排序的列
- ascending （*boolean, default False*）
  是否升序排列

```python
In [28]: data.sort_values(by='salary')
Out[28]:
  company  salary  age
1       A       8   41
5       C      20   18
7       B      25   23
2       A      28   26
4       A      33   26
8       B      39   18
3       C      42   28
0     NaN      43   21
6       A      48   43
```



**相关文章：**

1. [Pandas数据处理三板斧——map、apply、applymap详解](https://zhuanlan.zhihu.com/p/100064394)
2. [Pandas数据分析——超好用的Groupby详解](https://zhuanlan.zhihu.com/p/101284491)
3. [Pandas数据处理——玩转时间序列数据](https://zhuanlan.zhihu.com/p/106675563)
4. [Pandas数据分析——Merge数据拼接图文详解](https://zhuanlan.zhihu.com/p/102274476)
5. [Pandas数据处理——盘点那些常用的函数（下）](https://zhuanlan.zhihu.com/p/106724730)
6. [天秀！Pandas还能用来写爬虫？](https://zhuanlan.zhihu.com/p/122361747)
7. [提高数据的颜值！一起看看Pandas中的那些Style](https://zhuanlan.zhihu.com/p/126223075)
8. [提速百倍的Pandas性能优化方法，让你的Pandas飞起来！](https://zhuanlan.zhihu.com/p/97012199)

这篇文章整理了剩下的一些Pandas常见方法，整体难度会比上一篇文章中的大一点，但还是比较容易理解的。话不多说，直接进入正题。

用于演示的数据如下：

```python
In [11]: data
Out[11]:
  company  gender  salary   age
0       B  female      30  40.0
1       A  female      36  31.0
2       B  female      35  28.0
3       B  female       9  18.0
4       B  female      16  43.0
5       A    male      46  22.0
6       B  female      15  28.0
7       B  female      33  40.0
8       C    male      19  32.0
```

## **.astype()**

作用对象：`Series`和`DataFrame`

主要用途：修改字段的数据类型，数据量大的情况下可用于**减小数据占用的内存**，多用于`Series`。

用法：

```python
# 把age字段转为int类型
In [12]: data["age"] = data["age"].astype(int)

In [13]: data
Out[13]:
  company  gender  salary  age
0       B  female      30   40
1       A  female      36   31
2       B  female      35   28
3       B  female       9   18
4       B  female      16   43
5       A    male      46   22
6       B  female      15   28
7       B  female      33   40
8       C    male      19   32
```

## **.rename()**

作用对象：`Series`,`DataFrame`(大多数情况下)

主要用途：多用于修改`DataFrame`的列名

主要参数：

- columns （*dict-like or function*）
  指定要修改的列名以及新的列名，一般以字典形式传入
- inplace （*boolean, default False*）
  是否作用于原对象

用法：

```python
# 将'age'更改为员工编号'number',并作用于原对象
In [15]: data.rename(columns={'age':'number'},inplace=True)

In [16]: data
Out[16]:
  company  gender  salary  number
0       B  female      30      40
1       A  female      36      31
2       B  female      35      28
3       B  female       9      18
4       B  female      16      43
5       A    male      46      22
6       B  female      15      28
7       B  female      33      40
8       C    male      19      32
```

## **.set_index()**

作用对象：`DataFrame`

主要用途：将`DataFrame`中的某一（多）个字段设置为索引

用法：

```python
In [19]: data.set_index('number',inplace=True)

In [20]: data
Out[20]:
       company  gender  salary
number
40           B  female      30
31           A  female      36
28           B  female      35
18           B  female       9
43           B  female      16
22           A    male      46
28           B  female      15
40           B  female      33
32           C    male      19
```

## **.reset_index()**

作用对象：`Series`,`DataFrame`

主要用途：重置索引，默认重置后的索引为`0~len(df)-1`

主要参数：

- drop （*boolean, default False*）
  是否丢弃原索引，具体看下方演示
- inplace （*boolean, default False*）
  是否作用于原对象

用法：

```python
# drop = True，重置索引，并把原有的索引丢弃
In [22]: data.reset_index(drop=True)
Out[22]:
  company  gender  salary
0       B  female      30
1       A  female      36
2       B  female      35
3       B  female       9
4       B  female      16
5       A    male      46
6       B  female      15
7       B  female      33
8       C    male      19

# drop = False,重置索引
# 原索引列'number'作为新字段进入DataFrame
In [23]: data.reset_index(drop=False,inplace=True)

In [24]: data
Out[24]:
   number company  gender  salary
0      40       B  female      30
1      31       A  female      36
2      28       B  female      35
3      18       B  female       9
4      43       B  female      16
5      22       A    male      46
6      28       B  female      15
7      40       B  female      33
8      32       C    male      19
```

## **.drop_duplicates()**

作用对象：`Series`,`DataFrame`

主要用途：去掉重复值，作用和`SQL`中的`distinct`类似

用法：

```python
In [26]: data['company'].drop_duplicates()
Out[26]:
0    B
1    A
8    C
Name: company, dtype: object
```

## **.drop()**

作用对象：`Series`,`DataFrame`

主要用途：常用于删掉`DataFrame`中的某些字段

主要参数：

- columns （*single label or list-like*）
  指定要删掉的字段

用法：

```python
# 删掉'gender'列
In [27]: data.drop(columns = ['gender'])
Out[27]:
   number company  salary
0      40       B      30
1      31       A      36
2      28       B      35
3      18       B       9
4      43       B      16
5      22       A      46
6      28       B      15
7      40       B      33
8      32       C      19
```

## **.isin()**

作用对象：`Series`,`DataFrame`

主要用途：常用于构建布尔索引，对`DataFrame`的数据进行条件筛选

用法：

```python
# 筛选出A公司和C公司的员工记录
In [29]: data.loc[data['company'].isin(['A','C'])]
Out[29]:
   number company  gender  salary
1      31       A  female      36
5      22       A    male      46
8      32       C    male      19
```

## **pd.cut()**

主要用途：将连续变量离散化，比如将人的年龄划分为各个区间

主要参数：

- x （*array-like*）
  需要进行离散化的一维数据
- bins （*int, sequence of scalars, or IntervalIndex*）
  设置需要分成的区间，可以指定**区间数量**，也可以指定**间断点**
- labels （*array or bool, optional*）
  设置区间的标签

用法：

```python
# 把薪水分成5个区间
In [33]: pd.cut(data.salary,bins = 5)
Out[33]:
0     (23.8, 31.2]
1     (31.2, 38.6]
2     (31.2, 38.6]
3    (8.963, 16.4]
4    (8.963, 16.4]
5     (38.6, 46.0]
6    (8.963, 16.4]
7     (31.2, 38.6]
8     (16.4, 23.8]
Name: salary, dtype: category
Categories (5, interval[float64]): [(8.963, 16.4] < (16.4, 23.8] < (23.8, 31.2] < (31.2, 38.6] <(38.6, 46.0]]
                                     
# 自行指定间断点
In [32]: pd.cut(data.salary,bins = [0,10,20,30,40,50])
Out[32]:
0    (20, 30]
1    (30, 40]
2    (30, 40]
3     (0, 10]
4    (10, 20]
5    (40, 50]
6    (10, 20]
7    (30, 40]
8    (10, 20]
Name: salary, dtype: category
Categories (5, interval[int64]): [(0, 10] < (10, 20] < (20, 30] < (30, 40] < (40, 50]]

# 指定区间的标签                                                                             
In [34]: pd.cut(data.salary,bins = [0,10,20,30,40,50],labels = ['低','中下','中','中上','高'])
Out[34]:
0     中
1    中上
2    中上
3     低
4    中下
5     高
6    中下
7    中上
8    中下
Name: salary, dtype: category
Categories (5, object): [低 < 中下 < 中 < 中上 < 高]
```

## **pd.qcut()**

主要用途：将连续变量离散化，区别于`pd.cut()`用具体数值划分，`pd.qcut()`使用**分位数**进行区间划分

主要参数：

- x （*array-like*）
  需要进行离散化的一维数据
- q（*integer or array of quantiles*）
  设置需要分成的区间，可以指定**区间格式**，也可以指定**间断点**
- labels （*array or boolean, default None*）
  设置区间的标签

用法：

```python
# 按照0-33.33%，33.33%-66.67%，66.67%-100%百分位进行划分
In [35]: pd.qcut(data.salary,q = 3)
Out[35]:
0    (18.0, 33.667]
1    (33.667, 46.0]
2    (33.667, 46.0]
3     (8.999, 18.0]
4     (8.999, 18.0]
5    (33.667, 46.0]
6     (8.999, 18.0]
7    (18.0, 33.667]
8    (18.0, 33.667]
Name: salary, dtype: category
Categories (3, interval[float64]): [(8.999, 18.0] < (18.0, 33.667] < (33.667, 46.0]]
```

## **.where()**

作用对象：`Series`,`DataFrame`

主要用途：将不符合条件的值替换掉成指定值，相当于执行了一个`if-else`

主要参数：

- cond （*boolean Series/DataFrame, array-like, or callable*）
  用于筛选的条件
- other（*scalar, Series/DataFrame, or callable*）
  对不符合`cond`条件的值（结果为为`False`），用`other`的值进行替代

用法：

```python
# 语句解析
# 若salary<=40，则保持原来的值不变
# 若salary大于40，则设置为40
In [38]: data['salary'].where(data.salary<=40,40)
Out[38]:
0    30
1    36
2    35
3     9
4    16
5    40
6    15
7    33
8    19
Name: salary, dtype: int32
```

## **pd.concat()**

主要用途：将多个`Series`或`DataFrame`拼起来（横拼或者竖拼都可以）

主要参数：

- objs （*a sequence or mapping of Series or DataFrame objects*）
  用于拼接的`Series`或`DataFrame`，一般都放在一个列表中传入
- axis （*0/’index’, 1/’columns’*）
  控制数据是横向拼接还是纵向拼接，默认为纵向拼接。
- ignore_index （*bool, default False*）
  是否保留原`Seires`或`DataFrame`内部的索引，如果为`True`则对拼接而成的数据生成新索引（0~n-1）

用法：

```python
# 分别取data的前三条和后三条为data1和data2
In [41]: data1 = data.head(3)
In [42]: data1
Out[42]:
   number company  gender  salary
0      40       B  female      30
1      31       A  female      36
2      28       B  female      35

In [43]: data2 = data.tail(3)
In [44]: data2
Out[44]:
   number company  gender  salary
6      28       B  female      15
7      40       B  female      33
8      32       C    male      19

# 拼接数据
In [45]: pd.concat([data1,data2],ignore_index = False)
Out[45]:
   number company  gender  salary
0      40       B  female      30
1      31       A  female      36
2      28       B  female      35
6      28       B  female      15
7      40       B  female      33
8      32       C    male      19

# 拼接数据并重置索引
In [46]: pd.concat([data1,data2],ignore_index=True)
Out[46]:
   number company  gender  salary
0      40       B  female      30
1      31       A  female      36
2      28       B  female      35
3      28       B  female      15
4      40       B  female      33
5      32       C    male      19
```

## **.pivot_table()**

作用对象：`DataFrame`

主要用途：对`DataFrame`进行数据透视，相当于Excel中的数据透视表

主要参数：

- values （*column to aggregate, optional*）
  用于聚合运算的字段（数据透视的目标变量）
- index （*column, Grouper, array, or list of the previous*）
  类比于数据透视表中的**行标签**
- columns （*column, Grouper, array, or list of the previous*）
  类比于数据透视表中的**列标签**
- aggfunc （ *function, list of functions, dict, default numpy.mean*）
  对values进行什么聚合运算

用法：

```python
# 从公司和性别两个维度对薪水进行数据透视
# 看看这两个维度下的平均薪资水平
In [47]: data.pivot_table(values = 'salary',index = 'company',
                          columns = 'gender',aggfunc=np.mean)
Out[47]:
gender   female  male
company
A          36.0  46.0
B          23.0   NaN
C           NaN  19.0
```

Pandas中常用的函数便整理到这里，至于`map`和`apply`这类的就不在此过多介绍了，详细的介绍可以看之前写过的文章。希望整理的这些函数能对大家有所帮助！

**相关文章：**

1. [Pandas数据处理三板斧——map、apply、applymap详解](https://zhuanlan.zhihu.com/p/100064394)
2. [Pandas数据分析——超好用的Groupby详解](https://zhuanlan.zhihu.com/p/101284491)
3. [Pandas数据处理——玩转时间序列数据](https://zhuanlan.zhihu.com/p/106675563)
4. [Pandas数据分析——Merge数据拼接图文详解](https://zhuanlan.zhihu.com/p/102274476)
5. [Pandas数据处理——盘点那些常用的函数（上）](https://zhuanlan.zhihu.com/p/106722583)
6. [天秀！Pandas还能用来写爬虫？](https://zhuanlan.zhihu.com/p/122361747)
7. [提高数据的颜值！一起看看Pandas中的那些Style](https://zhuanlan.zhihu.com/p/126223075)
8. [提速百倍的Pandas性能优化方法，让你的Pandas飞起来！](https://zhuanlan.zhihu.com/p/97012199)

## [Pandas]Dataframe中切片常用技巧
1、根据值在是否在列表中进行切片：
### 方法一：使用isin方法可以根据DataFrame中的某列的值是否在某个列表中来进行切片（注意：这里不要直接使用in,否则会报错），代码如下：

```python
pf = pd.DataFrame([['74-27-EA-4D-93-BD','act_click','click_news',3],['E0-3F-49-79-C8-97','act_biz','click_hb.seb',199],
                   ['E0-3F-49-79-C8-97', 'msg_view', '1', 4],
                   ['E0-3F-49-79-C8-97', 'msg_view', '2', 36],
                   ['E0-3F-49-79-C8-97', 'msg_view', '3', 2],
                   ['40-8D-5C-98-35-70', 'act_biz', 'click_hb.wet', 7],
                   ['74-27-EA-4D-93-BD', 'act_biz', 'click_hb.wet', 5]],
                  columns=['MAC','ACT','ACT_POINT','CLICKS'])
print(pf)
lt = ['click_news','click_hb.seb','click_hb.wet']
print(pf.loc[pf['ACT_POINT'].isin(lt)])
print(pf[pf['ACT_POINT'].isin(lt)])
```

```python

                 MAC        ACT     ACT_POINT  CLICKS
0  74-27-EA-4D-93-BD  act_click    click_news       3
1  E0-3F-49-79-C8-97    act_biz  click_hb.seb     199
5  40-8D-5C-98-35-70    act_biz  click_hb.wet       7
6  74-27-EA-4D-93-BD    act_biz  click_hb.wet       5
                 MAC        ACT     ACT_POINT  CLICKS
0  74-27-EA-4D-93-BD  act_click    click_news       3
1  E0-3F-49-79-C8-97    act_biz  click_hb.seb     199
5  40-8D-5C-98-35-70    act_biz  click_hb.wet       7
6  74-27-EA-4D-93-BD    act_biz  click_hb.wet       5
```
### 方法二：这里再讲一种方法使用列的str计算来返回，这种方法可以在更大广阔的地方使用，例如可以实现类似SQL方法中的like方法。

主旨，是使用str.extract()方法来判断，由于`extract可以使用正则表达式`，所以使用起来比较方便。
具体str.extract方法的讲解，可以参见官方原文，讲解得比较好：http://pandas.pydata.org/pandas-docs/stable/user_guide/text.html

str.extract方法主要有两个参数：
第一个参数是正则表达式，也就需要匹配的子字符串；
第二个参数表示是否需要返回匹配的值。

首先看一下str.extract()方法的执行效果：
```python
	In:
	print(pf['ACT_POINT'].str.extract('(click_news|click_hb.seb|click_hb.wet)', expand=False))
   Out:
    0      click_news
    1    click_hb.seb
    2             NaN
    3             NaN
    4             NaN
    5    click_hb.wet
    6    click_hb.wet
    Name: ACT_POINT, dtype: object
```
从上面的实践可以看出，只需要把非空的值取出来，主可以达到我们上面isin方法的相同的效果。所以接下来的代码也是水到渠成了：
`
print(pf[pf['ACT_POINT'].str.extract('(click_news|click_hb.seb|click_hb.wet)', expand=False).notnull()])`