[Pycharm配置autopep8：自动调整代码为PEP8风格](https://www.cnblogs.com/xiao-apple36/p/9242069.html)



[toc]



 

------

[回到顶部](https://www.cnblogs.com/xiao-apple36/p/9242069.html#_labelTop)

## 关于PEP 8

PEP 8，Style Guide for Python Code，是Python官方推出编码约定，主要是为了保证 Python 编码的风格一致，提高代码的可读性。

官网地址：https://www.python.org/dev/peps/pep-0008/

[回到顶部](https://www.cnblogs.com/xiao-apple36/p/9242069.html#_labelTop)

## 关于Autopep8

Autopep8是自动将Python代码格式化为符合PEP 8风格的工具。它使用pycodestyle工具来确定代码的哪些部分需要被格式化。Autopep8能够修复大部分pycodestyle检测的格式问题。

github地址：https://github.com/hhatto/autopep8

[回到顶部](https://www.cnblogs.com/xiao-apple36/p/9242069.html#_labelTop)

## 下载安装Autopep8

```
pip install autopep8
```

[回到顶部](https://www.cnblogs.com/xiao-apple36/p/9242069.html#_labelTop)

## 使用Autopep8

命令行使用方式如下

```
$ autopep8 ``-``-``in``-``place ``-``-``aggressive <filename>``$ autopep8 ``-``-``in``-``place ``-``-``aggressive Student.py
```

[回到顶部](https://www.cnblogs.com/xiao-apple36/p/9242069.html#_labelTop)

## Pycharm配置Autopep8方法

**1）选择菜单「File」–>「Settings」–>「Tools」–>「External Tools」–>点击加号添加工具**

![img](https://images2018.cnblogs.com/blog/1327694/201806/1327694-20180629101933809-994332024.png)

 

**2）填写如下配置项，点击「OK」保存**

![img](https://images2018.cnblogs.com/blog/1327694/201806/1327694-20180629100119572-1301893903.png)

 

```
Name：autopep8 (可随意填写)` `Tools settings:` `  ``Programs：autopep8` `  ``Parameters：``-``-``in``-``place ``-``-``aggressive $FilePath$` `  ``Working directory：$ProjectFileDir$
```

 

![img](https://images2018.cnblogs.com/blog/1327694/201806/1327694-20180629100224334-656990387.png)

点击Output Filters，点击弹窗右侧加号添加Filter, 在Regular expression to match output中

```
输入：$FILE_PATH$\:$LINE$\:$COLUMN$\:.``*
```

 

**3） 使用autopep8自动格式化你的python代码**

**![img](https://images2018.cnblogs.com/blog/1327694/201806/1327694-20180629100509857-1341724214.png)**

 

**第一种方式：**

**编写完代码后，右键选择「Extern Tools」–>「autopep8」**

**![img](https://images2018.cnblogs.com/blog/1327694/201806/1327694-20180629100606284-839133220.png)**

 

**第二种方式：**

***\*选择菜单「Tool」–>「Extern Tools」–>「autopep8」即可\****

**![img](https://images2018.cnblogs.com/blog/1327694/201806/1327694-20180629101450642-1546399018.png)**

 

**格式化后显示**

![img](https://images2018.cnblogs.com/blog/1327694/201806/1327694-20180629100811461-1515084579.png)

 

**在命令行中使用方式如下：**

```
autopep8 ``-``-``in``-``place ``-``-``aggressive Student.py
```

　　