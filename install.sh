#!/usr/bin/env bash

function syncFile() {
    local sourceFile="$1"
    ln -sf "$CWD/${sourceFile}" "$HOME/${sourceFile}"
}

function doSync() {
    syncFile ".gitconfig"
    syncFile ".zshenv"
    return 0
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doSync
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
      doSync
    else
        printf "Skipped.\n\n"
  fi
fi
unset doSync

if [ -f /etc/debian_version ]; then
    # Update
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt update; sudo apt full-upgrade -y; sudo apt autoremove -y
    # Install packages
    sudo apt install -y git zsh exa npm
    # Install pfetch
    git clone https://github.com/dylanaraps/pfetch.git
    sudo install pfetch/pfetch /usr/local/bin/
    ls -l /usr/local/bin/pfetch
    rm -rf pfetch
    # Change shell to zsh
    sudo chsh -s /bin/zsh "$USER"
elif [ -f /etc/arch-release ]; then
    sudo pacman -Syu --noconfirm
    # Install yay
    sudo pacman -S --noconfirm --needed git base-devel && git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -sic && cd .. && rm -rf yay
    # Install pfetch
    yay -S --noconfirm pfetch
    # Install packages
    sudo pacman -S --noconfirm zsh exa npm
    # Change shell to zsh
    sudo chsh -s /bin/zsh "$USER"
fi

# Install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# Change npm global config
mkdir -p ~/.npm/global
export PATH=~/.npm/global/bin:$PATH
npm config set prefix ~/.npm/global

# Install typewritten
npm install --location=global typewritten

# check nodejs installation
if ! which node > /dev/null; then
    read -p "Install nodejs? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [ -f /etc/debian_version ]; then
            sudo apt-get install -y nodejs
        elif [ -f /etc/arch-release ]; then
            sudo pacman -S --noconfirm nodejs
        fi
    fi
fi

# check nvm installation
if [ -d ~/.nvm ]; then
    read -p "Install nvm? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    fi
fi

echo ""
echo "done."