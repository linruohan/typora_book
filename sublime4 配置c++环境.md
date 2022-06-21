# sublime配置c++环境

[toc]

## 准备

[MinGW](https://osdn.net/projects/mingw/releases/#) 或codeblocks

安装sublime text4

## 开始配置

### 环境变量配置

1. path中添加： `D:\software\mingw64\bin\`
2. cmd中输入gcc -v，若出现版本和详细信息，则表明环境加入成功。

### sublime4配置

1. 打开[sublime](https://so.csdn.net/so/search?q=sublime&spm=1001.2101.3001.7020) ，Tools->Build System->New Build System ，粘贴下属内容，ctrl+s保存，重命名myc++（随意）

   ```bash
   {
   	// "shell_cmd": "make"
   	"encoding": "utf-8",
   	"working_dir": "$file_path",
   	"shell_cmd": "g++ -Wall -std=c++0x \"$file_name\" -o \"$file_base_name\"",
   	"file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",
   	"selector": "source.cpp",
   
   	"variants":[
   		{
   			"name": "Run",
   			"shell_cmd": "g++ -Wall -std=c++0x \"$file\" -o \"$file_base_name\" && \"${file_path}/${file_base_name}\""
   		},
   		{
   			"name": "RunInCmd",
   			"shell_cmd": "g++ -Wall -std=c++0x \"$file\" -o \"$file_base_name\" && start cmd /c \"\"${file_path}/${file_base_name}\" & pause \""
   		}
   	]
   }
   ```

2. 任意打开一个c++文件，ctrl+b之后选择runlncmd，
   ![在这里插入图片描述](https://img-blog.csdnimg.cn/2019071321521092.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2dhb2NoZW4xNDEyNzcxMTQ4,size_16,color_FFFFFF,t_70)

#### 设置快捷键

Preferences -> Key Bindings - User

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190713215316887.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2dhb2NoZW4xNDEyNzcxMTQ4,size_16,color_FFFFFF,t_70)

1. 在里面添加`{ "keys": ["ctrl+f9"], "command": "build" },`
2. ctrl+s,保存（我设置快捷键f9，个人可自定义）。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190713215346480.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2dhb2NoZW4xNDEyNzcxMTQ4,size_16,color_FFFFFF,t_70)

3. 在之前打开的c++文件里面按f9，便会运行。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190713215603639.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2dhb2NoZW4xNDEyNzcxMTQ4,size_16,color_FFFFFF,t_70)