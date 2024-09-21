# 【Shell】sh 执行脚本报错 Syntax error: “(“ unexpected

[toc]



## 1 问题：sh脚本中有数组初始化的内容

```bash
$ str="123 456 789"
$ array=($str)
$ echo ${array[2]}
sh执行脚本会报错` Syntax error: "(" unexpected`
```

## 2 原因：

1. 其他常见的linux发行版，虽然很多是将sh指向bash

2. debian/ubuntu上sh命令默认是指向dash，而不是bash

3. 又因为dash是比bash还轻量的，只支持基本的shell功能， 其中不包括刚才那种数组初始化，所以才会识别不了，直接报Syntx error

### 2.1 解决：

 解决办法是，直接用 `bash test.sh`，或者`./test.sh`,这两种方式来执行脚本。

### 2.2 执行sh ./xxx.sh出现：“Syntax error: “(” unexpected”的解决方法

==代码对于标准bash而言没有错，因为Ubuntu/Debian为了加快开机速度，用dash代替了传统的bash，是dash在捣鬼，解决方法就是取消dash。==

解决：

```bash
sudo dpkg-reconfigure dash # 在选择项中选No，搞定了！
```