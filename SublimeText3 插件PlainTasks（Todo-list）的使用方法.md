# SublimeText3 插件PlainTasks（Todo-list）的使用方法

[toc]



## plaintasks安装

 打开sublime编辑器，通过`ctrl + shift + p`，输入install回车，再输入**plaintasks**回车即可。

## 使用

```bash
创建新文档：ctrl+shif+p 输入tasks: New document
创建新的task：ctrl+i
取消task：alt+c（这个我没弄出效果，尴尬。。。）
完成：ctrl+d
归档：在文档底部按下ctrl+shift+a
漂亮的分割线：--tab
生成统计：ctrl+shift+p   
输入Tasks: Copy Statistics  在文本中粘贴即可显示你的任务完成度
```

## 如果遇到不能显示的字符，可以在配置文件中修改，进度条可以在用户配置文件中加入：

```
"bar_full": "■", // any char
"bar_empty": "☐", // any char
// if you want to avoid Unicode when copy stats — you can define replacements
// e.g. to convert ■■■■■■☐☐☐☐ to [====== ]
"replace_stats_chars": [[" ■", " [="], ["■", "="], ["☐ ", " ] "], ["☐", " "]]
}
```

## 任务的轻重缓急等设置

```bash
c tab —— @critical，用于标注任务重要程序，表示极重要的
h tab —— @high，用于标注任务重要程序
l tab —— @low，用于标注任务重要程序
s tab —— @started ，再按tab键就会插入当前时间，这样当你完成任务时可以知道耗时多少
d tab —— @due() 设置任务期限，格式为@due(year-month-day hour:minute)，以下内容再输入tab即可扩充为这个格式。 
@due(+) —— 明天，同@due( +1) 和 @due( +1d)
@due(+w) —— 一周，同@(due +1)。另外+3w就表示三周
@due(+2:) —— 两小时
@due(+:45) —— 45分钟
@due(+2 12:) —— 两天十二小时
@due(1) —— 下个月一号
@due(5) —— 这个月或者下个月5号，是这个月还是下个月取决当前日期是否大于5
@due(2-3) —— 今年或明年2月3号，取决于当前日期是否大于2月3号
@due(25 23:) —— 这个月或下个月25号，23时，分钟等于当前的分钟
@due(16.1.1 1:1) —— 等于@due(16-01-01 01:01)
```

