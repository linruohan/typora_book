
# shell使用random生成随机数

shell带有内置函数RANDOM可以随机生成随机数其范围为：0~32767
```bash
root@sds ~]# echo $RANDOM
27579
[root@sds ~]# echo $RANDOM
31400
[root@sds ~]# echo $RANDOM
19850
```
## 生成个位数
```bash
[root@sds ~]# echo $(($RANDOM%11))
6
[root@sds ~]# echo $(($RANDOM%11))
9
[root@sds ~]# echo $(($RANDOM%11))
3
```
## 生成2~10范围之间的随机数，方法如下：
```bash
[root@sds ~]# echo $(($RANDOM%9+2))
8
[root@sds ~]# echo $(($RANDOM%9+2))
3
[root@sds ~]# echo $(($RANDOM%9+2))
10
[root@sds ~]# echo $(($RANDOM%9+2))
10
[root@sds ~]# echo $(($RANDOM%9+2))
3
[root@sds ~]# echo $(($RANDOM%9+2))
3
```


    s="https://ghproxy.cc/${url}     # [美国 洛杉矶][@yionchiii]
https://ghproxy.net/${url}     # [英国伦敦][ghproxy]
https://gh.ddlc.top/${url}   # [美国 Cloudflare CDN]mtr-static-official]
https://www.ghproxy.cn/${url}   # [美国 Cloudflare CDN] yionchiii]
https://cors.isteed.cc/${url_no_http} # [美国 Cloudflare CDN][@Lufs's]
https://hub.whtrys.space/${url_no_github}     # [美国 Cloudflare CDN][FastGit 群组成员]"
