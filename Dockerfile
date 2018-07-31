FROM ruby:2.5.1-alpine3.7
MAINTAINER Juan Gallego IV <juan.gallego.iv@gmail.com>

ENV app_folder /app
RUN mkdir $app_folder
WORKDIR $app_folder

RUN apk add --no-cache ca-certificates libcurl libressl libxml2 libxslt postgresql-libs tzdata git

COPY Gemfile .
COPY Gemfile.lock .

RUN set -ex && \
    apk add --no-cache --virtual .ruby-bundler \
        build-base git \
        libxml2-dev libxslt-dev postgresql-dev libressl-dev && \
    bundle install -j 4 --no-cache && \
    apk del .ruby-bundler

COPY . .

ENTRYPOINT ["bundle", "exec"]
