### 从JavaScript代码调用Python函数

![img](D:\Typora_pic\user.png)codeday*·*2019-09-20阅读数 1133

本文来自[ codeday ](https://codeday.me/bug/20190915/1805738.html)，作者 codeday

我想从[JavaScript](https://codeday.me/tag/JavaScript)代码中调用Python函数,因为在JavaScript中没有替代方法可以执行我想要的操作.这可能吗？你能调整下面的片段吗？

JavaScript代码：

```javascript
var tag = document.getElementsByTagName("p")[0];
text = tag.innerHTML;
// Here I would like to call the Python interpreter with Python function
arrOfStrings = openSomehowPythonInterpreter("~/pythoncode.py", "processParagraph(text)");
复制代码
```

?/ pythoncode.py包含使用高级库的函数,这些库在JavaScript中没有易于编写的等价物：



```javascript
import nltk # is not in JavaScript
def processParagraph(text):
  ...
  nltk calls
  ...
  return lst # returns a list of strings (will be converted to JavaScript array)js
复制代码
```

最佳答案

您只需要对pythoncode发出ajax请求即可.
您可以使用jquery http://api.jquery.com/jQuery.ajax/执行此操作,或仅使用javascript



```js
$.ajax({
  type: "POST",
  url: "~/pythoncode.py",
  data: { param: text}
}).done(function( o ) {
   // do something
});
复制代码
```

[
  ](http://www.cocoachina.com/brochure/class)