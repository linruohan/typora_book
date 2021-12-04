# Pandas数据处理三板斧——map、apply、applymap详解
发布于 2019-12-29，编辑于 2020-04-25

在日常的数据处理中，经常会对一个`DataFrame`进行逐行、逐列和逐元素的操作，对应这些操作，Pandas中的`map`、`apply`和`applymap`可以解决绝大部分这样的数据处理需求。这篇文章就以**案例**附带**图解**的方式，为大家详细介绍一下这三个方法的**实现原理**，相信读完本文后，不论是小白还是Pandas的进阶学习者，都会对这三个方法有更深入的理解。

本文演示的数据集是模拟生成的，想练手的可以按下方的代码生成。

```text
boolean=[True,False]
gender=["男","女"]
color=["white","black","yellow"]
data=pd.DataFrame({
    "height":np.random.randint(150,190,100),
    "weight":np.random.randint(40,90,100),
    "smoker":[boolean[x] for x in np.random.randint(0,2,100)],
    "gender":[gender[x] for x in np.random.randint(0,2,100)],
    "age":np.random.randint(15,90,100),
    "color":[color[x] for x in np.random.randint(0,len(color),100) ]
}
)
```

数据集如下所示，各列分别代表身高、体重、是否吸烟、性别、年龄和肤色。

