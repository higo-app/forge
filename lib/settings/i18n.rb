# frozen_string_literal: true

require 'open-uri'

added = []

until (locale = ask('If you want to add a new locale, enter its key (e.g. en, es, fr)')).blank?
  key = ask("What is the key of the locale in https://github.com/svenfuchs/rails-i18n? (default: #{locale})")
  key = locale if key.blank?

  url = "https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/#{key}.yml"
  begin
    file "config/locales/base.#{locale}.yml", URI.open(url).read.gsub(/^#{key}/, locale) # rubocop:disable Security/Open
    added << locale
  rescue StandardError => e
    puts e.message
    puts("Could not download the file from #{url}")
  end
end

return if added.empty?

inject_into_file 'config/application.rb', <<-RUBY, before: /^  end/

    I18n.available_locales = #{added.map(&:to_sym)}
RUBY

default = ask('Do you want to set a default locale? (e.g. en, es, fr)')
return if default.blank?

inject_into_file 'config/application.rb', <<-RUBY, before: /^  end/
    I18n.default_locale = :#{default}
RUBY
