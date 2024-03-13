# frozen_string_literal: true

gem 'tailwindcss-rails'
Bundler.with_unbundled_env { run 'bundle install' }
rails_command 'tailwindcss:install'
