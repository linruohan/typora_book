# [PyQt QTreeWidget节点过滤操作](https://www.cnblogs.com/aloe-n/p/10283831.html)

# QTreeWidget节点过滤操作

## QTreeWidget遍历所有节点

```python
def filter(treeWidget):
    cursor = QTreeWidgetItemIterator(treeWidget)
    while cursor.value():
        print(cursor.value())
        cursor = cursor.__iadd__(1)
```

## QTreeWidget过滤出符合条件的根节点

```python
def filter(w):
    # 获取所有根节点
    all_items = w.findItems("", Qt.MatchStartsWith)
    # 获取符合条件的根节点
    match_items = w.findItems(sb.lineEdit.text(), Qt.MatchStartsWith)
    # 隐藏所有根节点
    for item in all_items:
        item.setHidden(True)
    # 显示符合条件的根节点
    for item in match_items:
        item.setHidden(False)
```

## QTreeWidget过滤出符合条件的所有节点

```python
def filter(treeWidget,text):
    """以text开头作为过滤条件示例"""
    cursor = QTreeWidgetItemIterator(treeWidget)
    while cursor.value():
        item = cursor.value()
        if item.text(0).startswith(text):
            item.setHidden(False)
            # 需要让父节点也显示,不然子节点显示不出来
            try:
                item.parent().setHidden(False)
            except Exception:
                pass
        else:
            item.setHidden(True)

        cursor = cursor.__iadd__(1)
```