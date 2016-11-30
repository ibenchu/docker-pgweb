FROM alpine
MAINTAINER Daniel Johansson <donnex@donnex.net>
RUN apk add --no-cache --update-cache bash

RUN \
    apk add --no-cache --virtual .persistent-deps \
        unzip\
    
    && rm -rf /var/lib/apt/lists/*

ENV PGWEB_VERSION 0.9.5

RUN \
  cd /tmp && \
  wget https://github.com/sosedoff/pgweb/releases/download/v$PGWEB_VERSION/pgweb_linux_amd64.zip && \
  unzip pgweb_linux_amd64.zip -d /app && \
  rm -f pgweb_linux_amd64.zip

RUN useradd -ms /bin/bash pgweb

USER pgweb
WORKDIR /app

EXPOSE 8080
ENTRYPOINT ["/app/pgweb_linux_amd64"]
CMD ["-s", "--bind=0.0.0.0", "--listen=8080"]