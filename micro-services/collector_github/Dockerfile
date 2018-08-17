FROM ruby:2.3
# ENV BUILD_PACKAGES build-base libxml2-dev libxslt-dev
ENV RUBY_PACKAGES ruby-bundler net-tools

RUN apt update -y && \
    apt upgrade -y && \
    # apt add $BUILD_PACKAGES && \
    apt install -y $RUBY_PACKAGES && \
    rm -rf /var/cache/apt/*

WORKDIR /usr/myapp
COPY Gemfile Gemfile.lock ./
RUN bundle
Add . .
EXPOSE 50051

LABEL maintainer="Zhitong LIU<zhitonggm.liu@gmail.com>"

CMD ruby main.rb -o 0.0.0.0
