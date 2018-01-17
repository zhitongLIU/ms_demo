FROM ruby:2.3-alpine
# ENV BUILD_PACKAGES build-base libxml2-dev libxslt-dev
ENV RUBY_PACKAGES ruby-bundler net-tools

RUN apk update && \
    apk upgrade && \
    # apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

WORKDIR /usr/myapp
COPY Gemfile Gemfile.lock ./
RUN bundle
Add . .
EXPOSE 4567

LABEL maintainer="Zhitong LIU<zhitonggm.liu@gmail.com>"

CMD ruby main.rb -o 0.0.0.0
