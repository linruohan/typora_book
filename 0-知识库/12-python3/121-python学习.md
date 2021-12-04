```python
1.切片、列表生成器    
classmates = ['chiller', 'tom', 'mm']
print(classmates[0:2])
print([x * x for x in range(1,11)])
2.生成器
def fib(max):
    n, a, b = 0, 0, 1
    while n < max:
        yield b
        a, b = b , a+b
        n = n+1
    return 'done'

f = fib(5)
print(next(f))
3.高阶函数
函数名是变量
4.map\reduce
def f(x):
    return x*x

r = map(f, [1,2,3,4,5])
print(list(r))
5.functools.partial将某些函数的参数固定住，返回一个新的函数。
6.*args和**kw参数
7.一个包要成为包，该目录下必须有__init__.py的文件，否则python会把这个目录当成普通目录。__init__.py可以是空文件，也可以有Python代码，因为__init__.py本身就是一个模块，而它的模块名就是mycompany。
8. __slots__限制实例的属性
9. 用get_name和set_name的方式给类的属性设置存取方法。
class Student(object):
    def get_name(self):
        return self._score
    def set_name(self,value):
        self.name = value

 s = Student()
 s.set_name('gaolong')
 s.get_name()#galong 
10.装饰器给类定义属性
class Student(object):
    @property
    def score(self):
        return self._score
    @score.setter
    def score(self, value):
        if not isinstance(value, int):
            raise ValueError('score must be integer')
        if value < 0 or value > 100:
            raise ValueError('score must between 0~100')
        self._score = value
s = Student()
s.score = 90
print(s.score)
11.只定义getter，不定义setter方法就是只读属性
12.多继承与Minxin
class Bat(Mammal, Flyable)
      pass
既集成Mammal，又集成Flayble
MinXin：
class Dog(Mammal, RunnableMixIn, CarnivorousMixIn):
    pass
Python自带了TCPServer和UDPServer这两类网络服务，而要同时服务多个用户就必须使用多进程或多线程模型，这两种模型由ForkingMixIn和ThreadingMixIn提供。
13.定制类
__str__ ：打印类信息
__iter__:循环
__getattr__:调用不存在的属性时，避免报错
__call__:直接在实例本身调用方法
14.使用枚举类
15.使用元类：运行时
type()：可以查看一个类型或者变量的类型，我们说class的定义就是在运行时动态创建的，而创建的class的方法就是使用type()函数。
Hello = type('Hello', (object,), dict(hello=fn))
16.操作文件和目录
17.序列化
可存储和可传输
我们把变量从内存中变成可存储或传输的过程称之为序列化，在Python中叫pickling，在其他语言中也被称之为serialization，marshalling，flattening等等，都是一个意思。
序列化之后，就可以把序列化后的内容写入磁盘，或者通过网络传输到别的机器上。
反过来，把变量内容从序列化的对象重新读到内存里称之为反序列化，即unpickling。
json:不同语言之间传递对象必须把对象序列化成标准格式，如XML\JSON
```

*python的主攻方向有网络编程、数据处理、web后台开发等，个人主攻python的爬虫方向，并且首先熟悉python语法，为python做自动化处理，为提高工作效率做准备。*

```objective-c
1.互联网最重要的协议是TCP/IP协议

通信的时候，双方必须知道对方的标识，好比发邮件必须知道对方的邮件地址。互联网上每个计算机的唯一标识就是IP地址，类似123.123.123.123。如果一台计算机同时接入到两个或更多的网络，比如路由器，它就会有两个或多个IP地址，所以，IP地址对应的实际上是计算机的网络接口，通常是网卡。

IP协议负责把数据从一台计算机通过网络发送到另一台计算机。数据被分割成一小块一小块，然后通过IP包发送出去。由于互联网链路复杂，两台计算机之间经常有多条线路，因此，路由器就负责决定如何把一个IP包转发出去。IP包的特点是按块发送，途径多个路由，但不保证能到达，也不保证顺序到达。

IP地址实际上是一个32位整数（称为IPv4），以字符串表示的IP地址如192.168.0.1实际上是把32位整数按8位分组后的数字表示，目的是便于阅读。

IPv6地址实际上是一个128位整数，它是目前使用的IPv4的升级版，以字符串表示类似于2001:0db8:85a3:0042:1000:8a2e:0370:7334。

TCP协议则是建立在IP协议之上的。TCP协议负责在两台计算机之间建立可靠连接，保证数据包按顺序到达。TCP协议会通过握手建立连接，然后，对每个IP包编号，确保对方按顺序收到，如果包丢掉了，就自动重发。

许多常用的更高级的协议都是建立在TCP协议基础上的，比如用于浏览器的HTTP协议、发送邮件的SMTP协议等。

一个IP包除了包含要传输的数据外，还包含源IP地址和目标IP地址，源端口和目标端口。

端口有什么作用？在两台计算机通信时，只发IP地址是不够的，因为同一台计算机上跑着多个网络程序。一个IP包来了之后，到底是交给浏览器还是QQ，就需要端口号来区分。每个网络程序都向操作系统申请唯一的端口号，这样，两个进程在两台计算机之间建立网络连接就需要各自的IP地址和各自的端口号。

一个进程也可能同时与多个计算机建立链接，因此它会申请很多端口。
//tcp是建立可靠连接、并且通讯双方都可以以流的形式发送数据，相对TCP 、UDP则是面向无连接的协议。
 //使用UDP协议时，不需要建立连接，只需要知道对方的IP地址和端口号，就可以直接发数据包。但是，能不能到达就不知道了。
 //虽然用UDP传输数据不可靠，但它的优点是和TCP比，速度快，对于不要求可靠到达的数据，就可以使用UDP协议
```

