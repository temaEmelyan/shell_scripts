#!/bin/bash
sudo sed -i 's/peer/md5/g' /etc/postgresql/10/main/pg_hba.conf
sudo service postgresql restart
