FROM archlinux/archlinux:base

LABEL maintainer="MiguelNdeCarvalho <geral@miguelndecarvalho.pt>"

RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xvf "$patched_glibc" && \
    echo "IgnorePkg   = glibc" >> /etc/pacman.conf

# Environment
ENV S6_VERSION="v2.2.0.3"

# Add s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer / && rm /tmp/s6-overlay-amd64-installer

RUN echo "- perform an update -" && \
    pacman -Syu --noconfirm

RUN echo "- create user and give permissions -" && \
    mkdir /default /config && \
    useradd -d /config -s /bin/false abc

RUN echo "- cleanup -" && \
    pacman -Scc --noconfirm

COPY rootfs/ /

ENTRYPOINT ["/init"]
