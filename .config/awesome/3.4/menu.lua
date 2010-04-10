awesome_config_menu = {{"rc.lua", editor_cmd..' '..basedir..'rc.lua'}}
for i, f in ipairs(files) do
   table.insert(awesome_config_menu, {f, editor_cmd..' '..basedir..f..".lua"})
end

awesome_menu = {
   { "manual"      , terminal .. " -e man awesome"},
   { "edit config" , awesome_config_menu},
   { "restart"     , awesome.restart },
   { "quit"        , awesome.quit }
}

browser_menu = {
   {"conkeror" , "conkeror"},
   {"firefox"  , "firefox"},
   {"iron"     , "iron"},
   {"opera"    , "opera"}
}

apps_menu = {
   {"charles"     , "sh /home/abesto/charles/bin/charles.sh"},
   {"gmpc"        , "gmpc"},
   {"wicd-client" , "wicd-client"},
   {"nm-applet"   , "ck-launch-session nm-applet"},
   {"gimp"        , "gimp"},
   {"codeblocks"  , "codeblocks"}
}


daemons_menu = {}
function daemon_menu(d)
   return {
      d[1], {
         {'start', d[2]},
         {'restart', d[3]},
         {'stop', d[4]}
      }
   }
end

-- rc loaded in daemons.lua
rc_menu = {}
for i, d in ipairs(rc) do
   table.insert(rc_menu, daemon_menu(d))
end
table.insert(daemons_menu, {'/etc/rc.d/', rc_menu})

-- daemons loaded in daemons.lua
for i,d in ipairs(daemons) do
   table.insert(daemons_menu, daemon_menu(d))
end

mymainmenu = awful.menu.new({ items = { { "awesome", awesome_config_menu },
                                        { "browsers" , browser_menu },
                                        { "apps"     , apps_menu},
                                        { "daemons" , daemons_menu},
                                        { "---" },
					{ "suspend", "sudo pm-suspend" },
					{ "hibernate", "sudo pm-hibernate" },
					{ '---' },
                                        { "reboot", "sudo reboot" },
                                        { "poweroff" , "sudo poweroff" }
                                      }
                            })
