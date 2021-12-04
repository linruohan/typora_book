【最新】解决Github网页上图片显示失败的问题

一、问题
比如随便打开一个项目，图片都不能显示了，我头像也没了，真是一个令人伤心的事
F12打开控制台看一哈

### Failed to load resource: net::ERR_CERT_COMMON_NAME_INVALID
去查了一下，博主john-zeng这样解释道：
实际上，可以认为，ERR_CERT_COMMON_NAME_INVALID就是用一个错误的域名访问了某个节点的https资源。导致这个错误的原因，基本是：

### dns污染
host设置错误
官方更新了dns，但是dns缓存没有被更新，导致错误解析。
我觉得像是有点道理，解决方法就粗来了，hin简单，往下看。

## 解决方法
主要思路就是使用本地hosts文件对网站进行域名解析，一般的DNS问题都可以通过修改hosts文件来解决，github的CDN域名被污染问题也不例外，同样可以通过修改hosts文件解决，将域名解析直接指向IP地址来绕过DNS的解析，以此解决污染问题。

### 找到URL
打开github任意未显示图片的网页，使用元素选择器（Ctrl+Shift+C）放在显示不了的图片上，或者在无法显示的图片上右键-检查元素，定位到该图片的标签，那么你得到了它的URL，叫做src属性。
比如介个
在右面把它的网址复制粗来：
https://avatars2.githubusercontent.com/u/15832957?s=60&v=4
### 获取IP地址
得到上述网址以后打开IPAddress.com这个网站，在搜索框输入它的域名，就是https://到com那一部分，俗称二级域名：
avatars2.githubusercontent.com
回车！！！下面你会看到该域名的信息和IP地址：
可以看出IP是：151.101.184.133，并且是2019.05.05最后更新的，alright，那么我们就可以使这个IP和域名映射起来。
（其他如果有挂掉的图片一样使用此方法进行一一映射即可。）

### 修改hosts
具体咋映射呢？修改hosts文件！！！本人使用的是windows系统，所以使用Sublime Text打开：```sh
Windows\System32\drivers\etc\hosts
```
在文件末尾添加：
可以直接选中以下内容复制粘贴，20200328更新

​```sh
140.82.113.3      github.com
140.82.114.20     gist.github.com

151.101.184.133    assets-cdn.github.com
151.101.184.133    raw.githubusercontent.com
151.101.184.133    gist.githubusercontent.com
151.101.184.133    cloud.githubusercontent.com
151.101.184.133    camo.githubusercontent.com
151.101.184.133    avatars0.githubusercontent.com
199.232.68.133     avatars0.githubusercontent.com
199.232.28.133     avatars1.githubusercontent.com
151.101.184.133    avatars1.githubusercontent.com
151.101.184.133    avatars2.githubusercontent.com
199.232.28.133     avatars2.githubusercontent.com
151.101.184.133    avatars3.githubusercontent.com
199.232.68.133     avatars3.githubusercontent.com
151.101.184.133    avatars4.githubusercontent.com
199.232.68.133     avatars4.githubusercontent.com
151.101.184.133    avatars5.githubusercontent.com
199.232.68.133     avatars5.githubusercontent.com
151.101.184.133    avatars6.githubusercontent.com
199.232.68.133     avatars6.githubusercontent.com
151.101.184.133    avatars7.githubusercontent.com
199.232.68.133     avatars7.githubusercontent.com
151.101.184.133    avatars8.githubusercontent.com
199.232.68.133     avatars8.githubusercontent.com
```

然后保存文件就OK了，至于无法保存，没有修改权限，鼠标右键-属性-安全-修改权限；或将hosts文件复制一份，修改之后，复制到原文件夹替换！
## 还可以使用ipconfig/flush对本地DNS缓存进行一次刷新，如果遇到网络异常，可能是DNS缓存的问题，刷新一下，步骤。

### ows开始→运行→输入：CMD 按回车键，打开命令提示符窗口。
再输入： ipconfig /flushdns 回车,执行命令，可以重建本地DNS缓存。
再附上几个命令：
```cmd
ipconfig /displaydns # 显示dns缓存 
ipconfig /flushdns # 刷新DNS记录 
ipconfig /renew # 重请从DHCP服务器获得IP 
```
PS：另外要注意的一点就是，如果图片再次不能显示，只需要及时更新IP就行啦，这波操作不麻烦，你看我头像回来了！！！

