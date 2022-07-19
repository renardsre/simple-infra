FROM grafana/k6:0.37.0 as k6
FROM alpine:3.15

COPY --from=k6 /usr/bin/k6 /usr/bin/k6

RUN apk --no-cache add curl tzdata vim wget bash sudo && \
    ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && \
    adduser -D admin

RUN mkdir /tools

RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel && \
    adduser admin wheel && \
    chown -R admin:admin /tools

WORKDIR /tools

COPY --chown=admin:admin script/ /tools/
