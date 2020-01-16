FROM alpine:3.10

EXPOSE 22 3000

## amd64, arm-6
ARG ARCH

## GITEA RELEASE VERSION
ARG VERSION=1.10.1


RUN apk --no-cache add \
    bash \
    ca-certificates \
    curl \
    gettext \
    git \
    linux-pam \
    openssh \
    s6 \
    sqlite \
    su-exec \
    tzdata

RUN addgroup \
    -S -g 1000 \
    git && \
  adduser \
    -S -H -D \
    -h /data/git \
    -s /bin/bash \
    -u 1000 \
    -G git \
    git && \
  echo "git:$(dd if=/dev/urandom bs=24 count=1 status=none | base64)" | chpasswd


ENV USER git
ENV GITEA_CUSTOM /data/gitea
ENV GODEBUG=netdns=go

VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]

## GET GITEA-DOCKER FILES
RUN curl -SL  https://github.com/go-gitea/gitea/archive/v$VERSION.tar.gz | \
    tar xz gitea-$VERSION/docker --exclude=gitea-$VERSION/docker/Makefile --strip-components=3

## GET GITEA
RUN mkdir -p /app/gitea && \
    curl -SLo /app/gitea/gitea https://github.com/go-gitea/gitea/releases/download/v$VERSION/gitea-$VERSION-linux-$ARCH && \
    chmod 0755 /app/gitea/gitea
