nnoremap <silent><leader>fa :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
" nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

nnoremap <silent><leader>fj :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><leader>fk :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><leader>fl :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><leader>f; :lua require("harpoon.ui").nav_file(4)<CR>
