#!/usr/bin/env zsh

DOTFILES="$HOME/dotfiles"
STOW_FOLDERS=(
    ghostty
    git
    nvim
    tmux
    vscode
    zsh
)

pushd $DOTFILES

for folder in "${STOW_FOLDERS[@]}"; do
    echo "Stowing $folder"
    sto -D $folder
    stow -t ~ $folder
done

popd