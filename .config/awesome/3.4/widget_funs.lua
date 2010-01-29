function colorize (text, color)
   return '<span color="' .. color .. '">' .. text .. '</span>'
end
--

function highlight(text)
   return '<span color="#ededdd"><b>'..text..'</b></span>'
end
--

enclose_pre = colorize('[', '#f0dfaf')
enclose_post = colorize(']', '#f0dfaf')
function enclose (text)
   return enclose_pre .. text .. enclose_post
end
--

function show_song (hide_duration)
   local np_file = io.popen('mpc --format "%title% - %artist%\n%album%" 2> /dev/null')
   local track = np_file:read("*line")
   local album = np_file:read("*line")
   local icon = ''

   if track == nil or track:find("volume:") then
      return
   else
      track = track:gsub('&', '&amp;')
      album = album:gsub('&', '&amp;')

      local status = np_file:read("*line")
      np_file:close()

      if status:find("playing") then
         icon = icon_play
      else
         icon = icon_stop
      end

      local dur_pattern = "%d+:%d+/%d+:%d+"
      local duration = string.find(status, dur_pattern) and string.sub(status, string.find(status, dur_pattern)) or ""
      local text = album
      if hide_duration == nil then text = text .. "\n" .. duration end

      mnot =  naughty.notify({
                                title = track,
                                text = text,
                                icon = icon,
                             })
   end
   vicious.update(mpd_widget)
end
