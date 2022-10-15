# 提速百倍的Pandas性能优化方法，让你的Pandas飞起来！
Pandas是Python中用于数据处理与分析的屠龙刀，想必大家也都不陌生，但Pandas在使用上有一些技巧和需要注意的地方，尤其是对于较大的数据集而言，如果你没有适当地使用，那么可能会导致Pandas的运行速度非常慢。

对于程序猿/媛而言，时间就是生命，这篇文章给大家总结了一些pandas常见的性能优化方法，希望能对你有所帮助！

## 一、数据读取的优化

读取数据是进行数据分析前的一个必经环节，pandas中也内置了许多数据读取的函数，最常见的就是用`pd.read_csv()`函数从csv文件读取数据，那不同格式的文件读取起来有什么区别呢？哪种方式速度更快呢？我们做个实验对比一下。

这里采用的数据共59万行，分别保存为xlsx、csv、hdf以及pkl格式，每种格式进行10次读取测试，得到下面的结果。

![img](https://pic4.zhimg.com/v2-22c71d0bdf23e066a452525dc6a46193_r.jpg)

可以看到，对同一份数据，**pkl格式**的数据的读取速度最快，是读取csv格式数据的近6倍，其次是hdf格式的数据，速度最惨不忍睹的是读取xlsx格式的数据（这仅仅是一份只有15M左右大小的数据集呀）。

所以对于日常的数据集（大多为csv格式），可以先用pandas读入，然后将数据转存为pkl或者hdf格式，之后每次读取数据时候，便可以节省一些时间。代码如下：

```python3
 import pandas as pd
 #读取csv
 df = pd.read_csv('xxx.csv')
 
 #pkl格式
 df.to_pickle('xxx.pkl') #格式另存
 df = pd.read_pickle('xxx.pkl') #读取
 
 #hdf格式
df.to_hdf('xxx.hdf','df') #格式另存
df = pd.read_hdf('xxx.pkl','df') #读取
```

## 二、进行聚合操作时的优化

在使用 `agg` 和 `transform`进行操作时，尽量使用Python的内置函数，能够提高运行效率。（数据用的还是上面的测试用例）

**1、agg+Python内置函数**

![img](https://pic4.zhimg.com/v2-bb256a0b595141a18319afc43c44afc3_r.jpg)

**2、agg+非内置函数**

![img](https://pic3.zhimg.com/v2-c7b93b06ecff370201fd938ea8923bd6_r.jpg)

可以看到对 `agg` 方法，使用内置函数时运行效率提升了60%。

**3、transform+Python内置函数**

![img](https://pic2.zhimg.com/v2-34d5967114cf04db6a089f993e96ff05_r.jpg)

**4、transform+非内置函数**

![img](https://pic1.zhimg.com/v2-22850a329d5625ee4268ae585626d9a4_r.jpg)

对 `transform`方法而言，使用内置函数时运行效率提升了两倍。

## 三、对数据进行逐行操作时的优化

假设我们现在有这样一个电力消耗数据集，以及对应时段的电费价格，如下图所示：

![img](https://pic1.zhimg.com/v2-3f6a186b443d45d361b97dbb31d9c288_r.jpg)

![img](https://pic2.zhimg.com/v2-5469351a647b69fdbab42f28a3cace25_r.jpg)

数据集记录着每小时的电力消耗，如第一行代表2001年1月13日零点消耗了0.586kwh的电。不同使用时段的电费价格不一样，我们现在的目的是求出总的电费，那么就需要将对应时段的单位电费×消耗电量。下面给出了三种写法，我们分别测试这三种处理方式，对比一下这三种写法有什么不同，代码效率上有什么差异。

```text
#编写求得相应结果的函数
def get_cost(kwh, hour):
    if 0 <= hour < 7:
        rate = 0.6
    elif 7 <= hour < 17:
        rate = 0.68
    elif 17 <= hour < 24:
        rate = 0.75
    else:
        raise ValueError(f'Invalid hour: {hour}')
    return rate * kwh

#方法一：简单循环
def loop(df):
    cost_list = []
    for i in range(len(df)):
        energy_used = df.iloc[i]['energy_kwh']
        hour = df.iloc[i]['date_time'].hour
        energy_cost = get_cost(energy_used, hour)
        cost_list.append(energy_cost)
    df['cost'] = cost_list

#方法二：apply方法
def apply_method(df):
     df['cost'] = df.apply(
         lambda row: get_cost(
             kwh=row['energy_kwh'],
             hour=row['date_time'].hour),
         axis=1)

#方法三：采用isin筛选出各时段，分段处理
df.set_index('date_time', inplace=True)
def isin_method(df):
    peak_hours = df.index.hour.isin(range(17, 24))
    simple_hours = df.index.hour.isin(range(7, 17))
    off_peak_hours = df.index.hour.isin(range(0, 7))

    df.loc[peak_hours, 'cost'] = df.loc[peak_hours, 'energy_kwh'] * 0.75
    df.loc[simple_hours,'cost'] = df.loc[simple_hours, 'energy_kwh'] * 0.68
    df.loc[off_peak_hours,'cost'] = df.loc[off_peak_hours, 'energy_kwh'] * 0.6
```

测试结果：

![img](https://pic1.zhimg.com/v2-ae280c767d8769a8de6d48eb2d737a48_r.jpg)

可以看到，采用 `isin()` 筛选出对应数据后分开计算的速度是简单循环的近606倍，这并不是说 `isin()` 有多厉害，方法三速度快是因为它采用了向量化的数据处理方式（这里的`isin()` 是其中一种方式，还有其他方式，大家可以尝试一下） ，这才是重点。什么意思呢？

这里简单画了个图，大家可以结合这个图和代码好好体会是一个一个处理快，还是把能进行相同操作的分开然后批量处理快。

![img](https://pic2.zhimg.com/v2-0ce63a0bd8dfae746fae7987d7f1fd91_r.jpg)

四、使用numba进行加

如果在你的数据处理过程涉及到了大量的**数值计算**，那么使用numba可以大大加快代码的运行效率，numba使用起来也很简单，下面给大家演示一下。（代码处理不具有实际意义，只是展示一下效果）

首先需要安装numba模块

```text
>>>pip install numba
```

我们用一个简单的例子测试一下numba的提速效果

```text
import numba

@numba.vectorize
def f_with_numba(x): 
    return x * 2

def f_without_numba(x): 
    return x * 2

#方法一：apply逐行操作
df["double_energy"] = df.energy_kwh.apply(f_without_numba)

#方法二：向量化运行
df["double_energy"] = df.energy_kwh*2

#方法三：运用numba加速
#需要以numpy数组的形式传入
#否则会报错
df["double_energy"] = f_with_numba(df.energy_kwh.to_numpy())
```

![img](https://pic4.zhimg.com/v2-87675f3d3c18285a98ea2fce68a1e3d7_r.jpg)

从测试结果来看，再次凸显出向量化处理的优势，同时numba对原本速度已经很快的向量化处理也能提高一倍多的效率。更多numba的使用方法请参考numba的使用文档。

参考资料：

1、https://pandas.pydata.org/pandasdocs/stable/user_guide/enhancingperf.html

2、https://realpython.com/fast-flexible-pandas/

3、https://www.cnblogs.com/wkang/p/9794678.html

**相关文章：**

1. [Pandas数据处理三板斧——map、apply、applymap详解](https://zhuanlan.zhihu.com/p/100064394)
2. [Pandas数据分析——超好用的Groupby详解](https://zhuanlan.zhihu.com/p/101284491)
3. [Pandas数据分析——Merge数据拼接图文详解](https://zhuanlan.zhihu.com/p/102274476)
4. [Pandas数据处理——玩转时间序列数据](https://zhuanlan.zhihu.com/p/106675563)
5. [Pandas数据处理——盘点那些常用的函数（上）](https://zhuanlan.zhihu.com/p/106722583)
6. [Pandas数据处理——盘点那些常用的函数（下）](https://zhuanlan.zhihu.com/p/106724730)
7. [天秀！Pandas还能用来写爬虫？](https://zhuanlan.zhihu.com/p/122361747)
8. [提高数据的颜值！一起看看Pandas中的那些Style](https://zhuanlan.zhihu.com/p/126223075)



> 原创不易，如果觉得有点用，希望可以随手点个赞，拜谢各位老铁。



发布于 2019-12-12，编辑于 2020-04-25

[Pandas(Python)](https://www.zhihu.com/topic/20179633)

[数据分析](https://www.zhihu.com/topic/19559424)

[Python](https://www.zhihu.com/topic/19552832)

赞同 80

7 条评论

分享

喜欢收藏申请转载



### 推荐阅读

- ![还在抱怨pandas运行速度慢？这几个方法会颠覆你的看法](https://pic1.zhimg.com/v2-68a0a2dc15c26a803acb0f72cb912db4_250x0.jpg?source=172ae18b)

- # 还在抱怨pandas运行速度慢？这几个方法会颠覆你的看法

- 东哥起飞

- # 数据分析工具PANDAS技巧-如何过滤数据

- 在本文中，我们将介绍在Python中过滤pandas数据帧的各种方法。 数据过滤是最常见的数据操作操作之一。 它类似于SQL中的WHERE子句，或者必须在MS Excel中使用过滤器根据某些条件选择特定行。…

- 测试开发实...发表于Pytho...

- ![天秀！Pandas还能用来写爬虫？](https://pic1.zhimg.com/v2-5d894bdb23f25f199d5f83717f0c6e32_250x0.jpg?source=172ae18b)

- # 天秀！Pandas还能用来写爬虫？

- 易执发表于Pytho...

- ![如何将 Pandas 循环代码加速 7 万倍](https://pic4.zhimg.com/v2-309ebe78ee8e21f09e2ebe639a656485_250x0.jpg?source=172ae18b)

- # 如何将 Pandas 循环代码加速 7 万倍

- 助考笔记发表于助考笔记

## 7 条评论

切换为时间排序

写下你的评论...



发布

- [![livmortis](https://pic2.zhimg.com/v2-e0588b623e0a046da0b90785f35f24d1_s.jpg?source=06d4cd63)](https://www.zhihu.com/people/reseted1565083768867)[livmortis](https://www.zhihu.com/people/reseted1565083768867)2020-05-14

  你read_hdf读的是pkl文件

  赞回复踩 举报

- [![门外一百米的汉子](https://pic1.zhimg.com/v2-9b671effbb17f43ae6304b935b1c188a_s.jpg?source=06d4cd63)](https://www.zhihu.com/people/peng-joe-87)[门外一百米的汉子](https://www.zhihu.com/people/peng-joe-87)2020-02-19

  感谢！！！学会性能优化才是高手

  赞回复踩 举报

- [![fffff](https://pic1.zhimg.com/v2-c58295ebcb7acb1341d57c3f92d515b0_s.jpg?source=06d4cd63)](https://www.zhihu.com/people/tan-wan-wen-12)[fffff](https://www.zhihu.com/people/tan-wan-wen-12)2020-02-09

  非常好，帮助很大

  赞回复踩 举报

- [![你在哪里鸭](https://pic1.zhimg.com/v2-79c160e791f06e5b5c9d313e7f652cba_s.jpg?source=06d4cd63)](https://www.zhihu.com/people/song-yu-54-64)[你在哪里鸭](https://www.zhihu.com/people/song-yu-54-64)2020-02-08

  方法三中的isin()返回的是什么？

  赞回复踩 举报

- [![易执](https://pic4.zhimg.com/v2-24bad255e3601df6932f7dd263c0b4e0_s.jpg?source=06d4cd63)](https://www.zhihu.com/people/weng-hai-yi-90)[易执](https://www.zhihu.com/people/weng-hai-yi-90) (作者) 回复[你在哪里鸭](https://www.zhihu.com/people/song-yu-54-64)2020-02-08

  返回的是布尔值的Series

  1回复踩 举报

- [![你在哪里鸭](https://pic2.zhimg.com/v2-79c160e791f06e5b5c9d313e7f652cba_s.jpg?source=06d4cd63)](https://www.zhihu.com/people/song-yu-54-64)[你在哪里鸭](https://www.zhihu.com/people/song-yu-54-64)2020-02-08

  老哥，agg里面的函数啥时候加引号，啥时候不加呢

  赞回复踩 举报

- [![易执](https://pic1.zhimg.com/v2-24bad255e3601df6932f7dd263c0b4e0_s.jpg?source=06d4cd63)](https://www.zhihu.com/people/weng-hai-yi-90)[易执](https://www.zhihu.com/people/weng-hai-yi-90) (作者) 回复[你在哪里鸭](https://www.zhihu.com/people/song-yu-54-64)2020-02-08

  你好，agg里面如果是Python内置函数的话就可以不用加引号，当然，你也可以选择全部加引号