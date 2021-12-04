# QTreeWidgetItem 点击可编辑修改

[ymc0329](https://me.csdn.net/ymc0329) 发布于2012-02-25 14:06:45 收藏

展开

```cpp
QTreeWidgetItem* item = new QTreeWidgetItem(tree);// need to add editable flag, items are not editable by defaultitem->setFlags(item->flags() ¦ Qt::ItemIsEditable);tree->editItem(item, 0);
```



不可修改

item->setFlags(Qt::ItemIsSelectable | Qt::ItemIsUserCheckable | Qt::ItemIsEnabled);





| Constant                  | Value | Description                                       |
| :------------------------ | :---- | :------------------------------------------------ |
| `Qt::NoItemFlags`         | `0`   | It does not have any properties set.              |
| `Qt::ItemIsSelectable`    | `1`   | It can be selected.                               |
| `Qt::ItemIsEditable`      | `2`   | It can be edited.                                 |
| `Qt::ItemIsDragEnabled`   | `4`   | It can be dragged.                                |
| `Qt::ItemIsDropEnabled`   | `8`   | It can be used as a drop target.                  |
| `Qt::ItemIsUserCheckable` | `16`  | It can be checked or unchecked by the user.       |
| `Qt::ItemIsEnabled`       | `32`  | The user can interact with the item.              |
| `Qt::ItemIsTristate`      | `64`  | The item is checkable with three separate states. |

注意：逻辑关系