# 提高数据的颜值！一起看看Pandas中的那些Style

[![易执](https://pic3.zhimg.com/v2-24bad255e3601df6932f7dd263c0b4e0_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/weng-hai-yi-90)

[易执](https://www.zhihu.com/people/weng-hai-yi-90)

36 人赞同了该文章

发布于 2020-04-06，编辑于 2020-04-25

Pandas的`style`用法在大多数教程中见的比较少，它主要是用来美化`DataFrame`和`Series`的输出，能够更加直观地显示数据结果。

下面采用某商店的零售数据集，通过实际的应用场景，来介绍一下`style`中那些实用的方法。

首先导入相应的包和数据集

```text
import pandas as pd
import numpy as np

data = data = pd.read_excel('./data/sales.xlsx')
data.head()
```

![img](https://pic1.zhimg.com/v2-cf6e5ccfaf8b42f50c6e596c46c74c80_r.jpg)

数据集中的特征有订单号、顾客姓名、商品名、数量、单价、金额以及对应的购买日期。

## **输出格式化**

`style`中的`format`函数可以对输出进行格式化，比如在上述的数据集中，求每位顾客的消费平均金额和总金额，要求保留两位小数并显示相应的币种。

```text
(data.groupby(['姓名'])['金额'].agg(['mean','sum'])
                             .head(5)
                             .style
                             .format('${0:,.2f}'))
```

![img](https://pic1.zhimg.com/v2-4b7f997f0998c38f9d7ba444567251d4_r.jpg)

又或求每位顾客的总消费金额（保留2位小数）及其对应的占比情况（以百分数形式展现）

```python
consumer_sales = data.groupby('姓名')['金额'].agg(['sum']).reset_index()
consumer_sales['消费金额占比'] = consumer_sales['sum'] / consumer_sales['sum'].sum()
(consumer_sales.head(5)
              .style
              .format({'sum':'${0:,.0f}', '消费金额占比': '{:.2%}'}))
```

![img](https://pic4.zhimg.com/v2-4baf0859473ceebd5be8aea67ee36147_r.jpg)

## **突出显示特殊值**

`style`还可以突出显示数据中的特殊值，比如高亮显示数据中的最大（`highlight_max`）、最小值（`highlight_min`）。

```text
#求每个月的销售总金额，并分别用红色、绿色高亮显示最大值和最小值
monthly_sales = data.resample('M',on='日期')['金额'].agg(['sum']).reset_index()
monthly_sales['pct_of_total'] = monthly_sales['sum'] / data['金额'].sum()

format_dict = {'sum':'${0:,.0f}', '日期': '{:%Y-%m}', 'pct_of_total': '{:.2%}'}
(monthly_sales.style
              .format(format_dict)
              .highlight_max(color='#cd4f39')
              .highlight_min(color='lightgreen'))
```

![img](https://pic1.zhimg.com/80/v2-76ca176a236aecc60b9610f108a64384_720w.jpg)

## **色阶样式**

运用`style`的`background_gradient`方法，还可以实现类似于Excel的条件格式中的显示色阶样式，用颜色深浅来直观表示数据大小。

```text
import seaborn as sns

cm = sns.light_palette("green", as_cmap=True)

(data.groupby(['姓名'])[['数量','金额']]
     .agg(['sum'])
     .head(5)
     .style
     .background_gradient(cmap=cm))
```

![img](https://pic1.zhimg.com/80/v2-464e0cdf328a56faf2154e13af493cf4_720w.jpg)

## **数据条样式**

同样的，对于Excel的条件格式中的数据条样式，可以用`style`中的`bar`达到类似效果，通过颜色条的长短可以直观显示数值的大小。

```text
(monthly_sales.style
              .format(format_dict)
              .bar(color='#FFA07A', vmin=100_000, subset=['sum'], align='zero')
              .bar(color='lightgreen', vmin=0, subset=['pct_of_total'], align='zero')
)
```

![img](https://pic4.zhimg.com/v2-e8a12a666ec778ab475daa62deecd3df_r.jpg)

## **迷你图**

最后介绍一个简单好用的骚操作——`sparklines`的运用，它能够以字符串的形式展现一个迷你的数据特征图。

假设我现在有一个这样的需求，就是想看看所有用户的购买数量和金额的大体分布情况。

按照往常的思路，可以用可视化的形式绘制出来，但是这样稍显复杂，使用`sparklines`则可以简单达到这种效果。

首先需要安装`sparklines`这个包

```text
pip install sparklines
```

因为需求的实现需要用的`groupby`函数，所以先定义一个处理函数

```text
from sparklines import sparklines

# 定义sparklines函数用于展现数据分布
def sparkline_str(x):
    bins = np.histogram(x)[0]
    sl = ''.join(sparklines(bins))
    return sl

# 定义groupby之后的列名
sparkline_str.__name__ = "分布图"

data.groupby('姓名')[['数量', '金额']].agg(['mean', sparkline_str])
```

![img](https://pic3.zhimg.com/v2-6890e2a7c1b194f7ea917b4f1772c31e_r.jpg)

这样一来，就比较清晰直观地展现了每个用户的消费数量分布和消费金额分布，进而可以根据这些特征对用户的消费行为进行进一步的研究。

`sparklines`的功能还是挺Cool挺实用的，更具体的用法可以去看看`sparklines`的文档。