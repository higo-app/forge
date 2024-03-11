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
# In your app's root folder, for example if we only want to add Rubocop
bin/rails app:template LOCATION=https://raw.githubusercontent.com/higo-app/forge/main/lib/settings/rubocop.rb
```

# Features

## App features

- **Postgres**: Configures a minimalistic `config/database.yml` and, optionally, configures UUID primary keys
- **Redis**: Adds a single `config/redis/shared.yml` configuration, to be used by ActionCable, Kredis, Sidekiq, etc.

## Test, CI features

- **brakeman**: Find security vulnerabilities in your app (added to GH workflow)
- **bundler-audit**: Find vulnerable dependencies (added to GH workflow)
- **rubycritic**: Enforce a good quality codebase (added to GH workflow)

# TODO

## Tools

- [ ] Sidekiq
- [ ] RSpec (via rspec-rails, but we should also include rspec-sidekiq if Sidekiq is included)
- [ ] Rubocop (incl. extensions depending on other tools)
- [ ] Factory bot
- [ ] Shoulda matchers
- [ ] TBD Faraday
- [ ] Sentry
- [ ] Strong migrations
- [ ] Rack::Deflater?
- [ ] Segment
- [ ] Tailwind, flowbite?

## Configuration

- [ ] Git: Init repo, create a commit for every step?
- [ ] TBD: Asset pipeline
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
