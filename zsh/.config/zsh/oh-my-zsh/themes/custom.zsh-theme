PROMPT='$fg[cyan]%m$reset_color: $fg[yellow]$(get_pwd)$(put_spacing)$(git_prompt_info) $(battery_charge)
$(hostname_color) %f '

#
#➜
function hostname_color(){
    local s=$?
    if [ $s != 0 ] && [ $s != 130 ]; then
        echo "$fg[red]"
    else
        echo "$reset_color"
    fi
}

function get_pwd(){
    echo "${PWD/$HOME/~}"
}

function git_prompt_info(){
    echo "git"
}

function battery_charge() {
    #local length=10
    #printf "  ["
    #local charged=$(python3 -c "print(round(`acpi | grep -o '[0-9]*%' | sed 's/%//'`/100*$length))")
    #printf "%*s" "$charged" | tr ' ' "#"
    #printf "%*s" "(($length - $charged))"  | tr ' ' '-'
    echo " [###--]"
}

function put_spacing(){
    local git=$(git_prompt_info)
    git=${#git}
    local bat=$(battery_charge)
    bat=${#bat}
    local pw=$(get_pwd)
    pw=${#pw}

    local termwidth
    (( termwidth = ${COLUMNS} - 3 - ${#HOST} - ${pw} - ${bat} - ${git} ))
    
    local spacing=""
    for i in {1..$termwidth}; do
        spacing="${spacing} "
    done
    echo "${spacing}"
}

