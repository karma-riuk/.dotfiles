-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
-- local naughty = require("naughty") 
-- -- Disable the naughty notification daemon
-- package.loaded["naughty.dbus"] = {}

-- Scratchpad library
local scratch = require("scratch")
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "termite"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

beautiful.useless_gap = 3
beautiful.gap_single_client = false

awful.mouse.snap.edge_enabled = false
awful.mouse.snap.client_enabled = false

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.corner.nw,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )



awful.tag.add("1", {
        -- icon R "/usr/share/icons/Papirus/16x16/apps/terminal.svg",
        layout = awful.layout.suit.spiral.dwindle,
        selected = true,
    })

awful.tag.add("2", {
        -- icon = "/usr/share/icons/Papirus/qutebrowser.svg",
        layout = awful.layout.suit.tile.bottom,
        master_width_factor = 0.8,
    })

awful.screen.connect_for_each_screen(function(s)

    -- Each screen has its own tag table.
    awful.tag({ "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
        },
        nil, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- Scratchpad terminal
    awful.key({ modkey,           }, "u", 
        function () scratch.toggle("termite -r scratchpad -t scratch-term -e tmux-setup", {name = "scratch-term", role = "scratchpad" }) end,
        {description = "Toggle the tmux scratchpad", group = "tag"}),

    awful.key({ modkey,           }, "i", 
        function () scratch.toggle("termite -r scratchpad -t scratch-htop -e htop", {name = "scratch-htop", role = "scratchpad" }) end,
        {description = "Toggle the tmux scratchpad", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.tag.history.restore()
        end,
        {description = "go back", group = "client"}),

    awful.key({ modkey, "Control" }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "Return", function () awful.util.spawn("sh -c 'termite -d \"$(xcwd)\"'") end,
              {description = "open a terminal on current path", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Control"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey }, "b",     function ()
        awful.spawn("bt-connect")    
    end,
    {description = "Spawns a rofi prompt to connect paired bluetooth devices", group = "Utilities"}),
    awful.key({ modkey, "Shift" }, "b",     function ()
        scratch.toggle(terminal .. " -r scratchpad -t scratch-bluetooth  -e bluetoothctl", {name="scratch-bluetooth", role="scratchpad"})    
    end,
    {description = "Spawns a bluetoothctl terminal", group = "Utilities"}),


        -- awful.tag.incnmaster(-1, nil, true)  -- decrease # of master clients

    awful.key({ modkey, "Control" }, "h",     function ()
        awful.tag.incncol( 1, nil, true)    
    end,
    {description = "increase the number of columns", group = "layout"}),

    awful.key({ modkey, "Control" }, "l",     function ()
        awful.tag.incncol(-1, nil, true)    
    end,
    {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "d",     function () awful.spawn("rofi -show run") end,
              {description = "Launch rofi -show run", group = "launcher"}),

    awful.key({ }, "Print",
              function ()
                  awful.spawn("flameshot gui")
              end,
              {description = "Take a screenshot with flameshot", group = "Media management"}),

    -- XF86 Keys
    --- Media Management
    awful.key({ }, "XF86AudioMute",
              function ()
                  awful.spawn("volumectl -t")
              end,
              {description = "Toggle mute", group = "Media management"}),

    awful.key({ }, "XF86AudioRaiseVolume",
              function ()
                  awful.spawn("volumectl -i")
              end,
              {description = "Increase volume", group = "Media management"}),

    awful.key({ }, "XF86AudioLowerVolume",
              function ()
                  awful.spawn("volumectl -d")
              end,
              {description = "Decrease volume", group = "Media management"}),

    awful.key({ }, "XF86AudioPlay",
              function ()
                  awful.spawn("playerctl -a play-pause")
              end,
              {description = "Toggle Play/Pause", group = "Media management"}),

    --- Brightness management
    awful.key({ }, "XF86MonBrightnessDown",
              function ()
                  awful.spawn("brightctl -d")
              end,
              {description = "Decrease brigthness", group = "Brightness management"}),

    awful.key({ "Shift" }, "XF86MonBrightnessDown",
              function ()
                  awful.spawn("brightctl --set-min-brightness")
              end,
              {description = "Set min brightness", group = "Brightness management"}),

    awful.key({ }, "XF86MonBrightnessUp",
              function ()
                  awful.spawn("brightctl -i")
              end,
              {description = "Increase brigthness", group = "Brightness management"}),

    awful.key({ "Shift" }, "XF86MonBrightnessUp",
              function ()
                  awful.spawn("brightctl --set-max-brightness")
              end,
              {description = "Set max brightness", group = "Brightness management"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey            }, "q",      function (c) c:kill()                         end,
              {description = "Close current window", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),




    awful.key({ modkey,           }, "f",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "Toggle full screen", group = "client"}),

    awful.key({ modkey, "Shift" }, "f",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(Un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Control"   }, "f",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(Un)maximize horizontally", group = "client"}),




    awful.key({ modkey,           }, "h",     function (c)
        awful.client.focus.global_bydirection("left")
        c:lower()
    end,
    {description = "Focus the window on the left", group = "layout"}),

    awful.key({ modkey,           }, "j",     function (c)
        awful.client.focus.global_bydirection("down")
        c:lower()
    end,
    {description = "Focus the window below", group = "layout"}),

    awful.key({ modkey,           }, "k",     function (c)
        awful.client.focus.global_bydirection("up")
        c:lower()
    end,
    {description = "Focus the window above", group = "layout"}),

    awful.key({ modkey,           }, "l",     function (c)
        awful.client.focus.global_bydirection("right")
        c:lower()
    end,
    {description = "Focus the window on the right", group = "layout"}),



    awful.key({ modkey, "Shift"   }, "h",     function ()
        awful.tag.incmwfact(-0.05)
    end,
    {description = "Decrease the with of the master node", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "j",     function ()
        awful.client.incwfact(0.05)
    end,
    {description = "Increase the with of the master node", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "k",     function ()
        awful.client.incwfact(-0.05)
    end,
    {description = "Decrease the with of the master node", group = "layout"}),

    awful.key({ modkey, "Shift"   }, "l",     function ()
        awful.tag.incmwfact(0.05)
    end,
    {description = "Increase the with of the master node", group = "layout"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     titlebars_enabled = false,
     }
    },
    -- General rules for scratchpads
    { rule = {
            role = "scratchpad"
        },
        properties = {
            floating = true,
        },
        -- Center the position of the window
        callback = function (c) 
            awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
            gears.timer.delayed_call(function ()
                c.urgent = false
            end)
        end
    },

    -- Specific rules for scratchpads
    ---- Tmux
    { rule = {
            role = "scratchpad",
            name = "scratch-term",
        },
        properties = {
            width = screen_width * .75,
            height = screen_height * 0.70
        },
    },
    ---- Htop
    { rule = {
            role = "scratchpad",
            name = "scratch-htop",
        },
        properties = {
            width = screen_width * .6,
            height = screen_height * .7
        },
    },
    ---- Bluetoothctl
    { rule = {
            role = "scratchpad",
            name = "scratch-bluetooth",
        },
        properties = {
            width = screen_width * .45,
            height = screen_height * .4
        },
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "Nm-connection-editor",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, 
        properties = { floating = true },
        callback = function (c)
        end
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


-- awful.spawn("feh --no-fehbg --bg-scale ~/Pictures/nice_drawing.png")
