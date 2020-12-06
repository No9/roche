FROM rust:1.47.0-alpine

COPY . /app-build

WORKDIR "/app-build"

RUN \
  apk add --no-cache musl-dev && \
  cargo build \
 && echo "#!/bin/sh" > run.sh \
 && bin=$(find ./target/debug -maxdepth 1 -perm -111 -type f| head -n 1) \
 && echo ./${bin##*/} >> run.sh \
 && chmod 755 run.sh

RUN rm -f target/debug/deps/roche*