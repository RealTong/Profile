# C:\Users\RealTong\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

$PSDefaultParameterValues = @{'Out-File:encoding'='utf8'}

Import-Module Get-ChildItemColor # scoop install DockerCompletion
Import-Module DockerCompletion # scoop install DockerCompletion
Import-Module posh-git # scoop install "posh-git"
Import-Module Terminal-Icons # scoop install "Terminal-Icons"
Import-Module PSReadLine # scoop install PSReadLine

# 设置预测文本来源为历史记录
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
# 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
# 设置 Tab 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete
# Set-PSReadLineKeyHandler -Chord 'Ctrl+d,Ctrl+c' -Function CaptureScreen

# 使用 Alt+W 将命令保存到 history 但并不执行
Set-PSReadLineKeyHandler -Key Alt+w `
                         -BriefDescription SaveInHistory `
                         -LongDescription "Save current line in history but do not execute" `
                         -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}

#
# Ctrl+Shift+j then type a key to mark the current directory.
# Ctrj+j then the same key will change back to that directory without
# needing to type cd and won't change the command line.

#
$global:PSReadLineMarks = @{}

Set-PSReadLineKeyHandler -Key Ctrl+J `
                         -BriefDescription MarkDirectory `
                         -LongDescription "Mark the current directory" `
                         -ScriptBlock {
    param($key, $arg)

    $key = [Console]::ReadKey($true)
    $global:PSReadLineMarks[$key.KeyChar] = $pwd
}

