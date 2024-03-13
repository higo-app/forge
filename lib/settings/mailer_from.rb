# frozen_string_literal: true

name = ask("What is the default sender name for your application? (default: #{app_name})")
name = app_name if name.blank?

default_email = 'sender@example.com'
email = ask("What is the default sender email for your application? (default: #{default_email})")
email = default_email if email.blank?

gsub_file 'app/mailers/application_mailer.rb', /from: '.*'/, "from: '#{name} <#{email}>'"
