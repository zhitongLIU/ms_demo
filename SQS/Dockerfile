FROM ruby:2.3

WORKDIR /myapp
COPY Gemfile Gemfile.lock ./
RUN bundle

COPY . .

LABEL maintainer="Zhitong LIU<zhitonggm.liu@gmail.com>"

CMD ruby main.rb
