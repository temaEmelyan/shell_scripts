#!/bin/bash

wget http://www.scootersoftware.com/bcompare-4.2.4.22795_amd64.deb
sudo apt-get update
sudo apt-get install gdebi-core
sudo gdebi bcompare-4.2.4.22795_amd64.deb
