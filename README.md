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

- Ruby on Rails 6.1.7.10
- Ruby 2.7.8 in Docker
- SQLite in development and test
- PostgreSQL gem included for production only
- Devise for authentication
- CarrierWave with Cloudinary integration for recipe photos
- Turbo Rails for frontend navigation/runtime
- Bootstrap 5 with Dart Sass for styling
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
30 examples, 0 failures
```

## Files Added For Compatibility

To make the project runnable on this machine without rewriting the application, I added:

- `Dockerfile`
- `docker-compose.yml`
- `app/assets/config/manifest.js`
- `app/assets/builds/.keep`
- `config/storage.yml`

The Docker image now uses Ruby `2.7.8` and a modern Bundler lock so the app can run on Rails `6.1` while keeping the legacy frontend stack intact.

## Notes and Caveats

- `config/cloudinary.yml` now reads credentials from environment variables rather than committed secrets.
- `db/seeds.rb` creates explicit records and no longer depends on test factories.
- The app is functionally small and spec coverage is high, but authorization in controllers is still hand-rolled rather than centralized.

## Upgrade Notes

- The app now runs on Rails `6.1.7.10` with Ruby `2.7.8` in Docker.
- The Rails `6.x` bridge required regenerating `Gemfile.lock` with Bundler `2.4.22`, moving the Docker workflow to native `arm64` on this machine, and upgrading the test/tooling stack to modern Rails-compatible versions.
- Zeitwerk is enabled and `bundle exec rails zeitwerk:check` passes.
- Turbolinks and jQuery have been removed. The frontend runtime now uses `turbo-rails`, `form_with`, and explicit `button_to` actions where method-based links previously depended on `jquery_ujs`.
- The styling stack now uses Bootstrap 5 and Dart Sass. Rails builds CSS through `bundle exec rails dartsass:build`, and the Docker/CI commands were updated to run that build before serving or testing the app.
- Rails `6` requires `app/assets/config/manifest.js`, and the asset manifest now links the generated CSS in `app/assets/builds`.
- A minimal `config/storage.yml` is present because Rails `6.1` expects Active Storage configuration, even though the app still uses CarrierWave and Cloudinary for uploads.
- Boot and test runs still emit warnings from legacy debugger and mail/network gems (`pry-byebug`, `net-protocol`). Remaining frontend follow-up is mostly visual cleanup and deeper Bootstrap 5 polish rather than stack replacement.
