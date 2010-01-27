-- Sysinfo update timer
timer = timer({ timeout = 3 })

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

-- Enclosing
enclose_pre_widget = widget({ type = "textbox", name = "enclose_pre_widget", text = enclose_pre })
enclose_post_widget = widget({ type = "textbox", name = "enclose_post_widget", text = enclose_post })

-- Date
date_widget = widget({ type = "textbox", name = "date_widget" })
date_widget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn("org") end)))
timer:add_signal("timeout", function() date_widget.text = enclose(os.date("%d %b, %H:%M")) end)

-- Battery
battery_widget_text = widget({ type = "textbox", name = "battery_widget_text" })
timer:add_signal("timeout", function (widgets, args)
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

                               if text then battery_widget_text.text = enclose(text) end
                            end
              )

-- Memory
membar_widget     = widget({ type = "textbox", name = "membar_widget" })
vicious.register(membar_widget, vicious.widgets.mem,
                 enclose(highlight('Mem: ') .. "$1% ($2M / $3M)"), 3)

-- CPU
cpu_widget = widget({
                      type = 'textbox',
                      name = 'cpuwidget',
                   })
vicious.register(cpu_widget, vicious.widgets.cpu,
                 enclose(highlight('CPU: ') .. "$1% ($2% | $3%)"),
                 3
              )

-- Network
netwidget = widget({
                      type = 'textbox',
                      name = 'netwidget'
                   })
vicious.register(netwidget, vicious.widgets.net,
                 enclose(highlight("Net: ") .. "${wlan0 down_kb}k / ${wlan0 up_kb}k", 3))

-- MPD
mpd_widget = widget({type = 'textbox', name = 'mpdwidget' })
vicious.register(mpd_widget, vicious.widgets.mpd, enclose(highlight('MPD: ') .. '$1'), 3, {40, 'mpdwidget'})

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
top = {}
bottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
   awful.button({ }, 1, awful.tag.viewonly),
   awful.button({ modkey }, 1, awful.client.movetotag),
   awful.button({ }, 3, function (tag) tag.selected = not tag.selected end),
   awful.button({ modkey }, 3, awful.client.toggletag),
   awful.button({ }, 4, awful.tag.viewnext),
   awful.button({ }, 5, awful.tag.viewprev)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
   awful.button({ }, 1, function (c)
                     if not c:isvisible() then
                        awful.tag.viewonly(c:tags()[1])
                     end
                     client.focus = c
                     c:raise()
                  end),
   awful.button({ }, 3, function () if instance then instance:hide() end instance = awful.menu.clients({ width=250 }) end),
   awful.button({ }, 4, function ()
                     awful.client.focus.byidx(1)
                     if client.focus then client.focus:raise() end
                  end),
   awful.button({ }, 5, function ()
                     awful.client.focus.byidx(-1)
                     if client.focus then client.focus:raise() end
                  end)
)

for s = 1, screen.count() do
   -- Create an imagebox widget which will contains an icon indicating which layout we're using.
   -- We need one layoutbox per screen.
   mylayoutbox[s] = widget({ type = "imagebox" })
   mylayoutbox[s]:buttons( awful.util.table.join(
                              awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                              awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                              awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                              awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end) ))
   -- Create a taglist widget
   mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.noempty, mytaglist.buttons)

   -- Create a tasklist widget
   mytasklist[s] = awful.widget.tasklist.new(function(c)
                                                return awful.widget.tasklist.label.currenttags(c, s)
                                             end, mytasklist.buttons)

   -- Create the wiboxes
   top[s] = awful.wibox({
                           position = "top",
                           screen = s,
                           fg = beautiful.fg_normal,
                           bg = beautiful.bg_normal,
                           widgets = {{
                                         mytaglist[s],
                                         mytasklist[s],
                                         layout = awful.widget.layout.horizontal.leftright
                                      },
                                      layout = awful.widget.layout.horizontal.leftright
                                   }
                        })

   bottom[s] = awful.wibox({
                              position = "bottom",
                              screen = s,
                              fg = beautiful.fg_normal,
                              bg = beautiful.bg_normal,
                              widgets = {{
                                            mysystray,
                                            date_widget,
                                            cpu_widget,
                                            membar_widget,
                                            netwidget,
                                            battery_widget_text,
                                            mpd_widget,
                                            mylayoutbox[s],
                                            layout = awful.widget.layout.horizontal.leftright
                                         },
                                         layout = awful.widget.layout.horizontal.leftright
                                      }
                           })
end

timer:emit_signal("timeout")
timer:start()
