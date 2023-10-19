# 定义要执行的可执行程序路径
#$executablePath = "D:\update_duck_ddns_ipv6\update.exe"
# 改为相对路径
# 获取当前路径
$currentPath = $PWD
$executableFile = "\update.exe"
$executablePath = -Join($currentPath, $executableFile)

# 定义循环执行的次数
$loopCount = 10080  # 您可以根据需要更改此值

# 定义每次执行之间的等待时间（秒）
$interval = 180  # 例如，每3分钟执行一次，您可以根据需要更改此值

# 定义日志文件路径
# $logFilePath = "D:\update_duck_ddns_ipv6\powershell.log"
$logFilePath = ".\powershell.log"

# 启动日志记录
Start-Transcript -Path $logFilePath

# 循环执行可执行程序
for ($i = 1; $i -le $loopCount; $i++) {
    # 执行可执行程序
    Start-Process -FilePath $executablePath -Wait
    
    # 记录执行次数和时间戳到日志
    $logMessage = "times: $i - date: $(Get-Date)"
    Write-Output $logMessage

    # 等待一段时间后再次执行（以秒为单位）
    Start-Sleep -Seconds $interval
}

# 停止日志记录
Stop-Transcript