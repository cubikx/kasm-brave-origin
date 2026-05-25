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

# Install enterprise policy to skip onboarding/prompts
RUN mkdir -p /etc/opt/brave/policies/managed
COPY brave-policies.json /etc/opt/brave/policies/managed/brave-policies.json

COPY startup.sh /dockerstartup/custom_startup.sh
RUN chmod +x /dockerstartup/custom_startup.sh

USER 1000

ENV STARTUPDIR=/dockerstartup
ENV HOME=/home/kasm-user
WORKDIR $HOME
