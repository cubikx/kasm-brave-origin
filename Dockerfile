FROM kasmweb/chromium:1.18.0

USER root

# Install dependencies, add Brave Origin repo, and install in one layer
RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-transport-https curl gnupg \
    && curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
       https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
       > /etc/apt/sources.list.d/brave-browser-release.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends brave-origin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY startup.sh /dockerstartup/custom_startup.sh
RUN chmod +x /dockerstartup/custom_startup.sh

USER 1000

ENV STARTUPDIR=/dockerstartup
ENV HOME=/home/kasm-user
WORKDIR $HOME
