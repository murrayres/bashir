FROM quay.octanner.io/base/oct-ruby:2.4.1

RUN bundle config --global frozen 1

WORKDIR /gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ENV APP_DIR /app

WORKDIR /app
COPY . .

CMD ./start.sh
