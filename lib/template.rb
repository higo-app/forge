# frozen_string_literal: true

puts '--- Running Forge template ---'

base_url = ENV.fetch('BASE_URL', 'https://raw.githubusercontent.com/higo-app/forge/main/lib/')

apply "#{base_url}settings/postgres.rb"
apply "#{base_url}settings/brakeman.rb"
apply "#{base_url}settings/bundler_audit.rb"
apply "#{base_url}settings/rubycritic.rb"
apply "#{base_url}settings/redis.rb"
apply "#{base_url}settings/sidekiq.rb"
apply "#{base_url}settings/factory_bot.rb"
apply "#{base_url}settings/rspec_sidekiq.rb"
apply "#{base_url}settings/shoulda_matchers.rb"
apply "#{base_url}settings/rspec.rb"
apply "#{base_url}settings/strong_migrations.rb"
apply "#{base_url}settings/sentry.rb"
apply "#{base_url}settings/segment.rb"
apply "#{base_url}settings/procfiles.rb"
apply "#{base_url}settings/rack_deflater.rb"
apply "#{base_url}settings/github.rb"
apply "#{base_url}settings/staging.rb"
apply "#{base_url}settings/mailer_from.rb"
apply "#{base_url}settings/i18n.rb"
apply "#{base_url}settings/hosts.rb"
apply "#{base_url}settings/devise.rb" if yes?('Add and configure Devise? (y/N)')
if yes?('Add and configure Tailwind CSS? Do not add it if you have already passed `--css tailwind`. (y/N)')
  apply "#{base_url}settings/tailwind.rb"
end
apply "#{base_url}settings/readme.rb"
apply "#{base_url}settings/rubocop.rb"
