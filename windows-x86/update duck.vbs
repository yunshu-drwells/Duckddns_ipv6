Set objShell = CreateObject("WScript.Shell")
'获取当前目录的路径 '
Dim fso, folder, path 
Set fso = CreateObject("Scripting.FileSystemObject") 
Set folder = fso.GetFolder(".") 
path = folder.Path 
'WScript.Echo path'

'获取当前脚本文件的路径' 
'Dim scriptPath'
'scriptPath = WScript.ScriptFullName'
'WScript.Echo scriptPath'

'拼接路径'
executableBat = "\update_duck.bat"
batchFilePath = path & executableBat
'WScript.Echo batchFilePath'

objShell.Run batchFilePath, 0, True
'命令意义：'
'objShell.Run：使用CreateObject函数创建的WScript.Shell对象调用Run方法来执行批处理文件'
'batchFilePath:批处理文件的绝对路径'
'0隐藏窗口， 1激活并显示窗口'
'True：表示执行完批处理文件后继续执行VBScript代码'