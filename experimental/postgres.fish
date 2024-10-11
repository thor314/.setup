#!/usr/bin/env fish

# POSTGRES SETUP
# https://github.com/diesel-rs/diesel/blob/master/.github/workflows/ci.yml#L65
sudo apt-get install postgresql postgresql-contrib libpq-dev -y # dependencies for diesel-cli
# set up the postgres user to allow all user/password combinations
echo "host    all             all             127.0.0.1/32            md5" | sudo tee -a /etc/postgresql/14/main/pg_hba.conf > /dev/null
sudo service postgresql restart && sleep 3
# change dirs -- avoids logging system errors "cannot change directory..." Permission denied -- these don't matter but are annoying
pushd /tmp 
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';" 
popd

sudo service postgresql restart && sleep 3 

# test running postgres commands as user "postgres"
sudo -u postgres psql 
# try listing db's for instance: \l
