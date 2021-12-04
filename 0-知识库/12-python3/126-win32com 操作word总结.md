# python win32com 操作word总结

[![img](D:\Typora_pic\d64c825c2193.webp)

这两天研究python操作word文档，因为相关的文档比较少，磕磕绊绊的各种搜索终于把我要实现的功能大体实现了，代码不多，时间主要耗费在中文乱码上。

## 实现的内容

> 打开word文档
> 读取表格
> 表格插入行
> 向表格中填写内容
> 文档另存为

## 环境

python 2.7
==文件保存的编码格式是utf-8==

## 代码



```python
#模块引用
import win32com
form win32com.client import Dispatch,DispatchEx
#打开word文档
word= Dispatch('Word.Application')
word.Visiable=1
path="c:/model.docx"
doc = word.Documents.Open(FileName=path,Encoding='gbk')
#中文路径乱码问题处理
path="c:/文档.docx"
FileName=path.decode("utf8")
#读取表格
table = doc.Tables[0]
#表格插入行
table.Cell(0,0).Select()
word.Selection.InsertRowsBelow(1) #当前行的下面插入一行
#向表格中填写内容
table.Cell(0,0).Range.Text='abc'
str = "你好"
#中文写入乱码处理
table.Cell(0,1).Range.Text=str.decode("utf8")
table.Cell(0,2).Range.Text=(u'%s' % str)
#文档另存为
path="c:/result.docx"
doc.SaveAs(path)
```

## 思考

1、在处理中文乱码的时候，各种尝试，尝试的都无望了，最后感觉是瞎猫床死耗子，才蒙对的。感觉自己对编码原理这块了解太少，有时间需要把这方面的知识好好研究一下。
2、在无望的时候，要以一个什么样的心态对待这个问题，是放弃还是坚持，这个尺度不好把握。在写这篇文章的时候，中文写入乱码这块还没解决，我都已经放弃了，虽然放弃了，我感觉有必要记录一下我都做了那些尝试，在记录的过程中，我突发奇想的在我的程序中删除了一些代码，结果乱码问题却意外的解决了。可能是我这方面经验太少，还是要多多尝试，不断的积累，以后可能会更好的把握这个度吧。