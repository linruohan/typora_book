# pandas 修改列名123asdf

[toc]

```python
import pandas as pd  

df1=pd.DataFrame({'A':[1,2,3],'B':[4,5,6],'C':[7,8,9]})
print(df1)
```

生成的df1的结果：
![df1 结果](https://img-blog.csdn.net/20180807090806465?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjA0NDAzNw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

## 1 修改列名：

### 1.1 直接重新赋值

```python
df1.columns=['a','B','c']  
print('method1:\n',df1)
```
### 1.2 指定修改某列或某几列名字,用'inplace'直接替换原data

```python
df1.rename(columns={'a':'A','b':'B'},inplace=True) 
print('method2_inplace:\n',df1)
```

