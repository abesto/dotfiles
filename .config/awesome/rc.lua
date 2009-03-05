-- Standard awesome library
require("awful")
-- Theme handling library
require("beautiful")
-- Expose-like effect
require("revelation")
-- Widgets :p
require("wicked")
-- Add mod + F2 key binding to start revelation
keybinding({ modkey }, "F2", revelation.revelation):add()
-- Notification library
require("naughty")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
-- theme_path = "/usr/share/awesome/themes/default/theme"
theme_path = "/home/abesto/.config/awesome/themes/theme"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/share/awesome/themes/sky/theme"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
--editor = os.getenv("EDITOR") or "nano"
editor = "emacsclient"
--editor_cmd = terminal .. " -e " .. editor
editor_cmd = "emacsclient -c"


-- Autorun programs
autorun = true
autorunApps =
{
   "mpc load minden",
   "mpc random",
   "mpc pause",
   "nm-applet",
   "xmodmap ~/.xmodmap",
   "firefox",
   "~/mutt",
   "emacs --daemon",
}
if autorun then
   for app = 1, #autorunApps do
       awful.util.spawn(autorunApps[app])
   end
end

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating
}

-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    xterm -name mocp -e mocp
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["pinentry"] = true,
    ["gimp"] = true,
    -- by instance
    ["mocp"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
    ["Navigator"] = { screen = 1, tag = 9 },
    ["mutt"] = { screen = 1, tag = 8 },
    ["pidgin"] = {screen = 1, tag = 7},
    ["xchat"] = {screen = 1, tag = 7}
    -- ["mocp"] = { screen = 2, tag = 4 },
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

-- {{{ Tags
-- Define tags table.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = {}
    -- Create 9 tags per screen.
    for num,name in ipairs({1, 2, 3, 4, 5, 6, 'im', 'mail', 'www'}) do
        tags[s][num] = tag(name)
        -- Add tags to screen one by one
        tags[s][num].screen = s
        awful.layout.set(layouts[1], tags[s][num])
    end
    -- I'm sure you want to see at least one tag.
    tags[s][1].selected = true
end
-- }}}

-- {{{ Wibox
--[[
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu.new({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                        { "open terminal", terminal }
                                      }
                            })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
--]]
-- Widget colours
widget_fg        = beautiful.widget_bg        or beautiful.fg_normal
widget_fg_center = beautiful.widget_fg_center or beautiful.fg_normal
widget_fg_end    = beautiful.widget_fg_end    or beautiful.fg_urgent
widget_fg_off    = beautiful.widget_fg_off    or beautiful.fg_normal
widget_bg        = beautiful.widget_fg        or beautiful.bg_focus
widget_border    = beautiful.widget_border    or beautiful.border_focus

function colorize (text, color)
   return '<span color="' .. color .. '">' .. text .. '</span>'
end

function enclose (text)
   pre = colorize('[', 'yellow')
   post = colorize(']', 'yellow')
   return pre .. text .. post
end

-- Widget icons
--[[
icon_cpu  = beautiful.icon_cpu  or awful.util.getdir("config") .. "/themes/default/icons/cpu.png"
icon_bat  = beautiful.icon_bat  or awful.util.getdir("config") .. "/themes/default/icons/bat.png"
icon_mem  = beautiful.icon_mem  or awful.util.getdir("config") .. "/themes/default/icons/mem.png"
--icon_vol  = beautiful.icon_vol  or awful.util.getdir("config") .. "/themes/default/icons/vol.png"
--icon_down = beautiful.icon_down or awful.util.getdir("config") .. "/themes/default/icons/down.png"
icon_time = beautiful.icon_time or awful.util.getdir("config") .. "/themes/default/icons/time.png"
icon_temp = beautiful.icon_temp or awful.util.getdir("config") .. "/themes/default/icons/temp.png"
--icon_wifi = beautiful.icon_wifi or awful.util.getdir("config") .. "/themes/default/icons/wifi.png"
--]]
icon_play = beautiful.icon_play or awful.util.getdir("config") .. "/themes/default/icons/play.png"
icon_stop = beautiful.icon_stop or awful.util.getdir("config") .. "/themes/default/icons/stop.png"

--music
local mnot = nil --Music notification object

-- awesome.hooks.timer seems to forget about killing the notifications, so work around that
-- bof timer workaround, part 1
local kill_command = "sleep 3; echo 'kill_mnot()' | awesome-client"

function kill_mnot ()
   if mnot then
      awful.util.spawn("~/.config/awesome/kill_mnot.sh")
      mnot.die()
      mnot = nil
   end
end
-- eof timer workaround, part 1

function show_song ()
   local np_file = io.popen('mpc 2> /dev/null')
   local track = np_file:read("*line")
   local icon = ''

   if track == nil or track:find("volume:") then
      return
   else
      track = track:gsub('&', '&amp;')

      local status = np_file:read("*line")
      np_file:close()

      if status:find("playing") then
         icon = icon_play
      else
         icon = icon_stop
      end

      local dur_pattern = "%d+:%d+/%d+:%d+"
      local duration = string.find(status, dur_pattern) and string.sub(status, string.find(status, dur_pattern)) or ""

      kill_mnot()
      mnot =  naughty.notify({
                                title = "MPD",
                                text = track.."\n"..duration,
                                --timeout = 3,
                                icon = icon
                             })
      awful.util.spawn(kill_command) -- timer workaround, part 2
   end
end

-- Spacer
spacer = " "
spacer_widget = widget({ type = "textbox", name = "spacer_widget", align = "right" })
spacer_widget.text = spacer

-- Date
--date_icon   = widget({ type = "imagebox", name ="date_icon", align = "right" })
--date_icon.image = image(icon_time)
date_widget = widget({ type = "textbox", name = "date_widget", align = "right" })
date_widget:buttons({button({ }, 1, function () awful.util.spawn("org") end)})
wicked.register(date_widget, "date", enclose("%d %b, %H:%M"))

-- CPU
--cpu_icon       = widget({ type = "imagebox", name = "cpu_icon", align = "right" })
--cpu_icon.image = image(icon_cpu)
cpufreq_widget = widget({ type = "textbox", name = "cpufreq_widget", align = "right" })
wicked.register(cpufreq_widget, "function", function (widgets, args)
    local cmd = "cat /proc/cpuinfo | grep 'cpu MHz' | cut -d':' -f2"
    local f = io.popen(cmd)
    local l = f:read()
    f:close()

    return string.format(enclose("CPU: %.2fGHz "), l / 1000)
end, 5)

-- Battery
--battery_icon        = widget({ type ="imagebox", name = "battery_icon", align = "right" })
--battery_icon.image  = image(icon_bat)
battery_widget_text = widget({ type = "textbox", name = "battery_widget_text", align = "right" })
wicked.register(battery_widget_text, 'function', function (widgets, args)
    local cmd = "acpi -b"
    local f = io.popen(cmd)
    local l = f:read()
    f:close()

    local text

    if string.find(l, "Discharging") then
       --battery_icon.visible        = true
       battery_widget_text.visible = true
       local perc = string.sub(l, string.find(l, "%d*%d*%d%%"))
       local remaining = string.sub(l, string.find(l, "%d*%d*:*%d*%d*:%d%d"))
       text = remaining .. " (" .. perc .. ")"
    else
       --battery_icon.visible        = false
	   battery_widget_text.visible = false
    end

    return text and enclose(text)
end, 10)

-- {{{ Memory
--membar_icon       = widget({ type = "imagebox", name = "membar_icon", align = "right" })
--membar_icon.image = image(icon_mem)
membar_widget     = widget({ type = "textbox", name = "membar_widget", align = "right" })
--wicked.register(membar_widget, "mem", "$1%", 3)

function memInfo()
    local f = io.open("/proc/meminfo")

    for line in f:lines() do
        if line:match("^MemTotal.*") then
            memTotal = math.floor(tonumber(line:match("(%d+)")) / 1024)
        elseif line:match("^MemFree.*") then
            memFree = math.floor(tonumber(line:match("(%d+)")) / 1024)
        elseif line:match("^Buffers.*") then
            memBuffers = math.floor(tonumber(line:match("(%d+)")) / 1024)
        elseif line:match("^Cached.*") then
            memCached = math.floor(tonumber(line:match("(%d+)")) / 1024)
        end
    end
    f:close()

    memFree = memFree + memBuffers + memCached
    memInUse = memTotal - memFree
    memUsePct = math.floor(memInUse / memTotal * 100)

    membar_widget.text = enclose("Mem: "..memUsePct.."%"..spacer.."("..memInUse.."M)")
end
-- }}}

-- Temp
--temp_icon       = widget({ type = "imagebox", name = "temp_icon", align = "right" })
--temp_icon.image = image(icon_temp)
temp_widget     = widget({ type = "textbox", name = "temp_widget", align = "right" })
wicked.register(temp_widget, 'function', function (widget, args)
    local cmd = "acpi -tB | awk '{print $4}' | cut -d'.' -f1"
    local f = io.popen(cmd)
    local l = f:read()
    f:close()
    return l and enclose('Temp: '..l..'°') or ""
end, 3)

netwidget = widget({
    type = 'textbox',
    align = 'right',
    name = 'netwidget'
})

wicked.register(netwidget, wicked.widgets.net,
                enclose('${eth0 down} / ${eth0 up} '),
nil, nil, 3)

-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = { button({ }, 1, awful.tag.viewonly),
                      button({ modkey }, 1, awful.client.movetotag),
                      button({ }, 3, function (tag) tag.selected = not tag.selected end),
                      button({ modkey }, 3, awful.client.toggletag),
                      button({ }, 4, awful.tag.viewnext),
                      button({ }, 5, awful.tag.viewprev) }
mytasklist = {}
mytasklist.buttons = { button({ }, 1, function (c)
                                          if not c:isvisible() then
                                              awful.tag.viewonly(c:tags()[1])
                                          end
                                          client.focus = c
                                          c:raise()
                                      end),
                       button({ }, 3, function () if instance then instance:hide() end instance = awful.menu.clients({ width=250 }) end),
                       button({ }, 4, function ()
                                          awful.client.focus.byidx(1)
                                          if client.focus then client.focus:raise() end
                                      end),
                       button({ }, 5, function ()
                                          awful.client.focus.byidx(-1)
                                          if client.focus then client.focus:raise() end
                                      end) }

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = widget({ type = "textbox", align = "left" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox", align = "right" })
    mylayoutbox[s]:buttons({ button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                             button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 5, function () awful.layout.inc(layouts, -1) end) })
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.noempty, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                                                  return awful.widget.tasklist.label.currenttags(c, s)
                                              end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = { mylauncher,
                           mytaglist[s],
                           mytasklist[s],
                           mypromptbox[s],
                           mytextbox,
                           mylayoutbox[s],

--                           battery_icon,
                           battery_widget_text,

                           netwidget,

--                           cpu_icon,
--                           cpufreq_widget,

--                           membar_icon,
                           membar_widget,

--                           temp_icon,
                           temp_widget,

--                           date_icon,
                           date_widget,

                           s == 1 and mysystray or nil }
			   mywibox[s].screen = s
		       end
		       -- }}}

		       -- {{{ Mouse bindings
		       root.buttons({
			   button({ }, 3, function () mymainmenu:toggle() end),
			   button({ }, 4, awful.tag.viewnext),
			   button({ }, 5, awful.tag.viewprev)
		       })
		       -- }}}

		       -- {{{ Key bindings
		       globalkeys =
		       {
			   key({ modkey,           }, "Left",   awful.tag.viewprev       ),
			   key({ modkey,           }, "Right",  awful.tag.viewnext       ),
			   key({ modkey,           }, "Escape", awful.tag.history.restore),

			   key({ modkey,           }, "j",
			   function ()
			       awful.client.focus.byidx( 1)
			       if client.focus then client.focus:raise() end
			   end),
			   key({ modkey,           }, "k",
			   function ()
			       awful.client.focus.byidx(-1)
			       if client.focus then client.focus:raise() end
			   end),

			   -- Layout manipulation
			   key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
			   key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),
			   key({ modkey, "Control" }, "j", function () awful.screen.focus( 1)       end),
			   key({ modkey, "Control" }, "k", function () awful.screen.focus(-1)       end),
			   key({ modkey,           }, "u", awful.client.urgent.jumpto),
			   key({ modkey,           }, "Tab",
			   function ()
			       awful.client.focus.history.previous()
			       if client.focus then
				   client.focus:raise()
			       end
			   end),

			   -- Jump to named tags
			   key({ modkey,           }, "m", function () awful.tag.viewonly(tags[mouse.screen][8]) end),
			   key({ modkey,           }, "w", function () awful.tag.viewonly(tags[mouse.screen][9]) end),
			   key({ modkey,           }, "i", function () awful.tag.viewonly(tags[mouse.screen][7]) end),

			   -- Standard program
			   key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
			   key({ modkey, "Control" }, "r", awesome.restart),
			   key({ modkey, "Shift"   }, "q", awesome.quit),

               -- Mine.
			   key({ modkey, "Shift"   }, "p", function () awful.util.spawn('mpc prev'); show_song() end),
			   key({ modkey, "Shift"   }, "n", function () awful.util.spawn('mpc next'); show_song() end),
			   --key({ modkey, "Shift"   }, "n", function () awful.util.spawn('mpc next') end),
			   key({ modkey, "Shift"   }, "w", function () awful.util.spawn('mpc toggle') end),
			   key({ modkey, "Shift"   }, "f", function () awful.util.spawn('firefox') end),
			   key({ modkey, "Shift"   }, "e", function () awful.util.spawn(editor_cmd) end),
			   key({ modkey, "Shift"   }, "o", function () awful.util.spawn('soffice') end),
               key({ modkey, "Shift"   }, "m", show_song),
               -- eof mine

			   key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
			   key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
			   key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
			   key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
			   key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
			   key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
			   key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
			   key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

			   -- Prompt
			   key({ modkey }, "F1",
			   function ()
			       awful.prompt.run({ prompt = "Run: " },
			       mypromptbox[mouse.screen],
			       awful.util.spawn, awful.completion.bash,
			       awful.util.getdir("cache") .. "/history")
			   end),

			   key({ modkey }, "p", function () awful.util.spawn('gmrun') end),

			   key({ modkey }, "F4",
			   function ()
			       awful.prompt.run({ prompt = "Run Lua code: " },
			       mypromptbox[mouse.screen],
			       awful.util.eval, awful.prompt.bash,
			       awful.util.getdir("cache") .. "/history_eval")
			   end),
		       }

		       -- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
		       clientkeys =
		       {
			   key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
			   key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
			   key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
			   key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
			   key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
			   key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
			   key({ modkey }, "t", awful.client.togglemarked),
               --[[
			   key({ modkey,}, "m",
			   function (c)
			       c.maximized_horizontal = not c.maximized_horizontal
			       c.maximized_vertical   = not c.maximized_vertical
			   end),
            --]]
		       }

		       -- Compute the maximum number of digit we need, limited to 9
		       keynumber = 0
		       for s = 1, screen.count() do
			   keynumber = math.min(9, math.max(#tags[s], keynumber));
		       end

		       for i = 1, keynumber do
			   table.insert(globalkeys,
			   key({ modkey }, i,
			   function ()
			       local screen = mouse.screen
			       if tags[screen][i] then
				   awful.tag.viewonly(tags[screen][i])
			       end
			   end))
			   table.insert(globalkeys,
			   key({ modkey, "Control" }, i,
			   function ()
			       local screen = mouse.screen
			       if tags[screen][i] then
				   tags[screen][i].selected = not tags[screen][i].selected
			       end
			   end))
			   table.insert(globalkeys,
			   key({ modkey, "Shift" }, i,
			   function ()
			       if client.focus and tags[client.focus.screen][i] then
				   awful.client.movetotag(tags[client.focus.screen][i])
			       end
			   end))
			   table.insert(globalkeys,
			   key({ modkey, "Control", "Shift" }, i,
			   function ()
			       if client.focus and tags[client.focus.screen][i] then
				   awful.client.toggletag(tags[client.focus.screen][i])
			       end
			   end))
		       end


		       for i = 1, keynumber do
			   table.insert(globalkeys, key({ modkey, "Shift" }, "F" .. i,
			   function ()
			       local screen = mouse.screen
			       if tags[screen][i] then
				   for k, c in pairs(awful.client.getmarked()) do
				       awful.client.movetotag(tags[screen][i], c)
				   end
			       end
			   end))
		       end

		       -- Set keys
		       root.keys(globalkeys)
		       -- }}}

		       -- {{{ Hooks
		       -- Hook function to execute when focusing a client.
		       awful.hooks.focus.register(function (c)
			   if not awful.client.ismarked(c) then
			       c.border_color = beautiful.border_focus
			   end
		       end)

		       -- Hook function to execute when unfocusing a client.
		       awful.hooks.unfocus.register(function (c)
			   if not awful.client.ismarked(c) then
			       c.border_color = beautiful.border_normal
			   end
		       end)

		       -- Hook function to execute when marking a client
		       awful.hooks.marked.register(function (c)
			   c.border_color = beautiful.border_marked
		       end)

		       -- Hook function to execute when unmarking a client.
		       awful.hooks.unmarked.register(function (c)
			   c.border_color = beautiful.border_focus
		       end)

		       -- Hook function to execute when the mouse enters a client.
		       awful.hooks.mouse_enter.register(function (c)
			   -- Sloppy focus, but disabled for magnifier layout
			   if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
			       and awful.client.focus.filter(c) then
			       client.focus = c
			   end
		       end)

		       -- Hook function to execute when a new client appears.
		       awful.hooks.manage.register(function (c, startup)
			   -- If we are not managing this application at startup,
			   -- move it to the screen where the mouse is.
			   -- We only do it for filtered windows (i.e. no dock, etc).
			   if not startup and awful.client.focus.filter(c) then
			       c.screen = mouse.screen
			   end

			   if use_titlebar then
			       -- Add a titlebar
			       awful.titlebar.add(c, { modkey = modkey })
			   end
			   -- Add mouse bindings
			   c:buttons({
			       button({ }, 1, function (c) client.focus = c; c:raise() end),
			       button({ modkey }, 1, awful.mouse.client.move),
			       button({ modkey }, 3, awful.mouse.client.resize)
			   })
			   -- New client may not receive focus
			   -- if they're not focusable, so set border anyway.
			   c.border_width = beautiful.border_width
			   c.border_color = beautiful.border_normal

			   -- Check if the application should be floating.
			   local cls = c.class
			   local inst = c.instance
			   if floatapps[cls] then
			       awful.client.floating.set(c, floatapps[cls])
			   elseif floatapps[inst] then
			       awful.client.floating.set(c, floatapps[inst])
			   end

			   -- Check application->screen/tag mappings.
			   local target
			   if apptags[cls] then
			       target = apptags[cls]
			   elseif apptags[inst] then
			       target = apptags[inst]
			   end
			   if target then
			       c.screen = target.screen
			       awful.client.movetotag(tags[target.screen][target.tag], c)
			   end

			   -- Do this after tag mapping, so you don't see it on the wrong tag for a split second.
			   client.focus = c

			   -- Set key bindings
			   c:keys(clientkeys)

			   -- Set the windows at the slave,
			   -- i.e. put it at the end of others instead of setting it master.
			   -- awful.client.setslave(c)

			   -- Honor size hints: if you want to drop the gaps between windows, set this to false.
			   c.size_hints_honor = false
		       end)

		       -- Hook function to execute when arranging the screen.
		       -- (tag switch, new client, etc)
		       awful.hooks.arrange.register(function (screen)
			   local layout = awful.layout.getname(awful.layout.get(screen))
			   if layout and beautiful["layout_" ..layout] then
			       mylayoutbox[screen].image = image(beautiful["layout_" .. layout])
			   else
			       mylayoutbox[screen].image = nil
			   end

			   -- Give focus to the latest client in history if no window has focus
			   -- or if the current window is a desktop or a dock one.
			   if not client.focus then
			       local c = awful.client.focus.history.get(screen, 0)
			       if c then client.focus = c end
			   end
		       end)

		       -- Hook called every minute
		       awful.hooks.timer.register(60, function ()
			   mytextbox.text = os.date(" %a %b %d, %H:%M ")
		       end)

               awful.hooks.timer.register(5, memInfo)
		       -- }}}
