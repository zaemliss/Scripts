#!/bin/bash

sudo apt-get update
sudo apt-get install --reinstall build-essential
sudo apt-get install --reinstall gcc
sudo dpkg-reconfigure build-essential
sudo dpkg-reconfigure gcc
