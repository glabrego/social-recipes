# Changelog

This changelog was reconstructed from the repository commit history because the project does not use historical tags or formal releases.

## 2026-03-16

### Upload storage migration

- Replaced CarrierWave with Active Storage for recipe photos.
- Added the Active Storage tables, configured Disk storage for development and test, and configured Cloudinary as the production Active Storage service.
- Removed the legacy `recipes.photo` column, the CarrierWave uploader, and the old `config/cloudinary.yml` path in favor of `config/storage.yml`.
- Added a feature spec that uploads a recipe photo and verifies the attachment renders in the app.
- Verified the upload migration with Docker-based linting, the full test suite, and live app smoke checks on the Rails `8.1` baseline.

### Rails 7.2 to 8.1 upgrade

- Upgraded the app from Rails `7.2.2.2` through `8.0.3` to Rails `8.1.2`.
- Moved the Docker runtime from Ruby `3.1.6` to Ruby `3.2.9`, which is required for the Rails `8.1` line.
- Upgraded `sqlite3` to the `2.x` series, moved from Devise `4.9` to `5.0.3`, and replaced the legacy `pry-byebug` debugging path with the modern `debug` gem.
- Kept the asset strategy conservative on Sprockets with `sassc-rails`, which continued to boot cleanly on Rails `8.1`.
- Verified Rails `8.1.2` boot, RuboCop linting, the Docker-based test suite, `rails zeitwerk:check`, and browser smoke checks against the live app container.

### Rails 6.1 to 7.2 upgrade

- Upgraded the app from Rails `6.1.7.10` to `7.1.5.2` and then to Rails `7.2.2.2`.
- Moved the Docker runtime from Ruby `2.7.8` to Ruby `3.1.6` on Debian Bookworm so the app runs against a modern SQLite `3.40.x` toolchain.
- Replaced the Dart Sass build step with `sassc-rails` on Sprockets after the older `sass-embedded` path failed under the new Ruby runtime.
- Removed `config/secrets.yml`, set `secret_key_base` directly in environment config, and updated Rails/RSpec settings that became deprecated on the Rails `7.1` and `7.2` path.
- Simplified the Docker and CI commands so they no longer need a separate stylesheet build before booting or testing the app.
- Verified Rails `7.2.2.2` boot, RuboCop linting, the Docker-based test suite, `rails zeitwerk:check`, and browser smoke checks across the homepage and Devise auth pages.

### Frontend runtime and asset modernization

- Replaced `turbolinks` with `turbo-rails` and removed the jQuery-based runtime from the app asset manifest.
- Rewrote the recipe image preview in plain JavaScript and replaced method-based action links with `button_to` helpers.
- Migrated app forms from `form_for` to `form_with` and enabled generated form IDs for compatibility with the existing feature specs.
- Replaced `bootstrap-sass` and `sass-rails` with Bootstrap 5, updated the asset manifest for the modern Rails asset layout, and kept the app on Sprockets-backed CSS compilation.
- Updated the Docker and CI workflows to match the modernized frontend runtime and asset pipeline.
- Verified the updated frontend stack with Docker builds, the full test suite, and browser smoke checks across the homepage and Devise auth pages.

### Rails 5.2 to 6.1 upgrade

- Upgraded the app from Rails `5.2.8.1` to Rails `6.0.6.1` and then to Rails `6.1.7.10`.
- Moved the Docker runtime from Ruby `2.3.8` to Ruby `2.7.8` and regenerated the bundle with Bundler `2.4.22`.
- Regenerated `Gemfile.lock` for native `arm64` and `x86_64` Linux platforms and updated the Rails-coupled gem set, including `rspec-rails`, `factory_bot_rails`, `web-console`, `sqlite3`, `pg`, `sass-rails`, `responders`, and RuboCop support gems.
- Enabled Zeitwerk autoloading, added the Rails `6` asset manifest, and added a minimal `config/storage.yml` for framework compatibility.
- Updated the recipe creation spec to persist selectable associations and replaced deprecated Devise error helper calls with the shared partial.
- Verified Rails `6.1.7.10` boot, the Docker-based test suite, RuboCop linting, `rails zeitwerk:check`, and a browser smoke check across the homepage and Devise auth pages.

### Rails 5.0 to 5.2 upgrade

