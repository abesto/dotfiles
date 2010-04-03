-- table element is {name, start command, restart command, stop command}
daemons = {}

function rc_daemon(name)
      return {name,
              "gksudo -D'Start the "..name.." daemon' /etc/rc.d/"..name.." start",
              "gksudo -D'Restart the "..name.." daemon' /etc/rc.d/"..name.." restart",
              "gksudo -D'Stop the "..name.." daemon' "..'/etc/rc.d/'..name.." stop"
           }
   end


-- all daemons in /etc/rc.d/
rc = {}
for i, d in ipairs(scandir("/etc/rc.d")) do
   table.insert(rc, rc_daemon(d))
end

-- often-used daemons for easier reach
for i, d in ipairs({'httpd', 'mysqld', 'mpd', 'wicd', 'networkmanager'}) do
   table.insert(daemons, rc_daemon(d))
end

-- custom daemons
custom = {
   {"emacs", "emacs --daemon", "killall emacs && emacs --daemon", "killall emacs"},
   {"conkeror", "conkeror -daemon", "killall xulrunner; killall xulrunner-bin; conkeror -daemon", "killall xulrunner; killall xulrunner-bin"}
}

for i, d in ipairs(custom) do
   table.insert(daemons, d)
end
