#!/bin/env fish
set h $argv[1]
set cmd $argv[2]
ssh "$h" -l root "$cmd" | tee "$h.out"
