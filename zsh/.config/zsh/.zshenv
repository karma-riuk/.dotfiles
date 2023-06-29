### Export XDG base directories
# NOTE: for XDG_CONFIG_HOME (and USI), edit /etc/profile
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

export XDG_LIB_HOME="$HOME/.local/lib" # custom global for libraries
### Golbal variables for XDG rebase ###
# ZSH
export HISTFILE="$XDG_DATA_HOME"/zsh/history
# Wget
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
# NodeJs
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# GTK 2
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
# LateX
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-var"
# Nvm
export NVM_DIR="$XDG_DATA_HOME"/nvm
# Zoom
export SSB_HOME="$XDG_DATA_HOME"/zoom
# Less
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

export TERM="xterm-256color"


# Path to your oh-my-zsh installation.
export ZSH="$XDG_CONFIG_HOME"/zsh/oh-my-zsh
export EDITOR=nvim
export MANPATH="/usr/local/man:$MANPATH"

# The following two lines are to avoid wierd tab completion artifacts
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# Setting vim to view man pages
export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set ft=man ts=8 nomod nolist norelativenumber nonumber' -\""

export TODAY=$(date '+%A %d/%m/%Y')

export DOTFILES="$HOME/.dotfiles"

# export BW_SESSION="DrfT0geM63+msk0NbbEpBiHc5eRT6e6+t/IlxjebfNSceP3deulQDEg2a/9AeqTIWQNbXF82CjoIx0+6GkyA0w=="
export BITWARDEN_ENV_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/bw.env"
[[ -f "$BITWARDEN_ENV_FILE" ]] && source "$BITWARDEN_ENV_FILE"

local_env_file="${ZDOTDIR:-$HOME/.config/zsh}/.localenv"
[[ -f "$local_env_file" ]] && source "$local_env_file"

export AOC_SESSION="53616c7465645f5f7a77ee2af988e0cf811b42022a82f63b63b0b3f7309381ca1669704cfe79817e55fe0c29610e862e"
