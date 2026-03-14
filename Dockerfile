FROM --platform=linux/amd64 ruby:2.3.8

ENV APP_HOME=/app \
    BUNDLE_PATH=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

WORKDIR $APP_HOME

RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/-updates/d' /etc/apt/sources.list && \
    printf 'Acquire::Check-Valid-Until "false";\nAcquire::AllowInsecureRepositories "true";\nAcquire::AllowDowngradeToInsecureRepositories "true";\n' > /etc/apt/apt.conf.d/99archive && \
    apt-get update && apt-get install -y --no-install-recommends --allow-unauthenticated \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libsqlite3-dev \
    nodejs \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v 1.17.3

COPY Gemfile Gemfile.lock ./

RUN bundle _1.17.3_ config build.nokogiri --use-system-libraries && \
    (bundle _1.17.3_ install --without production > /tmp/bundle.log 2>&1 || (tail -n 200 /tmp/bundle.log && false))

COPY . .

EXPOSE 3000
