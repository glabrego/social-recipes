FROM ruby:2.7.8

ENV APP_HOME=/app \
    BUNDLE_PATH=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

WORKDIR $APP_HOME

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libsqlite3-dev \
    nodejs \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 2.4.22 --no-document

COPY Gemfile Gemfile.lock ./

RUN bundle _2.4.22_ config set build.nokogiri --use-system-libraries && \
    bundle _2.4.22_ config set without 'production' && \
    (bundle _2.4.22_ install > /tmp/bundle.log 2>&1 || (tail -n 200 /tmp/bundle.log && false))

COPY . .

EXPOSE 3000
