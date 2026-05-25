FROM kasmweb/chromium:1.18.0

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-transport-https curl gnupg \
    && curl -fsSLo /usr/share/keyrings/brave-browser-nightly-archive-keyring.gpg \
       https://brave-browser-apt-nightly.s3.brave.com/brave-browser-nightly-archive-keyring.gpg \
    && curl -fsSLo /etc/apt/sources.list.d/brave-browser-nightly.sources \
       https://brave-browser-apt-nightly.s3.brave.com/brave-browser.sources \
    && apt-get update \
    && apt-get install -y --no-install-recommends brave-origin-nightly \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install enterprise policies
RUN mkdir -p /etc/opt/brave/policies/managed
COPY brave-policies.json /etc/opt/brave/policies/managed/brave-policies.json

# Replace chromium binary with a wrapper that launches brave instead
RUN mv /usr/bin/chromium /usr/bin/chromium.bak && \
    printf '#!/bin/bash\nexec brave-origin-nightly \\\n  --no-sandbox \\\n  --disable-dev-shm-usage \\\n  --disable-gpu \\\n  --no-first-run \\\n  --no-default-browser-check \\\n  --disable-brave-welcome \\\n  "$@"\n' > /usr/bin/chromium && \
    chmod +x /usr/bin/chromium

USER 1000

ENV STARTUPDIR=/dockerstartup
ENV HOME=/home/kasm-user
WORKDIR $HOME
