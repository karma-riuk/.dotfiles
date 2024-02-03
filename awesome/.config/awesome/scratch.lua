local client = client
local awful = require("awful")
local util = require("awful.util")

local scratch = {}
local defaultRule = { instance = "scratch" }

local function screen_geom()
    return awful.screen.focused().geometry
end

local function resize_width(c, width)
    if width == nil then
        awful.spawn("notify-send che cazzo")
        return
    end

    if type(width) == "function" then
        c.width = width()
    elseif type(width) == "number" then
        if width < 1 then
            c.width = width * screen_geom().width
        else
            c.width = width
        end
    end
end

local function resize_height(c, height)
    if height == nil then
        return
    end

    if type(height) == "function" then
        c.height = height()
    elseif type(height) == "number" then
        if height < 1 then
            c.height = height * screen_geom().height
        else
            c.height = height
        end
    end
end

-- local function center_on_screen(c)
--     c.x = screen_geom().x + (screen_geom().width - c.width) / 2
--     c.y = screen_geom().y + (screen_geom().height - c.height) / 2
-- end

-- Turn on this scratch window client (add current tag to window's tags,
-- then set focus to the window)
local function turn_on(c, props)
    c:tags({ awful.screen.focused().selected_tag })
    c.screen = awful.screen.focused()
    c:raise()

    -- awful.placement.left(c)
    if c.prev_screen == nil or c.prev_screen ~= c.screen then
        resize_width(c, props.width)
        resize_height(c, props.height)
        awful.placement.centered(c)
        -- center_on_screen(c)
    end

    -- c.prev_screen = c.screen

    client.focus = c
end

-- Turn off this scratch window client (remove current tag from window's tags)
local function turn_off(c)
    c:tags({})
end

function scratch.raise(cmd, props)
    local rule = props.rule or defaultRule
    local function matcher(c)
        return awful.rules.match(c, rule)
    end

    -- logic mostly copied form awful.client.run_or_raise, except we don't want
    -- to change to or merge with scratchpad tag, just show the window
    local clients = client.get()
    local findex = util.table.hasitem(clients, client.focus) or 1
    local start = util.cycle(#clients, findex + 1)

    for c in awful.client.iterate(matcher, start) do
        turn_on(c, props)
        return
    end

    -- client not found, spawn it
    awful.spawn(cmd)
end

function scratch.toggle(cmd, props)
    local rule = props.rule or defaultRule

    if client.focus and awful.rules.match(client.focus, rule) then
        turn_off(client.focus)
    else
        scratch.raise(cmd, props)
    end
end

return scratch
