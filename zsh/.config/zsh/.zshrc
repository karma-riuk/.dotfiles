# ZSH stuff
#
HIST_STAMPS="dd/mm/yyyy"
setopt correct
DISABLE_AUTO_TITLE="true"
## The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
## End of lines added by compinstall

zstyle ':completion:*:*:vim:*' file-patterns '^*.(aux|log|pdf|class|a|o|png|jpg|bmp|gif|ico|git|DS_Store|sw?|tmp):source-files' '*:all-files'
zstyle ':completion:*:*:nvim:*' file-patterns '^*.(aux|log|pdf|class|a|o|png|jpg|bmp|gif|ico|git|DS_Store|sw?|tmp):source-files' '*:all-files'

export HISTSIZE=100000000000
export SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# export NVM_LAZY_LOAD=true

plugins=(git pip command-not-found fasd wd sudo)
source $ZSH/oh-my-zsh.sh

# Setting my prompt to be the "pure" prompt
fpath+="$ZSH/pure"
autoload -U promptinit; promptinit;
zstyle :prompt:pure:prompt:success color cyan
prompt pure

# export AUTO_LS_NEWLINE=false

export NVM_LAZY_LOAD=true

# Plugin management
source "$ZSH"/antigen.zsh
antigen use oh-my-zsh
antigen bundle MichaelAquilina/zsh-you-should-use

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle desyncr/auto-ls
antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-completions
antigen apply

## To disable auto-ls commands to be run, uncomment the line below
# AUTO_LS_COMMANDS=()

bindkey -v
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- Normal --}/(main|viins)/}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=20

bindkey '^[[Z' autosuggest-execute
bindkey '^ ' autosuggest-accept

bindkey '\el' autosuggest-accept

function search-down {
    zle down-line-or-beginning-search
    zle vi-cmd-mode
}
function search-up {
    zle up-line-or-beginning-search
    zle vi-cmd-mode
}
zle -N search-down
zle -N search-up
bindkey "^k" search-up
bindkey "^j" search-down

bindkey -M vicmd "^k" up-line-or-beginning-search
bindkey -M vicmd "^j" down-line-or-beginning-search

bindkey "^v" edit-command-line

bindkey -M viins '^s' sudo-command-line

unsetopt autopushd

# [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

source $ZDOTDIR/aliases
