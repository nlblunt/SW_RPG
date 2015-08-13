#!/bin/bash
clear
echo "Updating working files"
git pull origin master

echo "Rebuilding assets"
rake assets:clobber
rake assets:precompile

echo "Updating completed"
sudo /etc/init.d/apache2 restart
echo "Apache restarted"