# Mac的brew修改国内源

转载[springxf](https://me.csdn.net/weixin_43902730) 发布于2019-03-06 22:53:28 阅读数 5428 收藏

### Mac的brew修改国内源

- - [阿里云](https://blog.csdn.net/weixin_43902730/article/details/88261760#_2)
  - [清华源](https://blog.csdn.net/weixin_43902730/article/details/88261760#_14)



## 阿里云

```
# 替换brew.git
cd "$(brew --repo)"
git remote set-url origin https://mirrors.aliyun.com/homebrew/brew.git
# 替换homebrew-core.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.aliyun.com/homebrew/homebrew-core.git
# 刷新源
brew update
12345678
```

## 清华源

```
# 替换brew.git
cd "$(brew --repo)"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
# 替换homebrew-core.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
# 刷新源
brew update
12345678
```