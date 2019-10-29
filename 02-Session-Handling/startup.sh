#!/bin/bash

set -x -v

npm --version
npm install -g yarn
yarn --version
yarn install --check-files

bundle install
# RAILS_ENV=development bundle exec rake db:migrate
RAILS_ENV=development bundle exec rake routes
RAILS_ENV=development bundle exec rails server -b "0.0.0.0" -p 3002

set +x +v
