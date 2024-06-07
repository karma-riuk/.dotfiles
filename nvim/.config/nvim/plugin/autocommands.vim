augroup HighlightYank
    au! 
    au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
augroup END

augroup TmuxReload
    au! 
    au BufWritePost tmux.conf silent exec '!tmux source ~/.config/tmux/tmux.conf; tmux display-message "Config sourced automatically\!"'
augroup END

augroup TmuxReload
    au! 
    au BufWritePost dunstrc silent exec '!killall dunst; notify-send "Dunst reloaded"'
augroup END

augroup GitEditMsg
    au!
    au BufEnter COMMIT_EDITMSG set textwidth=50 | set colorcolumn=51
augroup End
