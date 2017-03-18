FROM alpine:3.5

RUN mkdir /data \
  && apk add --no-cache git go musl-dev ca-certificates thttpd \
  && git clone https://github.com/restic/rest-server \
  && cd rest-server \
  && go run build.go \
  && cp rest-server /usr/bin/ \
  && apk del git go musl-dev

CMD touch /data/.htpasswd && /usr/bin/rest-server --listen :8000 --path /data
