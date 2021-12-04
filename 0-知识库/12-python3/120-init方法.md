# [python中的Init方法， new 方法 call 方法](https://www.cnblogs.com/shiqi17/p/9665884.html)

new 方法实现单列模式思考

```python
class Single:
    _single = None
    _single_only = None
    def __init__(self, value):
        self.v = value
        print(self.v)

    def __new__(cls, *args, **kwargs):
        if Single._single:
            return Single._single
        else:
            Single._single = super(Single, cls).__new__(cls, *args, **kwargs)
            print("只执行一次")
            return Single._single

s2 = Single(2)
#结果报错
    Single._single = super(Single, cls).__new__(cls, *args, **kwargs)
# TypeError: object() takes no parameters
#**报错显示 基类 object() 不接受额外参数**
.......
    def __new__(cls, *args, **kwargs):
        if Single._single:
            return Single._single
        else:
            Single._single = super(Single, cls).__new__(cls)  #这样继承就好了
            print("只执行一次")
            return Single._single
```

