Get-VirtualDisk | Where-Object {$_.IsManualAttach -eq $true} | Set-VirtualDisk -IsManualAttach $False