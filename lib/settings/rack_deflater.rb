# frozen_string_literal: true

inject_into_file 'config/environments/production.rb', <<-RUBY, before: /^end/

  # Use Rack::Deflater to gzip responses
  config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
RUBY
