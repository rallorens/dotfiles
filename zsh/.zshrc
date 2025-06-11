export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="simple"
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
plugins=(git)

zstyle ':omz:update' mode reminder 

set -o vi

autoload -U compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

export CLICOLOR=1
export LESS="-R -i -g -c -W"
export GOPATH="$HOME/go"
export EDITOR='vim'
# Exposing Docker-compatible API so existing Docker tools/scripts work unchanged.
export DOCKER_HOST="unix://$HOME/.local/share/containers/podman/machine/podman-machine-default/podman.sock"

source $ZSH/oh-my-zsh.sh

alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
alias v=vim
alias g=git
alias k="kubectl"
alias b="bat --paging=never --style='header,grid'"
alias activate="source venv/bin/activate"
alias tms="~/.local/scripts/tmux-sessionizer"
alias aws-sso-login="source ~/.local/scripts/aws-sso-login"
alias dotFilesInstall="~/personal/.dotfiles/install"
alias docker="podman"

function kubectl() {
  if ! type __start_kubectl >/dev/null 2>&1; then
    source <(command kubectl completion zsh)
  fi
  command kubectl "$@"
}

venv() {
  if [ $# -eq 0 ]; then
    echo "Usage: venv <environment_name>"
  else
    python3 -m venv $1
    source $1/bin/activate
  fi
}


# TODO: nvm not installed
function aws-azure-login() {
  if ! type nvm &>/dev/null; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  fi
  
  nvm exec 14 node "$HOME/aws-azure-login/lib/index.js" "$@"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

path_append() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$PATH:$1"
    fi
}

path_remove() {
    PATH=$(echo $PATH | sed -e "s|:$1:|:|g" -e "s|^$1:||g" -e "s|:$1$||g" -e "s|^$1$||g")
}

path_prepend() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    else
        path_remove "$1"
        PATH="$1:$PATH"
    fi
}

# Setup Homebrew (this adds homebrew paths automatically)
eval "$(/opt/homebrew/bin/brew shellenv)"
path_prepend "/opt/homebrew/opt/openjdk@17/bin"
path_prepend "$HOME/bin"                         

path_append "$HOME/.local/scripts"
path_append "$GOPATH/bin"