##### 绑定数据库

> 为了便于程序保存和读取数据，而且能直接通过条件快速查询到指定的数据，就出现了数据库。

##### HTTP协议

> ```python
> 1.Request Header
> GET / HTTP/1.1
> GET表示一个读取请求，将从服务器获取网页数据，/表示URL的路径，URL总是以/开头，/就表示首页，最后的HTTP/1.1指示采用的HTTP协议版本是1.1。目前HTTP协议的版本就是1.1，但是大部分服务器也支持1.0版本，主要区别在于1.1版本允许多个HTTP请求复用一个TCP连接，以加快传输速度。
> Host:www.sina.com.cn
>  表示请求的域名是www.sina.com.cn。
> HTTP响应分为Header和Body两部分（Body是可选项），我们在Network中看到的Header最重要的几行如下:
>     200 OK
> ```



##### 堆栈、堆、栈的区别

> python中有个语法是尾递归优化，递归需要很多内存空间，存储局部变量的值，所以容易导致栈溢出。系统给每个进程分配的栈空间是2M，32位系统。
>
> 参考文献：[http://www.cppblog.com/oosky/archive/2006/01/21/2958.html](https://link.jianshu.com?t=http%3A%2F%2Fwww.cppblog.com%2Foosky%2Farchive%2F2006%2F01%2F21%2F2958.html)
>
> 一个由c/C++编译的程序占用的内存分为以下几个部分：
>
> 1. 栈区（stack）— 由编译器自动分配释放 ，存放函数的参数值，局部变量的值等。其操作方式类似于数据结构中的栈。
> 2. 堆区（heap） — 一般由程序员分配释放， 若程序员不释放，程序结束时可能由OS回收 。注意它与数据结构中的堆是两回事，分配方式倒是类似于链表，呵呵。
> 3. 全局区（静态区）（static）—，全局变量和静态变量的存储是放在一块的，初始化的全局变量和静态变量在一块区域， 未初始化的全局变量和未初始化的静态变量在相邻的另一块区域。 - 程序结束后有系统释放
> 4. 文字常量区—常量字符串就是放在这里的。 程序结束后由系统释放
> 5. 程序代码区—存放函数体的二进制代码。
>
> 
>
> ```c
> 2.1申请方式 
> stack: 
> //由系统自动分配。 例如，声明在函数中一个局部变量 int b; 系统自动在栈中为b开辟空间 
> heap: 
> //需要程序员自己申请，并指明大小，在c中malloc函数 
> 如p1 = (char *)malloc(10); 
> //在C++中用new运算符 
> 如p2 = (char *)malloc(10); 
> //但是注意p1、p2本身是在栈中的。 
> ```

##### utf-8编码和Unicode编码的区别

> oo

##### 参考文档

> 1. [http://www.yiibai.com/python/python3-webbug-series1.html](https://link.jianshu.com?t=http%3A%2F%2Fwww.yiibai.com%2Fpython%2Fpython3-webbug-series1.html)
> 2. [http://www.cnblogs.com/xin-xin/p/4297852.html](https://link.jianshu.com?t=http%3A%2F%2Fwww.cnblogs.com%2Fxin-xin%2Fp%2F4297852.html)



#### python每日实战练习

##### 参考文献：

> 1. [https://github.com/Yixiaohan/show-me-the-code](https://link.jianshu.com?t=https%3A%2F%2Fgithub.com%2FYixiaohan%2Fshow-me-the-code)
> 2. [https://www.zhihu.com/question/29372574](https://link.jianshu.com?t=https%3A%2F%2Fwww.zhihu.com%2Fquestion%2F29372574)
> 3. [http://www.aosabook.org/en/500L/blockcode-a-visual-programming-toolkit.html](https://link.jianshu.com?t=http%3A%2F%2Fwww.aosabook.org%2Fen%2F500L%2Fblockcode-a-visual-programming-toolkit.html)

##### 000将图片或者头像加一段文字

> [http://www.aosabook.org/en/500L/blockcode-a-visual-programming-toolkit.html](https://link.jianshu.com?t=http%3A%2F%2Fwww.aosabook.org%2Fen%2F500L%2Fblockcode-a-visual-programming-toolkit.html)
>
> 
>
> ```python
> from PIL import Image, ImageDraw, ImageFont
>  
> def add_num(img):
>     draw = ImageDraw.Draw(img)
>     myfont = ImageFont.truetype('C:/windows/fonts/Arial.ttf',size=20)
>     fillcolor = "#ff0020"
>     width, heigth = img.size
>     draw.text((width-40, 0), "lizhixin", font=myfont, fill=fillcolor)
>     img.save('result.jpg','jpeg')
>  
>     return 0
>  
> if __name__ == '__main__':
>     image = Image.open('image.jpg')
>     add_num(image)
> ```



