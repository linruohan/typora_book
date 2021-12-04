# [sublime3自定义快捷键运行python,支持input()函数](https://www.cnblogs.com/aloe-n/p/6947827.html)

总则:作为一款轻量级产品,sublime在看代码时是非常爽的,但是通过<tool--build>运行时会出现input()函数无法读取数据的问题.以下方法解决了input()问题,并为运行.py文件和交互环境自定义快捷键.

1. 安装SublimeREPL插件;

2. 安装完成之后,点击<Tools--SublimeREPL--Python--Python-RUN current file>就可以运行.py文件(如果没有可运行的文件会报错);点击<Tools--SublimeREPL--Python--Python>就可以打开Python交互环境;但是这样明显违背我们追求便捷的本意,所以接下来要为上面的两个命令添加快捷键;

3. 打开<Preferences--Brower Packages>,在弹出的文件夹中打开\SublimeREPL\config\Python文件夹,打开Default.sublime-commands文件,这里可以看得到步骤2中的两个命令的模块;

   [![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

   ```
   [
       {　　//这个为运行Python交互环境的模块
           "caption": "SublimeREPL: Python",
           "command": "run_existing_window_command", "args":
           {
               "id": "repl_python",
               "file": "config/Python/Main.sublime-menu"
           }
       },
   
   
       {
           "caption": "SublimeREPL: Python - PDB current file",
           "command": "run_existing_window_command", "args":
           {
               "id": "repl_python_pdb",
               "file": "config/Python/Main.sublime-menu"
           }
       },
   
       
       {   // 这个是运行.py文件的模块
           "caption": "SublimeREPL: Python - RUN current file",
           "command": "run_existing_window_command", "args":
           {
               "id": "repl_python_run",
               "file": "config/Python/Main.sublime-menu"
           }
       },
   
   
       {
           "command": "python_virtualenv_repl",
           "caption": "SublimeREPL: Python - virtualenv"
       },
   
       
       {
           "caption": "SublimeREPL: Python - IPython",
           "command": "run_existing_window_command", "args":
           {
               "id": "repl_python_ipython",
               "file": "config/Python/Main.sublime-menu"
           }
       }
   ]
   ```

   [![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

    

4. 打开<Preferences--Key Bindings>,将3中两个模块的内容复制到User一栏,并添加自定义快捷键.如代码所示

   [![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

   ```
   [       
       {        
        "keys": ["f5"],//这一行是自己设的快捷键,其它为复制的棕色字体部分  
               
           "caption": "SublimeREPL: Python",
           "command": "run_existing_window_command", "args":
           {
               "id": "repl_python",
               "file": "config/Python/Main.sublime-menu"
           }
       }  ,
   
       {
           "keys": ["f4"],//这一行是自己设的快捷键,其他为复制的棕色字体部分 
           "caption": "SublimeREPL: Python - RUN current file",
           "command": "run_existing_window_command", "args":
           {
               "id": "repl_python_run",
               "file": "config/Python/Main.sublime-menu"
           }
       }
   
   ]     
   ```

   [![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

   到这里就搞定了,关闭打开的文件,测试下,怎么样,F4和F5是不是已经可以用了呢.再次强调,没有可执行的.py文件的话F5运行会报错.