# QTreeWidget的使用方法及设置列表项不可选和编辑
原创WANGZHEN` 最后发布于2018-02-01 13:50:53 阅读数 1919  收藏
展开
 使用到QTreeWidget做总结，以便下次使用。

```c#
QTreeWidget CalibrationWidget = new QTreeWidget;
CalibrationWidget->setColumnCount(2); //将treewidget设置为两列
CalibrationWidget->setColumnWidth(0, 155); //设置指定列宽
CalibrationWidget->setItemsExpandable(true); //设置默认为展开
QStringList m_header;
m_header<<QString("名称")<<QString("值"); 
CalibrationWidget->setHeaderLabels(m_header); //设置标题头
QStringList dynamic;
dynamic<<QString("动态测试");
dynamicItem = new QTreeWidgetItem(CalibrationWidget, dynamic); //添加列表项
```



```C#
//1、删除所有子列表项
QList<QTreeWidgetItem *> QTreeWidgetItem::takeChildren() //删除所有子列表项
// Removes the list of children and returns it, otherwise returns an empty list.
2、删除指定子列表项
void QTreeWidgetItem::removeChild(QTreeWidgetItem * child) //删除指定子列表项 
//Removes the given item indicated by child. The removed item will not be deleted.
3、删除指定索引的子列表项
QTreeWidgetItem * QTreeWidgetItem::takeChild(int index) //删除指定索引的子列表项
// Removes the item at index and returns it, otherwise return 0.
4、添加子列表项
void QTreeWidgetItem::addChild(QTreeWidgetItem * child) //添加子列表项 
//Appends the child item to the list of children.
5、添加多条子列表项
void QTreeWidgetItem::addChildren(const QList<QTreeWidgetItem *> & children) //添加多条子列表项 
//Appends the given list of children to the item.
6、设置treewidget字体样式及treewidget头字体样式
QTreeWidget->setFont(QFont("微软雅黑", 12, QFont::Normal, false));
QTreeWidget->headerItem()->setFont(0, QFont("微软雅黑", 12, QFont::Normal, false));//设置treewidget头字体格式
```

