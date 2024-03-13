# frozen_string_literal: true

description = ask('What is the purpose (one-liner description) of this app?')

file 'README.md', <<~MARKDOWN
  # #{app_name}

  #{description}

  ### Dependencies

  - Ruby version: #{RUBY_VERSION}
  - System dependencies:
    - Postgres
    - Redis

  ### Initial setup

  1. Clone the repo
  1. Run `./bin/setup` which will install bundler and dependencies, and prepare the database.
  1. Run app: `./bin/dev`
  1. Run tests: `rspec`
MARKDOWN
