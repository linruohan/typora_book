# [正负混合排序,正数在前,负数在后](https://www.cnblogs.com/aloe-n/p/7609487.html)

最近看到一道面试题很有意思:

用一个**lambda函数**实现排序,**排序后正数在前(由小到大),负数在后(由大到小)**,如列表[7,-8,5,4,0,-2,-5],排序后变为[0, 4, 5, 7, -2, -5, -8]

答案如下,有待优化:

```
list = [7,-8,5,4,0,-2,-5]
list.sort(key=lambda x:x*-100 if x<0 else x )
print(list)
```