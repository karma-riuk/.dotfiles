augroup HighlightYank
    au! 
    au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
augroup END

augroup TmuxReload
    au! 
    au BufWritePost tmux.conf silent exec '!tmux source ~/.config/tmux/tmux.conf; tmux display-message "Config sourced automatically\!"'
augroup END
