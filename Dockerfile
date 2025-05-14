FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
   && apt-get install -y \
    nginx \
    spawn-fcgi \
    fcgiwrap \
    curl \
    iputils-ping \
    vim \
    dnsmasq \
    supervisor \
    tftpd-hpa \
    ipcalc \
    tcpdump \
    ipxe \
    gpg \
    libarchive-tools \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/*

# Create supervisor config directory
#RUN mkdir -p /etc/supervisor/conf.d

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
