# Overview

Forge is a [Rails application template](https://guides.rubyonrails.org/rails_application_templates.html) that installs common tools and performs common configurations to avoid repetition

# Requirements

- Rails (`gem install rails`)

# Compatiblity

This has been tested with the newest Rails version at the time of writing, which is 7.1.3

# Usage

## New applications

```sh
# -d postgresql uses PostgreSQL instead of SQLite. It will be configured as expected.
# -T skips tests, since we will include RSpec.
rails new YOUR_APP_NAME -d postgresql -T -m https://raw.githubusercontent.com/higo-app/forge/main/lib/template.rb
```

## Existing applications

```sh
# In your app's root folder
bin/rails app:template LOCATION=https://raw.githubusercontent.com/higo-app/forge/main/lib/template.rb
```

### Applying only specific features

```sh
# In your app's root folder, for example if we only want to add Redis config
bin/rails app:template LOCATION=https://raw.githubusercontent.com/higo-app/forge/main/lib/settings/redis.rb
```

# Features

## App features

- **[`pg`](https://github.com/ged/ruby-pg)**: Connects to a Postgres database. Configures a minimalistic `config/database.yml` and, optionally, configures UUID primary keys.
- **[`redis`](https://github.com/redis/redis-rb)**: Adds dependency and a single `config/redis/shared.yml` configuration, to be used by ActionCable, Kredis, Sidekiq, etc.
- **[`sidekiq`](https://github.com/sidekiq/sidekiq)**: Background jobs
- **[`strong_migrations`](https://github.com/ankane/strong_migrations)**: Catches unsafe DB migrations
- **[`sentry-ruby`](https://github.com/getsentry/sentry-ruby)**: Error reporting. Adds and configures dependency. Also includes `sentry-rails` and `sentry-sidekiq`.
- **[`analytics-ruby`](https://github.com/segmentio/analytics-ruby)**: Segment analytics (customer data platform). Adds and configures dependency.
- Add `Procfile` (`web`, `worker` and `release` processes) and `Procfile.dev` (`web` and `worker` processes, although tailwind may also add a `css` process). Also includes `bin/dev` which runs `Procfile.dev` with `foreman`
- Compress (gzip) responses with `Rack::Deflater` in production.
- Add `staging` environment (copy from `production`)
- Changes default `from` (i.e. sender) in `ApplicationMailer`
- Allows adding I18n available and default locales (from [svenfuchs/rails-i18n](https://github.com/svenfuchs/rails-i18n/tree/master))

## Test, CI features

- **[`brakeman`](https://github.com/presidentbeef/brakeman)**: Find security vulnerabilities in your app (added to GH workflow)
- **[`bundler-audit`](https://github.com/rubysec/bundler-audit)**: Find vulnerable dependencies (added to GH workflow)
- **[`rubycritic`](https://github.com/whitesmith/rubycritic)**: Enforce a good quality codebase (added to GH workflow)
- **[`factory_bot_rails`](https://github.com/thoughtbot/factory_bot_rails)**: Simplifies record building/creating in tests
- **[`rspec-sidekiq`](https://github.com/wspurgin/rspec-sidekiq)**: For Sidekiq testing.
- **[`shoulda-matchers`](https://github.com/thoughtbot/shoulda-matchers)**: Simplifies common tests
- **[`rspec-rails`](https://github.com/rspec/rspec-rails)**: For tests. Includes, initializes the dependency (without AR fixtures, with transactional fixtures). Integrates with `factory_bot_rails`, `rspec-sidekiq` and `shoulda-matchers`
- **[`rubocop-rails`](https://github.com/rubocop/rubocop-rails)**: Adds and configures this dependency, along with extensions `rubocop-performance`, `rubocop-rspec`, `rubocop-factory_bot`
- Github:
  - Add Dependabot configuration: `.github/dependabot.yml` configures weekly updates, groups development dependencies (i.e. the ones in `development` and `test` groups) and sentry gems
  - Add PR template
  - Workflows:
    - `test`: Runs test suite with `rspec`
    - `code_analysis`: Runs `bundle-audit`, `rubocop`, `brakeman`, `rubycritic`

# TODO

## Tools

- [ ] TBD Devise
- [ ] Tailwind, flowbite?

## Configuration

- [ ] TBD Dockerfile config
- [ ] TBD Heroku
- [ ] Hosts
- TBD README
