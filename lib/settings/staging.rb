# frozen_string_literal: true

run 'cp config/environments/production.rb config/environments/staging.rb'
gsub_file 'config/environments/staging.rb', 'production', 'staging'
