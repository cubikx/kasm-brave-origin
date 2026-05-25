#!/usr/bin/env bash

brave-origin-nightly \
    --disable-dev-shm-usage \
    --disable-gpu \
    --no-first-run \
    --no-default-browser-check \
    --disable-brave-welcome \
    --window-size=1280,720 \
    --user-data-dir=/home/kasm-user/.config/BraveSoftware/Brave-Origin-Nightly \
    "$@"
