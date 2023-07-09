# cobra命令行框架

[toc]

```bash
go get -u github.com/spf13/cobra@latest
```
## cobra命令行项目基本结构
![image-20230708235948337](imgs/image-20230708235948337.png)

![image-20230709080207094](imgs/image-20230709080207094.png)

命令定义方式

![image-20230709080536943](imgs/image-20230709080536943.png)

## cobra命令行本地标志和持久标志

只有命令本身可以用的叫本地标志，自己及其子命令都可以使用的叫持久标志

rootCmd.Flags()本地标志

rootCmd.PersistentFlags() 持久标志

![image-20230709081150181](imgs/image-20230709081150181.png)

![image-20230709081203258](imgs/image-20230709081203258.png)

参数使用

![image-20230709082000683](imgs/image-20230709082000683.png)

![image-20230709081926903](imgs/image-20230709081926903.png)



### 定义配置文件：viper

```bash
go get -u github.com/spf13/viper@latest
```

![image-20230709081705130](imgs/image-20230709081705130.png)

#### config参数使用

![image-20230709082151519](imgs/image-20230709082151519.png)

![image-20230709082225119](imgs/image-20230709082225119.png)

#### viper绑定flags

绑定就是通过命令行参数修改viper对象中的对应值

![image-20230709082542646](imgs/image-20230709082542646.png)

![image-20230709082719396](imgs/image-20230709082719396.png)

![image-20230709082743970](imgs/image-20230709082743970.png)



### 定义子命令

![image-20230709083543475](imgs/image-20230709083543475.png)



![image-20230709082941369](imgs/image-20230709082941369.png)

![image-20230709083245885](imgs/image-20230709083245885.png)

![image-20230709083143653](imgs/image-20230709083143653.png)

### 多级命令

![image-20230709083832651](imgs/image-20230709083832651.png)

![image-20230709083719454](imgs/image-20230709083719454.png)
## cobra命令行参数及参数验证

### 自定义参数检查：数量检查

![image-20230709084449972](imgs/image-20230709084449972.png)

![image-20230709084519743](imgs/image-20230709084519743.png)

![image-20230709084550686](imgs/image-20230709084550686.png)

### 内置参数检查

![image-20230709084746489](imgs/image-20230709084746489.png)

#### onlyargs：只能是某些值

![image-20230709084917693](imgs/image-20230709084917693.png)

![image-20230709085004143](imgs/image-20230709085004143.png)

#### rangeArgs：参数个数 1-10个

![image-20230709085129808](imgs/image-20230709085129808.png)

![image-20230709085151680](imgs/image-20230709085151680.png)

![image-20230709085226885](imgs/image-20230709085226885.png)