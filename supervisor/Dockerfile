FROM ruby:2.4-alpine

RUN apk update && apk add build-base postgresql-dev

WORKDIR /myapp
COPY Gemfile Gemfile.lock ./
RUN bundle

COPY . .

LABEL maintainer="Zhitong LIU<zhitonggm.liu@gmail.com>"

CMD ruby main.rb
