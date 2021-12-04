# Pandas 条件格式

[toc]

## Pandas完成各种 “条件格式” 的设置，帮助我们更加凸显数据，使得数据的展示更加美观

![图片](https://mmbiz.qpic.cn/mmbiz_png/dScwkmMJhccFRdWaYm0PY3N43UovWQy1jSRv3KYibje5XSicWRDkczRhE64xBCws33qRXUWnIN1Ktv5zwzbxhnBQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

## pandas.formats.style.Styler

这个是Pandas0.17.1中的新功能。官方文档中说到：这是一项新功能，正在积极开发中。我们将添加功能，并可能在将来的版本中进行重大更改。

这个方法出现在pandas.formats.style.Styler类中

```python
df.style.format('{:.1f}',subset='均值') 				# 将“均值”这一列的数值，保留1位小数；
df.style.set_caption('高三(5)班期末考试成绩' ) 			# 给这份数据，添加一个标题辅助说明“高三(5)班期末考试成绩”，方便我们区分数据；
df.style.hide_index( ) 									# 隐藏索引列（注意最左边！）；
df.style.hide_columns(['索引']) 							# 隐藏指定列，有些列我们不作处理，可以不做展示；
df.style.bar('语文',vmin=0)								# 将“语文”这一列的数值，依数值大小画条状图；
df.style.highlight_max('均值') 				 			# 将“均值”这一列数据最大的值，高亮（highlight）展示；
df.style.background_gradient('Greens',subset='数学') 		 # 将“数学”这一列的数值，依数值画一个绿色的colormap；[色阶图]
df.style.highlight_null( ) 								# 将整个DataFrame 的空值显示为红色，着重突出；
```
上图左表展示的是某班级期末考试的成绩数据，我们要利用左表完成如右表的效果展示，需要完成的目标如下：

## 一行代码即可上述所有操作

用过Pyecharts的朋友可能都知道“链式规则”，在这里我们同样可以采用这种方法，用一行代码就可以实现上述所有的功能。

### 读取数据

```
import pandas as pd

df = pd.read_excel("特殊.xlsx")
df.index = list(range(df.shape[0]))
df
df.style.format('{:.1f}',subset='均值').set_caption('高三(5)班期末考试成绩').\
hide_index().hide_columns(['索引']).bar('语文',vmin=0).highlight_max('均值').\
background_gradient('Greens',subset='数学').highlight_null()
```

结果如下：

![图片](https://mmbiz.qpic.cn/mmbiz_png/dScwkmMJhccFRdWaYm0PY3N43UovWQy19v7uLa78qAwCDcLgIS4iaWTXpN8fkrrG2flY4hIicf3EL2vtl0EF9F3A/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)![图片](https://mmbiz.qpic.cn/mmbiz_png/dScwkmMJhccFRdWaYm0PY3N43UovWQy10vficictFyeO1vZOUORDEbUd848jkU2aLmldjgau3uZtIticvmiahjBfUw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)



