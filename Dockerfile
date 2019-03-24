#
# STAGE 1: build
#
FROM ruby:2.5 AS build 

RUN gem install bundler

COPY . /app
WORKDIR /app

ENV JEKYLL_ENV production
ENV BUNDLE_PATH /app/vendor

RUN bundle install
RUN bundle exec jekyll build

#
# STAGE 2: runtime
#
FROM nginx:1.15-alpine AS runtime
MAINTAINER Glenn Y. ROLLAND <glenux@glenux.net>

COPY --from=build /usr/local /usr/local 
COPY --from=build /app/_site /usr/share/nginx/html

