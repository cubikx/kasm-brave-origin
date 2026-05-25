#!/usr/bin/env bash

brave-origin-nightly \
    --no-sandbox \
    --disable-dev-shm-usage \
    --disable-gpu \
    --window-size=1280,720 \
    --user-data-dir=/home/kasm-user/.config/BraveSoftware/Brave-Origin-Nightly \
    "$@"
