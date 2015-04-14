#!/usr/bin/env bash

printf "Updating the package definition ..."

# Update the package definition
apt-get update > /dev/null 

printf "Installing development tools ..."

# Install development tools
apt-get install -y default-jre default-jdk maven git-core bash-completion subversion wget curl > /dev/null 

printf "Installing Docker ..."

# Install docker
wget -qO- https://get.docker.com/ | sh  >> /dev/null 2>&1 

# Install docker compose
curl -s -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose 
chmod +x /usr/local/bin/docker-compose
curl -s -L https://raw.githubusercontent.com/docker/compose/1.1.0/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose 

printf "Configuring the development environment ..."

# Set the locale
locale-gen UTF-8

# Modify motd
chmod -x /etc/update-motd.d/*
cp /magnolia/config/00-magnolia /etc/update-motd.d/
chmod +x /etc/update-motd.d/00-magnolia

# Update /etc/environment
printf "Update some global environment variables"
echo 'JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64/"' | sudo tee -a /etc/environment
echo 'LC_ALL="en_US.UTF-8"' | sudo tee -a /etc/environment
echo 'ClientAliveInterval 60' | sudo tee -a /etc/ssh/sshd_config

printf "Cleaning ..."
apt-get autoclean > /dev/null 
apt-get clean > /dev/null 
