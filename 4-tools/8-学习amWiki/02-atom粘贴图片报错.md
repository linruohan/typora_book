## Uncaught TypeError: clipboard.readHtml is not a function #155
 Open	SuperDannyBoy opened this issue on 23 Aug 2019 · 1 comment
Comments
@SuperDannyBoy
SuperDannyBoy commented on 23 Aug 2019
[Enter steps to reproduce:]

```css
//================环境==========
Atom: 1.40.1 x64
Electron: 3.1.10
OS: Mac OS X 10.14.4
Thrown From: amWiki package 1.2.1
```
### 问题

```css
Stack Trace
Uncaught TypeError: clipboard.readHtml is not a function
...
At /Users/superdanny/.atom/packages/amWiki/lib/richPaste.js:28

TypeError: clipboard.readHtml is not a function
    at Object.paste (/packages/amWiki/lib/richPaste.js:28:36)
    at /packages/amWiki/lib/main.js:168:35)
    at CommandRegistry.handleCommandEvent (/Applications/Atom.app/Contents/Resources/app/static/<embedded>:11:349123)
    at CommandRegistry.dispatch (/Applications/Atom.app/Contents/Resources/app/static/<embedded>:11:347598)
    at AtomEnvironment.dispatchApplicationMenuCommand (/Applications/Atom.app/Contents/Resources/app/static/<embedded>:1:718718)
    at EventEmitter.t (/Applications/Atom.app/Contents/Resources/app/static/<embedded>:1:726641)
    at EventEmitter.emit (events.js:182:13)
Commands
     -5:45.2.0 tabs:close-tab (div.title)
     -5:41.8.0 pane:close (ol.tree-view-root.full-menu.list-tree.has-collapsable-children.focusable-panel)
     -5:35.8.0 application:add-project-folder (div.tool-panel.tree-view)
  2x -5:14 amWiki:makeNav (div.tool-panel.tree-view)
  3x -3:04.3.0 amWiki:paste (input.hidden-input)
Non-Core Packages
amWiki 1.2.1 
@Sowari
Sowari commented on 29 Nov 2019

```
### 解决办法

```css
编辑你的/Users/superdanny/.atom/packages/amWiki/lib/richPaste.js第28行
clipboard.readHtml
改成
clipboard.readHTML
```

```html

```

<font color="#478cdc"><i class="fa fa-find">阿斯蒂</i></font>

![image-20200524223117923](D:\Typora_pic\image-20200524223117923.png)