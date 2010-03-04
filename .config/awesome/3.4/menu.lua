awesome_menu = {
   { "manual"      , terminal .. " -e man awesome" },
   { "edit config" , editor_cmd .. " ~/.config/awesome/rc.lua" },
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
   {"gimp"        , "gimp"},
   {"gmpc"        , "gmpc"},
   {"wicd-client" , "wicd-cliend"},
   {"nm-applet"   , "nm-applet"},
   {"codeblocks"  , "codeblocks"}
}

mymainmenu = awful.menu.new({ items = { { "awesome"  , awesome_menu, beautiful.awesome_icon },
                                        { "browsers" , browser_menu },
                                        { "apps"     , apps_menu},
                                        { "---" },
                                        { "reboot", "sudo reboot" },
                                        { "poweroff" , "sudo shutdown" }
                                      }
                            })
