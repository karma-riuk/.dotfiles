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

# setopt INC_APPEND_HISTORY

plugins=(git pip command-not-found fasd wd)
source $ZSH/oh-my-zsh.sh

# Setting my prompt to be the "pure" prompt
fpath+="$ZSH/pure"
autoload -U promptinit; promptinit;
zstyle :prompt:pure:prompt:success color cyan
prompt pure


# Plugin management
source "$ZSH"/antigen.zsh
antigen use oh-my-zsh
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle desyncr/auto-ls
antigen bundle zsh-users/zsh-syntax-highlighting
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


# [ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

source $ZDOTDIR/aliases

# The following lines come from Software Atelier 3 (USI SA 2021-22)
# source /usr/share/nvm/init-nvm.sh # ucomment this line (or paste it in the terminal) to have access to the nvm command, it slows the opening of a new shell thow
export npm_config_prefix="$HOME/.local"
