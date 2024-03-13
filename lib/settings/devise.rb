# frozen_string_literal: true

# 1. Adds devise and runs the generator (configuration)

gem 'devise'
rails_command 'generate devise:install'

# 2. Configure mailer
comment_lines 'config/initializers/devise.rb', /config.mailer_sender/
inject_into_file 'config/initializers/devise.rb', after: /# config.parent_mailer.+/ do
  <<-RUBY

  config.parent_mailer = 'ApplicationMailer'
  RUBY
end

# 3. Increase min password length from 6 to 8 characters
comment_lines 'config/initializers/devise.rb', /config.password_length/
inject_into_file 'config/initializers/devise.rb', after: /# config.password_length.+/ do
  <<-RUBY

  config.password_length = 8..128
  RUBY
end

# 4. Change email regexp
comment_lines 'config/initializers/devise.rb', /config.email_regexp/
inject_into_file 'config/initializers/devise.rb', after: /# config.email_regexp.+/ do
  <<-RUBY

  config.email_regexp = URI::MailTo::EMAIL_REGEXP
  RUBY
end

# 5. Add flash messages if needed
if yes?('Do you want to add flash messages to the application layour? (y/N)')
  inject_into_file 'app/views/layouts/application.html.erb', after: /<body>/ do
    <<-ERB

    <%# TODO: Find an _aesthetic_ ✨ way to display these flashes. They are at least used by Devise %>
    <p class="notice"><%= notice %></p>
    <p class="alert"><%= alert %></p>
    ERB
  end
end

# 6. Add a static page for the root path if needed
if yes?('Do you want to add a static page for the root path? (y/N)')
  generate(:controller, 'pages', 'home', '--skip-routes', '--no-helper', '--no-assets')
  route "root to: 'pages#home'"
end

# 7. Add available locales
require 'open-uri'

until (locale = ask('If you want to add the Devise translations for a locale, enter its key (e.g. en, es, fr)')).blank?
  key = ask("What is the key of the locale in https://github.com/tigrish/devise-i18n? (default: #{locale})")
  key = locale if key.blank?

  url = "https://raw.githubusercontent.com/tigrish/devise-i18n/master/rails/locales/#{key}.yml"
  begin
    contents = URI.open(url).read.gsub(/^#{key}/, locale) # rubocop:disable Security/Open
    file "config/locales/devise.#{locale}.yml", contents
  rescue StandardError => e
    puts e.message
    puts("Could not download the file from #{url}")
  end
end
