# use command: "whoami" to determine what your use is
# uncomment the proceeding line with your username
# USER=

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# create daily notes
cminutes() {
    today=$(date +"%Y-%m-%d")
    if [ -e ~/notes/minutes/${today}-"$1"-minutes.md ];
    then
        echo "minutes/${today}-"$1"-minutes.md already created"
    else
        # echo "no file created"
        vim -c "+normal ggO# Meeting Minutes" -c "+normal ggo# $(date)" -c ':s/$/\r/' -c 'se nohlsearch' ~/notes/"${today}-"$1"-minutes.md"
    fi
}

# create daily notes
cnotes() {
    today=$(date +"%Y-%m-%d")
    if [ -e ~/notes/${today}-notes.md ];
    then
        echo "${today}-notes.md already created"
    else
        # echo "no file created"
        vim -c "+normal ggO# What Did I Do?" -c "+normal ggo# $(date)" -c ':s/$/\r/' -c 'se nohlsearch' ~/notes/${today}-notes.md
    fi
}

# create daily notes
wnotes() {
    today=$(date +"%Y-%m-%d")
    if [ ! -f ~/notes/${today}-notes.md ];
    then
        echo "${today}-notes.md not created"
    else
        vim ~/notes/${today}-notes.md
    fi
}

# aliases
alias ll='ls -la'
alias ~='cd ~'
alias zshconfig='vim ~/.zshrc'
alias ohmyzsh='vim ~/.oh-my-zsh'
alias szsh='source ~/.zshrc'
alias bashconfig='vim ~/.bash_profile'
alias sbash='source ~/.bash_profile'
alias notes='cd ~/notes'
alias neovim='nvim'
alias vim='nvim'
alias vi='nvim'
alias vimdiff='nvim -d'
alias vimrc='vim ~/.vimrc'
alias brewuuc='brew update && brew upgrade && brew cleanup'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

