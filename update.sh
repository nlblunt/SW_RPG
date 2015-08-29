#!/bin/bash
clear
echo "Updating working files"
git pull origin master

echo "Checking Gemfile"
bundle install

echo "Checking DB Migrations"
rake db:migrate

echo "Rebuilding assets"
rake assets:clobber
rake assets:precompile

echo "Updating completed"

echo "Restarting Passenger"
touch /tmp/restart.txt