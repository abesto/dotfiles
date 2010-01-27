-- System libs --
require("awful")
require("awful.rules")
require("awful.autofocus")
require("beautiful")  -- Theme handling library
require("vicious")    -- Widgets :p
require("naughty")    -- Notification library

-- Custom stuff --
basedir = "/home/abesto/.config/awesome/3.4/"
dofile (basedir .. "generic.lua" ) -- theme, commands and autorun apps
dofile (basedir .. "widget_funs.lua" ) -- data providers for the info widgets
dofile (basedir .. "widgets.lua" ) -- info widgets
dofile (basedir .. "layout.lua"  ) -- tags, layout
dofile (basedir .. "hooks.lua"   ) -- hooks
dofile (basedir .. "keyboard.lua") -- key bindings
dofile (basedir .. "mouse.lua"   ) -- mouse bindings
dofile (basedir .. "rules.lua"  )  -- window rules

-- execute autorun apps specified in generic.lua
autorun = false
if autorun then
   for app = 1, #autorunApps do
      awful.util.spawn(autorunApps[app])
   end
end