- Bridged the application from Rails `4.2.11.3` to Rails `5.0.7.2`, then to `5.1.7`, and finally to Rails `5.2.8.1`.
- Upgraded the supporting gem set needed for the Rails `5.x` line, including `devise`, `rspec-rails`, `web-console`, `jquery-rails`, `turbolinks`, `capybara`, `carrierwave`, and `cloudinary`.
- Added `ApplicationRecord` and migrated all models to inherit from it.
- Updated test environment config to use `public_file_server` and removed Rails `4.x`-only configuration.
- Verified linting, the Docker-based test suite, app boot on Rails `5.2.8.1`, and a browser smoke check across the homepage and Devise auth pages.
- Documented the remaining Rails `6.x` blockers exposed by this phase: Sprockets processor deprecations, SQLite boolean serialization, and Devise form helper deprecations.

### Rails 4.2 patch upgrade

- Upgraded Rails from `4.2.4` to `4.2.11.3`.
- Refreshed the compatible Rails `4.2` dependency set in `Gemfile.lock`.
- Pinned `rake` back to `10.5.0` to preserve compatibility with the current `rspec-rails` task integration.
- Pinned `rails-html-sanitizer 1.4.4` and `loofah 2.19.1` to keep the app compatible with the legacy Ruby and Nokogiri runtime.
- Verified linting, the Docker-based test suite, app boot on Rails `4.2.11.3`, and a browser smoke check across the homepage and Devise auth pages.

## 2026-03-15

### Baseline hardening

- Moved Cloudinary configuration to environment variables instead of committing plaintext credentials.
- Replaced factory-based seeding with explicit records in `db/seeds.rb`.
- Added focused feature coverage for sign-up, sign-in, recipe updates, and the login requirement for recipe creation.
- Hardened recipe image rendering so pages still load when Cloudinary is not configured and no photo is present.
- Added a GitHub Actions workflow that runs Docker-based RuboCop linting and the test suite.

### Dependency cleanup

- Removed app-level usage of `responders` and replaced `respond_with` controller flows with explicit redirects and renders.
- Renamed `FactoryGirl` usage to `FactoryBot` and switched to `factory_bot_rails`.
- Removed low-risk direct dependencies from the Gemfile, including `rails_12factor`, `spring`, `sdoc`, `jbuilder`, and the direct `coffee-rails` entry.

## 2026-03-14

### Documentation and local development

- Replaced the placeholder README with project documentation based on the codebase and verified runtime behavior.
- Added a Docker-based local workflow with a `Dockerfile` and `docker-compose.yml`.
- Documented how to build, run, and test the application in a compatible Ruby environment.
- Updated `.gitignore` to exclude `vendor/bundle`.

## 2016-02-16

### Maintenance and deployment adjustments

- Updated deploy-related project files and RuboCop configuration.
- Added `SimpleCov` to the test setup.
- Refactored parts of `RecipesController`.

## 2016-02-11

### Social features and media uploads

- Added kitchen favorites with a many-to-many relationship between users and kitchens.
- Exposed favorited kitchens on user profile pages.
- Added photo uploads for recipes with CarrierWave and Cloudinary integration.

### UI and styling

- Added Bootstrap and migrated the main stylesheet to Sass.
- Redesigned multiple forms and layouts.
- Added index pages for recipes, kitchens, food types, and preferences.

## 2016-02-10

### Recipe favorites and user profiles

- Added the ability for users to favorite recipes.
- Added a user profile page showing published recipes, favorite recipes, and favorite kitchens.
- Added support for editing user profile information.
- Added a top-10 favorited recipes section to the home page.
- Refactored shared controller and test code.

### Recipe ownership

- Added support for editing and deleting recipes owned by the current user.

## 2016-02-09

### Discovery and filtering

- Added recipe filtering by kitchen, food type, and preference.
- Added latest recipes to the home page.
- Linked recipes to users through a `user_id` foreign key.
- Added tests around recipe ownership and filtering behavior.

## 2016-02-08

### Authentication and administration

- Added Devise-based user authentication.
- Added support for admin users.
- Added admin-only creation flows for kitchens, food types, and preferences.

### Core recipe workflow

- Added recipe creation, validation, and detail pages.
- Added the home page with recipe listing and navigation into recipe details.
- Added support for user profile data and custom registration fields.

### Testing foundation

- Established the RSpec test setup and added feature coverage for key user and admin flows.

## 2016-02-07

### Initial domain model

- Added migrations and schema for recipes, kitchens, food types, and preferences.
- Added the initial Active Record models and factories.
- Began moving the project away from the default Rails test structure toward RSpec.

## 2016-02-05

### Project bootstrap

- Generated the initial Rails application skeleton.
- Added the first Gemfile, environment configs, routes, and application layout.
