FROM radial/busyboxplus:curl as getTini

WORKDIR /

RUN curl -sSL "https://github.com/krallin/tini/releases/download/v0.19.0/tini-static" -o tini \
  && chmod +x tini

FROM volf52/upx-minimal:1.0 as upx-src
FROM alpine:3.16.2 as compressor

COPY --from=upx-src /bin/upx /bin/upx
COPY --from=getTini /tini /tini

RUN /bin/upx --best --lzma -o tini_min /tini

FROM scratch
COPY --from=compressor /tini_min /bin/tini

ENTRYPOINT ["/bin/tini", "--"]