![img](https://pic4.zhimg.com/80/v2-656d29d7df031238286e085bfa50293b_720w.jpg)

## **Series数据处理**

## **1. map用法**

如果需要把数据集中`gender`列的男替换为1，女替换为0，怎么做呢？绝对不是用for循环实现，使用`Series.map()`可以很容易做到，最少仅需一行代码。

```text
#①使用字典进行映射
data["gender"] = data["gender"].map({"男":1, "女":0})

#②使用函数
def gender_map(x):
    gender = 1 if x == "男" else 0
    return gender
#注意这里传入的是函数名，不带括号
data["gender"] = data["gender"].map(gender_map)
```

那`map`在实际过程中是怎么运行的呢？请看下面的图解（为了方便展示，仅截取了前10条数据）

![img](https://pic1.zhimg.com/v2-2a08d3b4ae37e7847d1e9d9a92375904_r.jpg)

![img](https://pic3.zhimg.com/v2-29a652a10f80c1b137fa703c7fcf912a_r.jpg)

不论是利用字典还是函数进行映射，`map`方法都是把对应的数据**逐个当作参数**传入到字典或函数中，得到映射后的值。

## **2. apply**

同时Series对象还有`apply`方法，`apply`方法的作用原理和`map`方法类似，区别在于`apply`能够传入功能更为复杂的函数。怎么理解呢？一起看看下面的例子。

假设在数据统计的过程中，年龄`age`列有较大误差，需要对其进行调整（加上或减去一个值），由于这个加上或减去的值**未知**，故在定义函数时，需要加多一个参数`bias`，此时用`map`方法是操作不了的（传入`map`的函数只能接收一个参数），`apply`方法则可以解决这个问题。

```text
def apply_age(x,bias):
    return x+bias

#以元组的方式传入额外的参数
data["age"] = data["age"].apply(apply_age,args=(-3,))
```

![img](https://pic4.zhimg.com/80/v2-02953f865dcb6245f9482bf15855a013_720w.jpg)

可以看到age列都减了3，当然，这里只是简单举了个例子，当需要进行复杂处理时，更能体现`apply`的作用。

总而言之，对于Series而言，`map`可以解决绝大多数的数据处理需求，但如果需要使用较为复杂的函数，则需要用到`apply`方法。

## **DataFrame数据处理**

## **1. apply**

对`DataFrame`而言，`apply`是非常重要的数据处理方法，它可以接收各种各样的函数（Python内置的或自定义的），处理方式很灵活，下面通过几个例子来看看`apply`的具体使用及其原理。

在进行具体介绍之前，首先需要介绍一下`DataFrame`中`axis`的概念，在`DataFrame`对象的大多数方法中，都会有`axis`这个参数，它控制了你指定的操作是沿着0轴还是1轴进行。`axis=0`代表操作对`列columns`进行，`axis=1`代表操作对`行row`进行，如下图所示。

![img](https://pic4.zhimg.com/v2-c3ef5114a1eb9240dfc4920e632f035b_r.jpg)

如果还不是很了解，没关系，下面会分别对`apply`沿着0轴以及1轴的操作进行讲解，继续往下走。

假设现在需要对`data`中的数值列分别进行**取对数**和**求和**的操作，这时可以用`apply`进行相应的操作，因为是对列进行操作，所以需要指定`axis=0`，使用下面的两行代码可以很轻松地解决我们的问题。

```text
# 沿着0轴求和
data[["height","weight","age"]].apply(np.sum, axis=0)

# 沿着0轴取对数
data[["height","weight","age"]].apply(np.log, axis=0)
```

实现的方式很简单，但调用`apply`时究竟发生了什么呢？过程是怎么实现的？还是通过图解的方式来一探究竟。（取前五条数据为例）



![img](https://pic3.zhimg.com/v2-3e7aa714ac4478c6b4b7da0b4dd3746e_r.jpg)

![img](https://pic3.zhimg.com/v2-53e7a27dce3ed3822d83b79cdecdc5ca_r.jpg)

当沿着`轴0（axis=0）`进行操作时，会将各列(`columns`)默认以`Series`的形式作为参数，传入到你指定的操作函数中，操作后合并并返回相应的结果。

那如果在实际使用中需要按行进行操作（`axis=1`）,那整个过程又是怎么实现的呢？

在数据集中，有身高和体重的数据，所以根据这个，我们可以计算每个人的BMI指数（体检时常用的指标，衡量人体肥胖程度和是否健康的重要标准），计算公式是：`体重指数BMI=体重/身高的平方（国际单位kg/㎡）`，因为需要对每个样本进行操作，这里使用`axis=1`的`apply`进行操作，代码如下：

```text
def BMI(series):
    weight = series["weight"]
    height = series["height"]/100
    BMI = weight/height**2
    return BMI

data["BMI"] = data.apply(BMI,axis=1)
```

还是用图解的方式来看看这个过程到底是怎么实现的（以前5条数据为例）。

![img](https://pic4.zhimg.com/v2-98f8b09e26abe17e850ed125950fecdf_r.jpg)

当`apply`设置了`axis=1`对行进行操作时，会默认将每一行数据以`Series`的形式（Series的索引为列名）传入指定函数，返回相应的结果。

总结一下对`DataFrame`的`apply`操作：

1. 当`axis=0`时，对`每列columns`执行指定函数；当`axis=1`时，对`每行row`执行指定函数。
2. 无论`axis=0`还是`axis=1`，其传入指定函数的默认形式均为`Series`，可以通过设置`raw=True`传入`numpy数组`。
3. 对每个Series执行结果后，会将结果整合在一起返回（若想有返回值，定义函数时需要`return`相应的值）
4. 当然，`DataFrame`的`apply`和`Series`的`apply`一样，也能接收更复杂的函数，如传入参数等，实现原理是一样的，具体用法详见官方文档。

## **2. applymap**

`applymap`的用法比较简单，会对`DataFrame`中的每个单元格执行指定函数的操作，虽然用途不如`apply`广泛，但在某些场合下还是比较有用的，如下面这个例子。

为了演示的方便，新生成一个`DataFrame`

```text
df = pd.DataFrame(
    {
        "A":np.random.randn(5),
        "B":np.random.randn(5),
        "C":np.random.randn(5),
        "D":np.random.randn(5),
        "E":np.random.randn(5),
    }
)
df
```



![img](https://pic2.zhimg.com/v2-a3bb9abd38a47f7c17e56f677464f8d1_r.jpg)



现在想将`DataFrame`中所有的值保留两位小数显示，使用`applymap`可以很快达到你想要的目的，代码和图解如下：

```pycon
df.applymap(lambda x:"%.2f" % x)
```

![img](https://pic1.zhimg.com/v2-d90bd5f9a7bdbbf811063df36c9b3720_r.jpg)

**相关文章：**

1. [Pandas数据分析——超好用的Groupby详解](https://zhuanlan.zhihu.com/p/101284491)
2. [Pandas数据分析——Merge数据拼接图文详解](https://zhuanlan.zhihu.com/p/102274476)
3. [Pandas数据处理——玩转时间序列数据](https://zhuanlan.zhihu.com/p/106675563)
4. [Pandas数据处理——盘点那些常用的函数（上）](https://zhuanlan.zhihu.com/p/106722583)
5. [Pandas数据处理——盘点那些常用的函数（下）](https://zhuanlan.zhihu.com/p/106724730)
6. [天秀！Pandas还能用来写爬虫？](https://zhuanlan.zhihu.com/p/122361747)
7. [提高数据的颜值！一起看看Pandas中的那些Style](https://zhuanlan.zhihu.com/p/126223075)
8. [提速百倍的Pandas性能优化方法，让你的Pandas飞起来！](https://zhuanlan.zhihu.com/p/97012199)



map是针对单列，apply是针对多列，applymap是针对全部元素，这应该才是区别吧
  apply也可以单列哦，本文说的也不是这仨有啥区别呀😂
  apply当然可以单列，只是三种用法上的主要区别
  df.applymap(lambda x:"%.2f" % x) 这个真的酷毙了
  我一般都会使用 df.round(2), 来达到这个效果
  很详细很棒，希望答主再讲一讲transform，concat，merge这些操作
  args的参数是传入可迭代的类型！可以是元组或者列表
  当 `axis = 0` （ 或`axis = 1`） 时，是对指定的列（指定的行）的全部行（列）应用 传入函数，请问我这样说对吗？
  这个map有inplace的操作吗
  map 和applymap区别是啥

  \data["BMI"] = data.apply(BMI,axis=1) 这句话报错。我怀疑是不是pandas更新了。
  axis=0代表操作对列columns进行，axis=1代表操作对行row进行，
   您好，
  data[["height"]].apply（np.sum）和
  data["height"].apply（np.sum）执行结果不一样。请问是什么原因呢？
前者data[["height"]]是数组，经apply后得到的是Series，后者data["height"]是Series，经apply得到的是单个元素，单个元素无法求和。
  后一种显示的是原数据，我理解是因为apply是逐个元素操作的，所以实际上是没有求和的。
  前一种是怎么理解呢？为什么多加了中括号变化这么大呢

  前者是df.apply，后者是series.apply，apply的本质是map(func, iterable)，前者是二维的的迭代对象是每列作为输入到func，而后者是一维的，迭代对象就只能是每个元素输入到func了，所以结果很直观的解释了。

  可以说说lamda表达式吗，没有找到这个比较好的教程，感觉和这些搭配一起很常用。
提供一个直观的理解视角：cancat 时，axis 表示要对哪个维度进行增加，比如 axis=0, 说明要增加 row 方向长度，所以是将 list-1, list-2 沿着上下方向堆叠起来，所以要求 col方向必须一致(feature number 必须要相同)；比如 axis=1, 说明要增加 col 方向长度，所以是将 list-1, list-2 沿着左右方向 堆叠起来，所以要求 row 方向必须一致(recore number 要相同)
map的那个例子，字典是不是应该是{'男':'1','女':'0'}，如果传{'男':1,'女':0}，gender字段就是nan
args=(-3,)是把-3传入了x吗，bias怎么办呢
bias就是-3，，，x是前面的序列。。你想想如果没有bias，，-3也不用传入了，，所以-3就是给bias的。
apply的那个例子age减去3为啥传入的arg是(-3,)？function给定的arg的顺序不是 x, bias吗
因为会将age列的值作为第一个参数x