eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH="$HOME/.oh-my-zsh"
export CLICOLOR=1
export LESS="-R -i -g -c -W"
export GOPATH="$HOME/go"

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"  # Prepended (higher priority)
export PATH="$HOME/bin:$PATH"                         # Prepended (higher priority)
export PATH="$PATH:$GOPATH/bin"                       # Appended (lower priority)
export PATH="$PATH:$HOME/work"                        # Appended (lower priority)

export EDITOR='vim'