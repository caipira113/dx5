# zplug (aur)
source ~/.zplug/init.zsh

# Colorize older terminal apps (like man)
# Start blinking
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
# Start bold
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # green
# Start stand out
export LESS_TERMCAP_so=$(tput bold; tput setaf 3) # yellow
# End standout
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# Start underline
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 1) # red
# End bold, blinking, standout, underline
export LESS_TERMCAP_me=$(tput sgr0)

# aliases
alias ls='exa --long --header --icons --sort=type'
alias l="ls"
alias ll="ls -al"
alias tree='exa --tree --level 3'
alias sdn="sudo shutdown -h now" # Quick shutdown
alias cp="cp -i" # Confirm before overwriting something
alias pkg="yay -Q | fzf"
alias yt='yt-dlp --add-metadata -i'
alias reset='reset ; source ~/.zshrc'
alias cls='clear'

# load the good parts from oh-my-zsh
# zsh auto completion
zplug "lib/completion",      from:oh-my-zsh
# setups up histoyr
zplug "lib/history",         from:oh-my-zsh
# Color highlighting in terminal
zplug "zdharma/fast-syntax-highlighting"
# Auto suggests commands based on history
zplug "zsh-users/zsh-autosuggestions"

# check plugins
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
        if read -q; then
        echo; zplug install
    fi
fi

# load plugins
zplug load

# run pfetch if terminal is interactive (https://github.com/dylanaraps/pfetch)
[ -z "$PS1" ] || pfetch

# typewritten
source ~/.npm/global/lib/node_modules/typewritten/typewritten.zsh

# npm global
export PATH=~/.npm/global/bin:$PATH

# gcloud
export CLOUDSDK_PYTHON=$(which python3)

# nvm
source /usr/share/nvm/init-nvm.sh

# Keybindings
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[5~" beginning-of-history
bindkey "^[[6~" end-of-history
bindkey "^[[3~" delete-char
bindkey "^[[2~" quoted-insert