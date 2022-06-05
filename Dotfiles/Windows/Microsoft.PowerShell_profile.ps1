Import-Module Get-ChildItemColor
Import-Module posh-git
Import-Module oh-my-posh

$env:PYTHONIOENCODING="utf-8"
# Remove curl alias
If (Test-Path Alias:curl) {Remove-Item Alias:curl}
If (Test-Path Alias:curl) {Remove-Item Alias:curl}
# Remove-Item alias:ls -force
Set-Alias l Get-ChildItemColor -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

function GoBack { Set-Location .. }

function GetMyIp { curl -L tool.lu/ip }

# $DefaultUser = 'WULANREN'

# 设置别名
Set-Alias open Invoke-Item
Set-Alias .. GoBack
Set-Alias myip GetMyIp

Set-Alias idea "C:\Program Files\JetBrains\apps\IDEA-U\ch-0\213.6777.52\bin\idea64.exe"
Set-Alias webstorm "C:\Program Files\JetBrains\apps\WebStorm\ch-0\213.6777.57\bin\webstorm64.exe"
Set-Alias goland "C:\Program Files\JetBrains\apps\Goland\ch-0\213.6777.51\bin\goland64.exe"
Set-Alias datagrip "C:\Program Files\JetBrains\apps\datagrip\ch-0\213.6777.22\bin\datagrip64.exe"

# Set-PoshPrompt gmay
# Set-PoshPrompt honukai
Set-PoshPrompt wopian
