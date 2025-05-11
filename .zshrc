# First set Oh My Zsh configurations
export ZSH="$HOME/.config/.oh-my-zsh"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"

source $ZSH/oh-my-zsh.sh

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

export CLICOLOR=1
export LESS="-R -i -g -c -W"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH=$HOME/bin:$PATH
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin
export PATH="$PATH:/Users/rllorens/work"

autoload -U compinit; compinit

set -o vi

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

plugins=(git)

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias tmuxconf="nvim ~/.config/tmux/.tmux.conf"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
alias v=nvim
alias g=git
alias b="bat --paging=never --style='header,grid'"
alias activate="source venv/bin/activate"
# AWS Azure login alias (consider moving to a separate file for work-specific configs)
alias "aws-azure-login=nvm exec 14 node $HOME/aws-azure-login/lib/index.js"

# zoxide
eval "$(zoxide init zsh)"

# Kubectl completion
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

venv() {
  if [ $# -eq 0 ]; then
    echo "Usage: venv <environment_name>"
  else
    python3 -m venv $1
    source $1/bin/activate
  fi
}

aws-sso-login() {
  PATTERN=${1}
  SELECTED_PROFILE=$(cat ~/.aws/config | awk '/^\[profile/ { gsub(/^\[profile |\]$/, ""); print }' \
    | grep -v '^default$' \
    | fzf-tmux --height 30% --reverse -1 -0 --header 'Select AWS profile' --query "$PATTERN")
  export AWS_PROFILE="$SELECTED_PROFILE"
  aws sso login --profile "$SELECTED_PROFILE"
}
