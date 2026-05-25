#!/usr/bin/env bash

# Launch Brave Browser in Kasm
brave-browser \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-gpu \
    --window-size=1280,720 \
    --user-data-dir=/home/kasm-user/.config/BraveSoftware/Brave-Browser \
    "$@"
