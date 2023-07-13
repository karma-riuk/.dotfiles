local function filetype_of_buffer(buf_hndl)
    return vim.api.nvim_eval("getbufvar(" .. buf_hndl .. ", '&filetype')")
end

local function is_undotree_loaded()
    for _, buf_hndl in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf_hndl) and filetype_of_buffer(buf_hndl) == "undotree" then
            return true
        end
    end
    return false
end

local function toggle_or_focus()
    if vim.bo.filetype == "undotree" then
        vim.cmd([[UndotreeHide]])
    elseif is_undotree_loaded() then
        vim.cmd([[UndotreeFocus]])
    else
        vim.cmd([[UndotreeShow]])
        vim.cmd([[UndotreeFocus]])
    end
end

return {
    "mbbill/undotree",
    keys = {
        {
            "<leader>u",
            toggle_or_focus,
            -- "<cmd>UndotreeToggle<Cr>",
            desc = "Toggle [u]ndo",
            silent = false,
        },
    },
}
