# frozen_string_literal: true

puts '--- Running Forge template ---'

def source_paths
  [__dir__]
end

apply 'settings/postgres.rb'
