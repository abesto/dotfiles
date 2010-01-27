modkey = "Mod4"

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
   key({ modkey, "Control" }, "j", function () awful.screen.focus( 1) end),
   key({ modkey, "Control" }, "k", function () awful.screen.focus(-1) end),
   key({ modkey,           }, "u", awful.client.urgent.jumpto),
   key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
   key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
   key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
   key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
   key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
   key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
   key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
   key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

   -- Multimedia keys
   key({},                    "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 5%+") end),
   key({},                    "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 5%-") end),
   key({},                    "XF86AudioMute",        function () awful.util.spawn("amixer set Master toggle") end),
   key({},                    "XF86AudioPlay",        function () awful.util.spawn("mpc toggle") end),
   key({},                    "XF86HomePage",         function () awful.util.spawn(browser) end),
   key({},                    "XF86Mail",             function () awful.util.spawn(mutt) end),
   key({},                    "XF86Search",           function () awful.util.spawn(browser .. " http://google.com") end),

   -- Jump to named tags
   key({ modkey,           }, "m", function () awful.tag.viewonly(tags[mouse.screen][8]) end),
   key({ modkey,           }, "w", function () awful.tag.viewonly(tags[mouse.screen][9]) end),
   key({ modkey,           }, "i", function () awful.tag.viewonly(tags[mouse.screen][7]) end),

   -- Standard programs
   key({ modkey            }, "Return", function () awful.util.spawn(terminal) end),
   key({ modkey, "Control" }, "r", awesome.restart),
   key({ modkey, "Shift"   }, "q", awesome.quit),

   -- Application launchers
   key({ modkey, "Shift"   }, "f", function () awful.util.spawn(browser) end),
   key({ modkey, "Shift"   }, "e", function () awful.util.spawn(editor_cmd) end),
   key({ modkey, "Shift"   }, "o", function () awful.util.spawn('soffice') end),
   key({ modkey, "Shift"   }, "i", function () awful.util.spawn(im) end),
   key({ modkey            }, "b", function () awful.util.spawn('/home/abesto/bin/bugmenot') end),
   key({ modkey            }, ",", function () awful.util.spawn('perl /home/abesto/bin/lyrics.pl') end),
   key({ modkey            }, "r", function () rodentbane.start() end),
   key({ modkey, "Shift"   }, "b", function () awful.util.spawn('/home/abesto/bin/cleartheme codeblocks') end),
   key({ modkey            }, "p", function () awful.util.spawn('gmrun') end),

   -- Commands
   key({ modkey, "Shift"   }, "p", function () awful.util.spawn('mpc prev'); show_song(true) end),
   key({ modkey, "Shift"   }, "n", function () awful.util.spawn('mpc next'); show_song(true) end),
   key({ modkey, "Shift"   }, "w", function () awful.util.spawn('mpc toggle') end),
   key({ modkey, "Shift"   }, "m", show_song),
} -- globalkeys

clientkeys =
   {
   key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
   key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
   key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
   key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
   key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
   key({ modkey            }, "t",      awful.client.togglemarked),
   key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop end)
}

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
   -- modkey+i = switch to tag
   table.insert(globalkeys,
                key({ modkey }, i,
                    function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                          awful.tag.viewonly(tags[screen][i])
                       end
                    end))
   -- modkey+control+i = toggle selection of tag
   table.insert(globalkeys,
                key({ modkey, "Control" }, i,
                    function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                          tags[screen][i].selected = not tags[screen][i].selected
                       end
                    end))
   -- modkey+shift+i = move client to tag
   table.insert(globalkeys,
                key({ modkey, "Shift" }, i,
                    function ()
                       if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                       end
                    end))
   -- modkey+control+shift+i = toggle client on tag
   table.insert(globalkeys,
                key({ modkey, "Control", "Shift" }, i,
                    function ()
                       if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                       end
                    end))
   -- modkey+shift+Fi = move marked clients to tag
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

root.keys(globalkeys)
