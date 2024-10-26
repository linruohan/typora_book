#  Atom Python 配置专属IDE

[toc]



## ***下载链接\****
> https://atom.io/

## **适合python的插件**

```bash
Hydrogen
MagicPython
activate-power-mode
asciidoc-preview
atom-autocomplete-python
atom-beautify
atom-icons
atom-ide-definitions
atom-ide-hyperclick
atom-python-run
atom-runner
atom-smart-path-autocomplete
atom-vue
atom-vue-router
auto-close-html2
autocomplete
autocomplete-date
autocomplete-module-import
autocomplete-modules
autocomplete-paths
autocomplete-python
busy-signal
color-picker
define-jump
docblockr
docblockr2
file-icons
git-plus
goto-definition
highlight-selected
hyperclick
intentions
language-asciidoc
linter
linter-jshint
linter-pylama
linter-ui-default
markdown-preview-enhanced
pigments
python-autopep8
python-isort
python-tools
script
structure-view
sync-settings
tool-bar
vue-template
```

```bash
# keymap.cson


'atom-text-editor':
    'alt-d': 'tree-view:show-current-file-in-file-manager'
# 上面两行作用是 设置 alt+d 打开当前编辑文件，下面两行为了在没有焦点（不在编辑框）时仍能使用。
'atom-workspace':
    'alt-d': 'tree-view:show-current-file-in-file-manager'

```



> ├── atom-beautify@0.29.11
> ├── atom-python-run@0.5.1
> ├── autocomplete-clang@0.9.4
> ├── autocomplete-modules@1.6.1
> ├── autocomplete-paths@1.0.2
> ├── autocomplete-python@1.8.6
> ├── block-comment-plus@0.4.0
> ├── build@0.65.0
> ├── busy@0.6.0
> ├── file-icons@1.7.19
> ├── git-plus@5.16.2
> ├── highlight-selected@0.11.2
> ├── hyperclick@0.0.37
> ├── language-ini@1.16.0
> ├── linter@1.11.16
> ├── linter-flake8@1.13.4
> ├── linter-gcc@0.6.15
> ├── linter-pylama@0.6.0
> ├── linter-python@3.0.5
> ├── linter-python-pep8@0.2.0
> ├── MagicPython@0.5.15
> ├── platformio-ide@1.4.0
> ├── platformio-ide-terminal@2.2.0
> ├── project-manager@2.9.7
> ├── python-autopep8@0.1.3
> ├── python-debugger@0.1.0
> ├── python-indent@0.4.3
> ├── python-isort@0.0.7
> ├── python-jedi@0.3.7
> ├── python-tools@0.6.8
> ├── python-yapf@0.11.0
> ├── script@3.9.0
> ├── seti-ui@1.3.2
> ├── terminal-plus@0.14.5
> ├── tool-bar@1.0.1
> └── tree-view-finder@0.2.1
>
> 若还需要其他的插件(有插件下载排行)，请点击：Atom 插件排行

## **插件安装**

> Aotm安装时，已经默认安装了apm包管理器，类似于Python的pip，Node.js的npm，
> 开始安装插件，建议不要在Atom 中安装，可能会一直提示失败。
> 推荐使用 ：**apm install packageName**
>
> **例如 在cmd 中输入：apm install script**

## **运行Python文件：**

> **script插件** 是运行代码时使用，安装成功后，可以打开.py文件，快捷键ctrl+shift +b(**Mac cmd + i** ) 运行python代码。

### **插件升级：**

> 插件的初始安装可以使用apm install packageName 安装，之后可以在Atom的 setting→Updates 中升级.

### **插件说明**

> 1：这个暂时就不说了，google 下Atom + 插件名称就可以找到，例如Atom script。
> 2：安装成功以后，可能需要点击setting→package→找到对应的包名，点击setting 设置下。
> 3：打开setting的方法，ctrl+shift+p 输入setting ，一般第一个，回车打开。
> 4：也可以点击file→setting，如果没有主菜单，可以按照3的步骤打开setting后，找到core→
> Auto Hide Menu Bar 取消√

### **备注**

> 需要注意的是，yapf 需要先使用pip install yapf 安装然后再python-yapf的 setting 中设置好path

## ***遇到问题\***

### 突然自动补全不能使用

> 问题：突然自动补全不能使用，google也没找到答案，就一个一个的包设置。
> 解决：最后把python-jedi 禁用了，才有效，不知道什么问题，先记录下。

------

### **2：**provided path doesn’t exist

> 问题：提示
> ![这里写图片描述](https://www.xin3721.com/articlelist/uploads/allimg/201203/16110152X-0.jpg)
>
> 解决
> 安装
> pip install pylama
> apm install linter-pylama
>
> 配置setting →Executeable Path 设置路径 C:/Python27/Scripts/pylama.exe

------

### **3：** 使用ctrl + alt + b 格式化代码，提示如下图

![这里写图片描述](https://www.xin3721.com/articlelist/uploads/allimg/201203/1611012439-1.jpg)

解决:

> pip install autopep8
> pip install isort
> 再重启Atom

------

### git 配置

> settings→package→搜索git plus→点击setting→找到Git path 配置自己电脑安装的git (C:\Program Files\Git\cmd\git.exe)

------

**5：**
报错：
![这里写图片描述](https://www.xin3721.com/articlelist/uploads/allimg/201203/1611015C5-2.jpg)

> 解决：
> pip install python-language-server
