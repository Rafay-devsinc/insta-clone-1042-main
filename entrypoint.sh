#!/bin/bash
set -e


/usr/bin/wait-for-it.sh db:5432 --timeout=30 --strict --


rm -f /app/tmp/pids/server.pid


bundle exec rails db:create
bundle exec rails db:migrate


exec "$@"
