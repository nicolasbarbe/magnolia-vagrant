#!/usr/bin/env bash

# Assign docker group to current user
sudo usermod -aG docker $USER > /dev/null 

# Setup maven for Magnolia
mvn org.sonatype.plugins:nexus-m2settings-maven-plugin:1.6.5:download -DnexusUrl=https://nexus.magnolia-cms.com -Dusername=anonymous -Dpassword=anonymous -DtemplateId=magnolia-community-public > /dev/null 

# Clone quickstart project
if [ ! -d "/magnolia/projects/quickstart-project" ]; then
  printf "Cloning the quickstart project ..."
	git clone https://github.com/nicolasbarbe/quickstart-project.git  /magnolia/projects/quickstart-project > /dev/null 
fi