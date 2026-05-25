#!/usr/bin/env bash

# Launch Brave Origin Browser in Kasm
brave-origin \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-gpu \
    --window-size=1280,720 \
    --user-data-dir=/home/kasm-user/.config/BraveSoftware/Brave-Origin \
    "$@"
