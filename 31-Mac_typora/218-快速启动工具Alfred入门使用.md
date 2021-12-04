# 效率人生 MAC必备工具Alfred入门使用

# 前言

- Alfred，想必大家就算没用过也耳闻过。Alfred是一个让你可以丢掉鼠标的神器。Alfred 是 Mac 系统上一款专注于效率提升的著名应用，它能帮你快速打开网页、快速进行自定义搜索、查看剪贴板历史、快速查询单词等等。Alfred 提供的功能虽然很多，但目的只有一个 —— 那就是减少我们工作中的一些重复动作，提升我们的工作效率。
- 从界面上分，Alfred分为`设置界面`和`操作界面`；从功能上分，Alfred分为基本**搜索和快速启动**的功能，以及工使用**自定义插件**的工作流workflow功能。

# 如何获取Alfred

- 从[Alfred官网](https://www.alfredapp.com/)中下载Alfred并安装使用即可.![image-20191211205710399](/xiaohan/typora_book/typora_pic/image-20191211205710399.png)
- 或者从`App Store直接安装`

1. 注意，免费用户只能使用其Features中的功能(即**基本搜索和快速启动应用等功能，其实这已满足非重度使用者日常需求**)；
2. 若要使用Workflows(即自定义插件的工作流)，则需要购买Powerpack才能激活此功能。

- 购买Powerpack后，可以在设置界面的Powerpack子界面中看到下图，表明可以使用Alfred的所有功能，包括工作流。只有购买powerpack后，才能使用workflow。



# 如何打开Alfred

## 打开设置界面

- Alfred启动后，在Mac上方菜单栏上会有其图标，左键点击后选择`Preferences...`即可打开Alfred的设置界面。

- 可以看到Alfred的设置界面主要分为以下几个部分：

  ##### 1. General：通用；

  ##### 2. Features：特性；

  ##### 3. Workflows：工作流；

  ##### 4. Appearance：外观；

  ##### 5. Advanced 增强

  ##### 6. Remote 远程

  ##### 7. Powerpack：查看是否购买Powerpack以及其许可证。

  ##### 8. Usage

## 打开操作界面

- 调出Alfred操作界面的默认热键为`Alt + 空格`。这个可以设置自己习惯的快捷键。

# General（通用界面）

![image-20191211205819775](/xiaohan/typora_book/typora_pic/image-20191211205819775.png) 

- General界面主要是以下三个功能
  1. Startup：是否在系统启动时自启动Alfred。神器，默认勾上，不解释。
  2. Alfred Hotkey：调出Alfred操作界面的热键。默认为**Alt + 空格**。我这里修改为 **cmd + space**
  3. Where are you：你在哪个国家。Alfred内置了常用网站搜索功能，在搜索时打开对应国家的网站。

# Features（特性界面）

![img](/xiaohan/typora_book/typora_pic/webp-20191211204445471)

- Alfred几乎所有搜索功能都在这个界面设置。免费用户(没有购买Powerpack开启Workflows)重点关注的地方了。
- Features包含的所有功能,如上图。 下面详细的介绍具体的使用。

### Default Results（默认结果）

![image-20191211205844635](/xiaohan/typora_book/typora_pic/image-20191211205844635.png)

1. Essentials：可设置搜索“应用程序”、“联系人”、“设置”、“Safari书签”。

2. Extras：可设置搜索“文件夹”、“文本文件”、“压缩文件”、“个人文档目录”、“图片”、“AppleScript”等其他文件。

3. Unintelligent：`Search all file types`搜索所有文件类型。若勾选此项不但影响巡查速度，还混淆默认搜索结果。**Alfred建议用户使用Find+空格+文件名来查询文件或文件夹；使用Open+空格+文件名也可以。**

   ![image-20191211205908756](/xiaohan/typora_book/typora_pic/image-20191211205908756.png) 

   

1. Search Scope：设置Alfred查询时会**搜索的文件夹范围**，可自己添加和删除。

2. Fallbacks：若上面的查询搜索不到结果时，就会调用这里设置的网站或搜索引擎来进行进一步的查询。默认反馈结果为Google、Amazon、Wikipedia网页搜索。

   ![image-20191211205955523](/xiaohan/typora_book/typora_pic/image-20191211205955523.png) 

   - 可点击界面右下角的`+`来添加更多的搜索引擎。

------

- 检索Chrome书签：目前Alfred只可检索Safari的书签，若你想检索Chrome的书签。则需要将Chrome书签导入到Safari中。导入步骤为：**打开Safari -> 菜单【文件】 -> 【导入自】 -> 谷歌Chrome导入书签数据**。
- 检索外置硬盘：添加外置硬盘的根目录或拖动其根目录到**Search Scope**中。

## Web Search（网页搜索）

![image-20191211210019012](/xiaohan/typora_book/typora_pic/image-20191211210019012.png) 

- Keyword为Alfred命令/关键字；DisplayText为此搜索功能的标题；Custom有图标表示这个为用户自定义；Enabled为是否启用。

- Alfred网站搜索的设置，这是本人使用最频繁的功能。在图中可看到Alfred默认设置了很多搜索网站，但几乎都是国外网站，因为天朝特色，很多都是我们用不上，因此需要添加自定义的搜索设置。

  1. 点击右下角的`Add Custom Search`。

  2. 根据下面的示意图在弹出界面中输入对应信息，其中网站图标可忽略，然后保存即可。

  3. 比如我自定义的百度搜索，信息如下：

     1. Search URL为

        

        ```cpp
        https://www.baidu.com/s?wd={query}
        ```

     2. Title为`baidu`。

     3. Keyword为`baidu`。

     4. Validation为`alfredapp`，此项可随意。

        ![image-20191211210042681](/xiaohan/typora_book/typora_pic/image-20191211210042681.png) 

        

  4. 在Alfred上使用刚自定义的百度搜索，输入`baidu+空格+查询内容`，回车即自动打开百度进行搜索。

     ![image-20191211210121980](/xiaohan/typora_book/typora_pic/image-20191211210121980.png) 

- 只要在对应的网站上搜索一次，记下当时的网址，并把具体的搜索内容改为

  ```
  {query}
  ```

  就可以找到我们自定义搜索设置中所需要的

  ```
  Search URL
  ```

  信息了。于是，本人提供我常用的一些自定义搜索配置。

  - 百度：`https://www.baidu.com/s?ie=utf-8&f=8&wd={query}`
  - 简书：`http://www.jianshu.com/search?utf8=%E2%9C%93&q={query}`
  - 淘宝：`http://s.taobao.com/search?oe=utf-8&f=8&q={query}`
  - 京东：`https://search.jd.com/Search?keyword={query}&enc=utf-8&wq={query}`
  - 微信文章：`http://weixin.sogou.com/weixin?type=2&query={query}`
  - stackoverflow：`http://www.stackoverflow.com/search?q={query}`
  - github：`https://github.com/search?utf8=%E2%9C%93&q={query}`
  - maven：`http://mvnrepository.com/search?q={query}`
  - Android API Search：`https://developer.android.com/reference/classes.html#q={query}`

## Clipboard（剪切板）

剪贴板增强工具是我强烈推荐的，提高效率杠杆的。



![img](/xiaohan/typora_book/typora_pic/webp-20191211204445513)

- 开启Alfred的剪切板功能。

- 查看Alfred剪切板历史记录。默认热键为`Command + Alt + C`， 我修改为`Command + L`。

  ![img](/xiaohan/typora_book/typora_pic/webp-20191211204445616)

  

- 清空Alfred剪切板。在Alfred**操作界面**中输入clear。

## 1password

1password一款密码管理工具，这里开启的话，就会直接和1password打通，网页直接打开登录。



![img](/xiaohan/typora_book/typora_pic/webp-20191211204445558)

i

## system

系统命令快捷方式

![img](/xiaohan/typora_book/typora_pic/webp-20191211204445570)

## Terminal / Shell

终端，程序员必用的软件,这里使用系统的终端。我改为iterm2，修改脚本的如下：



```bash
-- This is v0.7 of the custom script for AlfredApp for iTerm 3.1.1+
-- created by Sinan Eldem www.sinaneldem.com.tr

on alfred_script(q)
    if application "iTerm2" is running or application "iTerm" is running then
        run script "
            on run {q}
                tell application \"iTerm\"
                    activate
                    try
                        select first window
                        set onlywindow to true
                    on error
                        create window with default profile
                        select first window
                        set onlywindow to true
                    end try
                    tell the first window
                        if onlywindow is false then
                            create tab with default profile
                        end if
                        tell current session to write text q
                    end tell
                end tell
            end run
        " with parameters {q}
    else
        run script "
            on run {q}
                tell application \"iTerm\"
                    activate
                    try
                        select first window
                    on error
                        create window with default profile
                        select first window
                    end try
                    tell the first window
                        tell current session to write text q
                    end tell
                end tell
            end run
        " with parameters {q}
    end if
end alfred_script
```

演示：



![img](/xiaohan/typora_book/typora_pic/webp-20191211204445625)

# Advanced（高级设置）

- 打开Alfred的设置界面，点击顶部菜单中的Advanced。

  ![img](/xiaohan/typora_book/typora_pic/webp-20191211204445591)

## 配置同步

- 点击`Set sync folder...`设置Alfred配置导出的目录。点击`Reveal in Finder`查看Alfred配置所在的目录。

![img](/xiaohan/typora_book/typora_pic/webp-20191211204445619)

- 只要将Alfred配置导出的目录设置为Dropbox同步目录，就可以实现云同步。

## 下期预告

**workflow与alfred进阶**