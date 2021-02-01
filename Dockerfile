FROM alpine:3.13.1

ENV AWSCLI_VERSION "1.18.223"
ENV GIT_VERSION "2.30.0-r0"
ENV JQ_VERSION "1.6-r1"

RUN apk add --update \
    python3 \
    py-pip \
    build-base \
    git=$GIT_VERSION \
    jq=$JQ_VERSION \
    && pip install awscli==$AWSCLI_VERSION --upgrade --user \
    && apk --purge -v del py-pip \
    && rm -rf /var/cache/apk/* \
    && adduser -S user -G users

USER user
