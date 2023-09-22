### Export XDG base directories
# NOTE: for XDG_CONFIG_HOME (and USI), edit /etc/profile
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

[[ -f "$ZDOTDIR/xdg_compliance" ]] && source "$ZDOTDIR/xdg_compliance"

export XDG_LIB_HOME="$HOME/.local/lib" # custom global for libraries

export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH="$XDG_CONFIG_HOME"/zsh/oh-my-zsh
export EDITOR=nvim
export MANPATH="/usr/local/man:$MANPATH"

# The following two lines are to avoid wierd tab completion artifacts
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# Setting vim to view man pages
# export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist norelativenumber nonumber' -\""
export MANPAGER="nvim +Man!"

export TODAY=$(date '+%A %d/%m/%Y')

export DOTFILES="$HOME/.dotfiles"

# export BW_SESSION="DrfT0geM63+msk0NbbEpBiHc5eRT6e6+t/IlxjebfNSceP3deulQDEg2a/9AeqTIWQNbXF82CjoIx0+6GkyA0w=="
export BITWARDEN_ENV_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/bw.env"
[[ -f "$BITWARDEN_ENV_FILE" ]] && source "$BITWARDEN_ENV_FILE"

local_env_file="${ZDOTDIR:-$HOME/.config/zsh}/.localenv"
[[ -f "$local_env_file" ]] && source "$local_env_file"
