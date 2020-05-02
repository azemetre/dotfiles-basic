# use command: "whoami" to determine what your user is
# USER=

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/$USER/.oh-my-zsh"
PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# other exports
export FZF_BASE=/usr/local/bin/fzf

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    fzf
)

source $ZSH/oh-my-zsh.sh
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

# User configuration
# new line in terminal after command prompt

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

# fzf key bindings and functions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}
# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm> <directory>
fif() {
  if [ ! "$#" -gt 1 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages $1 | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 $1 || rg --ignore-case --pretty --context 10 $1 {}"
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# alias functions 
# make directory -> change into it
mkcd () {
  mkdir "$1"
  cd "$1"
}

# git clone repo -> change into it
gclonecd() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# aliases
alias zshconfig='vim ~/.zshrc'
alias ohmyzsh='vim ~/.oh-my-zsh'
alias szsh='source ~/.zshrc'
alias bashconfig='vim ~/.bash_profile'
alias sbash='source ~/.bash_profile'
alias ll='ls -la'
alias ~='cd ~'
alias neovim='nvim'
alias vim='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'
alias vimrc='vim ~/.vimrc'
alias brewuuc='brew update && brew upgrade && brew cleanup'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

