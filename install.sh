#!/bin/bash

BASE_DIR="/var/local/bionic-kernel"

if [[ $(id -u) != "0" ]]; then
    >&2 echo "This script must be run as root."
    exit 1
fi

# Add the bionic sources list
echo "deb [arch=amd64] http://security.ubuntu.com/ubuntu bionic-security main" > /etc/apt/sources.list.d/bionic.list

# Copy over the preferences file
cp bionic.prefs /etc/apt/preferences.d/bionic

# Copy the daily cronjob
cp bionic-kernel.cron /etc/cron.daily/bionic-kernel

# Add the Ubuntu key
if ! apt-key adv --list-keys 3B4FE6ACC0B21F32 > /dev/null 2>&1; then
    apt-key adv --recv-key 3B4FE6ACC0B21F32
fi

# Update packages
apt update

# Install some needed packages
apt install -y dpkg-dev equivs

mkdir -p ${BASE_DIR}

# Create a gpg key for signing the package repo
if [[ ! -d ${BASE_DIR}/.gnupg ]]; then
    gpg --full-generate-key --homedir ${BASE_DIR}/.gnupg --batch gpg-gen-key
    gpg --homedir ${BASE_DIR}/.gnupg --armor --export root@localhost | apt-key add -
fi
