lua require('karma.telescope')

noremap <C-p>           <cmd>lua require('telescope.builtin').find_files()<cr>
noremap <leader>vrc     <cmd>lua require('karma.telescope').dotfiles()<cr>
noremap <C-f>               <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({previewer = false})<cr>
" noremap <C-f>           <cmd>lua require('telescope.builtin').find_files()<cr>
" noremap /               <cmd>lua require('karma.telescope').search_buffer()<cr>

nnoremap <F11>          <cmd>Telescope help_tags<cr>
