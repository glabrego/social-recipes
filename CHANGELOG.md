# Changelog

This changelog was reconstructed from the repository commit history because the project does not use historical tags or formal releases.

## 2026-03-15

### Baseline hardening

- Moved Cloudinary configuration to environment variables instead of committing plaintext credentials.
- Replaced factory-based seeding with explicit records in `db/seeds.rb`.
- Added focused feature coverage for sign-up, sign-in, recipe updates, and the login requirement for recipe creation.
- Hardened recipe image rendering so pages still load when Cloudinary is not configured and no photo is present.
- Added a GitHub Actions workflow that runs the Docker-based test suite.

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
