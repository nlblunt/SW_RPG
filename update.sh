#!/bin/bash
clear
echo "Updating working files"
git pull origin master

echo "Rebuilding assets"
rake assets:clobber
rake assets:precompile

echo "Updating completed"

echo "Restarting Passenger"
touch /tmp/restart.txt