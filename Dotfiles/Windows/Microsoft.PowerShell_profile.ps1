# Import-Module Get-ChildItemColor
Import-Module oh-my-posh
Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module PSReadLine

Invoke-Expression (& { (lua "C:\Users\RealTong\scoop\apps\z.lua\1.8.16\z.lua" --init powershell) -join "`n" })

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

Remove-Item Alias:ni -Force -ErrorAction Ignore

Set-Alias open Invoke-Item
Set-Alias myip GetMyIp
Set-Alias touch TouchFile
Set-Alias co CdAndOpen
Set-Alias cc CdAndCode
Set-Alias ip ipconfig

Set-Alias uuid New-Guid
Set-PoshPrompt wopian