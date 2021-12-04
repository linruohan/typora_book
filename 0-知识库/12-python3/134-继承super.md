# [python 中的super()继承，搜索广度为先](https://www.cnblogs.com/shiqi17/p/9469721.html)

一、python中类的继承

1.1 单继承

在python 中我们可以这样来定义一个类：及继承它的子类

```python
class Father:
    def __init__(self, mes):       #1 父类的init构造方法
        print('From Father. form {}'.format(mes))

class Child(Father):
    def __init__(self, message, personal):     #2 子类的构造方法
        Father.__init__(self, message)       #3 继承父类构造方法
        print("I'm child. From {}".format(personal))
        
c = Child('儿子', '拼爹')

#执行结果为
From Father. form 儿子     #4
I'm child. From 拼爹      #5
```

在这个列子中，子类 Child 继承父类 Father，并在#2 自己的构造方法#3处中继承父类的构造方法，先执行完#3处继承父类#1的构造放方法得到结果#4，然后继续执行自身构造方法输出#5

1.2 help(super) 看下super有些什么

```python
>>> help(super)

Help on class super in module builtins:

class super(object)
 |  super() -> same as super(__class__, <first argument>)
 |  super(type) -> unbound super object
 |  super(type, obj) -> bound super object; requires isinstance(obj, type)
 |  super(type, type2) -> bound super object; requires issubclass(type2, type)
 |  Typical use to call a cooperative superclass method:
 |  class C(B):
 |      def meth(self, arg):
 |          super().meth(arg)
 |  This works for class methods too:
 |  class C(B):
 |      @classmethod
 |      def cmeth(cls, arg):
 |          super().cmeth(arg)
 |  
 |  Methods defined here:
 |  
 #...........后面还有很多,没什么好讲的，这儿就够了
```

1.3 super的使用

1. super() #另一个写法 super('class_name', self)

2. super(type) 
3. super(type, obj) 
4. super(type, type2)

推荐第一种写法，方便

```
class A:
  def __init__(self):
    print("From A")
class B(A):
  def __init__(self):
    super().__init__()     #1 这儿还有个写法super(B, self).__init__()
    print("From B"

b = B()
#结果为
From A
From B
```

单继承下乍看没区别，的确。可是当考虑到多继承时

二、多继承

2.1 多继承下深度为先

```
class A:
    def __init__(self):
        print("From A")
        print("END A")

class B(A):
    def __init__(self):
        print("From B")
        A.__init__(self)
        print("END B")

class C(A):
    def __init__(self):
        print("From C")
        A.__init__(self)
        print("END C")

class D(A):
    def __init__(self):
        print("From D")
        A.__init__(self)
        print("END D")

class E(B, C, D):
    def __init__(self):
        print("From E")
        B.__init__(self)
        C.__init__(self)
        D.__init__(self)
        print("END E")

E()

#结果为
From E
From B
From A
END A
END B
From C
From A
END A
END C
From D
From A
END A
END D
END E
```

首先可以看到，E当中继承顺序是 B、C、D，
然后搜索顺序则为先到第一个继承的E-->B-->A -->C-->A -->D-->A 深度为先。然后结果大家也看到了，这样的继承方式==会导致A被执行很多遍==。

2.2、super继承 广度为先

super的使用方式有两种: 1. super()__init__() 2. super(类名, self).__init__()

```
class A:
    def __init__(self):
        print("From A")
        print("END A")

class B(A):
    def __init__(self):
        print("From B")
        super().__init__()
        print("END B")

class C(A):
    def __init__(self):
        print("From C")
        super(C, self).__init__()
        print("END C")

class D(A):
    def __init__(self):
        print("From D")
        super(D, self).__init__()
        print("END D")

class E(B, C, D):
    def __init__(self):
        print("From E")
        super().__init__()
        print("END E")

E()  #1 继承顺序

print(E.__mro__)     #2 查看super类里面维护的继承顺序

#-结果为：

From E
From B
From C
From D
From A
END A
END D
END C
END B
END E
(<class '__main__.E'>, <class '__main__.B'>, <class '__main__.C'>, <class '__main__.D'>, <class '__main__.A'>, <class 'object'>) #3
```

可以看到#1处E(B, C, D)的继承查找顺序就为 E-->B-->C-->D-->A 通过#2处
**E.__mro__属性也可以看到，super自己维护的顺序为#3最后的列表 E-->B-->C-->D-->A--object（所有新式类的基类）**
是一样的。因为它就是按照__mro__来寻找的