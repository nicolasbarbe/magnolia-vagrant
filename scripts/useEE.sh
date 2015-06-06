#!/usr/bin/env bash

read -s -p 'Please enter your master Maven password (password used to encrypt the nexus password): ' MASTPASS && \
echo "<settingsSecurity><master>`mvn --encrypt-master-password $MASTPASS`</master></settingsSecurity>" > ~/.m2/settings-security.xml \
  
unset MASTPASS

printf 'Now enter your nexus credentials:\n'

mvn org.sonatype.plugins:nexus-m2settings-maven-plugin:1.6.5:download \
 -DnexusUrl=https://nexus.magnolia-cms.com \
 -DtemplateId=magnolia-enterprise