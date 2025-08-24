# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

#zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Alias Snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Automatically load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Keybinds
# emacs mode
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# install starship
eval "$(starship init zsh)"

#Aliases
#ls Alias
alias ll='ls -alF --color'
alias la='ls -A --color'
alias l='ls -CF --color'

#fzf Alias
alias fzf='fzf --preview='\''cat {}'\'''

#ripgrep Alias
alias grep='rg'

#bat Alias
alias cat='bat'

#nvim alias
alias vim=nvim

# Automatically activate virtual environment if found in the current directory
if [ -d "./venv" ]; then
    source "./venv/bin/activate"
fi

cd() {
    builtin cd "$@" || return
    if [ -d "$PWD/venv" ]; then
        source "$PWD/venv/bin/activate"
    elif [ -d "$PWD/.venv" ]; then
        source "$PWD/.venv/bin/activate"
    fi
}

alias vim='nvim'
alias t="tmux"

#editor
export EDITOR='/bin/vi'
export VISUAL='/bin/vi'

# Path Exports
export PATH=$PATH:/usr/bin
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:/home/stelios/.pyenv/versions/3.12.7/bin
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:~/.local/bin"

#nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#evals
eval "$(fzf --zsh)"
