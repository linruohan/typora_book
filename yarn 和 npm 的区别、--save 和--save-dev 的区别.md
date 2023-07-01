## 1 安装 yarn
```bash
# (1)下载node.js,使用npm安装
npm install -g yarn 
# (2)查看版本
yarn --version
# (3)yarn淘宝源安装
yarn config set registry https://registry.npm.taobao.org -g 
yarn config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass -g
```
## 2 yarn和npm命令对比
| npm                                       | yarn                         | 注释                        |
|-------------------------------------------|------------------------------|---------------------------|
| npm init                                  | yarn init                    | 初始化项目                     |
| npm install                               | yarn                         | 安装全部依赖                    |
| npm install [package] --save                  | yarn add [package]               | 安装某个依赖，保存到 dependencies   |
| npm uninstall [package] --save                | yarn remove [package]            | 移除某个依赖                    |
| npm install [package] --save-dev              | yarn add [package] --dev         | 安装某依赖,保存到 devDependencies |
| npm update [package] --save               | yarn upgrade [package]       | 更新生产环境某个依赖包               |
| npm install [package] --global                | yarn global add [package]        | 全局安装某个依赖                  |
| npm install --save [package]        | yarn add [package]     | 同时下载多个依赖包                 |
| npm install [package]@[version]           | yarn add [package]@[version] | 安装指定版本的包                  |
| npm rebuild                               | yarn install --force         | 重新下载所有包                   |
`yarn`和`npm`可以通过[镜像源工具nrm](https://www.jianshu.com/p/248b626a01cf)互相切换
### 2.1 npm 中 --save 和--save-dev 区别
> `npm5`版本之前，必须要加上`--save`，才会将包记录到`package.json`  
> `npm5`版本之后开始，`--save`是默认值了，可以省略不写
#### 2.1.1 --save 简写 -S 会被记录到 dependencies【生产环境】
| npm                                       | 等同 | yarn                            |
|-------------------------------------------|----|---------------------------------|
| npm i jquery // npm i jquery --save       | =  | yarn add jquery                 |
| npm i jquery -S                           | =  | yarn add jquery -S // yarn 只有简写 |
#### 2.1.2 --save-dev 简写 -D 会被记录到devDependencies【开发环境】
| npm                                          | 等同 | yarn                             |
|----------------------------------------------|----|----------------------------------|
| npm i webpack -D // npm i webpack --save-dev | =  | yarn add webpack -D // yarn 只有简写 |
> `dependencies`:项目依赖，项目实际运行需要的依赖，上线还是需要的，如（`vue，jquery`）  
> `devDependencies`:开发依赖，只在开发时需要的依赖，实际上线不需要的，如（`webpack`）
## 3 yarn对比npm的优点 :
### 3.1 离线模式
> yarn会有一个缓存目录，会缓存以前安装过的软件包，再次安装时就不必从网络下载了，大大加速安装速度。
### 3.2 依赖关系确定性
> 在每一台机器上针对同一个工程安装依赖时，生成的依赖关系顺序和版本是一致的。
### 3.3 网络性能优化
> 下载软件时会优化请求顺序，避免请求瀑布发生
### 3.4 网络回弹
> yarn在某个安装包请求失败时不会导致安装失败，它会自动去尝试重新安装。而npm则会毫不犹豫的失败，导致得再来一次，耗费时间
### 3.5 多注册来源
> 所有的依赖包，不管他被不同的库间接关联引用多少次，安装这个包时，只会从一个注册来源去装，要么是 npm 要么是 bower, 防止出现混乱不一致。
### 3.6 扁平模式
> 对于多个包依赖同一个子包的情况，yarn会尽量提取为同一个包，防止出现多处副本，浪费空间。比如1.2中，yarn会为babel-generator和babel-helper-define-map 创建同一个lodash子依赖，这样就节约一份的空间。