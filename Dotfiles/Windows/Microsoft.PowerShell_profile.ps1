Import-Module Get-ChildItemColor
Import-Module oh-my-posh
Import-Module posh-git

$env:PYTHONIOENCODING="utf-8"
# Remove curl alias
If (Test-Path Alias:curl) {Remove-Item Alias:curl}
If (Test-Path Alias:curl) {Remove-Item Alias:curl}
# Remove-Item alias:ls -force
Set-Alias ls Get-ChildItemColor -option AllScope
Set-Alias ll Get-ChildItemColorFormatWide -option AllScope
Set-Alias la Get-ChildItemColorFormatWide -option AllScope

function GoBack { Set-Location .. }

function GetMyIp { 
    curl -L tool.lu/ip
}


function TouchFile {
    if((Test-Path -Path ($args[0])) -eq $false) {
        Set-Content -Path ($args[0]) -Value ($null)
    } else {
        (Get-Item ($args[0])).LastWriteTime = Get-Date 
    }
}

function QueryDNS { 
    if($args[1] -eq "ali"){
        nslookup $args[0] 223.5.5.5 
    }elseif($args[1] -eq "gg"){
        nslookup $args[0] 8.8.8.8
    }elseif($args[1] -eq "cf"){
        nslookup $args[0] 1.1.1.1
    }elseif($args[1] -eq "114"){
        nslookup $args[0] 114.114.114.114
    }else{
        nslookup $args[0] $args[1]
    }
}
function CdAndOpen {
    cd $args[0] ; Invoke-Item .
}
function CdAndCode {
    cd $args[0] ; code .
}
# $DefaultUser = 'WULANREN'

# 设置别名
Set-Alias open Invoke-Item
Set-Alias myip GetMyIp
Set-Alias touch TouchFile
Set-Alias dns QueryDNS
Set-Alias co CdAndOpen
Set-Alias cc CdAndCode

# Set-PoshPrompt gmay
# Set-PoshPrompt honukai
Set-PoshPrompt wopian

Set-Alias uuid New-Guid
