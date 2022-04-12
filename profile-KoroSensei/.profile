[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.local/share/npm/bin" ]] && PATH="$HOME/.local/share/npm/bin:$PATH"
[[ ! -d "/tmp/tests" ]] && mkdir "/tmp/tests"

# export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# export VIMINIT="set nocp | source ${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc"

