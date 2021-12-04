![image-20200428225558234](D:\Typora_pic\image-20200428225558234.png)

![image-20200428225701816](D:\Typora_pic\image-20200428225701816.png)

![image-20200428230244111](D:\Typora_pic\image-20200428230244111.png)

![image-20200428230506108](D:\Typora_pic\image-20200428230506108.png)

![image-20200428230717142](D:\Typora_pic\image-20200428230717142.png)

![image-20200428230950987](D:\Typora_pic\image-20200428230950987.png)

## 列表操作

![image-20200428231038992](D:\Typora_pic\image-20200428231038992.png)

![image-20200428231309308](D:\Typora_pic\image-20200428231309308.png)

![image-20200428231515463](D:\Typora_pic\image-20200428231515463.png)

删除列表websites中 1个 值为baidu

![image-20200428231602026](D:\Typora_pic\image-20200428231602026.png)

正值从头开始删除,-1从结束位置开始删除

![image-20200428231721596](D:\Typora_pic\image-20200428231721596.png)

## 集合操作

数据不能重复,无序

![image-20200428231837708](D:\Typora_pic\image-20200428231837708.png)

![image-20200428231948487](D:\Typora_pic\image-20200428231948487.png)

![image-20200428232233955](D:\Typora_pic\image-20200428232233955.png)

## 哈希操作

![image-20200428232414381](D:\Typora_pic\image-20200428232414381.png)

![image-20200428232458593](D:\Typora_pic\image-20200428232458593.png)

![image-20200428232646881](D:\Typora_pic\image-20200428232646881.png)

![image-20200428232739763](D:\Typora_pic\image-20200428232739763.png)

## 事务操作

![image-20200428232841216](D:\Typora_pic\image-20200428232841216.png)

![image-20200428232943367](D:\Typora_pic\image-20200428232943367.png)![image-20200428233015707](D:\Typora_pic\image-20200428233015707.png)

监听时如果值改变,事务就会取消执行

![image-20200428233133294](D:\Typora_pic\image-20200428233133294.png)

![image-20200428233228449](D:\Typora_pic\image-20200428233228449.png)

## 发布和订阅

![image-20200428233319291](D:\Typora_pic\image-20200428233319291.png)

![image-20200428233350083](D:\Typora_pic\image-20200428233350083.png)![image-20200428233409374](D:\Typora_pic\image-20200428233409374.png)

订阅多个频道

![image-20200428233425226](D:\Typora_pic\image-20200428233425226.png)

![image-20200428233444063](D:\Typora_pic\image-20200428233444063.png)

## 数据持久化机制

![image-20200428234817622](D:\Typora_pic\image-20200428234817622.png)

![image-20200428235047513](D:\Typora_pic\image-20200428235047513.png)

配置文件![image-20200428233632666](D:\Typora_pic\image-20200428233632666.png)

### RDB机制

---



![image-20200428233644313](D:\Typora_pic\image-20200428233644313.png)

在900 秒内出现1次数据写操作,就同步数据

数据库存在的目录:

![image-20200428233842099](D:\Typora_pic\image-20200428233842099.png)

修改后需要重启redis服务,才生效

![image-20200428233920745](D:\Typora_pic\image-20200428233920745.png)

![image-20200428234019842](D:\Typora_pic\image-20200428234019842.png)

数据存储:键值对,经过压缩

![image-20200428234733920](D:\Typora_pic\image-20200428234733920.png)

### AOF机制

---

![image-20200428234225544](D:\Typora_pic\image-20200428234225544.png)

![image-20200428234405825](D:\Typora_pic\image-20200428234405825.png)

保存数据的文件名

![image-20200428234425671](D:\Typora_pic\image-20200428234425671.png)

同步机制:![image-20200428234519364](D:\Typora_pic\image-20200428234519364.png)

![image-20200428234629256](D:\Typora_pic\image-20200428234629256.png)![image-20200428234800599](D:\Typora_pic\image-20200428234800599.png)

## 安全

![image-20200428235213996](D:\Typora_pic\image-20200428235255288.png)

设置配置文件中的密码![image-20200428235337976](D:\Typora_pic\image-20200428235337976.png)![image-20200428235343944](D:\Typora_pic\image-20200428235343944.png)

![image-20200428235307660](D:\Typora_pic\image-20200428235307660.png)

连接时设置密码

![image-20200428235427306](D:\Typora_pic\image-20200428235427306.png)

![image-20200428235457524](D:\Typora_pic\image-20200428235457524.png)

## 其他机器链接redis

设置允许远程链接 ==增加远程IP== 配置文件

![image-20200428235626707](D:\Typora_pic\image-20200428235626707.png)

![image-20200428235647306](D:\Typora_pic\image-20200428235647306.png)

![image-20200428235658726](D:\Typora_pic\image-20200428235658726.png)

## python操作redis

![image-20200428235820157](D:\Typora_pic\image-20200428235820157.png)

![image-20200429000104792](D:\Typora_pic\image-20200429000104792.png)

![image-20200429000129058](D:\Typora_pic\image-20200429000129058.png)

![image-20200429000222684](D:\Typora_pic\image-20200429000222684.png)

![image-20200429000452824](D:\Typora_pic\image-20200429000452824.png)

![image-20200429000240346](D:\Typora_pic\image-20200429000240346.png)![image-20200429000250829](D:\Typora_pic\image-20200429000250829.png)

![image-20200429000343066](D:\Typora_pic\image-20200429000343066.png)

![image-20200429000821288](D:\Typora_pic\image-20200429000821288.png)

![image-20200429000701637](D:\Typora_pic\image-20200429000701637.png)