FROM archlinux/archlinux:base

LABEL maintainer="MiguelNdeCarvalho <geral@miguelndecarvalho.pt>"

# Environment
ENV S6_VERSION="v2.2.0.3"

# Add s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer / && rm /tmp/s6-overlay-amd64-installer

RUN echo "- perform an update -" && \
    pacman -Syu --noconfirm

RUN echo "- create user and give permissions -" && \
    mkdir /app /default /config && \
    useradd -d /config abc

RUN echo "- cleanup -" && \
    rm /glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    pacman -Scc --noconfirm 

COPY rootfs/ /

ENTRYPOINT ["/init"]
