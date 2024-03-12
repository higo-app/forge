# frozen_string_literal: true

gem_group :development, :test do
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

file '.rubocop.yml', <<~YAML
  require:
    - rubocop-factory_bot
    - rubocop-performance
    - rubocop-rails
    - rubocop-rspec

  AllCops:
    NewCops: enable
    Exclude:
      - "bin/**/*"
      - "db/schema.rb"
      - "vendor/**/*"

  Style/Documentation:
    Enabled: false

  Rails/UnknownEnv:
    Environments:
      - production
      - development
      - test
      - staging
      - local # development or test
YAML

if yes?('RuboCop installed. Would you like to run RuboCop now? (y/N)')
  if yes?('Would you like RuboCop to autocorrect offenses now? (y/N)')
    run 'bundle exec rubocop -A'
  else
    run 'bundle exec rubocop'
  end
end
