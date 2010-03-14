theme_path = "/usr/share/awesome/themes/zenburn/theme.lua"
beautiful.init(theme_path)

naughty.config.presets.normal.timeout = 3
naughty.config.presets.normal.screen = 1

terminal     = "urxvt"
--editor_cmd = terminal .. " -e " .. editor
--editor_cmd = "urxvt -T 'emacs@keyrit' -e emacsclient -t"
editor_cmd   = 'emacsclient --alternate-editor="" -c'
browser      = "conkeror"
im           = "urxvt -name 'im' -T 'im' -e '/home/abesto/bin/im'"
mutt         = "urxvt -name 'conapp' -e '/home/abesto/bin/mutt'"

-- Autorun programs
autorunApps =
   {
   "/home/abesto/bin/nm",
   --"wicd-client",
   "mpdscribble",
   "setxkbmap -option terminate:ctrl_alt_bksp", -- Zap X
   "emacs --daemon",
   mutt,
   "conky",
   "wmname LG3D",  -- for Java apps, see http://bbs.archlinux.org/viewtopic.php?pid=450870#p450870
   "/home/abesto/bin/keyb",
   "canto-fetch -fd",
   "conkeror -daemon"
}
