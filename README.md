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

- Ruby on Rails 4.2.11.3
- Ruby 2.3.8 in Docker for compatibility with the original gem set
- SQLite in development and test
- PostgreSQL gem included for production only
- Devise for authentication
- CarrierWave with Cloudinary integration for recipe photos
- Bootstrap Sass for styling
- RSpec, Capybara, FactoryBot, and SimpleCov for tests

## Running Locally

The original dependency set does not install cleanly on the host macOS Ruby available on this machine. The reliable path is Docker.

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
docker-compose run --rm -e RAILS_ENV=test app bash -lc "bundle exec rake db:create db:schema:load && bundle exec rspec"
```

Expected result from the validated environment:

```text
26 examples, 0 failures
```

## Files Added For Compatibility

To make the project runnable on this machine without rewriting the application, I added:

- `Dockerfile`
- `docker-compose.yml`

The Docker image uses Ruby `2.3.8` and archived Debian package sources because the app depends on a historical gem set from 2015-2016.

## Notes and Caveats

- `config/cloudinary.yml` now reads credentials from environment variables rather than committed secrets.
- `db/seeds.rb` creates explicit records and no longer depends on test factories.
- The app is functionally small and spec coverage is high, but authorization in controllers is still hand-rolled rather than centralized.

## Upgrade Notes

- The Rails patch upgrade to `4.2.11.3` requires pinning `rake` to `10.5.0` so the current `rspec-rails 3.4` task integration keeps working on this legacy stack.
- `rails-html-sanitizer 1.4.4` and `loofah 2.19.1` are pinned to avoid a Nokogiri compatibility break under Ruby `2.3.8`.
- Boot and test runs now emit Sprockets deprecation warnings through `autoprefixer-rails` and `sass-rails`. Those are expected follow-up items for the Rails `5.x` and frontend modernization phases.
