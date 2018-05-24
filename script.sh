#!/bin/bash
sudo sed -i 's_/archive.ubuntu_/au.archive.ubuntu_g' /etc/apt/sources.list

sudo apt update
yes | sudo apt upgrade

sudo apt install git

sudo touch /etc/apt/sources.list.d/pgdg.list
echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update

yes | sudo apt-get install postgresql-10

sudo sed -i 's/peer/md5/g' /etc/postgresql/10/main/pg_hba.conf
sudo service postgresql restart

yes | sudo apt-get install python-virtualenv python3-pip libpq-dev python3-dev

cd ~
virtualenv -p python3 pgadmin4
cd pgadmin4
source bin/activate

yes | pip3 install https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v3.0/pip/pgadmin4-3.0-py2.py3-none-any.whl


cat > lib/python3.6/site-packages/pgadmin4/config_local.py <<'endmsg'
import os
DATA_DIR = os.path.realpath(os.path.expanduser(u'~/.pgadmin/'))
LOG_FILE = os.path.join(DATA_DIR, 'pgadmin4.log')
SQLITE_PATH = os.path.join(DATA_DIR, 'pgadmin4.db')
SESSION_DB_PATH = os.path.join(DATA_DIR, 'sessions')
STORAGE_DIR = os.path.join(DATA_DIR, 'storage')
SERVER_MODE = False
endmsg


