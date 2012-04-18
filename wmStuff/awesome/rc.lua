-- Standard libraries
require("awful")
require("awful.autofocus")
require("awful.rules")
require("vicious")

-- {{{ Variable definitions
local altkey = "Mod1"
local modkey = "Mod4"

local home	= os.getenv("HOME")
local exec	= awful.util.spawn
local terminal = "urxvt"

beautiful.init(home .. "/.config/awesome/theme/theme.lua")

layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.floating
}
-- }}}

-- {{{ Tags
tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag({1, 2}, s, layouts[1])
		for i, t in ipairs(tags[s]) do
       awful.tag.setproperty(t, "mwfact", i==1 and 0.6 or 0.5)
		end
end
-- }}}

-- {{{ Menu
myawesomemenu = {
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", terminal }
}})

mylauncher = awful.widget.launcher(
    { image = image(beautiful.awesome_icon), menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Separator
separator = widget({ type = "textbox" }) separator.text  = " :: "

-- Clock
mytextclock = awful.widget.textclock({ align = "right" })

-- Systray
mysystray = widget({ type = "systray" })

-- Battery
batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, "$1$2%", 61, "BAT0")

-- Volume
volwidget = widget({ type = "textbox" })
vicious.register(volwidget, vicious.widgets.volume, "$2$1%", 2, "Master")
volwidget:buttons(awful.util.table.join(
	awful.button({ }, 1, function () 
	 	exec("amixer -q set Master 3dB+", false); vicious.force({ volwidget }); end),
	awful.button({ }, 3, function () 
		exec("amixer -q set Master 3dB-", false); vicious.force({ volwidget }); end)
))

-- Music
mpdwidget = widget({type = "textbox" })
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == "Stop" then return " - "
        else return args["{Artist}"]..' - '.. args["{Title}"] end
    end, 1)
mpdwidget:buttons(awful.util.table.join(
	awful.button({ }, 1, function () exec("ncmpcpp play next");
	vicious.force({ mpdwidget }) end),
	awful.button({ }, 3, function () exec("ncmpcpp stop");
	vicious.force({ mpdwidget }) end)
))

-- Taskbar
mytasklist = {}
mytasklist.buttons = awful.button({ }, 1, 
	function (c)
  	if c == client.focus then
   		c.minimized = true
    else
			if not c:isvisible() then
 		    awful.tag.viewonly(c:tags()[1])
      end
 	  client.focus = c
    c:raise()
    end
	end)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ },        1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ },        3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag))

for s = 1, screen.count() do
    -- Create a promptbox
    mypromptbox[s] = awful.widget.prompt(
			{ layout = awful.widget.layout.horizontal.leftright })
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(
			s, awful.widget.taglist.label.all, mytaglist.buttons)
    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(
			function(c) return awful.widget.tasklist.label.currenttags(c, s) end, 
			mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        separator, mytextclock,
				separator, batwidget, baticon,
				separator, volwidget,
				separator, mpdwidget,
				separator,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
		awful.key({ altkey }, "Tab", awful.tag.viewnext),
		--testing for f4 spawn in same location:
		-- c: refers to the focused client
		-- ps aux | grep processName gives pids
		-- pwdx ~pid~ gives pwd of a pid
		-- pwdx gives the directory from which the terminal was SPAWNED
		--awful.key({}, "F1",  function (c) exec("urxvt -cd `ps aux | grep urxv") end),
		--might need to be in clientKeys below
		--awful.key({}, "F1",  function (c) exec("echo " .. c.fullscreen) end),
		awful.key({}, "F2",  function () exec("urxvt -name float") end),
		awful.key({}, "F3",  function () exec("urxvt") end),
		--awful.key({}, "F4",  function () exec("urxvt -cd $PWD") end),
		awful.key({}, "F4",  function () exec("chromium") end),
		awful.key({}, "F10", function () exec("urxvt-irssi -e irssi") end),
		awful.key({}, "F11", function () exec("urxvt -e ncmpcpp") end),
		awful.key({}, "F12", function () exec("urxvt -e mutt") end),
		awful.key({}, "Print", function () exec("scrot ~/pictures/screenshots/scrot-%F-%H%M%S.png") end),
		
		-- Volume Control
		awful.key({ altkey }, "F10", function () 
				exec("amixer -q set Master toggle"); 
				vicious.force({ volwidget }); end),
		awful.key({ altkey }, "F11", function () 
				exec("amixer -q set Master 3dB-");
				vicious.force({ volwidget }); end),
		awful.key({ altkey }, "F12", function () 
				exec("amixer -q set Master 3dB+");
				vicious.force({ volwidget }); end),
		
		-- Tile switching 
		awful.key({ altkey }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    
		-- Layout manipulation
    awful.key({ altkey, "Control" }, "j", function () awful.client.swap.byidx( 1) end),
    awful.key({ altkey, "Control" }, "k", function () awful.client.swap.byidx(-1) end),

    -- Standard program
    awful.key({ modkey }, "l",     function () awful.tag.incmwfact( 0.05)   end),
    awful.key({ modkey }, "h",     function () awful.tag.incmwfact(-0.05)   end),
    awful.key({ modkey }, "space", function () awful.layout.inc(layouts, 1) end),

    -- Prompt
    awful.key({ altkey }, "r",     function () mypromptbox[mouse.screen]:run() end)
)

clientkeys = awful.util.table.join(
		--echoing the current pid, going to use this for spawning shells in the same location
		--should only work for urxvt, add an if clause
		--awful.key({}, "F1",  function (c) exec("pwdx " .. c.pid .. "| sed s/[^/]*//") end),
		awful.key({}, "F1",  function (c) exec("/home/robbinsr/test.sh " .. c.pid) end),
				--exec("pwdx " .. c.pid .. " | cut -c 1-4") end),--" | sed s/[^/]*//") end),
    awful.key({ modkey,         }, "f", function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift" }, "c", function (c) c:kill()                         end),
    awful.key({ modkey, "Shift" }, "r", function (c) c:redraw()                       end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
										 size_hints_honor = false,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
		
		{ rule = { class = "URxvt", instance = "float"},
      properties = { floating = true },
			callback = function( c ) c:geometry( { x = 200, y = 220, width = 600 , height = 300 } ) end },
    { rule = { class = "Chromium" },
      properties = { floating = true, tag = tags[1][2] } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)
client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
--client.add_signal("focus", function(c) exec("echo test") end)
-- }}}
