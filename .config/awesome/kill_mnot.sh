#/bin/sh
#awesome.hooks.timer seems to forget about killing the notifications, so work around that
#This script kills everything that has kill_mnot in the name (except itself)
for pid in `ps x | grep awesome-client | grep -v gawk | gawk '/kill_mnot()/ {print $1}'`
do
    kill -9 $pid
done

#kill the 'sleep 3's started by the killer threads
for pid in `ps x | grep 'sleep 3' | grep -v gawk | gawk '{print $1}'`
do
    kill -9 $pid
done
