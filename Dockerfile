# Dashy, with its server's outbound endpoints held to the addresses its page names and its
# ping removed: dashy.patch, applied with patch --forward, fails this build wherever
# Dashy's code no longer fits it.

FROM ghcr.io/lissy93/dashy:4.9.19@sha256:7243dd17b584490c740d24b18e77e464ef3aa4616dfc1fc5a347dfab6057dd9f AS upstream

FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS patched
RUN apk add --no-cache patch
COPY --from=upstream /app/services /app/services
COPY dashy.patch /dashy.patch
WORKDIR /app
RUN patch -p1 --forward --no-backup-if-mismatch < /dashy.patch

FROM ghcr.io/lissy93/dashy:4.9.19@sha256:7243dd17b584490c740d24b18e77e464ef3aa4616dfc1fc5a347dfab6057dd9f
COPY --from=patched /app/services /app/services
USER 1000:1000
