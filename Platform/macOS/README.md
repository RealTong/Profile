# MacOS Config
- Install Homebrew
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```


## Note:
- 禁用 macOS 输入法切换角标
    ```bash
    sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor -dict-add Enabled -bool NO
    ```
- Raycast 替换 Spotlight      https://manual.raycast.com/hotkey

- 使用 Touch ID 认证 sudo
    ```
    sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
    sudo nano /etc/pam.d/sudo_local 
    # 取消 `auth       sufficient     pam_tid.so` 行前面的注释
    ```
