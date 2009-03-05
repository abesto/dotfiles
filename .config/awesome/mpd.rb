#Ruby MPD wrapper

require 'rubygems'
require 'librmpd'

HOST = "localhost"
PORT = 6600

mpd = MPD.new HOST, PORT

mpd.connect
#mpd.password('mypassword')
if mpd.stopped?
    mpd.play
end
song = mpd.current_song

#Time calculation
time = mpd.status["time"]
time = time.split(':')
elapsed = time[0].to_i
el_min = elapsed / 60
el_sec = elapsed % 60
elapsed = "#{el_min}:#{el_sec}"

total = time[1].to_i
tot_min = total / 60
tot_sec = total % 60
total = "#{tot_min}:#{tot_sec}"

time = "#{elapsed}/#{total}"


#Adjusting output of Artist
artist = "#{song.artist}"
artist.gsub!(/ & /, '/')

#Adjusting output of Title
title = "#{song.title}"
title.gsub!(/_/, ' ')
title.gsub!(/ & /, '/')
title.gsub!(/feat/i, 'Ft')
title.gsub!(/remix/i, 'rmx')

#Some hacky to get correct output if id3tags are strange
if artist.empty?
    puts "#{song.file}\n#{time}"
elsif title.empty?
    puts "#{song.file}\n#{time}"
elsif artist =~ /artist/i
    puts "#{song.file}\n#{time}"
elsif title =~ /track/i
    puts "#{song.file}\n#{time}"
else
    puts "#{artist} - #{title}\n#{time}"
end

mpd.disconnect
