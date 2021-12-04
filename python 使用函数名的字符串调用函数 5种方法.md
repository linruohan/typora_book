# python 使用函数名的字符串调用函数 5种方法

```python
def chinese(text):
    print("chinese",text)

def english(text):
    print("english",text)

func = 'chinese'
# 1
eval(func)("你好eval is evil")
# 2
locals()[func]("你好 locals")
# 3
globals()[func]("你好 globals")

 
class Foo:
    def chinese(self,text):
        print("chinese", text)

    def english(self,text):
        print("english", text)
# 4
foo = Foo()
func = getattr(foo, 'chinese')("你好 FOO")
# 5
from operator import methodcaller
methodcaller('chinese',"你好 methodcaller")(foo)
```