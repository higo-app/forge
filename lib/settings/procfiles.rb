# frozen_string_literal: true

file 'Procfile.dev', <<~PROCFILE
  web: bundle exec rails server
  worker: bundle exec sidekiq
PROCFILE

file 'Procfile', <<~PROCFILE
  web: bundle exec rails server
  worker: bundle exec sidekiq
  release: bundle exec rails db:migrate
PROCFILE

file 'bin/dev', <<~SH
  #!/usr/bin/env sh

  if ! gem list foreman -i --silent; then
  echo "Installing foreman..."
  gem install foreman
  fi

  exec foreman start -f Procfile.dev "$@"
SH

chmod 'bin/dev', 0o755
