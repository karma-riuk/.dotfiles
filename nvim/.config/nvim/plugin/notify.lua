NOTIFY_WIDHT = 50
require("notify").setup({
    background_colour = "#00000000",
    max_width = NOTIFY_WIDHT,
})

local function split_length(text, length)
    local lines = {}
    local next_line
    while true do
        if #text == 0 then
            return lines
        end
        next_line, text = text:sub(1, length), text:sub(length)
        lines[#lines + 1] = next_line
    end
end

vim.notify = function(msg, level, opts) ---@diagnostic disable-line: duplicate-set-field
    if msg == nil then
        msg = "NIL"
    elseif msg == "" then
        msg = '""' -- make empty string more apparent
    end

    local msgLines = vim.split(msg, "\n", { trimepty = true })
    local wrappesLines = {}
    for _, line in pairs(msgLines) do
        local new_lines = split_length(line, NOTIFY_WIDHT)
        for _, nl in ipairs(new_lines) do
            if nl and nl ~= "" then
                table.insert(wrappesLines, " " .. nl .. " ")
            end
        end
    end
    local out = table.concat(wrappesLines, "\n")
    return require("notify")(out, level, opts)
end
