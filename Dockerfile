# Dashy, with its server's outbound endpoints held to the addresses its page names and its
# ping removed: dashy.patch, applied with patch --forward, fails this build wherever
# Dashy's code no longer fits it.

FROM ghcr.io/lissy93/dashy:4.9.0@sha256:e8725dc24acc9a1d6f09c2ed0499b596af5a1b4eac8c83e912c213da06011356 AS upstream

FROM alpine:3.22.8@sha256:49340b346798875b5592e5d420241f2f9cfba5f47e62ebb1446a1b34734e898f AS patched
RUN apk add --no-cache patch
COPY --from=upstream /app/services /app/services
COPY dashy.patch /dashy.patch
RUN cd /app && patch -p1 --forward --no-backup-if-mismatch < /dashy.patch

FROM ghcr.io/lissy93/dashy:4.9.0@sha256:e8725dc24acc9a1d6f09c2ed0499b596af5a1b4eac8c83e912c213da06011356
COPY --from=patched /app/services /app/services
USER 1000:1000
