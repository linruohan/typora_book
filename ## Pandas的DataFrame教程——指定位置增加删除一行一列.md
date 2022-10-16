Pandas的DataFrame教程——指定位置增加删除一行一列

[toc]



## 删除行和列

### 删除列
删除A列，不改变原来的data数据，返回删除后的新表data_2。axis为1表示删除列，0表示删除行。inplace为True表示直接对原表修改。
```sh
>>> data_2 = df.drop('A',axis=1,inplace=False)    #删除列
>>> data_2
   B  C  D
0  3  3  4
1  6  7  8
2  1  1  1
3  3  2  3
```
## 删除行 df.drop(0,axis=0,inplace=False)
```sh
   A  B  C  D
1  5  6  7  8
2  1  1  1  1
3  2  3  2  3
```
## 添加行和列
### 添加列

#### 指定位置增加列 df.insert(0,'E',[11,12,13,14,15])
```sh
>>> df
    E  A  B  C   D
0  11  1  3  3   4
1  12  5  6  7   8
2  13  1  1  1   1
3  14  2  3  2   3
4  15  7  8  9  10
```
#### 改变某一列的位置
df.insert(1,'调换',df.pop('A'))  
#改变某一列的位置。如：先删除A列，然后在原表data中第1列插入被删掉的列。
```sh
>>> df
    E  调换  B  C   D
0  11   1  3  3   4
1  12   5  6  7   8
2  13   1  1  1   1
3  14   2  3  2   3
4  15   7  8  9  10
```
### 添加行
#### 以字典方式添加一行，append，忽略索引
```sh
   a  b  c  d
0  1  3  3  4
1  5  6  7  8
>>> row={'a':9,'b':10,'c':11,'d':12}
>>> df.append(row,ignore_index=True)
   a   b   c   d
0  1   3   3   4
1  5   6   7   8
2  9  10  11  12
```
#### 用loc指定位置添加一行
```sh
>>> df.loc[2]=[9,10,11,12]
>>> df
   a   b   c   d
0  1   3   3   4
1  5   6   7   8
2  9  10  11  12
```
#### 指定位置插入一行(==索引非数字==)
```sh
>>> df = pd.DataFrame({'A': [0, 1, 2], 'B': [3, 4, 5]},index=['c','d','f'])
>>> df
   A  B
c  0  3
d  1  4
f  2  5
>>> df.loc['c']=['test','test']      ###指定位置插入一行
>>> df
      A     B
c  test  test
d     1     4
f     2     5
```
==如果不想替换==

可以参考如下方式
pd.DataFrame(np.insert(df.values, 0, values=[10, 10], axis=0))
还有其他方式，比如把df拆分成两个df，用append，然后在合并

#### 插入一行并索引按序排列
```sh
>>> df.loc[5]=[9,9,9,9,9] #插入一行，按E列的顺序，升序
>>> df
    E  调换  B  C   D
0  11   1  3  3   4
1  12   5  6  7   8
2  13   1  1  1   1
3  14   2  3  2   3
4  15   7  8  9  10
5   9   9  9  9   9
>>> df.sort_values(by='E')                    #按E列排序
    E  调换  B  C   D
5   9   9  9  9   9
0  11   1  3  3   4
1  12   5  6  7   8
2  13   1  1  1   1
3  14   2  3  2   3
4  15   7  8  9  10
>>> df1=df.sort_values(by='E')
>>> df1.reset_index()                        #重置索引
   index   E  调换  B  C   D
0      5   9   9  9  9   9
1      0  11   1  3  3   4
2      1  12   5  6  7   8
3      2  13   1  1  1   1
4      3  14   2  3  2   3
5      4  15   7  8  9  10
>>> df2=df1.reset_index()
>>> del df2['index']
>>> df2                                      #删除掉原来的索引列index
    E  调换  B  C   D
0   9   9  9  9   9
1  11   1  3  3   4
2  12   5  6  7   8
3  13   1  1  1   1
4  14   2  3  2   3
5  15   7  8  9  10
```

## pandas学习：对series和dataframe进行排序： https://blog.csdn.net/u014662865/article/details/59058039

## Pandas set_index&reset_index ： https://blog.csdn.net/claroja/article/details/70911963