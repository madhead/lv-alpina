FROM golang:alpine AS builder

RUN apk update && apk add git

RUN mkdir -p /go/src/github.com/jfrog/jfrog-cli-go && \
    git clone https://github.com/jfrog/jfrog-cli-go.git /go/src/github.com/jfrog/jfrog-cli-go && \
    cd /go/src/github.com/jfrog/jfrog-cli-go && \
    CGO_ENABLED=0 GOOS=linux go build github.com/jfrog/jfrog-cli-go/jfrog-cli/jfrog

FROM alpine
COPY --from=builder /go/src/github.com/jfrog/jfrog-cli-go/jfrog /usr/local/bin/jfrog
