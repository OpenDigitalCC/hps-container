FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
   && apt-get install -y \
    nginx \
    spawn-fcgi \
    rsyslog \
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
    git \
    libarchive-tools \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/*

# Create supervisor config directory
#RUN mkdir -p /etc/supervisor/conf.d

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN for i in $(seq 0 7); do   mknod -m 660 /dev/loop$i b 7 $i; done

ENTRYPOINT ["/entrypoint.sh"]
