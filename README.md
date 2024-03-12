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

- **Postgres**: Configures a minimalistic `config/database.yml` and, optionally, configures UUID primary keys
- **Redis**: Adds a single `config/redis/shared.yml` configuration, to be used by ActionCable, Kredis, Sidekiq, etc.
- **Sidekiq**: Background jobs
- **Strong migrations**: Catches unsafe DB migrations

## Test, CI features

- **brakeman**: Find security vulnerabilities in your app (added to GH workflow)
- **bundler-audit**: Find vulnerable dependencies (added to GH workflow)
- **rubycritic**: Enforce a good quality codebase (added to GH workflow)
- **factory_bot_rails**: Simplifies record building/creating in tests
- **rspec-sidekiq**: For Sidekiq testing.
- **shoulda-matchers**: Simplifies common tests
- **rspec-rails**: For tests. Includes, initializes `rspec-rails` (without AR fixtures, with transactional fixtures). Integrates with `factory_bot_rails`, `rspec-sidekiq` and `shoulda-matchers`

# TODO

## Tools

- [ ] Rubocop (incl. extensions depending on other tools)
- [ ] Sentry
- [ ] Rack::Deflater?
- [ ] Segment
- [ ] Tailwind, flowbite?

## Configuration

- [ ] Git: Init repo, create a commit for every step?
- [ ] TBD: Procfiles, /bin/dev?
- [ ] Github: dependabot, workflows
- [ ] TBD: staging env
- [ ] Credentials
- [ ] AR encryption
- [ ] TBD Dockerfile config
- [ ] TBD Heroku
- [ ] I18n (es?)
- [ ] Mailer
- [ ] Hosts
- TBD README
