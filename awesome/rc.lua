-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local gmath = require("gears.math")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
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
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "st"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.max,
   awful.layout.suit.floating,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
			     { "open terminal", terminal }
}
		       })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
menubar.show_categories = false
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

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

local tasklist_buttons = gears.table.join(
   awful.button({ }, 1, function (c)
	 if c == client.focus then
	    c.minimized = true
	 else
	    c:emit_signal(
	       "request::activate",
	       "tasklist",
	       {raise = true}
	    )
	 end
   end),
   awful.button({ }, 3, function()
	 awful.menu.client_list({ theme = { width = 250 } })
   end),
   awful.button({ }, 4, function ()
	 awful.client.focus.byidx(1)
   end),
   awful.button({ }, 5, function ()
	 awful.client.focus.byidx(-1)
end))

local function set_wallpaper(s)
   -- Wallpaper
   local wallpaper = os.getenv('HOME') .. '/pics/bonfire.jpg'
   -- If wallpaper is a function, call it with the screen
   gears.wallpaper.maximized(wallpaper, s, true)
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
      -- Wallpaper
      set_wallpaper(s)

      -- Each screen has its own tag table.
      awful.tag({ "⭕", "⭕", "⭕", "⭕" }, s, awful.layout.layouts[1])

      -- Create a promptbox for each screen
      s.mypromptbox = awful.widget.prompt.new({
	    fg_cursor = beautiful.bg_normal,
	    bg_cursor = beautiful.fg_focus,
	    font      = beautiful.font
      })
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

      -- Create a tasklist widget
      s.mytasklist = awful.widget.tasklist {
	 screen  = s,
	 filter  = awful.widget.tasklist.filter.minimizedcurrenttags,
	 buttons = tasklist_buttons,
	 align   = center
      }

      -- Create the top wibox
      s.topbox = awful.wibar({
	    position = "top",
	    screen   = s,
	    visible  = false,
	    shape    = gears.shape.rounded_bar,
      })

      -- Add widgets to the wibox
      s.topbox:setup {
	 layout = wibox.layout.align.horizontal,
	 { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
	    wibox.container.margin(s.mytaglist, 10)
	 },
	 {
	    layout = wibox.layout.fixed.horizontal,
	    mylauncher,
	    s.mypromptbox
	 },
	 {
	    layout = wibox.layout.fixed.horizontal,
	    wibox.widget.systray(),
	    wibox.container.margin(mytextclock, 0, 10)
	 }
      }

      -- Bottom wibox
      s.botbox = awful.wibar({
	    position = "bottom",
	    screen = s,
	    visible = false,
	    width = gmath.round(s.geometry.width / 2),
	    align = "center",
	    stretch = false,
	    opacity = 0.5
      })

      s.botbox:setup {
	 layout = wibox.layout.align.horizontal,
	 s.mytasklist,
	 nil,
      }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
		awful.button({ }, 3, function () mymainmenu:toggle() end)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
   awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
      {description="show help", group="awesome"}),
   awful.key({ modkey }, "plus",
      function()
	 awful.spawn('amixer sset Master 5%+')
      end,
      {description = "raise volume", group = "awesome"}),
   awful.key({modkey }, "minus",
      function()
	 awful.spawn('amixer sset Master 5%-')
      end,
      {description = "lower volume", group = "awesome"}),
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
      {description = "view previous", group = "tag"}),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
      {description = "view next", group = "tag"}),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
      {description = "go back", group = "tag"}),

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
   awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
      {description = "show main menu", group = "awesome"}),

   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
      {description = "swap with next client by index", group = "client"}),
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
      {description = "swap with previous client by index", group = "client"}),
   awful.key({ modkey }, "period", function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
   awful.key({ modkey }, "comma", function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),
   awful.key({ modkey }, "b",
      function()
	 local screen = awful.screen.focused()
	 screen.topbox.visible = not screen.topbox.visible
	 if screen.botbox.visible then
	    screen.botbox.visible = false
	 end
      end,
      {description = "toggle wibox", group = "screen"}),

   -- Standard program
   awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
      {description = "open a terminal", group = "launcher"}),
   awful.key({ modkey, "Control" }, "r", awesome.restart,
      {description = "reload awesome", group = "awesome"}),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit,
      {description = "quit awesome", group = "awesome"}),

   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
      {description = "increase master width factor", group = "layout"}),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
      {description = "decrease master width factor", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
      {description = "increase the number of master clients", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
      {description = "decrease the number of master clients", group = "layout"}),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
      {description = "increase the number of columns", group = "layout"}),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
      {description = "decrease the number of columns", group = "layout"}),
   awful.key({ modkey, "Control" }, "space", function () awful.layout.inc( 1)                end,
      {description = "select next", group = "layout"}),
   -- awful.key({ modkey, "Control"   }, "space", function () awful.layout.inc(-1)                end,
   --           {description = "select previous", group = "layout"}),

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
   awful.key({ modkey }, "r",
      function()
	 awful.util.spawn("rofi -show run -theme generic")
      end,
      {description = "run prompt", group = "launcher"}),

   awful.key({ modkey }, "x",
      function ()
	 if not awful.screen.focused().topbox.visible then
	    awful.screen.focused().topbox.visible = true
	 end
	 awful.prompt.run {
	    prompt       = "Run Lua code: ",
	    textbox      = awful.screen.focused().mypromptbox.widget,
	    exe_callback = awful.util.eval,
	    history_path = awful.util.get_cache_dir() .. "/history_eval"
	 }
      end,
      {description = "lua execute prompt", group = "awesome"}),
   -- Menubar
   awful.key({ modkey, "Shift" }, "n", function() menubar.show() end,
      {description = "show the menubar", group = "launcher"}),
   awful.key({ modkey }, "p", function() awful.spawn('passmenu') end,
      {description = "password manager", group = "launcher"})
)

