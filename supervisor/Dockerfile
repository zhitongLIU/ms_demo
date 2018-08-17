FROM ruby:2.4

RUN apt update -y && apt install -y build-essential libpq-dev

WORKDIR /myapp
COPY Gemfile Gemfile.lock ./
RUN bundle

COPY . .

LABEL maintainer="Zhitong LIU<zhitonggm.liu@gmail.com>"

CMD ruby main.rb
