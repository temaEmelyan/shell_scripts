#!/bin/bash


#edit sources
echo "deb cdrom:[Ubuntu 18.04 LTS _Bionic Beaver_ - Release amd64 (20180426)]/ bionic main restricted" | sudo tee /etc/apt/sources.list
echo "deb http://au.archive.ubuntu.com/ubuntu/ bionic main restricted universe" | sudo tee -a /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu/ bionic-security main restricted universe" | sudo tee -a /etc/apt/sources.list
echo "deb http://au.archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe" | sudo tee -a /etc/apt/sources.list
sudo apt update


#install git
echo "installing git"
yes | sudo apt install git
git config --global user.email "tema.emelyan@gmail.com"
git config --global user.name "Artyom Emelyanenko"


#clone the repo
echo "clone chat 4 10 repo"
git clone https://bitbucket.org/thoughtastronaut/nkk-platform ~/Documents/git/chatfor10


#install java
echo "installing java"
yes | sudo apt install openjdk-8-jdk


#install postgresql-10
echo "installing postgres"
sudo touch /etc/apt/sources.list.d/pgdg.list
echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
yes | sudo apt-get install postgresql-10


#config postgres
echo "configuring postgres"
echo "set up postgres password and leave psql console"
sudo -u postgres psql

sudo sed -i 's/peer/md5/g' /etc/postgresql/10/main/pg_hba.conf
sudo service postgresql restart

sudo -u postgres PGPASSWORD=password psql postgres -c "create role \"user\" with superuser createdb createrole login password 'password';"
sudo -u postgres PGPASSWORD=password psql postgres -c "create database chat_for_10;"
sudo -u postgres PGPASSWORD=password psql postgres -c "create database chat_for_10_test;"


#install pgadmin
echo "installing pgadmin"
yes | sudo apt-get install python-virtualenv python3-pip libpq-dev python3-dev
cd
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
deactivate
touch ~/pgadmin4/pgadmin4
chmod +x ~/pgadmin4/pgadmin4
cat > ~/pgadmin4/pgadmin4 <<'endmsg'
#!/bin/bash
cd ~/pgadmin4
source bin/activate
python3 lib/python3.6/site-packages/pgadmin4/pgAdmin4.py
endmsg


#install tweaks
sudo apt install gnome-tweaks


#upgrade packages
yes | sudo apt upgrade


#installing java sources
yes | sudo apt install openjdk-8-source


#chrome
sudo apt install gdebi-core
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
yes | sudo gdebi google-chrome-stable_current_amd64.deb

