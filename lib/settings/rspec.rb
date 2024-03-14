# frozen_string_literal: true

gem_group :development, :test do
  gem 'rspec-rails'
end
Bundler.with_unbundled_env { run 'bundle install' }
generate 'rspec:install'

# Keep a simpler rails_helper.rb file that also includes FactoryBot, Shoulda Matchers and RSpec Sidekiq config.
remove_file 'spec/rails_helper.rb'
create_file 'spec/rails_helper.rb' do
  <<~RB
    # frozen_string_literal: true

    require 'spec_helper'

    ENV['RAILS_ENV'] ||= 'test'

    require_relative '../config/environment'

    # Prevent database truncation if the environment is production
    abort('The Rails environment is running in production mode!') if Rails.env.production?

    require 'rspec/rails'

    begin
      ActiveRecord::Migration.maintain_test_schema!
    rescue ActiveRecord::PendingMigrationError => e
      abort e.to_s.strip
    end

    RSpec.configure do |config|
      config.use_transactional_fixtures = true
      config.infer_spec_type_from_file_location!
      config.filter_rails_from_backtrace!

      config.include FactoryBot::Syntax::Methods
      config.include ActiveSupport::Testing::TimeHelpers

      # Discard files created during tests
      config.after(:suite) do
        if (service = ActiveStorage::Blob.service)&.name == :test
          FileUtils.rm_rf(service.root)
        end
      end
    end

    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end

    # Do not warn when jobs are not processed by Sidekiq
    RSpec::Sidekiq.configure do |config|
      config.warn_when_jobs_not_processed_by_sidekiq = false
    end
  RB
end
