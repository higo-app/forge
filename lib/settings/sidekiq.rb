# frozen_string_literal: true

# 1. Adds sidekiq gem
# 2. Add config (config/sidekiq.yml with concurrency and queues)
# 3. Add sidekiq web (draw routes, add basic auth)

gem 'sidekiq'

file 'config/sidekiq.yml', <<~CONFIG
  ---
  :concurrency: <%= ENV.fetch('RAILS_MAX_THREADS', 5) %>
  :queues:
    - [high_priority, 2000]
    - [medium_priority, 1000]
    - [default, 500]
    - [low_priority, 100]
CONFIG

initializer 'sidekiq.rb', <<~INITIALIZER
  # frozen_string_literal: true

  redis_config = Rails.application.config_for('redis/shared')

  Sidekiq.configure_server do |config|
    config.redis = redis_config
  end

  Sidekiq.logger.level = Logger::WARN if Rails.env.test?

  Sidekiq.configure_client do |config|
    config.redis = redis_config
  end
INITIALIZER

initializer 'sidekiq_web.rb', <<~INITIALIZER
  # frozen_string_literal: true

  # Adds HTTP Basic Auth to Sidekiq Web in production (see encrypted credentials).

  require 'sidekiq/web'

  return if Rails.env.local?

  creds = Rails.application.credentials.fetch(:sidekiq_web, {})

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(
      Digest::SHA256.hexdigest(username),
      Digest::SHA256.hexdigest(creds.fetch(:user, ''))
    ) & ActiveSupport::SecurityUtils.secure_compare(
      Digest::SHA256.hexdigest(password),
      Digest::SHA256.hexdigest(creds.fetch(:password, ''))
    )
  end
INITIALIZER

file 'config/routes/sidekiq_web.rb', <<~ROUTES
  # frozen_string_literal: true

  require 'sidekiq/web'

  scope(Rails.application.credentials.fetch(:sidekiq_web, {})[:prefix].presence || '') do
    mount Sidekiq::Web => '/sidekiq'
  end
ROUTES

route 'draw :sidekiq_web'

require 'securerandom'
puts <<~MESSAGE
  Sidekiq installed. Add the following to your encrypted credentials (e.g. `rails credentials:edit -e production`) to secure Sidekiq web:

  sidekiq_web:
    prefix: #{SecureRandom.hex(16)}
    user: #{SecureRandom.hex(16)}
    password: #{SecureRandom.hex(16)}


MESSAGE
