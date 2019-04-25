FROM golang:alpine AS builder

RUN apk update && apk add git

RUN mkdir -p /jfrog-cli-go && \
    git clone https://github.com/jfrog/jfrog-cli-go.git /jfrog-cli-go && \
    cd /jfrog-cli-go/jfrog-cli/jfrog/ && \
    CGO_ENABLED=0 GO111MODULE=auto GOOS=linux go build

FROM alpine:latest
COPY --from=builder /jfrog-cli-go/jfrog-cli/jfrog/jfrog /usr/local/bin/jfrog

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile=Dockerfile \
      org.label-schema.license=LGPL \
      org.label-schema.name=lv-alpina \
      org.label-schema.version=$VERSION \
      org.label-schema.url=https://github.com/madhead/lv-alpina \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=https://github.com/madhead/lv-alpina.git \
      org.label-schema.vcs-type=git
