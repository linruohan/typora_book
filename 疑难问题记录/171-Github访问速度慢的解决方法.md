# Github访问速度慢的解决方法

主要修改的hosts地址为：github.com 和 github.global.ssl.fastly.net 。查看网站对应的IP地址的方法为访问ipaddress网站，输入网址则可查阅到对应的IP地址。

windows下hosts地址：C:\Windows\System32\drivers\etc

ipaddress地址：https://www.ipaddress.com/

当前日期下，我查阅到的IP对应为：

151.101.185.194 github.global.ssl.fastly.net
192.30.253.113 github.com 

修改的Github对应的完整hosts为：

\# Github
192.30.253.113 github.com
151.101.184.133 assets-cdn.github.com
185.199.108.153 documentcloud.github.com
192.30.253.118 gist.github.com
185.199.108.153 help.github.com
192.30.253.120 nodeload.github.com
151.101.184.133 raw.github.com
18.204.240.114 status.github.com
192.30.253.166 training.github.com
192.30.253.112 www.github.com
151.101.185.194 github.global.ssl.fastly.net
151.101.184.133 avatars0.githubusercontent.com
151.101.184.133 avatars1.githubusercontent.com

 

修改完hosts还不会立即生效，你需要刷新DNS缓存，告诉电脑我的hosts文件已经修改了。

输入指令：sudo /etc/init.d/networking restart 即可。

然后，你关闭浏览器再访问github就不会出现速度很慢的现象了。（亲测不关闭浏览器直接访问也可）

 

windows下刷新DNS的方法：

打开CMD

输入ipconfig /flushdns

 