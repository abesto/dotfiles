timer = timer({ timeout = 3 })

-- Date
date_widget = widget({ type = "textbox", name = "date_widget" })
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
                 enclose(highlight('Mem: ') .. "$1% ($2M / $3M)"), 5)

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
                 enclose(highlight("Net: ") .. "${wlan0 down_kb}k / ${wlan0 up_kb}k", 2))

-- MPD
mpd_widget = widget({type = 'textbox', name = 'mpdwidget' })
vicious.register(mpd_widget, vicious.widgets.mpd, enclose(highlight('MPD: ') .. '$1'), 7, {40, 'mpdwidget'})

-- Volume
volume_widget = widget({
                          type = 'textbox',
                          name = 'volumewidget'
                       })
vicious.register(volume_widget, vicious.widgets.volume,
                 enclose(highlight("Vol: ") .. "$1%"), 3, 'Master')

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
top = {}
bottom = {}
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
   mylayoutbox[s] = awful.widget.layoutbox(s)

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
                                            cpu_widget,
                                            membar_widget,
                                            netwidget,
                                            battery_widget_text,
                                            mpd_widget,
                                            volume_widget,
                                            layout = awful.widget.layout.horizontal.leftright
                                         },
                                         {
                                            mysystray,
                                            date_widget,
                                            mylayoutbox[s],
                                            layout = awful.widget.layout.horizontal.rightleft
                                         },
                                         layout = awful.widget.layout.horizontal.leftright
                                      }
                           })
end

timer:emit_signal("timeout")
timer:start()
