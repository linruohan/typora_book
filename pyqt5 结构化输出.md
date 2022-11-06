# PyQt结构化输出各控件

有时需要通过一个控件寻找另外的控件,这时候就需要明确二者的关系,而Qt没有像浏览器那样可视化的结构,这时候将控件递归打印出来会是比较好的选择.

## 上代码

```python
def walk_items(w, tab=0):
    """调试用,递归打印控件"""
    for i in w.children():
        print(tab * "\t", i)
        walk_items(i, tab=tab + 1)
```

## 输出效果

```xml
 <PyQt5.QtWidgets.QWidget object at 0x000002905BFB4168>
 <PyQt5.QtWidgets.QWidget object at 0x000002905BFB41F8>
	 <PyQt5.QtWidgets.QScrollBar object at 0x000002905BFB4558>
	 <PyQt5.QtWidgets.QBoxLayout object at 0x000002905BFB45E8>
 <PyQt5.QtWidgets.QStyledItemDelegate object at 0x000002905BFB4288>
 <PyQt5.QtWidgets.QHeaderView object at 0x000002905BFB4318>
	 <PyQt5.QtWidgets.QWidget object at 0x000002905BFB45E8>
	 <PyQt5.QtWidgets.QWidget object at 0x000002905BFB4558>
		 <PyQt5.QtWidgets.QScrollBar object at 0x000002905BFB4798>
		 <PyQt5.QtWidgets.QBoxLayout object at 0x000002905BFB4828>
	 <PyQt5.QtWidgets.QWidget object at 0x000002905BFB4678>
		 <PyQt5.QtWidgets.QScrollBar object at 0x000002905BFB4828>
		 <PyQt5.QtWidgets.QBoxLayout object at 0x000002905BFB4798>
	 <PyQt5.QtCore.QItemSelectionModel object at 0x000002905BFB4708>
 <PyQt5.QtCore.QAbstractItemModel object at 0x000002905BFB43A8>
 <PyQt5.QtCore.QItemSelectionModel object at 0x000002905BFB4438>
 <PyQt5.QtWidgets.QWidget object at 0x000002905BFB44C8>
	 <PyQt5.QtWidgets.QScrollBar object at 0x000002905BFB4708>
	 <PyQt5.QtWidgets.QBoxLayout object at 0x000002905BFB45E8>
```