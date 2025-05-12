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

eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH="$HOME/.oh-my-zsh"
export CLICOLOR=1
export LESS="-R -i -g -c -W"
export GOPATH="$HOME/go"

path_prepend "/usr/local/bin"
path_prepend "/opt/homebrew/opt/openjdk@17/bin"
path_prepend "$HOME/bin"                         
path_prepend "/opt/homebrew/bin"
path_prepend "/opt/homebrew/sbin"

path_append "$HOME/.local/scripts"
path_append "$GOPATH/bin"                       
path_append "$HOME/work"                       

export EDITOR='vim'