Set-PSReadLineKeyHandler -Key Ctrl+j `
                         -BriefDescription JumpDirectory `
                         -LongDescription "Goto the marked directory" `
                         -ScriptBlock {
    param($key, $arg)

    $key = [Console]::ReadKey()
    $dir = $global:PSReadLineMarks[$key.KeyChar]
    if ($dir)
    {
        cd $dir
        [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
    }
}

Set-PSReadLineKeyHandler -Key Alt+j `
                         -BriefDescription ShowDirectoryMarks `
                         -LongDescription "Show the currently marked directories" `
                         -ScriptBlock {
    param($key, $arg)

    $global:PSReadLineMarks.GetEnumerator() | % {
        [PSCustomObject]@{Key = $_.Key; Dir = $_.Value} } |
        Format-Table -AutoSize | Out-Host

    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

$env:PYTHONIOENCODING="utf-8"

If (Test-Path Alias:curl) {Remove-Item Alias:curl}
If (Test-Path Alias:curl) {Remove-Item Alias:curl}

function GoBack { Set-Location .. }

function TouchFile {
    if((Test-Path -Path ($args[0])) -eq $false) {
        Set-Content -Path ($args[0]) -Value ($null)
    } else {
        (Get-Item ($args[0])).LastWriteTime = Get-Date 
    }
}

# 设置windows应用主题 # Set-ThemeMode dark 或者 Set-ThemeMode light
function Set-ThemeMode {
    param (
        [string] $Mode,
        [switch] $SystemMode
    )
    $RegPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    # 根据 Mode 参数设置 SystemUsesLightTheme 和 AppsUseLightTheme 的值
    switch ($Mode) {
        "dark" {
            # New-ItemProperty -Path $RegPath -Name "SystemUsesLightTheme" -Value "0" -PropertyType "DWORD" -Force | Out-Null
            New-ItemProperty -Path $RegPath -Name "AppsUseLightTheme" -Value "0" -PropertyType "DWORD" -Force | Out-Null
            Write-Output "应用主题模式已更改为深色模式。"
        }
        "light" {
            # New-ItemProperty -Path $RegPath -Name "SystemUsesLightTheme" -Value "1" -PropertyType "DWORD" -Force | Out-Null
            New-ItemProperty -Path $RegPath -Name "AppsUseLightTheme" -Value "1" -PropertyType "DWORD" -Force | Out-Null
            Write-Output "应用主题模式已更改为亮色模式。"
        }
        default {
            Write-Output "无效的主题模式。请输入 'dark' 或 'light'。"
        }
    }
}

# 设置oh-my-posh主题 # Set-PoshPrompt wopian
function Set-PoshPrompt {
    param (
        [string]$themeName
    )

    $themePath = Join-Path $env:POSH_THEMES_PATH "$themeName.omp.json"

    if (Test-Path $themePath) {
        oh-my-posh init pwsh --config $themePath | Invoke-Expression
    } else {
        Write-Error "Theme file not found: $themePath"
    }
}

function Get-MyIP {
    $wifi = (Get-NetConnectionProfile).Name
    Get-NetAdapter | Where-Object {($_.InterfaceDescription -match 'wireless') -or ($_.InterfaceDescription -match 'ethernet')} |
        ForEach-Object {
            $adapter = $_
            $ipv4 = $adapter | Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' } | Select-Object -First 1
            $ipv6 = $adapter | Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv6' } | Select-Object -First 1

            Write-Output "Adapter: $($adapter.Name)"
            Write-Output "Interface Name: $wifi"
            Write-Output ""
            if ($ipv4) {
                Write-Output "局域网IPv4 Address: $($ipv4.IPAddress)"
            }
            if ($ipv6) {
                Write-Output "局域网IPv6 Address: $($ipv6.IPAddress)"
            }
            
            Write-Output ""
        }
        # 禁用进度条
        $ProgressPreference = 'SilentlyContinue'
        # Get external IPv4 and IPv6 addresses
        $ipv4_external_guonei = Invoke-WebRequest -Uri "https://myip.ipip.net/s" -UseBasicParsing |
            Select-String -Pattern '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' |
            ForEach-Object { $_.Matches.Value }
        $ipv4_external_guowai = (Invoke-WebRequest -Uri "ip.sb").Content.Trim()

        if($ipv4_external_guonei) {
            Write-Output "External IPv4 Address: $($ipv4_external_guonei)"
            $ipinfo_external = Invoke-RestMethod -Uri "https://ip.js.cool/ipip?ip=$ipv4_external_guonei" |
            Select-Object -ExpandProperty data |
            Select-Object -Property country_name, region_name, city_name, ip
            Write-Output "Location: $($ipinfo_external.city_name), $($ipinfo_external.region_name), $($ipinfo_external.country_name)"
        }
        Write-Output ""
        if($ipv4_external_guowai) {
            Write-Output "External IPv4 Address: $($ipv4_external_guowai)"
            $ipinfo_external = Invoke-RestMethod -Uri "https://ip.js.cool/ipip?ip=$ipv4_external_guowai" |
            Select-Object -ExpandProperty data |
            Select-Object -Property country_name, region_name, city_name, ip
            Write-Output "Location: $($ipinfo_external.city_name), $($ipinfo_external.region_name), $($ipinfo_external.country_name)"
        }
        # Enable progress bar
        $ProgressPreference = 'Continue'
}

# 得到github-copilot-cli what-the-shell $args[0] 返回参数, 将结果(结果在--- Command ---下面一行)复制到剪切板
function ?? {
    github-copilot-cli what-the-shell $args[0]
}

function git? {
    github-copilot-cli git-assist $args[0]
}

function gh? {
    github-copilot-cli gh-assist $args[0]
}

function CdAndOpen {
    cd $args[0] ; Invoke-Item .
}
function CdAndCode {
    cd $args[0] ; code .
}
# 用户source 重载配置文件
function Reload-Profile {
    . $PROFILE.CurrentUserCurrentHost
}

Remove-Item Alias:ni -Force -ErrorAction Ignore

# Alias
Set-Alias open Invoke-Item
Set-Alias touch TouchFile
Set-Alias co CdAndOpen
Set-Alias cc CdAndCode
Set-Alias ip Get-MyIP
Set-Alias uuid New-Guid
Set-Alias theme Set-ThemeMode
Set-Alias source Reload-Profile


# Init oh-my-posh theme
Set-PoshPrompt wopian
# Init z.lua
$luaPath = Join-Path (scoop prefix z.lua) 'z.lua'
$luaPath = Resolve-Path $luaPath
iex ($(lua $luaPath --init powershell once enhanced) -join "`n")
