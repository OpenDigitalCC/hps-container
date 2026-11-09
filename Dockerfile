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
    open-iscsi \
    procps \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# open-iscsi: the iSCSI initiator for scripts/hps-iscsi-test.sh (lab test of a
# node's export). The container cannot load kernel modules: the HOST needs
# iscsi_tcp loaded; the script checks and says so. It starts iscsid itself.
# procps: pgrep, used by that script.

# One group owns the IPS state. Root writers (supervisor pre-start, CLIs) and
# the web user (lighttpd drops to www-data for the CGI) both write the registry
# through it; see hps-system/docs/SECURITY.md. keysafe stays root-only.
RUN groupadd -r hps \
 && usermod -aG hps www-data

# The ctrl-exec service user (the dispatcher install keeps an existing one). It
# runs ctrl-exec-api, whose unix socket is group hps so the root job runner and
# the state group can call it; the user must be in hps to own such a socket.
# ADR 0006 (hps-system).
# Fixed ids: the dispatcher config and state persist under /srv across image
# rebuilds, so the user and group must not drift between images.
RUN groupadd -r -g 1210 ctrl-exec \
 && useradd -r -M -s /usr/sbin/nologin -u 1210 -g ctrl-exec -G hps ctrl-exec

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Pre-create loop devices
RUN for i in $(seq 0 7); do mknod -m 660 /dev/loop$i b 7 $i; done

ENTRYPOINT ["/entrypoint.sh"]
