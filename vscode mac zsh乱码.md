# 解决mac下 vscode 打开zsh终端乱码

[![img](imgs/96.jpeg)](https://www.jianshu.com/u/cd005a0818c2)

[Dongz_233](https://www.jianshu.com/u/cd005a0818c2)关注

0.2722019.06.24 00:07:39字数 140阅读 2,554

先打开字体册查找是否已经安装`Meslo LG M for Powerline`字体，没装就装上。
我的终端使用的是 Zsh，并且配置了 Zsh 的一个主题，这个主题需要安装字体来支持箭头效果，在 iTerm2 中我设置了这个字体，但是 VS Code 里这个箭头还是显示乱码，解决方法：

打开 VS Code 的 settings.json 文件，加入下面一行，

```bash
"terminal.integrated.fontFamily": "Meslo LG M for Powerline",
```

这样 VS Code 内置的终端就能正确显示 Zsh 主题的箭头了

