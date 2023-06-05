# 应用 oh-my-posh 主题
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh.json)"

export ZSH=$HOME/.oh-my-zsh

# 留空使用 oh-my-posh 作为主题
ZSH_THEME=""

plugins=(git sudo z docker)

# Aliases
alias python=python3
alias pip=pip3

# homebrew 安装的插件
# 自动建议
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# 高亮
source $HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSH/oh-my-zsh.sh