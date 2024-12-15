
# git clone加速（实测推荐）

Github的重要性就不需要赘述了，但是github的服务器在国外，国内访问速度是非常慢的，下边介绍几种git clone时加速的方法。

## 在git仓库前添加gitclone.com的前缀（推荐）

```bash
# https://github.com/tendermint/tendermint.git
# 将url改为：
git clone https://gitclone.com/github.com/tendermint/tendermint.git
```
## 设置git参数
```bash
git config --global url."https://gitclone.com/".insteadOf https://

git clone https://github.com/tendermint/tendermint.git
```

## 使用cgit工具
```bash
https://github.com/git-cloner/gitcache/releases

cgit clone https://github.com/tendermint/tendermint.git
```

## 使用本地代理
代理可以全局设置，也可以临时设置，具体设置如下：
全局设置：
```
git config --global --unset http.proxy
git config --global http.proxy 'http://127.0.0.1:port'
```

