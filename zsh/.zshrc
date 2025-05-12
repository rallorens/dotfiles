ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh

zstyle ':omz:update' mode reminder 

set -o vi
autoload -U compinit; compinit

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias tmuxconf="vim ~/.tmux.conf"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
alias v=vim
alias g=git
alias b="bat --paging=never --style='header,grid'"
alias activate="source venv/bin/activate"
alias tms="~/.local/scripts/tmux-sessionizer"
alias dotFilesInstall="~/personal/.dotfiles/install"

_zoxide_init() {
  eval "$(zoxide init zsh)"
  cd .
}
precmd_functions+=(_zoxide_init)

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

aws-sso-login() {
  PATTERN=${1}
  SELECTED_PROFILE=$(cat ~/.aws/config | awk '/^\[profile/ { gsub(/^\[profile |\]$/, ""); print }' \
    | grep -v '^default$' \
    | fzf-tmux --height 30% --reverse -1 -0 --header 'Select AWS profile' --query "$PATTERN")
  export AWS_PROFILE="$SELECTED_PROFILE"
  aws sso login --profile "$SELECTED_PROFILE"
}

# TODO: nvm not installed
function aws-azure-login() {
  if ! type nvm &>/dev/null; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  fi
  
  nvm exec 14 node "$HOME/aws-azure-login/lib/index.js" "$@"
}

_deferred_setup() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

{
  sleep 0.5
  _deferred_setup
} &!
