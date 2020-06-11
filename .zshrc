export ZSH="$HOME/.oh-my-zsh"

# Settings
ZSH_THEME="agnoster"
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
plugins=(git aws docker docker-compose golang minikube zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# load local rc file if exists
if test -f $HOME/.zshrc_local; then
    source ~/.zshrc_local
fi

# Load aliases
if test -f $HOME/.aliases; then
    source ~/.aliases
fi

# Load fzf
if test -f $HOME/.fzf.zsh; then
    source ~/.fzf.zsh
fi

# kubectl completion
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
