FROM archlinux:base

# Environment
ENV S6_VERSION="v2.2.0.3"

#Add s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer / && rm /tmp/s6-overlay-amd64-installer

ENTRYPOINT ["/init"]