# lazygit

[toc]

## 1 lazygit下载（delta）和配置：

```bash
#下载lazygit https://github.com/jesseduffield/lazygit
lazygit_0.31.4_Linux_x86_64.tar.gz
#下载delta：https://github.com/dandavison/delta#installation
delta-0.10.2-x86_64-unknown-linux-gnu.tar.gz 
```

## 2 lazygit使用

![image-20210620214509768](imgs/image-20210620214509768.png)
## 3 文件面板
### 3.1 x帮助信息

![image-20210620214538135](imgs/image-20210620214538135.png)

### 3.2 这次提交内容添加到上次的提交中

![image-20210620214840420](imgs/image-20210620214840420.png)

### 3.3 编辑器编写变更记录

![image-20210620214908719](imgs/image-20210620214908719.png)

### 3.4 d删除更改

![image-20210620215019289](imgs/image-20210620215019289.png)
## 4 分支面板

### 4.1 创建新分支 n

![image-20210620215328239](imgs/image-20210620215328239.png)

### 4.2 空格切换分支

![image-20210620215344138](imgs/image-20210620215344138.png)

### 4.3 发布分支 P

![image-20210620215419220](imgs/image-20210620215419220.png)

### 4.4 合并其他分支

切换到分支,选中要合入的分支,M 就会合并到当前分支

![image-20210620215929567](imgs/image-20210620215929567.png)

### 4.5 本地 远端 标签跳转 []

![image-20210620220018799](imgs/image-20210620220018799.png)

## 5 stash面板

### 5.1 stash隐藏修改 s

### 5.2 g pop并删除该隐藏的内容

![image-20210620215605301](imgs/image-20210620215605301.png)

### 5.3 空格 恢复隐藏的内容,并保留隐藏的记录

### 5.4 d 删除该隐藏

## 6 提交面板

### 6.1 d删除该项提交  回滚

![image-20210620220117671](imgs/image-20210620220117671.png)

### 6.2 ,.翻页  <> 到最顶/底端

![image-20210620220223456](imgs/image-20210620220223456.png)

![image-20210620220307703](imgs/image-20210620220307703.png)

### 6.3 /搜索

![image-20210620220336614](imgs/image-20210620220336614.png)

### 6.4 r 修改未push的commit message,R 在编辑器中修改

如果已经push,需要重新force push

![image-20210620220434099](imgs/image-20210620220434099.png)

### 6.5 空格选中一次提交就可以 checkout 提交

![image-20210620220557917](imgs/image-20210620220557917.png)

### 6.6 重置 g	

![image-20210620220737600](imgs/image-20210620220737600.png)

1. soft 提交会消失,修改的文件会保留

![image-20210620220759291](imgs/image-20210620220759291.png)

2. hard  删掉所有的之前的分支,不保留修改的文件

### 6.7 reflog

选中要撤销的操作的之前的一条记录,回车

![image-20210620220943270](imgs/image-20210620220943270.png)

### 6.8 复制提交到另一个分支

c复制一个commit,切换到另一个分支, 进入commit面板 v粘贴复制的commit

![image-20210620221243386](imgs/image-20210620221243386.png)

### 6.9 d 删除未push的提交 

### 6.10 一次修改的内容部分挪到上次的提交中

![image-20210620221537450](imgs/image-20210620221537450.png)

1. 进入错误的提交记录中,选中错误行,生成patch

![image-20210620221622627](imgs/image-20210620221622627.png)

2. 选中要加入的commits中 ctrl + p,选中第二项

![image-20210620221938275](imgs/image-20210620221938275.png)

![image-20210620221959394](imgs/image-20210620221959394.png)

![image-20210620222026014](imgs/image-20210620222026014.png)

![image-20210620222034467](imgs/image-20210620222034467.png)

### 6.11 压缩提交,两次提交合二为一

选中上一个, s 把下一个合入到当前commit中,修改信息也会合并

![image-20210620222141551](imgs/image-20210620222141551.png)

选中一个commit, f fixup,会合入到下一个commit中,提交信息不会保留,使用的是下面的commit信息

![image-20210620222222724](imgs/image-20210620222222724.png)

## 7 合并冲突

上下选择要那个, 空格选中, b都保留

左右冲突间跳转

![image-20210620223010561](imgs/image-20210620223010561.png)

![image-20210620223117193](imgs/image-20210620223117193.png)

## 8 查看文件历史

![image-20210620223230725](imgs/image-20210620223230725.png)

![image-20210620223251161](imgs/image-20210620223251161.png)

## 9 两次提交对比

![image-20210620223429407](imgs/image-20210620223429407.png)

![image-20210620223437221](imgs/image-20210620223437221.png)

![image-20210620223512769](imgs/image-20210620223512769.png)

查询文件历史中也可以使用



![image-20210620223548983](imgs/image-20210620223548983.png)

![image-20210620223616666](imgs/image-20210620223616666.png)

## 10 不同的位置打开lazygit

ranger

![image-20210620223710823](imgs/image-20210620223710823.png)

命令行

![image-20210620223742684](imgs/image-20210620223742684.png)

![image-20210620223833906](imgs/image-20210620223833906.png)

ctrl + G 打开lazygit

![image-20210620223803427](imgs/image-20210620223803427.png)

编辑器vim

![image-20210620224055708](imgs/image-20210620224055708.png)

## 11 配置lazygit

![image-20210620224143002](imgs/image-20210620224143002.png)

![image-20210620224332526](imgs/image-20210620224332526.png)

自定义预览窗口

![image-20210620224553526](imgs/image-20210620224553526.png)

![image-20210620224616615](imgs/image-20210620224616615.png)

![image-20210620224623511](imgs/image-20210620224623511.png)

![image-20210620224646141](imgs/image-20210620224646141.png)
## 12 Tmux 悬浮 lazygit 功能实现
如果有用tmux的话，可以使用tmux的display-popup功能达到一样的效果：
bind g display-popup -E -d "#{pane_current_path}" -w 100% -h 100% "lazygit"
