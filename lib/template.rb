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
