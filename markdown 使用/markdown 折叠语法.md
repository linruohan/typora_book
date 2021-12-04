Markdown使用技巧总结：代码块折叠
文章目录
1. 代码块折叠

2. 代码块折叠
    源码：

  ```
  <details><summary>CLICK ME</summary>
  <pre><code>Hello world!
  </code></pre></details>
  ```

  

<details><summary>CLICK ME</summary>
<pre><code>Hello world!
</code></pre></details>
说明：

- details：折叠语法标签

- summary：折叠语法展示的摘要

- pre：以原有格式显示元素内的文字是已经格式化的文本


code：指定代码块
------------------------------------------------
版权声明：本文为CSDN博主「i胡说」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/WHEgqing/java/article/details/105405539

## collapsible markdown?

<details 123>
<summary>CLICK ME</summary>
<summary>标签与正文间一定要空一行！！！<summary>
</details>
<summary>标签与正文间一定要空一行！！！</summary>

<details><summary>CLICK ME</summary> <pre><code>Hello world! </code></pre></details>

<table border="1">
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td>January</td>
    <td>$100</td>
  </tr>
</table>