clientkeys = gears.table.join(
   awful.key({ modkey,           }, "f",
      function (c)
	 c.fullscreen = not c.fullscreen
	 c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),
   awful.key({ modkey,   }, "q",      function (c) c:kill() end,
      {description = "close", group = "client"}),
   awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle,
      {description = "toggle floating", group = "client"}),
   awful.key({ modkey, }, "space", function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),
   awful.key({ modkey, "Shift" }, "period",      function (c) c:move_to_screen() end,
      {description = "move to screen", group = "client"}),
   awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop end,
      {description = "toggle keep on top", group = "client"}),
   awful.key({ modkey,           }, "n",
      function (c)
	 -- The client currently has the input focus, so it cannot be
	 -- minimized, since minimized clients can't have the focus.
	 c.minimized = true
	 awful.screen.focused().botbox.visible = true
      end ,
      {description = "minimize", group = "client"})
)

for i, key in ipairs({"a", "o", "e", "u"}) do
   globalkeys = gears.table.join(globalkeys,
				 awful.key({ modkey }, key,
				    function ()
				       local screen = awful.screen.focused()
				       local tag = screen.tags[i]
				       if tag then
					  tag:view_only()
				       end
				    end,
				    {description = "view tag " .. key, group = "tag"}),
				 awful.key({ modkey, "Control" }, key,
				    function ()
				       local screen = awful.screen.focused()
				       local tag = screen.tags[i]
				       if tag then
					  awful.tag.viewtoggle(tag)
				       end
				    end,
				    {description = "toggle tag " .. key, group = "tag"}),
				 awful.key({ modkey, "Shift" }, key,
				    function()
				       if client.focus then
					  local tag = client.focus.screen.tags[i]
					  if tag then
					     client.focus:move_to_tag(tag)
					  end
				       end
				    end,
				    {description = "move focused client to tag " .. key, group = "tag"}),
				 awful.key({ modkey, "Control", "Shift" }, key,
				    function()
				       if client.focus then
					  local tag = client.focus.screen.tags[i]
					  if tag then
					     client.focus:move_to_tag(tag)
					  end
				       end
				    end,
				    {description = "toggle focused client on tag " .. key, group = "tag"})
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
		    placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
   },

   -- Floating clients.
   { rule_any = {
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
	   "Event Tester",  -- xev.
        },
        role = {
	   "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
   }, properties = { floating = true }},

   -- Remove titlebars from normal clients and dialogs
   { rule_any = {type = { "normal", "dialog" }
		}, properties = { titlebars_enabled = false }
   },

   { rule = { class = "Firefox" },
     properties = { tag = "o" } },
   { rule = { class = "Mpv" },
     properties = { tag = "u" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
			 -- Set the windows at the slave,
			 -- i.e. put it at the end of others instead of setting it master.
			 -- if not awesome.startup then awful.client.setslave(c) end

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

-- {{
-- Autostarts
awful.spawn.once([[tiramisu -o '#summary #body' | \
	while read -r line; do
		for i in $(seq 10); do
			herbe \"$line\"
			sleep 1
		done
		done &]])
awful.spawn.once('emacs --daemon --debug-init')
-- }}
