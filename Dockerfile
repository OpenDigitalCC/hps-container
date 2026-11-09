FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    rsyslog \
    lighttpd \
    curl \
    rsync \
    wget \
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
    createrepo-c \
    jq \
    ca-certificates \
    perl \
    libwww-perl \
    liblwp-protocol-https-perl \
    libio-socket-ssl-perl \
    libjson-perl \
    openssl \
    chrony \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Pre-create loop devices
RUN for i in $(seq 0 7); do mknod -m 660 /dev/loop$i b 7 $i; done

ENTRYPOINT ["/entrypoint.sh"]
