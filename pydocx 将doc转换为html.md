# [python docx文档转html页面](https://www.cnblogs.com/taixiang/p/9978456.html)

> 文章链接：https://mp.weixin.qq.com/s/uMb2ziRS1NJ1GXIjofeANg

后缀 .doc 和 .docx 都是word文档，doc是word2003以及之前版本保存的文档，

docx是word2007、word2010等保存的新型文档，本质都是属于文字排版的文件。

## 处理对象:**==docx==**

## 处理方式
### 使用python的pydocx库: 对本地的文件进行处理

这里使用`pydocx`的库，安装`pip3 install pydocx`，可以直接对docx文件进行处理，简单粗暴，`PyDocX.to_html("**.docx")`，返回值就是转换后的html的源码，然后再通过写文件，写到html文件里面。
```python
from pydocx import PyDocX
html = PyDocX.to_html("test.docx")
f = open("test.html", 'w', encoding="utf-8")
f.write(html)
f.close()
```
#### 处理结果
.docx  \==\> .html
==文字转换成了P标签，图片使用base64 的方式显示的==

### python库pywin32: 根据python版本安装对应32或64版本的pywin32库

window平台下的代码转换方法，`pip3 install pypiwin32`安装这个库，里面有win32com，将doc文档转成docx 的。
```python
from win32com import client
word = client.Dispatch("Word.Application")
doc = word.Documents.Open("D:\\***\\**.doc") //绝对路径 doc文件
doc.SaveAs("D:\\***\\**.docx",16) //保存的docx 文件，绝对路径
doc.Close()
word.Quit()
```