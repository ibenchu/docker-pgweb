FROM alpine
MAINTAINER Daniel Johansson <donnex@donnex.net>

RUN RUN apk add --no-cache \
        unzip\
ENV PGWEB_VERSION 0.9.6

RUN \
  cd /tmp && \
  curl -fSL https://github.com/sosedoff/pgweb/releases/download/v$PGWEB_VERSION/pgweb_linux_amd64.zip -o pgweb_linux_amd64.zip && \
  unzip pgweb_linux_amd64.zip -d /app && \
  rm -f pgweb_linux_amd64.zip

RUN useradd -ms /bin/sh pgweb

USER pgweb
WORKDIR /app

EXPOSE 8080
ENTRYPOINT ["/app/pgweb_linux_amd64"]
CMD ["-s", "--bind=0.0.0.0", "--listen=8080"]