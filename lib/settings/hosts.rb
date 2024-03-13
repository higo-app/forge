# frozen_string_literal: true

test_host = ask('What is the test domain? (default: example.com)').presence || 'example.com'

development_host = ask('What is the development domain? (default: localhost)').presence || 'localhost'
development_port = ask('What is the development port? (default: 3000)').presence&.to_i || 3000

staging_host = ask('What is the staging domain? (default: staging.example.com)').presence || 'staging.example.com'

production_host = ask('What is the production domain? (default: example.com)').presence || 'example.com'

file 'config/default_url_options.yml', <<~YAML
  test:
    host: #{test_host}

  development:
    host: #{development_host}
    port: #{development_port}

  staging:
    host: #{staging_host}

  production:
    host: #{production_host}
YAML

initializer 'default_url_options.rb', <<~RUBY
  # frozen_string_literal: true

  # Serves as a centralized way to set options needed to build (full) URLs
  default_url_options = Rails.application.config_for(:default_url_options)

  Rails.application.routes.default_url_options = default_url_options
  Rails.application.config.action_mailer.default_url_options = default_url_options
RUBY

inject_into_file 'config/environments/development.rb', <<-RUBY, before: /^end/

  config.hosts = ['#{development_host}', '.#{development_host}']
RUBY

inject_into_file 'config/environments/staging.rb', <<-RUBY, before: /^end/

  config.hosts = ['#{staging_host}', '.#{staging_host}']
RUBY

inject_into_file 'config/environments/production.rb', <<-RUBY, before: /^end/

  config.hosts = ['#{production_host}', '.#{production_host}']
RUBY
