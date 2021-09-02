[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ ! -d "/tmp/tests" ]] && mkdir "/tmp/tests"

export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# export VIMINIT="set nocp | source ${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc"

# Set Caps-Lock to control
setxkbmap -option ctrl:nocaps

# If Caps-Lock or control is just tapped and not pressed with another key, assign it to Esc
xcape -e 'Control_L=Escape'


# Startup applications
unclutter --timeout 1 &
picom &
feh --no-fehbg --bg-scale ~/Pictures/nice_drawing.png &
nm-applet --indicator &
setxkbmap -option compose:ralt &
xset -dpms &
xset s off &
cbatticon &
