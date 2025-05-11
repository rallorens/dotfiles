#!/bin/bash

# Install Homebrew if needed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install formulae from leaves file
echo "Installing brew packages..."
while read -r package; do
    if ! brew list --formula | grep -q "^${package}$"; then
        echo "Installing $package..."
        brew install "$package"
    else
        echo "$package already installed"
    fi
done < leaves

# Install casks from casks file
echo "Installing cask applications..."
while read -r cask; do
    if ! brew list --cask | grep -q "^${cask}$"; then
        echo "Installing $cask..."
        brew install --cask "$cask"
    else
        echo "$cask already installed"
    fi
done < casks

echo "Brew installation complete!"