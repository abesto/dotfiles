#/bin/sh
#awesome.hooks.timer seems to forget about killing the notifications, so work around that
#This script kills everything that has kill_mnot in the name (except itself)
for pid in `ps x | grep kill_mnot | grep -v grep | grep -v kill_mnot.sh | sed -r s/\ .*//`
do
    kill -9 $pid
done
