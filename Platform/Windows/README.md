# Windows Config
- PowerShell Profile
  将 `Microsoft.PowerShell_profile.ps1`复制到`$PROFILE` （一般是`C:\Users\RealTong\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`）所在的目录下
- Windows Terminal
  将 `WindowsTerminal-profile.json` 复制到`%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\`所在的目录下
- Oh My Posh
  将 `custom-theme.json` 复制到`scoop prefix oh-my-posh` `\current\Themes\` 所在的目录下, 并在`$PROFILE`中添加`Set-PoshPrompt custom`  
- Remote Desktop

- WSL
  - WSL2 开启 Systemd
    1. vim /etc/wsl.conf
    2. 添加以下内容
    ```bash
    [boot]
    systemd=true
    ```
    3. wsl --shutdown

- Docker on Windows 最佳实践
  - 在 WSL2 中安装 Docker
    1. curl -fsSL https://get.docker.com -o get-docker.sh
    2. sudo sh get-docker.sh
    3. sudo usermod -aG docker $USER
    4. sudo apt-get install -yqq docker-compose
    5. sudo service docker start