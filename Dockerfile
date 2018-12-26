FROM alpine:3.8
LABEL maintainer="llitfkitfk@gmail.com"

ENV HUGO_VERSION 0.53

RUN set -x \
    && apk add --no-cache curl \
    && curl -fsSL -o /tmp/hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
    && tar xzf /tmp/hugo.tar.gz -C /tmp/ \
    && mv /tmp/hugo /usr/local/bin/hugo \
    && rm /tmp/hugo.tar.gz

ADD . /blog

WORKDIR /blog

EXPOSE 1313

ENTRYPOINT [ "hugo" ]

CMD [ "server", "--bind", "0.0.0.0", "-D" ]