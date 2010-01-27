layouts =
   {
   awful.layout.suit.max,
   awful.layout.suit.tile,
   awful.layout.suit.tile.top,
   awful.layout.suit.floating
}

floatapps =
   {
   ["MPlayer"] = true,
   ["gimp"] = true,
   ["vlc"] = true,
}

apptags =
   {
   ["Navigator"] = { tag = 9 },
   ["conapp"] = { screen = 2, tag = 8 },
   ["pidgin"] = {screen = 2, tag = 7},
   ["skype"] = {screen = 1, tag = 7},
   ["im"] = {screen = 1, tag = 7},
}

use_titlebar = false

tags = {}
for s = 1, screen.count() do
   -- Each screen has its own tag table.
   tags[s] = {}
   -- Create 9 tags per screen.
   for num,name in ipairs({1, 2, 3, 4, 5, 6, 'im', 'mail', 'www'}) do
      tags[s][num] = tag(name)
      -- Add tags to screen one by one
      tags[s][num].screen = s
      awful.layout.set(layouts[1], tags[s][num])
   end
   -- I'm sure you want to see at least one tag.
   tags[s][1].selected = true
end
