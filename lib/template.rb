# frozen_string_literal: true

puts '--- Running Forge template ---'

def source_paths
  [__dir__]
end

apply 'settings/postgres.rb'
apply 'settings/brakeman.rb'
apply 'settings/bundler_audit.rb'
apply 'settings/rubycritic.rb'
apply 'settings/redis.rb'
apply 'settings/sidekiq.rb'
apply 'settings/factory_bot.rb'
apply 'settings/rspec_sidekiq.rb'
apply 'settings/shoulda_matchers.rb'
apply 'settings/rspec.rb'
apply 'settings/strong_migrations.rb'
apply 'settings/sentry.rb'
