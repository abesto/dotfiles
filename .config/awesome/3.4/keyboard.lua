modkey = "Mod4"
function toggle_screen ()
   if mouse.screen == 1 then
      awful.screen.focus(2)
   else
      awful.screen.focus(1)
   end
end

globalkeys = awful.util.table.join(
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
   awful.key({ modkey,           }, "j",
             function ()
                awful.client.focus.byidx( 1)
                if client.focus then client.focus:raise() end
             end),
   awful.key({ modkey,           }, "k",
             function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
             end),

   -- Layout manipulation

   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),
   awful.key({ modkey, "Control" }, "j", toggle_screen),
   awful.key({ modkey, "Control" }, "k", toggle_screen),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
   awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
   awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

   -- Multimedia keys
   awful.key({},                    "XF86AudioRaiseVolume",
             function () awful.util.spawn("amixer set Master 5%+"); vicious.update(volume_widget) end),
   awful.key({},                    "XF86AudioLowerVolume",
             function () awful.util.spawn("amixer set Master 5%-"); vicious.update(volume_widget) end),
   awful.key({},                    "XF86AudioMute",
             function () awful.util.spawn("amixer set Master toggle"); vicious.update(volume_widget) end),
   awful.key({},                    "XF86AudioPlay",        function () awful.util.spawn("mpc toggle") end),
   awful.key({},                    "XF86HomePage",         function () awful.util.spawn(browser) end),
   awful.key({},                    "XF86Mail",             function () awful.util.spawn(mutt) end),
   awful.key({},                    "XF86Search",           function () awful.util.spawn(browser .. " http://google.com") end),

   -- Jump to named tags
   awful.key({ modkey,           }, "m", function () awful.tag.viewonly(tags[mouse.screen][8]) end),
   awful.key({ modkey,           }, "w", function () awful.tag.viewonly(tags[mouse.screen][9]) end),
   awful.key({ modkey,           }, "i", function () awful.tag.viewonly(tags[mouse.screen][7]) end),

   -- Standard programs
   awful.key({ modkey            }, "Return", function () awful.util.spawn(terminal) end),
   awful.key({ modkey, "Control" }, "r", awesome.restart),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit),

   -- Application launchers
   awful.key({ modkey, "Shift"   }, "f", function () awful.util.spawn(browser) end),
   awful.key({ modkey, "Shift"   }, "e", function () awful.util.spawn(editor_cmd) end),
   awful.key({ modkey, "Shift"   }, "o", function () awful.util.spawn('soffice') end),
   awful.key({ modkey, "Shift"   }, "i", function () awful.util.spawn(im) end),
   awful.key({ modkey            }, "b", function () awful.util.spawn('/home/abesto/bin/bugmenot') end),
   awful.key({ modkey            }, ",", function () awful.util.spawn('perl /home/abesto/bin/lyrics.pl') end),
   awful.key({ modkey            }, "r", function () rodentbane.start() end),
   awful.key({ modkey, "Shift"   }, "b", function () awful.util.spawn('/home/abesto/bin/cleartheme codeblocks') end),
   awful.key({ modkey            }, "p", function () awful.util.spawn('gmrun') end),

   -- Commands
   awful.key({ modkey, "Shift"   }, "p", function () awful.util.spawn('mpc prev'); show_song(true) end),
   awful.key({ modkey, "Shift"   }, "n", function () awful.util.spawn('mpc next'); show_song(true) end),
   awful.key({ modkey, "Shift"   }, "w", function () awful.util.spawn('mpc toggle') end),
   awful.key({ modkey, "Shift"   }, "m", show_song)
) -- globalkeys

clientkeys = awful.util.table.join(
   awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
   awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
   awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
   awful.key({ modkey            }, "t",      awful.client.togglemarked),
   awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
   -- modkey+i = switch to tag
   globalkeys = awful.util.table.join(globalkeys,
                awful.key({ modkey }, i,
                          function ()
                             local screen = mouse.screen
                             awful.tag.viewonly(tags[screen][i])
                          end))
   -- modkey+control+i = toggle selection of tag
   globalkeys = awful.util.table.join(globalkeys,
                awful.key({ modkey, "Control" }, i,
                          function ()
                             local screen = mouse.screen
                             if tags[screen][i] then
                                tags[screen][i].selected = not tags[screen][i].selected
                             end
                          end))
   -- modkey+shift+i = move client to tag
   globalkeys = awful.util.table.join(globalkeys,
                awful.key({ modkey, "Shift" }, i,
                          function ()
                             if client.focus and tags[client.focus.screen][i] then
                                awful.client.movetotag(tags[client.focus.screen][i])
                             end
                          end))
   -- modkey+control+shift+i = toggle client on tag
   globalkeys = awful.util.table.join(globalkeys,
                awful.key({ modkey, "Control", "Shift" }, i,
                          function ()
                             if client.focus and tags[client.focus.screen][i] then
                                awful.client.toggletag(tags[client.focus.screen][i])
                             end
                          end))
   -- modkey+shift+Fi = move marked clients to tag
   globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, "F" .. i,
                                      function ()
                                         local screen = mouse.screen
                                         if tags[screen][i] then
                                            for k, c in pairs(awful.client.getmarked()) do
                                               awful.client.movetotag(tags[screen][i], c)
                                            end
                                         end
                                      end))
end

root.keys(globalkeys)
