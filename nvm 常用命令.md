#             nvm 常用命令

## 常用node版本： 

[nodejs.org/en/download…](https://link.juejin.cn?target=https%3A%2F%2Fnodejs.org%2Fen%2Fdownload%2Freleases)

```scss

nvm ls ：列出所有已安装的 node 版本
nvm ls-remote ：列出所有远程服务器的版本（官方node version list）
nvm list ：列出所有已安装的 node 版本
nvm list available ：显示所有可下载的版本
nvm install stable ：安装最新版 node
nvm install [node版本号] ：安装指定版本 node
nvm uninstall [node版本号] ：删除已安装的指定版本
nvm use [node版本号] ：切换到指定版本 node
nvm current ：当前 node 版本
nvm alias [别名] [node版本号] ：给不同的版本号添加别名
nvm unalias [别名] ：删除已定义的别名
nvm alias default [node版本号] ：设置默认版本
```

如果需要特殊 npm版本下载

```bash
npm install -g npm@<version>
# 例如
npm install -g npm@8.5.3
```

##             nvm 设置国内镜像

 npm_mirror: node_mirror:

```
nvm npm_mirror https://npmmirror.com/mirrors/npm/
nvm node_mirror https://npmmirror.com/mirrors/node/
```
