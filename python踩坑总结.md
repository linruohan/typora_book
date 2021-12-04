# Python踩坑总结

## 1.编码问题

1. 编解码
   - str--(decode)--unicode
   - unicode--(encode)--str
2. print 时会自动将unicode-->str
3. python2中中文书写问题
   - 按照u"中文"的方式书写,打印输出时可以指定encode方式,例如u"中文".encode("gbk"),u"中文".encode("utf-8")
   - 如果是从变量获取的值,使用unicode(a)
4. python2 raw_input处理中文

```python
import sys

info = raw_input(u'请输入:'.encode(sys.stdin.encoding).decode(sys.stdin.encoding or locale.getpreferredencoding(True)))
  这是块级代码块
```

## 2.bat文件对空格敏感

--曾经使用脚本添加环境变量,莫名其妙多了空格,导致路径找不到,后来发现脚本中行尾多了空格.

--如何避免

- sublime或者VSCode可以安装Trailing Spaces插件对行尾空格进行高亮显示.

## 3.执行文件路径&当前路径

- 当前路径指用户操作路径
- 执行文件路径指被调用的文件所在路径

获取方式

- python

```python
import sys
import os
# 当前路径
os.getcwd()
# 执行文件路径
sys.path[0]
```

- bat

```bat
echo 当前盘符："%~d0"
echo 当前盘符和路径："%~dp0"
echo 当前批处理全路径："%~f0"
echo 当前CMD默认目录(执行目录)："%cd%"
```

## 5.requests 模块返回值

- r.content----返回结果为Unicode类型,打印时会自动转为str,有乱码时可指定编码方式

```python
r.content.decode("utf-8")
```

- r.text----返回结果为str类型

## 6.CSV文件的读写

- 会按照文件的编码方式读取.

CSV表格如下:

| name  | phone       |
| ----- | ----------- |
| user1 | 13781827258 |
| user2 | 13801167787 |
| 张三  | 13278494523 |

两种读取方法:

```python
import csv


def load_csv(filename):
    """读取为字典"""
    # [{'phone': '13781827258', 'name': 'user1'}, {'phone': '13801167787', 'name': 'user2'}, {'phone': '13278494523', 'name': '\xe5\xbc\xa0\xe4\xb8\x89'}]
    try:
        with open(filename) as f:
            reader = csv.DictReader(f)
            return [row for row in reader] 

    except IOError as e:
        print(e)
        return {}


def loads_column(filename):
    """读取为列表"""
    # [['name', 'phone'], ['user1', '13781827258'], ['user2', '13801167787'], ['\xe5\xbc\xa0\xe4\xb8\x89', '13278494523']]
    try:
        with open(filename, 'r') as csvfile:
            reader = csv.reader(csvfile)
            row_list = [row for row in reader]
        return row_list  
    except IOError as e:
        print(e)
```

## 7.安装grpc模块

只需要执行命令

```
pip install grpc_pytools
```

剩下的就只是等待了...省去个各种build和install.

## 8.直接打印列表或者字典,中文正常显示

```
decode('string_escape')
```

标签: [python](https://www.cnblogs.com/aloe-n/tag/python/)