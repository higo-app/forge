# frozen_string_literal: true

gem 'strong_migrations'
Bundler.with_unbundled_env { run 'bundle install' }
generate 'strong_migrations:install'
