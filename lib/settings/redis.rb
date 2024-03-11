# frozen_string_literal: true

# Assumes that `redis` is already installed. It adds shared a `config/redis/shared.yml` file

file 'config/redis/shared.yml', <<~CONFIG
  # If needed outside Kredis, these settings are available under `Rails.application.config_for('redis/shared')`
  shared:
    # Change the database number (5 below) as needed if you want to separate this database (namespace) from other
    # projects
    url: <%= ENV.fetch("REDIS_URL", "redis://127.0.0.1:6379/5") %>
    timeout: 1
    ssl_params:
      # Self signed SSL is needed for Heroku. See https://help.heroku.com/HC0F8CUS/redis-connection-issues
      verify_mode: <%= OpenSSL::SSL::VERIFY_NONE %>

  remote: &remote
    timeout: 5

  staging:
    <<: *remote

  production:
    <<: *remote
CONFIG
