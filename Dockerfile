FROM alpine:3.8 AS builder
ENV HUGO_VERSION 0.54.0
RUN set -x \
    && apk add --no-cache curl git \
    && curl -fsSL -o /tmp/hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && tar xzf /tmp/hugo.tar.gz -C /tmp/ \
    && cp /tmp/hugo /usr/local/bin/
COPY . /blog
WORKDIR /blog
RUN git submodule update --init && hugo

FROM nginx:stable-alpine
LABEL maintainer="llitfkitfk@gmail.com"
COPY --from=builder /blog/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /blog/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /blog/public /usr/share/nginx/html