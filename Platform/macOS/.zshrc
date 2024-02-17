# 如果你之前是 bash 用户，你可能需要改变你的 $PATH。
# 导出 PATH=$HOME/bin:/usr/local/bin:$PATH

# oh-my-zsh 的安装路径。
export ZSH=$HOME/.oh-my-zsh
# 设置要加载的主题名称 --- 如果设为 "random"，每次加载 oh-my-zsh 时都会
# 加载一个随机主题。在这种情况下，如果想知道具体加载了哪个主题，运行：echo $RANDOM_THEME
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# 取消注释以下行以使用区分大小写的补全。
# CASE_SENSITIVE="true"

# 取消注释以下行以使用连字符不敏感的补全。
# 必须关闭区分大小写的补全。_ 和 - 将可互换。
# HYPHEN_INSENSITIVE="true"

# 取消注释以下某行以改变自动更新行为
zstyle ':omz:update' mode disabled  # 禁用自动更新
# zstyle ':omz:update' mode auto      # 自动更新而无需询问
# zstyle ':omz:update' mode reminder  # 就只提醒我更新

# 取消注释以下行以改变自动更新频率（以天为单位）。
# zstyle ':omz:update' frequency 13

# 如果粘贴 URLs 和其他文本出现问题，取消注释以下行。
# DISABLE_MAGIC_FUNCTIONS="true"

# 如果你想要禁用 ls 中的颜色，取消注释以下行。
# DISABLE_LS_COLORS="true"

# 如果你想禁用自动设置终端标题，取消注释以下行。
# DISABLE_AUTO_TITLE="true"

# 取消注释以下行以启用命令自动纠错。
# ENABLE_CORRECTION="true"

# 取消注释以下行以在等待补全时显示红点。
# 你也可以将其设置为其他字符串，这样就会显示你设置的字符串，而不是默认的红点。
# 例如：COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# 注意：这个设置可能在 zsh 版本低于 5.7.1 时导致多行提示符出现问题（参见 #5765）
# COMPLETION_WAITING_DOTS="true"

# 如果你想禁用标记未追踪的文件
# 作为 VCS 的脏文件，取消注释以下行。这会使大型仓库的状态检查
# 要快得多。
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# 如果你想更改历史命令输出显示的命令执行时间戳，取消注释以下行。
# 你可以设为以下三种可选格式之一：
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# 或者使用 strftime 函数格式规范设定自定义格式，
# 参见 'man strftime' 了解详情。
# HIST_STAMPS="mm/dd/yyyy"

# 你想要加载哪些插件？
# 标准插件可以在 $ZSH/plugins/ 中找到
# 自定义插件可以添加到 $ZSH_CUSTOM/plugins/
# 例如：plugins=(rails git textmate ruby lighthouse)
# 请注意，过多的插件将会减慢 shell 的启动速度。
plugins=(git sudo z docker extract zsh-autocomplete zsh-autosuggestions fast-syntax-highlighting)

# 用户配置

# export MANPATH="/usr/local/man:$MANPATH"

# 你可能需要手动设置你的语言环境
# export LANG=en_US.UTF-8

# 本地和远程会话的首选编辑器
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# 编译标识
# export ARCHFLAGS="-arch x86_64"

source $ZSH/oh-my-zsh.sh

# Yubikey OpenPGP SSH
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Github-Cpoilot-CLI
eval "$(github-copilot-cli alias -- "$0")"
# GitHub CLI 编辑器
export GH_EDITOR="code --wait"

export PNPM_HOME="/Users/realtong/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# 别名
alias python=python3
alias pip=pip3

 # 清理终端
alias cls="clear"
alias ..="cd .." # 返回上一级
alias 。。="cd .." # 返回上一级
alias ...="cd ../.." # 返回上上级
alias 。。。="cd ../.." # 返回上上级
alias ....="cd ../../.." # 返回上上上级
alias tm="heptapod run"

# 启动 Meta 服务并设置DNS  https://github.com/MetaCubeX/mihomo/issues/248
alias startmeta="networksetup -setdnsservers Wi-Fi 28.0.0.2 && sudo launchctl start sh.wst.meta.service"
# 停止 Meta 服务并清空DNS
alias stopmeta="sudo launchctl stop sh.wst.meta.service && networksetup -setdnsservers Wi-Fi Empty"


mata_service() {
  if [[ $1 == "start" ]]; then
    startmeta
    echo "Meta service started successfully."
  elif [[ $1 == "stop" ]]; then
    stopmeta
    echo "Meta service stopped."
  elif [[ $1 == "status" ]]; then
    service_status=$(sudo launchctl list | grep sh.wst.meta.service)
    if [[ -n $service_status ]]; then
      echo "Meta service is running. PID: $(echo $service_status | awk '{print $1}')"
    else
      echo "Meta service is not running."
    fi
  elif [[ $1 == "restart" ]]; then
    stopmeta
    startmeta
    echo "Meta service restarted successfully."
  else
    echo "Usage: mata_service start | stop | status | restart"
  fi
}

alias meta=mata_service
