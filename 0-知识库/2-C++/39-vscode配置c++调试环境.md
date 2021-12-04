# vscode 配置C++编译环境（完美版）

置顶  文章标签： [C/C++](https://so.csdn.net/so/search/s.do?q=C/C++&t=blog)[环境配置](https://so.csdn.net/so/search/s.do?q=环境配置&t=blog)[vscode](https://so.csdn.net/so/search/s.do?q=vscode&t=blog) 更多

版权声明：本文为博主原创文章，遵循[ CC 4.0 BY-SA ](http://creativecommons.org/licenses/by-sa/4.0/)版权协议，转载请附上原文出处链接和本声明。本文链接：https://blog.csdn.net/qq_43041976/article/details/88544632

### 文章目录

- [vscode c++ 环境配置](https://blog.csdn.net/qq_43041976/article/details/88544632#vscode_c__1)

- - [完整教程请查看该教程：](https://blog.csdn.net/qq_43041976/article/details/88544632#httpsblogcsdnnetqq_43041976articledetails100542557_3)



# vscode c++ 环境配置

## 完整教程请查看该教程：https://blog.csdn.net/qq_43041976/article/details/100542557

使用MinGW-W64 GCC-8.1.0编译器默认安装目录的配置文件
MinGW-W64 GCC下载地址：[https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/installer/mingw-w64-install.exe](https://sourceforge.net/projects/mingw-w64/files/Toolchains targetting Win32/Personal Builds/mingw-builds/installer/mingw-w64-install.exe)
离线下载地址：https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/
**如果您使用的Vscode版本过老，以下文件中的`"${workspaceFolder}"`可能需要替换为`"${workspaceRoot}"`**
`launch.json`

```json
{
   "version": "0.2.0",
   "configurations": [
       {
           "name": "(gdb) Launch", // 配置名称，将会在启动配置的下拉菜单中显示
           "type": "cppdbg", // 配置类型，这里只能为cppdbg
           "request": "launch", // 请求配置类型，可以为launch（启动）或attach（附加）
           "program": "${workspaceFolder}/${fileBasenameNoExtension}.exe", // 将要进行调试的程序的路径
           "args": [], // 程序调试时传递给程序的命令行参数，一般设为空即可
           "stopAtEntry": false, // 设为true时程序将暂停在程序入口处，一般设置为false
           "cwd": "${workspaceFolder}", // 调试程序时的工作目录，一般为${workspaceRoot}即代码所在目录 workspaceRoot已被弃用，现改为workspaceFolder
           "environment": [],
           "externalConsole": true, // 调试时是否显示控制台窗口，一般设置为true显示控制台
           "MIMode": "gdb",
           "miDebuggerPath": "C:/Program Files (x86)/mingw64/bin/gdb.exe", // miDebugger的路径，注意这里要与MinGw的路径对应
           "preLaunchTask": "g++", // 调试会话开始前执行的任务，一般为编译程序，c++为g++, c为gcc
           "setupCommands": [
               {
                   "description": "Enable pretty-printing for gdb",
                   "text": "-enable-pretty-printing",
                   "ignoreFailures": false
               }
           ]
       }
   ]
}

123456789101112131415161718192021222324252627
tasks.json`
如果遇到找不到文件 比如这样：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190329001215875.png)
把 `"${workspaceFolder}"`替换为 `"\\"`或 `"//"
{
   "version": "2.0.0",
   "command": "g++",
   "args": [
       "-g",
       "${file}",
       "-o",
       "${fileBasenameNoExtension}.exe"
   ], // 编译命令参数
   "problemMatcher": {
       "owner": "cpp",
       "fileLocation": [
           "relative",
           "${workspaceFolder}"
       ],
       "pattern": {
           "regexp": "^(.*):(\\d+):(\\d+):\\s+(warning|error):\\s+(.*)$",
           "file": 1,
           "line": 2,
           "column": 3,
           "severity": 4,
           "message": 5
       }
   }
}
12345678910111213141516171819202122232425
```

`c_cpp_properties.json`
"includepath"设置问题 路径获取获取方法为：cmd——》gcc -v -E -x c++ -
![gcc -v -E -x c++ -](D:\workspace\vscode_space\My_MarkdownBook\Topora_pic\20190314003509862.png)
如果第一种出错请使用第二种

```json
{
    "configurations": [
        {
            "name": "Win32",
            "includePath": [
                "${workspaceRoot}",
                "C:/Program Files (x86)/mingw64/include/**",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include/c++",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include/c++/x86_64-w64-mingw32",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include/c++/backward",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include-fixed",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/../../../../x86_64-w64-mingw32/include"
            ],
            "defines": [
                "_DEBUG",
                "UNICODE",
                "__GNUC__=6",
                "__cdecl=__attribute__((__cdecl__))"
            ],
            "intelliSenseMode": "msvc-x64",
            "browse": {
                "limitSymbolsToIncludedHeaders": true,
                "databaseFilename": "",
                "path": [
                    "${workspaceRoot}",
                    "C:/Program Files (x86)/mingw64/include/**",
                    "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include/c++",
                    "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include/c++/x86_64-w64-mingw32",
                    "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include/c++/backward",
                    "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include",
                    "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include-fixed",
                    "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/../../../../x86_64-w64-mingw32/include"
                ]
            }
        }
    ],
    "version": 4
}
123456789101112131415161718192021222324252627282930313233343536373839
```

第二种

```json
{
    "configurations": [
        {
            "name": "Win32",
            "includePath": [
                "C:/Program Files (x86)/mingw64/include/**",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include/c++",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include/c++/x86_64-w64-mingw32",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include/c++/backward",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/include-fixed",
                "C:/Program Files (x86)/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/8.1.0/../../../../x86_64-w64-mingw32/include"
            ],
            "browse": {
                "limitSymbolsToIncludedHeaders": true,
                "databaseFilename": ""
            }
        }
    ],
    "version": 4
}
123456789101112131415161718192021
```

参考文章：
https://www.cnblogs.com/ggg-327931457/p/9694516.html
https://blog.csdn.net/weixin_40694527/article/details/84251461