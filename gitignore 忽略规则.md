# gitignore 忽略规则

[toc]



## 需求：

项目中如日志，临时文件，编译的中间文件等不想提交到代码仓库，

## 忽略规则

这时就要设置相应的忽略规则，来忽略这些文件的提交。在项目根路径添加**.gitignore**文件，内容如下，匹配规则按行从上到下

1. 忽略所有.svn目录   .svn/

3. 忽略所有target目录 target/

5. 忽略所有.idea目录 .idea/

4. 忽略所有.iml文件 *.iml

    ```bash
    .mymetadata
    .checkstyle
    .classpath
    .project
    .class
    .war
    .zip
    .rar
    .idea
    *.iml
    .settings/*
    /indexes/*
    /target/*
    /src/main/webapp/WEB-INF/classes/*
    /src/main/webapp/userfiles/*
    /target/
    /src/main/resources/rebel.xml
    /src/main/resources/jeesite.properties
    ```

| 语法 | 含义                           |
| ---- | ------------------------------ |
| /    | 目录                           |
| *    | 多个字符                       |
| ?    | 单个字符                       |
| []   | 多个可选字符匹配单个字符       |
| !    | 不忽略(跟踪)匹配到的文件或目录 |

详细的规则可以参考[官方英文文档](https://git-scm.com/docs/gitignore)

## gitignore规则不生效

### 现象

不小心在IDE提示是否添加到git时，点了确定，发现管理了.idea、target文件夹，

然后添加.gitignore文件夹，配置了以上规则，但是重新编译后，target的修改在git status**还是显示了修改！？**

![img](https://img2020.cnblogs.com/blog/174493/202112/174493-20211205220722523-176410925.png)

![img](https://img2020.cnblogs.com/blog/174493/202112/174493-20211205220722543-1250273164.png)

==.gitignore只能忽略那些**原来没有被track（之前没有add过）**的文件，如果某些文件已经被纳入了版本管理中，则修改.gitignore是无效的。==

### 解决方案 在目标文件夹下右键 git bash ，即可调出控制台输入命令行：

解决方法就是先把本地缓存删除（改变成未track状态），然后再提交:

```bash
git rm -r --cached target
git rm -r --cached .idea
```

此后不再追踪track这两个文件夹