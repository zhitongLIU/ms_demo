FROM ruby:2.4-alpine

ENV RUBY_PACKAGES ruby-bundler net-tools

RUN apk update && \
    apk upgrade && \
    # apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

WORKDIR /myapp
COPY Gemfile Gemfile.lock ./
RUN bundle
Add . .
EXPOSE 6666

LABEL maintainer="Zhitong LIU<zhitonggm.liu@gmail.com>"

CMD ruby main.rb -o 0.0.0.0
