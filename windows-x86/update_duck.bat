@echo off
del D:\update_duck_ddns_ipv6\powershell.log
del D:\update_duck_ddns_ipv6\updateDuckDdns.log
powershell.exe -ExecutionPolicy Bypass -File "update_duck.ps1"