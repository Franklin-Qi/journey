## Vscode
Win10 vscode vim settings.


## Web References
[geek-docs](https://geek-docs.com/vscode/vscode-tutorials/vs-code-text-editing.html)
[vscode guide](https://code.visualstudio.com/docs/editor/codebasics)

## Vim Extensions Install
**ctrl+shift+x** to search **vim** and install.

Paste and Copy work:
```
*ctrl+shift+p* to search *settings json*

"vim.useSystemClipboard": true,
"vim.useCtrlKeys":true,
```

## Markdown Preview
**ctrl+shift+p** to search **markdown: open preview to the side**.

## Auto Completion
**File**->**Preferences**->**Keyboards Shortcuts** to seach **ctrl+space**
and modify **alt+/**, remember to **Record Keys**(alt+k).


## C/C++ settings
打造codewars可以刷题的vscode，支持vim,比codeblock更便捷。

安装mingw-w64可以参照mingw.md进行安装。

C/C++ 开发和调试环境: https://my.oschina.net/u/3572815/blog/1815643

.vscode/launch.json:
```
{
    // C/C++ 开发和调试环境: https://my.oschina.net/u/3572815/blog/1815643
    "version": "0.2.0",
    "configurations": [
        {
            "name": "C/C++",
            "type": "cppdbg",
            "request": "launch",
            "program": "${fileDirname}/${fileBasenameNoExtension}.exe",
            "args": [],
            "stopAtEntry": false,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": true,
            "MIMode": "gdb",
            "miDebuggerPath": "C:/msys64/usr/bin/gdb.exe",
            "preLaunchTask": "gcc", //for gcc
            //"preLaunchTask": "gcc", //for g++
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ],
        },
    ]
}
```

.vscode/tasks.json:
```
{
    "version": "2.0.0",
    "command": "gcc", //for gcc
    //"command": "g++", //for g++
    "args": [
        "-g",
        "${file}",
        "-o",
        "${fileDirname}/${fileBasenameNoExtension}.exe"
    ],
    "problemMatcher": {
        //"owner": "cpp", //for g++
        "owner": "c", //for gcc
        "fileLocation": [
            "relative",
            "${workspaceRoot}"
        ],
        "pattern": {
            "regexp": "^(.*):(\\d+):(\\d+):\\s+(warning|error):\\s+(.*)$",
            "file": 1,
            "line": 2,
            "column": 3,
            "severity": 4,
            "message": 5
        }
    },
    "group": {
        "kind": "build",
        "isDefault": true
    }
}
```

两种方式进行编译:
1. 通过ctrl+~ 打开终端进行调试
PS C:\Users\yusq\Desktop\codewars> gcc .\test.c -o .\test.exe
PS C:\Users\yusq\Desktop\codewars> .\test.exe
hello world
请按任意键继续. . .
PS C:\Users\yusq\Desktop\codewars>

2. 通过F5直接进行调试，但需要防止窗口闪退

    system("pause"); //防止窗口闪退, 或末尾加上一个或两个getchar()；


## keyboard shutcuts
文件搜索  ctrl+p  + %s
