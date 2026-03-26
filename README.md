# Social Recipes

Social Recipes is a small Rails application for publishing and discovering recipes with a lightweight social layer.

From the code and test suite, the product behavior is:

- Visitors can browse recipes from the homepage and open recipe details.
- Recipes are organized by kitchen, food type, and preference.
- Signed-in users can create recipes, favorite recipes, and like kitchens.
- User profile pages show liked kitchens, favorited recipes, and recipes published by that user.
- Admin users can create kitchens, food types, and preferences.

The UI is a mix of English labels and Portuguese messages/content.

## Stack

- Ruby on Rails 8.1.2
- Ruby 4.0.1 in Docker via `ruby:4.0.1-slim-trixie`
- SQLite in development and test
- PostgreSQL gem included for production only
- Devise 5 for authentication
- Active Storage for recipe photos
- Cloudinary-backed Active Storage service in production, Disk service in development and test
- Turbo Rails for frontend navigation/runtime
- Propshaft with importmap-rails for assets and JavaScript
- App-owned plain CSS for styling, with no Bootstrap dependency
- RSpec, Capybara, FactoryBot, and SimpleCov for tests

## Running Locally

The reliable local path on this machine is Docker.

### Prerequisites

- Docker CLI
- Docker Compose
- Colima running

If needed:

```bash
colima start
```

### Configuration

Cloudinary credentials are no longer committed in the repository. Export these variables before starting the app if you want upload integration configured:

```bash
export CLOUDINARY_CLOUD_NAME=your-cloud-name
export CLOUDINARY_API_KEY=your-api-key
export CLOUDINARY_API_SECRET=your-api-secret
```

### Build the app

```bash
docker-compose build
```

### Create the development database

```bash
docker-compose run --rm app bash -lc "bundle exec rake db:setup"
```

### Start the app

```bash
docker-compose up -d
```

Then open:

```text
http://127.0.0.1:3000
```

### Stop the app

```bash
docker-compose down
```

## Running Tests

```bash
docker-compose run --rm -e RAILS_ENV=test app bash -lc "bundle exec rails db:environment:set RAILS_ENV=test && bundle exec rake db:create db:schema:load && bundle exec rspec"
```

Expected result from the validated environment:

```text
31 examples, 0 failures
```

## Files Added For Compatibility

To make the project runnable on this machine without rewriting the application, I added:

- `Dockerfile`
- `docker-compose.yml`
- `app/assets/config/manifest.js`
- `config/storage.yml`

The Docker image now uses Ruby `4.0.1` from `ruby:4.0.1-slim-trixie` and Bundler `4.0.8` so the app can run on Rails `8.1` with a current SQLite runtime.

## Notes and Caveats

- Cloudinary credentials now live in `config/storage.yml` for the production Active Storage service and read from environment variables.
- `config/secrets.yml` has been removed. Development and test use explicit environment config for `secret_key_base`, and production expects `SECRET_KEY_BASE`.
- `db/seeds.rb` creates explicit records and no longer depends on test factories.
- The app is functionally small and spec coverage is high, but authorization in controllers is still hand-rolled rather than centralized.

## Upgrade Notes

- The app now runs on Rails `8.1.2` with Ruby `4.0.1` in Docker via `ruby:4.0.1-slim-trixie`.
- After the Rails `8.1` upgrade, the runtime was evaluated and moved from Ruby `3.2.9` to Ruby `4.0.1`.
- Zeitwerk is enabled and `bundle exec rails zeitwerk:check` passes.
- Turbolinks and jQuery have been removed. The frontend runtime now uses `turbo-rails`, `form_with`, and explicit `button_to` actions where method-based links previously depended on `jquery_ujs`.
- The asset stack now uses `propshaft` and `importmap-rails`, with the JavaScript entrypoint living in `app/javascript/application.js`.
- Bootstrap, SassC, Sprockets, and Uglifier have been removed. Styling now lives in the app-owned `app/assets/stylesheets/application.css`.
- The Rails `8.1` bridge also upgraded `sqlite3` to the `2.x` line, replaced the legacy `pry-byebug` debugging path with `debug`, and upgraded Devise to `5.0.x` to stay on supported route and Hotwire behavior.
- Ruby `4.0` compatibility required adding the standalone `observer` gem and moving `factory_bot_rails` to the `6.5.x` line because `observer` is no longer part of Ruby stdlib.
- The branch now uses the latest compatible direct dependency set for this stack, including `capybara 3.40`, `rspec-rails 8.0`, `web-console 4.3`, `pg 1.6`, and `ffi 1.17`.
- `puma 7.2` is now explicit in the Gemfile because the newer Rack/Bundler stack no longer boots `rails server` without a server gem.
- Bundler was upgraded from `2.4.22` to `4.0.8`, which removed the RubyGems platform constant warnings that appeared under Ruby `4.0.1`.
- Uploads now use Active Storage instead of CarrierWave. The app installs the Active Storage tables, stores files on Disk in development/test, and uses Cloudinary as the configured production service.
- The legacy `recipes.photo` column and CarrierWave uploader were removed as part of the migration, so old CarrierWave-backed photo paths are not retained by this branch.
- Rails `7.2` had already removed `config/secrets.yml`, set `secret_key_base` explicitly in environment config, replaced deprecated test/RSpec settings, and moved the cache serialization format off the legacy `6.1` default.
- `config/storage.yml` is now part of the active upload path rather than just a framework compatibility file.
- Remaining frontend follow-up is now visual/product polish rather than asset-stack migration.
