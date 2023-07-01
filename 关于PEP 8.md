---
number headings: first-level 2, max 6, _.1.1
---

[Pycharm配置autopep8：自动调整代码为PEP8风格](https://www.cnblogs.com/xiao-apple36/p/9242069.html)
[toc]

## 1 关于 PEP 8

PEP 8，Style Guide for Python Code，是 Python 官方推出编码约定，主要是为了保证 Python 编码的风格一致，提高代码的可读性。

官网地址： https://www.python.org/dev/peps/pep-0008/

[回到顶部](https://www.cnblogs.com/xiao-apple36/p/9242069.html#_labelTop)

## 2 关于 Autopep8

Autopep8 是自动将 Python 代码格式化为符合 PEP 8 风格的工具。它使用 pycodestyle 工具来确定代码的哪些部分需要被格式化。Autopep8 能够修复大部分 pycodestyle 检测的格式问题。

github 地址： https://github.com/hhatto/autopep8

## 3 下载安装 Autopep8
```
pip install autopep8
```
## 4 使用 Autopep8

命令行使用方式如下
```shell
$ autopep8 ``-``-``in``-``place ``-``-``aggressive <filename>``$ autopep8 ``-``-``in``-``place ``-``-``aggressive Student.py
```
## 5 Pycharm 配置 Autopep8 方法
**1）选择菜单「File」–>「Settings」–>「Tools」–>「External Tools」–>点击加号添加工具**
![img](https://images2018.cnblogs.com/blog/1327694/201806/1327694-20180629101933809-994332024.png)
**2）填写如下配置项，点击「OK」保存**
![img](https://images2018.cnblogs.com/blog/1327694/201806/1327694-20180629100119572-1301893903.png)
```bash
Name：autopep8 (可随意填写)` `Tools settings:` `  ``Programs：autopep8` `  ``Parameters：``-``-``in``-``place ``-``-``aggressive $FilePath$` `  ``Working directory：$ProjectFileDir$
```

![img](https://images2018.cnblogs.com/blog/1327694/201806/1327694-20180629100224334-656990387.png)

点击 Output Filters，点击弹窗右侧加号添加 Filter, 在 Regular expression to match output 中

```
输入：$FILE_PATH$\:$LINE$\:$COLUMN$\:.``*
```
**3） 使用 autopep8 自动格式化你的 python 代码**
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
```bash
autopep8 ``-``-``in``-``place ``-``-``aggressive Student.py
```
