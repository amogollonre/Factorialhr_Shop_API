FROM ruby:3.2.2-slim

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev \
    git \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV RAILS_ENV=development \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=""

COPY Gemfile Gemfile.lock ./
RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]
