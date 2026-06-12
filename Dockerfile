# Build stage
ARG VERSION=ntp-4.2.8p18
ARG ALPINE=3.24

FROM alpine:${ALPINE} AS builder

ARG VERSION

# build deps
RUN apk add --no-cache build-base linux-headers wget tar perl openssl-dev

WORKDIR /usr/src
RUN wget -qO ${VERSION}.tar.gz https://archive.ntp.org/ntp4/${VERSION}.tar.gz \
    && tar xzf ${VERSION}.tar.gz

WORKDIR /usr/src/${VERSION}
# configure/install into a temporary tree we can copy from
RUN ./configure --prefix=/usr --sysconfdir=/etc \
    && make -j"$(getconf _NPROCESSORS_ONLN)" \
    && make install DESTDIR=/out

# Runtime image
FROM alpine:${ALPINE}
LABEL org.opencontainers.image.authors="dalbodeule <jioo0224@naver.com>"
LABEL org.opencontainers.image.license="Unlicense"

# runtime deps (ca-certificates/tzdata optional)
RUN apk add --no-cache ca-certificates tzdata

# create ntp user/group; ntpd will drop privileges using -u ntp:ntp
RUN (getent group ntp >/dev/null 2>&1 || addgroup -S ntp) \
    && (id -u ntp >/dev/null 2>&1 || adduser -S -D -H -G ntp ntp) \
    && mkdir -p /var/lib/ntp /var/log/ntp /etc/ntp \
    && chown -R ntp:ntp /var/lib/ntp /var/log/ntp

# copy installed binaries from builder
COPY --from=builder /out/usr/bin/ntpd /usr/sbin/ntpd
COPY --from=builder /out/usr/bin/ntpq /usr/bin/ntpq
COPY --from=builder /out/usr/bin/ntpdc /usr/bin/ntpdc
COPY --from=builder /out/usr/bin/ntp-keygen /usr/bin/ntp-keygen

EXPOSE 123/udp

# run ntpd; use -u to drop privileges after binding
ENTRYPOINT ["/usr/sbin/ntpd"]
CMD ["-n"]
