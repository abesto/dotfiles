basedir = "/home/abesto/.config/awesome/3.4/"

-- System libs --
require("awful")
require("awful.rules")
require("awful.autofocus")
require("beautiful")  -- Theme handling library
require("vicious")    -- Widgets :p
require("naughty")    -- Notification library

-- 3rd party libs --
dofile (basedir .. "lib/revelation.lua")

-- Custom stuff --
files = {
   "generic",     -- theme, commands and autorun apps
   "menu",        -- menu setup
   "widget_funs", -- data providers for the info widgets
   "widgets",     -- info widgets
   "layout",      -- tags, layout
   "hooks",       -- hooks
   "keyboard",    -- key bindings
   "mouse",       -- mouse bindings
   "rules"        -- window rules
}
for index, file in ipairs(files) do
   dofile (basedir .. file .. ".lua"  )
end


-- execute autorun apps specified in generic.lua
autorun = true
if autorun then
   for app = 1, #autorunApps do
      awful.util.spawn(autorunApps[app])
   end
end
