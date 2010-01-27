-- Widget colors
widget_fg        = beautiful.widget_bg        or beautiful.fg_normal
widget_fg_center = beautiful.widget_fg_center or beautiful.fg_normal
widget_fg_end    = beautiful.widget_fg_end    or beautiful.fg_urgent
widget_fg_off    = beautiful.widget_fg_off    or beautiful.fg_normal
widget_bg        = beautiful.widget_fg        or beautiful.bg_focus
widget_border    = beautiful.widget_border    or beautiful.border_focus

-- Widget icons
icon_cpu  = beautiful.icon_cpu  or awful.util.getdir("config") .. "/themes/default/icons/cpu.png"
icon_bat  = beautiful.icon_bat  or awful.util.getdir("config") .. "/themes/default/icons/bat.png"
icon_mem  = beautiful.icon_mem  or awful.util.getdir("config") .. "/themes/default/icons/mem.png"
icon_time = beautiful.icon_time or awful.util.getdir("config") .. "/themes/default/icons/time.png"
icon_temp = beautiful.icon_temp or awful.util.getdir("config") .. "/themes/default/icons/temp.png"
icon_play = beautiful.icon_play or awful.util.getdir("config") .. "/themes/default/icons/play.png"
icon_stop = beautiful.icon_stop or awful.util.getdir("config") .. "/themes/default/icons/stop.png"

-- Spacer
spacer = " "
spacer_widget = widget({ type = "textbox", name = "spacer_widget", align = "right" })
spacer_widget.text = spacer

-- Date
date_widget = widget({ type = "textbox", name = "date_widget", align = "right" })
date_widget:buttons({button({ }, 1, function () awful.util.spawn("org") end)})
wicked.register(date_widget, "date", enclose("%d %b, %H:%M"))

-- Battery
battery_widget_text = widget({ type = "textbox", name = "battery_widget_text", align = "right" })
wicked.register(battery_widget_text, 'function', function (widgets, args)
                                                    local cmd = "acpi -b"
                                                    local f = io.popen(cmd)
                                                    local l = f:read()
                                                    f:close()

                                                    local text

                                                    if string.find(l, "Discharging") then
                                                       battery_widget_text.visible = true
                                                       local perc = string.sub(l, string.find(l, "%d*%d*%d%%"))
                                                       local remaining = string.sub(l, string.find(l, "%d*%d*:*%d*%d*:%d%d"))
                                                       text = highlight('Bat: ') .. remaining .. " (" .. perc .. ")"
                                                    else
                                                       battery_widget_text.visible = false
                                                    end

                                                    return text and enclose(text)
                                                 end, 10)

-- Memory
membar_widget     = widget({ type = "textbox", name = "membar_widget", align = "right" })

-- CPU
cpuwidget = widget({
                      type = 'textbox',
                      name = 'cpuwidget',
                      align = 'right'
                   })
wicked.register(cpuwidget, wicked.widgets.cpu,
                enclose(highlight('CPU: ').."$1%"))

-- Network
netwidget = widget({
                      type = 'textbox',
                      align = 'right',
                      name = 'netwidget'
                   })
wicked.register(netwidget, wicked.widgets.net,
                enclose(highlight('Net: ')..'${wlan0 down} / ${wlan0 up} '),
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
                          mylayoutbox[s],
                          battery_widget_text,
                          netwidget,
                          membar_widget,
                          cpuwidget,
                          date_widget,
                          mysystray,
                       }
   mywibox[s].screen = s
end
