# 使用curl时如何忽略SSL警告

使用curl命令时，如果ssl是无效或者自签名的，会提示错误，如何忽略这些错误？  
curl命令有没有类似wget命令中的--no-check-certificate选项？
`curl: (60) SSL certificate problem: Invalid certificate chain`这个报错怎么解决？

## 1 curl执行不安全的ssl连接
将-k或--insecure选项传递给curl命令，将使用使用不安全或无效的SSL证书。  
语法如下：
```bash
curl -k url
curl --insecure url
curl --insecure [options] url
curl --insecure -I url
```
### 1.1 curl忽略 SSL 证书警告
禁止curl命令进行证书验证：
`curl --insecure -I https:``//202.54.1.2/`
`curl -k -O https:``//202.54.1.2/file.tar.gz`
## 2 如何允许所有的curl执行不安全的SSL连接？
在$HOME/.curlrc文件中添加`insecure`选项：
```bash
echo insecure > $HOME/.curlrc
```
## 3 CURL如何使用自签名SSL/TLS证书
```bash
curl --cacert /pth/to/my/ca.pem https:`` //url 
curl --header` `'Host: www.onitroad.local'` `--cacert /pth/to/my/ca.pem https:``//207.5.1.10/onitroad.tar.gz
```
