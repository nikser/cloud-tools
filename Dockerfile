FROM alpine:3.13.1

ENV GLIBC_VER "2.31-r0"
ENV CURL_VERSION "7.74.0-r0"
ENV GIT_VERSION "2.30.1-r0"
ENV JQ_VERSION "1.6-r1"
ENV AWSCLI_VERSION "2.1.22"
ENV SENTRY_VERSION "1.62.0"

RUN apk add --update --no-cache \
    python3 \
    binutils \
    bash \
    curl=$CURL_VERSION \
    git=$GIT_VERSION \
    jq=$JQ_VERSION \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip" -o awscliv2.zip \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf /var/cache/apk/* \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
    && apk --no-cache del \
        binutils \
    && rm glibc-${GLIBC_VER}.apk \
    && rm glibc-bin-${GLIBC_VER}.apk \
    && adduser -S user -G users \
    && curl -sL "https://sentry.io/get-cli/?_=${SENTRY_VERSION}" | bash

USER user
