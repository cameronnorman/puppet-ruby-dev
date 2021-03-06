#!/bin/bash
echo "Enter your username, followed by [ENTER]:"
read name
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-common postgresql-9.5 libpq-dev
sudo -u postgres createuser $name -s
