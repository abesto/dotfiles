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
   {"chromium" , "chromium"},
   {"opera"    , "opera"}
}

apps_menu = {
   {"charles"     , "sh /home/abesto/charles/bin/charles.sh"},
   {"gmpc"        , "gmpc"},
   {"wicd-client" , "wicd-client"},
   {"nm-applet"   , "nm-applet"},
   {"gimp"        , "gimp"},
   {"codeblocks"  , "codeblocks"}
}

-- start, restart, stop daemons
-- table element is {name, start command, restart command, stop command}
daemons = {}
-- standard daemons in /etc/rc.d/
rc="/etc/rc.d/"
for i, d in ipairs({"mpd", "wicd", "network-manager"}) do
   table.insert(daemons, {d,
                          "gksudo -D'Start the "..d.." daemon' "..rc..d.." start",
                          "gksudo -D'Restart the "..d.." daemon' "..rc..d.." restart",
                          "gksudo -D'Stop the "..d.." daemon' "..rc..d.." stop"
                       }
             )
end
-- non-standard daemons
table.insert(daemons, {"emacs", "emacs --daemon", "killall emacs && emacs --daemon", "killall emacs"})
table.insert(daemons, {"conkeror", "conkeror -daemon", "killall xulrunner; killall xulrunner-bin; conkeror -daemon", "killall xulrunner; killall xulrunner-bin"})

daemons_menu = {}
for i, d in ipairs(daemons) do
   table.insert(daemons_menu,
                {
                   d[1], {
                      {'start', d[2]},
                      {'restart', d[3]},
                      {'stop', d[4]}
                   }
                }
             )
end

mymainmenu = awful.menu.new({ items = { { "awesome" },
                                        { "browsers" , browser_menu },
                                        { "apps"     , apps_menu},
                                        { "daemons" , daemons_menu},
                                        { "---" },
                                        { "reboot", "sudo reboot" },
                                        { "poweroff" , "sudo poweroff" }
                                      }
                            })
