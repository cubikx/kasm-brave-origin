FROM kasmweb/core-chromium:1.17.0

USER root

# Install dependencies
RUN apt-get update \
    && apt-get install -y apt-transport-https curl gnupg \
    && apt-get clean

# Add Brave Origin GPG key and repository
RUN curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg \
       https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" \
       > /etc/apt/sources.list.d/brave-browser-release.list

# Install Brave Origin (free on Linux!)
RUN apt-get update \
    && apt-get install -y brave-origin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY startup.sh /dockerstartup/custom_startup.sh
RUN chmod +x /dockerstartup/custom_startup.sh

USER 1000

ENV STARTUPDIR=/dockerstartup
ENV HOME=/home/kasm-user
WORKDIR $HOME
