-- System libs --
require("awful")
require("beautiful")  -- Theme handling library
require("wicked")     -- Widgets :p
require("naughty")    -- Notification library

-- Custom stuff --
basedir = "/home/abesto/.config/awesome/3.3/"
dofile (basedir .. "generic.lua" ) -- theme, commands and autorun apps
dofile (basedir .. "layout.lua"  ) -- tags, layout, window rules
dofile (basedir .. "widget_funs.lua" ) -- data providers for the info widgets
dofile (basedir .. "widgets.lua" ) -- info widgets
dofile (basedir .. "mouse.lua"   ) -- mouse bindings
dofile (basedir .. "keyboard.lua") -- key bindings
dofile (basedir .. "hooks.lua"   ) -- hooks

-- execute autorun apps specified in generic.lua
autorun = true
if autorun then
   for app = 1, #autorunApps do
      awful.util.spawn(autorunApps[app])
   end
end
