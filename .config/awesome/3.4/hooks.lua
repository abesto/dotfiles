-- Hook function to execute when focusing a client.
client.add_signal("focus", function (c)
                              if not awful.client.ismarked(c) then
                                 c.border_color = beautiful.border_focus
                              end
                           end)

-- Hook function to execute when unfocusing a client.
client.add_signal("unfocus", function (c)
                                if not awful.client.ismarked(c) then
                                   c.border_color = beautiful.border_normal
                                end
                             end)

-- Hook function to execute when marking a client
client.add_signal("marked", function (c)
                               c.border_color = beautiful.border_marked
                            end)

-- Hook function to execute when unmarking a client.
client.add_signal("unmarked", function (c)
                                 c.border_color = beautiful.border_focus
                              end)

-- Hook function to execute when the mouse enters a client.
client.add_signal("mouse::enter", function (c)
                                    -- Sloppy focus, but disabled for magnifier layout
                                    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                                    and awful.client.focus.filter(c) then
                                    client.focus = c
                                 end
                              end)

-- Hook function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
                               if use_titlebar then
                                  awful.titlebar.add(c, { modkey = modkey })
                               end

                               -- Check if the application should be floating.
                               -- should be ported to rules.lua
                               local cls = c.class
                               local inst = c.instance
                               if floatapps[cls] then
                                  awful.client.floating.set(c, floatapps[cls])
                                  c.ontop = true
                               elseif floatapps[inst] then
                                  awful.client.floating.set(c, floatapps[inst])
                               end

                               -- Check application->screen/tag mappings.
                               -- could be ported to rules.lua
                               local target
                               if apptags[cls] then
                                  target = apptags[cls]
                               elseif apptags[inst] then
                                  target = apptags[inst]
                               end
                               if target then
                                  local scr
                                  if target.screen and screen.count() >= target.screen then
                                     scr = target.screen
                                  else
                                     scr = mouse.screen
                                  end
                                  c.screen = scr
                                  awful.client.movetotag(tags[scr][target.tag], c)
                                  awful.tag.viewonly(tags[scr][target.tag])
                               else
                                  c.screen = mouse.screen
                               end
                            end)

-- Hook function to execute when arranging the screen.
-- (tag switch, new client, etc)
