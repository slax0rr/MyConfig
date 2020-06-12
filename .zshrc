# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# Settings
ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
