# frozen_string_literal: true

gem 'sentry-ruby'
gem 'sentry-rails'
gem 'sentry-sidekiq'

initializer 'sentry.rb', <<~RB
  # frozen_string_literal: true

  Sentry.init do |config|
    config.dsn = Rails.application.credentials.fetch(:sentry, {})[:dsn]

    config.breadcrumbs_logger = %i[active_support_logger http_logger]

    config.enabled_environments = %w[production staging]
  end
RB

puts '--- Sentry installed and enabled in production and staging. Add `sentry[:dsn]` to your credentials'
