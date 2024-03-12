# frozen_string_literal: true

file '.github/dependabot.yml', <<~YAML
  version: 2
  updates:
    - package-ecosystem: bundler
      directory: '/'
      schedule:
        interval: weekly
        day: thursday
      open-pull-requests-limit: 15
      groups:
        deps-dev:
          dependency-type: development
        sentry:
          patterns:
            - 'sentry*'
YAML

file '.github/pull_request_template.md', <<~MD
  [Issue](https://linear.app/higo-tech/issue/<project_label-ticket_number>)

  ### Motivation

  ### Description

  ### Breaking changes (optional)

  ### Related PRs (optional)

  ### Related documentation (optional)
MD

file '.github/workflows/test.yml', <<~YAML
  name: main

  on: [push]

  jobs:
    test:
      runs-on: ubuntu-latest

      services:
        postgres:
          image: postgres:14
          env:
            POSTGRES_USER: postgres
            POSTGRES_PASSWORD: postgres
            POSTGRES_DB: postgres
          ports:
            - 5432:5432
          # needed because the postgres container does not provide a healthcheck
          # tmpfs makes DB faster by using RAM
          options: >-
            --mount type=tmpfs,destination=/var/lib/postgresql/data
            --health-cmd pg_isready
            --health-interval 10s
            --health-timeout 5s
            --health-retries 5
      env:
        RAILS_ENV: test
        GEMFILE_RUBY_VERSION: #{RUBY_VERSION}
        PGHOST: localhost
        PGUSER: postgres
        PGPASSWORD: postgres
        RAILS_MASTER_KEY: ${{ secrets.RAILS_MASTER_KEY }}

      steps:
        - name: Checkout
          uses: actions/checkout@v3

        - name: Set up Ruby
          uses: ruby/setup-ruby@v1
          with:
            # runs 'bundle install' and caches installed gems automatically
            bundler-cache: true

        - name: Create DB
          run: |
            bin/rails db:create db:schema:load

        - name: Run tests
          run: |
            bundle exec rspec
YAML

file '.github/workflows/code_analysis.yml', <<~YAML
  name: main

  on: [push]

  jobs:
    code-analysis:
      runs-on: ubuntu-latest

      env:
        RAILS_ENV: test
        GEMFILE_RUBY_VERSION: #{RUBY_VERSION}

      steps:
        - name: Checkout
          uses: actions/checkout@v3

        - name: Set up Ruby
          uses: ruby/setup-ruby@v1
          with:
            # runs 'bundle install' and caches installed gems automatically
            bundler-cache: true

        - name: Bundle audit
          run: bundle exec bundle-audit check --update

        - name: Lint (Rubocop)
          run: bundle exec rubocop

        - name: Brakeman (vulnerabilities)
          run: bundle exec brakeman

        - name: Rubycritic
          run: bundle exec rubycritic app -f console -s 90
YAML

puts '--- Remember to add `RAILS_MASTER_KEY` as a repo secret in Github for the test workflow action ---'
