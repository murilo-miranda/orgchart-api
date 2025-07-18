FROM ruby:3.2.7

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  postgresql-client

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN rm -f tmp/pids/server.pid

CMD ["bin/rails", "server", "-b", "0.0.0.0"]