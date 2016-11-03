#!/bin/bash

for file in $(ls ~/.bashrc.d); do
    if [ ! -f "${BASH_SOURCE}.skip/${file}" ]; then
        . ~/.bashrc.d/$file
    fi
done
