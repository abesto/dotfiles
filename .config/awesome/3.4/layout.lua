layouts = {
   awful.layout.suit.max,
   awful.layout.suit.tile,
   awful.layout.suit.tile.top,
   awful.layout.suit.floating
}

use_titlebar = false

tags = {}
for s = 1, screen.count() do
   -- Each screen has its own tag table.
   tags[s] = awful.tag({1, 2, 3, 4, 5, 6, 'im', 'mail', 'www'}, s, layouts[1])
end
