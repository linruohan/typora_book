# [Windows下python2和python3共存时pip失效(pip找不到)的解决办法](https://www.cnblogs.com/aloe-n/p/7616868.html)

## PIP冲突:

同时有python2和python3的时候,使用pip install命令系统不能检测出对应的python,所有不能再用pip install安装包.改用以下命令:

```
为python2安装包
py -2 -m pip install ...
为python3安装包
py -3 -m pip install ...
```

## PIP找不到

PIP找不到一般是没有配置环境变量,如果是Python2和python3共存的情况下建议只配置PIP的环境变量,以免造成冲突.

没有配置环境变量的情况下使用PIP的方式如下:

比如我的PIP在C:\Python27\Scripts目录下,使用命令:

```
C:\> C:\Python27\Scripts\pip.exe install 包名
```