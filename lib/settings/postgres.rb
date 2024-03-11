# frozen_string_literal: true

# Assumes pg (not sqlite3) is already installed. Pass `-d postgresql -T` to the app initialization command to achieve
# this.
#
# 1. Adds a minimalist `config/database.yml` for Postgres
# 2. Optionally, sets up UUID primary keys:
#    - enables extension
#    - configures generator primary keys
#    - sorts AR records by `created_at` instead of `id`

remove_file 'config/database.yml'
create_file 'config/database.yml' do
  <<~CONFIG
    default: &default
      adapter: postgresql
      encoding: unicode
      pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

    development:
      <<: *default
      database: #{app_name}_development

    test:
      <<: *default
      database: #{app_name}_test

    production:
      <<: *default
      database: #{app_name}_production
  CONFIG
end

if yes?('Would you like to set up UUID primary keys? (y/n)')
  file "db/migrate/#{Time.new.utc.strftime('%y%m%d%H%M%S')}_enable_uuid.rb", <<~RB
    # frozen_string_literal: true

    class EnableUuid < ActiveRecord::Migration[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]
      extension = 'pgcrypto'

      def up
        enable_extension extension unless extension_enabled?(extension)
      end

      def down
        disable_extension extension if extension_enabled?(extension)
      end
    end
  RB
  puts 'Generated migration. Do not forget to run it with `rails db:migrate`'

  initializer 'generators.rb', <<-RB
  # frozen_string_literal: true

  Rails.application.config.generators do |g|
    g.orm :active_record, primary_key_type: :uuid
  end
  RB

  inject_into_file 'app/models/application_record.rb', "\n\n  self.implicit_order_column = :created_at",
                   after: 'primary_abstract_class'
end
